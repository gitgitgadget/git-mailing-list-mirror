Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC371F453
	for <e@80x24.org>; Fri, 18 Jan 2019 23:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfARXUi (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 18:20:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35480 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfARXUi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 18:20:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so17045743wrb.2
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=6NC449zcoPr6vWvhc02rYNizMsldfnaYOGl87rzaoOc=;
        b=ZBFBHniF+VFQpcujRwSd+jJ5okt5ISE/zrb/7ZwS0STn0K+73M3s8LX5LGk8O04RNa
         H4AnYLOz7IcZjsLVauaZDrXt4gwQwEo/XrWRpa21v8a7ELcmIwzkNjQzysqKDqX6HvkY
         diC/Mk/fXlWLek7CGD4pvixaQGSJI5zjkcTp+sbe2rillbsa9w//XKZTPMcaFFRoQDpw
         4yPIhwW5/2rKLmzkH20rgqjWNLJCtfyMWGUvHd/U1LeHQzy6aSgl+TiXA9WgiirAnXSH
         5dleqivPZRimbgy+zuJH6lmJWAVwpog5OO+qs1rRinseXz/nHg6zBF7GoD/Dx0g6c6Ck
         vy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=6NC449zcoPr6vWvhc02rYNizMsldfnaYOGl87rzaoOc=;
        b=EWINBtkYRgh0xKgtO+t45WXyaXE86GucfRzZOuHGUfnDg0ehj3zLQJVQC8q+kIfsLV
         ZiCSwo3TdHxo5kVXKxa8b/sNjF2FRPMEUq+2Vta9ll4x4Q4IB45PoPTVm19tw1VtGH2A
         ysnFLpCL1bM2s6pJpM2/5boMElKEOOKDslN5uD2KSfHHiQ/ZftrQaxkdYXUYmZmGN251
         xmxPYCZFyFDIAzZnc9WpsHx5Yeo16SbQ9h1UqfDhu6dkD0K419YwFrhW2GL9TD/Spt5m
         8vuKLZNAco/l+GxzVlu9hLSDXhtZp5ILLEA8HT2aTRk1V1KXLIf0T/QGt8A01GsKKCbZ
         Vfrg==
X-Gm-Message-State: AJcUukeEECLwXBMK0oKHFfAcnEkWtsJqxmAizgAjmWSIhKKSx6rXz1XI
        CdfW43XftYPin3wWG/QfQ5WaRlme
X-Google-Smtp-Source: ALg8bN6dGpU65I2O30mf3IaZDCxN9anEgp4viEcrGgL06itNNSL/xCIfC2hOYw5vl7fooSoAgsbRjA==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr18265129wro.29.1547853633012;
        Fri, 18 Jan 2019 15:20:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h2sm96044201wrv.87.2019.01.18.15.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 15:20:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2019, #03; Fri, 18)
X-master-at: 16a465bc018d09e9d7bbbdc5f40a7fb99c21f8ef
X-next-at: aa96b0ce6b0fa4fa4cc6870f1a3aff3878967bfa
Date:   Fri, 18 Jan 2019 15:20:31 -0800
Message-ID: <xmqqfttpimdc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

A handful of topics graduated to 'master' as the third batch after
spending about a week or so in 'next', and another group of topics
are now in 'next' for their turn.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* cy/completion-typofix (2019-01-03) 1 commit
  (merged to 'next' on 2019-01-08 at 6c6f01a07d)
 + completion: fix typo in git-completion.bash

 Typofix.


* cy/zsh-completion-SP-in-path (2019-01-03) 2 commits
  (merged to 'next' on 2019-01-08 at fee27de30b)
 + completion: treat results of git ls-tree as file paths
 + zsh: complete unquoted paths with spaces correctly

 With zsh, "git cmd path<TAB>" was completed to "git cmd path name"
 when the completed path has a special character like SP in it,
 without any attempt to keep "path name" a single filename.  This
 has been fixed to complete it to "git cmd path\ name" just like
 Bash completion does.


* ds/commit-graph-assert-missing-parents (2019-01-02) 1 commit
  (merged to 'next' on 2019-01-08 at d141f063e0)
 + commit-graph: writing missing parents is a BUG

 Tightening error checking in commit-graph writer.


* ds/gc-doc-typofix (2019-01-08) 1 commit
  (merged to 'next' on 2019-01-08 at f21ffc83e0)
 + git-gc.txt: fix typo about gc.writeCommitGraph

 Typofix.


* ed/simplify-setup-git-dir (2019-01-03) 1 commit
  (merged to 'next' on 2019-01-08 at 8722c7c2ef)
 + Simplify handling of setup_git_directory_gently() failure cases.

 Code simplification.


* en/show-ref-doc-fix (2019-01-10) 1 commit
  (merged to 'next' on 2019-01-14 at f875bfb9a4)
 + git-show-ref.txt: fix order of flags

 Doc update.


* es/doc-worktree-guessremote-config (2018-12-28) 1 commit
  (merged to 'next' on 2019-01-08 at f1dc5e39a6)
 + doc/config: do a better job of introducing 'worktree.guessRemote'

 Doc clarification.


* ew/ban-strncat (2019-01-02) 1 commit
  (merged to 'next' on 2019-01-08 at 3bba2ae2bb)
 + banned.h: mark strncat() as banned

 The "strncat()" function is now among the banned functions.


* jk/dev-build-format-security (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at 3761ab7026)
 + config.mak.dev: add -Wall, primarily for -Wformat, to help autoconf users

 Earlier we added "-Wformat-security" to developer builds, assuming
 that "-Wall" (which includes "-Wformat" which in turn is required
 to use "-Wformat-security") is always in effect.  This is not true
 when config.mak.autogen is in use, unfortunately.  This has been
 fixed by unconditionally adding "-Wall" to developer builds.


* jn/stripspace-wo-repository (2018-12-26) 1 commit
  (merged to 'next' on 2019-01-08 at 81815821c9)
 + stripspace: allow -s/-c outside git repository

 "git stripspace" should be usable outside a git repository, but
 under the "-s" or "-c" mode, it didn't.


* js/gc-repack-close-before-remove (2019-01-11) 1 commit
  (merged to 'next' on 2019-01-14 at 9daedfee40)
 + gc/repack: release packs when needed

 "git gc" and "git repack" did not close the open packfiles that
 they found unneeded before removing them, which didn't work on a
 platform incapable of removing an open file.  This has been
 corrected.


* la/quiltimport-keep-non-patch (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at 37cb490792)
 + git-quiltimport: add --keep-non-patch option

 "git quiltimport" learned "--keep-non-patch" option.


* ma/asciidoctor (2018-12-26) 3 commits
  (merged to 'next' on 2019-01-08 at 3cfd4ad6cb)
 + git-status.txt: render tables correctly under Asciidoctor
 + Documentation: do not nest open blocks
 + git-column.txt: fix section header

 Some of the documentation pages formatted incorrectly with
 Asciidoctor, which have been fixed.


* mm/multimail-1.5 (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at 8c872af48e)
 + git-multimail: update to release 1.5.0

 Update "git multimail" from the upstream.


* nd/style-opening-brace (2018-12-10) 1 commit
  (merged to 'next' on 2019-01-08 at 80de026e14)
 + style: the opening '{' of a function is in a separate line

 Code clean-up.


* nd/worktree-remove-with-uninitialized-submodules (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at e19cfe8741)
 + worktree: allow to (re)move worktrees with uninitialized submodules

 "git worktree remove" and "git worktree move" refused to work when
 there is a submodule involved.  This has been loosened to ignore
 uninitialized submodules.


* ot/ref-filter-object-info (2019-01-10) 7 commits
  (merged to 'next' on 2019-01-10 at 9e740568ce)
 + ref-filter: give uintmax_t to format with %PRIuMAX
  (merged to 'next' on 2019-01-08 at 0a4d4ed36a)
 + ref-filter: add docs for new options
 + ref-filter: add tests for deltabase
 + ref-filter: add deltabase option
 + ref-filter: add tests for objectsize:disk
 + ref-filter: add check for negative file size
 + ref-filter: add objectsize:disk option

 The "--format=<placeholder>" option of for-each-ref, branch and tag
 learned to show a few more traits of objects that can be learned by
 the object_info API.


* po/git-p4-wo-login (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at a7cc58d6b9)
 + git-p4: fix problem when p4 login is not necessary

 "git p4" update.


* rb/hpe (2019-01-03) 5 commits
  (merged to 'next' on 2019-01-08 at 52d6995399)
 + compat/regex/regcomp.c: define intptr_t and uintptr_t on NonStop
 + git-compat-util.h: add FLOSS headers for HPE NonStop
 + config.mak.uname: support for modern HPE NonStop config.
 + transport-helper: drop read/write errno checks
 + transport-helper: use xread instead of read

 Portability updates for the HPE NonStop platform.


* rs/loose-object-cache-perffix (2019-01-08) 4 commits
  (merged to 'next' on 2019-01-08 at 36e355e099)
 + object-store: retire odb_load_loose_cache()
 + object-store: use one oid_array per subdirectory for loose cache
 + object-store: factor out odb_clear_loose_cache()
 + object-store: factor out odb_loose_cache()
 (this branch is used by jk/loose-object-cache-oid.)

 The loose object cache used to optimize existence look-up has been
 updated.


* rs/sha1-file-close-mapped-file-on-error (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at 5841cbc153)
 + sha1-file: close fd of empty file in map_sha1_file_1()

 Code clean-up.


* sb/submodule-fetchjobs-default-to-one (2018-12-14) 1 commit
  (merged to 'next' on 2019-01-08 at 97a522ef5e)
 + submodule update: run at most one fetch job unless otherwise set

 "git submodule update" ought to use a single job unless asked, but
 by mistake used multiple jobs, which has been fixed.


* sb/submodule-unset-core-worktree-when-worktree-is-lost (2018-12-26) 4 commits
  (merged to 'next' on 2019-01-08 at 38f3175a2b)
 + submodule deinit: unset core.worktree
 + submodule--helper: fix BUG message in ensure_core_worktree
 + submodule: unset core.worktree if no working tree is present
 + submodule update: add regression test with old style setups

 The core.worktree setting in a submodule repository should not be
 pointing at a directory when the submodule loses its working tree
 (e.g. getting deinit'ed), but the code did not properly maintain
 this invariant.


* sg/stress-test (2019-01-07) 8 commits
  (merged to 'next' on 2019-01-08 at 2a65cea5f9)
 + test-lib: add the '--stress' option to run a test repeatedly under load
 + test-lib-functions: introduce the 'test_set_port' helper function
 + test-lib: set $TRASH_DIRECTORY earlier
 + test-lib: consolidate naming of test-results paths
 + test-lib: parse command line options earlier
 + test-lib: parse options in a for loop to keep $@ intact
 + test-lib: extract Bash version check for '-x' tracing
 + test-lib: translate SIGTERM and SIGHUP to an exit
 (this branch uses sg/test-bash-version-fix.)

 Flaky tests can now be repeatedly run under load with the
 "--stress" option.


* sg/test-bash-version-fix (2019-01-03) 2 commits
  (merged to 'next' on 2019-01-08 at f83a0628a0)
 + Merge branch 'sg/test-bash-version-fix'
 + test-lib: check Bash version for '-x' without using shell arrays
 (this branch is used by sg/stress-test.)

 The test suite tried to see if it is run under bash, but the check
 itself failed under some other implementations of shell (notably
 under NetBSD).  This has been corrected.


* so/cherry-pick-always-allow-m1 (2019-01-07) 4 commits
  (merged to 'next' on 2019-01-08 at 2b790fec25)
 + t3506: validate '-m 1 -ff' is now accepted for non-merge commits
 + t3502: validate '-m 1' argument is now accepted for non-merge commits
 + cherry-pick: do not error on non-merge commits when '-m 1' is specified
 + t3510: stop using '-m 1' to force failure mid-sequence of cherry-picks

 "git cherry-pick -m1" was forbidden when picking a non-merge
 commit, even though there _is_ parent number 1 for such a commit.
 This was done to avoid mistakes back when "cherry-pick" was about
 picking a single commit, but is no longer useful with "cherry-pick"
 that can pick a range of commits.  Now the "-m$num" option is
 allowed when picking any commit, as long as $num names an existing
 parent of the commit.

 Technically this is a backward incompatible change; hopefully
 nobody is relying on the error-checking behaviour.


* tg/t5570-drop-racy-test (2019-01-07) 2 commits
  (merged to 'next' on 2019-01-08 at 9fc753bbdc)
 + Revert "t/lib-git-daemon: record daemon log"
 + t5570: drop racy test

 An inherently racy test that caused intermittent failures has been
 removed.

--------------------------------------------------
[New Topics]

* ab/commit-graph-write-optim (2019-01-17) 1 commit
 - commit-graph write: use pack order when finding commits
 (this branch uses ab/commit-graph-write-progress.)

 The codepath to write out commit-graph has been optimized by
 following the usual pattern of visiting objects in in-pack order.

 This is taken hostage of the other topic; it may be slightly better
 if the dependency were the other way around, to allow this to
 graduate faster without waiting for the other.

 Needs sign-off.


* ab/commit-graph-write-progress (2019-01-17) 9 commits
 - commit-graph write: emit a percentage for all progress
 - commit-graph write: add itermediate progress
 - commit-graph write: remove empty line for readability
 - commit-graph write: add more descriptive progress output
 - commit-graph write: show progress for object search
 - commit-graph write: more descriptive "writing out" output
 - commit-graph write: add "Writing out" progress output
 - commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
 - commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
 (this branch is used by ab/commit-graph-write-optim.)

 The codepath to show progress meter while writing out commit-graph
 file has been improved.

 Proposed updates for the bottom two have been raised.
 cf. <20190118170549.30403-1-szeder.dev@gmail.com>


* cc/test-ref-store-typofix (2019-01-17) 1 commit
 - helper/test-ref-store: fix "new-sha1" vs "old-sha1" typo

 An obvious typo in an assersion error message has been fixed.

 Will merge to 'next'.


* jk/add-ignore-errors-bit-assignment-fix (2019-01-17) 1 commit
 - add: use separate ADD_CACHE_RENORMALIZE flag

 "git add --ignore-errors" did not work as advertised and instead
 worked as an unintended synonym for "git add --renormalize", which
 has been fixed.

 Will merge to 'next'.


* js/mingw-unc-path-w-backslashes (2019-01-18) 2 commits
 - mingw: special-case arguments to `sh`
 - mingw (t5580): document bug when cloning from backslashed UNC paths

 In Git for Windows, "git clone \\server\share\path" etc. that uses
 UNC paths from command line had bad interaction with its shell
 emulation.

 Will merge to 'next'.


* js/t6042-timing-fix (2019-01-17) 1 commit
 - t6042: work around speed optimization on Windows

 Test update.

 Will merge to 'next'.


* jt/namespaced-ls-refs-fix (2019-01-18) 1 commit
 - ls-refs: filter refs using namespace-stripped name

 Fix namespace support in protocol v2.

 Will merge to 'next'.


* bp/checkout-new-branch-optim (2019-01-18) 2 commits
 - checkout: fix regression in checkout -b on intitial checkout
 - checkout: add test to demonstrate regression with checkout -b on initial commit

 "git checkout -b <new> [HEAD]" to create a new branch from the
 current commit and check it out ought to be a no-op in the index
 and the working tree in normal cases, but there are corner cases
 that does require updates to the index and the working tree.
 Running it immediately after "git clone --no-checkout" is one of
 these cases that an earlier optimization kicked in incorrectly,
 which has been fixed.

 Seems to break an existing test...


* br/blame-ignore (2019-01-18) 3 commits
 - blame: add a config option to mark ignored lines
 - blame: add the ability to ignore commits and their changes
 - Move init_skiplist() outside of fsck

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.


* js/abspath-part-inside-repo (2019-01-18) 1 commit
 - abspath_part_inside_repo: respect core.ignoreCase

 On a case-insensntive filesystem, we failed to compare the part of
 the path that is above the worktree directory in an absolute
 pathname, which has been corrected.

 Will merge to 'next'.


* nd/diff-parseopt (2019-01-18) 77 commits
 - SQUASH???
 - am: avoid diff_opt_parse()
 - diff --no-index: use parse_options() instead of diff_opt_parse()
 - range-diff: use parse_options() instead of diff_opt_parse()
 - diff.c: allow --no-color-moved-ws
 - diff.c: convert --color-moved-ws
 - diff.c: convert --color-moved
 - diff.c: convert --inter-hunk-context
 - diff.c: convert --no-prefix
 - diff.c: convert --line-prefix
 - diff.c: convert --[src|dst]-prefix
 - diff.c: convert --[no-]abbrev
 - diff.c: convert --diff-filter
 - diff.c: convert --find-object
 - diff.c: convert -O
 - diff.c: convert --pickaxe-all|--pickaxe-regex
 - diff.c: convert -S|-G
 - diff.c: convert -l
 - diff.c: convert -z
 - diff.c: convert --ita-[in]visible-in-index
 - diff.c: convert --ws-error-highlight
 - diff.c: convert --submodule
 - diff.c: convert --ignore-submodules
 - diff.c: convert --textconv
 - diff.c: convert --ext-diff
 - diff.c: convert --quiet
 - diff.c: convert --exit-code
 - diff.c: convert --color-words
 - diff.c: convert --word-diff-regex
 - diff.c: convert --word-diff
 - diff.c: convert --[no-]color
 - diff.c: convert --[no-]follow
 - diff.c: convert -R
 - diff.c: convert -a|--text
 - diff.c: convert --full-index
 - diff.c: convert --binary
 - diff.c: convert --anchored
 - diff.c: convert --diff-algorithm
 - diff.c: convert --histogram
 - diff.c: convert --patience
 - diff.c: convert --[no-]indent-heuristic
 - diff.c: convert --ignore-some-changes
 - diff.c: convert --[no-]minimal
 - diff.c: convert --relative
 - diff.c: convert --no-renames|--[no--rename-empty
 - diff.c: convert --find-copies-harder
 - diff.c: convert -C|--find-copies
 - diff.c: convert -D|--irreversible-delete
 - diff.c: convert -M|--find-renames
 - diff.c: convert -B|--break-rewrites
 - diff.c: convert --output-*
 - diff.c: convert --[no-]compact-summary
 - diff.c: convert --stat*
 - diff.c: convert -s|--no-patch
 - diff.c: convert --name-status
 - diff.c: convert --name-only
 - diff.c: convert --patch-with-stat
 - diff.c: convert --summary
 - diff.c: convert --check
 - diff.c: convert --dirstat and friends
 - diff.c: convert --numstat and --shortstat
 - diff.c: convert --patch-with-raw
 - diff.c: convert --raw
 - diff.c: convert -W|--[no-]function-context
 - diff.c: convert -U|--unified
 - diff.c: convert -u|-p|--patch
 - diff.c: prepare to use parse_options() for parsing
 - diff.h: avoid bit fields in struct diff_flags
 - diff.h: keep forward struct declarations sorted
 - parse-options: allow ll_callback with OPTION_CALLBACK
 - parse-options: avoid magic return codes
 - parse-options: stop abusing 'callback' for lowlevel callbacks
 - parse-options: add OPT_BITOP()
 - parse-options: disable option abbreviation with PARSE_OPT_KEEP_UNKNOWN
 - parse-options: allow keep-unknown + stop-at-non-opt combination
 - parse-options: add one-shot mode
 - parse-options.h: remove extern on function prototypes

 The diff machinery, one of the oldest parts of the system, which
 long predates the parse-options API, uses fairly long and complex
 handcrafted option parser.  This has been rewritten to use the
 parse-options API.

--------------------------------------------------
[Cooking]

* sc/pack-redundant (2019-01-14) 5 commits
 - pack-redundant: consistent sort method
 - pack-redundant: rename pack_list.all_objects
 - pack-redundant: remove unused functions
 - pack-redundant: new algorithm to find min packs
 - t5323: test cases for git-pack-redundant

 Update the implementation of pack-redundant for performance in a
 repository with many packfiles.

 Comments?


* pw/diff-color-moved-ws-fix (2019-01-10) 9 commits
  (merged to 'next' on 2019-01-18 at e19713c82f)
 + diff --color-moved-ws: handle blank lines
 + diff --color-moved-ws: modify allow-indentation-change
 + diff --color-moved-ws: optimize allow-indentation-change
 + diff --color-moved=zebra: be stricter with color alternation
 + diff --color-moved-ws: fix false positives
 + diff --color-moved-ws: demonstrate false positives
 + diff: allow --no-color-moved-ws
 + Use "whitespace" consistently
 + diff: document --no-color-moved

 "git diff --color-moved-ws" updates.

 Will merge to 'master'.


* it/log-format-source (2019-01-11) 1 commit
  (merged to 'next' on 2019-01-18 at d660044e93)
 + log: add %S option (like --source) to log --format

 Custom userformat "log --format" learned %S atom that stands for
 the tip the traversal reached the commit from, i.e. --source.

 Will merge to 'master'.


* js/filter-options-should-use-plain-int (2019-01-15) 1 commit
  (merged to 'next' on 2019-01-18 at 6714547e6d)
 + filter-options: expand scaled numbers
 (this branch uses md/list-objects-filter-by-depth and sb/more-repo-in-api; is tangled with jt/get-reference-with-commit-graph.)

 Update the protocol message specification to allow only the limited
 use of scaled quantities.  This is ensure potential compatibility
 issues will not go out of hand.

 Will merge to 'master'.


* jt/upload-pack-deepen-relative-proto-v2 (2019-01-10) 2 commits
  (merged to 'next' on 2019-01-18 at 1483ad21db)
 + upload-pack: teach deepen-relative in protocol v2
 + fetch-pack: do not take shallow lock unnecessarily

 "git fetch --deepen=<more>" has been corrected to work over v2
 protocol.

 Will merge to 'master'.


* nd/config-move-to (2019-01-14) 7 commits
 - config.h: fix hdr-check warnings
 - config: add --move-to
 - config: factor out set_config_source_file()
 - config: use OPT_FILENAME()
 - config.c: add repo_config_set_worktree_gently()
 - worktree.c: add get_worktree_config()
 - config.c: avoid git_path() in do_git_config_sequence()

 Needs review.


* sg/travis-specific-cc (2019-01-17) 4 commits
 - travis-ci: build with the right compiler
 - travis-ci: switch to Xcode 10.1 macOS image
 - travis-ci: don't be '--quiet' when running the tests
 - .gitignore: ignore external debug symbols from GCC on macOS

 The travis CI scripts have been corrected to build Git with the
 compiler(s) of our choice.

 Will merge to 'next'.


* sg/obstack-cast-function-type-fix (2019-01-17) 1 commit
 - compat/obstack: fix -Wcast-function-type warnings

 The compat/obstack code had casts that -Wcast-function-type
 compilation option found questionable.

 Will merge to 'next'.


* cc/fetch-error-message-fix (2019-01-14) 1 commit
  (merged to 'next' on 2019-01-14 at 81078f86c0)
 + fetch: fix extensions.partialclone name in error message

 Error message fix.

 Will merge to 'master'.


* cc/parial-clone-doc-typofix (2019-01-14) 1 commit
  (merged to 'next' on 2019-01-14 at 0395de767e)
 + partial-clone: add missing 'is' in doc

 Doc fix.

 Will merge to 'master'.


* jk/remote-insteadof-cleanup (2019-01-11) 1 commit
  (merged to 'next' on 2019-01-18 at 112c93eef3)
 + remote: check config validity before creating rewrite struct

 Code clean-up.

 Will merge to 'master'.


* jk/save-getenv-result (2019-01-11) 6 commits
  (merged to 'next' on 2019-01-18 at 429c77402a)
 + builtin_diff(): read $GIT_DIFF_OPTS closer to use
 + merge-recursive: copy $GITHEAD strings
 + init: make a copy of $GIT_DIR string
 + config: make a copy of $GIT_CONFIG string
 + commit: copy saved getenv() result
 + get_super_prefix(): copy getenv() result

 There were many places the code relied on the string returned from
 getenv() to be non-volatile, which is not true, that have been
 corrected.

 Will merge to 'master'.


* jt/fetch-v2-sideband (2019-01-17) 5 commits
 - tests: define GIT_TEST_SIDEBAND_ALL
 - {fetch,upload}-pack: sideband v2 fetch response
 - sideband: reverse its dependency on pkt-line
 - pkt-line: introduce struct packet_writer
 - Merge branch 'ms/packet-err-check' into jt/fetch-v2-sideband
 (this branch uses ms/packet-err-check.)

 "git fetch" and "git upload-pack" learned to send all exchange over
 the sideband channel while talking the v2 protocol.

 Will merge to 'next'.


* kg/external-diff-save-env (2019-01-11) 1 commit
  (merged to 'next' on 2019-01-14 at 8281bbd48b)
 + diff: ensure correct lifetime of external_diff_cmd

 The code to drive GIT_EXTERNAL_DIFF command relied on the string
 returned from getenv() to be non-volatile, which is not true, that
 has been corrected.

 Will merge to 'master'.


* ld/git-p4-shelve-update-fix (2019-01-18) 2 commits
 - git-p4: handle update of moved/copied files when updating a shelve
 - git-p4: add failing test for shelved CL update involving move/copy

 "git p4" failed to update a shelved change when there were moved
 files, which has been corrected.

 Will merge to 'next'.


* ma/clear-repository-format (2019-01-14) 3 commits
 - setup: add `clear_repository_format()`
 - setup: do not use invalid `repository_format`
 - setup: free old value before setting `work_tree`

 The setup code has been cleaned up to avoid leaks around the
 repository_format structure.

 cf. <20190115193112.GE4886@sigill.intra.peff.net>


* nd/the-index-final (2019-01-14) 11 commits
 - cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch
 - read-cache.c: remove the_* from index_has_changes()
 - merge-recursive.c: remove implicit dependency on the_repository
 - merge-recursive.c: remove implicit dependency on the_index
 - sha1-name.c: remove implicit dependency on the_index
 - read-cache.c: replace update_index_if_able with repo_&
 - read-cache.c: kill read_index()
 - checkout: avoid the_index when possible
 - repository.c: replace hold_locked_index() with repo_hold_locked_index()
 - notes-utils.c: remove the_repository references
 - grep: use grep_opt->repo instead of explict repo argument

 The assumption to work on the single "in-core index" instance has
 been reduced from the library-ish part of the codebase.

 This obviously has fallouts with a few topics in flight, but
 otherwise it seemed to be in good enough shape.


* bc/tree-walk-oid (2019-01-15) 5 commits
  (merged to 'next' on 2019-01-18 at 60c38b9e4a)
 + cache: make oidcpy always copy GIT_MAX_RAWSZ bytes
 + tree-walk: store object_id in a separate member
 + match-trees: use hashcpy to splice trees
 + match-trees: compute buffer offset correctly when splicing
 + tree-walk: copy object ID before use

 The code to walk tree objects has been taught that we may be
 working with object names that are not computed with SHA-1.

 Will merge to 'master'.


* js/add-e-clear-patch-before-stating (2019-01-15) 1 commit
  (merged to 'next' on 2019-01-18 at 9ea7fc4b49)
 + add --edit: truncate the patch file

 "git add -e" got confused when the change it wants to let the user
 edit is smaller than the previous change that was left over in a
 temporary file.

 Will merge to 'master'.


* jt/fetch-pack-v2 (2019-01-10) 1 commit
  (merged to 'next' on 2019-01-18 at 75ceb55ff8)
 + fetch-pack: support protocol version 2

 "git fetch-pack" now can talk the version 2 protocol.

 Will merge to 'master'.


* jp/author-committer-config (2019-01-02) 2 commits
 - DONTMERGE
 - Add author and committer configuration settings

 Four new configuration variables {author,committer}.{name,email}
 have been introduced to override user.{name,email} in more specific
 cases.

 Expecting a reroll.
 cf. <xmqq1s5uk6qh.fsf@gitster-ct.c.googlers.com>


* js/rebase-am (2019-01-18) 4 commits
 - built-in rebase: call `git am` directly
 - rebase: teach `reset_head()` to optionally skip the worktree
 - rebase: avoid double reflog entry when switching branches
 - rebase: move `reset_head()` into a better spot

 Instead of going through "git-rebase--am" scriptlet to use the "am"
 backend, the built-in version of "git rebase" learned to drive the
 "am" backend directly.

 Waiting for a review response.
 Looked almost ready.


* ms/packet-err-check (2019-01-02) 2 commits
 - pack-protocol.txt: accept error packets in any context
 - Use packet_reader instead of packet_read_line
 (this branch is used by jt/fetch-v2-sideband.)

 Error checking of data sent over the pack-protocol has been
 revamped so that error packets are always diagnosed properly.

 Will merge to 'next'.


* os/rebase-runs-post-checkout-hook (2019-01-02) 2 commits
  (merged to 'next' on 2019-01-18 at a03d536318)
 + rebase: run post-checkout hook on checkout
 + t5403: simplify by using a single repository

 "git rebase" internally runs "checkout" to switch between branches,
 and the command used to call the post-checkout hook, but the
 reimplementation stopped doing so, which is getting fixed.

 Will merge to 'master'.


* ms/http-no-more-failonerror (2019-01-10) 5 commits
  (merged to 'next' on 2019-01-18 at 8938d70b6d)
 + test: test GIT_CURL_VERBOSE=1 shows an error
 + remote-curl: unset CURLOPT_FAILONERROR
 + remote-curl: define struct for CURLOPT_WRITEFUNCTION
 + http: enable keep_error for HTTP requests
 + http: support file handles for HTTP_KEEP_ERROR

 Debugging help for http transport.

 Will merge to 'master'.


* tt/bisect-in-c (2019-01-02) 7 commits
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C

 More code in "git bisect" has been rewritten in C.

 Comments?


* ja/doc-build-l10n (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-18 at 5dbe5ad3d7)
 + Documentation/Makefile add optional targets for l10n

 Prepare Documentation/Makefile so that manpage localization can
 reuse it by overriding and tweaking the list of build products.

 Will merge to 'master'.


* jk/loose-object-cache-oid (2019-01-08) 11 commits
 . prefer "hash mismatch" to "sha1 mismatch"
 . sha1-file: avoid "sha1 file" for generic use in messages
 . sha1-file: prefer "loose object file" to "sha1 file" in messages
 . sha1-file: drop has_sha1_file()
 - convert has_sha1_file() callers to has_object_file()
 - sha1-file: convert pass-through functions to object_id
 - sha1-file: modernize loose header/stream functions
 - sha1-file: modernize loose object file functions
 - http: use struct object_id instead of bare sha1
 - update comment references to sha1_object_info()
 - sha1-file: fix outdated sha1 comment references

 Code clean-up.

 Later parts of the series crash heavily with sb/more-repo-in-api
 and are left out for now.  I am not sure if keeping that other
 topic is worth keeping to block the clean-up value of this topic
 which is probably more clear.


* lt/date-human (2019-01-18) 5 commits
 - Add `human` date format tests.
 - Add `human` format to test-tool
 - Add 'human' date format documentation
 - Remove the proposed use of auto as secondary way to specify human
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.

 The design around "auto" may need to be rethought.
 The tests need to be updated, too.
 cf. <20190104075034.GA26014@sigill.intra.peff.net>
 cf. <a5412274-028f-3662-e4f5-dbbcad4d9a40@iee.org>


* ds/midx-expire-repack (2019-01-10) 9 commits
 - multi-pack-index: test expire while adding packs
 - midx: implement midx_repack()
 - multi-pack-index: prepare 'repack' subcommand
 - multi-pack-index: implement 'expire' subcommand
 - midx: refactor permutation logic and pack sorting
 - midx: simplify computation of pack name lengths
 - multi-pack-index: prepare for 'expire' subcommand
 - Docs: rearrange subcommands for multi-pack-index
 - repack: refactor pack deletion for future use

 "git multi-pack-index expire/repack" are new subcommands that
 consult midx file and are used to drop unused pack files and
 coalesce small pack files that are still in use.

 Comments?


* ds/push-sparse-tree-walk (2019-01-17) 5 commits
 - pack-objects: create GIT_TEST_PACK_SPARSE
 - pack-objects: create pack.useSparse setting
 - revision: implement sparse algorithm
 - list-objects: consume sparse tree walk
 - revision: add mark_tree_uninteresting_sparse

 "git pack-objects" learned another algorithm to compute the set of
 objects to send, that trades the resulting packfile off to save
 traversal cost to favor small pushes.

 Will merge to 'next'.


* js/rebase-i-redo-exec (2018-12-11) 3 commits
  (merged to 'next' on 2019-01-18 at 71be3fedb7)
 + rebase: introduce a shortcut for --reschedule-failed-exec
 + rebase: add a config option to default to --reschedule-failed-exec
 + rebase: introduce --reschedule-failed-exec

 "git rebase -i" learned to re-execute a command given with 'exec'
 to run after it failed the last time.

 Will merge to 'master'.


* md/list-objects-filter-by-depth (2019-01-15) 4 commits
 + tree:<depth>: skip some trees even when collecting omits
 + list-objects-filter: teach tree:# how to handle >0
 + Merge branch 'nd/the-index' into md/list-objects-filter-by-depth
 + Merge branch 'sb/more-repo-in-api' into md/list-objects-filter-by-depth
 (this branch is used by js/filter-options-should-use-plain-int; uses sb/more-repo-in-api; is tangled with jt/get-reference-with-commit-graph.)

 The objects-filter machinery learned "tree:<depth>" to filter
 objects up to a given depth; earlier it only supported depth=0,
 i.e. usable to create a commit-only lazy clone.

 Will merge to 'next'.


* tg/checkout-no-overlay (2019-01-08) 8 commits
  (merged to 'next' on 2019-01-18 at 1e2a79ba5c)
 + checkout: introduce checkout.overlayMode config
 + checkout: introduce --{,no-}overlay option
 + checkout: factor out mark_cache_entry_for_checkout function
 + checkout: clarify comment
 + read-cache: add invalidate parameter to remove_marked_cache_entries
 + entry: support CE_WT_REMOVE flag in checkout_entry
 + entry: factor out unlink_entry function
 + move worktree tests to t24*

 "git checkout --no-overlay" can be used to trigger a new mode of
 checking out paths out of the tree-ish, that allows paths that
 match the pathspec that are in the current index and working tree
 and are not in the tree-ish.

 Will merge to 'master'.


* jk/proto-v2-hidden-refs-fix (2019-01-10) 1 commit
  (merged to 'next' on 2019-01-18 at 875dbbc71f)
 + upload-pack: support hidden refs with protocol v2

 The v2 upload-pack protocol implementation failed to honor
 hidden-ref configuration, which has been corrected.

 Will merge to 'master'.
 An earlier attempt reverted out of 'next'.


* js/commit-graph-chunk-table-fix (2019-01-15) 3 commits
 - Makefile: correct example fuzz build
 - commit-graph: fix buffer read-overflow
 - commit-graph, fuzz: add fuzzer for commit-graph

 The codepath to read from the commit-graph file attempted to read
 past the end of it when the file's table-of-contents was corrupt.

 Will merge to 'next'.


* jt/get-reference-with-commit-graph (2018-12-28) 1 commit
  (merged to 'next' on 2019-01-18 at bfc4eb9411)
 + revision: use commit graph in get_reference()
 (this branch uses sb/more-repo-in-api; is tangled with js/filter-options-should-use-plain-int and md/list-objects-filter-by-depth.)

 Micro-optimize the code that prepares commit objects to be walked
 by "git rev-list" when the commit-graph is available.

 Will merge to 'master'.


* dl/merge-cleanup-scissors-fix (2018-11-21) 2 commits
 - merge: add scissors line on merge conflict
 - t7600: clean up 'merge --squash c3 with c7' test

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Ready?


* aw/pretty-trailers (2018-12-09) 7 commits
 - pretty: add support for separator option in %(trailers)
 - strbuf: separate callback for strbuf_expand:ing literals
 - pretty: add support for "valueonly" option in %(trailers)
 - pretty: allow showing specific trailers
 - pretty: single return path in %(trailers) handling
 - pretty: allow %(trailers) options with explicit value
 - doc: group pretty-format.txt placeholders descriptions

 The %(trailers) formatter in "git log --format=..."  now allows to
 optionally pick trailers selectively by keyword, show only values,
 etc.

 How's the doneness of this one?


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* en/rebase-merge-on-sequencer (2019-01-07) 8 commits
 - rebase: implement --merge via the interactive machinery
 - rebase: define linearization ordering and enforce it
 - git-legacy-rebase: simplify unnecessary triply-nested if
 - git-rebase, sequencer: extend --quiet option for the interactive machinery
 - am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
 - t5407: add a test demonstrating how interactive handles --skip differently
 - rebase: fix incompatible options error message
 - rebase: make builtin and legacy script error messages the same

 "git rebase --merge" as been reimplemented by reusing the internal
 machinery used for "git rebase -i".

 On hold.
 cf. <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 I am personally not yet quite convinced if this is worth pursuing.


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.


* js/smart-http-detect-remote-error (2019-01-07) 3 commits
 - remote-curl: die on server-side errors
 - remote-curl: tighten "version 2" check for smart-http
 - remote-curl: refactor smart-http discovery

 Some errors from the other side coming over smart HTTP transport
 were not noticed, which has been corrected.

 Will merge to 'next'.


* nb/branch-show-other-worktrees-head (2019-01-15) 3 commits
 - branch: add an extra verbose output displaying worktree path for checked out branch
 - branch: mark and color a branch that is checked out in a linked worktree differently
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 The second one is of dubious value.  The third one requires extra
 "-v" to trigger extra information, but a new feature that improves
 human-readable Porcelain output, it probably shouldn't.  Needs
 sign-off.


* sb/more-repo-in-api (2018-12-28) 23 commits
 + t/helper/test-repository: celebrate independence from the_repository
 + path.h: make REPO_GIT_PATH_FUNC repository agnostic
 + commit: prepare free_commit_buffer and release_commit_memory for any repo
 + commit-graph: convert remaining functions to handle any repo
 + submodule: don't add submodule as odb for push
 + submodule: use submodule repos for object lookup
 + pretty: prepare format_commit_message to handle arbitrary repositories
 + commit: prepare logmsg_reencode to handle arbitrary repositories
 + commit: prepare repo_unuse_commit_buffer to handle any repo
 + commit: prepare get_commit_buffer to handle any repo
 + commit-reach: prepare in_merge_bases[_many] to handle any repo
 + commit-reach: prepare get_merge_bases to handle any repo
 + commit-reach.c: allow get_merge_bases_many_0 to handle any repo
 + commit-reach.c: allow remove_redundant to handle any repo
 + commit-reach.c: allow merge_bases_many to handle any repo
 + commit-reach.c: allow paint_down_to_common to handle any repo
 + commit: allow parse_commit* to handle any repo
 + object: parse_object to honor its repository argument
 + object-store: prepare has_{sha1, object}_file to handle any repo
 + object-store: prepare read_object_file to deal with any repo
 + object-store: allow read_object_file_extended to read from any repo
 + packfile: allow has_packed_and_bad to handle arbitrary repositories
 + sha1_file: allow read_object to read objects in arbitrary repositories
 (this branch is used by js/filter-options-should-use-plain-int, jt/get-reference-with-commit-graph and md/list-objects-filter-by-depth.)

 The in-core repository instances are passed through more codepaths.

 Will merge to 'next'.


* bc/sha-256 (2018-11-14) 12 commits
  (merged to 'next' on 2019-01-18 at 3f161d31bb)
 + hash: add an SHA-256 implementation using OpenSSL
 + sha256: add an SHA-256 implementation using libgcrypt
 + Add a base implementation of SHA-256 support
 + commit-graph: convert to using the_hash_algo
 + t/helper: add a test helper to compute hash speed
 + sha1-file: add a constant for hash block size
 + t: make the sha1 test-tool helper generic
 + t: add basic tests for our SHA-1 implementation
 + cache: make hashcmp and hasheq work with larger hashes
 + hex: introduce functions to print arbitrary hashes
 + sha1-file: provide functions to look up hash algorithms
 + sha1-file: rename algorithm to "sha1"

 Add sha-256 hash and plug it through the code to allow building Git
 with the "NewHash".

 Will merge to 'master'.


* js/vsts-ci (2018-10-16) 13 commits
 . travis: fix skipping tagged releases
 . README: add a build badge (status of the Azure Pipelines build)
 . tests: record more stderr with --write-junit-xml in case of failure
 . tests: include detailed trace logs with --write-junit-xml upon failure
 . git-p4: use `test_atexit` to kill the daemon
 . git-daemon: use `test_atexit` in the tests
 . tests: introduce `test_atexit`
 . ci: add a build definition for Azure DevOps
 . ci/lib.sh: add support for Azure Pipelines
 . tests: optionally write results as JUnit-style .xml
 . test-date: add a subcommand to measure times in shell scripts
 . ci/lib.sh: encapsulate Travis-specific things
 . ci: rename the library of common functions

 Prepare to run test suite on Azure DevOps.

 Ejected out of 'pu', as doing so seems to help other topics get
 tested at TravisCI.

 https://travis-ci.org/git/git/builds/452713184 is a sample of a
 build whose tests on 4 hang (with this series in).  Ejecting it
 gave us https://travis-ci.org/git/git/builds/452778963 which still
 shows breakages from other topics not yet in 'next', but at least
 the tests do not stall.


* du/branch-show-current (2018-10-26) 1 commit
 - branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 I am personally not yet quite convinced if this is worth pursuing.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* ag/sequencer-reduce-rewriting-todo (2019-01-14) 18 commits
 - rebase-interactive.h: fix hdr-check warnings
 - sequencer: mark file local symbols as static
 - rebase-interactive: move transform_todo_file() to rebase--interactive.c
 - sequencer: use edit_todo_list() in complete_action()
 - rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 - rebase-interactive: append_todo_help() changes
 - rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 - sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 - sequencer: change complete_action() to use the refactored functions
 - sequencer: make sequencer_make_script() write its script to a strbuf
 - sequencer: refactor rearrange_squash() to work on a todo_list
 - sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 - sequencer: refactor check_todo_list() to work on a todo_list
 - sequencer: introduce todo_list_write_to_file()
 - sequencer: refactor transform_todos() to work on a todo_list
 - sequencer: remove the 'arg' field from todo_item
 - sequencer: make the todo_list structure public
 - sequencer: changes in parse_insn_buffer()

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 May need a further update, including squashing the tip commit to a
 releavant place.


* sb/submodule-recursive-fetch-gets-the-tip (2018-12-09) 9 commits
  (merged to 'next' on 2019-01-18 at 79a2809fbc)
 + fetch: ensure submodule objects fetched
 + submodule.c: fetch in submodules git directory instead of in worktree
 + submodule: migrate get_next_submodule to use repository structs
 + repository: repo_submodule_init to take a submodule struct
 + submodule: store OIDs in changed_submodule_names
 + submodule.c: tighten scope of changed_submodule_names struct
 + submodule.c: sort changed_submodule_names before searching it
 + submodule.c: fix indentation
 + sha1-array: provide oid_array_filter

 "git fetch --recurse-submodules" may not fetch the necessary commit
 that is bound to the superproject, which is getting corrected.

 Will merge to 'master'.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ps/stash-in-c (2019-01-18) 28 commits
 - stash: fix segmentation fault when files were added with intent
 - tests: add a special setup where stash.useBuiltin is off
 - stash: optionally use the scripted version again
 - stash: add back the original, scripted `git stash`
 - stash: convert `stash--helper.c` into `stash.c`
 - stash: replace all `write-tree` child processes with API calls
 - stash: optimize `get_untracked_files()` and `check_changes()`
 - stash: convert save to builtin
 - stash: make push -q quiet
 - stash: convert push to builtin
 - stash: convert create to builtin
 - stash: convert store to builtin
 - stash: convert show to builtin
 - stash: convert list to builtin
 - stash: convert pop to builtin
 - stash: convert branch to builtin
 - stash: convert drop and clear to builtin
 - stash: convert apply to builtin
 - stash: mention options in `show` synopsis
 - stash: add tests for `git stash show` config
 - stash: rename test cases to be more descriptive
 - t3903: modernize style
 - stash: improve option parsing test coverage
 - ident: add the ability to provide a "fallback identity"
 - strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
 - strbuf.c: add `strbuf_join_argv()`
 - sha1-name.c: add `get_oidf()` which acts like `get_oid()`
 - Merge branch 'sd/stash-wo-user-name'

 "git stash" rewritten in C.

 Will merge to 'next'.


* pw/add-p-select (2018-07-26) 4 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select modified lines correctly
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Will discard.
 No further feedbacks on the topic for quite some time.

 cf. <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
 I found the feature to be hard to explain, and may result in more
 end-user complaints, but let's see.
