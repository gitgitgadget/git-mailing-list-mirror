Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D8D20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdASVay (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:30:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:60009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdASVax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:30:53 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJFBe-1cX5Rv1wk6-002p52; Thu, 19
 Jan 2017 22:30:45 +0100
Date:   Thu, 19 Jan 2017 22:30:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Marc Branchaud <marcnarc@xiplink.com>
cc:     Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Subject: Re: [RFC] stash --continue
In-Reply-To: <aa8104ad-45f4-7bef-f199-6e6021cf0c06@xiplink.com>
Message-ID: <alpine.DEB.2.20.1701192220320.3469@virtualbox>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net> <alpine.DEB.2.20.1701161153340.3469@virtualbox> <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com> <alpine.DEB.2.20.1701181725130.3469@virtualbox> <38d592b8-975c-1fd9-4c42-877e34a4ab70@xiplink.com>
 <alpine.DEB.2.20.1701191341530.3469@virtualbox> <aa8104ad-45f4-7bef-f199-6e6021cf0c06@xiplink.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VefKfxOajk0oirgL/N0MXhueLP2vQMUcZ+qvb5YhH63IC/0t12+
 cD3r2XTh9oM/6W43uogiEMf4ayzSVehP8Xs9dDYHOSfroUG4eQCiVVHPTT3HGlbw/fGvSZ5
 U+anh7IWGMj5FlQEkUBPp81PkRaaPVP+FzKjWL+CqtGO9GA+8MgcK0DoVNLPth/kTzfvgAY
 6N7ikYcWmo517GX9ilKJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HUvnSSRDTZA=:3nh29gQyAAYy3lJPfpvOKD
 k4x/gsufuZiODzgcKCotwzMLUuzfIvrOrXviJKxZFS20KTI0tt9VylK1VQKgG9wN7gQlXS8U8
 xw/5drD2GK2sNyOdDOfXEn7z45Ow/Ylq8BqMTROfr2X/YWjAzW8zm83PTz4PUu+RqUbqlDX8/
 9Zch3/eeK6xIdCP0d2izllBh4m5L3B1GYvITpPMz7HCHN5x+vippMxjpzZ12Kv/yBbWBcNWjF
 cB0mivOfIkTE9O9gLswGEzRNspWSXGvronDgY+AJpz3ZR30NN+VUKgsmQZ8yi6yiYhXcBbWck
 Z91NZ3Rt5TuyJyOOQQaIom4YljAlDNe9YCXO5ptZRRaOYOiDX+VrMSOS9wzIsk4cpjpXyGJPJ
 XjHA52sf+2PeHjNfESI/A4EDe+64ljTMo8JsmJk9aMKfUdxI/PismaKAw1jmrfDIOdsFbOhVj
 kM9KiWv+CGuqcZrtiAIvIrwZNMGfBSiaogQbJ89cQ+T78LpR/yGRve5aL/2k87BQLtvuCaMjj
 ssvw27aU1HVGlamaTrOG5Ja48ZZ8BR+Y1EMI9E80K9cefBFhdhpbRrMIUuCViGLArz2r32s7f
 Ldec/OH6aJ1DzkUpAlESov4ZsOqjcUIWxcXpX9MwnBvijmJUSbwtHHJ/tAd3WEcD7etcN+eaO
 Wrcm+kvF40spIk6htKFEZzc5e/AP9kqQ1CxhFOjerZ3gXu1/3d5+UpAFyevfFUQkCgU6jp/I4
 i7J1e8OmQbqWWFUe4uw1C/vkwUsaGVB6zy/jRl/F9lz6tWwUYhwJqDdjSz4S9h0dZ6abr9Djh
 AA8P4/pEiez46+AkkOXe8JGe+lWj/IHzAYTu59yiLWo9/GFDY6wdyDCS8qcGB2g4LnBSdmchu
 ylc8sjZXpx09gY4LHoOAU3RfnZmZpZotYSZfbxi8onU79wxS1xedVar9DEQ3x8Uci1FXBX44B
 jW9+/zCYaCmbp+B+bKUv0KjjeFoADR6D7r14XFtnXiu5kIzppbOnlc0NY8x6zGiCmXY3b6X6e
 CA5KDGr/AOhWwKCGJPzG0736QGZwYdgXJ4dCAbdm90qWHajOY+oE6BVMrI6f2U9/FA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marc,

On Thu, 19 Jan 2017, Marc Branchaud wrote:

> On 2017-01-19 10:49 AM, Johannes Schindelin wrote:
> >
> > On Wed, 18 Jan 2017, Marc Branchaud wrote:
> >
> > > On 2017-01-18 11:34 AM, Johannes Schindelin wrote:
> > > >
> > > > On Wed, 18 Jan 2017, Marc Branchaud wrote:
> > > >
> > > > > On 2017-01-16 05:54 AM, Johannes Schindelin wrote:
> > > > >
> > > > > > On Mon, 16 Jan 2017, Stephan Beyer wrote:
> > > > > >
> > > > > > > a git-newbie-ish co-worker uses git-stash sometimes. Last
> > > > > > > time he used "git stash pop", he got into a merge conflict.
> > > > > > > After he resolved the conflict, he did not know what to do
> > > > > > > to get the repository into the wanted state. In his case, it
> > > > > > > was only "git add <resolved files>" followed by a "git
> > > > > > > reset" and a "git stash drop", but there may be more
> > > > > > > involved cases when your index is not clean before "git
> > > > > > > stash pop" and you want to have your index as before.
> > > > > > >
> > > > > > > This led to the idea to have something like "git stash
> > > > > > > --continue"[1]
> > > > > >
> > > > > > More like "git stash pop --continue". Without the "pop"
> > > > > > command, it does not make too much sense.
> > > > >
> > > > > Why not?  git should be able to remember what stash command
> > > > > created the conflict.  Why should I have to?  Maybe the fire
> > > > > alarm goes off right when I run the stash command, and by the
> > > > > time I get back to it I can't remember which operation I did.
> > > > > It would be nice to be able to tell git to "just finish off (or
> > > > > abort) the stash operation, whatever it was".
> > > >
> > > > That reeks of a big potential for confusion.
> > > >
> > > > Imagine for example a total Git noob who calls `git stash list`,
> > > > scrolls two pages down, then hits `q` by mistake. How would you
> > > > explain to that user that `git stash --continue` does not continue
> > > > showing the list at the third page?
> > >
> > > Sorry, but I have trouble taking that example seriously.  It assumes
> > > such a level of "noobness" that the user doesn't even understand how
> > > standard command output paging works, not just with git but with any
> > > shell command.
> >
> > Yeah, well, I thought you understood what I meant.
> >
> > The example was the best I could come up with quickly, and it only
> > tried to show that there are *other* stash operations that one might
> > perceive to happen at the same time as the "pop" operation, so your
> > flimsical comment "why not continue the latest operation" may very
> > well be ambiguous.
> >
> > And if it is not ambiguous in "stash", it certainly will be in other
> > Git operations. And therefore, having a DWIM in "stash" to allow
> > "--continue" without any specific subcommand, but not having it in
> > other Git commands, is just a very poor user interface design. It is
> > prone to confuse users, which is always a hallmark of a bad user
> > interface.
> 
> Please don't underestimate the power of syntactic consistency in helping
> users achieve their goals.  Having some commands use "git foo
> --continue" while others use "git foo bar --continue" *will* confuse
> people, regardless of how logical the reasons for those differences.

