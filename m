Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6474D1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbcIIQ0Z convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 9 Sep 2016 12:26:25 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.11]:50696 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751463AbcIIQ0Y (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Sep 2016 12:26:24 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Sep 2016 12:26:24 EDT
Received: from [216.82.249.211] by server-11.bemta-12.messagelabs.com id A6/72-28088-F11E2D75; Fri, 09 Sep 2016 16:19:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRWlGSWpSXmKPExsVS+YHdVlf+4aV
  wg96rLBZdV7qZHBg9Pm+SC2CMYs3MS8qvSGDNODv3MWNBN3NF/6VXrA2MR5i6GDk5hAS2Mkr0
  NOiA2BICuhIftnxihYg/YZRofiPRxcgFZN9glGhpOMcIkhAREJd4e3wmexcjBwebgLvE2RWxI
  GFhAU2JnZNbWUBsXgE7iWvdS8BKWARUJDadUgMJiwrESOyf1c4KUSIocXLmE7ByZgEziXmbHz
  JD2NoSyxa+Zp7AyDsLSdksJGWzkJQtYGRexahenFpUllqka6KXVJSZnlGSm5iZo2toaKSXm1p
  cnJiempOYVKyXnJ+7iREYTgxAsINx1ULnQ4ySHExKoryb9l4KF+JLyk+pzEgszogvKs1JLT7E
  KMPBoSTBq/8AKCdYlJqeWpGWmQMMbJi0BAePkgjv1/tAad7igsTc4sx0iNQpRl2OBT9ur2USY
  snLz0uVEud9AVIkAFKUUZoHNwIWZZcYZaWEeRmBjhLiKUgtys0sQZV/xSjOwagkzCsAcglPZl
  4J3KZXQEcwAR0hdOo8yBEliQgpqQZGwfRfV//uNmUVFdphK7/u9B22C6typ/I2x+8tYPzzWiI
  84NKNxEWnwpfIzXw079oxFYFKh/nNqxYXn2xNZ/r8wvmMVGP5IyfZJw7OPNmeDS/vi2pH+Mb+
  83U7cXP6ysuKv6P2cU2STDu1a4Gb7c33xX+XrbteIBiwl33J3EUmhxX6FX7Z9pyqU2Ipzkg01
  GIuKk4EAHh9wrOtAgAA
X-Env-Sender: sergio.martin@accelya.com
X-Msg-Ref: server-10.tower-53.messagelabs.com!1473437981!15064619!1
X-Originating-IP: [121.240.7.61]
X-StarScan-Received: 
X-StarScan-Version: 8.84; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 51802 invoked from network); 9 Sep 2016 16:19:42 -0000
Received: from bkc61.logix.in (HELO accelya-ldmtp.logix.local) (121.240.7.61)
  by server-10.tower-53.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 9 Sep 2016 16:19:42 -0000
Received: from localhost (localhost [127.0.0.1])
        by accelya-ldmtp.logix.local (Postfix) with ESMTP id AA6B350E1420
        for <git@vger.kernel.org>; Fri,  9 Sep 2016 21:49:40 +0530 (IST)
X-Virus-Scanned: amavisd-new at accelya.local
Received: from accelya-ldmtp.logix.local ([127.0.0.1])
        by localhost (accelya-ldmtp.logix.local [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ohNuVFHgeqFl for <git@vger.kernel.org>;
        Fri,  9 Sep 2016 21:49:40 +0530 (IST)
Received: from [10.124.8.144] (107.pool85-59-34.dynamic.orange.es [85.59.34.107])
        by accelya-ldmtp.logix.local (Postfix) with ESMTPSA id 4546450E04E5
        for <git@vger.kernel.org>; Fri,  9 Sep 2016 21:49:40 +0530 (IST)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Sergio_Mart=c3=adn_Turiel?= <sergio.martin@accelya.com>
Subject: Missing RPM spec file in tarball
Message-ID: <4c42a1f4-4f03-0fdf-8bd2-8a7f1f978073@accelya.com>
Date:   Fri, 9 Sep 2016 18:19:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,


  I am trying to build RPM packages from tarball (release 2.9.3 and 
2.10.0), and i do not find git.spec file, in previous releases i can 
found it (e.g. 2.8.3).

O.S.: CentOS 7.2
Command: rpmbuild -ta git-2.9.3.tar.gz
Response: error: Failed to read spec file from git-2.9.3.tar.gz

Can you tell me what I'm doing wrong?


Thank you very much and best regards, Sergio Martín.
