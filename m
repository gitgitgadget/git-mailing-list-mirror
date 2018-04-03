Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ABBB1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 09:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754876AbeDCJt6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 05:49:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:46215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754762AbeDCJt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 05:49:57 -0400
Received: from minint-aivcfq2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lh7M3-1ehl7D3uj9-00oSqs; Tue, 03 Apr 2018 11:49:41 +0200
Date:   Tue, 3 Apr 2018 11:49:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
In-Reply-To: <20180330191620.GA32338@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1804031133270.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de> <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com> <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet> <87fu4hwgfa.fsf@evledraar.gmail.com> <20180330191620.GA32338@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1399196620-1522748980=:5026"
X-Provags-ID: V03:K0:h962hNsvekIuqv0sSbK6oJE+Yvdx87cbIPk/OdOpw7bLSXiqfX1
 Md8jzzj2hx0l/XTukBL4umreU83dxhpEW5bQIdh2lK8sGDNXrxNGSQ5x8n3l2S+9yqHdVQL
 TSQ04g4n77FABjlM8eutGXjC0cGUafBU9CgpXuOD1n4TWvfs31UbLjkPAuZupH2/fLuFtXg
 uUm/Mo1MbhgoZhyCLFlsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rPA5H0MIfqg=:auE20Z5LbWW6K/II6GEBHK
 ID2fMVMtgQXitawtdyocrz5Vkb325VvN+9aYqDwLC5cYu5WT+/ZTPyDqSxead6wfpmYAdjrzm
 QLQ9AwUs+As+i5HQP2uDnBEfXS4QvM4faSOC5qh/sAhLBrACZdM/ZnpbfxEVogRpfcqxehcbN
 UheqkbqTeIpNCdPgU6sB8tGmoqDevwYIc7gKAjQUl8MkK01FxwPZ5i1FOn8irHf5eRnZThJPD
 OYPt3yFYT0mil867BpD8JSdOEZyMb2evpsdCge8Gh+2/vk2nbG+2bPN2wVB9+z2UJDnQySo19
 Zg4R+2Gt2KYKwen+/9+ynreNe5dzCqiyaw/CtBudnCjdiVXDqEFIJ1cHFLZ/LoDvIlHwSN4zz
 ZfeCPBnWeMO5Gr4qgSWOuW+APf3mIzuwQ5Le9kATysfXPhhNQ2OxVxmiBFNtsJig4zfeSD73j
 tjRmISNedMVC8wCS3z6+Vbr6vzNOIk5kjRcWBrHKcuXYBTyTkosw3VW59bftoJZVTWoodG7yw
 s0lHOCOuR7ZjkHkBX/OkC2YF6TaDMvFziv/XEii3JC94JMxmZkYIuLQhq+K492hifEupumaTI
 m0cdveFGIfrNimqBZu4fFaK4LbQAS5WGavLzAceEPn/OB6ZZlZ2pibBwedafMLNRdMDK+q30e
 cHi48bXr8jwm2dQ+vBnXHBolnb+8N4hdcBr44NZSy1Sl24GL1GbBeoMx/pnJgilsGQ7ZlcPon
 JJBS2VQ9GTUlY3pX50h9oj+fDbvASMt77iGUB7RLi7Xa0HEeG4ulhT5JkyVd06Vw5weiTgz46
 kDLURodPSsh8QvaHgkFvXPWsYQHdIvGLThtsRvVSDhbHOnDAL1xk6b3OnwkTLtFK0O2zeXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1399196620-1522748980=:5026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Peff,

On Fri, 30 Mar 2018, Jeff King wrote:

> On Fri, Mar 30, 2018 at 08:45:45PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>=20
> > I've wondered for a while whether it wouldn't be a viable approach to
> > make something like an interpreter for our test suite to get around
> > this problem, i.e. much of it's very repetitive and just using a few
> > shell functions we've defined, what if we had C equivalents of those?
>=20
> I've had a similar thought, though I wonder how far we could get with
> just shell. I even tried it out with test_cmp:
>=20
>   https://public-inbox.org/git/20161020215647.5no7effvutwep2xt@sigill.int=
ra.peff.net/
>=20
> But Johannes Sixt pointed out that they already do this (see
> mingw_test_cmp in test-lib-functions).

Right.

Additionally, I noticed that that simple loop in shell is *also* very slow =
on
Windows (at least in the MSYS2 Bash we use in Git for Windows).

Under the assumption that it is the Bash with the loop that uses too much
POSIX emulation to make it fast, I re-implemented mingw_test_cmp in pure
C:
https://github.com/git-for-windows/git/commit/8a96ef63a0083ba02305dfeef6ff9=
2c31b4fd7c3

Unfortunately, it did not produce any noticeable speed improvement, so I
did not even finish the conversion (when the cmp fails, it does not show
you any helpful diff yet).

> I also tried to explore a few numbers about process invocations to see
> if running shell commands is the problem:
>=20
>   https://public-inbox.org/git/20161020123111.qnbsainul2g54z4z@sigill.int=
ra.peff.net/

This mail was still in my inbox, in want of me saying something about
this.

My main evidence that shell scripts on macOS are slower than on Linux was
the difference of the improvement incurred by moving more things from
git-rebase--interactive.sh into sequencer.c: Linux saw an improvement only
of about 3x, while macOS saw an improvement of 4x, IIRC. If I don't
remember the absolute numbers correctly, at least I vividly remember the
qualitative difference: It was noticeable.

> There was some discussion there about whether the problem is programs
> being exec'd, or if it's forks due to subshells. And if it is programs
> being exec'd, whether it's shell programs or if it is simply that we
> exec Git a huge number of times.

One large problem there is that it is really hard to analyze performance
over such a heterogenous code base: part C, part Perl, part Unix shell
(and of course, when you say Unix shell, you imply dozens of separate
tools that *also* need to be performance-profiled). I have very good
profiling tools for C, I saw some built-in performance profiling for Perl,
but there is no good performance profiling for Unix shell scripting: I
doubt that the inventors of shell scripting had speed-critical production
code in mind when they came up with the idea.

I did invest dozens of hours earlier this year trying to obtain debug
symbols in .pdb format (ready for Visual Studio's really envy-inducing
performance profiler) also for the MSYS2 runtime and Bash, so that I could
analyze what makes things so awfully slow in Git's test suite.

The only problem is that I also have to do other things in my day-job, so
that project waits patiently until I have some time to come back to that
project.

Ciao,
Dscho
--8323328-1399196620-1522748980=:5026--
