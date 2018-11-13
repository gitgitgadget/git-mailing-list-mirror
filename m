Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887E91F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 09:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbeKMTPj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 14:15:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:44355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731001AbeKMTPj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 14:15:39 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOf5S-1gRQFQ2QiM-0068TW; Tue, 13
 Nov 2018 10:18:18 +0100
Date:   Tue, 13 Nov 2018 10:18:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, predatoramigo@gmail.com
Subject: Re: [PATCH v2 2/2] rebase: Implement --merge via
 git-rebase--interactive
In-Reply-To: <f0231c21-8727-94cb-96aa-13ebfb5b7283@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1811131017250.39@tvgsbejvaqbjf.bet>
References: <20181108060158.27145-1-newren@gmail.com> <20181108060158.27145-3-newren@gmail.com> <nycvar.QRO.7.76.6.1811121614190.39@tvgsbejvaqbjf.bet> <f0231c21-8727-94cb-96aa-13ebfb5b7283@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dYYtZQob3aeZZAhQltBTxGbKRZ0ESLU5EMjB93teSmJJdoyZUWi
 ANq7CCmHFiN5s1j7ca+ctTalV9P7QI8/0yFp7h/+Xh4Fv4N/XvHH/c/itZ5qHROjd3dAYhO
 FVPEr/tUVy5L5I17YXUZq/FC1gyKnjzz/NGa89uylnvaZtogPA10d5EjC/g6M9dmwU0Vzsj
 aRP3I9dRa9xDybUUmQ66g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nFNHRnSTZ4w=:6w95akSgRcCXkLcNghc+cJ
 CedxHf3l6PGN5MmVCGuWAKy+PNnEturF1YaQxvT8Rzwmw9D56xiLrHyFLQZwB8ZJX9lA4NE/A
 nBg/iSKUxHWMDzNuEa+Vs/qzRsBsyghJaitBCdXhwFud5wtsIMBSednRUn6CU8yGOiEJXr/83
 x120yFdv2P/WJ8OVKh88vBh9vTHdwg/viJoYDOcVDOEUCumXYaM0OqWCerfCsHPx8txeLYtV6
 QpnL5kSdYyooiwsERiliK71cQtah1YL9WgEYLrY3/+pzOSK1+oQ545Wy4NaTrrrRJ78OJ3TTm
 LsX4pQKcUz3Vsk0QBM8m1pahL0iETbcWdff0s1M88HBROT6dhGvTQQLFYqt/6Wyw/q7cr/xvy
 6bj1j42YpxKPs+LJl/8deUM2V9rhoYubF2MVX41ktIyXbwaLPwCWMOwxa7YjCFCynr45/FIM9
 SB0X9sWxBmxGK5SgnA1OHNp3PbAdJyGFv6ksknP5WIikEdhE8S8kg0OCU9TVRrBvuRRr5PO9C
 jPh57TpRDbM8IQo9aaESZTEzm0HXrj8N9ZXrIjhwErHc1Rata9+5BGkCxjLGInH64eQuXQlfG
 tqxXfOtpYefVPuran1od/AU6vdIMgQ6CKygT1pkPGXS5PcARLfff8oRIWzarPbpBxQKhL83ke
 9lBZpRRbhntLYcVEQQTQ/KyzrL6qvC8+UQqF+ldR2iBzDAfr4Qoasjbenqw8vWivL3rzVXweH
 2/Gs4UOiBTcvw0x7U01frFFqpaKA+Ti0N9QRKj3x78CdaICpvd+GSQRlgJ0GC5i5wXnAS3drH
 IYxeu/3CSifTscohOrOTXSMhBboLt4Rdi/ZlkIG/fVE0PCsHdidk4RlmfnsBvbAjsC0MJUMdp
 hZPkwjAk0N4ePIV/i+UMG46t/J3hS1c2g9DACuqKKo6NPRmYf/hF9fjBhh0wilGKGhipXjRq+
 M4cekvOOATA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 12 Nov 2018, Phillip Wood wrote:

