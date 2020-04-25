Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A423AC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A5B20704
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZacQVaHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDYOtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:49:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:44737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDYOtf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 10:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587826168;
        bh=8+dc/acN/wC1R/wa5Tvmj+BSRNKBJIz3a+6MOzOmtQg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZacQVaHLN3bocTDIpRecmAQ6F5Odoy5hiGe3jDYfWt1J5ZG88uPwVqcLMpKx8cgvc
         5l13kI/nchMVdqqIblLa5v5GjeWPTVxJzu7QR2k5uf3lYNiJet6l057jWvod4bnbA7
         vyu9/OP1YRRgYaTq59iRomj3cK+8tDUMt8YCncxY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1My32F-1jH9eh2wCV-00zXDd; Sat, 25 Apr 2020 16:49:28 +0200
Date:   Sat, 25 Apr 2020 16:49:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
In-Reply-To: <CAKiG+9XpZjesKs4p_yRvtgEhqwSHDqnjJcNkzqg_AEWr5BeuQg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004251647520.18039@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com> <xmqq8sikblv2.fsf@gitster.c.googlers.com> <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
 <40da111a-77e0-55b1-a6c2-9edc77cf1f3c@iee.email> <nycvar.QRO.7.76.6.2004251523560.18039@tvgsbejvaqbjf.bet> <CAKiG+9VMjft14ttqQuZMwewOGFbnbfJ3uXn0vPiJb05A8wdSwg@mail.gmail.com> <nycvar.QRO.7.76.6.2004251624100.18039@tvgsbejvaqbjf.bet>
 <CAKiG+9XpZjesKs4p_yRvtgEhqwSHDqnjJcNkzqg_AEWr5BeuQg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MnjvuZlST8lXyfqdRg05HtDT+6D1wIGZE4ha1DvcgZjg2Fni+CT
 d4PLaqpN4BjfGSmGkKmXoQ4qVCPQzE/cvDU1yKfGCLLMf4k/bFJ2K+T6Jjytjpga4LmuU35
 mqOvFeEXiwEpaXui5od8zM2Xirm8SgwZKubKRmpqaCYjxyUWB6AGPjo4VYaeW2MMqwEecFi
 4iNTobl0Kt07FUIv9scIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dwWHys0pv0g=:mc5kZilQwz2dXxZN1dHj1X
 Vvi6pj3urAf2I+6CTpg/lhKXNHLnojqJixIpzka7qP2gk++22aNf3y1C1B3s0JKMjS70fTMuW
 lyefmj7SJQGZ6IONpz1FKiyCzYipLBMfs9eOBW8qQC05kju/vBzvSYbsCNxDnALe5VfnCgQP9
 NGf8BWWfiydzpSTb3FKcdDyJ7TTD6+QpzAtyjcpiYPrXz+xNFiyI68F4fPOttdgxKiaEpgB4C
 9FynY3nlfEsc5NS6VwetRcZvV+Et9upZbGSCaE+X45cauL/YoCJMA7T77ARORI5IAXNrkxTEA
 KdcXyYbIqXo78MHhyMdVNWd8iOSyofXTTbzHC/iwBy6U3JdMUTORLbUVEyME4qtCwQ/y/uXq6
 uDAb6ahHanRU5/duzv11RJy1BUUR3LqhgIvdSGpjTXHPIrBeX1JAReKcECJNemGvhx/9CKrrk
 bA27CcfSEKalZ5XVhUkQzpaqNsVAZW3HDLa7HLm+KI5u2NVdTgcqRaztES18EmCoDYNbKMwrE
 qTpOr9kizcOHNXD0Z0LJMWbWHLBJyxq/0uW6P66OIBS34dyYT3BmjyGZgOjcRiDOsSe+Q2XBd
 QIzMLSk7VhTmZhyguIL2QfT4JB2WzqcXtG1M8rFEB3tcYtw/Vi+eoWcj+99s6uyIWjZSaooGK
 CnjJ3xPpZu1NWQgTnM2i9+iJ8TJzXhCZuhlHGM3D92mKJVfOg7dd70V89G50vNKanqwgrmOKX
 i+pUrOgmweU/oWIY12CIp/VUqXsSU98IAAqoWaTpRLU23Dfn18/Dso1xwHKXW31bC3Rl6kVe+
 vPOPQRcBikO+12v3DJBZyZmWUK7LACZ+Xh9ZK+2k/neczesEX0tIUicdCA2rCJsff7/oPpUmf
 azS2tq8aN3gH8iy9nr8uHhlqll0oFyJFu6gZQFcxGVvPxOqXwOJouuDGwtdybbTsil8i7R0P6
 B7N0wAeZnMfQsitb+gJ3FfZA6mM3MvBxfncycZImlpbKwRW8QzG/0C+NK+S9ECj0kpIcWRc4n
 z42lykrsUV7mSU49fZMFZb7LrGu++ieVjoC1H3ZhJpb3nJT0kghWKoCABWMIMZxZh6ODODXC0
 ZcwkfWLDelKqIzNQxJWCgQvXuervZN1jmU5bOqQiMlJa1eVKcUeYLZ/wfAKfH4ogGfOkZLJAW
 b2rbwta1UXiUJbZEXIkIqO/aId175Jka2jwjZwTH0FkSMgyJQ3vcac71X/xNcopvsc3wGVdD7
 zEDE/HScAlSUmQLXy
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On Sat, 25 Apr 2020, Sibi Siddharthan wrote:

