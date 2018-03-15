Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8AB1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 01:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeCOBe4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 21:34:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32812 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbeCOBey (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 21:34:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id z73so2348039wrb.0
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 18:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=G9z4pCyh+ctuMa670vWlPl4hSniCSpAGF9dJOwf959c=;
        b=UpQ+nIaN8T+soBM3DvrEDGC8OSCg0ZnrQ1RSQsWh5HEqSbnaFsAWBEmekSGJoh4zo4
         PPOG2FYrwHCTExb6buB8etIHiJKgQ7hcHWYEhLjwyS+NiY04VgSU6RSzNb7cbgdvfaIz
         GVcmtZOhZ/qAPQ2c6I4i3nVgve5yFnRbzm/Q9uqQj2Ruealp5dbOy2dtz2Ie8wEQrTWe
         9RqBa4Obp0zCWvx+nvuOgudQLjqQvjx48+8gskUum3ZGNO01v3/nhEoZCj7+vua3hLr3
         J1sy7yLlTevA9A/7QhD+BE9NpyDEJs9egUwpnIFmdd2eYrUl71m+4sPa9XjW3ei4Deqn
         w5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=G9z4pCyh+ctuMa670vWlPl4hSniCSpAGF9dJOwf959c=;
        b=Y8OOuz2Csz+2HK8Y52WvU/b3aTA39vGo4HuPU9VlgIzII7k2plSbu+1CUSNHvyV0w9
         x/Ltrq7lDkJBLshICUxwnpNrGiAH0S/SORgiihi4S4F+gsZCg55qU9xd+wA5pal63AxI
         iZzBoIjOpRx19rLo7FD43+Cod0gu2MaWhohK9F+G95fNEkQM1EZm2toyIn/yiMKVocJo
         WgoW70zntlrX5pI7MRZjAulcJLUUoJOkWAEYku1yc/QF+tYywCAiS3agpuHeZjvlFPOi
         ULVHSvx+LzoEvmu1i2lhLZu2l9SbAN9Vp8X3kUcCjA1wyotkNbPeRUrlPICaHDPnsMSo
         YZeg==
X-Gm-Message-State: AElRT7H1WkmbCT0Sv0rFlX01d/IEC95bykcaUwJrI6qN8SbBQZ9elyAh
        jM/Ry0rg3suRE5k7JMhYefav6kGLkILA/w==
X-Google-Smtp-Source: AG47ELs7fSZgTrOmPzWh7ctRmOQR4KwMF6G4tPM5/j45pq4M41a4AZuIW+RbyKqdYQR8UYqKR0vlJg==
X-Received: by 10.223.141.143 with SMTP id o15mr5783433wrb.272.1521077691384;
        Wed, 14 Mar 2018 18:34:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i44sm3429972wri.23.2018.03.14.18.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 18:34:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2018, #03; Wed, 14)
X-master-at: 7fb6aefd2aaffe66e614f7f7b83e5b7ab16d4806
X-next-at: 6dcf76e1189e32b367ea053200d21aa31432517e
Date:   Wed, 14 Mar 2018 18:34:49 -0700
Message-ID: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
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

* ab/gc-auto-in-commit (2018-03-01) 1 commit
  (merged to 'next' on 2018-03-02 at 96a5a4d629)
 + commit: run git gc --auto just before the post-commit hook

 "git commit" used to run "gc --auto" near the end, which was lost
 when the command was reimplemented in C by mistake.


* ab/pre-auto-gc-battery (2018-02-28) 1 commit
  (merged to 'next' on 2018-03-06 at ca9cb273cb)
 + hooks/pre-auto-gc-battery: allow gc to run on non-laptops

 A sample auto-gc hook (in contrib/) to skip auto-gc while on
 battery has been updated to almost always allow running auto-gc
 unless on_ac_power command is absolutely sure that we are on
 battery power (earlier, it skipped unless the command is sure that
 we are on ac power).


* ag/userdiff-go-funcname (2018-03-01) 1 commit
  (merged to 'next' on 2018-03-02 at ea404d1be9)
 + userdiff: add built-in pattern for golang

 "git diff" and friends learned funcname patterns for Go language
 source files.


* bp/untracked-cache-noflush (2018-02-28) 2 commits
  (merged to 'next' on 2018-03-02 at 709887971b)
 + untracked cache: use git_env_bool() not getenv() for customization
 + dir.c: don't flag the index as dirty for changes to the untracked cache

 Writing out the index file when the only thing that changed in it
 is the untracked cache information is often wasteful, and this has
 been optimized out.


* ds/find-unique-abbrev-optim (2018-02-27) 1 commit
  (merged to 'next' on 2018-03-02 at 0b6d4f9335)
 + sha1_name: fix uninitialized memory errors

 While finding unique object name abbreviation, the code may
 accidentally have read beyond the end of the array of object names
 in a pack.


* ds/mark-parents-uninteresting-optim (2018-02-27) 1 commit
  (merged to 'next' on 2018-03-02 at 5a42c79806)
 + revision.c: reduce object database queries

 Micro optimization in revision traversal code.


* jc/test-must-be-empty (2018-02-27) 1 commit
  (merged to 'next' on 2018-03-02 at ec129f1b97)
 + test_must_be_empty: make sure the file exists, not just empty

 Test framework tweak to catch developer thinko.


* jh/status-no-ahead-behind (2018-01-24) 4 commits
  (merged to 'next' on 2018-03-02 at 68bde8d571)
 + status: support --no-ahead-behind in long format
 + status: update short status to respect --no-ahead-behind
 + status: add --[no-]ahead-behind to status and commit for V2 format.
 + stat_tracking_info: return +1 when branches not equal

 "git status" can spend a lot of cycles to compute the relation
 between the current branch and its upstream, which can now be
 disabled with "--no-ahead-behind" option.


* jk/add-i-diff-filter (2018-03-05) 2 commits
  (merged to 'next' on 2018-03-08 at 6ef737add3)
 + add--interactive: detect bogus diffFilter output
 + t3701: add a test for interactive.diffFilter

 The "interactive.diffFilter" used by "git add -i" must retain
 one-to-one correspondence between its input and output, but it was
 not enforced and caused end-user confusion.  We now at least make
 sure the filtered result has the same number of lines as its input
 to detect a broken filter.


* jk/smart-http-protocol-doc-fix (2018-03-05) 1 commit
  (merged to 'next' on 2018-03-08 at 599b1a7c42)
 + smart-http: document flush after "# service" line

 A doc update.


* ma/roll-back-lockfiles (2018-02-28) 5 commits
  (merged to 'next' on 2018-03-06 at be29bf891c)
 + sequencer: do not roll back lockfile unnecessarily
 + merge: always roll back lock in `checkout_fast_forward()`
 + merge-recursive: always roll back lock in `merge_recursive_generic()`
 + sequencer: always roll back lock in `do_recursive_merge()`
 + sequencer: make lockfiles non-static
 (this branch is used by ma/skip-writing-unchanged-index.)

 Some codepaths used to take a lockfile and did not roll it back;
 they are automatically rolled back at program exit, so there is no
 real "breakage", but it still is a good practice to roll back when
 you are done with a lockfile.


* mk/doc-pretty-fill (2018-02-27) 1 commit
  (merged to 'next' on 2018-03-02 at 623461b127)
 + docs/pretty-formats: fix typo '% <(<N>)' -> '%<|(<N>)'

 Docfix.


* nd/diff-stat-with-summary (2018-02-27) 2 commits
  (merged to 'next' on 2018-03-06 at d543f92f5e)
 + diff: add --compact-summary
 + diff.c: refactor pprint_rename() to use strbuf

 "git diff" and friends learned "--compact-summary" that shows the
 information usually given with the "--summary" option on the same
 line as the diffstat output of the "--stat" option (which saves
 vertical space and keeps info on a single path at the same place).


* nd/object-allocation-comments (2018-03-06) 2 commits
  (merged to 'next' on 2018-03-08 at 91d553a339)
 + object.h: realign object flag allocation comment
 + object.h: update flag allocation comment

 Code doc update.


* nd/parseopt-completion (2018-03-07) 45 commits
  (merged to 'next' on 2018-03-08 at 2461b7035d)
 + completion: more subcommands in _git_notes()
 + completion: complete --{reuse,reedit}-message= for all notes subcmds
 + completion: simplify _git_notes
 + completion: don't set PARSE_OPT_NOCOMPLETE on --rerere-autoupdate
  (merged to 'next' on 2018-03-02 at d72a6525fd)
 + completion: use __gitcomp_builtin in _git_worktree
 + completion: use __gitcomp_builtin in _git_tag
 + completion: use __gitcomp_builtin in _git_status
 + completion: use __gitcomp_builtin in _git_show_branch
 + completion: use __gitcomp_builtin in _git_rm
 + completion: use __gitcomp_builtin in _git_revert
 + completion: use __gitcomp_builtin in _git_reset
 + completion: use __gitcomp_builtin in _git_replace
 + remote: force completing --mirror= instead of --mirror
 + completion: use __gitcomp_builtin in _git_remote
 + completion: use __gitcomp_builtin in _git_push
 + completion: use __gitcomp_builtin in _git_pull
 + completion: use __gitcomp_builtin in _git_notes
 + completion: use __gitcomp_builtin in _git_name_rev
 + completion: use __gitcomp_builtin in _git_mv
 + completion: use __gitcomp_builtin in _git_merge_base
 + completion: use __gitcomp_builtin in _git_merge
 + completion: use __gitcomp_builtin in _git_ls_remote
 + completion: use __gitcomp_builtin in _git_ls_files
 + completion: use __gitcomp_builtin in _git_init
 + completion: use __gitcomp_builtin in _git_help
 + completion: use __gitcomp_builtin in _git_grep
 + completion: use __gitcomp_builtin in _git_gc
 + completion: use __gitcomp_builtin in _git_fsck
 + completion: use __gitcomp_builtin in _git_fetch
 + completion: use __gitcomp_builtin in _git_difftool
 + completion: use __gitcomp_builtin in _git_describe
 + completion: use __gitcomp_builtin in _git_config
 + completion: use __gitcomp_builtin in _git_commit
 + completion: use __gitcomp_builtin in _git_clone
 + completion: use __gitcomp_builtin in _git_clean
 + completion: use __gitcomp_builtin in _git_cherry_pick
 + completion: use __gitcomp_builtin in _git_checkout
 + completion: use __gitcomp_builtin in _git_branch
 + completion: use __gitcomp_builtin in _git_apply
 + completion: use __gitcomp_builtin in _git_am
 + completion: use __gitcomp_builtin in _git_add
 + git-completion.bash: introduce __gitcomp_builtin
 + parse-options: let OPT__FORCE take optional flags argument
 + parse-options: add OPT_xxx_F() variants
 + parse-options: support --git-completion-helper

 The parse-options API has been taught an option to help the
 completion script; the command line completion has been updated to
 take advantage of this mechanism.


* nd/worktree-move (2018-03-06) 8 commits
  (merged to 'next' on 2018-03-06 at a26271e7de)
 + t2028: fix minor error and issues in newly-added "worktree move" tests
  (merged to 'next' on 2018-03-02 at 5c514dfc92)
 + worktree remove: allow it when $GIT_WORK_TREE is already gone
 + worktree remove: new command
 + worktree move: refuse to move worktrees with submodules
 + worktree move: accept destination as directory
 + worktree move: new command
 + worktree.c: add update_worktree_location()
 + worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.


* ot/ref-filter-cleanup (2018-02-21) 2 commits
  (merged to 'next' on 2018-03-02 at 3b4c39a4b5)
 + ref-filter: get rid of goto
 + ref-filter: get rid of duplicate code

 Code cleanup.


* pw/add-p-recount (2018-03-05) 9 commits
  (merged to 'next' on 2018-03-06 at 68952f9bb0)
 + add -p: don't rely on apply's '--recount' option
 + add -p: fix counting when splitting and coalescing
 + add -p: calculate offset delta for edited patches
 + add -p: adjust offsets of subsequent hunks when one is skipped
 + t3701: add failing test for pathological context lines
 + t3701: don't hard code sha1 hash values
 + t3701: use test_write_lines and write_script
 + t3701: indent here documents
 + add -i: add function to format hunk header
 (this branch is used by pw/add-p-select.)

 "git add -p" has been lazy in coalescing split patches before
 passing the result to underlying "git apply", leading to corner
 case bugs; the logic to prepare the patch to be applied after hunk
 selections has been tightened.


* rj/test-i18ngrep (2018-02-28) 2 commits
  (merged to 'next' on 2018-03-06 at 7ea1a2352c)
 + t5536: simplify checking of messages output to stderr
 + t4151: consolidate multiple calls to test_i18ngrep

 Test updates.


* rs/perf-repeat-thrice-by-default (2018-02-27) 1 commit
  (merged to 'next' on 2018-03-02 at 4898b3c450)
 + perf: use GIT_PERF_REPEAT_COUNT=3 by default even without config file

 Perf test regression fix.


* rv/grep-cleanup (2018-02-23) 2 commits
  (merged to 'next' on 2018-03-02 at 4aafca15f9)
 + grep: simplify grep_oid and grep_file
 + grep: move grep_source_init outside critical section

 Threaded "git grep" has been optimized to avoid allocation in code
 section that is covered under a mutex.


* sg/subtree-signed-commits (2018-02-23) 1 commit
  (merged to 'next' on 2018-03-02 at c5f6fd33e6)
 + subtree: fix add and pull for GPG-signed commits

 "git subtree" script (in contrib/) scripted around "git log", whose
 output got affected by end-user configuration like log.showsignature


* sg/test-x (2018-02-28) 11 commits
  (merged to 'next' on 2018-03-06 at ab0684b27c)
 + travis-ci: run tests with '-x' tracing
 + t/README: add a note about don't saving stderr of compound commands
 + t1510-repo-setup: mark as untraceable with '-x'
 + t9903-bash-prompt: don't check the stderr of __git_ps1()
 + t5570-git-daemon: don't check the stderr of a subshell
 + t5526: use $TRASH_DIRECTORY to specify the path of GIT_TRACE log file
 + t5500-fetch-pack: don't check the stderr of a subshell
 + t3030-merge-recursive: don't check the stderr of a subshell
 + t1507-rev-parse-upstream: don't check the stderr of a shell function
 + t: add means to disable '-x' tracing for individual test scripts
 + t: prevent '-x' tracing from interfering with test helpers' stderr

 Running test scripts under -x option of the shell is often not a
 useful way to debug them, because the error messages from the
 commands tests try to capture and inspect are contaminated by the
 tracing output by the shell.  An earlier work done to make it more
 pleasant to run tests under -x with recent versions of bash is
 extended to cover posix shells that do not support BASH_XTRACEFD.


* sg/travis-build-during-script-phase (2018-01-08) 1 commit
  (merged to 'next' on 2018-03-02 at 29e1585ae7)
 + travis-ci: build Git during the 'script' phase

 Build the executable in 'script' phase in Travis CI integration, to
 follow the established practice, rather than during 'before_script'
 phase.  This allows the CI categorize the failures better ('failed'
 is project's fault, 'errored' is build environment's).

--------------------------------------------------
[New Topics]

* ab/man-sec-list (2018-03-08) 1 commit
  (merged to 'next' on 2018-03-09 at 9626b691e2)
 + git manpage: note git-security@googlegroups.com

 Doc update.

 Will merge to 'master'.


* sg/cvs-tests-with-x (2018-03-08) 2 commits
  (merged to 'next' on 2018-03-09 at 6ec749c7b7)
 + t9402-git-cvsserver-refs: don't check the stderr of a subshell
 + t9400-git-cvsserver-server: don't rely on the output of 'test_cmp'

 Allow running a couple of tests with "sh -x".

 Will merge to 'master'.


* tl/userdiff-csharp-async (2018-03-08) 1 commit
  (merged to 'next' on 2018-03-09 at 6dcf76e118)
 + userdiff.c: add C# async keyword in diff pattern

 Update funcname pattern used for C# to recognize "async" keyword.

 Will merge to 'master'.


* ti/fetch-everything-local-optim (2018-03-14) 1 commit
 - fetch-pack.c: use oidset to check existence of loose object

 A "git fetch" from a repository with insane number of refs into a
 repository that is already up-to-date still wasted too many cycles
 making many lstat(2) calls to see if these objects at the tips
 exist as loose objects locally.  These lstat(2) calls are optimized
 away by enumerating all loose objects beforehand.

 It is unknown if the new strategy negatively affects existing use
 cases, fetching into a repository with many loose objects from a
 repository with small number of refs.

 Will merge to 'next'.


* ab/nuke-emacs-contrib (2018-03-13) 1 commit
 - git{,-blame}.el: remove old bitrotting Emacs code

 The scripts in contrib/emacs/ have outlived their usefulness and
 have been removed.

 Will merge to 'next'.


* bc/object-id (2018-03-14) 36 commits
 - convert: convert to struct object_id
 - sha1_file: introduce a constant for max header length
 - Convert lookup_replace_object to struct object_id
 - sha1_file: convert read_sha1_file to struct object_id
 - sha1_file: convert read_object_with_reference to object_id
 - tree-walk: convert tree entry functions to object_id
 - streaming: convert istream internals to struct object_id
 - tree-walk: convert get_tree_entry_follow_symlinks internals to object_id
 - builtin/notes: convert static functions to object_id
 - builtin/fmt-merge-msg: convert remaining code to object_id
 - sha1_file: convert sha1_object_info* to object_id
 - Convert remaining callers of sha1_object_info_extended to object_id
 - packfile: convert unpack_entry to struct object_id
 - sha1_file: convert retry_bad_packed_offset to struct object_id
 - sha1_file: convert assert_sha1_type to object_id
 - builtin/mktree: convert to struct object_id
 - streaming: convert open_istream to use struct object_id
 - sha1_file: convert check_sha1_signature to struct object_id
 - sha1_file: convert read_loose_object to use struct object_id
 - builtin/index-pack: convert struct ref_delta_entry to object_id
 - archive: convert sha1_file_to_archive to struct object_id
 - archive: convert write_archive_entry_fn_t to object_id
 - builtin/mktag: convert to struct object_id
 - replace_object: convert struct replace_object to object_id
 - send-pack: convert remaining functions to struct object_id
 - http-walker: convert struct object_request to use struct object_id
 - Convert find_unique_abbrev* to struct object_id
 - wt-status: convert struct wt_status_state to object_id
 - strbuf: convert strbuf_add_unique_abbrev to use struct object_id
 - ref-filter: convert grab_objectname to struct object_id
 - tree: convert read_tree_recursive to struct object_id
 - resolve-undo: convert struct resolve_undo_info to object_id
 - cache-tree: convert remnants to struct object_id
 - cache-tree: convert write_*_as_tree to object_id
 - builtin/write-tree: convert to struct object_id
 - bulk-checkin: convert index_bulk_checkin to struct object_id

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'next'.


* jh/fsck-promisors (2018-03-13) 1 commit
 - sha1_file: restore OBJECT_INFO_QUICK functionality

 A hotfix to a topic that graduated recently.

 Will merge to 'next'.


* ma/shortlog-revparse (2018-03-13) 3 commits
 - shortlog: do not accept revisions when run outside repo
 - shortlog: add usage-string for stdin-reading
 - git-shortlog.txt: reorder usages

 "git shortlog cruft" aborted with a BUG message when run outside a
 Git repository.  The command has been taught to complain about
 extra and unwanted arguments on its command line instead in such a
 case.

 Expecting a reroll.
 cf. <CAN0heSoDSf+3VmRowHmiTPDDzfdvUjQi+tjpPF6RW172ZE5BWw@mail.gmail.com>


* ab/pcre-v2 (2018-03-14) 3 commits
 - Makefile: make USE_LIBPCRE=YesPlease mean v2, not v1
 - configure: detect redundant --with-libpcre & --with-libpcre1
 - configure: fix a regression in PCRE v1 detection

 Git can be built to use either v1 or v2 of the PCRE library, and so
 far, the build-time configuration USE_LIBPCRE=YesPlease instructed
 the build procedure to use v1, but now it means v2.  USE_LIBPCRE1
 and USE_LIBPCRE2 can be used to explicitly choose which version to
 use, as before.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* sb/blame-color (2018-02-13) 3 commits
 - builtin/blame: highlight recently changed lines
 - builtin/blame: add option to color metadata fields separately
 - builtin/blame: dim uninteresting metadata

 Expecting a reroll.
 cf. https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/#t
 error messages are funny, can segfault, ...


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

--------------------------------------------------
[Cooking]

* bb/git-gui-ssh-key-files (2018-03-02) 2 commits
 - Merge branch 'bb/ssh-key-files' of git-gui into bb/git-gui-ssh-key-files
 - git-gui: search for all current SSH key types

 "git gui" learned that "~/.ssh/id_ecdsa.pub" and
 "~/.ssh/id_ed25519.pub" are also possible SSH key files.


* bp/git-gui-bind-kp-enter (2018-03-02) 2 commits
 - Merge branch 'bp/bind-kp-enter' of git-gui into bp/git-gui-bind-kp-enter
 - git-gui: bind CTRL/CMD+numpad ENTER to do_commit

 "git gui" performs commit upon CTRL/CMD+ENTER but the
 CTRL/CMD+KP_ENTER (i.e. enter key on the numpad) did not have the
 same key binding.  It now does.


* cb/git-gui-ttk-style (2018-03-05) 2 commits
 - Merge branch 'cb/ttk-style' of git-gui into cb/git-gui-ttk-style
 - git-gui: workaround ttk:style theme use

 "git gui" has been taught to work with old versions of tk (like
 8.5.7) that do not support "ttk::style theme use" as a way to query
 the current theme.


* nd/pack-objects-pack-struct (2018-03-05) 9 commits
 - pack-objects: reorder 'hash' to pack struct object_entry
 - pack-objects: refer to delta objects by index instead of pointer
 - pack-objects: move in_pack out of struct object_entry
 - pack-objects: move in_pack_pos out of struct object_entry
 - pack-objects: note about in_pack_header_size
 - pack-objects: use bitfield for object_entry::depth
 - pack-objects: use bitfield for object_entry::dfs_state
 - pack-objects: turn type and in_pack_type to bitfields
 - pack-objects: document holes in struct object_entry.h

 "git pack-objects" needs to allocate tons of "struct object_entry"
 while doing its work, and shrinking its size helps the performance
 quite a bit.

 Will merge to 'next'.


* nd/repack-keep-pack (2018-03-07) 6 commits
 - SQUASH???
 - pack-objects: display progress in get_object_details()
 - pack-objects: show some progress when counting kept objects
 - gc --auto: exclude base pack if not enough mem to "repack -ad"
 - repack: add --keep-pack option
 - t7700: have closing quote of a test at the beginning of line

 "git gc" in a large repository takes a lot of time as it considers
 to repack all objects into one pack by default.  The command has
 been taught to pretend as if the largest existing packfile is
 marked with ".keep" so that it is left untouched while objects in
 other packs and loose ones are repacked.

 Expecting a reroll.
 cf. <CACsJy8BW_EtxQvgL=YrCXCQY7cEWCQxgfkeH=Gd=X=uVYhPJcw@mail.gmail.com>
 Except for final finishing touches, this looked more-or-less ready
 for 'next'.


* nd/worktree-prune (2018-03-06) 3 commits
 - worktree prune: improve prune logic when worktree is moved
 - worktree: delete dead code
 - gc.txt: more details about what gc does

 The way "git worktree prune" worked internally has been simplified,
 by assuming how "git worktree move" moves an existing worktree to a
 different place.

 Will merge to 'next'.


* pw/add-p-select (2018-03-06) 3 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Expecting a reroll.
 cf. <6476d776-dbf7-09cf-1c65-e413798b9987@talktalk.net>


* ld/p4-unshelve (2018-02-22) 1 commit
 - git-p4: add unshelve command

 "git p4" learned to "unshelve" shelved commit from P4.

 Will hold, perhaps drop and use format-change that uses a proper "diff".
 cf. <CAE5ih7_ooDMqVtTMoQ70s5XCkncr04HY0JkqSp1UmKQeG81oaA@mail.gmail.com>


* ps/contains-id-error-message (2018-03-06) 1 commit
 - parse-options: squelch usage help on certain errors

 "git tag --contains no-such-commit" gave a full list of options
 after giving an error message.

 Expecting a reroll.
 cf. <CAN0heSrnERYggyJ8bL1nAV=X2JQYS8aOkc6nWZhnZu3oqhzAfA@mail.gmail.com>
 Rebooted and fixed the root cause of the issue at a lower level.


* nd/remove-ignore-env-field (2018-03-05) 5 commits
 - repository: delete ignore_env member
 - sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
 - repository.c: delete dead functions
 - repository.c: move env-related setup code back to environment.c
 - repository: initialize the_repository in main()
 (this branch is used by sb/object-store and sb/packfiles-in-repository.)

 Code clean-up for the "repository" abstraction.

 Will merge to 'next'.


* sb/object-store (2018-03-05) 27 commits
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
 (this branch is used by sb/packfiles-in-repository; uses nd/remove-ignore-env-field.)

 Refactoring the internal global data structure to make it possible
 to open multiple repositories, work with and then close them.

 Rerolled by Duy on top of a separate preliminary clean-up topic.
 The resulting structure of the topics looked very sensible.

 Waiting for a follow-up discussion.


* sb/packfiles-in-repository (2018-03-05) 12 commits
 - packfile: keep prepare_packed_git() private
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
 (this branch uses nd/remove-ignore-env-field and sb/object-store.)

 Refactoring of the internal global data structure continues.

 Waiting for a follow-up discussion.


* ma/skip-writing-unchanged-index (2018-03-01) 1 commit
 - write_locked_index(): add flag to avoid writing unchanged index

 Internal API clean-up to allow write_locked_index() optionally skip
 writing the in-core index when it is not modified.

 Will merge to 'next'.


* ab/perl-fixes (2018-03-05) 13 commits
  (merged to 'next' on 2018-03-09 at 262d84c1ba)
 + perl Git::LoadCPAN: emit better errors under NO_PERL_CPAN_FALLBACKS
 + Makefile: add NO_PERL_CPAN_FALLBACKS knob
 + perl: move the perl/Git/FromCPAN tree to perl/FromCPAN
 + perl: generalize the Git::LoadCPAN facility
 + perl: move CPAN loader wrappers to another namespace
 + perl: update our copy of Mail::Address
 + perl: update our ancient copy of Error.pm
 + git-send-email: unconditionally use Net::{SMTP,Domain}
 + Git.pm: hard-depend on the File::{Temp,Spec} modules
 + gitweb: hard-depend on the Digest::MD5 5.8 module
 + Git.pm: add the "use warnings" pragma
 + Git.pm: remove redundant "use strict" from sub-package
 + perl: *.pm files should not have the executable bit

 Clean-up to various pieces of Perl code we have.

 Will merge to 'master'.


* ds/commit-graph (2018-03-14) 17 commits
 - SQUASH??? sparse fixes
 - commit-graph: implement "--additive" option
 - commit-graph: build graph from starting commits
 - commit-graph: read only from specific pack-indexes
 - commit: integrate commit graph with commit parsing
 - commit-graph: close under reachability
 - commit-graph: add core.commitGraph setting
 - commit-graph: implement git commit-graph read
 - commit-graph: implement 'git-commit-graph write'
 - commit-graph: implement write_commit_graph()
 - commit-graph: create git-commit-graph builtin
 - graph: add commit graph design document
 - commit-graph: add format document
 - csum-file: refactor finalize_hashfile() method
 - csum-file: rename hashclose() to finalize_hashfile()
 - Merge branch 'jk/cached-commit-buffer' into HEAD
 - Merge branch 'jt/binsearch-with-fanout' into HEAD

 Precompute and store information necessary for ancestry traversal
 in a separate file to optimize graph walking.

 It seems that this topic is getting there.


* ma/config-page-only-in-list-mode (2018-02-21) 3 commits
 - config: change default of `pager.config` to "on"
 - config: respect `pager.config` in list/get-mode only
 - t7006: add tests for how git config paginates

 In a way similar to how "git tag" learned to honor the pager
 setting only in the list mode, "git config" learned to ignore the
 pager setting when it is used for setting values (i.e. when the
 purpose of the operation is not to "show").

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


* np/send-email-header-parsing (2017-12-15) 1 commit
  (merged to 'next' on 2018-03-09 at 91ef7216f7)
 + send-email: extract email-parsing code into a subroutine
 (this branch is used by cl/send-email-reply-to.)

 Code refactoring.

 Will merge to 'master'.


* cl/send-email-reply-to (2018-03-06) 2 commits
  (merged to 'next' on 2018-03-09 at 3d3c3ab441)
 + send-email: support separate Reply-To address
 + send-email: rename variable for clarity
 (this branch uses np/send-email-header-parsing.)

 "git send-email" learned "--reply-to=<address>" option.

 Will merge to 'master'.


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


* bw/protocol-v2 (2018-03-14) 35 commits
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
 - push: pass ref prefixes when pushing
 - fetch: pass ref prefixes when fetching
 - ls-remote: pass ref prefixes when requesting a remote's refs
 - transport: convert transport_get_remote_refs to take a list of ref prefixes
 - transport: convert get_refs_list to take a list of ref prefixes
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


* ls/checkout-encoding (2018-03-09) 10 commits
 - convert: add round trip check based on 'core.checkRoundtripEncoding'
 - convert: add tracing for 'working-tree-encoding' attribute
 - convert: advise canonical UTF encoding names
 - convert: check for detectable errors in UTF encodings
 - convert: add 'working-tree-encoding' attribute
 - utf8: add function to detect a missing UTF-16/32 BOM
 - utf8: add function to detect prohibited UTF-16/32 BOM
 - strbuf: add a case insensitive starts_with()
 - strbuf: add xstrdup_toupper()
 - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).

 Expecting a reroll.
 cf. <66370A41-A048-44E7-9BF8-4631C50AAE63@gmail.com>
 Modulo minor design decision corrections, the series is almost there.


