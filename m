Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97741F404
	for <e@80x24.org>; Wed,  7 Feb 2018 23:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbeBGXNm (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 18:13:42 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42576 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBGXNk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 18:13:40 -0500
Received: by mail-wr0-f193.google.com with SMTP id 41so2831329wrc.9
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 15:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=Cvy9+AIRRj0V2Q3lfN90+EYT2TpLoUapXYTPHHIsDMk=;
        b=KeqQrgGyDQ3cJxSnxhtbgQwl21Oo5rY9RvARU85BcEX6yu6ldMGGfw7ClPiCaMvD0s
         JCaMrcFvQVrW9v0AP8aCR1jsqvdqAx7F+JMaCOI11/g7uml5gJxyKeRDr0771XG3jk5s
         nh5g9BcqQRDaivotdL58uGwSCdxptVmTycZdqiGCe6H2ugvLXPrQgL7Pdggul8n6kLqE
         vPcIoaBOOgH0v5YueJ5G8dR2hvfuTKUmbhc8wWTW0KWo5q02mr5pApQguSYpxar1A/0z
         v+KKYJEuaj17bkX+GgQxd+14dGubijSz8vxU+1cZkNvkGgGE54RQ+hYac0mF2UBhnn0E
         a4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=Cvy9+AIRRj0V2Q3lfN90+EYT2TpLoUapXYTPHHIsDMk=;
        b=iTW9mewEcU+itAEDnyieCv8Q0SqdAuBm01NXfL9kpniBXvZLRdzB4UYHZnTSm95UpR
         3ZM+37/LT0WRER71F4YPrIkmZuftKrHEwqw2s9HrCYZSmdSdv/SznjTOkTMD1e6QbJKe
         YU30UBEUFE5O0iRO5id2tGI4pqMpKd+IzT5X+q62Co2hRWTiL4NTulCXexJPKdWQtzTk
         XOjzrDBZjgWJziafl91HHfuBeJhsUOrz678fkJxSkn5AEjHARGoDfivmDN5+Mn6aTeLP
         lhEXAnEFYTSILULqF5MPYbaI3/03gT+GDbhyEGIJfQdUzUl456YnZDW6c6QKYwD2T/W6
         q7vg==
X-Gm-Message-State: APf1xPAOMtVw5b3+Y51WPMNQwpBZl3rdC7CAJF9AldA6gnPSXgS5Zd0s
        Zv/l4hR31BYTJeMOSloEaAQpuhDp5a2LSw==
X-Google-Smtp-Source: AH8x226p2mtJKu/aA9wA3JgGXkpXFn670a3APFm5+pSMPE+wW5qHgUtE2ZbrfVgbJA8wSLiFNJraLg==
X-Received: by 10.223.208.198 with SMTP id z6mr7008762wrh.194.1518045217968;
        Wed, 07 Feb 2018 15:13:37 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v75sm5635448wrb.12.2018.02.07.15.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 15:13:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2018, #01; Wed, 7)
X-master-at: 5be1f00a9a701532232f57958efab4be8c959a29
X-next-at: fa21fb2ec8acbede1bf0ed3cca9e96e2445d38d1
Date:   Wed, 07 Feb 2018 15:13:36 -0800
Message-ID: <xmqqtvus5r6n.fsf@gitster-ct.c.googlers.com>
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

I am migrating my build and integration environment to a different
machine; if you notice anything out of ordinary, please let me know
before I decomission and reimage my usual environment ;-)

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* bc/hash-algo (2018-02-02) 12 commits
 - bulk-checkin: abstract SHA-1 usage
 - csum-file: abstract uses of SHA-1
 - csum-file: rename sha1file to hashfile
 - read-cache: abstract away uses of SHA-1
 - pack-write: switch various SHA-1 values to abstract forms
 - pack-check: convert various uses of SHA-1 to abstract forms
 - fast-import: switch various uses of SHA-1 to the_hash_algo
 - sha1_file: switch uses of SHA-1 to the_hash_algo
 - builtin/unpack-objects: switch uses of SHA-1 to the_hash_algo
 - builtin/index-pack: improve hash function abstraction
 - hash: create union for hash context allocation
 - hash: move SHA-1 macros to hash.h

 More abstraction of hash function from the codepath.

 Will merge to 'next'.


