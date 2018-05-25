Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA651F42D
	for <e@80x24.org>; Fri, 25 May 2018 14:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936147AbeEYOTT (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 10:19:19 -0400
Received: from mail.javad.com ([54.86.164.124]:48746 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935791AbeEYOTR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 10:19:17 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6D0233E99B;
        Fri, 25 May 2018 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527257956;
        bh=omlUtS6aE2uaNbHLb8h152slxk8Y3EL6OsyRGAWMNDQ=; l=8544;
        h=Received:From:To:Subject;
        b=BwaGK7EhsQY924tpIS0V3YTvqulTMZSvKOwe5vPeRtvKN6C0FNBYIIncxREAcYZbB
         EQRW/MlJDW+KgDIA7Nc+4Vft9zkNaeW2Xt9laf+e5NomFQ9sRBM/gmVMMvpqnMSJ7S
         +yY8dUNKXDxSEFQBV9Ok4k0qaTTBi4Zzjk0Z2klw=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1fMDYo-0002c9-QE; Fri, 25 May 2018 17:19:14 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v9 00/17] rebase -i: offer to recreate commit topology by rebasing merges
References: <cover.1524306546.git.johannes.schindelin@gmx.de>
        <cover.1524659287.git.johannes.schindelin@gmx.de>
Date:   Fri, 25 May 2018 17:19:14 +0300
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Wed, 25 Apr 2018 14:28:08 +0200")
Message-ID: <87zi0nvmvx.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Junio, I think this is now ready for `next`. Thank you for your patience
> and help with this.
>
> Once upon a time, I dreamed of an interactive rebase that would not
> linearize all patches and drop all merge commits, but instead recreate
> the commit topology faithfully.
>
> My original attempt was --preserve-merges, but that design was so
> limited that I did not even enable it in interactive mode.
>
> Subsequently, it *was* enabled in interactive mode, with the predictable
> consequences: as the --preserve-merges design does not allow for
> specifying the parents of merge commits explicitly, all the new commits'
> parents are defined *implicitly* by the previous commit history, and
> hence it is *not possible to even reorder commits*.
>
> This design flaw cannot be fixed. Not without a complete re-design, at
> least. This patch series offers such a re-design.
>
> Think of --rebase-merges as "--preserve-merges done right". It
> introduces new verbs for the todo list, `label`, `reset` and `merge`.
> For a commit topology like this:
>
>             A - B - C
>               \   /
>                 D
>
> the generated todo list would look like this:
>
>             # branch D
>             pick 0123 A
>             label branch-point
>             pick 1234 D
>             label D
>
>             reset branch-point
>             pick 2345 B
>             merge -C 3456 D # C
>
> There are more patches in the pipeline, based on this patch series, but
> left for later in the interest of reviewable patch series: one mini
> series to use the sequencer even for `git rebase -i --root`, and another
> one to add support for octopus merges to --rebase-merges. And then one
> to allow for rebasing merge commits in a smarter way (this one will need
> a bit more work, though, as it can result in very complicated, nested
> merge conflicts *very* easily).
>
> Changes since v8:
>
> - Disentangled the patch introducing `label`/`reset` from the one
>   introducing `merge` again (this was one stupid, tired `git commit
>   --amend` too many).
>
> - Augmented the commit message of "introduce the `merge` command" to
>   describe what the `label onto` is all about.
>
> - Fixed the error message when `reset` would overwrite untracked files to
>   actually say that a "reset" failed (not a "merge").
>
> - Clarified the rationale for `label onto` in the commit message of
>   "rebase-helper --make-script: introduce a flag to rebase merges".
>
> - Edited the description of `--rebase-merges` heavily, for clarity, in
>   "rebase: introduce the --rebase-merges option".
>
> - Edited the commit message of (and the documentation introduced by) " rebase
>   -i: introduce --rebase-merges=[no-]rebase-cousins" for clarity (also
>   mentioning the `--ancestry-path` option).
>
> - When run_git_commit() fails after a successful merge, we now take pains
>   not to reschedule the `merge` command.
>
> - Rebased the patch series on top of current `master`, i.e. both
>   `pw/rebase-keep-empty-fixes` and `pw/rebase-signoff`, to resolve merge
>   conflicts myself.
>
>
> Johannes Schindelin (15):
>   sequencer: avoid using errno clobbered by rollback_lock_file()
>   sequencer: make rearrange_squash() a bit more obvious
>   sequencer: refactor how original todo list lines are accessed
>   sequencer: offer helpful advice when a command was rescheduled
>   sequencer: introduce new commands to reset the revision
>   sequencer: introduce the `merge` command
>   sequencer: fast-forward `merge` commands, if possible
>   rebase-helper --make-script: introduce a flag to rebase merges
>   rebase: introduce the --rebase-merges option
>   sequencer: make refs generated by the `label` command worktree-local
>   sequencer: handle post-rewrite for merge commands
>   rebase --rebase-merges: avoid "empty merges"
>   pull: accept --rebase=merges to recreate the branch topology
>   rebase -i: introduce --rebase-merges=[no-]rebase-cousins
>   rebase -i --rebase-merges: add a section to the man page
>
> Phillip Wood (1):
>   rebase --rebase-merges: add test for --keep-empty
>
> Stefan Beller (1):
>   git-rebase--interactive: clarify arguments
>
>  Documentation/config.txt               |   8 +
>  Documentation/git-pull.txt             |   6 +-
>  Documentation/git-rebase.txt           | 163 ++++-
>  builtin/pull.c                         |  14 +-
>  builtin/rebase--helper.c               |  13 +-
>  builtin/remote.c                       |  18 +-
>  contrib/completion/git-completion.bash |   4 +-
>  git-rebase--interactive.sh             |  22 +-
>  git-rebase.sh                          |  16 +
>  refs.c                                 |   3 +-
>  sequencer.c                            | 892 ++++++++++++++++++++++++-
>  sequencer.h                            |   7 +
>  t/t3421-rebase-topology-linear.sh      |   1 +
>  t/t3430-rebase-merges.sh               | 244 +++++++
>  14 files changed, 1352 insertions(+), 59 deletions(-)
>  create mode 100755 t/t3430-rebase-merges.sh
>
>
> base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
> Published-As: https://github.com/dscho/git/releases/tag/recreate-merges-v9
> Fetch-It-Via: git fetch https://github.com/dscho/git recreate-merges-v9
>
> Interdiff vs v8:
>  diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>  index e691b93e920..bd5ecff980e 100644
>  --- a/Documentation/git-rebase.txt
>  +++ b/Documentation/git-rebase.txt
>  @@ -381,21 +381,24 @@ have the long commit hash prepended to the format.
>   
>   -r::
>   --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
>  -	By default, a rebase will simply drop merge commits and only rebase
>  -	the non-merge commits. With this option, it will try to preserve
>  +	By default, a rebase will simply drop merge commits from the todo
>  +	list, and put the rebased commits into a single, linear branch.
>  +	With `--rebase-merges`, the rebase will instead try to preserve
>   	the branching structure within the commits that are to be rebased,
>  -	by recreating the merge commits. If a merge commit resolved any merge
>  -	or contained manual amendments, then they will have to be re-applied
>  -	manually.
>  +	by recreating the merge commits. Any resolved merge conflicts or
>  +	manual amendments in these merge commits will have to be
>  +	resolved/re-applied manually.
>   +
>   By default, or when `no-rebase-cousins` was specified, commits which do not
>  -have `<upstream>` as direct ancestor will keep their original branch point.
>  -If the `rebase-cousins` mode is turned on, such commits are instead rebased
>  +have `<upstream>` as direct ancestor will keep their original branch point,
>  +i.e. commits that would be excluded by gitlink:git-log[1]'s
>  +`--ancestry-path` option will keep their original ancestry by default. If
>  +the `rebase-cousins` mode is turned on, such commits are instead rebased
>   onto `<upstream>` (or `<onto>`, if specified).
>   +
>  -This mode is similar in spirit to `--preserve-merges`, but in contrast to
>  -that option works well in interactive rebases: commits can be reordered,
>  -inserted and dropped at will.
>  +The `--rebase-merges` mode is similar in spirit to `--preserve-merges`, but
>  +in contrast to that option works well in interactive rebases: commits can be
>  +reordered, inserted and dropped at will.
>   +
>   It is currently only possible to recreate the merge commits using the
>   `recursive` merge strategy; Different merge strategies can be used only via
>  diff --git a/sequencer.c b/sequencer.c
>  index b5715f69450..e2f83942843 100644
>  --- a/sequencer.c
>  +++ b/sequencer.c
>  @@ -2635,6 +2635,7 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
>   	}
>   
>   	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
>  +	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
>   	unpack_tree_opts.head_idx = 1;
>   	unpack_tree_opts.src_index = &the_index;
>   	unpack_tree_opts.dst_index = &the_index;
>  @@ -2855,7 +2856,12 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
>   	if (ret)
>   		rerere(opts->allow_rerere_auto);
>   	else
>  -		ret = run_git_commit(git_path_merge_msg(), opts,
>  +		/*
>  +		 * In case of problems, we now want to return a positive
>  +		 * value (a negative one would indicate that the `merge`
>  +		 * command needs to be rescheduled).
>  +		 */
>  +		ret = !!run_git_commit(git_path_merge_msg(), opts,
>   				     run_commit_flags);
>   
>   leave_merge:
>  @@ -3809,12 +3815,9 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
>   
>   	init_revisions(&revs, NULL);
>   	revs.verbose_header = 1;
>  -	if (rebase_merges)
>  -		revs.cherry_mark = 1;
>  -	else {
>  +	if (!rebase_merges)
>   		revs.max_parents = 1;
>  -		revs.cherry_pick = 1;
>  -	}
>  +	revs.cherry_mark = 1;
>   	revs.limited = 1;
>   	revs.reverse = 1;
>   	revs.right_only = 1;
