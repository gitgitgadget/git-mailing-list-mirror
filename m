Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F1BC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 23:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243667AbhLJXrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 18:47:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:58335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241232AbhLJXro (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 18:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639179826;
        bh=HwVSFaKjP57jsjOK1ONScn1S8s71jofocmsK2JzQMHY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Oda39dXIIbiT+Ci3HjBzdjcxtCNgFLzL3N4pDyTHoFFUhpAwOei8UOvy6uGzZe/lp
         J5T8suUN66zHrc15/Q0viXyPMy0yqsTkTEm54YCDBE5K/l9sfMU9KSCXm/+SZ1y4/8
         cerQSnRKRBU6E8O2OvTmTOIVTZOtsM7ouYvtF3X0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1mmzqc1DnM-008tHB; Sat, 11
 Dec 2021 00:43:46 +0100
Date:   Sat, 11 Dec 2021 00:43:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
In-Reply-To: <YbMUw70vfxJ+hJW3@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2112110015170.90@tvgsbejvaqbjf.bet>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com> <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com> <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com> <xmqq4k7nmksi.fsf@gitster.g> <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
 <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g> <211209.86fsr2l8vn.gmgdl@evledraar.gmail.com> <xmqq4k7htzpk.fsf@gitster.g> <211210.86a6h9duay.gmgdl@evledraar.gmail.com> <YbMUw70vfxJ+hJW3@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1273704495-1639179826=:90"
X-Provags-ID: V03:K1:MatJZx7UyH/mZbaZQ7sNuYfDrnWac8TfPT+v9TSDcFy0bvot46R
 5nBJ/vakjxBby6mUqBFXLelgjvfj3rK+UNsmzQ13/pmlPQqoTTE8E4TTS+OWQAoESRb9TWc
 xVOv3tlu2jaBGuy+wIWtmL52lp0LPsIVSGyh2zJLvgSQSmze01xF8x8Gr1Q+9P2sXe51Non
 K5CaB5PeZ2GfFYu4+PycQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qeRy9SLbdc4=:bFC/x4zEHRgL73fChDY8zt
 g+uVIj4peVw/kb0Y/39fOB82oSMsYCchd/p6w7e830OMNJS8hWg7uarIjHhmAQQeanYb0peQg
 YPVkoXk/W1J0Pv8Tm8JmotaotvwkciDamriltTIRmXVb/TjpiOv4mDJDBeZVyHuatySIBEsj6
 cZnsFZ9d6dHlSoUX7UlZU5prs8FjpaICq4rheTZsa5pS9yedxzgpSjwrBE+9uLrlaIcO1MgEu
 W7DpSq155xAXtIHVdwoQOXzN5fHuRyiY5/rdTCrItu847KUyj1kLeaPxUrriSqGBOofdZ3VHQ
 obZPLYPBdMckdE59Rrq/5+znD/UKyJkT3gLCySdf0Sbeqk5U+sJDQ8rJgyAc8WyEuwGRuNE2J
 3WrGSTfRqTkMHK/JTLFaku8A8gjLpPnm7Ib8YQsQHEIgOFi4DjBRP6qg9YPHRz83V1jng+AZD
 tva9ontwrUgh3SAHqWT1vJ2xWaaFkgtL67hTzWJTDs7B/2XkBqUkSCdKJYZyKzfGa2a0FaieB
 4BFT6zNmNGUPbpfHECCNYP5nuWNXspeC+TfjAsoo7WCGCSBU+LU1VnFcHEpixqqj7pnvT0Nq1
 paUyqGELKV1YtN40wwnlhvcFx04jbMjNJTCpjPmSuNCoV3ltC2V1f8ejCEsIu1I5zr4cpubXn
 R2XYXaMJm0/s4Od0uaPHPliYiiVvwYvDJYZYVKYUhwR2l77nmxNuWbfd0OLcEBh306jHDkmTK
 WE3bns4E8hLv3pMAneKvqF7CeaqhEfiCKls5z2gh5z4SauzV3LgRuZvCdDxkNKIjFAyogTfu+
 ZYJmKt8MSHTzLuqtjX9BfRxtwNC4av1J9GJwsI3lXrYhdvV0JZNmiFQ8XxsJ5h6ayiAycWlXy
 XLfBwQs+xatp0taems3iSMs88h+8Sf1RUugyr7pO8LJ2jdNdyNAio1yw6HCRpAwdVjeT4EDiZ
 U1pps2MI3iDmS+IIM7G3up6jCzjAUW+grxjDee8GTvYHZfbalwWrSZziQ/yNFLUtcNGLLTPrz
 LXkzQEMlt+Jiy1zOQA0lpwrPHsLxwCpXkLBd4btDiox5Q+ftZTcRJL21FpKtpNbOSOu7+GZMv
 Pcz49n+nQVk4XY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1273704495-1639179826=:90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Fri, 10 Dec 2021, Jeff King wrote:

> On Fri, Dec 10, 2021 at 03:38:53AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>
> > I just don't think it makes any sense that I edit say refs.[ch], run
> > "make test" locally, but only see that something broke in scalar's
> > specific use of libgit.a later when I look at GitHub CI.
>
> I'm definitely sympathetic to this. Having been surprised by CI failure
> on something that worked locally is annoying at best, and downright
> frustrating when you can't easily reproduce the problem.

I feel your frustration. Same here.

> But isn't that already true for most of the value that CI provides?
> While part of its purpose may be a back-stop for folks who don't run
> "make test" locally, I think the biggest value is that it covers a much
> wider variety of platforms and scenarios that you don't get out of "make
> test" already.
>
> In some of those cases you can reproduce the problem locally by tweaking
> build or test knobs. But in others it can be quite a bit more
> challenging (e.g., something that segfaults only on Windows). At least
> in the proposed change here you'd only be a "make test-all" away from
> reproducing the problem locally.
>
> I dunno. I don't feel that strongly either way about whether scalar
> tests should be part of "make test". Mostly just observing that this is
> not exactly a new case.

It isn't a new case.

What is new is that we are talking about CI for patches targeting contrib/
specifically to introduce something cautiously that still has a chance of
not ending up in Git proper (for whatever reasons), as Junio seems to
be anxious to not give any premature "go" to integrate Scalar fully.

In that light, I am somewhat surprised that we are still discussing
putting a burden on contributors having to adapt contrib/scalar/ to
their changes, when Junio still endeavors the option of not accepting
that to-be-adapted code into core Git, after all.

I fully expected everybody to be on board with leaving the responsibility
to keep contrib/scalar/ building and passing the tests to _me_, until the
day Scalar is accepted as a full Git command (which might not happen).

> > If I'm preparing patches for submission I'll need to get CI passing, s=
o
> > I'll need to fix those tests & behavior either way as it's
> > in-tree. Knowing about the failures later-not-sooner wastes more time,
> > not less.
>
> I think there's probably a tradeoff here. How often you get a "late"
> notification of a bug (and how much of your time that wastes) versus how
> much time you spend locally running tests that you don't care about.
>
> I do agree that CI presents a bit of a conundrum for stuff at the edge
> of the project. It's become a de facto requirement for it to pass. In
> general that's good. But it means that features which were introduced
> under the notion of "the people who care about this area will tend to
> its maintenance" slowly become _everybody's_ problem as soon as they
> have any CI coverage. Another example here is the cmake stuff. Or the
> recent discussion about "-x" and bash.
>
> I wonder if there's a good way to make some CI results informational,
> rather than "failing". I.e., run scalar tests via CI, but if you're not
> working on scalar, you don't have to care. Folks who are interested in
> the area would keep tabs on those results and make sure that Junio's
> tree stays passing.
>
> That view disagrees with the final paragraph here, though:
>
> > The reason we do that with the completion is because some changes to
> > e.g. tweak getopts will need to have a corresponding change to the
> > completion.
> >
> > The reason we've not done that with contrib/{subtree,mw-to-git}/ is
> > because those are thoroughly in the category of only incidentally bein=
g
> > in-tree.
> > [...]
> > Scalar is thoroughly on the "completion" side of that divide, not
> > "subtree".
>
> I haven't followed the discussion closely, but in my mind "scalar" was
> still in the "it may live in-tree for convenience, but people who aren't
> working on it don't necessarily need to care about it" camp. Maybe
> that's not the plan, though.

I had hoped for a clearer answer from Junio where he sees Scalar in the
long term, for now he seems to be undecided.

As a consequence, I kept targeting contrib/scalar/ with this first patch
series, to leave the door open for keeping it in contrib/ as a "not
maintained by Junio!" part of the tree.

That is independent, of course, of my intention to keep maintaining
Scalar's code (once we get a few steps further, that is, because we're
still quite stuck here, the Scalar patch series has not seen any concerns
in the last half dozen iterations about its design nor about its actual
code). I intend to keep maintainig the Scalar code no matter whether it
lives in contrib/ or whether it will be turned into a first-class command
whose source code lives in the top-level directory.

So yes, from my side I do not understand at all where this notion comes
from that contrib/scalar/ should be treated any different than
contrib/subtree/ for now. At least until contrib/scalar/ is
feature-complete, that won't change.

But of course, we can keep discussing back and forth the build process of
Scalar, whether it should be tested in CI or not, whether it should be in
contrib/ or in the top-level directory or not in Git at all, without
getting the Scalar patches anywhere, for the next few years, in which case
the outcome of that discussion will be completely moot because the Scalar
patches would still be as stuck as they are right now. In which case it
would be super annoying for any contributor who had to adapt the code in
contrib/scalar/ to code changes in libgit.a, for no value in return
whatsoever. So far, that contributor has been me.

I sincerely hope that it won't come to that, and that we can move forward
with this here patch series, with the next ones I have lined up to make
Scalar feature-complete, and _then_ discuss the merits of making Scalar a
first-class Git command or not. At that point we will automatically have
the answer whether to build Scalar and run its tests as part of Git's CI.

Ciao,
Dscho

--8323328-1273704495-1639179826=:90--