* bp/untracked-cache-noflush (2018-02-05) 1 commit
 - dir.c: don't flag the index as dirty for changes to the untracked cache

 Writing out the index file when the only thing that changed in it
 is the untracked cache information is often wasteful, and this has
 been optimized out.

 Waiting for the discussion to finish.
 cf. <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>


* cc/perf-aggregate (2018-02-02) 3 commits
 - perf/aggregate: sort JSON fields in output
 - perf/aggregate: add --reponame option
 - perf/aggregate: add --subsection option

 Will merge to 'next'.


* gs/rebase-allow-empty-message (2018-02-07) 1 commit
 - rebase: add --allow-empty-message option

 "git rebase" learned to take "--allow-empty-message" option.

 Will merge to 'next'.


* jc/blame-missing-path (2018-02-07) 1 commit
 - blame: tighten command line parser

 "git blame HEAD COPYING" in a bare repository failed to run, while
 "git blame HEAD -- COPYING" run just fine.

 Will merge to 'next'.


* jt/binsearch-with-fanout (2018-02-02) 2 commits
 - packfile: refactor hash search with fanout table
 - packfile: remove GIT_DEBUG_LOOKUP log statements

 Refactor the code to binary search starting from a fan-out table
 (which is how the packfile is indexed with object names) into a
 reusable helper.

 Will merge to 'next'.


* lw/daemon-log-destination (2018-02-05) 1 commit
 - daemon: add --log-destination=(stderr|syslog|none)

 The log from "git daemon" can be redirected with a new option; one
 relevant use case is to send the log to standard error (instead of
 syslog) when running it from inetd.

 Will merge to 'next'.


* nd/diff-stat-with-summary (2018-02-02) 2 commits
 - diff: add --stat-with-summary
 - diff.c: refactor pprint_rename() to use strbuf

 Waiting for the discussion to finish.


* nd/parseopt-completion (2018-02-07) 42 commits
 - SQUASH???
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


* nd/trace-index-ops (2018-02-02) 1 commit
 - trace: measure where the time is spent in the index-heavy operations

 Will merge to 'next'.


* pc/submodule-helper-foreach (2018-02-02) 5 commits
 - submodule: port submodule subcommand 'foreach' from shell to C
 - submodule foreach: document variable '$displaypath'
 - submodule foreach: clarify the '$toplevel' variable documentation
 - submodule foreach: document '$sm_path' instead of '$path'
 - submodule foreach: correct '$path' in nested submodules from a subdirectory

 Waiting for the discussion to finish.
 cf. <20180206150044.1bffbb573c088d38c8e44bf5@google.com>


* rs/cocci-strbuf-addf-to-addstr (2018-02-02) 1 commit
 - cocci: simplify check for trivial format strings

 Will merge to 'next'.


* tg/reset-hard-show-head-with-pretty (2018-02-02) 1 commit
 - reset --hard: make use of the pretty machinery

 The way "git reset --hard" reports the commit the updated HEAD
 points at is made consistent with the way how the commit title is
 generated by the other parts of the system.  This matters when the
 title is spread across physically multiple lines.

 Will merge to 'next'.


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
 - tag: add --edit option


* sm/mv-dry-run-update (2018-02-07) 2 commits
 - mv: remove unneeded 'if (!show_only)'
 - t7001: add test case for --dry-run

--------------------------------------------------
[Stalled]

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

--------------------------------------------------
[Cooking]

* ab/fetch-prune (2018-01-24) 11 commits
 - fetch: add a --fetch-prune option and fetch.pruneTags config
 - fetch tests: add scaffolding for the new fetch.pruneTags
 - git-fetch & config doc: link to the new PRUNING section
 - git remote doc: correct dangerous lies about what prune does
 - git fetch doc: add a new section to explain the ins & outs of pruning
 - fetch tests: test --prune and refspec interaction
 - fetch tests: add a tag to be deleted to the pruning tests
 - fetch tests: re-arrange arguments for future readability
 - fetch tests: refactor in preparation for testing tag pruning
 - fetch: stop accessing "remote" variable indirectly
 - fetch: don't redundantly NULL something calloc() gave us

 Clarify how configured fetch refspecs interact with the "--prune"
 option of "git fetch", and also add a handy short-hand for getting
 rid of stale tags that are locally held.

 Expecting a reroll.
 cf. <87h8quytmq.fsf@evledraar.gmail.com>


