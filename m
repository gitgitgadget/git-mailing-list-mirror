Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1204C1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 22:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162553AbeCAWUw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 17:20:52 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39797 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162460AbeCAWUs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 17:20:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id i3so13637419wmi.4
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 14:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=iI2A1k8uWL/Hl8LlHleeSo9CCWiXrMvWoINzLSlycjw=;
        b=eisggmROl8P4GD2aRCou1C/OmB0vzvg52NNt/bwgKsx3S8Yx+S0t0orfZvw2fCqIrC
         Ux7+JGG7CIgPwxnpI+yALBBHeKmhR4M2VubR3mNUIYtR2MsC/qKjTZi2qmnJZ89Zqpyw
         EDwbR1t3AdO5dqp1I93jsMRRxJwKZ611jDlJVGjefvU9WnWCp8rk5dx6XP+TKuV4Sakb
         2YUBwL3O2XkxWwCmEpACnNZl8ZAv9qi5EECg+QbUGAjgX5kPW5tMiChEO0hitHRYV3ZA
         ENrprLzc6QAvOZaklpz8IDfzPeDf3Saq0g3kRJPloqyWraDvBTQ1oaztoncTEPFOIDn/
         q/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=iI2A1k8uWL/Hl8LlHleeSo9CCWiXrMvWoINzLSlycjw=;
        b=LWnFmjtjhQpfLHLBl4QUlfq+lOtKiBPJCmHnRHMu6px60I6+lf4vhHR7IazkEfH5+u
         Bok79zodeIEMqtCY/u2NscMhGReEpR/SuP0GbV9QDRW6M80ggGKvCmTEBGuvMPR5g6NW
         uWu4ATqCABi2C0jsPalRDJPrreivpGwdhlbbnV8PIIqxx86ykvKdfB9oASBVRlXk9YDT
         NdUcPSQh/rGKHQrNfdOR59QU8S4BjMoaMBTJtHfiNpV2ILBcPiwPtlEFNVQL+4MF1Ge5
         lTy5m3HMXv5Vgl/KYGXj445fwc/X4tXAWhibVEuOwCs+65DmVyMtJnrdJBwHIucwWPff
         2e6w==
X-Gm-Message-State: AElRT7Fya+xy9g+pH6A1cwt36DlnALQUan7Q6BQ55Zy0zXsytsdtcdCw
        vkvO5TdalYlO8k4PniiFRT05LavlWtm3FQ==
X-Google-Smtp-Source: AG47ELuT77reMaE2SyqdL9SQNkDMxJLpy4baclUXCgnWcqgo49LNEb+V6sJyZ/3hZiSpbc0PGsWCgQ==
X-Received: by 10.28.17.77 with SMTP id 74mr2955918wmr.67.1519942845736;
        Thu, 01 Mar 2018 14:20:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g7sm4522663wrb.78.2018.03.01.14.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 14:20:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2018, #01; Thu, 1)
X-master-at: 7e31236f652ad9db221511eaf157ce0ef55585d6
X-next-at: cb683e0bf615cfbbe729b561a6ca9484c4bf4596
Date:   Thu, 01 Mar 2018 14:20:42 -0800
Message-ID: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
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

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/untracked-cache-invalidation-docs (2018-02-09) 2 commits
  (merged to 'next' on 2018-02-14 at 11d2d07c4a)
 + update-index doc: note the caveat with "could not open..."
 + update-index doc: note a fixed bug in the untracked cache
 (this branch uses nd/fix-untracked-cache-invalidation.)

 Doc update to warn against remaining bugs in untracked cache.


* as/ll-i18n (2018-02-13) 1 commit
  (merged to 'next' on 2018-02-14 at b30154a04c)
 + Mark messages for translations

 Some messages in low level start-up codepath have been i18n-ized.


* bc/doc-interpret-trailers-grammofix (2018-02-13) 1 commit
  (merged to 'next' on 2018-02-14 at 940e6dc7a5)
 + docs/interpret-trailers: fix agreement error

 Docfix.


* bp/fsmonitor (2018-02-14) 1 commit
  (merged to 'next' on 2018-02-14 at 5c508858fb)
 + fsmonitor: update documentation to remove reference to invalid config settings

 Doc update for a recently added feature.


* bp/name-hash-dirname-fix (2018-02-08) 1 commit
  (merged to 'next' on 2018-02-14 at 2f564fb4b3)
 + name-hash: properly fold directory names in adjust_dirname_case()

 "git add" files in the same directory, but spelling the directory
 path in different cases on case insensitive filesystem, corrupted
 the name hash data structure and led to unexpected results.  This
 has been corrected.


* es/worktree-add-post-checkout-hook (2018-02-15) 1 commit
  (merged to 'next' on 2018-02-21 at 6ef6a130bf)
 + worktree: add: fix 'post-checkout' not knowing new worktree location

 "git worktree add" learned to run the post-checkout hook, just like
 "git clone" runs it upon the initial checkout.


* gs/test-unset-xdg-cache-home (2018-02-16) 1 commit
  (merged to 'next' on 2018-02-21 at 9aec46d404)
 + test-lib.sh: unset XDG_CACHE_HOME

 Test update.


* jc/blame-missing-path (2018-02-07) 1 commit
  (merged to 'next' on 2018-02-14 at 883d266e1e)
 + blame: tighten command line parser

 "git blame HEAD COPYING" in a bare repository failed to run, while
 "git blame HEAD -- COPYING" run just fine.  This has been corrected.


