Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C2C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 00:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbhLKAda (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:33:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:39055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244279AbhLKAd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 19:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639182586;
        bh=6BAnaJsucPxGodzI0Kq8INHZFuu1JbdRnI7VO4MxndY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hS7yal0xWyaYKozQjHFjbUnO/cBX2ppRK4FkcQ1O3hXbjyrkJoGH0yINORTNjIvLu
         WL6Oj9pBVrVA4n9UvNzN/HNYMJ7CrBpxbbGgEEPP1ej2MDqDzw+zMTOu59y3dbkh9M
         J3xTtT2E0sqlun0qFQNES5h0tHVsD5CxVZ3PM5No=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1nEl612c7H-00Kk9O; Sat, 11
 Dec 2021 01:29:46 +0100
Date:   Sat, 11 Dec 2021 01:29:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
In-Reply-To: <xmqq8rwuv3i2.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112110044010.90@tvgsbejvaqbjf.bet>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com> <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com> <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com> <xmqq4k7nmksi.fsf@gitster.g> <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
 <xmqq8rwuv3i2.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-181199005-1639182586=:90"
X-Provags-ID: V03:K1:mRIlMlWNhEAcEKJJVFP7Vcshc7fXVZt2PXFNQ6GV3AZUu+DrOBU
 /0fO4uGQ4uMfs+HFQSkfit1NT07ZyDnwcEBSetFJ2BggnsslyyNm/55+5COLt0R576wDSKw
 pMSm1vb5ozWeRhwSlsQsmoPLqKuRylOF8ReLdd6Niflzar+Yi4/YvEpg9+j/Wt0TZ9aZrkp
 g2Pzs16/6bfkPAaB5mBGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:br9/uBAYUgU=:aBWRpfcPGE5l5k5Wm9WFhj
 dQYFrwdDHZy86vXV8exSAeFRqTYaT1E/c9JTM7+llnNYdxFl8P9gHQbQXL5ybsuSoGUiP9fRy
 /mCeo0Cp/wCJse1+0TeKGI7fGzvdbTxDe7T7duxQlDFjt9mmYGWzUE1dN3hEJXyAB9kY3kdjq
 sV3BZPdO4Bb3kK4fZHC1d80J0mSLMeOyyybsEcUMzXXfmfom4RgydBntcfoD1Dm4uCPNuPeTM
 CJQYEu3xm2QRJwjSPP1MWDs8tFNabe5j7zY5FM16UBiqeo9y2O5RcvfaM4xX9UDoxVd8moo+v
 /UeIEzJG9MZ3WYAuyWp2GDqrO5OPphyGfDFB07u54GmLnTcWq60ynVgYs5Q4/1qLPhGAPxg3j
 /hBNHHgU7lhMrCNcz6jNPrLe733dUBC6RjuR0T5KiyARIS55DwKAUYPCCYT/ZqPaQ80nMkP9k
 eXTaH7BtEIFhljAx162OviG+k7JLrcxu6eK2tJ0gaV7rjiDqCje8hO0cGVD0thZrGaMHmEv1z
 /r35kBXB6Wfu2/A36QGJTIKOHMeUIfRKBs6J7OnWmdalRxQwtxkcuQO3Cwq0kGU6o8AWKbxOg
 AJSquL/gahCcDdvU8b+DEu1un83cYp/RiKx2e9S9bf51Ndw1wXtc+dxdGuwHO/N9L5mGAHRFz
 AMY/04zvTUll1ZrD1gWZGIv8BNn3r/gADmivhQV1y+21NR1Oi766QkIUpWmP/SXzdK8DQc54s
 C+3moF65ofyH8HXn54K5P9lGNK4A1pVORNHAkDwWcZ9OmsKJw/hgQylCRou6L8law6SgqoIII
 cck0pZVOTymW4MgJ7E4m/FKMcUBrT+5Pcs+rPbT0FNhPGI0WPasUdVz6992qMcSguI1ngykGc
 jc4MtfA85BYnjvk9iuggffE60U/58E/L7TutjiepRkl65RNvcBYoCriLsp00QyLP78jH9U4FA
 bNg8WIIRrlnVrF82n9/gL05Lq017W9LyUA4gjVT50E/C0Tb492E/Ir/rqNl0a+offux9nVD7l
 OuopT17XBdZE/DnkX/iiVNL2EDlGyexSZfunBpMXaxYbuRSQh9mhAr07mgyH2CoYngASulkPx
 u36ZC6lprUtGAE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-181199005-1639182586=:90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 8 Dec 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > The Scalar Functional Tests were designed with Azure Repos in mind, i.=
e.
> > they specifically verify that the `gvfs-helper` (emulating Partial Clo=
ne
> > using the predecessor of Partial Clone, the GVFS protocol) manages to
> > access the repositories in the intended way.
> > ...
> > I do realize, though, that clarity of intention has been missing from =
this
> > mail thread all around, so let me ask point blank: Junio, do you want =
me
> > to include upstreaming `gvfs-helper` in the overall Scalar plan?
>
> Sorry, I do not follow.

In
https://lore.kernel.org/git/CABPp-BGpe9Q5k22Yu8a=3D1xwu=3DpZYSeNQoqEgf+DN0=
7cU4EB1ew@mail.gmail.com/
(i.e. in the great great grand parent of this mail), you specifically
replied to my mentioning Scalar's Functional Test suite:

	> > One other thing is very interesting about that vfs-with-scalar
	> > branch thicket: it contains a GitHub workflow which will run
	> > Scalar's quite extensive Functional Tests suite. This test
	> > suite is quite comprehensive and caught us a lot of bugs in
	> > the past, not only in the Scalar code, but also core Git.
	>
	> From your wording it sounds like the plan might not include
	> moving these tests over.  Perhaps it doesn't make sense to move
	> them all over, but since they've caught problems in both Scalar
	> and core Git, it would be nice to see many of those tests come
	> to Git as well as part of a future follow on series.

I had mentioned a couple of times that I had no intention to move Scalar's
Function Tests into contrib/scalar/, and your wording "it would be nice to
see many of those tests come to Git as well" made it sound as if you
disagreed with that intention.

But it was not a clear "please do port them over" nor a "nah, we don't
want that test suite implemented in C# and requiring, for the most part,
access to a dedicacted Azure Repo".

Hence I was asking for a clear answer to the question whether you want me
to spend time on preparing a patch series to contribute Scalar's
Functional Tests to contrib/scalar/ as well.

I _suspect_ your clear answer, if you are willing to give it as clearly,
to be "no, we do not do integration tests here, and besides, C# is not a
language we want to add to Git's tree".

> What I was lamenting about was the lack of CI test coverage of stuff
> that is already being considered to go 'next'.  Specifically, since
> contrib/scalar/Makefile in 'seen' has a 'test' target, it would be a
> shame not to exercise it, when we should be able to do so in the CI
> fairly easily.

We do have a very different understanding of "fairly easily" in that case.
Three iterations, and three weeks time spent on implementing what you
suggest, only to see broken by the merge of the `ab/ci-updates` patch
series, suggesting a fixup for the incorrect merge, seeing that fixup
rejected, and then more discussing, all of that does not strike me as
"fairly easily". It strikes me as "a lot of time and effort was spent,
mostly stepping on toes".

Granted, if `ab/ci-updates` would not have happened, it would have been
much easier. Or if `ab/ci-updates` had waited until `js/scalar` advanced
to `next`. But the way it happened was (unnecessarily?) un-easy.

> I fail to see what gvfs-helper has to do with anything in the
> context of advancing the js/scalar topic as we have today.

Okay, okay! I was just asking about gvfs-helper because that would be
required to port over Scalar's Functional Tests. The same Functional Tests
that I heard you mentioning would be "nice to see" to "come to Git as
well".

> If "The Scalar Functional Tests" that were designed with Azure Repos in
> mind is not a good fit to come into contrib/scalar/, it is fine not to
> have it here---lack of it would not make the test target you have in
> contrib/scalar/Makefile any less valuable, I would think.

The test target won't go anywhere, no worries. Just like the test target
in contrib/subtree/ does not go anywhere.

And just like `contrib/subtree/`, it does not have to be run as part of
Git's CI build.

> Unless you are saying that "make -C contrib/scalar test" is useless,
> that is.  But I do not think that is the case.

It is as useful as `make -C contrib/subtree test`. Which, as =C3=86var wil=
l
readily offer, is broken, because it does not ensure that top-level `make
all` is executed and therefore in a fresh checkout will fail.

Of course, I disagree that it is "broken". It works as designed. It is in
the contrib/ part of the tree, i.e. safely in the realm of "you have to
build Git first, and then the thing in contrib/". In other words, the idea
to "fix" this kind of "broken"ness is a solution in search of a problem.

And as I have said multiple times, I still think that having Scalar's code
in contrib/ is a good spot to experiment with it. It sends the right
signal of "this is not really something we promise to maintain just yet".
It is a logical place for code that developers can build themselves, but
that is not built and installed with Git by default.

Having it in the Git tree will give interested developers a chance who
want to clone a large repository on Linux, without having to touch
anything with "Microsoft" in its repository name.

Having it in the Git tree will give interested developers a chance to
experiment with things like "let's try to let `scalar clone` _not_
clone into `<enlistment>/src/`, but instead create a bare clone in
`<enlistment>/.git` and make `<enlistment>/src/` a worktree". Things like
that.

I would find those things quite a bit more useful than to force regular
Git contributors who want to change libgit.a (even if it is just pointless
refactoring) to pay attention to contrib/scalar/ in CI, when there is
still no clear answer whether Scalar will even become a first-class Git
command eventually (which I hope it will, of course).

Ciao,
Dscho

--8323328-181199005-1639182586=:90--
