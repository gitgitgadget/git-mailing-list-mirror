Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BF8E1FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 00:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756591AbdCHACC (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 19:02:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:65144 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750986AbdCHABy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 19:01:54 -0500
Received: from virtualbox ([95.208.58.5]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7YF5-1cNeYm20G7-00xMXw; Wed, 08
 Mar 2017 00:03:31 +0100
Date:   Wed, 8 Mar 2017 00:03:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     valtron <valtron2000@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
In-Reply-To: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703072345530.3767@virtualbox>
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6SdoSV0amfuL3ps6qhhgUEgEX1s6Rk9RAZR8SiKraw/cS6SYRJs
 mnm2yuB0cR61+LgXV+7VA/j3Y0AIPGRqFlgMUygMD/1v7yv8wqbhQw5wi9aw9lqBvHK3E9d
 jcti0rb7y8Os0npF7daChaM7jW6XF9AdmiiIVtXaAvvk/EfNQO+PWEQUfbWWgGGPhTDxWvZ
 my8ZA7BpfjZ3mqRMSUWSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hWN5NrvUtSk=:NKkYi7/sabWBUlYlIPu0KT
 pzn+6GkZCiLasXaBrTmQQzjXtRq5yB/9jbPOvfQJJuCU/HEDzgg+ui2UjFy6SOEJvXc9mqfWk
 LGaQH3SqWL07XAXba3FUqHQk0kSRXL23OEhpBoOI0zkUCSbWyDVBF2RnIJfgGAhlOBJzhvg0l
 BJLADV4mxL0ptVMzta9CAKW8uA2rNG8/fmsXtB9ycsit574CAMinfVaFz+/drkUSCX2t5E8bg
 Gw6mmXIF1i45ygAfHeX0xA+Y2iJE1apL0nfDmIjf8E57vdFXWAhxFvZ+xUeiM43bVlqf8K9gg
 588ATGWFxA6IZqS9hP8nsIvDXjha3JKwqUh5o2qdnIaWA6l7fb18DflAtME/jFB/NyQ9x/xgV
 OZjNcSsW7Z/LXBR4vpDxF3c+aNk3VYAkWAZiLVazxevflmsyBiHKIWXjwof5RN/fg8n8ayyNb
 xESiBU5YiRlhZe4LbXjc9qblWhDG8dvAVyeTcUqi7rZvRxuUu36LcgkjJbHDLb6RRk1+b4xhW
 Go9w9LS8OpMUixx7yL/lGMTrzlvA2Rku1d4RRXmve/6qA1BiU+pwltNzhS123sQoThOewndKz
 /UNtN4ChUz74TkeXcjG2+yBA1ovql7FP3qlqXjX5ObcKd+TxqugusFo6Wz6TaKpmkpGCSWQEE
 ixrcpqtvannZgOfxteF2A5RunSM79dV9uu2rnMZepHNfUDmvbLAxTIU2xhF6iKb3XTN3kjfq7
 qZgZ2yOVwsClffi1tlQDVV8kMv88+Ixg/HWUFAB7yioyjC6YbU7a8yggH/A6Vj7IXfHCRiW+W
 MyEbpmj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi valtron,

On Tue, 7 Mar 2017, valtron wrote:

> Git 1.12.0.

I take it you meant 2.12.0. And you probably also meant to imply that you
are referring to MSYS2's git.exe in /usr/bin/.

> When GIT_WORK_TREE contains a drive-letter and forward-slashes, some git
> commands crash:
> 
> C:\repo>set GIT_WORK_TREE=C:/repo
> C:\repo>git rev-parse HEAD
>      1 [main] git 2332 cygwin_exception::open_stackdumpfile: Dumping
> stack trace to git.exe.stackdump

This suggests that my assumption above is correct: it looks as if you are
executing <MSYS2>\usr\bin\git.exe here.

The proof lies in the pudding, though, and you are the only person who can
do that unless you post the contents of that git.exe.stackdump.

> Stacktrace from GDB (on git-rev-parse) is:
> 
> #0  0x000000018019634d in strcmp (s1=0x600062080 "/c/repo", s2=0x0)
>    at /msys_scripts/msys2-runtime/src/msys2-runtime/newlib/libc/string/strcmp.c:83
> #1  0x00000001005239f1 in ?? ()
> #2  0x0000000100523f36 in ?? ()
> #3  0x000000010046c6fa in ?? ()
> #4  0x0000000100401b6d in ?? ()
> #5  0x0000000100401e4b in ?? ()
> #6  0x0000000100563593 in ?? ()
> #7  0x0000000180047c37 in _cygwin_exit_return ()
>    at /msys_scripts/msys2-runtime/src/msys2-runtime/winsup/cygwin/dcrt0.cc:1031
> #8  0x0000000180045873 in _cygtls::call2 (this=0xffffce00,
> func=0x180046bd0 <dll_crt0_1(void*)>, arg=0x0,
>    buf=buf@entry=0xffffcdf0) at
> /msys_scripts/msys2-runtime/src/msys2-runtime/winsup/cygwin/cygtls.cc:40
> #9  0x0000000180045924 in _cygtls::call (func=<optimized out>,
> arg=<optimized out>)
>    at /msys_scripts/msys2-runtime/src/msys2-runtime/winsup/cygwin/cygtls.cc:27
> #10 0x0000000000000000 in ?? ()
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)

This may be the wrong thread, though. You can find out what other threads
there are with `info threads` and switch by `thread <id>`, the
backtrace(s) of the other thread(s) may be informative.

Please also note that installing the `msys2-runtime-devel` package via
Pacman may be able to get you nicer symbols.

In any case, this problem is squarely within the MSYS2 runtime. It has
nothing to do with Git except for the motivation to set an environment
variable to an absolute path as you outlined.

Having said that, the problem also occurs when using *MSYS2* git.exe (i.e.
/usr/bin/git.exe, not /mingw64/bin/git.exe) in the Git for Windows SDK.

Ciao,
Johannes