> It's good to see these patches progressing, I've just got a couple of
> comments related to Johannes' points below
> 
> On 12/11/2018 16:21, Johannes Schindelin wrote:
> > Hi Elijah,
> > 
> > On Wed, 7 Nov 2018, Elijah Newren wrote:
> > 
> >> Interactive rebases are implemented in terms of cherry-pick rather than
> >> the merge-recursive builtin, but cherry-pick also calls into the recursive
> >> merge machinery by default and can accept special merge strategies and/or
> >> special strategy options.  As such, there really is not any need for
> >> having both git-rebase--merge and git-rebase--interactive anymore.
> >>
> >> Delete git-rebase--merge.sh and have the --merge option be implemented
> >> by the now built-in interactive machinery.
> > 
> > Okay.
> > 
> >> Note that this change fixes a few known test failures (see t3421).
> > 
> > Nice!
> > 
> >> testcase modification notes:
> >>   t3406: --interactive and --merge had slightly different progress output
> >>          while running; adjust a test to match
> >>   t3420: these test precise output while running, but rebase--am,
> >>          rebase--merge, and rebase--interactive all were built on very
> >>          different commands (am, merge-recursive, cherry-pick), so the
> >>          tests expected different output for each type.  Now we expect
> >>          --merge and --interactive to have the same output.
> >>   t3421: --interactive fixes some bugs in --merge!  Wahoo!
> >>   t3425: topology linearization was inconsistent across flavors of rebase,
> >>          as already noted in a TODO comment in the testcase.  This was not
> >>          considered a bug before, so getting a different linearization due
> >>          to switching out backends should not be considered a bug now.
> > 
> > Ideally, the test would be fixed, then. If it fails for other reasons than
> > a real regression, it is not a very good regression test, is it.
> > 
> >>   t5407: different rebase types varied slightly in how many times checkout
> >>          or commit or equivalents were called based on a quick comparison
> >>          of this tests and previous ones which covered different rebase
> >>          flavors.  I think this is just attributable to this difference.
> > 
> > This concerns me.
> > 
> > In bigger repositories (no, I am not talking about Linux kernel sized
> > ones, I consider those small-ish) there are a ton of files, and checkout
> > and commit (and even more so reset) sadly do not have a runtime complexity
> > growing with the number of modified files, but with the number of tracked
> > files (and some commands even with the number of worktree files).
> > 
> > So a larger number of commit/checkout operations makes me expect
> > performance regressions.
> > 
> > In this light, could you elaborate a bit on the differences you see
> > between rebase -i and rebase -m?
> > 
> >>   t9903: --merge uses the interactive backend so the prompt expected is
> >>          now REBASE-i.
> > 
> > We should be able to make that test pass, still, by writing out a special
> > file (e.g. $state_dir/opt_m) and testing for that. Users are oddly upset
> > when their expectations are broken... (and I actually agree with them.)
> > 
> >> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> >> index 3407d835bd..35084f5681 100644
> >> --- a/Documentation/git-rebase.txt
> >> +++ b/Documentation/git-rebase.txt
> >> @@ -504,15 +504,7 @@ See also INCOMPATIBLE OPTIONS below.
> >>  INCOMPATIBLE OPTIONS
> >>  --------------------
> >>  
> >> -git-rebase has many flags that are incompatible with each other,
> >> -predominantly due to the fact that it has three different underlying
> >> -implementations:
> >> -
> >> - * one based on linkgit:git-am[1] (the default)
> >> - * one based on git-merge-recursive (merge backend)
> >> - * one based on linkgit:git-cherry-pick[1] (interactive backend)
> >> -
> > 
> > Could we retain this part, with `s/three/two/` and `/git-merge/d`? *Maybe*
> > `s/interactive backend/interactive\/merge backend/`
> 
> I was hoping we could get rid of that, I'm not sure how useful it is to
> users.

That's a good point. If the commit message makes the case for that (it is
an implementation detail that confuses users), I am fine with removing it,
too.

Thanks,
Dscho

