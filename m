Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA56D1FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 01:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbdCHBMa (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 20:12:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:53359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933407AbdCHBM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 20:12:29 -0500
Received: from virtualbox ([95.208.58.158]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M86PB-1cPCIw48mn-00vgwT; Wed, 08
 Mar 2017 02:05:52 +0100
Date:   Wed, 8 Mar 2017 02:05:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     valtron <valtron2000@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
In-Reply-To: <alpine.DEB.2.20.1703072345530.3767@virtualbox>
Message-ID: <alpine.DEB.2.20.1703080159420.3767@virtualbox>
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com> <alpine.DEB.2.20.1703072345530.3767@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SvhCR2/xt9AM8Kz5NM2nu4Bll5j6H8pm8g/XACVmtGu/IRZlanx
 OGMWaKMaw1Nvcpwazxd844b+oPkXZv4dmWOrnXBqYVg9kM85t8V11ExxTWC4Iky+2XX5IO7
 T4v6ahtqDcJDClEQbRQ6oRVnMGv6YdmJNz2iJujjExbZVm9wJUxUWt+70alkmCzXq7KkA0V
 r1aRLe6/WbJLEGtf0A3Bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4ZtowW+QonA=:D7bGj0TY1SZnU0m6xA+BTy
 wJblz+4ArzZQrckQj0UroCpwNWTjGonnB4nAZ8XEX0yB4qRGG88DHQvkv3oz1nQbV34b0z+b9
 ocn08y6xu1ybRPdi82ZjkCAmiOYpW0yIMhZC3+H49+oY5ew7N42ZZPCKvg7e3QVcW9iVStUY1
 Hc7bWkb1Kme0LbBmd4LqgoYsfU4Q6/DUhbTHGF7oJLw5MaPAjVyAZTrpB/dketYjdbrgEKbTP
 gV+kcAmp0oYYIKCu3HV0mLVTAW1g0jWn2QfTvB2kXv0K+wAwPslgUiZ0xMSTq4sOedRABbtwx
 d+fPVkJxtXm4iZOyPW12D3t9esRrH08xo0YuzxsHtpNXfxfIh48GnsEPv1eczVADi2Bj+JB25
 MAGI3iaxGsOdIuyr0IQBpw9aSHmkrCKOItWaT5ldRFz6ykNyGfz8c82uaO7Z6uaTh8es6G7H9
 uvyt7TxK3JJYMGSvdogXSMo/kXyjgqjg8P9F/HPefbN6R2glmOQ2nWiCfqXqLS9PGvWTpQbm3
 nf+Tq2vYs6rymEZkwrSYYZSGbVkFfTB8aAp/mxYHa+rffr39Y6dRy8MSmf9buZ/xBa04qXnwB
 shDAxOScr+aydTeCZ/3RH+tW666oz6PCH0s+KHpio8bTe7Ovw3iyqlW0QY9H5olW9wKdGOqce
 4eAv5dBKrg2wRrspubql0zrsy9h+NvY2uk8OF9ahLN8Wq8ZThCvjLOP18FP/DBUmf3sgcVQYJ
 a0z2HHow/w6LNe869ihQZnvCJDrfOujtLTD49taoS+8yz1/xEWmRqf30xAMwzVazN1ZDqDFma
 Khbauro
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi valtron,

just to set the record straight on a few of my suggestions that turned out
to be incorrect:

On Wed, 8 Mar 2017, Johannes Schindelin wrote:

> On Tue, 7 Mar 2017, valtron wrote:
> 
> > Stacktrace from GDB (on git-rev-parse) is:
> > 
> > #0  0x000000018019634d in strcmp (s1=0x600062080 "/c/repo", s2=0x0)
> >    at /msys_scripts/msys2-runtime/src/msys2-runtime/newlib/libc/string/strcmp.c:83
> > #1  0x00000001005239f1 in ?? ()
> > #2  0x0000000100523f36 in ?? ()
> > #3  0x000000010046c6fa in ?? ()
> > #4  0x0000000100401b6d in ?? ()
> > #5  0x0000000100401e4b in ?? ()
> > #6  0x0000000100563593 in ?? ()
> > #7  0x0000000180047c37 in _cygwin_exit_return ()
> >    at /msys_scripts/msys2-runtime/src/msys2-runtime/winsup/cygwin/dcrt0.cc:1031
> > #8  0x0000000180045873 in _cygtls::call2 (this=0xffffce00,
> > func=0x180046bd0 <dll_crt0_1(void*)>, arg=0x0,
> >    buf=buf@entry=0xffffcdf0) at
> > /msys_scripts/msys2-runtime/src/msys2-runtime/winsup/cygwin/cygtls.cc:40
> > #9  0x0000000180045924 in _cygtls::call (func=<optimized out>,
> > arg=<optimized out>)
> >    at /msys_scripts/msys2-runtime/src/msys2-runtime/winsup/cygwin/cygtls.cc:27
> > #10 0x0000000000000000 in ?? ()
> > Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> 
> This may be the wrong thread, though. You can find out what other threads
> there are with `info threads` and switch by `thread <id>`, the
> backtrace(s) of the other thread(s) may be informative.

It was actually the correct thread.

> Please also note that installing the `msys2-runtime-devel` package via
> Pacman may be able to get you nicer symbols.

I was wrong. The problem here is git.exe: you would have to uncomment the
'#options("debug","!strip")' line in the git/PKGBUILD file in
https://github.com/Alexpux/MSYS2-packages before rebuilding the package
[*1*], and then reinstalling it (which increases the installed size by
94.82MB to 119.63MB due to the unstripped symbols). But then gdb would
find the symbols alright and you'd see that the crash happens in

#1  0x000000010051aecb in setup_explicit_git_dir
    (gitdirenv=gitdirenv@entry=0x1005a00cc <sign_off_header+556> ".git",
     cwd=cwd@entry=0x10055e970 <cwd>, nongit_ok=nongit_ok@entry=0x0) at
    setup.c:669
669             if (!strcmp(cwd->buf, worktree)) { /* cwd == worktree */

and worktree indeed was NULL.

Ciao,
Johannes