* jk/doc-do-not-write-extern (2018-02-08) 1 commit
  (merged to 'next' on 2018-02-14 at e55b5127de)
 + CodingGuidelines: mention "static" and "extern"

 Devdoc update.


* jk/gettext-poison (2018-02-08) 2 commits
  (merged to 'next' on 2018-02-14 at cca3719a59)
 + git-sh-i18n: check GETTEXT_POISON before USE_GETTEXT_SCHEME
 + t0205: drop redundant test

 Test updates.


* jk/push-options-via-transport-fix (2018-02-20) 2 commits
  (merged to 'next' on 2018-02-21 at a037cbfa2b)
 + remote-curl: unquote incoming push-options
 + t5545: factor out http repository setup

 "git push" over http transport did not unquote the push-options
 correctly.


* jk/sq-dequote-on-bogus-input (2018-02-14) 1 commit
  (merged to 'next' on 2018-02-14 at 75d4f1eaf8)
 + sq_dequote: fix extra consumption of source string

 Code to unquote single-quoted string (used in the parser for
 configuration files, etc.) did not diagnose bogus input correctly
 and produced bogus results instead.


* jk/t0002-simplify (2018-02-12) 1 commit
  (merged to 'next' on 2018-02-14 at a7a24f5f29)
 + t0002: simplify error checking

 Code cleanup.


* jk/test-hashmap-updates (2018-02-14) 6 commits
  (merged to 'next' on 2018-02-14 at a61a9bd8f0)
 + test-hashmap: use "unsigned int" for hash storage
 + test-hashmap: simplify alloc_test_entry
 + test-hashmap: use strbuf_getline rather than fgets
 + test-hashmap: use xsnprintf rather than snprintf
 + test-hashmap: check allocation computation for overflow
 + test-hashmap: use ALLOC_ARRAY rather than bare malloc

 Code clean-up.


* js/fix-merge-arg-quoting-in-rebase-p (2018-02-08) 1 commit
  (merged to 'next' on 2018-02-14 at 27ebf001a1)
 + rebase -p: fix incorrect commit message when calling `git merge`.

 "git rebase -p" mangled log messages of a merge commit, which is
 now fixed.


* js/packet-read-line-check-null (2018-02-08) 2 commits
  (merged to 'next' on 2018-02-14 at 6ba237b284)
 + always check for NULL return from packet_read_line()
 + correct error messages for NULL packet_read_line()

 Some low level protocol codepath could crash when they get an
 unexpected flush packet, which is now fixed.


* jt/binsearch-with-fanout (2018-02-15) 2 commits
  (merged to 'next' on 2018-02-15 at 7648891022)
 + packfile: refactor hash search with fanout table
 + packfile: remove GIT_DEBUG_LOOKUP log statements
 (this branch is used by ds/commit-graph.)

 Refactor the code to binary search starting from a fan-out table
 (which is how the packfile is indexed with object names) into a
 reusable helper.


* nd/am-quit (2018-02-14) 1 commit
  (merged to 'next' on 2018-02-21 at 9a9cb40c2f)
 + am: support --quit

 "git am" has learned the "--quit" option, in addition to the existing
 "--abort" option; having the pair mirrors a few other commands like
 "rebase" and "cherry-pick".


* nd/fix-untracked-cache-invalidation (2018-02-07) 5 commits
  (merged to 'next' on 2018-02-08 at 23bd5a5d2d)
 + dir.c: ignore paths containing .git when invalidating untracked cache
 + dir.c: stop ignoring opendir() error in open_cached_dir()
 + dir.c: fix missing dir invalidation in untracked code
 + dir.c: avoid stat() in valid_cached_dir()
 + status: add a failing test showing a core.untrackedCache bug
 (this branch is used by ab/untracked-cache-invalidation-docs.)

 Some bugs around "untracked cache" feature have been fixed.
 Seems to uncover bad untracked cache information a bit too loudly,
 for which there is ab/untracked-cache-invalidation-docs topic.
 cf. <87d11omi2o.fsf@evledraar.gmail.com>
 They have to graduate together.


* rd/typofix (2018-02-14) 2 commits
  (merged to 'next' on 2018-02-14 at e770601de4)
 + Correct mispellings of ".gitmodule" to ".gitmodules"
 + t/: correct obvious typo "detahced"

 Typofix.


* rj/sparse-updates (2018-02-12) 2 commits
  (merged to 'next' on 2018-02-14 at 072df8ed5b)
 + Makefile: suppress a sparse warning for pack-revindex.c
 + config.mak.uname: remove SPARSE_FLAGS setting for cygwin

 Devtool update.


* rs/check-ignore-multi (2018-02-12) 1 commit
  (merged to 'next' on 2018-02-14 at 43cb0704af)
 + check-ignore: fix mix of directories and other file types

 "git check-ignore" with multiple paths got confused when one is a
 file and the other is a directory, which has been fixed.


* sb/describe-blob (2018-02-12) 1 commit
  (merged to 'next' on 2018-02-14 at 23e4c13944)
 + describe: confirm that blobs actually exist

 "git describe $garbage" stopped giving any errors when the garbage
 happens to be a string with 40 hexadecimal letters.


* sb/status-doc-fix (2018-02-15) 1 commit
  (merged to 'next' on 2018-02-21 at 5e68f3dac8)
 + Documentation/git-status: clarify status table for porcelain mode

 Docfix.


* sg/doc-test-must-fail-args (2018-02-12) 1 commit
  (merged to 'next' on 2018-02-14 at 28662d145b)
 + t: document 'test_must_fail ok=<signal-name>'

 Devdoc update.