> 
> > 
> >> -Flags only understood by the am backend:
> >> +The following options:
> >>  
> >>   * --committer-date-is-author-date
> >>   * --ignore-date
> >> @@ -520,15 +512,12 @@ Flags only understood by the am backend:
> >>   * --ignore-whitespace
> >>   * -C
> >>  
> >> -Flags understood by both merge and interactive backends:
> >> +are incompatible with the following options:
> >>  
> >>   * --merge
> >>   * --strategy
> >>   * --strategy-option
> >>   * --allow-empty-message
> >> -
> >> -Flags only understood by the interactive backend:
> >> -
> 
> It's nice to see this being simplified
> 
> >>   * --[no-]autosquash
> >>   * --rebase-merges
> >>   * --preserve-merges
> >> @@ -539,7 +528,7 @@ Flags only understood by the interactive backend:
> >>   * --edit-todo
> >>   * --root when used in combination with --onto
> >>  
> >> -Other incompatible flag pairs:
> >> +In addition, the following pairs of options are incompatible:
> >>  
> >>   * --preserve-merges and --interactive
> >>   * --preserve-merges and --signoff
> > 
> > The rest of the diff is funny to read, but the post image makes a lot of
> > sense.
> > 
> >> diff --git a/builtin/rebase.c b/builtin/rebase.c
> >> index be004406a6..d55bbb9eb9 100644
> >> --- a/builtin/rebase.c
> >> +++ b/builtin/rebase.c
> >> @@ -118,7 +118,7 @@ static void imply_interactive(struct rebase_options *opts, const char *option)
> >>  	case REBASE_PRESERVE_MERGES:
> >>  		break;
> >>  	case REBASE_MERGE:
> >> -		/* we silently *upgrade* --merge to --interactive if needed */
> >> +		/* we now implement --merge via --interactive */
> >>  	default:
> >>  		opts->type = REBASE_INTERACTIVE; /* implied */
> >>  		break;
> >> @@ -475,10 +475,6 @@ static int run_specific_rebase(struct rebase_options *opts)
> >>  		backend = "git-rebase--am";
> >>  		backend_func = "git_rebase__am";
> >>  		break;
> >> -	case REBASE_MERGE:
> >> -		backend = "git-rebase--merge";
> >> -		backend_func = "git_rebase__merge";
> >> -		break;
> >>  	case REBASE_PRESERVE_MERGES:
> >>  		backend = "git-rebase--preserve-merges";
> >>  		backend_func = "git_rebase__preserve_merges";
> >> @@ -1156,6 +1152,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >>  		}
> >>  	}
> >>  
> >> +	if (options.type == REBASE_MERGE) {
> >> +		imply_interactive(&options, "--merge");
> >> +	}
> >> +
> >>  	if (options.root && !options.onto_name)
> >>  		imply_interactive(&options, "--root without --onto");
> >>  
> > 
> > Okay, this makes sense.
> > 
> >> diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> >> index da27bfca5a..4abcceed06 100755
> >> --- a/git-legacy-rebase.sh
> >> +++ b/git-legacy-rebase.sh
> >> @@ -218,6 +218,7 @@ then
> >>  	state_dir="$apply_dir"
> >>  elif test -d "$merge_dir"
> >>  then
> >> +	type=interactive
> >>  	if test -d "$merge_dir"/rewritten
> >>  	then
> >>  		type=preserve-merges
> >> @@ -225,10 +226,7 @@ then
> >>  		preserve_merges=t
> >>  	elif test -f "$merge_dir"/interactive
> >>  	then
> >> -		type=interactive
> >>  		interactive_rebase=explicit
> >> -	else
> >> -		type=merge
> >>  	fi
> >>  	state_dir="$merge_dir"
> >>  fi
> >> @@ -469,6 +467,7 @@ then
> >>  	test -z "$interactive_rebase" && interactive_rebase=implied
> >>  fi
> >>  
> >> +actually_interactive=
> >>  if test -n "$interactive_rebase"
> >>  then
> >>  	if test -z "$preserve_merges"
> >> @@ -477,11 +476,12 @@ then
> >>  	else
> >>  		type=preserve-merges
> >>  	fi
> >> -
> >> +	actually_interactive=t
> >>  	state_dir="$merge_dir"
> >>  elif test -n "$do_merge"
> >>  then
> >> -	type=merge
> >> +	interactive_rebase=implied
> >> +	type=interactive
> >>  	state_dir="$merge_dir"
> >>  else
> >>  	type=am
> >> @@ -493,21 +493,13 @@ then
> >>  	git_format_patch_opt="$git_format_patch_opt --progress"
> >>  fi
> >>  
> >> -if test -n "$git_am_opt"; then
> >> -	incompatible_opts=$(echo " $git_am_opt " | \
> >> -			    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
> >> -	if test -n "$interactive_rebase"
> >> +incompatible_opts=$(echo " $git_am_opt " | \
> >> +		    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
> > 
> > Why are we no longer guarding this behind the condition that the user
> > specified *any* option intended for the `am` backend?
> 
> I was confused by this as well, what if the user asks for 'rebase
> --exec=<cmd> --ignore-whitespace'?
> 
> > 
> >> +if test -n "$incompatible_opts"
> >> +then
> >> +	if test -n "$actually_interactive" || test "$do_merge"
> >>  	then
> >> -		if test -n "$incompatible_opts"
> >> -		then
> >> -			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
> >> -		fi
> >> -	fi
> >> -	if test -n "$do_merge"; then
> >> -		if test -n "$incompatible_opts"
> >> -		then
> >> -			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
> >> -		fi
> >> +		die "$(gettext "error: cannot combine am options ($incompatible_opts) with either interactive or merge options")"
> >>  	fi
> >>  fi
> >>  
> 
> If you want to change the error message here, I think you need to change
> the corresponding message in builtin/rebase.c
> 
> Best Wishes
> 
> Phillip
> 
> > 
> > The rest of this hunk makes sense.
> > 
> >> @@ -672,7 +664,7 @@ require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
> >>  # but this should be done only when upstream and onto are the same
> >>  # and if this is not an interactive rebase.
> >>  mb=$(git merge-base "$onto" "$orig_head")
> >> -if test -z "$interactive_rebase" && test "$upstream" = "$onto" &&
> >> +if test -z "$actually_interactive" && test "$upstream" = "$onto" &&
> >>  	test "$mb" = "$onto" && test -z "$restrict_revision" &&
> >>  	# linear history?
> >>  	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
> >> @@ -716,6 +708,19 @@ then
> >>  	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
> >>  fi
> >>  
> >> +if test -z "$actually_interactive" && test "$mb" = "$orig_head"
> >> +then
> >> +	# If the $onto is a proper descendant of the tip of the branch, then
> >> +	# we just fast-forwarded.
> > 
> > This comment is misleading if it comes before, rather than after, the
> > actual `checkout -q` command.
> > 
> >> +	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
> >> +	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
> >> +		git checkout -q "$onto^0" || die "could not detach HEAD"
> >> +	git update-ref ORIG_HEAD $orig_head
> >> +	move_to_original_branch
> >> +	finish_rebase
> >> +	exit 0
> >> +fi
> >> +
> >>  test -n "$interactive_rebase" && run_specific_rebase
> >>  
> >>  # Detach HEAD and reset the tree
> >> @@ -725,16 +730,6 @@ GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
> >>  	git checkout -q "$onto^0" || die "could not detach HEAD"
> >>  git update-ref ORIG_HEAD $orig_head
> > 
> > It is a pity that this hunk header hides the lines that you copied into
> > the following conditional before moving it before the "if interactive, run
> > it" line:
> > 
> >>  
> >> -# If the $onto is a proper descendant of the tip of the branch, then
> >> -# we just fast-forwarded.
> >> -if test "$mb" = "$orig_head"
> >> -then
> >> -	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
> >> -	move_to_original_branch
> >> -	finish_rebase
> >> -	exit 0
> >> -fi
> >> -
> >>  if test -n "$rebase_root"
> >>  then
> >>  	revisions="$onto..$orig_head"
> > 
> > What you did is correct, if duplicating code, and definitely the easiest
> > way to do it. Just move the comment, and we're good here.
> > 
> >> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> >> deleted file mode 100644
> >> [... snip ...]
> > 
> > Nice. Really nice!
> > 
> >> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> >> index 0392e36d23..04d6c71899 100755
> >> --- a/t/t3406-rebase-message.sh
> >> +++ b/t/t3406-rebase-message.sh
> >> @@ -17,14 +17,9 @@ test_expect_success 'setup' '
> >>  	git tag start
> >>  '
> >>  
> >> -cat >expect <<\EOF
> >> -Already applied: 0001 A
> >> -Already applied: 0002 B
> >> -Committed: 0003 Z
> >> -EOF
> >> -
> > 
> > As I had mentioned in the previous round: I think we can retain these
> > messages for the `--merge` mode. And I think we should: users of --merge
> > have most likely become to expect them.
> > 
> > The most elegant way would probably be by adding code to the sequencer
> > that outputs these lines if in "merge" mode (and add a flag to say that we
> > *are* in "merge" mode).
> > 
> > To that end, the `make_script()` function would not generate `# pick` but
> > `drop` lines, I think, so that the sequencer can see those and print the
> > `Already applied: <message>` lines. And a successful `TODO_PICK` would
> > write out `Committed: <message>`.
> > 
> >>  test_expect_success 'rebase -m' '
> >>  	git rebase -m master >report &&
> >> +	>expect &&
> >>  	sed -n -e "/^Already applied: /p" \
> >>  		-e "/^Committed: /p" report >actual &&
> >>  	test_cmp expect actual
> >> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> >> index f355c6825a..49077200c5 100755
> >> --- a/t/t3420-rebase-autostash.sh
> >> +++ b/t/t3420-rebase-autostash.sh
> >> @@ -53,41 +53,6 @@ create_expected_success_interactive () {
> >>  	EOF
> >>  }
> >>  
> >> -create_expected_success_merge () {
> >> -	cat >expected <<-EOF
> >> -	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> >> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
> >> -	First, rewinding head to replay your work on top of it...
> >> -	Merging unrelated-onto-branch with HEAD~1
> >> -	Merging:
> >> -	$(git rev-parse --short unrelated-onto-branch) unrelated commit
> >> -	$(git rev-parse --short feature-branch^) second commit
> >> -	found 1 common ancestor:
> >> -	$(git rev-parse --short feature-branch~2) initial commit
> >> -	[detached HEAD $(git rev-parse --short rebased-feature-branch~1)] second commit
> >> -	 Author: A U Thor <author@example.com>
> >> -	 Date: Thu Apr 7 15:14:13 2005 -0700
> >> -	 2 files changed, 2 insertions(+)
> >> -	 create mode 100644 file1
> >> -	 create mode 100644 file2
> >> -	Committed: 0001 second commit
> >> -	Merging unrelated-onto-branch with HEAD~0
> >> -	Merging:
> >> -	$(git rev-parse --short rebased-feature-branch~1) second commit
> >> -	$(git rev-parse --short feature-branch) third commit
> >> -	found 1 common ancestor:
> >> -	$(git rev-parse --short feature-branch~1) second commit
> >> -	[detached HEAD $(git rev-parse --short rebased-feature-branch)] third commit
> >> -	 Author: A U Thor <author@example.com>
> >> -	 Date: Thu Apr 7 15:15:13 2005 -0700
> >> -	 1 file changed, 1 insertion(+)
> >> -	 create mode 100644 file3
> >> -	Committed: 0002 third commit
> >> -	All done.
> >> -	Applied autostash.
> >> -	EOF
> >> -}
> >> -
> >>  create_expected_failure_am () {
> >>  	cat >expected <<-EOF
> >>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> >> @@ -112,43 +77,6 @@ create_expected_failure_interactive () {
> >>  	EOF
> >>  }
> >>  
> >> -create_expected_failure_merge () {
> >> -	cat >expected <<-EOF
> >> -	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> >> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
> >> -	First, rewinding head to replay your work on top of it...
> >> -	Merging unrelated-onto-branch with HEAD~1
> >> -	Merging:
> >> -	$(git rev-parse --short unrelated-onto-branch) unrelated commit
> >> -	$(git rev-parse --short feature-branch^) second commit
> >> -	found 1 common ancestor:
> >> -	$(git rev-parse --short feature-branch~2) initial commit
> >> -	[detached HEAD $(git rev-parse --short rebased-feature-branch~1)] second commit
> >> -	 Author: A U Thor <author@example.com>
> >> -	 Date: Thu Apr 7 15:14:13 2005 -0700
> >> -	 2 files changed, 2 insertions(+)
> >> -	 create mode 100644 file1
> >> -	 create mode 100644 file2
> >> -	Committed: 0001 second commit
> >> -	Merging unrelated-onto-branch with HEAD~0
> >> -	Merging:
> >> -	$(git rev-parse --short rebased-feature-branch~1) second commit
> >> -	$(git rev-parse --short feature-branch) third commit
> >> -	found 1 common ancestor:
> >> -	$(git rev-parse --short feature-branch~1) second commit
> >> -	[detached HEAD $(git rev-parse --short rebased-feature-branch)] third commit
> >> -	 Author: A U Thor <author@example.com>
> >> -	 Date: Thu Apr 7 15:15:13 2005 -0700
> >> -	 1 file changed, 1 insertion(+)
> >> -	 create mode 100644 file3
> >> -	Committed: 0002 third commit
> >> -	All done.
> >> -	Applying autostash resulted in conflicts.
> >> -	Your changes are safe in the stash.
> >> -	You can run "git stash pop" or "git stash drop" at any time.
> >> -	EOF
> >> -}
> >> -
> >>  testrebase () {
> >>  	type=$1
> >>  	dotest=$2
> >> @@ -177,6 +105,9 @@ testrebase () {
> >>  	test_expect_success "rebase$type --autostash: check output" '
> >>  		test_when_finished git branch -D rebased-feature-branch &&
> >>  		suffix=${type#\ --} && suffix=${suffix:-am} &&
> >> +		if test ${suffix} = "merge"; then
> >> +			suffix=interactive
> >> +		fi &&
> >>  		create_expected_success_$suffix &&
> >>  		test_i18ncmp expected actual
> >>  	'
> >> @@ -274,6 +205,9 @@ testrebase () {
> >>  	test_expect_success "rebase$type: check output with conflicting stash" '
> >>  		test_when_finished git branch -D rebased-feature-branch &&
> >>  		suffix=${type#\ --} && suffix=${suffix:-am} &&
> >> +		if test ${suffix} = "merge"; then
> >> +			suffix=interactive
> >> +		fi &&
> >>  		create_expected_failure_$suffix &&
> >>  		test_i18ncmp expected actual
> >>  	'
> > 
> > As I stated earlier, I am uncomfortable with this solution. We change
> > behavior rather noticeably, and the regression test tells us the same. We
> > need to either try to deprecate `git rebase --merge`, or we need to at
> > least attempt to recreate the old behavior with the sequencer.
> > 
> >> diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
> >> index 99b2aac921..911ef49f70 100755
> >> --- a/t/t3421-rebase-topology-linear.sh
> >> +++ b/t/t3421-rebase-topology-linear.sh
> >> @@ -111,7 +111,7 @@ test_run_rebase () {
> >>  	"
> >>  }
> >>  test_run_rebase success ''
> >> -test_run_rebase failure -m
> >> +test_run_rebase success -m
> >>  test_run_rebase success -i
> >>  test_run_rebase success -p
> >>  
> >> @@ -126,7 +126,7 @@ test_run_rebase () {
> >>  	"
> >>  }
> >>  test_run_rebase success ''
> >> -test_run_rebase failure -m
> >> +test_run_rebase success -m
> >>  test_run_rebase success -i
> >>  test_run_rebase success -p
> >>  
> >> @@ -141,7 +141,7 @@ test_run_rebase () {
> >>  	"
> >>  }
> >>  test_run_rebase success ''
> >> -test_run_rebase failure -m
> >> +test_run_rebase success -m
> >>  test_run_rebase success -i
> >>  test_run_rebase success -p
> >>  
> >> @@ -284,7 +284,7 @@ test_run_rebase () {
> >>  	"
> >>  }
> >>  test_run_rebase success ''
> >> -test_run_rebase failure -m
> >> +test_run_rebase success -m
> >>  test_run_rebase success -i
> >>  test_run_rebase success -p
> >>  
> >> @@ -315,7 +315,7 @@ test_run_rebase () {
> >>  	"
> >>  }
> >>  test_run_rebase success ''
> >> -test_run_rebase failure -m
> >> +test_run_rebase success -m
> >>  test_run_rebase success -i
> >>  test_run_rebase failure -p
> >>  
> > 
> > Nice.
> > 
> >> diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
> >> index 846f85c27e..cd505c0711 100755
> >> --- a/t/t3425-rebase-topology-merges.sh
> >> +++ b/t/t3425-rebase-topology-merges.sh
> >> @@ -72,7 +72,7 @@ test_run_rebase () {
> >>  }
> >>  #TODO: make order consistent across all flavors of rebase
> >>  test_run_rebase success 'e n o' ''
> >> -test_run_rebase success 'e n o' -m
> >> +test_run_rebase success 'n o e' -m
> >>  test_run_rebase success 'n o e' -i
> >>  
> >>  test_run_rebase () {
> >> @@ -89,7 +89,7 @@ test_run_rebase () {
> >>  }
> >>  #TODO: make order consistent across all flavors of rebase
> >>  test_run_rebase success 'd e n o' ''
> >> -test_run_rebase success 'd e n o' -m
> >> +test_run_rebase success 'd n o e' -m
> >>  test_run_rebase success 'd n o e' -i
> >>  
> >>  test_run_rebase () {
> >> @@ -106,7 +106,7 @@ test_run_rebase () {
> >>  }
> >>  #TODO: make order consistent across all flavors of rebase
> >>  test_run_rebase success 'd e n o' ''
> >> -test_run_rebase success 'd e n o' -m
> >> +test_run_rebase success 'd n o e' -m
> >>  test_run_rebase success 'd n o e' -i
> >>  
> >>  test_expect_success "rebase -p is no-op in non-linear history" "
> > 
> > This is a bit unfortunate. I wonder if we could do something like this, to
> > retain the current behavior:
> > 
> > -- snip --
> > diff --git a/sequencer.c b/sequencer.c
> > index 9e1ab3a2a7..5018957e49 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -4394,7 +4394,8 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
> >  	revs.reverse = 1;
> >  	revs.right_only = 1;
> >  	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> > -	revs.topo_order = 1;
> > +	if (!(flags & TODO_LIST_NO_TOPO_ORDER))
> > +		revs.topo_order = 1;
> >  
> >  	revs.pretty_given = 1;
> >  	git_config_get_string("rebase.instructionFormat", &format);
> > -- snap -
> > 
> > (and then pass TODO_LIST_NO_TOPO_ORDER if in "merge" mode)?
> > 
> >> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
> >> index 9b2a274c71..145c61251d 100755
> >> --- a/t/t5407-post-rewrite-hook.sh
> >> +++ b/t/t5407-post-rewrite-hook.sh
> >> @@ -120,6 +120,7 @@ test_expect_success 'git rebase -m --skip' '
> >>  	git rebase --continue &&
> >>  	echo rebase >expected.args &&
> >>  	cat >expected.data <<-EOF &&
> >> +	$(git rev-parse C) $(git rev-parse HEAD^)
> >>  	$(git rev-parse D) $(git rev-parse HEAD)
> >>  	EOF
> >>  	verify_hook_input
> > 
> > This suggests to me that we call `commit` too many times. I think we
> > really need to address this without changing the test. This is a change in
> > behavior.
> > 
> >> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> >> index 81a5179e28..5cadedb2a9 100755
> >> --- a/t/t9903-bash-prompt.sh
> >> +++ b/t/t9903-bash-prompt.sh
> >> @@ -180,7 +180,7 @@ test_expect_success 'prompt - interactive rebase' '
> >>  '
> >>  
> >>  test_expect_success 'prompt - rebase merge' '
> >> -	printf " (b2|REBASE-m 1/3)" >expected &&
> >> +	printf " (b2|REBASE-i 1/3)" >expected &&
> > 
> > As I said, this should be easily addressed by having a tell-tale in
> > $state_dir/. Come to think of it, we must have had one, right? Let's see
> > how the bash-prompt does it.
> > 
> > *clicketyclick*
> > 
> > Ah, it is the *absence* of the `interactive` file... Which makes me wonder
> > whether we should not simply retain that behavior for `git rebase
> > --merge`?
> > 
> >>  	git checkout b2 &&
> >>  	test_when_finished "git checkout master" &&
> >>  	test_must_fail git rebase --merge b1 b2 &&
> >> -- 
> >> 2.19.1.858.g526e8fe740.dirty
> >>
> >>
> > 
> > Thank you for this pleasant read. I think there is still quite a bit of
> > work to do, but you already did most of it.
> > 
> > Out of curiosity, do you have a public repository with these patches in a
> > branch? (I might have an hour to play with it tonight...)
> > 
> > Thanks!
> > Dscho
> > 
> 
> 
