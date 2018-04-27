Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC601F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759300AbeD0Vgu (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:36:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:34399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759079AbeD0Vgt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:36:49 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M35iN-1eLZvS39a3-00syCF; Fri, 27
 Apr 2018 23:36:41 +0200
Date:   Fri, 27 Apr 2018 23:36:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] rebase --skip: clean up commit message after a
 failedfixup/squash
In-Reply-To: <b6512eae-e214-9699-4d69-77117a0daec3@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1804272304100.72@tvgsbejvaqbjf.bet>
References: <cover.1524226637.git.johannes.schindelin@gmx.de> <6d9f6ba1e73d2297cef3619a89ce69122438368d.1524226637.git.johannes.schindelin@gmx.de> <b6512eae-e214-9699-4d69-77117a0daec3@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nshpgMnY2lUSg5Sa7ij9oeoHlgDW7ikvJyP0LnGvTX4ynHHHmMc
 mBao/WwdMr9U0t2UE2wzGO0lNNF1a7ohaVfhNW71d9UDm9GSi5aCgtY+z3bBt0aJFHH9xxF
 v+9QlEHlpe1q/lrNNuOTngSyB6eLtQb/t2tw4TdWvgvp0Ryn4KNOvr5jkSSa79bZfntSfpE
 M0VQFapLxxHglQR6vY+Ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4qHA2pKFAk8=:+ZmJyyqViRwBGDvtfeGzej
 V4mhia+B1QZ0xG3tsJ2iOuwcbmsE2zxXo2tlivgifS+xD84BKI3LU7RrXtC5me00H5NRSmWWS
 B7K+V+utPgjnmo2tbBNDcLjQbLXIXpC+GWsMZSKsL58zR2oJt9EOaEOcb2oyAsTBzf1IbYr+Y
 d0pmrNfSA0xPSVYmHOHIJ1DFIgs8xmKfUxqT2REEn2/QgOL3nYbndyAj/bRIy5UGZRPRAOWtB
 H4rvuFzCj1hyxlr7KgeclrRGFRrBRqHn5+fZTJl1kYhaODiRFKgMmDHyIJtka0Sqn24cDVfAA
 GEXADsD4yOd9wHNhw7LJSbIglzhVcpLDDdLUOt1s84H0PXWyHJEH29+js8oPcTnM8xOHtNJzi
 mDLBEQsXW8POI0N1YAyPxw+oIbdzaxtkWMEXEywDJzDoBHCwdClKVaQt4ztPwK7bFd2aKZpCE
 yANA1XqwjLjiHufGoW77b27AYdzsFiVZUUWSmhziZ+HHAH0Ub7M8qIlg/bFXOVe25y6f3yCRZ
 p8XGq1YP7GBnG4jMI84Hqj0PqnSTAUJAcmtn4Pcfc1dnd6QKXU7XlyN7HDSOYFD2ANKX2XMJP
 QVflDeAajVlb64s6kKfyj/KpwBzYQENzke6WNrcMBs5yILYYMoEDaGODzmcVqHe8Aq2UPzLpG
 9mC06d9pdkiJ7UEoFPa6SMZzWMGLO83soLZ5qxAdcixdsPa/nxRsXNZZSf8WEBdP70skj+RoT
 RKX/3v7IrDrCwH28ZbSZO9HBPd81d/+zVMzk+9otO1TyHbj6O4q7NSQr6sNTzsvwboaCL7u5X
 4z5kQxW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sat, 21 Apr 2018, Phillip Wood wrote:

> On 20/04/18 13:18, Johannes Schindelin wrote:
> > 
> > During a series of fixup/squash commands, the interactive rebase builds
> > up a commit message with comments. This will be presented to the user in
> > the editor if at least one of those commands was a `squash`.
> > 
> > However, if the last of these fixup/squash commands fails with merge
> > conflicts, and if the user then decides to skip it (or resolve it to a
> > clean worktree and then continue the rebase), the current code fails to
> > clean up the commit message.
> 
> Thanks for taking the time to track this down and fix it.

It was on my mind, but since I got caught twice by this bug within a week,
I figured it was about time.