* tg/worktree-create-tracking (2018-02-16) 2 commits
  (merged to 'next' on 2018-02-21 at 3e00a10cd8)
 + git-worktree.txt: fix indentation of example and text of 'add' command
 + git-worktree.txt: fix missing ")" typo

 Hotfix for a recent topic.


* tk/apply-dev-null-verify-name-fix (2018-02-15) 2 commits
  (merged to 'next' on 2018-02-21 at dab449203b)
 + apply: handle Subversion diffs with /dev/null gracefully
 + apply: demonstrate a problem applying svn diffs

 Many places in "git apply" knew that "/dev/null" that signals
 "there is no such file on this side of the diff" can be followed by
 whitespace and garbage when parsing a patch, except for one, which
 made an otherwise valid patch (e.g. ones from subversion) rejected.


* tz/do-not-clean-spec-file (2018-02-17) 1 commit
  (merged to 'next' on 2018-02-21 at c1336418a8)
 + Makefile: remove *.spec from clean target

 We no longer create any *.spec file, so "make clean" should not
 remove it.

--------------------------------------------------
[New Topics]

* jk/cached-commit-buffer (2018-02-22) 2 commits
  (merged to 'next' on 2018-02-27 at af791d9a1e)
 + revision: drop --show-all option
 + commit: drop uses of get_cached_commit_buffer()

 Code clean-up.

 Will merge to 'master'.


* jk/test-helper-v-output-fix (2018-02-22) 1 commit
  (merged to 'next' on 2018-02-27 at c9109977e8)
 + t: send verbose test-helper output to fd 4

 Test framework update.

 Will merge to 'master'.


* ld/p4-unshelve (2018-02-22) 1 commit
 - git-p4: add unshelve command

 "git p4" learned to "unshelve" shelved commit from P4.

 Will merge to 'next'.


* ms/non-ascii-ticks (2018-02-22) 1 commit
  (merged to 'next' on 2018-02-27 at 41159fc4f0)
 + Documentation/gitsubmodules.txt: avoid non-ASCII apostrophes

 Doc markup fix.

 Will merge to 'master'.


* rs/strbuf-read-file-or-whine (2018-02-22) 1 commit
  (merged to 'next' on 2018-02-27 at 56017cb5e2)
 + sequencer: factor out strbuf_read_file_or_whine()

 Code clean-up.

 Will merge to 'master'.


* jk/strbuf-read-file-close-error (2018-02-23) 1 commit
  (merged to 'next' on 2018-02-27 at c5dfe33335)
 + strbuf_read_file(): preserve errno across close() call

 Code clean-up.

 Will merge to 'master'.


* bw/perl-timegm-timelocal-fix (2018-02-23) 1 commit
  (merged to 'next' on 2018-02-27 at 565a3141ce)
 + perl: call timegm and timelocal with 4-digit year

 Y2k20 fix ;-) for our perl scripts.

 Will merge to 'master'.


* ps/contains-id-error-message (2018-02-23) 1 commit
  (merged to 'next' on 2018-02-27 at 9623d6817b)
 + ref-filter: make "--contains <id>" less chatty if <id> is invalid

 "git tag --contains no-such-commit" gave a full list of options
 after giving an error message.

 Will merge to 'master'.
 As a follow-up we may want to also handle "branch --points-at <object>"
 that shares the same problem.


* rv/grep-cleanup (2018-02-23) 2 commits
 - grep: simplify grep_oid and grep_file
 - grep: move grep_source_init outside critical section

 Threaded "git grep" has been optimized to avoid allocation in code
 section that is covered under a mutex.

 Will merge to 'next'.


* sg/subtree-signed-commits (2018-02-23) 1 commit
 - subtree: fix add and pull for GPG-signed commits

 "git subtree" script (in contrib/) scripted around "git log", whose
 output got affected by end-user configuration like log.showsignature

 Will merge to 'next'.


* ds/find-unique-abbrev-optim (2018-02-27) 1 commit
 - sha1_name: fix uninitialized memory errors

 While finding unique object name abbreviation, the code may
 accidentally have read beyond the end of the array of object names
 in a pack.

 Will merge to 'next'.


* ds/mark-parents-uninteresting-optim (2018-02-27) 1 commit
 - revision.c: reduce object database queries

 Micro optimization in revision traversal code.

 Will merge to 'next'.


* jc/test-must-be-empty (2018-02-27) 1 commit
 - test_must_be_empty: make sure the file exists, not just empty

 Test framework tweak to catch developer thinko.

 Will merge to 'next'.


* ma/roll-back-lockfiles (2018-02-28) 5 commits
 - sequencer: do not roll back lockfile unnecessarily
 - merge: always roll back lock in `checkout_fast_forward()`
 - merge-recursive: always roll back lock in `merge_recursive_generic()`
 - sequencer: always roll back lock in `do_recursive_merge()`
 - sequencer: make lockfiles non-static
 (this branch is used by ma/skip-writing-unchanged-index.)

 Some codepaths used to take a lockfile and did not roll it back;
 they are automatically rolled back at program exit, so there is no
 real "breakage", but it still is a good practice to roll back when
 you are done with a lockfile.

 Will merge to 'next'.


* mk/doc-pretty-fill (2018-02-27) 1 commit
 - docs/pretty-formats: fix typo '% <(<N>)' -> '%<|(<N>)'

 Docfix.

 Will merge to 'next'.


* nd/remove-ignore-env-field (2018-02-28) 4 commits
 - repository: delete ignore_env member
 - sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
 - repository.c: delete dead functions
 - repository.c: move env-related setup code back to environment.c
 (this branch uses sb/object-store; is tangled with sb/packfiles-in-repository.)