* gs/retire-mru (2018-01-24) 1 commit
  (merged to 'next' on 2018-02-07 at 4b2e893911)
 + mru: Replace mru.[ch] with list.h implementation
 (this branch uses ot/mru-on-list.)

 Retire mru API as it does not give enough abstraction over
 underlying list API to be worth it.

 Will merge to 'master'.


* ot/mru-on-list (2017-10-01) 1 commit
  (merged to 'next' on 2018-02-07 at ee1ee4ac79)
 + mru: use double-linked list from list.h
 (this branch is used by gs/retire-mru.)

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 Will merge to 'master'.


* jc/mailinfo-cleanup-fix (2018-01-24) 1 commit
  (merged to 'next' on 2018-02-07 at 65d41f993b)
 + mailinfo: avoid segfault when can't open files

 Corner case bugfix.

 Will merge to 'master'.


* po/clang-format-functype-weight (2018-01-24) 1 commit
  (merged to 'next' on 2018-02-07 at 0724aaae38)
 + clang-format: adjust penalty for return type line break

 Prevent "clang-format" from breaking line after function return type.

 Will merge to 'master'.


* po/http-push-error-message (2018-01-24) 1 commit
  (merged to 'next' on 2018-02-07 at 3dccd32857)
 + http-push: improve error log

 Debugging aid.

 Will merge to 'master'.


* po/object-id (2018-01-30) 12 commits
 - sha1_file: rename hash_sha1_file_literally
 - sha1_file: convert write_loose_object to object_id
 - sha1_file: convert force_object_loose to object_id
 - sha1_file: convert write_sha1_file to object_id
 - notes: convert write_notes_tree to object_id
 - notes: convert combine_notes_* to object_id
 - commit: convert commit_tree* to object_id
 - match-trees: convert splice_tree to object_id
 - cache: clear whole hash buffer with oidclr
 - sha1_file: convert hash_sha1_file to object_id
 - dir: convert struct sha1_stat to use object_id
 - sha1_file: convert pretend_sha1_file to object_id

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'next'.


* sg/travis-linux32-sanity (2018-01-30) 5 commits
  (merged to 'next' on 2018-02-07 at 0349cf505c)
 + travis-ci: don't fail if user already exists on 32 bit Linux build job
 + travis-ci: don't run the test suite as root in the 32 bit Linux build
 + travis-ci: don't repeat the path of the cache directory
 + travis-ci: use 'set -e' in the 32 bit Linux build job
 + travis-ci: use 'set -x' for the commands under 'su' in the 32 bit Linux build

 Travis updates.

 Will merge to 'master'.


* jk/daemon-fixes (2018-01-25) 6 commits
  (merged to 'next' on 2018-02-07 at 0e4fe8f8cc)
 + daemon: fix length computation in newline stripping
 + t/lib-git-daemon: add network-protocol helpers
 + daemon: handle NULs in extended attribute string
 + daemon: fix off-by-one in logging extended attributes
 + t/lib-git-daemon: record daemon log
 + t5570: use ls-remote instead of clone for interp tests

 Assorted fixes to "git daemon".

 Will merge to 'master'.


* jt/long-running-process-doc (2018-01-25) 1 commit
  (merged to 'next' on 2018-02-07 at 8bbb42ad3c)
 + Docs: split out long-running subprocess handshake

 Doc updates.

 Will merge to 'master'.


* nd/format-patch-stat-width (2018-02-02) 2 commits
 - format-patch: reduce patch diffstat width to 72
 - format-patch: keep cover-letter diffstat wrapped in 72 columns

 "git format-patch" learned to give 72-cols to diffstat, which is
 consistent with other line length limits the subcommand uses for
 its output meant for e-mails.

 Will merge to 'next'.


* nd/list-merge-strategy (2018-01-26) 1 commit
  (merged to 'next' on 2018-02-07 at a75d04a675)
 + completion: fix completing merge strategies on non-C locales

 Completion of "git merge -s<strategy>" (in contrib/) did not work
 well in non-C locale.

 Will merge to 'master'.


* sb/pull-rebase-submodule (2018-01-25) 1 commit
 - builtin/pull: respect verbosity settings in submodules

 Will merge to 'next'.


