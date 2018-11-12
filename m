Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8BE01F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeKMAUF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:20:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:39667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbeKMAUF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:20:05 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqRKT-1fr15548R7-00e68t; Mon, 12
 Nov 2018 15:26:31 +0100
Date:   Mon, 12 Nov 2018 15:26:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Fix built-in rebase perf regression
In-Reply-To: <pull.72.v2.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811121521300.39@tvgsbejvaqbjf.bet>
References: <pull.72.git.gitgitgadget@gmail.com> <pull.72.v2.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fHz8cm2Ig5WFnF53358fd/jO1nyuzWag+URYGXKpyr7nBCXIkVK
 rt95zLJDUiYweMac9jrryKZLqFx0fl9ZcRFu+XYrMdNEb7Xvg7x1MFJPRj1ZbJWK9E8qx/2
 pXokSBYglloevlfo2ld+3Y2Y8zBXadF52UNzk7TVposN8E5T43XbxqSgzomdfiR2aKd1hoK
 0/WfDh9OYKqASS6fXBq8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e5zGi+H7+s0=:2fXpzbZDiZYg8Dbz0XRWSl
 JSMfXr/kvFJppJTlomH8QTlw66CSr0Xmg+0vFpdCayBmSpEWVilpo8GFCJPDDowpgmARZhO/+
 qpc0/zsH4Cq5INGyJYk1RWKmeynWx7GQv7wo1YjptvIl/Dq8IWSVNG924IKgsxIMfJNxmapRp
 kX0MpdqanODao6me2FSq/ehjcjKgDloj7CwMRvwt4RLd+sQ+K/D/ZEZk9ZfKZRnYi6WwMF9DJ
 j0MZvazd46YEhPNcvlz575M4EmPj5G1x24wycNBirbvReV2BJcsWTeuUqrrpk2s6frhJdED2V
 PgPUU0QaUByNJKhkFDyD67ox4hlyxCja4Bu6WgXPot8uMT0hruEuagpOtKX690GC5SUuqGNI5
 YDW8fDfmOE8DjxSzf/KNBpwP2qwU8qkXXE8qeiXMA+ABbiZT3njbEkQPiJeyAKDcJmqYh1g+m
 V/N2Z32bs7rvQ3u+NW22fnDYGFA64GL7Yk/HpXQAv1t4+zvXbhLDEVO9V0eJ4CEesafrpQAlT
 /DZrrDj+BOkmcy70XDLgyHC4XLir4XXX12kbRPwkx031dgwXGYXo/n857UigHv++tDDgXYZ7n
 ewlYcxoSPvFI2GsU5+vwVJZ1+L1tHF1wlrog74FKlCIYY8z9WeaJDDK+a28AQiYSm5+cuh3mf
 moNo1hFj2FEDu+KBgBLQmXTb0ZcUdB5XUoUE+hxd1qGdNqqVOKpBWMyFqokfC+Khq8RkDSD4r
 fkLHEoyxgjTk+iAhGtjL5VXrSV8LTv+8gVc3TUxdoJCvmd4POz9dyNQabkhTjnva/VSwVrlX+
 hVxw/Q3o6FFnP5WFMN9AmglgYJUO7CmfDoIsk8CnUYTrb7+6iHOsYX6WeMsf8qRWiaR6pGmVW
 yy0elc57Ai95zS9224uhEMsyAnn/X/dLm5B9bD7S0JdLNDMAjNe/h0EwFfcAx0+ni3L/QW5TY
 xUdWmfZxOKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 12 Nov 2018, Johannes Schindelin via GitGitGadget wrote:

> In our tests with large repositories, we noticed a serious regression of the
> performance of git rebase when using the built-in vs the shell script
> version. It boils down to an incorrect conversion of a git checkout -q:
> instead of using a twoway_merge as git checkout does, we used a oneway_merge 
> as git reset does. The latter, however, calls lstat() on all files listed in
> the index, while the former essentially looks only at the files that are
> different between the given two revisions.
> 
> Let's reinstate the original behavior by introducing a flag to the 
> reset_head() function to indicate whether we want to emulate reset --hard 
> (in which case we use the oneway_merge, otherwise we use twoway_merge).
> 
> Johannes Schindelin (3):
>   rebase: consolidate clean-up code before leaving reset_head()
>   rebase: prepare reset_head() for more flags
>   built-in rebase: reinstate `checkout -q` behavior where appropriate
> 
>  builtin/rebase.c | 79 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 33 deletions(-)

