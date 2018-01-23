Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04C61F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbeAWWkQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:40:16 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44232 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbeAWWkC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:40:02 -0500
Received: by mail-pf0-f194.google.com with SMTP id m26so1460232pfj.11
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:user-agent:date:message-id:mime-version;
        bh=f0GsV9VrotLs5jiMhf0R1M7uzp2geWRCuI2260WoVws=;
        b=Oqco7rC+kbPqbZkUH+YZyRN9caf1AJOw+RxmaXy62V0Z4imfK01vTKFayrvkc7CtMs
         vPBXeidN1koTSOqsCEu1CX8mHxrNkkiNXHddy2S9drdtG9/L3z7tJEdXGektPZ3lsZTM
         UGEiSfY5i4rIez66JlY6oEeFuLjvOlcS6HGyxybyfTRY4mavFJyVbBvN2Nh9YRDlFSjz
         qLCTo4/GSgZdpkrnDv+K7i901rP9X7VKxuERwMP7/U4dY1eBtFaiz/gC+LqT3TitAkeP
         7PSqWmT2q0PY35mqJSoGYfeNNxsDet8Tld7rb04/PPP+kq9LbTWkYVmNGBUCWq15kKuS
         WpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:user-agent:date
         :message-id:mime-version;
        bh=f0GsV9VrotLs5jiMhf0R1M7uzp2geWRCuI2260WoVws=;
        b=kJA62NYbalng7SFu+11u5R4q71Dbs9EOaXqAqsCOz7STfhXiqUDBP90Q37AxxTVy9G
         zPQbkSLEYzU0pVJP6pfzPUqR3kmf5H5UpX4FFwOL1qF8wDSGQrsqEzPVTvgKvSsltg7I
         eJYqsTPe/kLXZdTzKoyq7GbNrJGGTCkpzfSzuhMbwGvxRPMOygodWIOiIMla7aVCK0xb
         TGJTDUebdWrlhH8voDTyHIKobm6dsoShj4djL3SjBPpKSGxxq5qyXsXrjaEk9uvTZVx/
         WUtI3TfbXCqzlzhrEI6IW4A43PQVymZbprxstR3/jAJEDTf1NSGg4pIvsjzZchF1EMh4
         RsIA==
X-Gm-Message-State: AKwxytdhDwCH+510E4fn+LVMLYvXXe/Ng7Y8oIG09WUpDrNVJg1PrkWv
        M3fna1vPJ6uVpM1rCvmy8jyUFnfOGHs1CA==
X-Google-Smtp-Source: AH8x227vRviO35BSTkXN02255E5NfAJrNMipTqXPyi9152IJj80mL8qYwpWNEf8JXY3qiBA/ttsUdA==
X-Received: by 10.98.166.22 with SMTP id t22mr11034536pfe.80.1516747200624;
        Tue, 23 Jan 2018 14:40:00 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id p72sm8031758pfa.99.2018.01.23.14.39.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Jan 2018 14:39:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2018, #03; Tue, 23)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
X-master-at: 5be1f00a9a701532232f57958efab4be8c959a29
X-next-at: de0f0111ea2ad3a2b03a378e6272c2ee476a26ed
Date:   Tue, 23 Jan 2018 14:39:58 -0800
Message-ID: <xmqqefmgfbcx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Many topics in 'next' have been merged to 'master' while others are
tentatively kicked back to 'pu', to give them a chance to be rerolled
if the authors of them wish to do so.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/commit-m-with-fixup (2017-12-22) 2 commits
  (merged to 'next' on 2018-01-11 at 41255c464f)
 + commit: add support for --fixup <commit> -m"<extra message>"
 + commit doc: document that -c, -C, -F and --fixup with -m error

 "git commit --fixup" did not allow "-m<message>" option to be used
 at the same time; allow it to annotate resulting commit with more
 text.


* ab/doc-cat-file-e-still-shows-errors (2018-01-10) 1 commit
  (merged to 'next' on 2018-01-12 at 080bb1d397)
 + cat-file doc: document that -e will return some output

 Doc update.