* sg/test-i18ngrep (2018-01-26) 10 commits
 - t: make 'test_i18ngrep' more informative on failure
 - t: make sure that 'test_i18ngrep' got enough parameters
 - t: forbid piping into 'test_i18ngrep'
 - t: move 'test_i18ncmp' and 'test_i18ngrep' to 'test-lib-functions.sh'
 - t5536: let 'test_i18ngrep' read the file without redirection
 - t5510: consolidate 'grep' and 'test_i18ngrep' patterns
 - t4001: don't run 'git status' upstream of a pipe
 - t6022: don't run 'git merge' upstream of a pipe
 - t5812: add 'test_i18ngrep's missing filename parameter
 - t5541: add 'test_i18ngrep's missing filename parameter

 Test fixes.

 Expecting a reroll.
 cf. <CAM0VKjkf=51i1YPqdNm=pyPHaNNguXLu0T1iHDYv28jW92QTow@mail.gmail.com>


* bw/c-plus-plus (2018-01-30) 37 commits
 - replace: rename 'new' variables
 - trailer: rename 'template' variables
 - tempfile: rename 'template' variables
 - wrapper: rename 'template' variables
 - environment: rename 'namespace' variables
 - diff: rename 'template' variables
 - environment: rename 'template' variables
 - init-db: rename 'template' variables
 - unpack-trees: rename 'new' variables
 - trailer: rename 'new' variables
 - submodule: rename 'new' variables
 - split-index: rename 'new' variables
 - remote: rename 'new' variables
 - ref-filter: rename 'new' variables
 - read-cache: rename 'new' variables
 - line-log: rename 'new' variables
 - imap-send: rename 'new' variables
 - http: rename 'new' variables
 - entry: rename 'new' variables
 - diffcore-delta: rename 'new' variables
 - diff: rename 'new' variables
 - diff-lib: rename 'new' variable
 - commit: rename 'new' variables
 - combine-diff: rename 'new' variables
 - remote: rename 'new' variables
 - reflog: rename 'new' variables
 - pack-redundant: rename 'new' variables
 - help: rename 'new' variables
 - checkout: rename 'new' variables
 - apply: rename 'new' variables
 - apply: rename 'try' variables
 - diff: rename 'this' variables
 - rev-parse: rename 'this' variable
 - pack-objects: rename 'this' variables
 - blame: rename 'this' variables
 - object: rename function 'typename' to 'type_name'
 - object_info: change member name from 'typename' to 'type_name'

 I do not mind refraining from using these keywords in a foreign
 language in our codebase too much, but at the same time, renaming
 must be done a bit more thoughtfully.  When the original uses 'new'
 together with and in contrast to 'old', renaming 'new' must be done
 while preserving the pairing (which may involve renaming 'old' as
 well), for example.

 Backburnered, i.e. will drop if other topics start to conflict with
 it, but will accept rerolls.


* ew/svn-branch-segfault-fix (2018-01-30) 1 commit
  (merged to 'next' on 2018-02-07 at 1bf8d8f74f)
 + git-svn: control destruction order to avoid segfault

 Workaround for segfault with more recent versions of SVN.

 Will merge to 'master'.


* tz/doc-show-defaults-to-head (2018-01-30) 1 commit
  (merged to 'next' on 2018-02-07 at fa21fb2ec8)
 + doc: mention 'git show' defaults to HEAD

 Doc update.

 Will merge to 'master'.


* nd/ignore-glob-doc-update (2018-02-02) 1 commit
 - gitignore.txt: elaborate shell glob syntax

 Doc update.

 Will merge to 'next'.


* nd/rebase-show-current-patch (2018-01-31) 3 commits
 - rebase: introduce and use pseudo-ref ORIG_COMMIT
 - rebase: add --show-current-patch
 - am: add --show-current-patch

 The new "--show-current-patch" option gives an end-user facing way
 to get the diff being applied when "git rebase" (and "git am")
 stops with a conflict.

 Expecting a reroll.
 cf. <CACsJy8D8PaDR0r+6AKMgPo9UBcWYQC8goaVkVhxMCXCa1E9F9A@mail.gmail.com>


* jh/status-no-ahead-behind (2018-01-24) 4 commits
 - status: support --no-ahead-behind in long format
 - status: update short status to respect --no-ahead-behind
 - status: add --[no-]ahead-behind to status and commit for V2 format.
 - stat_tracking_info: return +1 when branches not equal

 "git status" can spend a lot of cycles to compute the relation
 between the current branch and its upstream, which can now be
 disabled with "--no-ahead-behind" option.

 At v5; is this ready for 'next'?


