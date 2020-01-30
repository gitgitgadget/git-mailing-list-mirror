Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B420C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758482083E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgA3XPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:15:00 -0500
Received: from mail-gateway-shared12.cyon.net ([194.126.200.65]:53084 "EHLO
        mail-gateway-shared12.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgA3XPA (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Jan 2020 18:15:00 -0500
X-Greylist: delayed 705 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2020 18:14:58 EST
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared12.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1ixIq6-0006yH-3r
        for git@vger.kernel.org; Fri, 31 Jan 2020 00:03:12 +0100
Received: from [10.20.10.231] (port=44756 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <dev+git@drbeat.li>)
        id 1ixIq4-00CheC-TS; Fri, 31 Jan 2020 00:03:08 +0100
Subject: Re: Facing error in git-imap-send while compiling Git
To:     Nirmal Khedkar <nirmalhk7@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
 <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com>
 <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet>
 <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001202232460.46@tvgsbejvaqbjf.bet>
 <CAFFaXsxLd8duDPTE1H-zJiYnTVSB3pHCfBV+08Y4jLvCWR9kNw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001212144560.46@tvgsbejvaqbjf.bet>
 <xmqqmuaf70xx.fsf@gitster-ct.c.googlers.com>
 <CAFFaXsxeyxkPwAYSs=TEzd8fsa5r9KpJ7q8PX0ehNJ1Wpai4fA@mail.gmail.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <ef341b26-a10f-9194-6c76-ae6ddfd7981a@drbeat.li>
Date:   Fri, 31 Jan 2020 00:03:08 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAFFaXsxeyxkPwAYSs=TEzd8fsa5r9KpJ7q8PX0ehNJ1Wpai4fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nirmal!

On 30.01.20 21:26, Nirmal Khedkar wrote:
> Hi All,
> I'll admit I'm quite perplexed with this OpenSSL problem that I'm
> facing. Here's what I've done along with their results:

... snipped ...

> Please let me know where am I going wrong. If there's any other system
> packages that I can download so that I can focus on other Git issues
> and this one simultaneously, please let me know. Here are my system
> specifications (let me know if you need anything more specific):
> ---
> OS: Ubuntu 18.04
> Linux Kernel: 5.3
> OpenSSL Version: 1.1.1d
> ---
> 
> Apologies for the long email,
> Thank You,

No problem!

My system is similar: Debian testing with the OpenSSL 1.1.1d from the
distribution. I have no build problems whatsoever. OpenSSL comes with
backward compatibility macros that most allow code written for 1.0.2 to
be compiled without errors. These macros can be turned off by changing
the API compatibility version using -DOPENSSL_API_COMPAT=<version>.

You can check this with

    make V=1 imap-send.o

This will show the compiler command executed:

    gcc -o imap-send.o -c -MF ./.depend/imap-send.o.d -MQ imap-send.o
-MMD -MP   -g -O2 -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\""
-DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND -DSHA1_DC
-DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0
-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\""
-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK
-pthread -DHAVE_PATHS_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY
-DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM
'-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"'  -DFREAD_READS_DIRECTORIES
-DNO_STRLCPY -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"'
imap-send.c

Check it for any -D flags mentioning OpenSSL.

You can get even more verbose output from gcc by copying the compiler
command make displays and running it after appending the verbose flag
"-v" at the end.

Check this new output for include directories etc. You need to make sure
that gcc picks up the system OpenSSL include files. They should be found
under /usr/include/openssl.


Hope this helps,

Beat Bolli
