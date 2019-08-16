Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF441F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 20:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfHPUTt (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 16:19:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:51465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfHPUTt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 16:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565986784;
        bh=h/nRC3umJ30UNhMDlDJvFdGLPwI4Gn1nN2ouwiWXtCs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Hh9KCkKJOLR2KwMqc6iM/t9PnxjhJBdta3LsaLWrAcTZ+sCcohWSQjMr6IFivogTS
         b4e7273UlrrmsdQegcIHW9TuoTaG4ZqOcjKc3uDQKueYHRbl1FE0fQ54yG4QUty3gU
         b1B347vu9DTo/8cfcZE09qZxRz+ioVtYuD0V7YJY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.63] ([77.165.132.136]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyzW8-1iKyXY1nLU-0149QW; Fri, 16
 Aug 2019 22:19:44 +0200
Date:   Fri, 16 Aug 2019 22:19:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
In-Reply-To: <20190815222427.GC208753@google.com>
Message-ID: <nycvar.QRO.7.76.6.1908162204380.46@tvgsbejvaqbjf.bet>
References: <20190815023418.33407-1-emilyshaffer@google.com> <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com> <nycvar.QRO.7.76.6.1908152205390.46@tvgsbejvaqbjf.bet> <20190815222427.GC208753@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ORd9LiOJLMMkTtT9jccAKuFC6l158SVFdE7tqpKpVEf7Yu9F7xs
 rrRRDRnabczN4kI0u1DQqlRm3Hq21WWT5yG+QE2GPbz764p8kpS0yIuqrkPoBu72eQj4g4g
 jcvv5vFfWaXS7jvAm1yiua5Fz0esgIUz3TJ6wtowd0yvv5WlbK6/wb8NNSQ1yVi335uCy9v
 pwDKVdba11FL2WQ4pEkCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CjxCKpNdIkM=:tOlmR19bSOj4cZy0tsJPl7
 B0NGgZpVrV4IlcJ+4G0Dq01Apqw8ZjZ7PwNOTnFqcbuigLTdCQAiw4VTvR3dQbpyR+VOIghYY
 v0DEf0okVTIdaQQ3vfxqCTh5N8qmGSTinF6SZ76DS3M7fZ33vF2heldObAvouiYlnzYbEJ1yj
 q93ZLIEL9yIT3dY9NCq1nirruqfCTyx4fnGjQ6qQIk5dorIBpAkzbDKkKl5BZXyQjj0mbuOE0
 uSirYdLrJvbuhzGCgpsXMvgL0N2AEuVi9XcNhGCKp0KxoOTeqvfd/cVLWTWMiVvr0v5Fn2HkA
 IUdtukfqYp+jZ9AK+JOnBhhEYoNNShRefWDTtVa0WESjPxAsBpx9kW8Bqiy0i8i13TpL5Aq0k
 027EXziRRzO8SWPvJ0PwW5F2w+ej0PffTAV2DNY608A+GztgZSCJKfj08EnYtlagRGBap8z+C
 qNLBRkpfee+2SRm5/ud6R35DwKSbsF7MvlX6XMVmKZG7x3/H0MuHo7G/XiMuA+AOhFNBRf9zd
 twpSR4Jor35NhVevuo0h48KnaTn2KIxkNsQwxVNfU7M7uSMHNueOPjEwSYcGB+5Gn4TAQfmf8
 vA0gSLV2P3CLZAZGhiwS7C4x8E8Hjps3rNHK6IMPyO6zpqzbgEwfGskW/1RpvKK18ZHPYeclS
 70kHsHgxdQBmqMtgfuorA9vR+U44wcB5EZt3pQbprLoMpLmnCPRs+v1xSR4osRLwfFNYHRuAZ
 JgBruG8PwKoer0XvxAQH7uuWiI2Yk6hAJxXwRp2MuXIrRXMajCE5D2r6V92mtgPGIyjS5HGHI
 V+gfbLncx3xIujzVSeNppnYSq879b3Q2tN0Jvh/24MV3f546VzJYoJx9hWk7c7N8qrXycbdj7
 JHHuCp+N4DFahW+K7RhdHzubVc6qVtd1OaqVSUS78sq1ya0+VTERDidJuFuDOuHAvoZSTG9nc
 f1t86Dj0FRdQTPEMM0hfEySqU2PpVFunsej+lGCeFHk7KXUUN5YPE8Wka/zyLZJyR6xXz64Ew
 pYLxUWYjqTyTC7XJrwzw0c05TibPkzmDtwMyZIb6VwXfR8IU0YNGSgdVF+69nG7J2oiMzenjU
 T4k6Du0qlyx5CuLQ4Q7LUZhy1Twg1Dgwq5pdMFVLOXgWj8LYxT4B7gUwbxxpBKnzlI2owbmtn
 gGynQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 15 Aug 2019, Emily Shaffer wrote:

> On Thu, Aug 15, 2019 at 10:07:57PM +0200, Johannes Schindelin wrote:
> >
> > On Thu, 15 Aug 2019, Derrick Stolee wrote:
> >
> > > On 8/14/2019 10:34 PM, Emily Shaffer wrote:
> > > > diff --git a/git-bugreport.sh b/git-bugreport.sh
> > > > new file mode 100755
> > > > index 0000000000..2200703a51
> > > > --- /dev/null
> > > > +++ b/git-bugreport.sh
> > >
> > > At first I was alarmed by "What? another shell script?" but this
> > > command should prioritize flexibility and extensibility over speed.
> > > Running multiple processes shouldn't be too taxing for what we are
> > > trying to do here.
> >
> > Git for Windows sometimes receives bug reports about Bash not being ab=
le
> > to start (usually it is a DLL base address problem, related to the way
> > Cygwin and MSYS2 emulate `fork()`).
>
> Hmm. In a case like this, then, how is someone using GfW at all?

On Windows, there are native command-line interpreters available that
are _not_ Bash: PowerShell and CMD.

These days, you can get away with using Git _without_ a working Unix
shell most of the time. There are only preciously few commands left that
are still written as scripts, and most of these seem to be used less
often than one might think:

	- submodule
	- bisect
	- filter-branch
	- instaweb
	- mergetool
	- some uncommon merge strategies
	- rebase -p (already deprecated)
	- several CVS/Subversion/Arch/Quilt integrations
	- send-email (only relevant for mailing list centric projects,
	  again, not very common any longer)
	- request-pull (I would not be surprised if this is specific for
	  the Linux project, as if that project was even close to the
	  main user of Git)

So as long as you don't use submodules, and as long as you are unaware
of the `bisect` command, which would comprise the majority of Git users
in my experience, you can totally use Git for Windows without using Bash
or Perl, i.e. without using the Cygwin/MSYS2 runtime that seems to be
one of the common causes for trouble in Git for Windows.

> Embarrassingly, I don't actually have a way to try it out for myself.
> It seems there's no GUI, and users are using it through the command line
> in mingw, so when you say "bash doesn't start" do you mean "users can't
> use the mingw prompt at all"?

There is no MinGW prompt.

MinGW stands for "Minimal GNU on Windows", but it really refers to a way
to compile native Win32 programs via GCC. Meaning that some of the POSIX
functionality Unix/Linux developers have come to expect is unavailable.
For example, `fork()`. Which means that there is no native port of Bash
to Windows, at least not that _I_ am aware of.

Git for Windows comes with a "Git Bash", which is essentially a Bash
built against the MSYS2 runtime (i.e. it is much more like a Cygwin
executable than like a Win32 executable).

The common way to run Git for Windows is actually via `git.exe`,
independent of what particular command-line interpreter you prefer.

> > In such a case, `git bugreport` would only be able to offer a reason f=
or
> > yet another bug report instead of adding useful metadata.
> >
> > Something to keep in mind when deciding how to implement this command.
>
> Yeah, that's an interesting point, thanks for bringing it up. So, in the
> case when bash won't start at all, what does that failure look like? How
> much of Git can users still use? For example, would they be able to get
> far enough to run a binary git-bugreport?

See above.

If I were you, I would not write `git bugreport` as anything but a
built-in, written in C. Unless there are _really_ good reasons not to
[*1*].  And quite honestly, I don't see any such reasons.

Ciao,
Dscho

Footnote *1*: One good reason to use the MSYS2 Bash would be to be able
to use MSYS2's POSIX emulation layer, e.g. to talk to the SSH agent
(that is also an MSYS2 program, meaning that it communicates via
emulated Unix sockets, which is a facility not available to native Win32
programs).

Another valid reason to use the MSYS2 Bash is to be able to talk to the
(emulated) pseudo TTYs provided by the MSYS2 runtime, e.g. when running
inside a MinTTY window, which is the default for Git Bash in Git for
Windows.