* nd/worktree-move (2018-01-24) 7 commits
 - worktree remove: allow it when $GIT_WORK_TREE is already gone
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20180124095357.19645-1-pclouds@gmail.com>


* nd/trace-with-env (2018-01-19) 7 commits
  (merged to 'next' on 2018-02-07 at 68399411d9)
 + run-command.c: print new cwd in trace_run_command()
 + run-command.c: print env vars in trace_run_command()
 + run-command.c: print program 'git' when tracing git_cmd mode
 + run-command.c: introduce trace_run_command()
 + trace.c: move strbuf_release() out of print_trace_line()
 + trace: avoid unnecessary quoting
 + sq_quote_argv: drop maxlen parameter

 The tracing machinery learned to report tweaking of environment
 variables as well.

 Will merge to 'master'.


* cl/t9001-cleanup (2018-01-12) 1 commit
  (merged to 'next' on 2018-02-07 at 9b194a9999)
 + t9001: use existing helper in send-email test

 Test clean-up.

 Will merge to 'master'.


* kg/packed-ref-cache-fix (2018-01-24) 6 commits
 - packed_ref_cache: don't use mmap() for small files
 - load_contents(): don't try to mmap an empty file
 - packed_ref_iterator_begin(): make optimization more general
 - find_reference_location(): make function safe for empty snapshots
 - create_snapshot(): use `xmemdupz()` rather than a strbuf
 - struct snapshot: store `start` rather than `header_len`

 Avoid mmapping small files while using packed refs (especially ones
 with zero size, which would cause later munmap() to fail).

 Will merge to 'next'.
 A change to a binsearch loop to work around picky complers was
 unnecessarily hard to reason about, but it should do.


* ks/submodule-doc-updates (2018-01-16) 2 commits
  (merged to 'next' on 2018-02-07 at aff2fa1650)
 + Doc/git-submodule: improve readability and grammar of a sentence
 + Doc/gitsubmodules: make some changes to improve readability and syntax

 Doc updates.

 Will merge to 'master'.


* nd/shared-index-fix (2018-01-24) 3 commits
  (merged to 'next' on 2018-02-07 at c5d6e68c91)
 + read-cache: don't write index twice if we can't write shared index
 + read-cache.c: move tempfile creation/cleanup out of write_shared_index
 + read-cache.c: change type of "temp" in write_shared_index()

 Code clean-up.

 Will merge to 'master'.


* rs/describe-unique-abbrev (2018-01-16) 1 commit
  (merged to 'next' on 2018-02-07 at b5383e2d05)
 + describe: use strbuf_add_unique_abbrev() for adding short hashes

 Code clean-up.

 Will merge to 'master'.


* tb/crlf-conv-flags (2018-01-16) 1 commit
  (merged to 'next' on 2018-02-07 at 1981be1b46)
 + convert_to_git(): safe_crlf/checksafe becomes int conv_flags
 (this branch is used by ls/checkout-encoding.)

 Code clean-up.

 Will merge to 'master'.


* nd/diff-flush-before-warning (2018-01-16) 1 commit
  (merged to 'next' on 2018-02-07 at 9c67f58ae0)
 + diff.c: flush stdout before printing rename warnings

 Avoid showing a warning message in the middle of a line of "git
 diff" output.

 Will merge to 'master'.


* rb/hashmap-h-compilation-fix (2018-01-16) 1 commit
  (merged to 'next' on 2018-02-07 at 780bc6d06b)
 + hashmap.h: remove unused variable

 Code clean-up.

 Will merge to 'master'.


* cc/sha1-file-name (2018-01-19) 2 commits
  (merged to 'next' on 2018-02-07 at a50b171a84)
 + sha1_file: improve sha1_file_name() perfs
 + sha1_file: remove static strbuf from sha1_file_name()

 Code clean-up.

 Will merge to 'master'.


* cl/send-email-reply-to (2018-01-17) 2 commits
 - send-email: support separate "Reply-To" address
 - send-email: rename variables for "In-reply-to" to $foo_in_reply_to

 "git send-email" learned "--reply-to=<address>" option.

 May want to get the log messages updated.
 cf. <CAN0heSqxmLoh33i65JPhyQbmPaAcJcwrTCO+ZD4eb+qh8Pf8+w@mail.gmail.com>