But that ship has already sailed!

By your reasoning, it was a mistake to introduce subcommands such as `git
stash pop` in the first place.

> But in the case of stash, I still don't see the utility in having
> operation-specific continuation.

Stephan already gave one good example where you want it: if `git stash
pop` fails, you may want to continue by *not* dropping the stash via `git
stash apply --continue`.

> Consider the following sequence (as you say, this doesn't work yet, but
> making it work seems reasonable):
> 
> 	git stash pop  # creates some conflicts
> 	git stash apply stash@{4} # creates some other conflicts
> 	# (User resolves the conflicts created by the pop.)
> 	git stash pop --continue

Yes, that would make sense: the `pop` would actually drop the stash entry.

> Given the description of the original proposal (do "git reset; git stash
> drop"), what's the state of the index and the working tree?
> 
> In particular, what has the user gained by continuing just that pop?

That it was completed.

> Another thing to ask is, how common is such a scenario likely to be?

We have millions of users. Even a 0.001% chance of anything happening will
bite users, who will then come back to bite us.

Let's just not go into the "how likely is this" game.

> I suggest that it will be far more common for users to resolve all the
> conflicts and then want to continue all their interrupted stash
> operations.  If so, fussily forcing them to explicitly continue the pop
> and the apply is just a waste.

No, it is not a waste, as we require the user nothing else than to be
precise. Do you want to continue the "stash pop"? Okay, then, call "git
stash pop --continue".

> [... a lot of stuff skipped, as it is basically ignoring my point...]
>
> > But foo *is the operation*! By that reasoning, you should agree that
> > "git stash --continue" is *wrong*!
> 
> No, in the user's mind *stash* is the operation!

How can that be true? In the user's mind, the *stash* operation is
equivalent to the *stash save* operation! Because that is what happens
when you call "git stash" without any further command-line parameters.

At this point I will stop commenting on this issue, as I have said all
that I wanted to say about it, at least once. If I failed to get my points
across so far, I simply won't be understood.

Ciao,
Johannes
