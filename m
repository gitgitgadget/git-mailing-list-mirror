Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCB3C64E90
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 12:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A7F206E0
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 12:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TsZhTESa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgLAMcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:32:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:53051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbgLAMcu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 07:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606825878;
        bh=QlQJPn6vii92RprlhceIeZiSQKpW3+pT1zYGTh8ocSU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TsZhTESaz/CYjxXSXmjBRzkJCNsQnBzHx8zR9gB7U9PEbMR71HtWtb7gn7vxByWOr
         kWgHX6mcIaOOq9Y+qYyaBohn9Y4kVuB61yl9N1mM1LLI2KP5vMuUCI2qNNjXi7OCN/
         yXnyGNOIfe80rA6NRFMXMhwFHdVBi2wfB9bkC/kQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([213.196.213.207]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKFk-1ksI1X41Tu-009SLM; Tue, 01
 Dec 2020 13:31:18 +0100
Date:   Tue, 1 Dec 2020 13:31:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/2] make macOS `git maintenance` test work on
 Windows
In-Reply-To: <CAPig+cT-axeG3UrxaQR3c+r7dMZkjmS19C3cHRVzu5KSc72BOQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2012011303210.54@tvgsbejvaqbjf.bet>
References: <20201130044224.12298-1-sunshine@sunshineco.com> <87blffjkne.fsf@evledraar.gmail.com> <CAPig+cT-axeG3UrxaQR3c+r7dMZkjmS19C3cHRVzu5KSc72BOQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-272819732-1606825878=:54"
X-Provags-ID: V03:K1:3bhPFi4zrb4CX3yXtJuoe3OzKK/KLCoS/r2i/Hle+Y3soGhXlGD
 KsazIfMpncT/0G6q3c5KPl5UBjLN0TjRXpBsJjKulIlO63SabDFeJ5Rls8EzM9DFmlzSpiM
 N7ylVX2A8duLr/rZufhbwS9fJCdDIHsqXry0d25fMnO6D54DBcZ3ctR1SE6CzoQFfQ5Qew/
 lYBObfJkQJ116W8Rofo8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L4e+XM2KI6Y=:Wr3YENoa7BrP31toJkWKzm
 M5/pIJm8Sl0KWhypByWAG7NjLjZj3g4asyajiwijRtobU1MMc0Mc1sG10V47VtrYYGAIHOdY0
 0lGWv1uANAe6B/Fba94svFg9KypbhKmU5Vopbdf4jhjdQtEmwB8W4SUPrWL6G8tF7b5V59PF6
 5mCm+sfu3iIh9C1/yhVB+dhtUuB3zhOdsLzzS3stBsCJpcKSdpUO71PITKRiw10r+EvNldsMY
 nUU2boeh+KKI14z0hjuluUWYT05KHrau/vVgdBXeSWc1zUGPdC7gQQ8dz3Q1LjdA0/oEfnZTD
 YEUE+4z9U2DszqGqKaqBb+TWIPmjPrltMfj1VX3N8B0rgdS6IIsZ313TRVwY5xwoMMIxukR3A
 +qyYwQuu00Dwb3G8RHH0R/d/auBDv+9NixY40b30psbjGax8uGxtWS+cnG+7rdEtSW9bNCZ6X
 RHPjh+b2XW1Jy7jEB4dtO7lRUA3tT6mAyNl8ROyB0CkXAK4Pyb7gRPQU3zyIcnX99+i6Hts4j
 frbRHFG7CYluURsY/okc8QclG4H9kUZfGtyFOq13L2QH6Klm57ng8/IwQFiTjvrY3Q8X4KjpJ
 TmpRlXcTnsontqw+hs1Pf3P2Nod+C0l62TSGz6E4Dtrl0LI33+YXo5QuyoJLckKP2ZeII1RL/
 vsE3VmHGJdjAf6642zPAadKJ0Ji5A7mhPYqKjNkRRgASL/E1+wTtH0o/GhSYizro89X35YmPF
 3/t86hFw25e9r0W52VNKWjMpJTeHFgP03euK9XtYj2oBg+CmyyBzsfsL6sN44b3NSf058weYf
 0zSedMBW7o62dWlDM11Ywks5tkyq6fvGqJWe3euLs3+boFM6/hmG/nBNbYrhMJpDjXngJ7tMr
 OkguBUGHpm90PGj9TScRE1Y5mNut7Xmd2t+BoucXM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-272819732-1606825878=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric & =C3=86var,