* ds/use-get-be64 (2018-01-19) 1 commit
  (merged to 'next' on 2018-02-07 at 6d6d5ba71d)
 + packfile: use get_be64() for large offsets

 Code clean-up.

 Will merge to 'master'.


* en/merge-recursive-fixes (2018-01-19) 3 commits
 - merge-recursive: add explanation for src_entry and dst_entry
 - merge-recursive: fix logic ordering issue
 - Tighten and correct a few testcases for merging and cherry-picking
 (this branch is used by en/rename-directory-detection.)

 Will merge to 'next'.


* jc/worktree-add-short-help (2018-01-17) 1 commit
 - worktree: say that "add" takes an arbitrary commit in short-help

 Error message fix.

 Will merge to 'next'.


* js/rebase-recreate-merge (2018-01-30) 10 commits
 - rebase -i: introduce --recreate-merges=[no-]rebase-cousins
 - pull: accept --rebase=recreate to recreate the branch topology
 - sequencer: handle autosquash and post-rewrite for merge commands
 - sequencer: make refs generated by the `label` command worktree-local
 - rebase: introduce the --recreate-merges option
 - rebase-helper --make-script: introduce a flag to recreate merges
 - sequencer: fast-forward merge commits, if possible
 - sequencer: introduce the `merge` command
 - sequencer: introduce new commands to reset the revision
 - git-rebase--interactive: clarify arguments

 "git rebase" learned "--recreate-merges" to transplant the whole
 topology of commit graph elsewhere.

 Not learning anything other than the parent info from an existing
 merge was found unsatisfactory by some.  It is something that can
 be fixed incrementally without breaking end-user experience, I
 would think, by doing the same cherry-pick 3-way merge.
 cf. <87k1vpqq85.fsf@javad.com>


* jt/http-redact-cookies (2018-01-19) 2 commits
  (merged to 'next' on 2018-02-07 at a8c3416a7d)
 + http: support omitting data from traces
 + http: support cookie redaction when tracing

 The http tracing code, often used to debug connection issues,
 learned to redact potentially sensitive information from its output
 so that it can be more safely sharable.

 Will merge to 'master'.


* mr/packed-ref-store-fix (2018-01-19) 1 commit
  (merged to 'next' on 2018-02-07 at 17d32e99da)
 + files_initial_transaction_commit(): only unlock if locked

 Crash fix for a corner case where an error codepath tried to unlock
 what it did not acquire lock on.

 Will merge to 'master'.


* rs/strbuf-cocci-workaround (2018-01-19) 1 commit
  (merged to 'next' on 2018-02-07 at 73a2c4c769)
 + cocci: use format keyword instead of a literal string

 Update Coccinelle rules to catch and optimize strbuf_addf(&buf, "%s", str)

 Will merge to 'master'.


* sg/cocci-move-array (2018-01-22) 1 commit
  (merged to 'next' on 2018-02-07 at 6ced765979)
 + Use MOVE_ARRAY

 Code clean-up.

 Will merge to 'master'.


* tg/split-index-fixes (2018-01-19) 3 commits
  (merged to 'next' on 2018-02-07 at 52d7a92ec5)
 + travis: run tests with GIT_TEST_SPLIT_INDEX
 + split-index: don't write cache tree with null oid entries
 + read-cache: fix reading the shared index for other repos

 The split-index mode had a few corner case bugs fixed.

 Will merge to 'master'.


* jt/fsck-code-cleanup (2018-01-23) 1 commit
 - fsck: fix leak when traversing trees

 Will merge to 'next'.


* ab/wildmatch-tests (2018-01-30) 10 commits
 - wildmatch test: mark test as EXPENSIVE_ON_WINDOWS
 - test-lib: add an EXPENSIVE_ON_WINDOWS prerequisite
 - wildmatch test: create & test files on disk in addition to in-memory
 - wildmatch test: perform all tests under all wildmatch() modes
 - wildmatch test: use test_must_fail, not ! for test-wildmatch
 - wildmatch test: remove dead fnmatch() test code
 - wildmatch test: use a paranoia pattern from nul_match()
 - wildmatch test: don't try to vertically align our output
 - wildmatch test: use more standard shell style
 - wildmatch test: indent with tabs, not spaces

 More tests for wildmatch functions.

 Will merge to 'next'.


* bw/protocol-v2 (2018-02-07) 35 commits
 - remote-curl: don't request v2 when pushing
 - remote-curl: implement stateless-connect command
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
 - upload-pack: support shallow requests
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
 - pkt-line: introduce struct packet_reader
 - pkt-line: introduce packet_read_with_status

 The beginning of the next-gen transfer protocol.