* rj/test-i18ngrep (2018-02-28) 2 commits
 - t5536: simplify checking of messages output to stderr
 - t4151: consolidate multiple calls to test_i18ngrep

 Test updates.

 Will merge to 'next'.


* rs/perf-repeat-thrice-by-default (2018-02-27) 1 commit
 - perf: use GIT_PERF_REPEAT_COUNT=3 by default even without config file

 Perf test regression fix.

 Will merge to 'next'.


* sb/object-store (2018-02-28) 27 commits
 - sha1_file: allow sha1_loose_object_info to handle arbitrary repositories
 - sha1_file: allow map_sha1_file to handle arbitrary repositories
 - sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
 - sha1_file: allow open_sha1_file to handle arbitrary repositories
 - sha1_file: allow stat_sha1_file to handle arbitrary repositories
 - sha1_file: allow sha1_file_name to handle arbitrary repositories
 - sha1_file: add repository argument to sha1_loose_object_info
 - sha1_file: add repository argument to map_sha1_file
 - sha1_file: add repository argument to map_sha1_file_1
 - sha1_file: add repository argument to open_sha1_file
 - sha1_file: add repository argument to stat_sha1_file
 - sha1_file: add repository argument to sha1_file_name
 - sha1_file: allow prepare_alt_odb to handle arbitrary repositories
 - sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
 - sha1_file: add repository argument to prepare_alt_odb
 - sha1_file: add repository argument to link_alt_odb_entries
 - sha1_file: add repository argument to read_info_alternates
 - sha1_file: add repository argument to link_alt_odb_entry
 - sha1_file: add raw_object_store argument to alt_odb_usable
 - pack: move approximate object count to object store
 - pack: move prepare_packed_git_run_once to object store
 - object-store: close all packs upon clearing the object store
 - object-store: move packed_git and packed_git_mru to object store
 - object-store: free alt_odb_list
 - object-store: move alt_odb_list and alt_odb_tail to object store
 - object-store: migrate alternates struct and functions from cache.h
 - repository: introduce raw object store field
 (this branch is used by nd/remove-ignore-env-field and sb/packfiles-in-repository.)

 Refactoring the internal global data structure to make it possible
 to open multiple repositories, work with and then close them.


* sb/packfiles-in-repository (2018-02-28) 11 commits
 - packfile: allow find_pack_entry to handle arbitrary repositories
 - packfile: add repository argument to find_pack_entry
 - packfile: allow reprepare_packed_git to handle arbitrary repositories
 - packfile: allow prepare_packed_git to handle arbitrary repositories
 - packfile: allow prepare_packed_git_one to handle arbitrary repositories
 - packfile: add repository argument to reprepare_packed_git
 - packfile: add repository argument to prepare_packed_git
 - packfile: add repository argument to prepare_packed_git_one
 - packfile: allow install_packed_git to handle arbitrary repositories
 - packfile: allow rearrange_packed_git to handle arbitrary repositories
 - packfile: allow prepare_packed_git_mru to handle arbitrary repositories
 (this branch uses sb/object-store; is tangled with nd/remove-ignore-env-field.)


* sg/test-x (2018-02-28) 11 commits
 - travis-ci: run tests with '-x' tracing
 - t/README: add a note about don't saving stderr of compound commands
 - t1510-repo-setup: mark as untraceable with '-x'
 - t9903-bash-prompt: don't check the stderr of __git_ps1()
 - t5570-git-daemon: don't check the stderr of a subshell
 - t5526: use $TRASH_DIRECTORY to specify the path of GIT_TRACE log file
 - t5500-fetch-pack: don't check the stderr of a subshell
 - t3030-merge-recursive: don't check the stderr of a subshell
 - t1507-rev-parse-upstream: don't check the stderr of a shell function
 - t: add means to disable '-x' tracing for individual test scripts
 - t: prevent '-x' tracing from interfering with test helpers' stderr

 Running test scripts under -x option of the shell is often not a
 useful way to debug them, because the error messages from the
 commands tests try to capture and inspect are contaminated by the
 tracing output by the shell.  An earlier work done to make it more
 pleasant to run tests under -x with recent versions of bash is
 extended to cover posix shells that do not support BASH_XTRACEFD.

 Will merge to 'next'.


* ab/gc-auto-in-commit (2018-03-01) 1 commit
 - commit: run git gc --auto just before the post-commit hook

 "git commit" used to run "gc --auto" near the end, which was lost
 when the command was reimplemented in C by mistake.

 Will merge to 'next'.


* ab/pre-auto-gc-battery (2018-02-28) 1 commit
 - hooks/pre-auto-gc-battery: allow gc to run on non-laptops

 A sample auto-gc hook (in contrib/) to skip auto-gc while on
 battery has been updated to almost always allow running auto-gc
 unless on_ac_power command is absolutely sure that we are on
 battery power (earlier, it skipped unless the command is sure that
 we are on ac power).

 Will merge to 'next'.


* ag/userdiff-go-funcname (2018-03-01) 1 commit
 - userdiff: add built-in pattern for golang

 "git diff" and friends learned funcname patterns for Go language
 source files.

 Will merge to 'next'.


* ma/skip-writing-unchanged-index (2018-03-01) 1 commit
 - write_locked_index(): add flag to avoid writing unchanged index
 (this branch uses ma/roll-back-lockfiles.)

 Internal API clean-up to allow write_locked_index() optionally skip
 writing the in-core index when it is not modified.

 May want to merge into ma/roll-back-lockfiles topic before merging
 to 'next'.

