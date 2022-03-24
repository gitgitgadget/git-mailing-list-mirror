Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68668C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 14:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350710AbiCXOEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCXOEr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 10:04:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA32825E8C
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648130563;
        bh=8ChLo4DTqvpShAljxcdwiZhZmKGHZYzc+0jeSGe55n8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fdMOUrVpZJ8MKubsEUdcV6LN05PRPn8P68/4eeTzhT5iu5daTX+1ffOueB9E1s5lF
         PIMKvifWBtTPE2K34vrfF356+/OPaHodcNqmLLDFTIiXipBPjhFma5pgVi3raZBY2Q
         hIOwJSPzmc/yxFesSbHU8ZC7BH83FVFm9SNi+4R0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([213.196.212.0]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1nJrfQ2ISt-00F9AH; Thu, 24
 Mar 2022 15:02:43 +0100
Date:   Thu, 24 Mar 2022 15:02:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     phillip.wood@dunelm.org.uk,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 4/6] builtin/stash: provide a way to export stashes to
 a ref
In-Reply-To: <YjJbJ9ZXlUAd2evC@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2203241456250.388@tvgsbejvaqbjf.bet>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net> <20220310173236.4165310-5-sandals@crustytoothpaste.net> <220311.86bkydi65v.gmgdl@evledraar.gmail.com> <2422376f-79aa-2d35-2646-c3611e2ef8d6@gmail.com>
 <YjJbJ9ZXlUAd2evC@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-597181099-1648130563=:388"
X-Provags-ID: V03:K1:Jx2vBBwvj7X0C0SIYjYfoZu0qna3PHWcHcGhjQAZc+Bkr6HRRem
 Ua0rtnvVbCz5mpXIBGFKUAQe8yNrLFxoRSsKTKNgRJmYrkxGofj+/75DI7rZoNQ8gNOOqGw
 C2TXTsqnSQpq6wkBPl+WPMK2VlThhicdBG9PwFQgOP/no0iKCdI9VAxyxwWvhkCoEdTsPsJ
 fYQi3WNiLR0pGpuXGxPGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kc/O4giwUDw=:N1oe6n4msWZYZ+CHUB1pDG
 bKEiY/jasb5nuQKsS/QdzLWf0mtlrlzC322FWUXTdMoynQy7uHvnk70BcO9XIVFLCD3YmEq0a
 z6uppZBndiZki6lAuTCaFZwlEJFDwK41rNY6duPtOxBHQphJhX+H1uN+vveiNxph4kFARqSmR
 MqX6MvrYALGv6QQcbW2AO4/iCP65J1BB3a6ulsKCKvGadLWYfq959hztsA+MC0rP0k0H9K2Ld
 RdDiAPrmP/gmSKiHX/C79FD8jgklpGP7zkz9jhSZartb4EQsWv/a7HG6IhYhltWnllqVRfr72
 lS6VOBOkqvL6mZYbeGC+HEjvOdqPWabjQ9MfRf/n37hnkfbdeAnq85R6cU7DbwK3amgpuFBS8
 inPy1am0XzFSL7NEOCBqAa83ofwzDUhnO7yqC0n8B+Sek5Gk7KWDPRZL4xjPPlwmQQtdp0PS4
 C8luxP0+r3rbl4wWBw9g3+doeV4tlJzKwsz8/WmIAt65XVBzHoWPwZZCFV7C/O0ZcGQ2Mit9v
 R+El55vTZBYJ0eXT8kTJMRAORKZ+Sb9A0eZ6TajZfuE38sLkpuv59AuyJgZu18ewWlnalKRR9
 zJlA/+nWMHiMWo8ZifjJkrojjzpRLwhe2CB0TdnhBAX0KikC3ZMEsIJ5ImHaGKudMVDC4FJyM
 TbVtOXAfoFsXw6r1mgcbQNop1KLM1UWdLyNzcsBRdPeb+D5dhfCv/Zc6XbyAW4vfzR73VCR5m
 EmlvDb5E1s/kkyrLSpNT6p2ZO74fZwsProZ8rJXRogNIryrWdVfrSxNPTtwlHVL9KfwoqeVZV
 fLLYayF0gMMhi3HzMynWGkvM4qaELuN00KK0Y8Gd8/5ZFJgflral8uSbDdl2ebo2A7K6EIu1f
 gwMir7LIPLNzH/UzgSIcYjiXrmqSyBtT4CO7QQ0xH577HD9YEVkmyzZzkaZlQLShtQ/TT3//1
 H3j4VWz3NrdJZo/OcCot9JH7oS0CLaDKdhsB73/XItOzFSGn0vKYQKQIJIptYkDXFleAE1Amu
 hp+RqnD9k7K5xBL4IvnFbI5Vwbf3VBQHM2rayfTdIiZoFJ1Y9ohYysV1ooNFh219HfDqZONfp
 ncC8RdyQSfFBNs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-597181099-1648130563=:388
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi brian,

On Wed, 16 Mar 2022, brian m. carlson wrote:

> On 2022-03-14 at 21:19:10, Phillip Wood wrote:
>
> > On 11/03/2022 02:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > >
> > > On Thu, Mar 10 2022, brian m. carlson wrote:
> > >
> > > > +			}
> > > > +			snprintf(buf, sizeof(buf), "%zu", i);
> > >
> > > Aren't the %z formats unportable (even with our newly found reliance=
 on
> > > more C99)? I vaguely recall trying them recently and the windows CI =
jobs
> > > erroring...
> >
> > According to [1] it has been available since at least 2015. It is cert=
ainly
> > much nicer than casting every size_t to uintmax_t and having to use PR=
IuMAX.
>
> If we're relying on a new enough MSVC for C11, then it's much newer than
> 2015, so we should be fine.  It's mandatory on POSIX systems.

The MSVCRT we're using in GCC is much, much older, and that won't change
anytime soon, I don't think.

You _might_ get the code to compile a `%zu` format by playing some macro
tricks, but executing the result would still not work.

It sure would be nice if we could use all that POSIX promises... but we
can't. Sorry...

Ciao,
Dscho

--8323328-597181099-1648130563=:388--