* en/rename-directory-detection (2018-02-27) 29 commits
  (merged to 'next' on 2018-03-06 at d42470f86e)
 + merge-recursive: ensure we write updates for directory-renamed file
 + merge-recursive: avoid spurious rename/rename conflict from dir renames
 + directory rename detection: new testcases showcasing a pair of bugs
 + merge-recursive: fix remaining directory rename + dirty overwrite cases
 + merge-recursive: fix overwriting dirty files involved in renames
 + merge-recursive: avoid clobbering untracked files with directory renames
 + merge-recursive: apply necessary modifications for directory renames
 + merge-recursive: when comparing files, don't include trees
 + merge-recursive: check for file level conflicts then get new name
 + merge-recursive: add computation of collisions due to dir rename & merging
 + merge-recursive: check for directory level conflicts
 + merge-recursive: add get_directory_renames()
 + merge-recursive: make a helper function for cleanup for handle_renames
 + merge-recursive: split out code for determining diff_filepairs
 + merge-recursive: make !o->detect_rename codepath more obvious
 + merge-recursive: fix leaks of allocated renames and diff_filepairs
 + merge-recursive: introduce new functions to handle rename logic
 + merge-recursive: move the get_renames() function
 + directory rename detection: tests for handling overwriting dirty files
 + directory rename detection: tests for handling overwriting untracked files
 + directory rename detection: miscellaneous testcases to complete coverage
 + directory rename detection: testcases exploring possibly suboptimal merges
 + directory rename detection: more involved edge/corner testcases
 + directory rename detection: testcases checking which side did the rename
 + directory rename detection: files/directories in the way of some renames
 + directory rename detection: partially renamed directory testcase/discussion
 + directory rename detection: testcases to avoid taking detection too far
 + directory rename detection: directory splitting testcases
 + directory rename detection: basic testcases

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.  A bug causing dirty files involved in a rename
 to be overwritten during merge has also been fixed as part of this
 work.

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

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


* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 Stalled for too long without any response; will discard.
 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* nd/tilde-expand-opt-file-value (2018-02-14) 2 commits
 - init-db: change --template type to OPTION_FILENAME
 - parse-options: expand $HOME on filename options

 "git cmd --opt=~u/path/to/file" did not tilde-expand "~u" part to
 the path to the home directory of user 'u'

 This may make the resulting whole more confusing, though.
 cf. <87wozffavp.fsf@evledraar.gmail.com>


* dp/git-el-ls-files-excludes (2018-03-05) 1 commit
 . git.el: handle default excludesfile properly

 The "git.el" script (in contrib/) has been taught to use
 "--exclude-standard" option when driving "ls-files", instead of
 locating the exclude files on its own.  With this change, it now
 honors $XDG_CONFIG_HOME when it is set.

 The author of "git.el" recommends that users consider switching to
 "magit", though.

 Discarded, as contrib/emacs/ hierarchy is being emptied by the
 ab/nuke-emacs-contrib topic.
