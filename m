Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8EFC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474BB206CD
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TI1SCCEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDYO2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:28:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:42179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgDYO2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 10:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587824918;
        bh=C+omtDfOxh404CzaczOgmwpkM1aBgicXRqffBfVogMI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TI1SCCEqE59Dw8VmGp1+g3/aJaNbn42nIwTxhebuiWCTsU5ol7PRm8ZbYcd8iJnfs
         3TS/vnXkAN30WObLNnKkyJlRYdvYM4gYrxiTTl89CdgLwFoTCUlHLSr3d0d4CkPaI9
         1P9mqRXhryK6EcAKjnEuure61PLBgAraoHzpK32g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N95iH-1j6Cg63Z27-0164un; Sat, 25 Apr 2020 16:28:37 +0200
Date:   Sat, 25 Apr 2020 16:28:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
In-Reply-To: <CAKiG+9VMjft14ttqQuZMwewOGFbnbfJ3uXn0vPiJb05A8wdSwg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004251624100.18039@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com> <xmqq8sikblv2.fsf@gitster.c.googlers.com> <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
 <40da111a-77e0-55b1-a6c2-9edc77cf1f3c@iee.email> <nycvar.QRO.7.76.6.2004251523560.18039@tvgsbejvaqbjf.bet> <CAKiG+9VMjft14ttqQuZMwewOGFbnbfJ3uXn0vPiJb05A8wdSwg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fWvQAi67UejUeDEtal9t+ZKFE5l9oREGQkZJBEcwQ6WDhr87lE7
 T92M4i/JitLmSFMcOpDFdGVzrrDiMBMmWv40FEsdMOOz19sdQY0P9CFM2some+QQsTK5rj0
 wgMmeUcuYhai2TZkC/4iN+I5JDl99+DoxkdLuHv0IxS/41l/0RK+Y6ji1xVN3zhOf8hYzbh
 EEl8RT2zvAVHAKRIzc4zA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TQ54x6aWk50=:Ud505+2A1vrbixZsyoxj5r
 9d+cNU6sUqXr4tuhaaUQ+jqtw6voUuBlMaAh/i88uk2VyFh1EFnRHE2GjBQt+aok9Qqb/fHSd
 A6jaUBMaToVYx3NSRNAWuztu3XbWa0BhaHt6z7B8d3S7xrSUdgfYX0+vimOMrGq/StKiRV6MD
 souXOXujjE2fW6hp5BQZ5aZntrrCRtZISsSBPi8jqVRo76tg8rCmlOkCk8EcdZTajkVYpoxdc
 vTq/k9Jr9TWQt1Yrpeq8vPWG5xnX4gYUkNe4iaM4X6l8xh5xPgyc2s5qLk/5stLgwhx+AMDWb
 dpRIzPtPG3E846yVG5kqzQR0+wu+rpJ+NfxkaBVULGBVQxrrvg377Kvi+iFe7zD7YFnobC0yp
 l+FFiHbwyabjVZJTBr+5gV9bsFn5r6sT7kVM/cMKEfKUBcZMv0T2FhVpBcp/wwrgFjhZYRnbZ
 ftMQZdlVizfFehbltA6NikIaqT1D7Aa4394PszMHjXc21odjfjw07wsMaqqPDYuJn9TOp445V
 I4T+jRnAGR/LbyEzRmnsQUyPKnbT2NYNjT3pOtVjyUXCy6NE4qIlmSQ1zV3mi9t0W4aPcpjib
 gDwsb3l+fcXhA03p3a6TRnCIL8RedpBg9/DcDSWEcKVNMJ1dleRxN9VY8nBnywOELtkfKtY6s
 H0LzM+VIJPPzbYecxlVc9zh3FJKwqDWVb0BQm8xlHH7GXJ5hKT5F/A70NL+XxZSQJBD8XUOO2
 JpPmqeN2ZIy1Ycnewtbp4/QCu6CWxPxpfHZijeRx0asNgL9SGYwIGUaRYrYJ8S8Gf9fI8UChZ
 ho2QFl49cYv/BOVaKPhN7ozGNJxVNbd3o5dYkU9nd38NrWbA6QHjQzfzUXs1DBZ5wcuotYbe7
 VUDDpcsQkoifzagOF0gdB2L4YFeIgMZDqJqkmxT1BnAeoAdyqfCU5bqNPFUFqmjftBMQkBaZ3
 pVUvZUSEZng/2CHRuJh8+mbSV516uzX9mgNGjSl9PARNVfX9vX4Jj2wtBz0HG7FfW5GCLq3Ro
 RuV0ta21pQoAREl5/JjFU2Y56/92bwwrOMYxkkndRmKJs13GLREpFf74XVQ3XKwsRVYUhrg90
 7PXUONov5MrDtK618QPTr+YLVcBHb7Aa2gb8JEgTfFfuOGaXWyplIzdijordKKCMb767I9Eau
 oADO9vGbn9cEUILTJppuFwU5GtjlN5etKLCeLuGnN5YAXY5DIQQKSIRNkosj5aO7UpcPZZ9eV
 sMmW2APcHIen1kljE
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On Sat, 25 Apr 2020, Sibi Siddharthan wrote:

> On Sat, Apr 25, 2020 at 6:59 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> >
> > We already use `GIT-VERSION-GEN` as the authoritative source for the G=
it
> > version, by parsing the line that contains.
> >
> > It would look very similar, at least in my mind, to generate the list =
of
> > source/script files by parsing the `Makefile`.
> >
> > Sibi, what do you think?
>
> One way of doing it is to track if the Makefile is changed in a commit,
> run a hook to see if it contains any new OBJs and match it with the
> CMake script. But this is too much work, in my opinion.

Oh, sorry, I should have clarified: We already parse the
`DEF_VER=3Dv2.26.GIT` line in `GIT-VERSION-GEN` to determine the Git
version.

We should be able to do the very exact same thing to parse the `SCRIPT_SH`
lines like

	SCRIPT_SH +=3D git-bisect.sh

in the `Makefile` to accumulate the list of shell scripts, and likewise
the list of object files could be accumulated by parsing the `LIB_OBJS`
lines like

	LIB_OBJS +=3D abspath.o

(We would of course need to substitute the `.o` with `.c`, but that should
be easy.)

That way, nobody will ever need to touch the CMakeLists.txt file when they
add a new source file to libgit.a.

I was not trying to auto-detect what `sed` invocation changed. Those
changes _will_ need manual forward-porting to CMakeLists.txt. Thankfully,
those events are really rare.

Makes sense?

Ciao,
Dscho