> > diff --git a/sequencer.c b/sequencer.c
> > index a9c3bc26f84..f067b7b24c5 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2781,17 +2781,12 @@ static int continue_single_pick(void)
> >   
> >   static int commit_staged_changes(struct replay_opts *opts)
> >   {
> > -	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
> > +	unsigned int flags = ALLOW_EMPTY | EDIT_MSG, is_fixup = 0, is_clean;
> >   
> >    if (has_unstaged_changes(1))
> >   		return error(_("cannot rebase: You have unstaged changes."));
> > -	if (!has_uncommitted_changes(0)) {
> > -		const char *cherry_pick_head = git_path_cherry_pick_head();
> >   -		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
> > -			return error(_("could not remove CHERRY_PICK_HEAD"));
> > -		return 0;
> > -	}
> > +	is_clean = !has_uncommitted_changes(0);
> >   
> >    if (file_exists(rebase_path_amend())) {
> >   		struct strbuf rev = STRBUF_INIT;
> > @@ -2804,16 +2799,41 @@ static int commit_staged_changes(struct replay_opts
> > *opts)
> >     if (get_oid_hex(rev.buf, &to_amend))
> >      return error(_("invalid contents: '%s'"),
> >   				rebase_path_amend());
> > -		if (oidcmp(&head, &to_amend))
> > +		if (!is_clean && oidcmp(&head, &to_amend))
> >      return error(_("\nYou have uncommitted changes in your "
> >              "working tree. Please, commit them\n"
> >              "first and then run 'git rebase "
> >              "--continue' again."));
> > +		if (is_clean && !oidcmp(&head, &to_amend)) {
> 
> Looking at pick_commits() it only writes to rebase_path_amend() if there are
> conflicts, not if the command has been rescheduled so this is safe.

This is indeed the intent of that file.

> > +			strbuf_reset(&rev);
> > +			/*
> > +			 * Clean tree, but we may need to finalize a
> > +			 * fixup/squash chain. A failed fixup/squash leaves
> > the
> > +			 * file amend-type in rebase-merge/; It is okay if
> > that
> > +			 * file is missing, in which case there is no such
> > +			 * chain to finalize.
> > +			 */
> > +			read_oneliner(&rev, rebase_path_amend_type(), 0);
> > +			if (!strcmp("squash", rev.buf))
> > +				is_fixup = TODO_SQUASH;
> > +			else if (!strcmp("fixup", rev.buf)) {
> > +				is_fixup = TODO_FIXUP;
> > +				flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
> 
> I was going to say this should probably be (flags & ~(EDIT_MSG | VERIFY_MSG))
> but for some reason VERIFY_MSG isn't set here - I wonder if it should be as I
> think it's set elsewhere when we edit the message.

As this patch series is purely about the bug fix where interrupted
fixup/squash series can lead to incorrect commit messages, I would say
that if this is a bug, it should be fixed in a separate patch series.

The name of that option is actually a little bit unfortunate: it bypasses
the pre-commit/commit-msg hooks. I am not sure why they are bypassed in
the commit_staged_changes() function.

*clickety-click*

It would appear that I simply copied this from

https://github.com/git/git/blob/v2.17.0/git-rebase--interactive.sh#L794-L808

So where does that come from? Let's use `git log -L
794,808:git-rebase--interactive.sh v2.17.0` to find out.

*clickety-click*

From that log, it looks as if this was added in 2147f844ed1 (rebase -i: handle
fixup of root commit correctly, 2012-07-24). But that is incorrect: the
--no-verify invocation was only split into two by said commit, and moved
into the conditional. So we need to look a little further, with a larger
line range (I extended it to 810 for the purpose of this analysis).

*clickety-click*

So it goes all the way back to c5b09feb786 (Avoid update hook during
git-rebase --interactive, 2007-12-19). From that commit message, you can
see that the rationale for the --no-verify flag was as following: the `git
commit` might fail when continuing with staged changes, due to a check in
a hook, and since there is inadequate error checking in the
git-rebase--interactive.sh script, it would continue and squash the
changes into the next commit.

From that description, it would appear that the proper fix would have been
to 1) introduce proper error checking, and 2) offer a mode to bypass the
hooks for *all* of the interactive rebase.

It is funny that 1) was addressed apparently 4 minutes later, in
dbedf9729bd (Catch and handle git-commit failures in git-rebase
--interactive, 2007-12-19).

As to 2): it seems to have been implemented in c44276563f9 (rebase
--no-verify, 2008-10-06), but by that time it was probably safely
forgotten that the --no-verify option was only introduced as a work-around
for the absence of the `git rebase -i --no-verify` mode.

So I guess it would be time to undo c5b09feb786...

But as I said, I'd rather really not taint this here patch series by an
unrelated bug fix. It has gone to the length of four iterations already
even without such distractions.

> > +			}
> > +		}
> >   
> >     strbuf_release(&rev);
> >     flags |= AMEND_MSG;
> >    }
> >   +	if (is_clean && !is_fixup) {
> > +		const char *cherry_pick_head = git_path_cherry_pick_head();
> > +
> > +		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
> > +			return error(_("could not remove CHERRY_PICK_HEAD"));
> > +		return 0;
> > +	}
> > +
> >    if (run_git_commit(rebase_path_message(), opts, flags))
> 
> If a squash command has been skipped, then rebase_path_message() still
> contains the message of the skipped commit. If it passed NULL instead
> then the user would get to edit the previous version of the squash
> message without the skipped commit message in it.

True. One problem that I only caught late in my work on v4 is that
run_git_commit() did not handle the absence of defmsg *and* EDIT_MSG well:
in that case, it always opened the editor. I addressed that in the new
3/4. (The old 3/4 is no longer needed: it wrote the amend-type file whose
purpose is now folded into current-fixups, introduced in the new 2/4.)

> Also I think we only want to re-commit if the skipped squash/fixup was
> preceded by another squash/fixup.

I thought so, too, at first. But I think that is still not quite the
correct thing: we really only want to re-commit if we are in the middle of
the final fixup/squash of the fixup/squash chain. And only if that final
fixup/squash was not the only one in that chain.

> If the user skips the first squash/fixup in a chain then HEAD has the
> commit message from the original pick so does not need amending. The
> first patch could perhaps avoid writing rebase_path_amend_type() in that
> case by reading the squash message and checking the message count is
> greater than two.

As I mentioned in another reply to you, I redid the whole shebang so that
we always write a `current-fixups` file as soon as we encounter a fixup or
squash. This file will build up the fixup/squash chain.

One thing that I had missed when I wrote that reply is that we sometimes
do *not* skip a failed fixup/squash, but instead resolve the merge
conflicts, stage the changes and call `git rebase --continue`. In this
case, `git rebase` will commit the changes, *opening the commit message in
an editor*. Therefore, the fixup/squash chain is broken at that point, and
we have to treat the current fixup/squash as if it were the final in the
current chain.

I imagine that it will take a while to review v4 in depth ;-)

Ciao,
Dscho