* ab/perf-grep-threads (2018-01-04) 1 commit
  (merged to 'next' on 2018-01-09 at 91889574fb)
 + perf: amend the grep tests to test grep.threads

 More perf tests for threaded grep


* as/read-tree-prefix-doc-fix (2018-01-09) 1 commit
  (merged to 'next' on 2018-01-12 at 895c72e5c3)
 + doc/read-tree: remove obsolete remark

 Doc update.


* bw/oidmap-autoinit (2017-12-27) 1 commit
  (merged to 'next' on 2018-01-11 at f941e013b4)
 + oidmap: ensure map is initialized

 Code clean-up.


* cc/codespeed (2018-01-05) 7 commits
  (merged to 'next' on 2018-01-09 at 8578089a2b)
 + perf/run: read GIT_PERF_REPO_NAME from perf.repoName
 + perf/run: learn to send output to codespeed server
 + perf/run: learn about perf.codespeedOutput
 + perf/run: add conf_opts argument to get_var_from_env_or_config()
 + perf/aggregate: implement codespeed JSON output
 + perf/aggregate: refactor printing results
 + perf/aggregate: fix checking ENV{GIT_PERF_SUBSECTION}

 "perf" test output can be sent to codespeed server.


* dk/describe-all-output-fix (2017-12-27) 1 commit
  (merged to 'next' on 2017-12-28 at c6254494e3)
 + describe: prepend "tags/" when describing tags with embedded name

 An old regression in "git describe --all $annotated_tag^0" has been
 fixed.


* ew/empty-merge-with-dirty-index (2018-01-09) 1 commit
  (merged to 'next' on 2018-01-09 at 6bcda11248)
 + Merge branch 'ew/empty-merge-with-dirty-index-maint' into ew/empty-merge-with-dirty-index
 (this branch uses ew/empty-merge-with-dirty-index-maint.)

 "git merge -s recursive" did not correctly abort when the index is
 dirty, if the merged tree happened to be the same as the current
 HEAD, which has been fixed.


* jc/merge-symlink-ours-theirs (2018-01-03) 1 commit
  (merged to 'next' on 2018-01-05 at 63ebfc45eb)
 + merge: teach -Xours/-Xtheirs to symbolic link merge

 "git merge -Xours/-Xtheirs" learned to use our/their version when
 resolving a conflicting updates to a symbolic link.


* jh/object-filtering (2018-01-08) 1 commit
  (merged to 'next' on 2018-01-11 at 56808f6969)
 + oidset: don't return value from oidset_init

 Hotfix for a topic already in 'master'.


* jk/abort-clone-with-existing-dest (2018-01-03) 4 commits
  (merged to 'next' on 2018-01-09 at 3c8e83c3a7)
 + clone: do not clean up directories we didn't create
 + clone: factor out dir_exists() helper
 + t5600: modernize style
 + t5600: fix outdated comment about unborn HEAD

 "git clone $there $here" is allowed even when here directory exists
 as long as it is an empty directory, but the command incorrectly
 removed it upon a failure of the operation.


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
  (merged to 'next' on 2018-01-05 at 6cb237ea44)
 + git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.


* js/fix-merge-arg-quoting-in-rebase-p (2018-01-05) 1 commit
  (merged to 'next' on 2018-01-09 at 91f5601e9c)
 + rebase -p: fix quoting when calling `git merge`

 "git rebase -p -X<option>" did not propagate the option properly
 down to underlying merge strategy backend.


* js/test-with-ws-in-path (2018-01-10) 1 commit
  (merged to 'next' on 2018-01-10 at c44db26fe4)
 + t3900: add some more quotes

 Hot fix to a test.


* ma/bisect-leakfix (2018-01-03) 1 commit
  (merged to 'next' on 2018-01-09 at 2ef8b59d1b)
 + bisect: fix a regression causing a segfault

 A hotfix for a recent update that broke 'git bisect'.