On Mon, 30 Nov 2020, Eric Sunshine wrote:

> On Mon, Nov 30, 2020 at 4:20 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
> > I did wonder "why not just call perl -e 'print $<' ?"  first. But then
> > found (by reading the Perl source[1], didn't actually test this) that =
it
> > fakes up UID=3D0 for everything on Windows.
>
> I totally forgot about Perl's `$<`.
>
> Under the Git for Windows SDK, Perl's `$<` returns a large positive
> number. I suspect this differs from what you saw in the Perl source
> code because the Windows-specific code you looked at does not come
> into play in this case. For Git for Windows SDK, Perl is almost
> certainly instead built in Unix-like mode, linking against the MSYS2
> library for its POSIX-like emulation, thus the Windows-specific Perl
> goop is not needed.

Correct.

> > I couldn't find any "is root?" in our tree that relies on Perl's $< in=
 a
> > bad way (the couuple of occurances seem innocuous), we have some "id -=
u"
> > checks, but those also seem OK if it returned 0 on Windows (what does =
it
> > return?). Seems the worst we'd do there is unintentionally skip some
> > "skip this as root" tests.
>
> Under Git for Windows SDK, `id -u` returns the same large positive
> number as returned by Perl's `$<`, which makes sense since `id` is
> also likely linked against the MSYS2 library.

Correct.

> > I know Johannes (CC'd) has (this is from wetware memory) wanted to
> > (understandably) not need to bother with Perl as part of GFW, but I
> > can't remember if that's for a reason covered by NO_PERL=3DYesPlease,
> > i.e. packaging it up, or whether it's also to not wanting to provide a
> > perl for the test suite.
>
> I _think_ that was for the NO_PERL=3DYesPlease case, but I expect Dscho
> can answer more concretely.

I assume you're referring to NO_PERL being set in the CI builds on
Windows?

There were two problems we tried to address via setting NO_PERL: MSYS2
problems on 32-bit Windows (where the `fork()` emulation would frequently
run into DLL base address issues due to the limited address space combined
with the requirement to keep the MSYS2 DLL at a _fixed_ memory location),
and speed.

We no longer run the 32-bit Pipeline, saving a couple electrons. But speed
is still a major concern with the automated test suite. Just have a look:
https://github.com/git/git/actions/runs/393089617 shows the `linux-clang`
job running for a little over 27 minutes, and that includes the build and
two test suite runs (taking 12m08s and 12m41s, respectively). At the same
time, the Windows tests (_not_ including the build), split into 10
parallel jobs, take between ~8-13.5 minutes to run (granted, there is a
1.5 minute overhead in each split job to download and set up stuff). And
that's _skipping_ the test cases requiring Perl, or GPG, or Perforce,
etc...

Perl is slow. Even on Linux. Running t3701 with the scripted vs the
built-in `git add -i` shows a stark contrast. See for yourself:
https://github.com/git/git/runs/1478012705?check_suite_focus=3Dtrue#step:4=
:994
says that the scripted version took just under 25 seconds, while
https://github.com/git/git/runs/1478012705?check_suite_focus=3Dtrue#step:4=
:1908
says that the built-in version took just over 8 seconds (this is the
`linux-gcc` job that runs the test suite twice, 2nd time with
`GIT_TEST_ADD_I_USE_BUILTIN=3D1`).

And that's on Linux.

On Windows, not even running any other tests in parallel (i.e. unlike the
`linux-gcc` job), the difference is 1m23s vs 39s on my beefy laptop.
That's how slow Perl is.

Imagine how much faster the entire test suite would run, for every
developer, if we didn't use Perl (nor Bash, for that matter). This is not
theoretical. There were, and are, instances of contributions which
obviously did not run through the test suite before being submitted. I
suspect that it simply takes too long.

Ciao,
Dscho

--8323328-272819732-1606825878=:54--
