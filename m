Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466161F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 13:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJHUts (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 16:49:48 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:46924 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeJHUts (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 16:49:48 -0400
Received: from [192.168.2.240] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 9VjRglSx8oI6L9VjSgW8gE; Mon, 08 Oct 2018 14:37:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539005879;
        bh=dP0o3MYQ592qIpMdoDk+JzsYPIxyJTguou8UjZ27JEQ=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jLxXYXRafdSHp/B7laAu5UsP7n9qyl4JUPQkPpSEJM8GcXLmmFe136sOlzr9kxfWI
         Cxb6vo6lm/pCZot1ivlVkLZZD6EbGppKUWyC310OERHEhmXrblgZgqsSsChtk4EQKR
         29vB/SaxQaddi29CHJYMwbJxaOnZy60w7KBuvgks=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=pBoiBGr16XAn0NSo9gkA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/4] rebase --skip: clean up commit message after a
 failed fixup/squash
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
 <cover.1524862093.git.johannes.schindelin@gmx.de>
 <08609b5f2d5bc7f3f6d010088db4b58695dfbd64.1524862093.git.johannes.schindelin@gmx.de>
 <4bd08893-52b4-3a01-d546-4884e2762670@talktalk.net>
 <nycvar.QRO.7.76.6.1810021546500.2034@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <2861c8c3-9c49-de59-277a-21c2857bb914@talktalk.net>
Date:   Mon, 8 Oct 2018 14:37:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1810021546500.2034@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKl0Io+GZOCCST6wNZ9i4ZLDF+CxKW/mqUQpXmZkxO8rUtBQaQo57QWcaADpo4ewTxKYVFNX+OKDCwp1XLgSzKM8pKmpDuDIko0q9WZV9swNCJfUhUZs
 E9MWl87XsUEOAwXOhHRJErPrTFy3nr6J16LSNbvPjWojudvi2urVahHm1IkyRvt+ru9nIguEzJ0nludovnzpJbJxSyWjOJV5hFGcQxoiAO+/WvUtdLpNdKBZ
 W0FJWm4N2e1HhqVM+eMjjBiMjkVMpf1nIYG/j500kBRcTgl9CP3Un/9A94RxLZfNJWDteo2ixQtsUOO4NvTT/+fg+jY3zugqqS9B7gssWS3nIcxRThUq1yRE
 d5YCFklk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 02/10/2018 14:50, Johannes Schindelin wrote:
> Hi Phillip,
> 
> [sorry, I just got to this mail now]

Don't worry, I'm impressed you remembered it, I'd completely forgotten 
about it.

> 
> On Sun, 6 May 2018, Phillip Wood wrote:
> 
>> On 27/04/18 21:48, Johannes Schindelin wrote:
>>>
>>> During a series of fixup/squash commands, the interactive rebase builds
>>> up a commit message with comments. This will be presented to the user in
>>> the editor if at least one of those commands was a `squash`.
>>>
>>> In any case, the commit message will be cleaned up eventually, removing
>>> all those intermediate comments, in the final step of such a
>>> fixup/squash chain.
>>>
>>> However, if the last fixup/squash command in such a chain fails with
>>> merge conflicts, and if the user then decides to skip it (or resolve it
>>> to a clean worktree and then continue the rebase), the current code
>>> fails to clean up the commit message.
>>>
>>> This commit fixes that behavior.
>>>
>>> The fix is quite a bit more involved than meets the eye because it is
>>> not only about the question whether we are `git rebase --skip`ing a
>>> fixup or squash. It is also about removing the skipped fixup/squash's
>>> commit message from the accumulated commit message. And it is also about
>>> the question whether we should let the user edit the final commit
>>> message or not ("Was there a squash in the chain *that was not
>>> skipped*?").
>>>
>>> For example, in this case we will want to fix the commit message, but
>>> not open it in an editor:
>>>
>>> 	pick	<- succeeds
>>> 	fixup	<- succeeds
>>> 	squash	<- fails, will be skipped
>>>
>>> This is where the newly-introduced `current-fixups` file comes in real
>>> handy. A quick look and we can determine whether there was a non-skipped
>>> squash. We only need to make sure to keep it up to date with respect to
>>> skipped fixup/squash commands. As a bonus, we can even avoid committing
>>> unnecessarily, e.g. when there was only one fixup, and it failed, and
>>> was skipped.
>>>
>>> To fix only the bug where the final commit message was not cleaned up
>>> properly, but without fixing the rest, would have been more complicated
>>> than fixing it all in one go, hence this commit lumps together more than
>>> a single concern.
>>>
>>> For the same reason, this commit also adds a bit more to the existing
>>> test case for the regression we just fixed.
>>>
>>> The diff is best viewed with --color-moved.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>   sequencer.c                | 113 ++++++++++++++++++++++++++++++++-----
>>>   t/t3418-rebase-continue.sh |  35 ++++++++++--
>>>   2 files changed, 131 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 56166b0d6c7..cec180714ef 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> [...]
>>> @@ -2804,19 +2801,107 @@ static int commit_staged_changes(struct replay_opts *opts)
>>>   		if (get_oid_hex(rev.buf, &to_amend))
>>>   			return error(_("invalid contents: '%s'"),
>>>   				rebase_path_amend());
>>> -		if (oidcmp(&head, &to_amend))
>>> +		if (!is_clean && oidcmp(&head, &to_amend))
>>>   			return error(_("\nYou have uncommitted changes in your "
>>>   				       "working tree. Please, commit them\n"
>>>   				       "first and then run 'git rebase "
>>>   				       "--continue' again."));
>>> +		/*
>>> +		 * When skipping a failed fixup/squash, we need to edit the
>>> +		 * commit message, the current fixup list and count, and if it
>>> +		 * was the last fixup/squash in the chain, we need to clean up
>>> +		 * the commit message and if there was a squash, let the user
>>> +		 * edit it.
>>> +		 */
>>> +		if (is_clean && !oidcmp(&head, &to_amend) &&
>>> +		    opts->current_fixup_count > 0 &&
>>> +		    file_exists(rebase_path_stopped_sha())) {
>>> +			const char *p = opts->current_fixups.buf;
>>> +			int len = opts->current_fixups.len;
>>> +
>>> +			opts->current_fixup_count--;
>>> +			if (!len)
>>> +				BUG("Incorrect current_fixups:\n%s", p);
>>> +			while (len && p[len - 1] != '\n')
>>> +				len--;
>>> +			strbuf_setlen(&opts->current_fixups, len);
>>> +			if (write_message(p, len, rebase_path_current_fixups(),
>>> +					  0) < 0)
>>> +				return error(_("could not write file: '%s'"),
>>> +					     rebase_path_current_fixups());
>>> +
>>> +			/*
>>> +			 * If a fixup/squash in a fixup/squash chain failed, the
>>> +			 * commit message is already correct, no need to commit
>>> +			 * it again.
>>> +			 *
>>> +			 * Only if it is the final command in the fixup/squash
>>> +			 * chain, and only if the chain is longer than a single
>>> +			 * fixup/squash command (which was just skipped), do we
>>> +			 * actually need to re-commit with a cleaned up commit
>>> +			 * message.
>>> +			 */
>>> +			if (opts->current_fixup_count > 0 &&
>>> +			    !is_fixup(peek_command(todo_list, 0))) {
>>> +				final_fixup = 1;
>>> +				/*
>>> +				 * If there was not a single "squash" in the
>>> +				 * chain, we only need to clean up the commit
>>> +				 * message, no need to bother the user with
>>> +				 * opening the commit message in the editor.
>>> +				 */
>>> +				if (!starts_with(p, "squash ") &&
>>> +				    !strstr(p, "\nsquash "))
>>> +					flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
>>> +			} else if (is_fixup(peek_command(todo_list, 0))) {
>>> +				/*
>>> +				 * We need to update the squash message to skip
>>> +				 * the latest commit message.
>>> +				 */
>>> +				struct commit *commit;
>>> +				const char *path = rebase_path_squash_msg();
>>> +
>>> +				if (parse_head(&commit) ||
>>> +				    !(p = get_commit_buffer(commit, NULL)) ||
>>> +				    write_message(p, strlen(p), path, 0)) {
>>> +					unuse_commit_buffer(commit, p);
>>> +					return error(_("could not write file: "
>>> +						       "'%s'"), path);
>>> +				}
>>
>> I think it should probably recreate the fixup message as well. If there
>> is a sequence
>>
>> pick commit
>> fixup a
>> fixup b
>> fixup c
>>
>> and 'fixup b' gets skipped then when 'fixup c' is applied the user will
>> be prompted to edit the message unless rebase_path_fixup_msg() exists.
> 
> I was already on my way to fix this when I encountered this mail 30
> minutes ago, but when I tried to implement the regression test, I took a
> step back: apart from "disk full" and "pilot error", there is really no
> good reason for the `message-squash` file not being able to be written.

Ah, I should perhaps have cut the patch a line higher to make it clearer 
I was not talking about the error condition. The code rewrites 
'message-squash' to remove the commit message from the skipped 
fixup/squash. However if we have skipped a fixup and there are no 
preceding squash commands then when rebase stopped for the user to fix 
the merge conflicts it removed the 'message-fixup' file. I thought (and 
still think) it would be nice if 'rebase --skip' recreated the 
'message-fixup' file so that the user is not unnecessarily prompted to 
edit the commit message at the end of the fixup chain but it's not the 
end of the world if it stays as it is now.

Best Wishes

Phillip

> 
> And in both cases, a benign `git status` will show the latest command,
> i.e. the one that failed.
> 
> In other words: I now deem this such a corner case that it is not worth
> spending more time on the error message than we already did...
> 
> Ciao,
> Dscho
> 
>>
>> Best Wishes
>>
>> Phillip
>>
>>> +				unuse_commit_buffer(commit, p);
>>> +			}
>>> +		}
>>>   
>>>   		strbuf_release(&rev);
>>>   		flags |= AMEND_MSG;
>>>   	}
>>>   
>>> -	if (run_git_commit(rebase_path_message(), opts, flags))
>>> +	if (is_clean) {
>>> +		const char *cherry_pick_head = git_path_cherry_pick_head();
>>> +
>>> +		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
>>> +			return error(_("could not remove CHERRY_PICK_HEAD"));
>>> +		if (!final_fixup)
>>> +			return 0;
>>> +	}
>>> +
>>> +	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
>>> +			   opts, flags))
>>>   		return error(_("could not commit staged changes."));
>>>   	unlink(rebase_path_amend());
>>> +	if (final_fixup) {
>>> +		unlink(rebase_path_fixup_msg());
>>> +		unlink(rebase_path_squash_msg());
>>> +	}
>>> +	if (opts->current_fixup_count > 0) {
>>> +		/*
>>> +		 * Whether final fixup or not, we just cleaned up the commit
>>> +		 * message...
>>> +		 */
>>> +		unlink(rebase_path_current_fixups());
>>> +		strbuf_reset(&opts->current_fixups);
>>> +		opts->current_fixup_count = 0;
>>> +	}
>>>   	return 0;
>>>   }
>>>   
>>> @@ -2828,14 +2913,16 @@ int sequencer_continue(struct replay_opts *opts)
>>>   	if (read_and_refresh_cache(opts))
>>>   		return -1;
>>>   
>>> +	if (read_populate_opts(opts))
>>> +		return -1;
>>>   	if (is_rebase_i(opts)) {
>>> -		if (commit_staged_changes(opts))
>>> +		if ((res = read_populate_todo(&todo_list, opts)))
>>> +			goto release_todo_list;
>>> +		if (commit_staged_changes(opts, &todo_list))
>>>   			return -1;
>>>   	} else if (!file_exists(get_todo_path(opts)))
>>>   		return continue_single_pick();
>>> -	if (read_populate_opts(opts))
>>> -		return -1;
>>> -	if ((res = read_populate_todo(&todo_list, opts)))
>>> +	else if ((res = read_populate_todo(&todo_list, opts)))
>>>   		goto release_todo_list;
>>>   
>>>   	if (!is_rebase_i(opts)) {
>>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>>> index 3874f187246..03bf1b8a3b3 100755
>>> --- a/t/t3418-rebase-continue.sh
>>> +++ b/t/t3418-rebase-continue.sh
>>> @@ -88,14 +88,14 @@ test_expect_success 'rebase passes merge strategy options correctly' '
>>>   	git rebase --continue
>>>   '
>>>   
>>> -test_expect_failure '--skip after failed fixup cleans commit message' '
>>> +test_expect_success '--skip after failed fixup cleans commit message' '
>>>   	test_when_finished "test_might_fail git rebase --abort" &&
>>>   	git checkout -b with-conflicting-fixup &&
>>>   	test_commit wants-fixup &&
>>>   	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
>>>   	test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
>>>   	test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
>>> -	test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
>>> +	test_must_fail env FAKE_LINES="1 fixup 2 squash 4" \
>>>   		git rebase -i HEAD~4 &&
>>>   
>>>   	: now there is a conflict, and comments in the commit message &&
>>> @@ -103,11 +103,38 @@ test_expect_failure '--skip after failed fixup cleans commit message' '
>>>   	grep "fixup! wants-fixup" out &&
>>>   
>>>   	: skip and continue &&
>>> -	git rebase --skip &&
>>> +	echo "cp \"\$1\" .git/copy.txt" | write_script copy-editor.sh &&
>>> +	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
>>> +
>>> +	: the user should not have had to edit the commit message &&
>>> +	test_path_is_missing .git/copy.txt &&
>>>   
>>>   	: now the comments in the commit message should have been cleaned up &&
>>>   	git show HEAD >out &&
>>> -	! grep "fixup! wants-fixup" out
>>> +	! grep "fixup! wants-fixup" out &&
>>> +
>>> +	: now, let us ensure that "squash" is handled correctly &&
>>> +	git reset --hard wants-fixup-3 &&
>>> +	test_must_fail env FAKE_LINES="1 squash 4 squash 2 squash 4" \
>>> +		git rebase -i HEAD~4 &&
>>> +
>>> +	: the first squash failed, but there are two more in the chain &&
>>> +	(test_set_editor "$PWD/copy-editor.sh" &&
>>> +	 test_must_fail git rebase --skip) &&
>>> +
>>> +	: not the final squash, no need to edit the commit message &&
>>> +	test_path_is_missing .git/copy.txt &&
>>> +
>>> +	: The first squash was skipped, therefore: &&
>>> +	git show HEAD >out &&
>>> +	test_i18ngrep "# This is a combination of 2 commits" out &&
>>> +
>>> +	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
>>> +	git show HEAD >out &&
>>> +	test_i18ngrep ! "# This is a combination" out &&
>>> +
>>> +	: Final squash failed, but there was still a squash &&
>>> +	test_i18ngrep "# This is a combination of 2 commits" .git/copy.txt
>>>   '
>>>   
>>>   test_expect_success 'setup rerere database' '
>>>
>>
>>

