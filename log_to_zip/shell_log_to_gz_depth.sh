# 1. create script
#   /home/USER/APP/logs -> shell_log_to_gz_depth.sh
#
#   vi shell_log_to_gz_depth.sh
#   chmod 755 shell_log_to_gz_depth.sh
#
# 2. set to 'crontab'
#   crontab -e
#   0 1 * * * /home/USER/APP/logs/shell_log_to_gz_depth.sh /home/USER/APP/logs/PROJECT/


#!/bin/bash
INPUT_PATH=$1
if [ -z "$INPUT_PATH" ];then
        echo "failed : you sholud input path"
        exit 1
fi
echo "========================="
echo "input path : " $INPUT_PATH
if [ ! -d "$INPUT_PATH" ]; then
        echo "failed : $INPUT_PATH is not directory"
        exit 1
fi
echo "convert log to gz start"
echo "========================="
TO_DAY=$(date +"%Y%m%d")
echo "today is "${TO_DAY}
echo "========================="
for log in $INPUT_PATH*/*.log
do
        echo "========================="
        log_name=${log: -12:8}
        if [ $log_name -lt ${TO_DAY} ]; then
                gzip ${log} &\
                echo "${log} converted"
                echo "========================="
        else
                echo "${log} is failed to convert"
        fi
done