Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C00BC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 09:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLHJ3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 04:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiLHJ3o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 04:29:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6091ADAC
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670491759; bh=Apgo10QomMv5UqLm6smUmt3QA5QShoMvZsPOR4K5jJc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=mSJ5kKJbJWpK2kkZEGwrCIsRd6Xub7gY9pj+fT6E/yVqbkOOXokrUUYiMIN3H3M0X
         3q5dhXEVKNO9Thndbly8oBT4mcTIoNOkon9VbFz3pXK0iw0pgKXOBMnxRquUKMI8AC
         QN9gzq/2LN4dJsP51Z2SWALnODwc64ElT/OqFAECPVKTetq8XjQmSqHX8OfcszNRjf
         penNjgg3Ija3YjTPy4pw8ikNszd+gwb8xm3ObN3IMV6MS+tc9DJxwHCo/7uZUv6Tf/
         MdYL5HYFc4uUkUc6pGR2FkjPK2nBjEnqmZYcUqvg2RwWgACkelGiS09rP57wTklHEp
         C4ngsP/M61GhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.24.155.134] ([89.1.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1ovgAy2eM3-011iIJ; Thu, 08
 Dec 2022 10:29:19 +0100
Date:   Thu, 8 Dec 2022 10:29:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: ab/cmake-nix-and-ci, was Re: [PATCH] test-lib.sh: discover "git" in
 subdirs of "contrib/buildsystems/out"
In-Reply-To: <221206.865yeodbtg.gmgdl@evledraar.gmail.com>
Message-ID: <oq7p2776-po8p-r9s0-82o2-o77so874n419@tzk.qr>
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk> <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com> <xmqq5yeuspam.fsf@gitster.g> <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk> <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
 <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net> <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com> <Y45/8WnuUnP9gOMo@nand.local> <Y46clyoKk9KzFiqj@coredump.intra.peff.net> <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com> <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
 <221206.86mt81claa.gmgdl@evledraar.gmail.com> <xmqqilipnq8j.fsf@gitster.g> <30360f4c-91a5-177b-133f-eb7036ed676a@dunelm.org.uk> <221206.865yeodbtg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1461207428-1670491759=:3015"
X-Provags-ID: V03:K1:Q7UtEl+syMnTL/aL1FLXV6VfySwyYlgoKWjvKBehleSrHoKqaPb
 OR06jbZwdW+vaLfaCHGjV2rwqPIPD+XWkHktBGwt44NXsHEAy+7iS38LCyqz0Mb2xH3rcpZ
 M5p3WmT8QgTLCOnAAVJmNcvTKMaGGHp+rXiYg0prvsToqmBwJbl7/MGWeJMmQxKQOscyhvZ
 vRZV63j8Q5zGApe5ynuFg==
UI-OutboundReport: notjunk:1;M01:P0:VBDljENRvwY=;NmdLz0BsDWnAds75AsB83T8FbRK
 eAcLdhob+JgOlbB+0ujJsoBfKbi+sAVbQLXrK+aepoayKWHj63ajkr+oXfaW6h4vRaRjc21sA
 p9Z9+p0/GJC/aaAYiTycco3vfGeZpdidCllKsvRqOIBPrwFClmSQ6g20U/FUgE9x+l545HDjm
 vwksL97IqKcE3irDDdSinsgAX8XX0Hqr0roxXfficsqU4nJzgxaqXKXsZys7Q/MyINtcYt9Eg
 0te+XwXbkCgkVm5FLfD9c3z7NVJOEej9qM9RGx+Vv7028B14EJKX3rMGXVBzGsP4yDroJ+NjT
 K60wPugGz4pfRCRsbnO28tUuyxRK8000qphBm4tBJaSPkTNrtr6F8Mkk6YmX6LL8tXDSjzvVU
 e3Z0fTOCohI+Ds2Q/FhFgfAq3XbEG0IMAxQJ0ij+hU2vXeUETJ6RN+vg7A9AJrAO5bdX9oXL2
 BcK8KQ/ySFSrW8WZiqZNuAXAoC7Y/3S0rpagB1cgxDdWw0cPpuc5QJoPue/lpr1XOobcmWBe9
 skbsMHlwXA7Q01sDEIwcnPvS2lZwrimCgkfHrViXBkX0HN4VYE6FC6DJbiilL2HuAGBd+p8ID
 L+5K8HrLUqe6iBJXB1weyuyeQOOtBScEfxLJkO1nd1HzQLyfzTYVVQZrsOPyVHP38VgNlrT51
 mSnvbDjHdeMEvd+nAW8fRZS9kF7bkmUvAZyV1fuJwmLsmeo3pIVDvH6PuknExi26/C/d00o8P
 edR217oEJJ54rF8MwfDVbDJexHaWYkmJtJKANqyeG6OEeKjmndH94q7ZSPjEhij9ukBAw6/bs
 nfuUGSqv/vrg8ltwXSdx/cD6PBMY6hs3cryC6dpUrBC6RBYcWAxLI3h8tVFtn2N+VFZMtMqvj
 OToB8FaSFchyQYezBVM3M1Ma8fQ0gekb1s1kjizoroY6x9zGWeFBqsHyt6TxWI9NY/GZ+nLiq
 skJlhA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1461207428-1670491759=:3015
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 6 Dec 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Dec 06 2022, Phillip Wood wrote:
>
> > On 06/12/2022 03:52, Junio C Hamano wrote:
> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >>
> >>> Just to add my own digression: I asked in some past thread (which
> >>> I'm too lazy to dig up) why it was the cmake file couldn't just
> >>> dispatch to "make" for most things.
> >
> > Because make is not installed by default on Windows. Our CI job uses
> > msbuild (whatever that is) and when I was playing with Visual Studio
> > last week it was using ninja.
> >
> >>> I.e. it needs to at some level be aware of what it's building for th=
e
> >>> IDE integration, but for say making a "grep.o" there's no reason it
> >>> couldn't be running:
> >>>
> >>> 	make grep.o
> >>>
> >>> Instead of:
> >>>
> >>>          cc <args> -o grep grep.c [...]
> >>>
> >>> which requires duplicating much of the Makefile logic (possibly with
> >>> some Makefile shim to not consider any dependencies in that case).
> >> That leads to a question at the other extreme.  Why does any logic
> >> in CMakeLists.txt even have to exist at all?  Whenever it is asked
> >> to make foo, it can be running "make foo" instead of having its own
> >> logic at all.  ;-)
> >
> > Yes, if make was available then we wouldn't need to use CMake.
>
> I think Junio and I are talking about something slightly different. Yes
> "make" isn't available by default. Getting it requires installing a
> larger SDK.
>
> But if you look at the history of contrib/vscode/README.md in our tree
> you'll see that we used to support this "Visual Studio Solution" for
> years via GNU make, it probably still works.

It probably doesn't. Last time I had to use it, during the embargoed
v2.37.1 release process, it didn't. I had to add plenty of patches to make
it work again:
https://github.com/git-for-windows/git/compare/323a69709944%5E...323a69709=
944%5E2

> The change in 4c2c38e800f (ci: modification of main.yml to use cmake for
> vs-build job, 2020-06-26) shows when the CI was switched over to using
> cmake instead.
>
> The code to support that is still in-tree as the "vcxproj" target in
> "config.mak.uname", which calls out to the ~1k lines of Perl code in
> contrib/buildsystems/Generators/*.

At some stage we can probably get rid of the `vcxproj` code. Before that,
we can even get rid of the `vcproj` code that is bit-rotting in
`contrib/buildsystems/`. But there seems no harm, and less maintenance
burden, in keeping the `vcxproj`/`vcproj` parts where they are, as they
are.

Taking a step back, I see that we got far away from the topic that started
this thread.

So here's my take on `ab/cmake-nix-and-ci`: While that patch series'
intention is apparently to make it easier to diagnose and fix CI problems,
I only see that it adds new problems. It won't make it possible to
diagnose most win+VS problems because they don't reproduce on Linux. But
the patches already did introduce Windows-specific problems merely by
trying to get the Linux side of CMake to work. And trying to keep CMake
working both on Linux and on Windows would cause many more problems in the
future. And we do not even need CMake support for Linux, `make` works well
there already. It would increase the maintenance burden unnecessarily.

I am therefore suggesting to drop `cmake-nix-and-ci` entirely.

To address the concern about broken CI runs, I hoped that monitoring them
and helping contributors by suggesting fixups was working well enough. It
used to be okay for patches to be contributed that caused CI to fail, we
simply worked together to fix CI, as a team, and that was that. We didn't
"blame" the contributors, or anything, when CI runs failed because of
their patches. After all, possible causes of CI failures include that
patches might be applied on top of other commits than intended, or that
patch series interact in unfortunate ways.

Junio, maybe you could clarify your take on this? As project lead, it is
your decision to define how Git uses Continuous Builds, and how the
project handles failed CI runs.

Ciao,
Johannes

--8323328-1461207428-1670491759=:3015--
