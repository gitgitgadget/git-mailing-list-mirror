Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35941F5FB
	for <e@80x24.org>; Wed,  1 Mar 2017 10:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbdCAKEA (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 05:04:00 -0500
Received: from mout.web.de ([212.227.15.14]:64598 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbdCAKDr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 05:03:47 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNL6f-1ch4Dv2z97-006woV; Wed, 01
 Mar 2017 11:02:54 +0100
Subject: Re: git status --> Out of memory, realloc failed
To:     Carsten Fuchs <carsten.fuchs@cafu.de>, git@vger.kernel.org
References: <84c02ca1-269e-2f26-c625-476d7f087f5c@cafu.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ea0722e2-c2bd-bd80-a233-50676efcafda@web.de>
Date:   Wed, 1 Mar 2017 11:02:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <84c02ca1-269e-2f26-c625-476d7f087f5c@cafu.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9EghMv8vrfYoQxFZHeNxiQM8NAN6FwgUSwywCRyJczUSvyjSkbj
 +Im55CYtmnDdWjXwJqNPrjh1cVpG4aB9M1y7ScGNaVJgVK0FXN2amCBcCt0wMQROwduIU+w
 smbOJfPvD7flYNPU4MtPjJJq+c+SJ8ix4E0lnUpkRZ7DpdBrEZKLT/Psyssripe+QfzIpXV
 AllOBX/qBhbL6Y9XwkfkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pImy1CyPAzk=:2Iko9JQeMQw/s6sjHCPmb8
 geHSoxIzTye8LNgqitEz/C476s0TsIH6jhobQWBoNeoEkvo3y4AG1lNUTDrfybTY13055hZSN
 Nl3DsHM4eeCxdwVnjHuKLKntbh9xQF472dpy2bMcmIjat6tpOKknp0iOYm1W5/UgGNJTjPTqk
 4HWhvIeTGADn4TSVF55RAHPnQiMXKR1E8a4k6L7KWuaD3e4EhgZ8AXVz1ES408aGn/lPjo3qM
 u5XwsDWKfPhJPZ93fxOxhf3wBZHX248hdhytbJ1DY038/p6MuLTV0obhoYO9fw4Zt+47B7pSn
 /Ui/VM2rXHS2R/kx/6F4vmXhLGZNnQ8aXT0VPgkrZMl4+z/ZLS8MYiIXQDLKlQoznT4rRmTxy
 tBywF9AokfuVGcedsoWJEycFZYPW3KQn0/wzXe45FYGrfahQg2JaaCYa88cJwCL0l5f5dTbxr
 i22qzCNsT6gWACEhHQBfVg9aUOZ3dDwzmIONy7iUozQc8/xISxBdHi8dPrRw8GQropVLJaSlI
 NwhPOuzklpG1Jou1eenUExb3KqRbu2K5sX02cjMq6npom8qAdFwP6y6L8RzmTTMLLNl8AplEp
 cG6BJ9ZhBqigUS71o5jBS5kIDnuDW82frgR50fWlrFGTgIOhLhG/1kWi/mlRaFINq+Gamig9I
 dp91dgiw6x9KVUl4b87sFwgbGbMKpf/A4LePIvKmjmQY0F6+paHAqi4s4lPGqkyOjJNQWdp2f
 3NXYBsR5QAy+lMZBPZovXpKIkSxj4Ehlj/Ks6yQoiLZ731wMsa0Sj8D+3XoUuA/772VZkxib2
 Tu0R5Tu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.02.2017 um 11:13 schrieb Carsten Fuchs:
> Dear Git group,
>
> I use Git at a web hosting service, where my user account has a memory
> limit of 768 MB:
>
> (uiserver):p7715773:~$ uname -a
> Linux infongp-de15 3.14.0-ui16322-uiabi1-infong-amd64 #1 SMP Debian
> 3.14.79-2~ui80+4 (2016-11-17) x86_64 GNU/Linux

What's the output of "ulimit -a"?

> (uiserver):p7715773:~$ git --version
> git version 2.1.4

That's quite old.  Can you try a more recent version easily (2.12.0 just 
came out)?  I don't remember a specific fix, and memory usage perhaps 
even increased with newer versions, but ruling out already fixed issues 
would be nice.

> (uiserver):p7715773:~/cafu$ git gc
> Zähle Objekte: 44293, Fertig.
> Komprimiere Objekte: 100% (24534/24534), Fertig.
> Schreibe Objekte: 100% (44293/44293), Fertig.
> Total 44293 (delta 17560), reused 41828 (delta 16708)
>
> (uiserver):p7715773:~/cafu$ git status
> fatal: Out of memory, realloc failed
> fatal: recursion detected in die handler
>
> The repository is tracking about 19000 files which together take 260 MB.
> The git server version is 2.7.4.1.g5468f9e (Bitbucket)

Is your repository publicly accessible?

René
