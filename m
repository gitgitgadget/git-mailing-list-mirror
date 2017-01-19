Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C437E20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 15:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbdASPta (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 10:49:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:50174 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753652AbdASPt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 10:49:29 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjLwB-1bz0sN3z2t-00dWoI; Thu, 19
 Jan 2017 16:49:17 +0100
Date:   Thu, 19 Jan 2017 16:49:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Marc Branchaud <marcnarc@xiplink.com>
cc:     Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Subject: Re: [RFC] stash --continue
In-Reply-To: <38d592b8-975c-1fd9-4c42-877e34a4ab70@xiplink.com>
Message-ID: <alpine.DEB.2.20.1701191341530.3469@virtualbox>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net> <alpine.DEB.2.20.1701161153340.3469@virtualbox> <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com> <alpine.DEB.2.20.1701181725130.3469@virtualbox> <38d592b8-975c-1fd9-4c42-877e34a4ab70@xiplink.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GS0kBUoMjY3QXkcIUqx33DnBtUclflieAEd33aJzSb7f1wU3f5c
 qhCIWrOe24t+/l2gTy8fHikuwVL7R67Zs+EzRY0U3qrF+GBTmA2cersxey055e9E5elp7U/
 HeSjbDcX6hwpmwMmD82ccMNuP1qEvu3GEdf1zfU6exr/ADxsbSHpLJBwBqpge9nv4afTAsS
 lZ//EMAK3onZlxAYQAF4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F8xucIK8NNQ=:ttsuPofV+3j0MPlicBgekp
 X04FWHBHlZ8aoRwBXpXjgMp9B/I2sXgkYfetmOFTZwfiE9bJA0Xk69MAlzmAprAtgBgCR6XpT
 I8X12ZKiuTV1wBSQUg+R9P9OS9Rwsxm56HVYsMN2SZutoxII1K7irwdIvgsy07dCoo82JtOAY
 j+LSW5wiORadi50TkqYMJ74Y38Zm7LCWpwgFL3yzzEPEdV967UvPxGql64XK+q0RBp8p0xR7S
 RzHM23P6HQkkJ9uABdNjvBLZM2WzLMNwkxVp++hmss9pI0/Tc9qXBg115hlE9aVkil5wPnKOl
 ohdRkyCyQSQdWQuzAvD4CceGhhqk1xjXsyOuADSfNpAfvwAyLLx3knRc/wOh+5Ys/NsDXECBI
 D/eCCcl2h2ZciAXfqpfvSkdDzFPzGv1z20zUX3/42F1W0LjuxV84iZQ5XW94Ek05CvOp5VDPX
 eldA1SYr4ODBD+4g5Y5Mil9MwgnhjgOh/+n7WF8rcqE9V3u3dqcQrRTNGeMRQu9pu/2xMbzUP
 ihbTmCO/9mzg3EfIh4+lVoo8IZ+i5EEe9wH2pj13ry6DDATcGqpwexHR6vej79cAnjoyquLKG
 ICyre4JhzvV6dDLWWps40PZi0DqRu2zCskCk0UGeZxztVkCarcHt55EepYqesNjQp48N77QGT
 0ouP8MosmivCRG06+0+G4VePgYdZ2OgL656CLlxxQPerAtX4aW0i7BEavo5ncUYvMs0VMH8mP
 ACor5Bl9J5/ywYKeZRt7fYFmzV/8jCAI4JpGPmIIBlWcRCIIbJTDvMzGF2vk03mP3q702nM0w
 knVxNby
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marc,

On Wed, 18 Jan 2017, Marc Branchaud wrote:

> On 2017-01-18 11:34 AM, Johannes Schindelin wrote:
> >
> > On Wed, 18 Jan 2017, Marc Branchaud wrote:
> >
> > > On 2017-01-16 05:54 AM, Johannes Schindelin wrote:
> > >
> > > > On Mon, 16 Jan 2017, Stephan Beyer wrote:
> > > >
> > > > > a git-newbie-ish co-worker uses git-stash sometimes. Last time
> > > > > he used "git stash pop", he got into a merge conflict. After he
> > > > > resolved the conflict, he did not know what to do to get the
> > > > > repository into the wanted state. In his case, it was only "git
> > > > > add <resolved files>" followed by a "git reset" and a "git stash
> > > > > drop", but there may be more involved cases when your index is
> > > > > not clean before "git stash pop" and you want to have your index
> > > > > as before.
> > > > >
> > > > > This led to the idea to have something like "git stash
> > > > > --continue"[1]
> > > >
> > > > More like "git stash pop --continue". Without the "pop" command,
> > > > it does not make too much sense.
> > >
> > > Why not?  git should be able to remember what stash command created
> > > the conflict.  Why should I have to?  Maybe the fire alarm goes off
> > > right when I run the stash command, and by the time I get back to it
> > > I can't remember which operation I did.  It would be nice to be able
> > > to tell git to "just finish off (or abort) the stash operation,
> > > whatever it was".
> >
> > That reeks of a big potential for confusion.
> >
> > Imagine for example a total Git noob who calls `git stash list`,
> > scrolls two pages down, then hits `q` by mistake. How would you
> > explain to that user that `git stash --continue` does not continue
> > showing the list at the third page?
> 
> Sorry, but I have trouble taking that example seriously.  It assumes
> such a level of "noobness" that the user doesn't even understand how
> standard command output paging works, not just with git but with any
> shell command.

Yeah, well, I thought you understood what I meant.

The example was the best I could come up with quickly, and it only tried
to show that there are *other* stash operations that one might perceive
to happen at the same time as the "pop" operation, so your flimsical
comment "why not continue the latest operation" may very well be
ambiguous.

And if it is not ambiguous in "stash", it certainly will be in other Git
operations. And therefore, having a DWIM in "stash" to allow "--continue"
without any specific subcommand, but not having it in other Git commands,
is just a very poor user interface design. It is prone to confuse users,
which is always a hallmark of a bad user interface.

Hence my objection to "git stash --continue". No argument in favor of "git
stash --continue" I heard so far comes even close to being convincing.

> > Even worse: `git stash` (without arguments) defaults to the `save`
> > operation, so any user who does not read the documentation (and who
> > does?) would assume that `git stash --continue` *also* implies `save`.
> 
> Like the first example, your user is trying to "continue" a command that
> is already complete.

Says who? You may understand the semantics better than other users, but
who are you to judge?

But that's besides the point.

My point (which you did not quite understand) was that it can be ambiguous
what to continue when looking at *all* Git commands. To special-case "git
stash"'s user interface makes things more confusing, and therefore less
usable for everyone.

And even with `git stash apply`, you could construct a very plausible
scenario (which does not work yet, but we may want to make it work): if
`git stash apply` causes conflicts, and `git stash apply stash@{1}`
conflicts in a *different* set of files, why don't we allow the second
operation to succeed (adding its conflicts)?

That example is like `git cherry-pick -n` with two different commits, both
of which conflict with the current worktree, but in different files. Both
cherry-picks would do their job if called after one another, and the
result is a worktree with the *combined* conflicts. That is a legitimate
use case (which I happened to *actually* perform just the other day).

If we fix "git stash" (and there is no reason we should not), it would
also allow "git stash pop; git stash pop" to work with two stashes that
both conflict with the current worktree, just in different files.

So I challenge you to get less hung up on the *exact* example I present,
and to try to see through the example what the issue is that I am trying
to get at.

> > If that was not enough, there would still be the overall design of
> > Git's user interface. You can call it confusing, inconsistent, with a
> > lot of room for improvement, and you would be correct. But none of
> > Git's commands has a `--continue` option that remembers the latest
> > subcommand and continues that. To introduce that behavior in `git
> > stash` would disimprove the situation.
> 
> I think it's more the case that none of the current continuable commands
> have subcommands (though I can't think of all the continuable or
> abortable operations offhand, so maybe I'm wrong).  I think we're
> discussing new UI ground here.

Nope, we are not entering new UI ground here. The principle is clear with
the existing --continue options: you pass them to the same operation that
you want to continue. By that reasoning, "git stash --continue" should
continue the (implicit) "save" operation. But that is not at all what you
want.

> And since the pattern is already "git foo --continue",

But foo *is the operation*! By that reasoning, you should agree that "git
stash --continue" is *wrong*!

> Think of it this way:  All the currently continuable/abortable commands
> put the repository in a shaky state, where performing certain other
> operations would be ill advised.  Attempting to start a rebase while a
> merge conflict is unresolved, for example.  IIRC, git actually tries to
> stop users from shooting their feet in this way.
> 
> And so it should be for the stash operation:  If applying a stash yields
> a conflict, it has to be resolved or aborted before something like a
> rebase or merge is attempted.

That already happens, and I have no idea how you think this safe-guarding
has anything to do whether the "--continue" option makes sense in "git
stash", or only in "git stash pop".

> In the long run, I think there's even the possibility of generic "git
> continue" and "git abort" commands,

Wrong.

You can call "git cherry-pick" (and "git cherry-pick --continue") while
running a "git rebase -i".

You can run "git rebase", "git stash", "git cherry-pick" and many other
commands while running a "git bisect".

You can even run a "git rebase" or a "git cherry-pick" while resolving an
interrupted "git am".

Many, many examples that make it *impossible* for Git to know *what* you
want to continue, *what* you want to abort.

> > At least `git stash pop --continue` would be consistent with all other
> > `--continue` options in Git that I can think of...
> 
> Alas, I disagree!

Sure, you are free to disagree.

And syntactially, you are even correct: "git <something> <something-else>
--continue" is inconsistent with "git <something> --continue".

But semantically, i.e. when you look at the *meaning* of those
"<something>"s, you are incorrect: the "--continue" option always goes
with the *operation* that needs to be continued. Always, always, always.
If you continue a rebase, it is "git rebase --continue", *not* "git
--continue". If you continue a revert, it is "git revert --continue". And
so it should be for popping a stash: "git stash pop --continue". Because
the operation is specified by "git stash pop", not by "git stash". There
is really not much you can argue sanely about that.

Ciao,
Johannes