> On Sat, Apr 25, 2020 at 7:58 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sat, 25 Apr 2020, Sibi Siddharthan wrote:
> >
> > > On Sat, Apr 25, 2020 at 6:59 PM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > >
> > > > We already use `GIT-VERSION-GEN` as the authoritative source for t=
he Git
> > > > version, by parsing the line that contains.
> > > >
> > > > It would look very similar, at least in my mind, to generate the l=
ist of
> > > > source/script files by parsing the `Makefile`.
> > > >
> > > > Sibi, what do you think?
> > >
> > > One way of doing it is to track if the Makefile is changed in a comm=
it,
> > > run a hook to see if it contains any new OBJs and match it with the
> > > CMake script. But this is too much work, in my opinion.
> >
> > Oh, sorry, I should have clarified: We already parse the
> > `DEF_VER=3Dv2.26.GIT` line in `GIT-VERSION-GEN` to determine the Git
> > version.
> >
> > We should be able to do the very exact same thing to parse the `SCRIPT=
_SH`
> > lines like
> >
> >         SCRIPT_SH +=3D git-bisect.sh
> >
> > in the `Makefile` to accumulate the list of shell scripts, and likewis=
e
> > the list of object files could be accumulated by parsing the `LIB_OBJS=
`
> > lines like
> >
> >         LIB_OBJS +=3D abspath.o
> >
> > (We would of course need to substitute the `.o` with `.c`, but that sh=
ould
> > be easy.)
> >
> > That way, nobody will ever need to touch the CMakeLists.txt file when =
they
> > add a new source file to libgit.a.
> >
>
> I understand what you are trying to say, this is not impossible to do bu=
t doing
> so will make the CMake script dependent on the Makefile for the sources.
> I am not fan of this approach.
>
> We should write a separate script (say python) to match each of the sour=
ces in
> the Makefile and the CMake file automatically whenever the changes detec=
ted.
> This excludes the platform specific/compatibility stuff in config.mak.un=
ame.

Hmm. That is an approach that _I_ don't like. Why duplicate the
information when you don't have to?

I don't see any issue with keeping CMakeLists.txt dependent on Makefile.
We could of course extract the lists into a separate file that is sourced
both from the Makefile and from CMakeLists.txt, but that would actually
not reflect that the Makefile _is_ authoritative. CMakeLists.txt will
never be the authoritative source.

Ciao,
Dscho

>
> > I was not trying to auto-detect what `sed` invocation changed. Those
> > changes _will_ need manual forward-porting to CMakeLists.txt. Thankful=
ly,
> > those events are really rare.
> >
> > Makes sense?
> >
> > Ciao,
> > Dscho
>
> Thank You,
> Sibi Siddharthan
>
>
