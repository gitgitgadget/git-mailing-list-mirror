Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BA71F453
	for <e@80x24.org>; Tue,  2 Oct 2018 13:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbeJBUe1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 16:34:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:44829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731304AbeJBUeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 16:34:25 -0400
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYbFe-1gB4AX2i7W-00VTon; Tue, 02
 Oct 2018 15:50:47 +0200
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYbFe-1gB4AX2i7W-00VTon; Tue, 02
 Oct 2018 15:50:47 +0200
Date:   Tue, 2 Oct 2018 15:50:48 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 4/4] rebase --skip: clean up commit message after a
 failed fixup/squash
In-Reply-To: <4bd08893-52b4-3a01-d546-4884e2762670@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1810021546500.2034@tvgsbejvaqbjf.bet>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524862093.git.johannes.schindelin@gmx.de> <08609b5f2d5bc7f3f6d010088db4b58695dfbd64.1524862093.git.johannes.schindelin@gmx.de>
 <4bd08893-52b4-3a01-d546-4884e2762670@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nHK3KTPxin6xE3vHM3roYESxtQwviqVoqJOIzO3dG9yekO1sScL
 7CkxJ4/t11ZuLhuc+3FOT+QclDFX8L2Dks3u97fost7/zIFTs6gb5R2pZqXVaL/nP9HEawH
 ttSDZzURQRpLr9gX4NzXAjsrj5O415sDBNBhjrDGeHRwZ7T0JNc3JcjDTOPqAnJzIAIdKxz
 eTQJ3BFzjBQJugmMx2rXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v0lRwZuE8UA=:l5/prtU9P+9L7Q6K8xa9KW
 uS7uz2vclnAS6JGDApb4KDMDDP3K1IHnjXZvNTKXJsHEy0yA95g91Wg2vWVFm9mNgEje91m5i
 rjp/gkbAUhiWpAHf0fJcccfbb7rPbyq0afvUtf0XTwYPzB44rguzKvT5o3CL2zt8IXo1arWfM
 azMZ0/3ePV9wejc3Mz4F7iDWBxU723vKjMK3NLMHD011M/vCxiIqgFbreF/GwYbMn5pTDEAxi
 80MHk4EPL3m+/KucfrHHjtESeyUKIHIjelRxrenwbcdyzTvsYzqroIx2B0yDADthhA5bcr33Z
 nOSOgYl+w32xWGMwpiIVcnImSzGnjlxIQbqNtBxt2VteHUUXw/iIfEPgjX02OEwcF4YtL3pJB
 kg+v0Xsac3WqKsyIKgv1vYko+xhcVTBjcz7EXca1JINHXdHXMWeWF7SB2DzWlYzO3p9+D+MLw
 CJsgyb8mLd3JeTdirmr0hV/i2myABfcSg5Cc/15FP5JZWbtbivIgLFrh9FsMoEpLOJZWAMwjy
 cUeB0VYgRfgSZQGxi1Op/Kz2mxHmhQUtD9ySucsVDWRFQLOYEVi6JZ+eUqMf1OULX2KDRXcc+
 EEaMpapYKXZJUa6W9NLlaaA+WyhQAdFRnRUvwv3ggwAA1bTUWFkw9chujv0hO+UMpvqzxb0Hb
 Mfrrk/rWxIl0Iq+lSbw/fj07UpCiZCffNKXFInw6AjeEa69Sb+Ua4aOrDEN/2SF3QmtkCRzoN
 +Obf9AXOCwM2hJq9g2csEreR8OdGniazyw2YTQN4BlHamhRu+SJ0SXvukXj9G2KQdTQ3bbXtH
 VGJvGYvkB4P1FyAd7SvmtO+Bmz8RcJRkVqoJ9dcGMCw8lfIm5Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

[sorry, I just got to this mail now]

On Sun, 6 May 2018, Phillip Wood wrote:

