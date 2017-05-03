Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFDFB207D6
	for <e@80x24.org>; Wed,  3 May 2017 09:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbdECJp4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 05:45:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:58479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752355AbdECJpy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 05:45:54 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfSrf-1dQ1Cp3T47-00P6FF; Wed, 03
 May 2017 11:45:40 +0200
Date:   Wed, 3 May 2017 11:45:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
In-Reply-To: <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1705031139090.3480@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox> <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com> <alpine.DEB.2.20.1705021756530.3480@virtualbox>
 <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1854777249-1493804740=:3480"
X-Provags-ID: V03:K0:w7ClSOJ1DRuaX6mbRI4/qNEcws3xqhDzzfwy8+I1x4BX6QHVdd6
 Hx9qoBDbyo/oO4lgFqbm+8a5DuXyJtkSQ/Pr3/AzcR1NrbpnhQZOhtjHGThLGeeKaYxCM5C
 zAAtQd9uXULF7k8k+U/DLRqNdO9rXyW31pAKCa8C5b5zlgGptiNWj0NOEIqlLC4f/drVzkO
 ZenFdnM9/YMkE7deKuy0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VVX1FBrR450=:3ECfZ0Vr+2d9j9j5etgVqb
 5elFhC/0i7vJmlqktJUJUjg1watux37xkA5AMix7dna0TcpnCgev+VHyThMH22EER/3OxJeI9
 ntVMcMsKPUQdEwBJNCiMochg7eyW5DPJHHmD+47l/EnEcw6tbz11oRThrbgWfoouzZIqV2Lla
 0kPA51FtLKlYm4Z8r2ar+4LOVH+YxiDKW18KhpPg2eAq6C+O6I28uzhsECSDUWHsvb9SZ3aMZ
 7b8phd4cnN+8jdEypmWYfR0pYUMsTOg7r9Qxz3N+/R+D6xBBFvjWoxvHysxufzJyQkE2TvaMb
 ftDIAda3VFKn46CqfG0EXPSHVPqW5TfyzE4SPsNj83pwn4RpBRbeY4bjdbQG3Q9bLv5i4zhdc
 Z9LpB2Z1G0REjvuKuqxZCzdYGdLpWxk5ugP/eJkz10SByjBkqFC2p7pjPonVOehbwqDD7hNgw
 MQJD6wGwCJW1TF2dc9hEj9vR3XhzzOWWQ7tL00HUkgDD6Foyz84/gyedq9QFoefAc0Oq/vs5d
 fJd36a7gVst+04/btleEnbNVv4CqjUK9wcIG+sL2nQi88nE9DYvxWbJdN32iNbT6wlQqAwbjZ
 pKme2hXQNvkxQ6wU8yjgMsD1AiVZzIxSsGPr/9ZkxUwOl2dPji3fyw6yNRmmAFICNftcz3xNh
 NtWZLsT9zsm3i0uRkUqO838JZ/ThdtC48BZ+o/fO4K3R2QkcLWibQbr7j+6uRkXkiZy4w3iKy
 lp2nR7hGg5cuzIleODeQLuOcEJhZRLPU6i1CnoizzXkMQkD27i/BdG7dCDwhlfr1u1X815Hi8
 rNZmgJB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1854777249-1493804740=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Tue, 2 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, May 2, 2017 at 6:05 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > [... complaint about the abrupt change that makes Git for Windows fail
> >  to build because pcre2.h is missing ...]
>
> I think it's worth it to copy/paste the commit message where I made
> this change, since we're having this discussion in this thread:
>=20
>     Makefile & configure: make PCRE v2 the default PCRE implementation
>=20
>     Change the USE_LIBPCRE=3DYesPlease & --with-libpcre flags to the
>     Makefile & configure script, respectively, to mean use PCRE v2, not
>     PCRE v1.
>=20
>     The legacy library previously available via those options is still
>     available on request via USE_LIBPCRE1=3DYesPlease or
>     --with-libpcre1. The existing USE_LIBPCRE2=3DYesPlease & --with-libpc=
re2
>     still explicitly ask for v2.
>=20
>     The v2 PCRE is stable & end-user compatible, all this change does is
>     change the default. Someone building a new git is likely to also have
>     packaged PCRE v2 sometime in the last 2 years since it was released.
>     If not they can choose to use the legacy v2 library by making the
>     trivial s/USE_LIBPCRE/USE_LIBPCRE1/ change, or package up PCRE v2.
>=20
>     New releases of PCRE v2 are already faster than PCRE v1, and not only
>     is all significant development is happening on v2, but bugs in
>     reported against v1 have started getting WONTFIX'd asking users to
>     just upgrade to v2.
>=20
>     So it makes sense to give our downstream distributors a nudge to
>     switch over to it.

I see where you are coming from.

At this point, I feel that someone should recall into our collective
memory what happened when we made a change similar in nature that broke
existing build setups: by requiring REG_STARTEND all of a sudden ("you can
easily flip the NO_REGEX switch", as if everybody should know about those
Makefile flags we have).

I hate to be that someone, but it has to be said: this is a disruptive
change, and it would be a lot better to make it an opt-in at first, and
when the dust settled about this option and many distributions have opted
in already because of the benefits and tested this thoroughly in practice,
then we can think about making this an opt-out option, potentially putting
some serious thought into trying to make it painless to upgrade for
users casually compiling Git (and not, woohoo, being subscribed to the Git
mailing list, let alone knowing about all those Makefile knobs).

In short: it would be a mistake to force PCRE v2 support on by default.

Ciao,
Dscho
--8323329-1854777249-1493804740=:3480--