* mm/send-email-fallback-to-local-mail-address (2018-01-08) 3 commits
  (merged to 'next' on 2018-01-17 at dd4867706b)
 + send-email: add test for Linux's get_maintainer.pl
 + perl/Git: remove now useless email-address parsing code
 + send-email: add and use a local copy of Mail::Address

 Instead of maintaining home-grown email address parsing code, ship
 a copy of reasonably recent Mail::Address to be used as a fallback
 in 'git send-email' when the platform lacks it.


* nd/add-i-ignore-submodules (2018-01-16) 1 commit
  (merged to 'next' on 2018-01-17 at 632401fd5a)
 + add--interactive: ignore submodule changes except HEAD

 "git add -p" was taught to ignore local changes to submodules as
 they do not interfere with the partial addition of regular changes
 anyway.


* nd/ita-wt-renames-in-status (2017-12-27) 6 commits
  (merged to 'next' on 2017-12-28 at 7610331a11)
 + wt-status.c: handle worktree renames
 + wt-status.c: rename rename-related fields in wt_status_change_data
 + wt-status.c: catch unhandled diff status codes
 + wt-status.c: coding style fix
 + Use DIFF_DETECT_RENAME for detect_rename assignments
 + t2203: test status output with porcelain v2 format

 "git status" after moving a path in the working tree (hence making
 it appear "removed") and then adding with the -N option (hence
 making that appear "added") detected it as a rename, but did not
 report the  old and new pathnames correctly.


* rs/lose-leak-pending (2017-12-28) 9 commits
  (merged to 'next' on 2018-01-05 at 05305f7f2f)
 + commit: remove unused function clear_commit_marks_for_object_array()
 + revision: remove the unused flag leak_pending
 + checkout: avoid using the rev_info flag leak_pending
 + bundle: avoid using the rev_info flag leak_pending
 + bisect: avoid using the rev_info flag leak_pending
 + object: add clear_commit_marks_all()
 + ref-filter: use clear_commit_marks_many() in do_merge_filter()
 + commit: use clear_commit_marks_many() in remove_redundant()
 + commit: avoid allocation in clear_commit_marks_many()

 API clean-up around revision traversal.


* sb/diff-blobfind-pickaxe (2018-01-04) 6 commits
  (merged to 'next' on 2018-01-09 at 2053890477)
 + diff: use HAS_MULTI_BITS instead of counting bits manually
 + diff: properly error out when combining multiple pickaxe options
 + diffcore: add a pickaxe option to find a specific blob
 + diff: introduce DIFF_PICKAXE_KINDS_MASK
 + diff: migrate diff_flags.pickaxe_ignore_case to a pickaxe_opts bit
 + diff.h: make pickaxe_opts an unsigned bit field

 "diff" family of commands learned "--find-object=<object-id>" option
 to limit the findings to changes that involve the named object.


* sb/submodule-update-reset-fix (2018-01-05) 4 commits
  (merged to 'next' on 2018-01-11 at e4e84b69a3)
 + submodule: submodule_move_head omits old argument in forced case
 + unpack-trees: oneway_merge to update submodules
 + t/lib-submodule-update.sh: fix test ignoring ignored files in submodules
 + t/lib-submodule-update.sh: clarify test

 When resetting the working tree files recursively, the working tree
 of submodules are now also reset to match.


* tg/stash-with-pathspec-fix (2018-01-08) 1 commit
  (merged to 'next' on 2018-01-11 at abfaa14a7b)
 + stash: don't delete untracked files that match pathspec

 "git stash -- <pathspec>" incorrectly blew away untracked files in
 the directory that matched the pathspec, which has been corrected.


