Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC8E2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 20:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbdCAUb3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 15:31:29 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:52291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdCAUb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 15:31:26 -0500
Received: from [192.168.1.50] ([94.219.230.230]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LlMaV-1c8Bdb3kWd-00bLja; Wed, 01 Mar 2017 21:12:52 +0100
Subject: Re: git status --> Out of memory, realloc failed
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <84c02ca1-269e-2f26-c625-476d7f087f5c@cafu.de>
 <ea0722e2-c2bd-bd80-a233-50676efcafda@web.de>
From:   Carsten Fuchs <carsten.fuchs@cafu.de>
Message-ID: <cbd281fc-3a4b-b4dc-5dff-145c97cd68d6@cafu.de>
Date:   Wed, 1 Mar 2017 21:12:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <ea0722e2-c2bd-bd80-a233-50676efcafda@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:quYzU8/jKwjYraiHxtZDVcSXoFWqJbDeMgF8Xhc5H3OzGFi4Spf
 bU3D2lilGPW9MuBoHNhv8zXi1YKK69HeUo/h5BJMftQq9tfHvPVzM/cFenxk8D2kUMrgozM
 K0F2b2ocboaCAVEnnnMdm8qMEVN7fsKO+LQcSTolIiFYrujyYSg/h6mtdFoJSGPxmAuFeB4
 Aoo2C6h/RBi0Klw5qKFgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xa7GNNUZgdI=:HSSzMY8gyXqyD1VMWGZTyH
 giaufRhsSZXZ2IITDMPJTK0g9ILohDzT6G1AaxzTbIo0lb+12vzZ8ThBLf9jxIiWiKPjGlmv/
 oxYWPQ12ZMTmWXJvmu+IjJ74ML682sX/jaSLkWEbDlnAd3trDQEKGwVnL/bkVwKEpvLiHPFvD
 QR9Vxv1XSlCsIwyhiqxwTIo0V9Bl7uOmGliojQvDtfpEdFb4LurpLDQ9oBIoSyj3nLO8wSBS2
 sKJy4VuShAGJLMH1Wf1Yf3MC20t79+BWDkZWpCvnPhiT8c5++m1p3rSlUNbdEAOw3/blqlHOY
 hRFs4z2IYdpFihY8JOq2OVN2a1viRnioszsaN0erOIZRlLMS9sZ2k2x1WrLAEb17ApyZkk5Ks
 dmlTzX9jp3BmuNq8or/tCJHji4jhbhRkLNZoZDyKFHpGjGP9Q2WfPi10ol5zB2vdH72YU/gvP
 FHmQTb66ZJfPn18ISeyBSBYIGGCvytfJBUELoNLG2LHttzIrm6gbG6vn37UI7XwppWp1fU8o4
 cXknsgqSxlLfZQsODbW3mx/FKY03GKcc9CWtIwiJG5zIdDGC7bi71oMczJU33yXxYG8MDpdGD
 JCTnQIyaZ3cnXRh0G9wplAIdcM7ZclPdXeYzzStC+MGcSCATkP0OSi1rwEpIzQdY0mjg0Es1v
 rBbo1O2wb4KBhAaJ8Ksc/q73lUKxLVicjJJtAJQwFiInpQVScYzbgjrTLDxEWcF7wyH3xoZ8J
 wIuSK285hHwf/kZ9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

Am 01.03.2017 um 11:02 schrieb René Scharfe:
>> I use Git at a web hosting service, where my user account has a memory
>> limit of 768 MB:
>>
>> (uiserver):p7715773:~$ uname -a
>> Linux infongp-de15 3.14.0-ui16322-uiabi1-infong-amd64 #1 SMP Debian
>> 3.14.79-2~ui80+4 (2016-11-17) x86_64 GNU/Linux
>
> What's the output of "ulimit -a"?

(uiserver):p7715773:~$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 1
file size               (blocks, -f) unlimited
pending signals                 (-i) 16382
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 512
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) 1800
max user processes              (-u) 42
virtual memory          (kbytes, -v) 786432
file locks                      (-x) unlimited

>> (uiserver):p7715773:~$ git --version
>> git version 2.1.4
>
> That's quite old.  Can you try a more recent version easily (2.12.0 just came out)?

I don't think that they have any newer version available, having just upgraded from Git 
1.7 a couple of weeks ago... (1und1)

Git 1.7 used to work for me in the same environment, but iirc they also said they 
switched from 32-bit to 64-bit edition and blame the increased memory consumption on 
that change.

I'll ask for a newer version, but I'd be surprised if this happened.

>> The repository is tracking about 19000 files which together take 260 MB.
>> The git server version is 2.7.4.1.g5468f9e (Bitbucket)
>
> Is your repository publicly accessible?

Unfortunately, no. There are no big secrets in there, but just a couple of database 
details so that I cannot make it universally available. I can gladly give you access 
though. (E.g. by adding your public SSH key?)

Best regards,
Carsten
