Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AAE9203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 12:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569AbcG0MfT (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 08:35:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:49862 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754421AbcG0MfS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 08:35:18 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M1WHV-1b8mq03cPx-00tXZ9; Wed, 27 Jul 2016 14:35:13
 +0200
Date:	Wed, 27 Jul 2016 14:35:07 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Orgad Shaneh <orgads@gmail.com>
cc:	git <git@vger.kernel.org>
Subject: Re: [PATCH] merge: Run commit-msg hook
In-Reply-To: <CAGHpTBLN1vBv12fSBXK0taGzxynMymBWRu8FcG=miBy=raReHw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607271413480.14111@virtualbox>
References: <1469519323-11420-1-git-send-email-orgad.shaneh@audiocodes.com> <alpine.DEB.2.20.1607261456480.14111@virtualbox> <CAGHpTBLr9q8h-+hVUzsTS1aS1TyZjz9gYM_T_ZBdY=o26JGaHw@mail.gmail.com> <alpine.DEB.2.20.1607261614020.14111@virtualbox>
 <CAGHpTBLN1vBv12fSBXK0taGzxynMymBWRu8FcG=miBy=raReHw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tRXxhC6UiiJ++uCNvuKBca3Mj43OEfw0N+atYxmjWqPGawuqO7J
 tNFL1L5uq47jTngJImZwwI0xa9LUMEnYtlJx6o1nlnKrmtCoWVtsWvDc/D55d9SJ0EvajtG
 kEb6knB3EOfuZLgXpTi2qT+CW4VAPIZvfrB0TPFW1tYxMvSweLe628fgYvmkn6WYv7bHWx1
 0e5ldyF9XLlWWHGmt8fVA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:kyqMPvSOX8o=:lZl0rzMZSeyoRiLC9OlnUE
 3EYW4/6lJ+oeMzB2m71UnWGysD3ghEhQy+3UXYDQcGZJ55sLsrtATO3iUsBIghW5HAM1P87TY
 puMm2HDgnbajIlTVkSF4yDRD51l9EyqCffCwYfSXZECsat1eYmljETCAd/m0Mfoa/ouv1/K9i
 hLJKT6NpD1DvIiixJdTzQGNQvqTSuF+4XUIFp0iE+xN4LNyL5vWBfxImwdbDEog+fVv/pZTca
 VtSS9qmat8xK/JFrAZM6rn/NKIqvyjYhF7TdebZ/tCSm0cpCIYE6hwPFKQFPB8NgNEJdETDRM
 L+Olco9zfTdUJHLtuChT1HdRliXsCyhW4CVdmZLt6fubCJtP9+d7C2SpUZ+4HlilmnAsI4y9E
 ocaovMNlaAHZWkeciM5y/jmEv+iVldXLhTg4lpJ8cvzqDw2Rc1cmu2zagnwpGYQ5+g4h9tJlt
 w0MDYIhe+TE+zEg8vkv1gxAOdCpdG6nb930HXzPy2+Rd8LfbGzAxCt43OGvqPjFV2bP3wKMFc
 DLRQ0W2bgku4s00aVR9RTC9xQDXQaRAfbkRLMYKUaXh3Mu/uBdmW9lkLV9jk6xDHv/FQwM7Ov
 hGK2Yt8QBFQKuhKMtSQjBsBNBvFkm5ZXdQe6Tn2hnZydwrthX50hXyOfPUOa5cFLt0bJoCuIt
 ULFY0airYnKu9cfiAmqCFHZMYoL6+8VNR/UCJknxzeDV7PwxLoJ1ymfPPyzuCkgLHi+Dt8INY
 dZrKyYGZd8oPHxFDnr7ZLArdBBLjKBG85Cm8MpZ7tjNRLEohkN4G7vuSF9eUEWMmVbAl6PpS9
 ojCCYBQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Orgad,

On Tue, 26 Jul 2016, Orgad Shaneh wrote:

> On Tue, Jul 26, 2016 at 5:54 PM, Johannes Schindelin <
> Johannes.Schindelin@gmx.de> wrote:
> 
> > On Tue, 26 Jul 2016, Orgad Shaneh wrote:
> >
> > > On Tue, Jul 26, 2016 at 4:02 PM, Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > On Tue, 26 Jul 2016, Orgad Shaneh wrote:
> > > >
> > > >> commit-msg is needed to either validate the commit message or
> > > >> edit it.  Gerrit for instance uses this hook to append its
> > > >> Change-Id footer.
> > > >>
> > > >> This is relevant to merge commit just like any other commit.
> > > >
> > > > Hmm. This is not very convincing to me, as
> > > >
> > > > - if you call commit-msg in `git merge` now, why not
> > `prepare-commit-msg`?
> > >
> > > prepare-commit-msg is already called, a few lines above this
> > > addition.
> >
> > Oh. That would have made a heck of a convincing argument in the commit
> > message. Pity it was not mentioned. (Yes, please read that as a strong
> > suggestion to fix that in the next patch iteration.)
> 
> Done.

Good.

> > FWIW I dug out the original submission:
> > http://thread.gmane.org/gmane.comp.version-control.git/151297/focus=151435
> >
> > It seems that there was no discussion about the commit-msg. Which
> > makes me wonder why nobody thought of this.
> >
> > Now, you could make a case that you want to run the commit-msg hook in
> > the same spirit as prepare-commit-msg (and mention that apparently
> > nobody thought of that when the patch was accepted into
> > builtin/merge.c).
> >
> > But then I wonder what your argument would be for *not* running the
> > pre-commit and the post-commit hooks in `git merge` as well?
> >
> > Seems like a big inconsistency to me, one that would not be helped by
> > a piecemeal patch that does only half the job of resolving the
> > inconsistency.
> >
> > There was actually a question why the post-commit hook was not run in
> > `git merge`:
> > http://thread.gmane.org/gmane.comp.version-control.git/168716/focus=168773
> > (but it seems nobody cared all that much).
> >
> 
> pre-commit seems to have been rejected, though I must admit I don't
> fully understand why.  post-commit might make sense, but I wouldn't
> include it in the same patch.  These are different issues.

I did not mean to include that change in the patch. I meant to make a case
for, or against, it, in the commit message.

The commit message is an excellent place to demonstrate the usefulness of
the change as well as background information that lets the reader
understand how thorough the patch is. A commit message can increase the
trust in the rigidity of the patch.

That is why I suggested to research further by providing two links with
further information.

Now that I know that pre-commit has been rejected, of course, I want to
know why. Because the same argument might well preclude commit-msg support
from being added to `git merge` (and it might well lead to the
prepare-commit-msg hook to be deprecated in `git merge`).

This is all very useful information. We are slowly getting to the full
picture needed to assess whether to include this patch or not.

> > > > - a merge is a different beast from a simple commit. That is why
> > > > we have two different commands for them. A hook to edit the merge
> > > > message may need to know the *second* parent commit, too, for
> > > > example to generate a diffstat, or to add information about
> > > > changes in an "evil commit".
> > >
> > > That is correct for a post-merge hook. Why should *message
> > > validation* differ between simple and merge commit?
> >
> > You yourself do not use the hook for validation. You use it to *edit*
> > the message. My examples do the very same thing. Why should they wait
> > for a *post-merge* hook to amend the message?
> >
> 
> Because commit-msg doesn't know anything about the commit.

That is incorrect. When that hook is called, `git rev-parse HEAD` refers
to the parent commit, and `GIT_INDEX_FILE` refers to the index that will be
written as a tree object. That is pretty much all the information needed
to know about the future commit.

> > Otherwise, why wouldn't you use the post-merge hook to add the Change-Id:
> > in your use case, too...
> >
> > > > - if Gerrit is the intended user, would it not make more sense to
> > > > introduce a new hook, e.g. `merge-msg` (and `prepare-merge-msg`),
> > > > as you have to teach Gerrit a new trick anyway?
> > >
> > > Why is that new? Every commit in gerrit has a Change-Id footer, which is
> > > generated by commit-msg hook.
> >
> > So it already works for Gerrit? Why is this patch needed, then? This is
> > confusing.
> >
> 
> Gerrit is a server, the user installs a commit-msg hook provided by
> Gerrit on the local machine.  This hook currently works only for simple
> commits and not for (trivial) merge commits.  That's where this patch
> comes to the rescue.

Sorry, you really need to explain this better in the commit message.
Gerrit exists for quite some time, so I would assume that other developers
would have had serious problems in similar situations. How do they address
those challenges?

> > > What I currently do for merges that succeed without conflicts is
> > > unconditional commit --amend --no-edit just to run the hook.
> >
> > So you do that manually? Or you taught Gerrit to do that? Please
> > clarify.
> 
> Gerrit can't do anything on my machine. It's a web/ssh server. I have my
> own post-merge hook that runs commit --amend

Okay, so why exactly do you need the commit-msg?

All the concerns I raised, all the confusion *need* to be addressed by a
commit message that makes a good case for the change. That is what commit
messages are for. So far, the commit message of this patch is not up to
the task.

Ciao,
Johannes