* tg/worktree-create-tracking (2018-01-11) 1 commit
  (merged to 'next' on 2018-01-11 at df6423dfc4)
 + Documentation/git-worktree.txt: add missing `

 Doc hotfix.


* ys/bisect-object-id-missing-conversion-fix (2018-01-09) 1 commit
  (merged to 'next' on 2018-01-11 at ca330c885d)
 + bisect: debug: convert struct object to object_id

 Fix for a commented-out code to adjust it to a rather old API change.

--------------------------------------------------
[New Topics]

* nd/trace-with-env (2018-01-19) 7 commits
 - run-command.c: print new cwd in trace_run_command()
 - run-command.c: print env vars in trace_run_command()
 - run-command.c: print program 'git' when tracing git_cmd mode
 - run-command.c: introduce trace_run_command()
 - trace.c: move strbuf_release() out of print_trace_line()
 - trace: avoid unnecessary quoting
 - sq_quote_argv: drop maxlen parameter

 The tracing machinery learned to report tweaking of environment
 variables as well.

 Will merge to 'next'.


* cl/t9001-cleanup (2018-01-12) 1 commit
 - t9001: use existing helper in send-email test

 Test clean-up.

 Will merge to 'next'.


* kg/packed-ref-cache-fix (2018-01-16) 1 commit
 - packed_ref_cache: don't use mmap() for small files

 Avoid mmapping small files while using packed refs (especially ones
 with zero size, which would cause later munmap() to fail).

 Will merge to 'next'.


* ks/submodule-doc-updates (2018-01-16) 2 commits
 - Doc/git-submodule: improve readability and grammar of a sentence
 - Doc/gitsubmodules: make some changes to improve readability and syntax

 Doc updates.

 Will merge to 'next'.


* nd/shared-index-fix (2018-01-22) 3 commits
 - read-cache: don't write index twice if we can't write shared index
 - read-cache.c: move tempfile creation/cleanup out of write_shared_index
 - read-cache.c: change type of "temp" in write_shared_index()


* rs/describe-unique-abbrev (2018-01-16) 1 commit
 - describe: use strbuf_add_unique_abbrev() for adding short hashes

 Code clean-up.

 Will merge to 'next'.


* tb/crlf-conv-flags (2018-01-16) 1 commit
 - convert_to_git(): safe_crlf/checksafe becomes int conv_flags

 Code clean-up.

 Will merge to 'next'.


* nd/diff-flush-before-warning (2018-01-16) 1 commit
 - diff.c: flush stdout before printing rename warnings

 Avoid showing a warning message in the middle of a line of "git
 diff" output.

 Will merge to 'next'.


* rb/hashmap-h-compilation-fix (2018-01-16) 1 commit
 - hashmap.h: remove unused variable

 Code clean-up.

 Will merge to 'next'.


* cc/sha1-file-name (2018-01-19) 2 commits
 - sha1_file: improve sha1_file_name() perfs
 - sha1_file: remove static strbuf from sha1_file_name()

 Code clean-up.

 Will merge to 'next'.


* cl/send-email-reply-to (2018-01-17) 2 commits
 - send-email: support separate "Reply-To" address
 - send-email: rename variables for "In-reply-to" to $foo_in_reply_to

 "git send-email" learned "--reply-to=<address>" option.

 May want to get the log messages updated.
 cf. <CAN0heSqxmLoh33i65JPhyQbmPaAcJcwrTCO+ZD4eb+qh8Pf8+w@mail.gmail.com>


* ds/use-get-be64 (2018-01-19) 1 commit
 - packfile: use get_be64() for large offsets

 Code clean-up.

 Will merge to 'next'.


* en/merge-recursive-fixes (2018-01-19) 3 commits
 - merge-recursive: add explanation for src_entry and dst_entry
 - merge-recursive: fix logic ordering issue
 - Tighten and correct a few testcases for merging and cherry-picking
 (this branch is used by en/rename-directory-detection.)


* jc/worktree-add-short-help (2018-01-17) 1 commit
 - worktree: say that "add" takes an arbitrary commit in short-help


* js/rebase-recreate-merge (2018-01-22) 8 commits
 - rebase -i: introduce --recreate-merges=no-rebase-cousins
 - pull: accept --rebase=recreate to recreate the branch topology
 - sequencer: handle autosquash and post-rewrite for merge commands
 - rebase: introduce the --recreate-merges option
 - rebase-helper --make-script: introduce a flag to recreate merges
 - sequencer: fast-forward merge commits, if possible
 - sequencer: introduce the `merge` command
 - sequencer: introduce new commands to reset the revision

 "git rebase" learned "--recreate-merges" to transplant the whole
 topology of commit graph elsewhere.


* jt/http-redact-cookies (2018-01-19) 2 commits
 - http: support omitting data from traces
 - http: support cookie redaction when tracing

 The http tracing code, often used to debug connection issues,
 learned to redact potentially sensitive information from its output
 so that it can be more safely sharable.

 Will merge to 'next'.


* mr/packed-ref-store-fix (2018-01-19) 1 commit
 - files_initial_transaction_commit(): only unlock if locked

 Crash fix for a corner case where an error codepath tried to unlock
 what it did not acquire lock on.

 Will merge to 'next'.


* rs/strbuf-cocci-workaround (2018-01-19) 1 commit
 - cocci: use format keyword instead of a literal string

 Update Coccinelle rules to catch and optimize strbuf_addf(&buf, "%s", str)

 Will merge to 'next'.


* sg/cocci-move-array (2018-01-22) 1 commit
 - Use MOVE_ARRAY

 Code clean-up.

 Will merge to 'next'.


* tg/split-index-fixes (2018-01-19) 3 commits
 - travis: run tests with GIT_TEST_SPLIT_INDEX
 - split-index: don't write cache tree with null oid entries
 - read-cache: fix reading the shared index for other repos

 The split-index mode had a few corner case bugs fixed.

 Will merge to 'next'.


* jt/fsck-code-cleanup (2018-01-23) 1 commit
 - fsck: fix leak when traversing trees

--------------------------------------------------
[Stalled]

* jh/status-no-ahead-behind (2018-01-04) 4 commits
 - status: support --no-ahead-behind in long format
 - status: update short status to respect --no-ahead-behind
 - status: add --[no-]ahead-behind to status and commit for V2 format.
 - stat_tracking_info: return +1 when branches not equal

 Expecting a reroll to finalize the topic.


* av/fsmonitor-updates (2018-01-04) 6 commits
 - fsmonitor: use fsmonitor data in `git diff`
 - fsmonitor: remove debugging lines from t/t7519-status-fsmonitor.sh
 - fsmonitor: make output of test-dump-fsmonitor more concise
 - fsmonitor: update helper tool, now that flags are filled later
 - fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
 - dir.c: update comments to match argument name

 Code clean-up on fsmonitor integration, plus optional utilization
 of the fsmonitor data in diff-files.

 Waiting for an update.
 cf. <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>


* pb/bisect-helper-2 (2017-10-28) 8 commits
 - t6030: make various test to pass GETTEXT_POISON tests
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C

 Expecting a reroll.
 cf. <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>


* dj/runtime-prefix (2017-12-05) 4 commits
 . exec_cmd: RUNTIME_PREFIX on some POSIX systems
 . Makefile: add Perl runtime prefix support
 . Makefile: add support for "perllibdir"
 . Makefile: generate Perl header from template file

 A build-time option has been added to allow Git to be told to refer
 to its associated files relative to the main binary, in the same
 way that has been possible on Windows for quite some time, for
 Linux, BSDs and Darwin.

 Tentatively kicked out of 'next' to see how well another topic
 ab/simplify-perl-makefile that heavily conflicts with this fares.


* mk/http-backend-content-length (2017-11-27) 4 commits
 - SQUASH???
 - t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
 - SQUASH???
 - http-backend: respect CONTENT_LENGTH as specified by rfc3875

 The http-backend (used for smart-http transport) used to slurp the
 whole input until EOF, without paying attention to CONTENT_LENGTH
 that is supplied in the environment and instead expecting the Web
 server to close the input stream.  This has been fixed.

 Expecting a reroll.
 Suggested fixes to be used when rerolling is queued, but I'd
 prefer _not_ squashing them myself.

 Also, it may be too complex solution for the problem.
 cf. <20171204171308.GA13332@sigill.intra.peff.net>


* cc/require-tcl-tk-for-build (2017-11-29) 2 commits
 - travis-ci: avoid new tcl/tk build requirement
 - Makefile: check that tcl/tk is installed

 A first-time builder of Git may have installed neither tclsh nor
 msgfmt, in which case git-gui and gitk part will fail and break the
 build.  As a workaround, refuse to run a build when tclsh is not
 installed and NO_TCLTK is not set.

 Undecided.
 I still feel that requring tclsh to be installed, with or without
 "escape hatch" for experts, may be too heavy-handed.


* mg/merge-base-fork-point (2017-09-17) 3 commits
 - merge-base: find fork-point outside partial reflog
 - merge-base: return fork-point outside reflog
 - t6010: test actual test output

 "merge-base --fork-point $branch $commit" is used to guess on which
 commit among the commits that were once at the tip of the $branch the
 $commit was built on top of, and it learns these historical tips from
 the reflog of the $branch.  When the true fork-point is lost due to
 pruning of old reflog entries, the command does not give any output,
 because it has no way to guess correctly and does not want to mislead
 the user with a wrong guess.

 The command has been updated to give the best but not known to be
 correct guess, based on a hope that a merge-base between $commit and a
 virtual merge across all the reflog entries that still are available
 for $branch may still be a closer to the true fork-point than the
 merge-base between $commit and the current tip of the $branch.

 This may have to be offered by an additional option, to allow the
 users that are prepared to see a potentially incorrect guess to opt
 into the feature, without affecting the current callers that may not
 be prepared to accept a guess that is not known to be correct.

 What's the doneness of this one?


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Expecting a reroll.


* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).


* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>

--------------------------------------------------
[Cooking]

* ab/wildmatch-tests (2018-01-04) 7 commits
 - wildmatch test: create & test files on disk in addition to in-memory
 - wildmatch test: perform all tests under all wildmatch() modes
 - wildmatch test: remove dead fnmatch() test code
 - wildmatch test: use a paranoia pattern from nul_match()
 - wildmatch test: don't try to vertically align our output
 - wildmatch test: use more standard shell style
 - wildmatch test: indent with tabs, not spaces

 More tests for wildmatch functions.

 Expecting an update.
 cf. <87vaga9mgf.fsf@evledraar.gmail.com>


* bw/protocol-v2 (2018-01-04) 26 commits
 - remote-curl: implement connect-half-duplex command
 - remote-curl: create copy of the service name
 - pkt-line: add packet_buf_write_len function
 - transport-helper: introduce connect-half-duplex
 - transport-helper: refactor process_connect_service
 - transport-helper: remove name parameter
 - fetch-pack: perform a fetch using v2
 - upload-pack: introduce fetch server command
 - push: pass ref patterns when pushing
 - fetch: pass ref patterns when fetching
 - ls-remote: pass ref patterns when requesting a remote's refs
 - transport: convert transport_get_remote_refs to take a list of ref patterns
 - transport: convert get_refs_list to take a list of ref patterns
 - connect: request remote refs using v2
 - ls-refs: introduce ls-refs server command
 - serve: introduce git-serve
 - protocol: introduce enum protocol_version value protocol_v2
 - transport: store protocol version
 - connect: discover protocol version outside of get_remote_heads
 - connect: convert get_remote_heads to use struct packet_reader
 - transport: use get_refs_via_connect to get refs
 - upload-pack: factor out processing lines
 - upload-pack: convert to a builtin
 - pkt-line: add delim packet support
 - pkt-line: introduce struct packet_reader
 - pkt-line: introduce packet_read_with_status

 The beginning of the next-gen transfer protocol.


* ls/checkout-encoding (2018-01-08) 6 commits
 - convert: add support for 'checkout-encoding' attribute
 - convert_to_git(): safe_crlf/checksafe becomes int conv_flags
 - utf8: add function to detect a missing UTF-16/32 BOM
 - utf8: add function to detect prohibited UTF-16/32 BOM
 - strbuf: add xstrdup_toupper()
 - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).


* pc/submodule-helper (2018-01-16) 2 commits
 - submodule: port submodule subcommand 'deinit' from shell to C
 - submodule: port submodule subcommand 'sync' from shell to C

 Rewrite two more "git submodule" subcommands in C.

 Will merge to 'next'.


* sb/blame-color (2018-01-08) 4 commits
 - builtin/blame: highlight recently changed lines
 - builtin/blame: add option to color metadata fields separately
 - builtin/blame: dim uninteresting metadata
 - color.h: document and modernize header


* sg/travis-build-during-script-phase (2018-01-08) 1 commit
 - travis-ci: build Git during the 'script' phase

 Still under discussion.
 cf. <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com>


* nd/fix-untracked-cache-invalidation (2018-01-19) 6 commits
 - dir.c: print correct errno when opendir() fails
 - dir.c: stop ignoring opendir() error in open_cached_dir()
 - update-index doc: note a fixed bug in the untracked cache
 - dir.c: fix missing dir invalidation in untracked code
 - dir.c: avoid stat() in valid_cached_dir()
 - status: add a failing test showing a core.untrackedCache bug

 Some bugs around "untracked cache" feature have been fixed.

 Kicked back to 'pu' for a reroll.
 cf. <CACsJy8AecDh6Bxo6xCBG+4AY5GCdtZgb2Cs2QXo5MYZvD7XKcQ@mail.gmail.com>


* np/send-email-header-parsing (2017-12-15) 1 commit
 - send-email: extract email-parsing code into a subroutine

 Code refactoring.

 Undecided.


* ab/sha1dc-build (2017-12-12) 4 commits
 . Makefile: use the sha1collisiondetection submodule by default
 - sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
 - Makefile: under "make dist", include the sha1collisiondetection submodule
 - Makefile: don't error out under DC_SHA1_EXTERNAL if DC_SHA1_SUBMODULE=auto

 Push the submodule version of collision-detecting SHA-1 hash
 implementation a bit harder on builders.

 The earlier two may make sense, but leaning toward rejecting the last step.
 cf. <xmqqk1xw6c24.fsf@gitster.mtv.corp.google.com>


* ab/simplify-perl-makefile (2018-01-03) 3 commits
  (merged to 'next' on 2018-01-23 at 1506e0651a)
 + perl: treat PERLLIB_EXTRA as an extra path again
 + perl: avoid *.pmc and fix Error.pm further
 + Makefile: replace perl/Makefile.PL with simple make rules

 Originally merged to 'next' on 2018-01-03

 The build procedure for perl/ part has been greatly simplified by
 weaning ourselves off of MakeMaker.

 Will cook in 'next'.


* en/rename-directory-detection (2018-01-19) 31 commits
 - merge-recursive: ensure we write updates for directory-renamed file
 - merge-recursive: avoid spurious rename/rename conflict from dir renames
 - directory rename detection: new testcases showcasing a pair of bugs
 - merge-recursive: fix remaining directory rename + dirty overwrite cases
 - merge-recursive: fix overwriting dirty files involved in renames
 - merge-recursive: avoid clobbering untracked files with directory renames
 - merge-recursive: apply necessary modifications for directory renames
 - merge-recursive: when comparing files, don't include trees
 - merge-recursive: check for file level conflicts then get new name
 - merge-recursive: add computation of collisions due to dir rename & merging
 - merge-recursive: add a new hashmap for storing file collisions
 - merge-recursive: check for directory level conflicts
 - merge-recursive: add get_directory_renames()
 - merge-recursive: make a helper function for cleanup for handle_renames
 - merge-recursive: add a new hashmap for storing directory renames
 - merge-recursive: split out code for determining diff_filepairs
 - merge-recursive: make !o->detect_rename codepath more obvious
 - merge-recursive: fix leaks of allocated renames and diff_filepairs
 - merge-recursive: introduce new functions to handle rename logic
 - merge-recursive: move the get_renames() function
 - directory rename detection: tests for handling overwriting dirty files
 - directory rename detection: tests for handling overwriting untracked files
 - directory rename detection: miscellaneous testcases to complete coverage
 - directory rename detection: testcases exploring possibly suboptimal merges
 - directory rename detection: more involved edge/corner testcases
 - directory rename detection: testcases checking which side did the rename
 - directory rename detection: files/directories in the way of some renames
 - directory rename detection: partially renamed directory testcase/discussion
 - directory rename detection: testcases to avoid taking detection too far
 - directory rename detection: directory splitting testcases
 - directory rename detection: basic testcases
 (this branch uses en/merge-recursive-fixes.)

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.


* pw/sequencer-in-process-commit (2018-01-23) 13 commits
 - sequencer: run 'prepare-commit-msg' hook
 - t7505: add tests for cherry-pick and rebase -i/-p
 - sequencer: assign only free()able strings to gpg_sign
 - sequencer: improve config handling
 - t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 - sequencer: try to commit without forking 'git commit'
 - sequencer: load commit related config
 - sequencer: simplify adding Signed-off-by: trailer
 - commit: move print_commit_summary() to libgit
 - commit: move post-rewrite code to libgit
 - Add a function to update HEAD after creating a commit
 - commit: move empty message checks to libgit
 - t3404: check intermediate squash messages

 The sequencer infrastructure is shared across "git cherry-pick",
 "git rebase -i", etc., and has always spawned "git commit" when it
 needs to create a commit.  It has been taught to do so internally,
 when able, by reusing the codepath "git commit" itself uses, which
 gives performance boost for a few tens of percents in some sample
 scenarios.


* jh/fsck-promisors (2017-12-08) 10 commits
  (merged to 'next' on 2018-01-23 at ca59f5c18e)
 + gc: do not repack promisor packfiles
 + rev-list: support termination at promisor objects
 + sha1_file: support lazily fetching missing objects
 + introduce fetch-object: fetch one promisor object
 + index-pack: refactor writing of .keep files
 + fsck: support promisor objects as CLI argument
 + fsck: support referenced promisor objects
 + fsck: support refs pointing to promisor objects
 + fsck: introduce partialclone extension
 + extension.partialclone: introduce partial clone extension
 (this branch is used by jh/partial-clone.)

 Originally merged to 'next' on 2018-01-17

 In preparation for implementing narrow/partial clone, the machinery
 for checking object connectivity used by gc and fsck has been
 taught that a missing object is OK when it is referenced by a
 packfile specially marked as coming from trusted repository that
 promises to make them available on-demand and lazily.

 Will cook in 'next'.


* jh/partial-clone (2017-12-08) 13 commits
  (merged to 'next' on 2018-01-23 at de0f0111ea)
 + t5616: test bulk prefetch after partial fetch
 + fetch: inherit filter-spec from partial clone
 + t5616: end-to-end tests for partial clone
 + fetch-pack: restore save_commit_buffer after use
 + unpack-trees: batch fetching of missing blobs
 + clone: partial clone
 + partial-clone: define partial clone settings in config
 + fetch: support filters
 + fetch: refactor calculation of remote list
 + fetch-pack: test support excluding large blobs
 + fetch-pack: add --no-filter
 + fetch-pack, index-pack, transport: partial clone
 + upload-pack: add object filtering for partial clone
 (this branch uses jh/fsck-promisors.)

 Originally merged to 'next' on 2018-01-17

 The machinery to clone & fetch, which in turn involves packing and
 unpacking objects, have been told how to omit certain objects using
 the filtering mechanism introduced by the jh/object-filtering
 topic, and also mark the resulting pack as a promisor pack to
 tolerate missing objects, taking advantage of the mechanism
 introduced by the jh/fsck-promisors topic.

 Will cook in 'next'.


* ot/mru-on-list (2017-10-01) 1 commit
 - mru: use double-linked list from list.h

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 A follow-up is being worked on; it seems to be almost ready.
 cf. <20180122073701.h7fh7xrkmnzndzj7@untitled>