--------------------------------------------------
[Stalled]

* np/send-email-header-parsing (2017-12-15) 1 commit
 - send-email: extract email-parsing code into a subroutine

 Code refactoring.

 Undecided but inclined to drop.  A "refactor" without the code that
 benefit from the refactoring is hard to tell from code churn whose
 only effect is potential to introduce bugs.


* sg/travis-build-during-script-phase (2018-01-08) 1 commit
 - travis-ci: build Git during the 'script' phase

 Stalled for too long without any response; will discard.


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

 Perhaps it is about time to reboot the effort?


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

 Stalled for too long without any response; will discard.
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

 Stalled for too long without any response; will discard.


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

 Stalled for too long without any response; will discard.
 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>

--------------------------------------------------
[Cooking]

* jh/status-no-ahead-behind (2018-01-24) 4 commits
 - status: support --no-ahead-behind in long format
 - status: update short status to respect --no-ahead-behind
 - status: add --[no-]ahead-behind to status and commit for V2 format.
 - stat_tracking_info: return +1 when branches not equal

 "git status" can spend a lot of cycles to compute the relation
 between the current branch and its upstream, which can now be
 disabled with "--no-ahead-behind" option.

 Will merge to 'next'.


* nd/tilde-expand-opt-file-value (2018-02-14) 2 commits
 - init-db: change --template type to OPTION_FILENAME
 - parse-options: expand $HOME on filename options

 "git cmd --opt=~u/path/to/file" did not tilde-expand "~u" part to
 the path to the home directory of user 'u'

 Will discard.
 This may make the resulting whole more confusing, though.
 cf. <87wozffavp.fsf@evledraar.gmail.com>


* jc/allow-ff-merging-kept-tags (2018-02-16) 1 commit
  (merged to 'next' on 2018-02-27 at 8b03610d2b)
 + merge: allow fast-forward when merging a tracked tag

 Since Git 1.7.9, "git merge" defaulted to --no-ff (i.e. even when
 the side branch being merged is a descendant of the current commit,
 create a merge commit instead of fast-forwarding) when merging a
 tag object.  This was appropriate default for integrators who pull
 signed tags from their downstream contributors, but caused an
 unnecessary merges when used by downstream contributors who
 habitually "catch up" their topic branches with tagged releases
 from the upstream.  Update "git merge" to default to --no-ff only
 when merging a tag object that does *not* sit at its usual place in
 refs/tags/ hierarchy, and allow fast-forwarding otherwise, to
 mitigate the problem.

 Will merge to 'master'.


* ab/perl-fixes (2018-02-27) 13 commits
 - perl Git::LoadCPAN: emit better errors under NO_PERL_CPAN_FALLBACKS
 - Makefile: add NO_PERL_CPAN_FALLBACKS knob
 - perl: move the perl/Git/FromCPAN tree to perl/FromCPAN
 - perl: generalize the Git::LoadCPAN facility
 - perl: move CPAN loader wrappers to another namespace
 - perl: update our copy of Mail::Address
 - perl: update our ancient copy of Error.pm
 - git-send-email: unconditionally use Net::{SMTP,Domain}
 - Git.pm: hard-depend on the File::{Temp,Spec} modules
 - gitweb: hard-depend on the Digest::MD5 5.8 module
 - Git.pm: add the "use warnings" pragma
 - Git.pm: remove redundant "use strict" from sub-package
 - perl: *.pm files should not have the executable bit

 Only the first few of a series of several small patches.

 Expecting a reroll.


* ab/simplify-perl-makefile (2018-02-15) 1 commit
  (merged to 'next' on 2018-02-27 at b0d68a2013)
 + Makefile: generate Git(3pm) as dependency of the 'doc' and 'man' targets

 Hotfix for a topic already in 'master'.

 Will merge to 'master'.


* bw/doc-submodule-recurse-config-with-clone (2018-02-21) 1 commit
  (merged to 'next' on 2018-02-27 at 5b12841508)
 + submodule: indicate that 'submodule.recurse' doesn't apply to clone

 Doc update.

 Will merge to 'master'.


* ds/commit-graph (2018-02-20) 13 commits
 - commit-graph: build graph from starting commits
 - commit-graph: read only from specific pack-indexes
 - commit: integrate commit graph with commit parsing
 - commit-graph: close under reachability
 - commit-graph: add core.commitGraph setting
 - commit-graph: implement --delete-expired
 - commit-graph: implement --set-latest
 - commit-graph: implement git commit-graph read
 - commit-graph: implement 'git-commit-graph write'
 - commit-graph: implement write_commit_graph()
 - commit-graph: create git-commit-graph builtin
 - graph: add commit graph design document
 - commit-graph: add format document

 Precompute and store information necessary for ancestry traversal
 in a separate file to optimize graph walking.

 Reroll exists, but it appears that there will be a further reroll.
 cf. <1519698787-190494-1-git-send-email-dstolee@microsoft.com>


* ot/ref-filter-cleanup (2018-02-21) 2 commits
 - ref-filter: get rid of goto
 - ref-filter: get rid of duplicate code

 Code cleanup.

 Will merge to 'next'.


* sb/color-h-cleanup (2018-02-13) 1 commit
  (merged to 'next' on 2018-02-27 at 617345de77)
 + color.h: document and modernize header
 (this branch is used by sb/blame-color.)

 Devdoc update.

 Will merge to 'master'.


