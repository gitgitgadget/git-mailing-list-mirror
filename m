Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788DD203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 14:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220AbcGZOyW (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 10:54:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:58583 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753946AbcGZOyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 10:54:21 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LwGDy-1bFQPv0dDy-0185x3; Tue, 26 Jul 2016 16:54:17
 +0200
Date:	Tue, 26 Jul 2016 16:54:06 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Orgad Shaneh <orgads@gmail.com>
cc:	git <git@vger.kernel.org>
Subject: Re: [PATCH] merge: Run commit-msg hook
In-Reply-To: <CAGHpTBLr9q8h-+hVUzsTS1aS1TyZjz9gYM_T_ZBdY=o26JGaHw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607261614020.14111@virtualbox>
References: <1469519323-11420-1-git-send-email-orgad.shaneh@audiocodes.com> <alpine.DEB.2.20.1607261456480.14111@virtualbox> <CAGHpTBLr9q8h-+hVUzsTS1aS1TyZjz9gYM_T_ZBdY=o26JGaHw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ui6LeIaxH13W41oMENyQaQq9alKb9BY0pX6HwGRiow1ZgC8nkVC
 Pa5RBBEyvOFu1SslyOKXP7kuJ/lX8kayxXKNkbymbBCRie4/7o5bO/iDNsA5Vo+avnQXndQ
 jFOfYXNbGe/YZoj7uW4lXFSt5zdbtF6gn1bAi6GcoLWWdOPAA8LkYdRx6/phgb2Pb/NM/IZ
 J2NQr8zZH7TdxonfXB6xA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:8Sz6oe4/sug=:xeQiX24ig42ban9tzM6fo8
 8fDCcz5mbNmP/Ws5ZfDdkcNMD61RBxY1+gU8/nzPFeh/sXPzhn601ydXbRqQq4fbx2nh3kfPU
 YeYSEhcOMM1aXr98kAM5ofMC8DEr3gftoWUh1LSFMtMvTCxulxlLfEUoJJgeQZi8KcDssrul+
 2lRwAndzOOVhyw7OczlcItKREBLUjM/CHpCqydifjEf6rfY75t6zscZxfRIDROXPMJ/mT//vA
 g3faL9byKiX3t/lvj9HnAGPjtAppNvP9Exmp+ukDyUEDr0bCL6HC+kmNLY1WEwt9A5cq/p9AC
 bykMRnMpK+7PFchBLckvvs+tD66upNV65Py5FEzn/hoCl+s1DwKy3SFaNC31C8TOux+gNCTn+
 67lqsulbhhlJ7m6xJ2yOP0vOidIurBhyIQt+5v9dU15vDRaZU76l2/dTlW/pcmUh+sYTfiN/4
 KiQc1OEnAjZ0OmgXB5tOtNlLO6fMOhJmaPLjw6guftW7bSwUsG7je+rLE2ftklnx1dudkI2Xy
 +LAHW4WlLqtjgCz5RoMLERwPCs+qtTvqPFWso1Rky2m4Ip955gv5PteObiEz0Xr0c9SLy1WN5
 5Iy3DaeYrZQgJ+22FKv/ccZbm82tB1BOxhMEHItBdbKzeWk5pjfeXjYwGX98QLdV3J4Er+ThN
 RydPpechXMyPyjUnunpZsAHYFZksVY9PVtR1VLAdB6FaBey/eQWPZKLbyE/+MhDhdw2S8nxzq
 LCKP5Gl80iz2USKzI/BahVY1BdHgPIDR75Wa/lVBZ87ETJgsKKiimlmxu5oDX2E2IxTsd/Zf1
 a5iMQ/6
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Orgad,

On Tue, 26 Jul 2016, Orgad Shaneh wrote:

> On Tue, Jul 26, 2016 at 4:02 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 26 Jul 2016, Orgad Shaneh wrote:
> >
> >> commit-msg is needed to either validate the commit message or edit it.
> >> Gerrit for instance uses this hook to append its Change-Id footer.
> >>
> >> This is relevant to merge commit just like any other commit.
> >
> > Hmm. This is not very convincing to me, as
> >
> > - if you call commit-msg in `git merge` now, why not `prepare-commit-msg`?
> 
> prepare-commit-msg is already called, a few lines above this addition.

Oh. That would have made a heck of a convincing argument in the commit
message. Pity it was not mentioned. (Yes, please read that as a strong
suggestion to fix that in the next patch iteration.)

FWIW I dug out the original submission:
http://thread.gmane.org/gmane.comp.version-control.git/151297/focus=151435

It seems that there was no discussion about the commit-msg. Which makes me
wonder why nobody thought of this.

Now, you could make a case that you want to run the commit-msg hook in the
same spirit as prepare-commit-msg (and mention that apparently nobody
thought of that when the patch was accepted into builtin/merge.c).

But then I wonder what your argument would be for *not* running the
pre-commit and the post-commit hooks in `git merge` as well?

Seems like a big inconsistency to me, one that would not be helped by a
piecemeal patch that does only half the job of resolving the inconsistency.

There was actually a question why the post-commit hook was not run in `git
merge`:
http://thread.gmane.org/gmane.comp.version-control.git/168716/focus=168773
(but it seems nobody cared all that much).

> > - a merge is a different beast from a simple commit. That is why we
> > have two different commands for them. A hook to edit the merge message
> > may need to know the *second* parent commit, too, for example to
> > generate a diffstat, or to add information about changes in an "evil
> > commit".
> 
> That is correct for a post-merge hook. Why should *message validation*
> differ between simple and merge commit?

You yourself do not use the hook for validation. You use it to *edit* the
message. My examples do the very same thing. Why should they wait for a
*post-merge* hook to amend the message?

Otherwise, why wouldn't you use the post-merge hook to add the Change-Id:
in your use case, too...

> > - if Gerrit is the intended user, would it not make more sense to
> >   introduce a new hook, e.g. `merge-msg` (and `prepare-merge-msg`), as you
> >   have to teach Gerrit a new trick anyway?
> 
> Why is that new? Every commit in gerrit has a Change-Id footer, which is
> generated by commit-msg hook.

So it already works for Gerrit? Why is this patch needed, then? This is
confusing.

> What I currently do for merges that succeed without conflicts is
> unconditional commit --amend --no-edit just to run the hook.

So you do that manually? Or you taught Gerrit to do that? Please clarify.

> > - if Gerrit is the intended user, why does it not simply edit the merge
> >   message itself? After all, it executes it, and probably crafts a merge
> >   message mentioning that this is an automatic merge, anyway, so why not
> >   add the Change-Id *then*?
> 
> Most Gerrit setups require Change-Id in the commit message that the user
> pushes. It is possible to disable this setting, and then you don't need the
> Change-Id at all, but then you can't push a new patch set for the change
> (unless you copy the Change-Id from gerrit to your commit message).
> That's a real pain, I'm not aware of any public gerrit server that
> disables this :)

Forgive me, I never used Gerrit, and neither do I intend to do so.

I would appreciate a self-contained commit message that explains just
enough about Gerrit to understand what the patch tries to solve, and in a
manner such that even developers who decided to ignore Gerrit understand.

Ciao,
Dscho