I forgot to specify the changes vs v1:

- More error paths are not consolidated via `goto leave_reset_head`.
- The `desc` array is not initialized to all-zero, to avoid bogus
  addresses being passed to `free()`.
- The `detach_head` and `reset_hard` parameters have been consolidated
  into a `flags` parameter.
- The `reset_head()` function once again only initializes `head_oid`
  when needed.

Sorry for the omission,
Johannes

> 
> 
> base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-72%2Fdscho%2Fbuiltin-rebase-perf-regression-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-72/dscho/builtin-rebase-perf-regression-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/72
> 
> Range-diff vs v1:
> 
>  1:  64597fe827 ! 1:  28e24d98ab rebase: consolidate clean-up code before leaving reset_head()
>      @@ -11,6 +11,33 @@
>       --- a/builtin/rebase.c
>       +++ b/builtin/rebase.c
>       @@
>      + 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
>      + 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
>      + 
>      +-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
>      +-		return -1;
>      ++	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
>      ++		ret = -1;
>      ++		goto leave_reset_head;
>      ++	}
>      + 
>      + 	if (!oid) {
>      + 		if (get_oid("HEAD", &head_oid)) {
>      +-			rollback_lock_file(&lock);
>      +-			return error(_("could not determine HEAD revision"));
>      ++			ret = error(_("could not determine HEAD revision"));
>      ++			goto leave_reset_head;
>      + 		}
>      + 		oid = &head_oid;
>      + 	}
>      +@@
>      + 		unpack_tree_opts.reset = 1;
>      + 
>      + 	if (read_index_unmerged(the_repository->index) < 0) {
>      +-		rollback_lock_file(&lock);
>      +-		return error(_("could not read index"));
>      ++		ret = error(_("could not read index"));
>      ++		goto leave_reset_head;
>        	}
>        
>        	if (!fill_tree_descriptor(&desc, oid)) {
>      @@ -31,15 +58,17 @@
>        	}
>        
>        	tree = parse_tree_indirect(oid);
>      -@@
>      + 	prime_cache_tree(the_repository->index, tree);
>        
>      - 	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0)
>      +-	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0)
>      ++	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
>        		ret = error(_("could not write index"));
>       -	free((void *)desc.buffer);
>      - 
>      - 	if (ret)
>      +-
>      +-	if (ret)
>       -		return ret;
>       +		goto leave_reset_head;
>      ++	}
>        
>        	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
>        	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
>  -:  ---------- > 2:  db963b2094 rebase: prepare reset_head() for more flags
>  2:  070092b430 ! 3:  a7360b856f built-in rebase: reinstate `checkout -q` behavior where appropriate
>      @@ -20,15 +20,18 @@
>       @@
>        #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
>        
>      + #define RESET_HEAD_DETACH (1<<0)
>      ++#define RESET_HEAD_HARD (1<<1)
>      + 
>        static int reset_head(struct object_id *oid, const char *action,
>      --		      const char *switch_to_branch, int detach_head,
>      -+		      const char *switch_to_branch,
>      -+		      int detach_head, int reset_hard,
>      + 		      const char *switch_to_branch, unsigned flags,
>        		      const char *reflog_orig_head, const char *reflog_head)
>        {
>      + 	unsigned detach_head = flags & RESET_HEAD_DETACH;
>      ++	unsigned reset_hard = flags & RESET_HEAD_HARD;
>        	struct object_id head_oid;
>       -	struct tree_desc desc;
>      -+	struct tree_desc desc[2];
>      ++	struct tree_desc desc[2] = { { NULL }, { NULL } };
>        	struct lock_file lock = LOCK_INIT;
>        	struct unpack_trees_options unpack_tree_opts;
>        	struct tree *tree;
>      @@ -42,18 +45,18 @@
>        	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
>        		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
>       @@
>      - 	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
>      - 		return -1;
>      + 		goto leave_reset_head;
>      + 	}
>        
>       -	if (!oid) {
>       -		if (get_oid("HEAD", &head_oid)) {
>      --			rollback_lock_file(&lock);
>      --			return error(_("could not determine HEAD revision"));
>      +-			ret = error(_("could not determine HEAD revision"));
>      +-			goto leave_reset_head;
>       -		}
>       -		oid = &head_oid;
>      -+	if (get_oid("HEAD", &head_oid)) {
>      -+		rollback_lock_file(&lock);
>      -+		return error(_("could not determine HEAD revision"));
>      ++	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
>      ++		ret = error(_("could not determine HEAD revision"));
>      ++		goto leave_reset_head;
>        	}
>        
>       +	if (!oid)
>      @@ -70,7 +73,7 @@
>        	unpack_tree_opts.merge = 1;
>        	if (!detach_head)
>       @@
>      - 		return error(_("could not read index"));
>      + 		goto leave_reset_head;
>        	}
>        
>       -	if (!fill_tree_descriptor(&desc, oid)) {
>      @@ -104,7 +107,8 @@
>        		string_list_clear(&merge_rr, 1);
>        
>       -		if (reset_head(NULL, "reset", NULL, 0, NULL, NULL) < 0)
>      -+		if (reset_head(NULL, "reset", NULL, 0, 1, NULL, NULL) < 0)
>      ++		if (reset_head(NULL, "reset", NULL, RESET_HEAD_HARD,
>      ++			       NULL, NULL) < 0)
>        			die(_("could not discard worktree changes"));
>        		if (read_basic_state(&options))
>        			exit(1);
>      @@ -113,7 +117,8 @@
>        			exit(1);
>        		if (reset_head(&options.orig_head, "reset",
>       -			       options.head_name, 0, NULL, NULL) < 0)
>      -+			       options.head_name, 0, 1, NULL, NULL) < 0)
>      ++			       options.head_name, RESET_HEAD_HARD,
>      ++			       NULL, NULL) < 0)
>        			die(_("could not move back to %s"),
>        			    oid_to_hex(&options.orig_head));
>        		ret = finish_rebase(&options);
>      @@ -122,34 +127,7 @@
>        			printf(_("Created autostash: %s\n"), buf.buf);
>        			if (reset_head(&head->object.oid, "reset --hard",
>       -				       NULL, 0, NULL, NULL) < 0)
>      -+				       NULL, 0, 1, NULL, NULL) < 0)
>      ++				       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
>        				die(_("could not reset --hard"));
>        			printf(_("HEAD is now at %s"),
>        			       find_unique_abbrev(&head->object.oid,
>      -@@
>      - 				strbuf_addf(&buf, "rebase: checkout %s",
>      - 					    options.switch_to);
>      - 				if (reset_head(&oid, "checkout",
>      --					       options.head_name, 0,
>      -+					       options.head_name, 0, 0,
>      - 					       NULL, NULL) < 0) {
>      - 					ret = !!error(_("could not switch to "
>      - 							"%s"),
>      -@@
>      - 			 "it...\n"));
>      - 
>      - 	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
>      --	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1,
>      -+	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1, 0,
>      - 	    NULL, msg.buf))
>      - 		die(_("Could not detach HEAD"));
>      - 	strbuf_release(&msg);
>      -@@
>      - 		strbuf_addf(&msg, "rebase finished: %s onto %s",
>      - 			options.head_name ? options.head_name : "detached HEAD",
>      - 			oid_to_hex(&options.onto->object.oid));
>      --		reset_head(NULL, "Fast-forwarded", options.head_name, 0,
>      -+		reset_head(NULL, "Fast-forwarded", options.head_name, 0, 0,
>      - 			   "HEAD", msg.buf);
>      - 		strbuf_release(&msg);
>      - 		ret = !!finish_rebase(&options);
> 
> -- 
> gitgitgadget
> 