* ma/config-page-only-in-list-mode (2018-02-21) 3 commits
 - config: change default of `pager.config` to "on"
 - config: respect `pager.config` in list/get-mode only
 - t7006: add tests for how git config paginates

 In a way similar to how "git tag" learned to honor the pager
 setting only in the list mode, "git config" learned to ignore the
 pager setting when it is used for setting values (i.e. when the
 purpose of the operation is not to "show").

 Is this ready for 'next'?


* ot/cat-batch-format (2018-02-12) 23 commits
 - cat-file: update of docs
 - cat-file: tests for new atoms added
 - for-each-ref: tests for new atoms added
 - ref-filter: unifying formatting of cat-file opts
 - ref-filter: make populate_value() internal again
 - cat-file: reuse printing logic from ref-filter
 - ref-filter: make valid_atom general again
 - ref-filter: make cat_file_info independent
 - cat-file: move skip_object_info into ref-filter
 - ref_filter: add is_atom_used function
 - ref-filter: get rid of mark_atom_in_object_info()
 - cat-file: start reusing populate_value()
 - ref-filter: rename field in ref_array_item stuct
 - ref-filter: make populate_value() global
 - cat-file: start use ref_array_item struct
 - ref-filter: reuse parse_ref_filter_atom()
 - cat-file: start migrating formatting to ref-filter
 - cat-file: split expand_atom() into 2 functions
 - cat-file: move struct expand_data into ref-filter
 - ref-filter: make valid_atom as function parameter
 - cat-file: reuse struct ref_format
 - ref-filter: add return value to some functions
 - ref-filter: get rid of goto

 Teach "cat-file --batch" to reuse the formatting machinery shared
 by for-each-ref, branch --list, and tag --list.

 Allocates flex-array on stack, etc.
 cf. <58b2bdcd-d621-fd21-ab4d-6a9478319b19@ramsayjones.plus.com>
 Will discard--a rebooted effort is beginning elsewhere.


* sg/t6300-modernize (2018-02-13) 1 commit
  (merged to 'next' on 2018-02-27 at b6f13b6915)
 + t6300-for-each-ref: fix "more than one quoting style" tests

 Test update.

 Will merge to 'master'.


* xz/send-email-batch-size (2018-02-12) 1 commit
  (merged to 'next' on 2018-02-27 at da0247d532)
 + send-email: error out when relogin delay is missing

 "git send-email" learned to complain when the batch-size option is
 not defined when the relogin-delay option is, since these two are
 mutually required.

 Will merge to 'master'.


* pw/add-p-recount (2018-03-01) 9 commits
 - add -p: don't rely on apply's '--recount' option
 - add -p: fix counting when splitting and coalescing
 - add -p: calculate offset delta for edited patches
 - add -p: adjust offsets of subsequent hunks when one is skipped
 - t3701: add failing test for pathological context lines
 - t3701: don't hard code sha1 hash values
 - t3701: use test_write_lines and write_script
 - t3701: indent here documents
 - add -i: add function to format hunk header

 "git add -p" has been lazy in coalescing split patches before
 passing the result to underlying "git apply", leading to corner
 case bugs; the logic to prepare the patch to be applied after hunk
 selections has been tightened.

 Will merge to 'next'.


* pw/add-p-single (2018-02-13) 3 commits
  (merged to 'next' on 2018-02-27 at 0e2bd585e3)
 + add -p: improve error messages
 + add -p: only bind search key if there's more than one hunk
 + add -p: only display help for active keys

 "git add -p" used to offer "/" (look for a matching hunk) as a
 choice, even there was only one hunk, which has been corrected.
 Also the single-key help is now given only for keys that are
 enabled (e.g. help for '/' won't be shown when there is only one
 hunk).

 Will merge to 'master'.


* bp/untracked-cache-noflush (2018-02-28) 2 commits
 - untracked cache: use git_env_bool() not getenv() for customization
 - dir.c: don't flag the index as dirty for changes to the untracked cache

 Writing out the index file when the only thing that changed in it
 is the untracked cache information is often wasteful, and this has
 been optimized out.

 Will merge to 'next'.


* nd/diff-stat-with-summary (2018-02-27) 2 commits
 - diff: add --compact-summary
 - diff.c: refactor pprint_rename() to use strbuf

 "git diff" and friends learned "--compact-summary" that shows the
 information usually given with the "--summary" option on the same
 line as the diffstat output of the "--stat" option (which saves
 vertical space and keeps info on a single path at the same place).

 Will merge to 'next'.