* ls/checkout-encoding (2018-01-30) 6 commits
 - convert: add tracing for 'working-tree-encoding' attribute
 - convert: add 'working-tree-encoding' attribute
 - utf8: add function to detect a missing UTF-16/32 BOM
 - utf8: add function to detect prohibited UTF-16/32 BOM
 - strbuf: add xstrdup_toupper()
 - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
 (this branch uses tb/crlf-conv-flags.)

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).


* pc/submodule-helper (2018-01-16) 2 commits
  (merged to 'next' on 2018-02-07 at 53b4524eca)
 + submodule: port submodule subcommand 'deinit' from shell to C
 + submodule: port submodule subcommand 'sync' from shell to C

 Rewrite two more "git submodule" subcommands in C.

 Will merge to 'master'.


* sb/blame-color (2018-01-08) 4 commits
 - builtin/blame: highlight recently changed lines
 - builtin/blame: add option to color metadata fields separately
 - builtin/blame: dim uninteresting metadata
 - color.h: document and modernize header

 Expecting a reroll.
 cf. https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/#t
 error messages are funny, can segfault, ...


* sg/travis-build-during-script-phase (2018-01-08) 1 commit
 - travis-ci: build Git during the 'script' phase

 Still under discussion.
 cf. <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com>


* nd/fix-untracked-cache-invalidation (2018-02-07) 5 commits
 - dir.c: ignore paths containing .git when invalidating untracked cache
 - dir.c: stop ignoring opendir() error in open_cached_dir()
 - dir.c: fix missing dir invalidation in untracked code
 - dir.c: avoid stat() in valid_cached_dir()
 - status: add a failing test showing a core.untrackedCache bug

 Some bugs around "untracked cache" feature have been fixed.

 Will merge to 'next'.


* np/send-email-header-parsing (2017-12-15) 1 commit
 - send-email: extract email-parsing code into a subroutine

 Code refactoring.

 Undecided but inclined to drop.  A "refactor" without the code that
 benefit from the refactoring is hard to tell from code churn whose
 only effect is potential to introduce bugs.


* ab/sha1dc-build (2017-12-08) 3 commits
 - sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
 - Makefile: under "make dist", include the sha1collisiondetection submodule
 - Makefile: don't error out under DC_SHA1_EXTERNAL if DC_SHA1_SUBMODULE=auto

 Push the submodule version of collision-detecting SHA-1 hash
 implementation a bit harder on builders.

 Will merge to 'next'.


* ab/simplify-perl-makefile (2018-01-03) 3 commits
  (merged to 'next' on 2018-01-23 at 1506e0651a)
 + perl: treat PERLLIB_EXTRA as an extra path again
 + perl: avoid *.pmc and fix Error.pm further
 + Makefile: replace perl/Makefile.PL with simple make rules

 Originally merged to 'next' on 2018-01-03

 The build procedure for perl/ part has been greatly simplified by
 weaning ourselves off of MakeMaker.

 Will merge to 'master'.


* en/rename-directory-detection (2018-01-31) 31 commits
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


* pw/sequencer-in-process-commit (2018-01-24) 14 commits
  (merged to 'next' on 2018-02-07 at ab5961edd9)
 + sequencer: run 'prepare-commit-msg' hook
 + t7505: add tests for cherry-pick and rebase -i/-p
 + t7505: style fixes
 + sequencer: assign only free()able strings to gpg_sign
 + sequencer: improve config handling
 + t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 + sequencer: try to commit without forking 'git commit'
 + sequencer: load commit related config
 + sequencer: simplify adding Signed-off-by: trailer
 + commit: move print_commit_summary() to libgit
 + commit: move post-rewrite code to libgit
 + Add a function to update HEAD after creating a commit
 + commit: move empty message checks to libgit
 + t3404: check intermediate squash messages

 The sequencer infrastructure is shared across "git cherry-pick",
 "git rebase -i", etc., and has always spawned "git commit" when it
 needs to create a commit.  It has been taught to do so internally,
 when able, by reusing the codepath "git commit" itself uses, which
 gives performance boost for a few tens of percents in some sample
 scenarios.

 Will merge to 'master'.


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

 Will merge to 'master'.


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

 Will merge to 'master'.
