#!/bin/bash

case "$1" in
'start')
DRIVER=`/sbin/ethtool -i wlan0 | grep driver | awk -F": " '{print $2}'`
ARCH=`/usr/bin/dpkg --print-architecture`

if [ $DRIVER = "rtl8192cu" -a $ARCH = "armhf" ] ; then
  echo "Launching Hostapd Edimax"
/usr/sbin/hostapd-edimax /etc/hostapd/hostapd-edimax.conf
else
  echo "Launching Ordinary Hostapd"
/usr/sbin/hostapd /etc/hostapd/hostapd.conf
fi
;;
'stop')

echo "Killing Hostapd"
/usr/bin/sudo /usr/bin/killall hostapd

echo "Killing Dhcpd"
/usr/bin/sudo /usr/bin/killall dhcpd
;;
esac