* nd/parseopt-completion (2018-02-09) 41 commits
 - completion: use __gitcomp_builtin in _git_worktree
 - completion: use __gitcomp_builtin in _git_tag
 - completion: use __gitcomp_builtin in _git_status
 - completion: use __gitcomp_builtin in _git_show_branch
 - completion: use __gitcomp_builtin in _git_rm
 - completion: use __gitcomp_builtin in _git_revert
 - completion: use __gitcomp_builtin in _git_reset
 - completion: use __gitcomp_builtin in _git_replace
 - remote: force completing --mirror= instead of --mirror
 - completion: use __gitcomp_builtin in _git_remote
 - completion: use __gitcomp_builtin in _git_push
 - completion: use __gitcomp_builtin in _git_pull
 - completion: use __gitcomp_builtin in _git_notes
 - completion: use __gitcomp_builtin in _git_name_rev
 - completion: use __gitcomp_builtin in _git_mv
 - completion: use __gitcomp_builtin in _git_merge_base
 - completion: use __gitcomp_builtin in _git_merge
 - completion: use __gitcomp_builtin in _git_ls_remote
 - completion: use __gitcomp_builtin in _git_ls_files
 - completion: use __gitcomp_builtin in _git_init
 - completion: use __gitcomp_builtin in _git_help
 - completion: use __gitcomp_builtin in _git_grep
 - completion: use __gitcomp_builtin in _git_gc
 - completion: use __gitcomp_builtin in _git_fsck
 - completion: use __gitcomp_builtin in _git_fetch
 - completion: use __gitcomp_builtin in _git_difftool
 - completion: use __gitcomp_builtin in _git_describe
 - completion: use __gitcomp_builtin in _git_config
 - completion: use __gitcomp_builtin in _git_commit
 - completion: use __gitcomp_builtin in _git_clone
 - completion: use __gitcomp_builtin in _git_clean
 - completion: use __gitcomp_builtin in _git_cherry_pick
 - completion: use __gitcomp_builtin in _git_checkout
 - completion: use __gitcomp_builtin in _git_branch
 - completion: use __gitcomp_builtin in _git_apply
 - completion: use __gitcomp_builtin in _git_am
 - completion: use __gitcomp_builtin in _git_add
 - git-completion.bash: introduce __gitcomp_builtin
 - parse-options: let OPT__FORCE take optional flags argument
 - parse-options: add OPT_xxx_F() variants
 - parse-options: support --git-completion-helper

 Teach parse-options API an option to help the completion script,
 and make use of the mechanism in command line completion.

 Will merge to 'next'.


* pc/submodule-helper-foreach (2018-02-02) 5 commits
 - submodule: port submodule subcommand 'foreach' from shell to C
 - submodule foreach: document variable '$displaypath'
 - submodule foreach: clarify the '$toplevel' variable documentation
 - submodule foreach: document '$sm_path' instead of '$path'
 - submodule foreach: correct '$path' in nested submodules from a subdirectory

 Expecting a response to review comments
 e.g. cf. <20180206150044.1bffbb573c088d38c8e44bf5@google.com>


* tg/worktree-add-existing-branch (2018-02-05) 3 commits
 - worktree: teach "add" to check out existing branches
 - worktree: be clearer when "add" dwim-ery kicks in
 - worktree: improve message when creating a new worktree

 "git worktree add" learned to check out an existing branch.

 Expecting a reroll.
 cf. <CAPig+cRLohiqR_Drh7P0q3XbvC22WLjNwH0YLZo3dqFzZZuAPw@mail.gmail.com>
 cf. <CACsJy8BEKYqW+Ne_WY2RBaSbb9OKcjREtrawStj=eJsVsia_Jw@mail.gmail.com>
 The general idea is good, just end-user facing messages are found
 suboptimal.


* nm/tag-edit (2018-02-07) 1 commit
  (merged to 'next' on 2018-02-27 at 3bc8345213)
 + tag: add --edit option

 "git tag" learned an explicit "--edit" option that allows the
 message given via "-m" and "-F" to be further edited.

 Will merge to 'master'.


* sm/mv-dry-run-update (2018-02-07) 2 commits
  (merged to 'next' on 2018-02-27 at 17eef62ddf)
 + mv: remove unneeded 'if (!show_only)'
 + t7001: add test case for --dry-run

 Code clean-up.

 Will merge to 'master'.


* ab/fetch-prune (2018-02-09) 17 commits
  (merged to 'next' on 2018-02-27 at eafb648dd9)
 + fetch: make the --prune-tags work with <url>
 + fetch: add a --prune-tags option and fetch.pruneTags config
 + fetch tests: add scaffolding for the new fetch.pruneTags
 + git-fetch & config doc: link to the new PRUNING section
 + git remote doc: correct dangerous lies about what prune does
 + git fetch doc: add a new section to explain the ins & outs of pruning
 + fetch tests: fetch <url> <spec> as well as fetch [<remote>]
 + fetch tests: expand case/esac for later change
 + fetch tests: double quote a variable for interpolation
 + fetch tests: test --prune and refspec interaction
 + fetch tests: add a tag to be deleted to the pruning tests
 + fetch tests: re-arrange arguments for future readability
 + fetch tests: refactor in preparation for testing tag pruning
 + remote: add a macro for "refs/tags/*:refs/tags/*"
 + fetch: stop accessing "remote" variable indirectly
 + fetch: trivially refactor assignment to ref_nr
 + fetch: don't redundantly NULL something calloc() gave us

 Clarify how configured fetch refspecs interact with the "--prune"
 option of "git fetch", and also add a handy short-hand for getting
 rid of stale tags that are locally held.

 Will merge to 'master'.


* bw/c-plus-plus (2018-02-22) 37 commits
  (merged to 'next' on 2018-02-27 at daf85c03de)
 + replace: rename 'new' variables
 + trailer: rename 'template' variables
 + tempfile: rename 'template' variables
 + wrapper: rename 'template' variables
 + environment: rename 'namespace' variables
 + diff: rename 'template' variables
 + environment: rename 'template' variables
 + init-db: rename 'template' variables
 + unpack-trees: rename 'new' variables
 + trailer: rename 'new' variables
 + submodule: rename 'new' variables
 + split-index: rename 'new' variables
 + remote: rename 'new' variables
 + ref-filter: rename 'new' variables
 + read-cache: rename 'new' variables
 + line-log: rename 'new' variables
 + imap-send: rename 'new' variables
 + http: rename 'new' variables
 + entry: rename 'new' variables
 + diffcore-delta: rename 'new' variables
 + diff: rename 'new' variables
 + diff-lib: rename 'new' variable
 + commit: rename 'new' variables
 + combine-diff: rename 'new' variables
 + remote: rename 'new' variables
 + reflog: rename 'new' variables
 + pack-redundant: rename 'new' variables
 + help: rename 'new' variables
 + checkout: rename 'new' variables
 + apply: rename 'new' variables
 + apply: rename 'try' variables
 + diff: rename 'this' variables
 + rev-parse: rename 'this' variable
 + pack-objects: rename 'this' variables
 + blame: rename 'this' variables
 + object: rename function 'typename' to 'type_name'
 + object_info: change member name from 'typename' to 'type_name'

 Avoid using identifiers that clash with C++ keywords.  Even though
 it is not a goal to compile Git with C++ compilers, changes like
 this help use of code analysis tools that targets C++ on our
 codebase.

 Will merge to 'master'.


