#!/bin/bash

## Prints a JSON array of port numbers all used by mysqld instances.

#get ports for centos 6
#res=`sudo /bin/netstat -lntp | awk '/mysqld/{print $4}' | sed "s/://g"`
#for centos 7
res=`sudo /bin/netstat -lntp | awk -F "[ :]+" '/mysqld/ {print $5}'`

port=($res)

printf '{\n'

printf '\t\"data\":[\n\n'

for key in ${!port[@]}

do

	if [[ "${#port[@]}" -gt 1 && "${key}" -ne "$((${#port[@]}-1))" ]];then

		printf '\t{\n'

		printf "\t\t\"{#MYSQLPORT}\":\"${port[${key}]}\"},\n"

	else [[ "${key}" -eq "((${#port[@]}-1))" ]]

		printf '\t{\n'

		printf "\t\t\"{#MYSQLPORT}\":\"${port[${key}]}\"}\n"

	fi

done

printf '\n\t]\n'

printf '}\n'