> On 27/04/18 21:48, Johannes Schindelin wrote:
> > 
> > During a series of fixup/squash commands, the interactive rebase builds
> > up a commit message with comments. This will be presented to the user in
> > the editor if at least one of those commands was a `squash`.
> > 
> > In any case, the commit message will be cleaned up eventually, removing
> > all those intermediate comments, in the final step of such a
> > fixup/squash chain.
> > 
> > However, if the last fixup/squash command in such a chain fails with
> > merge conflicts, and if the user then decides to skip it (or resolve it
> > to a clean worktree and then continue the rebase), the current code
> > fails to clean up the commit message.
> > 
> > This commit fixes that behavior.
> > 
> > The fix is quite a bit more involved than meets the eye because it is
> > not only about the question whether we are `git rebase --skip`ing a
> > fixup or squash. It is also about removing the skipped fixup/squash's
> > commit message from the accumulated commit message. And it is also about
> > the question whether we should let the user edit the final commit
> > message or not ("Was there a squash in the chain *that was not
> > skipped*?").
> > 
> > For example, in this case we will want to fix the commit message, but
> > not open it in an editor:
> > 
> > 	pick	<- succeeds
> > 	fixup	<- succeeds
> > 	squash	<- fails, will be skipped
> > 
> > This is where the newly-introduced `current-fixups` file comes in real
> > handy. A quick look and we can determine whether there was a non-skipped
> > squash. We only need to make sure to keep it up to date with respect to
> > skipped fixup/squash commands. As a bonus, we can even avoid committing
> > unnecessarily, e.g. when there was only one fixup, and it failed, and
> > was skipped.
> > 
> > To fix only the bug where the final commit message was not cleaned up
> > properly, but without fixing the rest, would have been more complicated
> > than fixing it all in one go, hence this commit lumps together more than
> > a single concern.
> > 
> > For the same reason, this commit also adds a bit more to the existing
> > test case for the regression we just fixed.
> > 
> > The diff is best viewed with --color-moved.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c                | 113 ++++++++++++++++++++++++++++++++-----
> >  t/t3418-rebase-continue.sh |  35 ++++++++++--
> >  2 files changed, 131 insertions(+), 17 deletions(-)
> > 
> > diff --git a/sequencer.c b/sequencer.c
> > index 56166b0d6c7..cec180714ef 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > [...]
> > @@ -2804,19 +2801,107 @@ static int commit_staged_changes(struct replay_opts *opts)
> >  		if (get_oid_hex(rev.buf, &to_amend))
> >  			return error(_("invalid contents: '%s'"),
> >  				rebase_path_amend());
> > -		if (oidcmp(&head, &to_amend))
> > +		if (!is_clean && oidcmp(&head, &to_amend))
> >  			return error(_("\nYou have uncommitted changes in your "
> >  				       "working tree. Please, commit them\n"
> >  				       "first and then run 'git rebase "
> >  				       "--continue' again."));
> > +		/*
> > +		 * When skipping a failed fixup/squash, we need to edit the
> > +		 * commit message, the current fixup list and count, and if it
> > +		 * was the last fixup/squash in the chain, we need to clean up
> > +		 * the commit message and if there was a squash, let the user
> > +		 * edit it.
> > +		 */
> > +		if (is_clean && !oidcmp(&head, &to_amend) &&
> > +		    opts->current_fixup_count > 0 &&
> > +		    file_exists(rebase_path_stopped_sha())) {
> > +			const char *p = opts->current_fixups.buf;
> > +			int len = opts->current_fixups.len;
> > +
> > +			opts->current_fixup_count--;
> > +			if (!len)
> > +				BUG("Incorrect current_fixups:\n%s", p);
> > +			while (len && p[len - 1] != '\n')
> > +				len--;
> > +			strbuf_setlen(&opts->current_fixups, len);
> > +			if (write_message(p, len, rebase_path_current_fixups(),
> > +					  0) < 0)
> > +				return error(_("could not write file: '%s'"),
> > +					     rebase_path_current_fixups());
> > +
> > +			/*
> > +			 * If a fixup/squash in a fixup/squash chain failed, the
> > +			 * commit message is already correct, no need to commit
> > +			 * it again.
> > +			 *
> > +			 * Only if it is the final command in the fixup/squash
> > +			 * chain, and only if the chain is longer than a single
> > +			 * fixup/squash command (which was just skipped), do we
> > +			 * actually need to re-commit with a cleaned up commit
> > +			 * message.
> > +			 */
> > +			if (opts->current_fixup_count > 0 &&
> > +			    !is_fixup(peek_command(todo_list, 0))) {
> > +				final_fixup = 1;
> > +				/*
> > +				 * If there was not a single "squash" in the
> > +				 * chain, we only need to clean up the commit
> > +				 * message, no need to bother the user with
> > +				 * opening the commit message in the editor.
> > +				 */
> > +				if (!starts_with(p, "squash ") &&
> > +				    !strstr(p, "\nsquash "))
> > +					flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
> > +			} else if (is_fixup(peek_command(todo_list, 0))) {
> > +				/*
> > +				 * We need to update the squash message to skip
> > +				 * the latest commit message.
> > +				 */
> > +				struct commit *commit;
> > +				const char *path = rebase_path_squash_msg();
> > +
> > +				if (parse_head(&commit) ||
> > +				    !(p = get_commit_buffer(commit, NULL)) ||
> > +				    write_message(p, strlen(p), path, 0)) {
> > +					unuse_commit_buffer(commit, p);
> > +					return error(_("could not write file: "
> > +						       "'%s'"), path);
> > +				}
> 
> I think it should probably recreate the fixup message as well. If there
> is a sequence
> 
> pick commit
> fixup a
> fixup b
> fixup c
> 
> and 'fixup b' gets skipped then when 'fixup c' is applied the user will
> be prompted to edit the message unless rebase_path_fixup_msg() exists.

I was already on my way to fix this when I encountered this mail 30
minutes ago, but when I tried to implement the regression test, I took a
step back: apart from "disk full" and "pilot error", there is really no
good reason for the `message-squash` file not being able to be written.

And in both cases, a benign `git status` will show the latest command,
i.e. the one that failed.

In other words: I now deem this such a corner case that it is not worth
spending more time on the error message than we already did...

Ciao,
Dscho

> 
> Best Wishes
> 
> Phillip
> 
> > +				unuse_commit_buffer(commit, p);
> > +			}
> > +		}
> >  
> >  		strbuf_release(&rev);
> >  		flags |= AMEND_MSG;
> >  	}
> >  
> > -	if (run_git_commit(rebase_path_message(), opts, flags))
> > +	if (is_clean) {
> > +		const char *cherry_pick_head = git_path_cherry_pick_head();
> > +
> > +		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
> > +			return error(_("could not remove CHERRY_PICK_HEAD"));
> > +		if (!final_fixup)
> > +			return 0;
> > +	}
> > +
> > +	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
> > +			   opts, flags))
> >  		return error(_("could not commit staged changes."));
> >  	unlink(rebase_path_amend());
> > +	if (final_fixup) {
> > +		unlink(rebase_path_fixup_msg());
> > +		unlink(rebase_path_squash_msg());
> > +	}
> > +	if (opts->current_fixup_count > 0) {
> > +		/*
> > +		 * Whether final fixup or not, we just cleaned up the commit
> > +		 * message...
> > +		 */
> > +		unlink(rebase_path_current_fixups());
> > +		strbuf_reset(&opts->current_fixups);
> > +		opts->current_fixup_count = 0;
> > +	}
> >  	return 0;
> >  }
> >  
> > @@ -2828,14 +2913,16 @@ int sequencer_continue(struct replay_opts *opts)
> >  	if (read_and_refresh_cache(opts))
> >  		return -1;
> >  
> > +	if (read_populate_opts(opts))
> > +		return -1;
> >  	if (is_rebase_i(opts)) {
> > -		if (commit_staged_changes(opts))
> > +		if ((res = read_populate_todo(&todo_list, opts)))
> > +			goto release_todo_list;
> > +		if (commit_staged_changes(opts, &todo_list))
> >  			return -1;
> >  	} else if (!file_exists(get_todo_path(opts)))
> >  		return continue_single_pick();
> > -	if (read_populate_opts(opts))
> > -		return -1;
> > -	if ((res = read_populate_todo(&todo_list, opts)))
> > +	else if ((res = read_populate_todo(&todo_list, opts)))
> >  		goto release_todo_list;
> >  
> >  	if (!is_rebase_i(opts)) {
> > diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> > index 3874f187246..03bf1b8a3b3 100755
> > --- a/t/t3418-rebase-continue.sh
> > +++ b/t/t3418-rebase-continue.sh
> > @@ -88,14 +88,14 @@ test_expect_success 'rebase passes merge strategy options correctly' '
> >  	git rebase --continue
> >  '
> >  
> > -test_expect_failure '--skip after failed fixup cleans commit message' '
> > +test_expect_success '--skip after failed fixup cleans commit message' '
> >  	test_when_finished "test_might_fail git rebase --abort" &&
> >  	git checkout -b with-conflicting-fixup &&
> >  	test_commit wants-fixup &&
> >  	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
> >  	test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
> >  	test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
> > -	test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
> > +	test_must_fail env FAKE_LINES="1 fixup 2 squash 4" \
> >  		git rebase -i HEAD~4 &&
> >  
> >  	: now there is a conflict, and comments in the commit message &&
> > @@ -103,11 +103,38 @@ test_expect_failure '--skip after failed fixup cleans commit message' '
> >  	grep "fixup! wants-fixup" out &&
> >  
> >  	: skip and continue &&
> > -	git rebase --skip &&
> > +	echo "cp \"\$1\" .git/copy.txt" | write_script copy-editor.sh &&
> > +	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
> > +
> > +	: the user should not have had to edit the commit message &&
> > +	test_path_is_missing .git/copy.txt &&
> >  
> >  	: now the comments in the commit message should have been cleaned up &&
> >  	git show HEAD >out &&
> > -	! grep "fixup! wants-fixup" out
> > +	! grep "fixup! wants-fixup" out &&
> > +
> > +	: now, let us ensure that "squash" is handled correctly &&
> > +	git reset --hard wants-fixup-3 &&
> > +	test_must_fail env FAKE_LINES="1 squash 4 squash 2 squash 4" \
> > +		git rebase -i HEAD~4 &&
> > +
> > +	: the first squash failed, but there are two more in the chain &&
> > +	(test_set_editor "$PWD/copy-editor.sh" &&
> > +	 test_must_fail git rebase --skip) &&
> > +
> > +	: not the final squash, no need to edit the commit message &&
> > +	test_path_is_missing .git/copy.txt &&
> > +
> > +	: The first squash was skipped, therefore: &&
> > +	git show HEAD >out &&
> > +	test_i18ngrep "# This is a combination of 2 commits" out &&
> > +
> > +	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
> > +	git show HEAD >out &&
> > +	test_i18ngrep ! "# This is a combination" out &&
> > +
> > +	: Final squash failed, but there was still a squash &&
> > +	test_i18ngrep "# This is a combination of 2 commits" .git/copy.txt
> >  '
> >  
> >  test_expect_success 'setup rerere database' '
> > 
> 
> 