* nd/rebase-show-current-patch (2018-02-12) 3 commits
  (merged to 'next' on 2018-02-27 at 5a4e23a77c)
 + rebase: introduce and use pseudo-ref REBASE_HEAD
 + rebase: add --show-current-patch
 + am: add --show-current-patch

 The new "--show-current-patch" option gives an end-user facing way
 to get the diff being applied when "git rebase" (and "git am")
 stops with a conflict.

 Will merge to 'master'.


* nd/worktree-move (2018-02-12) 7 commits
 - worktree remove: allow it when $GIT_WORK_TREE is already gone
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Will merge to 'next'.


* cl/send-email-reply-to (2018-01-17) 2 commits
 - send-email: support separate "Reply-To" address
 - send-email: rename variables for "In-reply-to" to $foo_in_reply_to

 "git send-email" learned "--reply-to=<address>" option.

 May want to get the log messages updated.
 cf. <CAN0heSqxmLoh33i65JPhyQbmPaAcJcwrTCO+ZD4eb+qh8Pf8+w@mail.gmail.com>


* js/rebase-recreate-merge (2018-02-23) 12 commits
 - rebase -i: introduce --recreate-merges=[no-]rebase-cousins
 - pull: accept --rebase=recreate to recreate the branch topology
 - sequencer: handle post-rewrite for merge commands
 - sequencer: make refs generated by the `label` command worktree-local
 - rebase: introduce the --recreate-merges option
 - rebase-helper --make-script: introduce a flag to recreate merges
 - sequencer: fast-forward merge commits, if possible
 - sequencer: introduce the `merge` command
 - sequencer: introduce new commands to reset the revision
 - git-rebase--interactive: clarify arguments
 - sequencer: make rearrange_squash() a bit more obvious
 - sequencer: avoid using errno clobbered by rollback_lock_file()

 "git rebase" learned "--recreate-merges" to transplant the whole
 topology of commit graph elsewhere.

 Will merge to 'next'.


* bw/protocol-v2 (2018-03-01) 35 commits
 - remote-curl: don't request v2 when pushing
 - remote-curl: implement stateless-connect command
 - http: eliminate "# service" line when using protocol v2
 - http: don't always add Git-Protocol header
 - http: allow providing extra headers for http requests
 - remote-curl: store the protocol version the server responded with
 - remote-curl: create copy of the service name
 - pkt-line: add packet_buf_write_len function
 - transport-helper: introduce stateless-connect
 - transport-helper: refactor process_connect_service
 - transport-helper: remove name parameter
 - connect: don't request v2 when pushing
 - connect: refactor git_connect to only get the protocol version once
 - fetch-pack: support shallow requests
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
 - test-pkt-line: introduce a packet-line test helper
 - protocol: introduce enum protocol_version value protocol_v2
 - transport: store protocol version
 - connect: discover protocol version outside of get_remote_heads
 - connect: convert get_remote_heads to use struct packet_reader
 - transport: use get_refs_via_connect to get refs
 - upload-pack: factor out processing lines
 - upload-pack: convert to a builtin
 - pkt-line: add delim packet support
 - pkt-line: allow peeking a packet line without consuming it
 - pkt-line: introduce packet_read_with_status

 The beginning of the next-gen transfer protocol.


* ls/checkout-encoding (2018-03-01) 7 commits
 - convert: add round trip check based on 'core.checkRoundtripEncoding'
 - convert: add tracing for 'working-tree-encoding' attribute
 - convert: add 'working-tree-encoding' attribute
 - utf8: add function to detect a missing UTF-16/32 BOM
 - utf8: add function to detect prohibited UTF-16/32 BOM
 - strbuf: add xstrdup_toupper()
 - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).

 Expecting a reroll; it is almost there, though.
 cf. <CAPig+cR81J3fTOtrgAumAs=RC5hqYFfSmeb-ru-Yf_ahFuBiew@mail.gmail.com>
 cf. <8EE59DC3-69E0-412B-AC50-5D348D6D5BE0@gmail.com>


* sb/blame-color (2018-02-13) 3 commits
 - builtin/blame: highlight recently changed lines
 - builtin/blame: add option to color metadata fields separately
 - builtin/blame: dim uninteresting metadata
 (this branch uses sb/color-h-cleanup.)

 Expecting a reroll.
 cf. https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/#t
 error messages are funny, can segfault, ...


* en/rename-directory-detection (2018-02-27) 29 commits
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
 - merge-recursive: check for directory level conflicts
 - merge-recursive: add get_directory_renames()
 - merge-recursive: make a helper function for cleanup for handle_renames
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

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.  A bug causing dirty files involved in a rename
 to be overwritten during merge has also been fixed as part of this
 work.

 Will merge to 'next'.
