Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B2FC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817A220707
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eYRHEync"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgEDVcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:32:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:42005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgEDVcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 17:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588627921;
        bh=8INt7mINFy1R1F55rVFsQmPT0ces2XKipWJVqbS7Wb4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eYRHEyncM9O1o6l04COi0oJU8Mqmc5A/QrTAMT69Rm3e0Ya48SZuBnNdM808vaxfM
         RJFkLpgpoHyX7sPB6KNhPSv3iTQhfHvN2p8IQnW1GawEpj+ZXDCMYbR7n8EO3HH093
         6ZhcnmYinvOOLFfUHq5IlXnLKrKxHkRqb2bGd8vo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.224.161] ([89.1.215.201]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1jTnoW1AfB-006trR; Mon, 04
 May 2020 23:32:01 +0200
Date:   Mon, 4 May 2020 16:31:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Konstantin Tokarev <annulen@yandex.ru>
cc:     Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] CMake build system for git
In-Reply-To: <689741588534833@mail.yandex.ru>
Message-ID: <nycvar.QRO.7.76.6.2005041630150.56@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>         <xmqqv9lod85m.fsf@gitster.c.googlers.com>         <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>         <xmqq8sikblv2.fsf@gitster.c.googlers.com>        
 <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>         <20200427200852.GC1728884@coredump.intra.peff.net>         <20200427201228.GD1728884@coredump.intra.peff.net>         <20200428135222.GB31366@danh.dev>         <20200428210750.GE4000@coredump.intra.peff.net>
         <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>         <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet>         <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>         <xmqq4ksyl4mz.fsf@gitster.c.googlers.com>
 <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com> <xmqqsgghhr32.fsf@gitster.c.googlers.com> <689741588534833@mail.yandex.ru>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-470759112-1588602668=:56"
X-Provags-ID: V03:K1:NmmDPJ4JbPiFWrCJ5D7rhshNHzFzYCZHSAR3iCVxnhtJ2Ap4h+U
 fVGmtNBA1hmfgV3Dcc/9dgs9N+/y6oyf5J7Tyv2vvJJmOQRTmyLiyVkp6falMglEVH2Iap5
 7EOp/6+KLfuefl+xt8shdzqWIhmm8fLif1Nb7iEriu1ujywEdVPrPyu8QjYDMVMx9jHskjE
 w1HLxE/FQkVaTdLyT5X/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TskjpDTruKY=:lfyHiqOTm6K203rOSQZSp/
 FHN7No1zBtQ5RMkQiQqblbya40siO4wcm4G+iF1Xp4063zyDEmv6rnlJ8FpykE/pGW0wx3I+v
 9fwddmJYQrVzSvfld68FZC+AvTHyFYQrVOWqX+vxQvPa7JcxXBu1wYh0wAZC+hnwwlF+F4oBL
 NBhHR54TfjJQJhoOgh0IdSLTEB0nxEYVQtW+L9G7l4zLzBicAErT1kGitUYcKLQiqgSPRGe4j
 IXn2O3/JIeE13q08DaicICC7/TavO0ehRs+el9ftXgDyjYx8vRczZNElRuWvGHy+XvSr/5/D2
 iGXkPxFWhuq/aYbmAZC7qGV5Bo4iol9IHF05RRx/zHGriPlxPUK01scLA7N2bRZXjQbLHKDVB
 x7BrKPiB45vnzoALa5ctQw4/B3INm3HRl0ruu4AZEivhS+GNci9gPeyTq/eC4sEAHoEKDxf9a
 JUhIcxeLIfq2DX/V1buWkVpcnPD0AtB3fHGl94ZNdhliRcS/ScwuoVjloh2fUSIFn1TPfDLfL
 H1e4LsxgcmJ2U5oKi0xu/TOFPIYhWZbpgeyInEyPUq8Zep0s8bkj2Sqqi2i7tWyp6OvUChbzP
 0KxbcEmyLrrLVqQ+L58YUyAc+lr80v6ollcRZXdgO7iR+YLGk3zM761+uTJGeBMmrQqGoX+W8
 YxEqIHu9yg5siL9u9IGz7B7mriapfKXJeA8EUj0hzEAvKhjqsxYsAWjwxGE2M95tENM+Nz4z9
 OEUkjfBHtbXz+sTedY4d5VzY86uOHncQLwsReduQCU5sPcHWG87ZTUcxjAgZejPMApYCMNbT+
 aNekR6NIW8melBtrSLoYBXThkMG04WeSSXkwuDqS7Xi7hOaCe1jTMCCSiy3Yas7vIa3jKppyB
 UZ0a8ryS6sWMkHpx4ERsDQtlFKy9yrE6KRjX6k+tgRVEz2Z5mFQA7ksHmHvIpEAf4TDz7862N
 QaoJKOK6QzlUEwDlcLZUmRM1BRdY2Odzaw8o2+fFnPiF0l1pvcmwd+PeOaIIROyZ2K2o0mvVR
 KWzSr4qW2VSTyID9KbYAlsX8twdwLILidkzLKVltid1yMtfUwwO3ZvAh8bOY/99bNPAcsGDtt
 1wLKVe270MuvnE2fAfAvAM1QHt9O2n5e9pBsqZE8u44YSakp1t3t+bRTHb5NLPSdjB0S2al2q
 JNJiw60+I4ToMpyDhHhqvqvUkkQ1aVb6OdkSxViKPqivCqA2zwdgwKamCEIyyQrxYxSTAPH2S
 etni37SwU2xoB5bof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-470759112-1588602668=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Konst,

On Sun, 3 May 2020, Konstantin Tokarev wrote:

>
>
> 03.05.2020, 20:21, "Junio C Hamano" <gitster@pobox.com>:
> > Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
> >
> >>> =C2=A0As you say, an extra instruction in INSTALL file to tell users=
 to
> >>> =C2=A0copy from contrib/cmake may workable, though it is unsatisfact=
ory.
> >>> =C2=A0But the other one will not simply work. If we need to have a n=
ew
> >>> =C2=A0file with string "CMake" in its name at the top-level *anyway*=
, we
> >>> =C2=A0should have the real thing to reduce one step from those who w=
ant to
> >>> =C2=A0use it. Those who do not want to see "CMake" at the toplevel a=
re
> >>> =C2=A0already harmed either way, if is a dummy or if it is the real =
thing.
> >>
> >> =C2=A0In your opinion, what would be the best way to communicate with=
 users, there is
> >> =C2=A0an optional CMake build system for git?
> >
> > You do not want to hear my opinion, as my priorities would be
> > different from yours ;-)
> >
> > Given that we all agreed that the only reason we contemplate use of
> > CMake in our project is strictly to help Windows build, i.e. due to
> > the same reason why we have contrib/buildsystems/, it is not one of
> > my goals to communicate with general users about optional CMake
> > support in the first place. It has lower priority than keeping the
> > project tree and the project history less cluttered.
> >
> > So my first preference would be an instruction somewhere in install
> > or readme that tells those who want to build for windows to copy
> > from (or perhaps update cmake to offer the "-f" option and tell it
> > to read from) contrib/cmake/CMakeLists.txt to the toplevel before
> > doing anything [*1*].
>
> FWIW, CMakeLists.txt doesn't have to be in the root of source tree in
> order to work. It can perfectly work from contrib/cmake after necessary
> changes in relative paths.

Would you have an example handy, or a link to an article describing this?

Ciao,
Johannes

--8323328-470759112-1588602668=:56--
