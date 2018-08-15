Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21AE61F404
	for <e@80x24.org>; Wed, 15 Aug 2018 23:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeHPB4M (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 21:56:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39226 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbeHPB4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 21:56:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so2648097wmq.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 16:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=15Cb/NJ1vjQghrIOO/WPbBdzEA+kcx4qpuesgIYTwKk=;
        b=PsQvdHj58LbcMDPjLkcU25piqPEo4zAxgBMARPUOZE/86MFIWS3A+SDhHUHrdiiWIS
         PijreZwZwLLxORwuQ+dUu059QT+pN9ymqU+bxLqR9xHWxKSwCh0cyNsu/3fjhGA4RcJr
         4RYDoUnt6NrIQdPtfl3gsN5OFlAKjAUBnCbM10flnIQthUqJJ32CCkVQ7YUbGh1GZMK6
         RphjZLEoh/i51pknBjWhOmnAda6FChhSO8/2V0UFuKFa9aUv6tZzTmCpqyCZlu/9wbRT
         2sh4xc70z8ZDyPyPPIB6JspZtbSBhkol9tewpKWGq6Nj5MbkzXlfHbTsde1efz1wNbj/
         BoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=15Cb/NJ1vjQghrIOO/WPbBdzEA+kcx4qpuesgIYTwKk=;
        b=B+FYDgMWocdE52peTGKC5NmV/rnMEFmkWZJpKv6evuk2RhKXcg21dLc2tm2eHltrDT
         TpiyRBl0DFH2gWo/A+breFRuicFhO/B2lud0meG5NoaXqoFFOFJgulacffEqveS/4XcB
         0NelgULvb//4Hmq6DHUTm9SwlUfkBDLYTRmuVYjgnZQ76xSo07o+cubmGbYIjagbkdFo
         vgz9D3daid7rp8HR02u8oN0TYDGR80vJDFvr5+LYRbxWt7LzSKyIdjCf6isW9QZvD39z
         +87hG74cfOIQQ3qyUJ3meNoqbETClOlLbU9/WTVccYyPcDMtxrWVcouqgYPoFwdisMKg
         NNzw==
X-Gm-Message-State: AOUpUlG1nxzzk6s70v9vVov4JZtKvTc7lNnJYMAwt/RxyThENyNr2JPA
        7hWvwQ8wWfmVmhDYbJOYl2n4EI1P8qvxEQ==
X-Google-Smtp-Source: AA+uWPxA4h/L8gun2HK7wuXfj9SP5DLZeoFuiHp7FnXo3bvFUGjmHXM8VU1PmJIPf48RBy2s3SmzZQ==
X-Received: by 2002:a1c:30d2:: with SMTP id w201-v6mr13818608wmw.47.1534374110231;
        Wed, 15 Aug 2018 16:01:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h17-v6sm19448979wrq.73.2018.08.15.16.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 16:01:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2018, #03; Wed, 15)
X-master-at: 63749b2dea5d1501ff85bab7b8a7f64911d21dea
X-next-at: a543ac7ca4538799a4ba8d9b2640e17e2fdf406f
Date:   Wed, 15 Aug 2018 16:01:48 -0700
Message-ID: <xmqqpnyjgroj.fsf@gitster-ct.c.googlers.com>
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

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bb/make-developer-pedantic (2018-07-25) 1 commit
  (merged to 'next' on 2018-08-02 at c738a84b7e)
 + Makefile: add a DEVOPTS flag to get pedantic compilation

 "make DEVELOPER=1 DEVOPTS=pedantic" allows developers to compile
 with -pedantic option, which may catch more problematic program
 constructs and potential bugs.


* bb/redecl-enum-fix (2018-07-26) 1 commit
  (merged to 'next' on 2018-08-06 at 828dc4b156)
 + packfile: ensure that enum object_type is defined

 Compilation fix.


* bw/clone-ref-prefixes (2018-07-20) 1 commit
  (merged to 'next' on 2018-08-02 at c8ad140ab0)
 + clone: send ref-prefixes when using protocol v2

 The wire-protocol v2 relies on the client to send "ref prefixes" to
 limit the bandwidth spent on the initial ref advertisement.  "git
 clone" when learned to speak v2 forgot to do so, which has been
 corrected.


* bw/fetch-pack-i18n (2018-07-23) 1 commit
  (merged to 'next' on 2018-08-02 at df72001755)
 + fetch-pack: mark die strings for translation

 i18n updates.


* bw/protocol-v2 (2018-07-24) 1 commit
  (merged to 'next' on 2018-08-02 at f4076b3e94)
 + pack-protocol: mention and point to docs for protocol v2

 Doc update.


* cb/p4-pre-submit-hook (2018-08-01) 1 commit
  (merged to 'next' on 2018-08-06 at e40ae4af80)
 + git-p4: add the `p4-pre-submit` hook

 "git p4 submit" learns to ask its own pre-submit hook if it should
 continue with submitting.


* en/merge-recursive-skip-fix (2018-07-27) 2 commits
  (merged to 'next' on 2018-08-06 at 9ab321a15c)
 + merge-recursive: preserve skip_worktree bit when necessary
 + t3507: add a testcase showing failure with sparse checkout

 When the sparse checkout feature is in use, "git cherry-pick" and
 other mergy operations lost the skip_worktree bit when a path that
 is excluded from checkout requires content level merge, which is
 resolved as the same as the HEAD version, without materializing the
 merge result in the working tree, which made the path appear as
 deleted.  This has been corrected by preserving the skip_worktree
 bit (and not materializing the file in the working tree).


* es/diff-color-moved-fix (2018-07-25) 1 commit
  (merged to 'next' on 2018-08-02 at 233bccfbfb)
 + diff: --color-moved: rename "dimmed_zebra" to "dimmed-zebra"

 One of the "diff --color-moved" mode "dimmed_zebra" that was named
 in an unusual way has been deprecated and replaced by
 "dimmed-zebra".


* es/mw-to-git-chain-fix (2018-07-31) 1 commit
  (merged to 'next' on 2018-08-06 at c10246e1c8)
 + mw-to-git/t9360: fix broken &&-chain

 Test fix.


* hs/gpgsm (2018-07-20) 7 commits
  (merged to 'next' on 2018-08-02 at db28bffe4f)
 + gpg-interface t: extend the existing GPG tests with GPGSM
 + gpg-interface: introduce new signature format "x509" using gpgsm
 + gpg-interface: introduce new config to select per gpg format program
 + gpg-interface: do not hardcode the key string len anymore
 + gpg-interface: introduce an abstraction for multiple gpg formats
 + t/t7510: check the validation of the new config gpg.format
 + gpg-interface: add new config to select how to sign a commit

 Teach "git tag -s" etc. a few configuration variables (gpg.format
 that can be set to "openpgp" or "x509", and gpg.<format>.program
 that is used to specify what program to use to deal with the format)
 to allow x.509 certs with CMS via "gpgsm" to be used instead of
 openpgp via "gnupg".


* jh/json-writer (2018-07-16) 1 commit
  (merged to 'next' on 2018-08-02 at d841450c7d)
 + json_writer: new routines to create JSON data
 (this branch is used by jh/structured-logging.)

 Preparatory code to later add json output for telemetry data.


* jk/banned-function (2018-07-26) 5 commits
  (merged to 'next' on 2018-08-06 at 3dcd1999df)
 + banned.h: mark strncpy() as banned
 + banned.h: mark sprintf() as banned
 + banned.h: mark strcat() as banned
 + automatically ban strcpy()
 + Merge branch 'sb/blame-color' into jk/banned-function

 It is too easy to misuse system API functions such as strcat();
 these selected functions are now forbidden in this codebase and
 will cause a compilation failure.


* jk/core-use-replace-refs (2018-07-18) 3 commits
  (merged to 'next' on 2018-08-02 at 90fb6b1056)
 + add core.usereplacerefs config option
 + check_replace_refs: rename to read_replace_refs
 + check_replace_refs: fix outdated comment

 A new configuration variable core.usereplacerefs has been added,
 primarily to help server installations that want to ignore the
 replace mechanism altogether.


* jk/size-t (2018-07-24) 6 commits
  (merged to 'next' on 2018-08-02 at 6f861e05f0)
 + strbuf_humanise: use unsigned variables
 + pass st.st_size as hint for strbuf_readlink()
 + strbuf_readlink: use ssize_t
 + strbuf: use size_t for length in intermediate variables
 + reencode_string: use size_t for string lengths
 + reencode_string: use st_add/st_mult helpers

 Code clean-up to use size_t/ssize_t when they are the right type.


* jk/ui-color-always-to-auto (2018-07-18) 1 commit
  (merged to 'next' on 2018-08-02 at 1a054baf0e)
 + Documentation: fix --color option formatting

 Doc formatting fix.


* jn/subtree-test-fixes (2018-07-30) 2 commits
  (merged to 'next' on 2018-08-06 at 62f21c328f)
 + subtree test: simplify preparation of expected results
 + subtree test: add missing && to &&-chain

 Test fix.


* js/t7406-recursive-submodule-update-order-fix (2018-07-23) 1 commit
  (merged to 'next' on 2018-08-02 at 217ea36a37)
 + t7406: avoid failures solely due to timing issues

 Test fix.


* js/vscode (2018-07-30) 9 commits
  (merged to 'next' on 2018-08-06 at 5c578b63a8)
 + vscode: let cSpell work on commit messages, too
 + vscode: add a dictionary for cSpell
 + vscode: use 8-space tabs, no trailing ws, etc for Git's source code
 + vscode: wrap commit messages at column 72 by default
 + vscode: only overwrite C/C++ settings
 + mingw: define WIN32 explicitly
 + cache.h: extract enum declaration from inside a struct declaration
 + vscode: hard-code a couple defines
 + contrib: add a script to initialize VS Code configuration

 Add a script (in contrib/) to help users of VSCode work better with
 our codebase.


* jt/connectivity-check-after-unshallow (2018-08-01) 1 commit
  (merged to 'next' on 2018-08-06 at 1932418f46)
 + fetch-pack: unify ref in and out param

 "git fetch" sometimes failed to update the remote-tracking refs,
 which has been corrected.


* jt/tag-following-with-proto-v2-fix (2018-07-24) 2 commits
  (merged to 'next' on 2018-08-02 at d9eabdea95)
 + fetch: send "refs/tags/" prefix upon CLI refspecs
 + t5702: test fetch with multiple refspecs at a time

 The wire-protocol v2 relies on the client to send "ref prefixes" to
 limit the bandwidth spent on the initial ref advertisement.  "git
 fetch $remote branch:branch" that asks tags that point into the
 history leading to the "branch" automatically followed sent to
 narrow prefix and broke the tag following, which has been fixed.


* ms/http-proto-doc (2018-07-30) 1 commit
  (merged to 'next' on 2018-08-06 at df1cac9945)
 + doc: fix want-capability separator

 Doc fix.


* nd/i18n (2018-07-23) 23 commits
  (merged to 'next' on 2018-08-02 at 904a22a5d1)
 + transport-helper.c: mark more strings for translation
 + transport.c: mark more strings for translation
 + sha1-file.c: mark more strings for translation
 + sequencer.c: mark more strings for translation
 + replace-object.c: mark more strings for translation
 + refspec.c: mark more strings for translation
 + refs.c: mark more strings for translation
 + pkt-line.c: mark more strings for translation
 + object.c: mark more strings for translation
 + exec-cmd.c: mark more strings for translation
 + environment.c: mark more strings for translation
 + dir.c: mark more strings for translation
 + convert.c: mark more strings for translation
 + connect.c: mark more strings for translation
 + config.c: mark more strings for translation
 + commit-graph.c: mark more strings for translation
 + builtin/replace.c: mark more strings for translation
 + builtin/pack-objects.c: mark more strings for translation
 + builtin/grep.c: mark strings for translation
 + builtin/config.c: mark more strings for translation
 + archive-zip.c: mark more strings for translation
 + archive-tar.c: mark more strings for translation
 + Update messages in preparation for i18n

 Many more strings are prepared for l10n.


* nd/pack-objects-threading-doc (2018-07-30) 1 commit
  (merged to 'next' on 2018-08-06 at cc8c305191)
 + pack-objects: document about thread synchronization

 Doc fix.


* rs/remote-mv-leakfix (2018-08-01) 1 commit
  (merged to 'next' on 2018-08-06 at 999fe6d3e5)
 + remote: clear string_list after use in mv()

 Leakfix.


* sb/histogram-less-memory (2018-07-23) 4 commits
  (merged to 'next' on 2018-08-02 at cfb02aa3b5)
 + xdiff/histogram: remove tail recursion
 + xdiff/xhistogram: move index allocation into find_lcs
 + xdiff/xhistogram: factor out memory cleanup into free_index()
 + xdiff/xhistogram: pass arguments directly to fall_back_to_classic_diff

 "git diff --histogram" had a bad memory usage pattern, which has
 been rearranged to reduce the peak usage.


* sb/trailers-docfix (2018-07-20) 1 commit
  (merged to 'next' on 2018-08-02 at ba348fafcd)
 + Documentation/git-interpret-trailers: explain possible values

 Doc update.


* sg/coccicheck-updates (2018-07-23) 5 commits
  (merged to 'next' on 2018-08-02 at b5548ff3a9)
 + coccinelle: extract dedicated make target to clean Coccinelle's results
 + coccinelle: put sane filenames into output patches
 + coccinelle: exclude sha1dc source files from static analysis
 + coccinelle: use $(addsuffix) in 'coccicheck' make target
 + coccinelle: mark the 'coccicheck' make target as .PHONY

 Update the way we use Coccinelle to find out-of-style code that
 need to be modernised.


* sg/fast-import-dump-refs-on-checkpoint-fix (2018-07-20) 1 commit
  (merged to 'next' on 2018-08-02 at f5c05b5a2c)
 + t9300: wait for background fast-import process to die after killing it

 Test update.


* sg/travis-cocci-diagnose-failure (2018-07-23) 2 commits
  (merged to 'next' on 2018-08-02 at 54808a8778)
 + travis-ci: fail if Coccinelle static analysis found something to transform
 + travis-ci: run Coccinelle static analysis with two parallel jobs

 Update the way we run static analysis tool at TravisCI to make it
 easier to use its findings.


* sg/travis-retrieve-trash-upon-failure (2018-08-01) 1 commit
  (merged to 'next' on 2018-08-06 at d67def2a92)
 + travis-ci: include the trash directories of failed tests in the trace log

 The Travis CI scripts were taught to ship back the test data from
 failed tests.

--------------------------------------------------
[New Topics]

* en/t7406-fixes (2018-08-08) 5 commits
  (merged to 'next' on 2018-08-15 at c6a740d828)
 + t7406: avoid using test_must_fail for commands other than git
 + t7406: prefer test_* helper functions to test -[feds]
 + t7406: avoid having git commands upstream of a pipe
 + t7406: simplify by using diff --name-only instead of diff --raw
 + t7406: fix call that was failing for the wrong reason

 Test fixes.

 Will merge to 'master'.


* en/update-index-doc (2018-08-08) 1 commit
  (merged to 'next' on 2018-08-15 at 3ee0ae14dc)
 + git-update-index.txt: reword possibly confusing example

 Doc update.

 Will merge to 'master'.


* jc/update-index-doc (2018-08-08) 1 commit
  (merged to 'next' on 2018-08-15 at 055994ccca)
 + update-index: there no longer is `apply --index-info`

 Doc update.

 Will merge to 'master'.


* js/typofixes (2018-08-08) 2 commits
  (merged to 'next' on 2018-08-15 at ce3932254a)
 + remote-curl: remove spurious period
 + git-compat-util.h: fix typo

 Comment update.

 Will merge to 'master'.


* jt/repack-promisor-packs (2018-08-09) 2 commits
 - repack: repack promisor objects if -a or -A is set
 - repack: refactor setup of pack-objects cmd

 After a partial clone, repeated fetches from promisor remote would
 have accumulated many packfiles marked with .promisor bit without
 getting them coalesced into fewer packfiles, hurting performance.
 "git repack" now learned to repack them.

 Will merge to 'next'.


* sk/instaweb-rh-update (2018-08-08) 2 commits
  (merged to 'next' on 2018-08-15 at ce5f1115e9)
 + git-instaweb: fix apache2 config with apache >= 2.4
 + git-instaweb: support Fedora/Red Hat apache module path

 "git instaweb" has been adjusted to run better with newer Apache on
 RedHat based distros.

 Will merge to 'master'.


* ab/submodule-relative-url-tests (2018-08-14) 1 commit
 - submodule: add more exhaustive up-path testing

 Test updates.

 Will merge to 'next'.


* ao/submodule-wo-gitmodules-checked-out (2018-08-14) 7 commits
 - submodule: support reading .gitmodules even when it's not checked out
 - t7506: clean up .gitmodules properly before setting up new scenario
 - submodule: use the 'submodule--helper config' command
 - submodule--helper: add a new 'config' subcommand
 - t7411: be nicer to future tests and really clean things up
 - submodule: factor out a config_set_in_gitmodules_file_gently function
 - submodule: add a print_config_from_gitmodules() helper

 The submodule support has been updated to read from the blob at
 HEAD:.gitmodules when the .gitmodules file is missing from the
 working tree.

 I find the design a bit iffy in that our usual "missing in the
 working tree?  let's use the latest blob" fallback is to take it
 from the index, not from the HEAD.


* bw/submodule-name-to-dir (2018-08-10) 2 commits
 - submodule: munge paths to submodule git directories
 - submodule: create helper to build paths to submodule gitdirs

 In modern repository layout, the real body of a cloned submodule
 repository is held in .git/modules/ of the superproject, indexed by
 the submodule name.  URLencode the submodule name before computing
 the name of the directory to make sure they form a flat namespace.

 Will merge to 'next'.


* cc/delta-islands (2018-08-10) 8 commits
 - pack-objects: move 'layer' into 'struct packing_data'
 - pack-objects: move tree_depth into 'struct packing_data'
 - t5320: delta islands tests
 - repack: add delta-islands support
 - pack-objects: add delta-islands support
 - pack-objects: refactor code into compute_layer_order()
 - Add delta-islands.{c,h}
 - packfile: make get_delta_base() non static

 Lift code from GitHub to restrict delta computation so that an
 object that exists in one fork is not made into a delta against
 another object that does not appear in the same forked repository.

 What's the doneness of this topic?


* ds/commit-graph-fsck (2018-08-13) 1 commit
  (merged to 'next' on 2018-08-15 at a2f82d3cbd)
 + t5318: use 'test_cmp_bin' to compare commit-graph files

 Test fix.

 Will merge to 'master'.


* en/incl-forward-decl (2018-08-15) 6 commits
 - Remove forward declaration of an enum
 - compat/precompose_utf8.h: use more common include guard style
 - urlmatch.h: fix include guard
 - Move definition of enum branch_track from cache.h to branch.h
 - alloc: make allocate_alloc_state and clear_alloc_state more consistent
 - Add missing includes and forward declarations

 Code hygiene improvement for the header files.

 Will merge to 'next'.


* es/chain-lint-more (2018-08-13) 6 commits
  (merged to 'next' on 2018-08-15 at bb5150ee96)
 + chainlint: add test of pathological case which triggered false positive
 + chainlint: recognize multi-line quoted strings more robustly
 + chainlint: let here-doc and multi-line string commence on same line
 + chainlint: recognize multi-line $(...) when command cuddled with "$("
 + chainlint: match 'quoted' here-doc tags
 + chainlint: match arbitrary here-docs tags rather than hard-coded names

 Improve built-in facility to catch broken &&-chain in the tests.

 Will merge to 'master'.


* jc/gpg-status (2018-08-09) 1 commit
  (merged to 'next' on 2018-08-15 at 824781761a)
 + gpg-interface: propagate exit status from gpg back to the callers

 Will merge to 'master'.


* jh/partial-clone-doc (2018-08-15) 1 commit
  (merged to 'next' on 2018-08-15 at cf09e8be6a)
 + partial-clone: render design doc using asciidoc

 Doc updates.

 Will merge to 'master'.


* jk/for-each-object-iteration (2018-08-14) 11 commits
  (merged to 'next' on 2018-08-15 at e2558810ff)
 + for_each_*_object: move declarations to object-store.h
 + cat-file: use a single strbuf for all output
 + cat-file: split batch "buf" into two variables
 + cat-file: use oidset check-and-insert
 + cat-file: support "unordered" output for --batch-all-objects
 + cat-file: rename batch_{loose,packed}_object callbacks
 + t1006: test cat-file --batch-all-objects with duplicates
 + for_each_packed_object: support iterating in pack-order
 + for_each_*_object: give more comprehensive docstrings
 + for_each_*_object: take flag arguments as enum
 + for_each_*_object: store flag definitions in a single location

 The API to iterate over all objects learned to optionally list
 objects in the order they appear in packfiles, which helps locality
 of access if the caller accesses these objects while as objects are
 enumerated.

 Will merge to 'master'.


* js/chain-lint-attrfix (2018-08-15) 1 commit
  (merged to 'next' on 2018-08-15 at e9ad19a848)
 + chainlint: fix for core.autocrlf=true

 Test fix.

 Will merge to 'master'.


* js/mingw-o-append (2018-08-13) 1 commit
  (merged to 'next' on 2018-08-15 at 284527a0fb)
 + mingw: enable atomic O_APPEND

 Among the three codepaths we use O_APPEND to open a file for
 appending, one used for writing GIT_TRACE output requires O_APPEND
 implementation that behaves sensibly when multiple processes are
 writing to the same file.  POSIX emulation used in the Windows port
 has been updated to improve in this area.

 Will merge to 'master'.


* jt/commit-graph-per-object-store (2018-08-13) 1 commit
  (merged to 'next' on 2018-08-15 at 5d6db738d8)
 + t5318: avoid unnecessary command substitutions

 Test update.

 Will merge to 'master'.


* jt/fetch-negotiator-skipping (2018-08-10) 1 commit
  (merged to 'next' on 2018-08-15 at 3cf8fa32f5)
 + t5552: suppress upload-pack trace output

 Test fix.

 Will merge to 'master'.


* md/filter-trees (2018-08-15) 6 commits
 - list-objects-filter: implement filter tree:0
 - revision: mark non-user-given objects instead
 - rev-list: handle missing tree objects properly
 - list-objects: always parse trees gently
 - list-objects: refactor to process_tree_contents
 - list-objects: store common func args in struct

 The "rev-list --filter" feature learned to exclude all trees via
 "tree:0" filter.

 Expecting a reroll.


* nd/no-the-index (2018-08-13) 24 commits
  (merged to 'next' on 2018-08-15 at 41e53dc53b)
 + blame.c: remove implicit dependency on the_index
 + apply.c: remove implicit dependency on the_index
 + apply.c: make init_apply_state() take a struct repository
 + apply.c: pass struct apply_state to more functions
 + resolve-undo.c: use the right index instead of the_index
 + archive-*.c: use the right repository
 + archive.c: avoid access to the_index
 + grep: use the right index instead of the_index
 + attr: remove index from git_attr_set_direction()
 + entry.c: use the right index instead of the_index
 + submodule.c: use the right index instead of the_index
 + pathspec.c: use the right index instead of the_index
 + unpack-trees: avoid the_index in verify_absent()
 + unpack-trees: convert clear_ce_flags* to avoid the_index
 + unpack-trees: don't shadow global var the_index
 + unpack-trees: add a note about path invalidation
 + unpack-trees: remove 'extern' on function declaration
 + ls-files: correct index argument to get_convert_attr_ascii()
 + preload-index.c: use the right index instead of the_index
 + dir.c: remove an implicit dependency on the_index in pathspec code
 + convert.c: remove an implicit dependency on the_index
 + attr: remove an implicit dependency on the_index
 + cache-tree: wrap the_index based wrappers with #ifdef
 + diff.c: move read_index() code back to the caller
 (this branch uses nd/no-extern.)

 The more library-ish parts of the codebase learned to work on the
 in-core index-state instance that is passed in by their callers,
 instead of always working on the singleton "the_index" instance.

 Will merge to 'master'.


* ng/mergetool-lose-final-prompt (2018-08-13) 1 commit
  (merged to 'next' on 2018-08-15 at f8f7ac365b)
 + mergetool: don't suggest to continue after last file

 "git mergetool" stopped and gave an extra prompt to continue after
 the last path has been handled, which did not make much sense.

 Will merge to 'master'.


* ng/status-i-short-for-ignored (2018-08-09) 1 commit
 - status: -i shorthand for --ignored command line option


* pk/rebase-in-c-2-basic (2018-08-10) 11 commits
 - builtin rebase: support `git rebase <upstream> <switch-to>`
 - builtin rebase: only store fully-qualified refs in `options.head_name`
 - builtin rebase: start a new rebase only if none is in progress
 - builtin rebase: support --force-rebase
 - builtin rebase: try to fast forward when possible
 - builtin rebase: require a clean worktree
 - builtin rebase: support the `verbose` and `diffstat` options
 - builtin rebase: support --quiet
 - builtin rebase: handle the pre-rebase hook (and add --no-verify)
 - builtin rebase: support `git rebase --onto A...B`
 - builtin rebase: support --onto
 (this branch is used by pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c.)


* pk/rebase-in-c-3-acts (2018-08-10) 7 commits
 - builtin rebase: stop if `git am` is in progress
 - builtin rebase: actions require a rebase in progress
 - builtin rebase: support --edit-todo and --show-current-patch
 - builtin rebase: support --quit
 - builtin rebase: support --abort
 - builtin rebase: support --skip
 - builtin rebase: support --continue
 (this branch is used by pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c and pk/rebase-in-c-2-basic.)


* pk/rebase-in-c-4-opts (2018-08-10) 18 commits
 - builtin rebase: support --root
 - builtin rebase: add support for custom merge strategies
 - builtin rebase: support `fork-point` option
 - merge-base --fork-point: extract libified function
 - builtin rebase: support --rebase-merges[=[no-]rebase-cousins]
 - builtin rebase: support `--allow-empty-message` option
 - builtin rebase: support `--exec`
 - builtin rebase: support `--autostash` option
 - builtin rebase: support `-C` and `--whitespace=<type>`
 - builtin rebase: support `--gpg-sign` option
 - builtin rebase: support `--autosquash`
 - builtin rebase: support `keep-empty` option
 - builtin rebase: support `ignore-date` option
 - builtin rebase: support `ignore-whitespace` option
 - builtin rebase: support --committer-date-is-author-date
 - builtin rebase: support --rerere-autoupdate
 - builtin rebase: support --signoff
 - builtin rebase: allow selecting the rebase "backend"
 (this branch is used by pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c, pk/rebase-in-c-2-basic and pk/rebase-in-c-3-acts.)


* pk/rebase-in-c-5-test (2018-08-10) 6 commits
 - builtin rebase: error out on incompatible option/mode combinations
 - builtin rebase: use no-op editor when interactive is "implied"
 - builtin rebase: show progress when connected to a terminal
 - builtin rebase: fast-forward to onto if it is a proper descendant
 - builtin rebase: optionally pass custom reflogs to reset_head()
 - builtin rebase: optionally auto-detect the upstream
 (this branch is used by pk/rebase-in-c-6-final; uses pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts and pk/rebase-in-c-4-opts.)


* pk/rebase-in-c-6-final (2018-08-10) 1 commit
 - rebase: default to using the builtin rebase
 (this branch uses pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test.)


* ps/stash-in-c (2018-08-08) 26 commits
 - stash: replace all "git apply" child processes with API calls
 - stash: replace all `write-tree` child processes with API calls
 - stash: optimize `get_untracked_files()` and `check_changes()`
 - stash: convert `stash--helper.c` into `stash.c`
 - stash: convert save to builtin
 - stash: replace spawning `git ls-files` child process
 - stash: add tests for `git stash push -q`
 - stash: make push to be quiet
 - stash: convert push to builtin
 - stash: avoid spawning a "diff-index" process
 - stash: replace spawning a "read-tree" process
 - stash: convert create to builtin
 - stash: convert store to builtin
 - stash: update `git stash show` documentation
 - stash: refactor `show_stash()` to use the diff API
 - stash: change `git stash show` usage text and documentation
 - stash: convert show to builtin
 - stash: implement the "list" command in the builtin
 - stash: convert pop to builtin
 - stash: convert branch to builtin
 - stash: convert drop and clear to builtin
 - stash: convert apply to builtin
 - stash: renamed test cases to be more descriptive
 - stash: update test cases conform to coding guidelines
 - stash: improve option parsing test coverage
 - sha1-name.c: added 'get_oidf', which acts like 'get_oid'


* pw/rebase-i-squash-number-fix (2018-08-15) 2 commits
 - squash??? if this is easier to read
 - rebase -i: fix numbering in squash message

 When "git rebase -i" is told to squash two or more commits into
 one, it labeled the log message for each commit with its number.
 It correctly called the first one "1st commit", but the next one
 was "commit #1", which was off-by-one.  This has been corrected.

 Will merge to 'next' after dropping the clean-up at the tip.


* sb/pull-rebase-submodule (2018-08-14) 1 commit
  (merged to 'next' on 2018-08-15 at 07c7b55cc9)
 + git-submodule.sh: accept verbose flag in cmd_update to be non-quiet

 "git pull --rebase -v" in a repository with a submodule barfed as
 an intermediate process did not understand what "-v(erbose)" flag
 meant, which has been fixed.

 Will merge to 'master'.


* sg/t5310-empty-input-fix (2018-08-14) 1 commit
  (merged to 'next' on 2018-08-15 at c3c03973a0)
 + t5310-pack-bitmaps: fix bogus 'pack-objects to file can use bitmap' test

 Test fix.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* bp/checkout-new-branch-optim (2018-07-31) 1 commit
 - checkout: optimize "git checkout -b <new_branch>"

 "git checkout -b newbranch [HEAD]" should not have to do as much as
 checking out a commit different from HEAD.  An attempt is made to
 optimize this special case.

 So... what is the status of this thing?  Is the other "optimize
 unpack-trees" effort turning out to be a safer and less hacky way
 to achieve similar gain and this no longer is needed?


* sl/commit-dry-run-with-short-output-fix (2018-07-30) 4 commits
 . commit: fix exit code when doing a dry run
 . wt-status: teach wt_status_collect about merges in progress
 . wt-status: rename commitable to committable
 . t7501: add coverage for flags which imply dry runs

 "git commit --dry-run" gave a correct exit status even during a
 conflict resolution toward a merge, but it did not with the
 "--short" option, which has been corrected.

 Seems to break 7512, 3404 and 7060 in 'pu'.


* ma/wrapped-info (2018-05-28) 2 commits
 - usage: prefix all lines in `vreportf()`, not just the first
 - usage: extract `prefix_suffix_lines()` from `advise()`

 An attempt to help making multi-line messages fed to warning(),
 error(), and friends more easily translatable.

 Will discard and wait for a cleaned-up rewrite.
 cf. <20180529213957.GF7964@sigill.intra.peff.net>


* hn/bisect-first-parent (2018-04-21) 1 commit
 - bisect: create 'bisect_flags' parameter in find_bisection()

 Preliminary code update to allow passing more flags down the
 bisection codepath in the future.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


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


* pb/bisect-helper-2 (2018-07-23) 8 commits
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

 I just rebased the topic to a newer base as it did not build
 standalone with the base I originally queued the topic on, but
 otherwise there is no update to address any of the review comments
 in the thread above---we are still waiting for a reroll.


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

* js/rebase-merges-exec-fix (2018-08-09) 2 commits
  (merged to 'next' on 2018-08-15 at 9de975d92d)
 + rebase --exec: make it work with --rebase-merges
 + t3430: demonstrate what -r, --autosquash & --exec should do

 The "--exec" option to "git rebase --rebase-merges" placed the exec
 commands at wrong places, which has been corrected.

 Will merge to 'master'.


* nd/no-extern (2018-08-03) 12 commits
  (merged to 'next' on 2018-08-08 at bcce75766b)
 + submodule.h: drop extern from function declaration
 + revision.h: drop extern from function declaration
 + repository.h: drop extern from function declaration
 + rerere.h: drop extern from function declaration
 + line-range.h: drop extern from function declaration
 + diff.h: remove extern from function declaration
 + diffcore.h: drop extern from function declaration
 + convert.h: drop 'extern' from function declaration
 + cache-tree.h: drop extern from function declaration
 + blame.h: drop extern on func declaration
 + attr.h: drop extern from function declaration
 + apply.h: drop extern on func declaration
 (this branch is used by nd/no-the-index.)

 Noiseword "extern" has been removed from function decls in the
 header files.

 Will merge to 'master'.


* ar/t4150-am-scissors-test-fix (2018-08-06) 1 commit
  (merged to 'next' on 2018-08-08 at e639183205)
 + t4150: fix broken test for am --scissors

 Test fix.

 Will merge to 'master'.


* en/t3031-title-fix (2018-08-06) 1 commit
  (merged to 'next' on 2018-08-08 at 3913b03884)
 + t3031: update test description to mention desired behavior

 Test fix.

 Will merge to 'master'.


* hn/config-in-code-comment (2018-08-06) 1 commit
  (merged to 'next' on 2018-08-08 at 1fae946a0f)
 + config: document git config getter return value

 Header update.

 Will merge to 'master'.


* jk/diff-rendered-docs (2018-08-06) 1 commit
  (merged to 'next' on 2018-08-08 at fe6e1b4dbe)
 + add a script to diff rendered documentation

 Developer support to allow the end result of documentation update
 to be inspected more easily.

 Will merge to 'master'.


* js/pull-rebase-type-shorthand (2018-08-06) 1 commit
  (merged to 'next' on 2018-08-08 at 9213756b36)
 + pull --rebase=<type>: allow single-letter abbreviations for the type

 "git pull --rebase=interactive" learned "i" as a short-hand for
 "interactive".

 Will merge to 'master'.


* nd/complete-config-vars (2018-08-06) 1 commit
  (merged to 'next' on 2018-08-08 at ffc8e1a3cd)
 + Makefile: add missing dependency for command-list.h

 Build fix.

 Will merge to 'master'.


* nd/config-blame-sort (2018-08-06) 1 commit
  (merged to 'next' on 2018-08-08 at 34ebb9888f)
 + config.txt: reorder blame stuff to keep config keys sorted

 Doc fix.

 Will merge to 'master'.


* wc/make-funnynames-shared-lazy-prereq (2018-08-06) 1 commit
 - t: factor out FUNNYNAMES as shared lazy prereq

 A test prerequisite defined by various test scripts with slightly
 different sematics has been consolidated into a single copy and
 made into a lazily defined one.

 Will merge to 'next'.


* ab/fsck-transfer-updates (2018-07-27) 10 commits
  (merged to 'next' on 2018-08-08 at d92085269f)
 + fsck: test and document unknown fsck.<msg-id> values
 + fsck: add stress tests for fsck.skipList
 + fsck: test & document {fetch,receive}.fsck.* config fallback
 + fetch: implement fetch.fsck.*
 + transfer.fsckObjects tests: untangle confusing setup
 + config doc: elaborate on fetch.fsckObjects security
 + config doc: elaborate on what transfer.fsckObjects does
 + config doc: unify the description of fsck.* and receive.fsck.*
 + config doc: don't describe *.fetchObjects twice
 + receive.fsck.<msg-id> tests: remove dead code

 The test performed at the receiving end of "git push" to prevent
 bad objects from entering repository can be customized via
 receive.fsck.* configuration variables; we now have gained a
 counterpart to do the same on the "git fetch" side, with
 fetch.fsck.* configuration variables.

 Will merge to 'master'.


* ab/test-must-be-empty (2018-07-30) 1 commit
  (merged to 'next' on 2018-08-08 at 06599ebd1f)
 + tests: make use of the test_must_be_empty function

 Test updates.

 Will merge to 'master'.


* ab/test-must-be-empty-for-master (2018-07-30) 1 commit
  (merged to 'next' on 2018-08-15 at 17652a77fb)
 + tests: make use of the test_must_be_empty function

 Test updates.

 Will merge to 'master'.


* es/rebase-i-author-script-fix (2018-07-31) 4 commits
  (merged to 'next' on 2018-08-08 at 6b34261b72)
 + sequencer: don't die() on bogus user-edited timestamp
 + sequencer: fix "rebase -i --root" corrupting author header timestamp
 + sequencer: fix "rebase -i --root" corrupting author header timezone
 + sequencer: fix "rebase -i --root" corrupting author header
 (this branch is used by pw/rebase-i-author-script-fix.)

 The "author-script" file "git rebase -i" creates got broken when
 we started to move the command away from shell script, which is
 getting fixed now.

 Will merge to 'master'.


* hn/highlight-sideband-keywords (2018-08-08) 1 commit
  (merged to 'next' on 2018-08-15 at f8945f3be5)
 + sideband: highlight keywords in remote sideband output

 The sideband code learned to optionally paint selected keywords at
 the beginning of incoming lines on the receiving end.

 Will merge to 'master'.


* sb/indent-heuristic-optim (2018-08-01) 1 commit
  (merged to 'next' on 2018-08-08 at 539dcc967a)
 + xdiff: reduce indent heuristic overhead

 "git diff --indent-heuristic" had a bad corner case performance.

 Will merge to 'master'.


* ab/fetch-nego (2018-08-01) 3 commits
  (merged to 'next' on 2018-08-08 at 87662bb344)
 + fetch doc: cross-link two new negotiation options
 + negotiator: unknown fetch.negotiationAlgorithm should error out
 + Merge branch 'jt/fetch-nego-tip' into ab/fetch-nego

 Update to a few other topics.

 Will merge to 'master'.


* ab/fetch-tags-noclobber (2018-08-13) 7 commits
  (merged to 'next' on 2018-08-15 at eca0ac8afa)
 + pull doc: fix a long-standing grammar error
 + fetch tests: correct a comment "remove it" -> "remove them"
 + push tests: assert re-pushing annotated tags
 + push tests: add more testing for forced tag pushing
 + push tests: fix logic error in "push" test assertion
 + push tests: remove redundant 'git push' invocation
 + fetch tests: change "Tag" test tag to "testTag"

 Test and doc clean-ups.

 Will merge to 'master'.


* jk/merge-subtree-heuristics (2018-08-02) 1 commit
  (merged to 'next' on 2018-08-08 at 5126c2d717)
 + score_trees(): fix iteration over trees with missing entries

 The automatic tree-matching in "git merge -s subtree" was broken 5
 years ago and nobody has noticed since then, which is now fixed.

 Will merge to 'master'.


* jt/refspec-dwim-precedence-fix (2018-08-02) 1 commit
  (merged to 'next' on 2018-08-08 at 34d0484d3a)
 + remote: make refspec follow the same disambiguation rule as local refs

 "git fetch $there refs/heads/s" ought to fetch the tip of the
 branch 's', but when "refs/heads/refs/heads/s", i.e. a branch whose
 name is "refs/heads/s" exists at the same time, fetched that one
 instead by mistake.  This has been corrected to honor the usual
 disambiguation rules for abbreviated refnames.

 Will merge to 'master'.


* nd/clone-case-smashing-warning (2018-08-14) 2 commits
 - mark_colliding_entries(): fix incorrect #if...#endif guard
 - clone: report duplicate entries on case-insensitive filesystems

 Running "git clone" against a project that contain two files with
 pathnames that differ only in cases on a case insensitive
 filesystem would result in one of the files lost because the
 underlying filesystem is incapable of holding both at the same
 time.  An attempt is made to detect such a case and warn.

 Expecting a new round of discussion.
 cf. <20180815190816.GA26521@tor.lan>


* nd/unpack-trees-with-cache-tree (2018-08-13) 5 commits
 - unpack-trees: reuse (still valid) cache-tree from src_index
 - unpack-trees: reduce malloc in cache-tree walk
 - unpack-trees: optimize walking same trees with cache-tree
 - unpack-trees: add performance tracing
 - trace.h: support nested performance tracing

 The unpack_trees() API used in checking out a branch and merging
 walks one or more trees along with the index.  When the cache-tree
 in the index tells us that we are walking a tree whose flattened
 contents is known (i.e. matches a span in the index), as linearly
 scanning a span in the index is much more efficient than having to
 open tree objects recursively and listing their entries, the walk
 can be optimized, which is done in this topic.

 Will merge to and cook in 'next'.


* sb/config-write-fix (2018-08-08) 3 commits
 - git-config: document accidental multi-line setting in deprecated syntax
 - config: fix case sensitive subsection names on writing
 - t1300: document current behavior of setting options

 Recent update to "git config" broke updating variable in a
 subsection, which has been corrected.

 Expecting a reroll.
 cf. <CAGZ79kZ1R8sxmtfgPOQcpoWM7GWV1qiRaqMq_zhGyKBB3ARLjg@mail.gmail.com>


* sb/range-diff-colors (2018-08-14) 8 commits
 - diff.c: rewrite emit_line_0 more understandably
 - diff.c: omit check for line prefix in emit_line_0
 - diff: use emit_line_0 once per line
 - diff.c: add set_sign to emit_line_0
 - diff.c: reorder arguments for emit_line_ws_markup
 - diff.c: simplify caller of emit_line_0
 - t3206: add color test for range-diff --dual-color
 - test_decode_color: understand FAINT and ITALIC
 (this branch uses js/range-diff; is tangled with es/format-patch-rangediff.)

 The color output support for recently introduced "range-diff"
 command got tweaked a bit.


* sg/t1404-update-ref-test-timeout (2018-08-01) 1 commit
 - t1404: increase core.packedRefsTimeout to avoid occasional test failure

 An attempt to unflake a test a bit.


* ab/sha1dc (2018-08-02) 1 commit
  (merged to 'next' on 2018-08-08 at 920c190941)
 + sha1dc: update from upstream

 AIX portability update for SHA1DC hash, imported from upstream.

 Will merge to 'master'.


* es/want-color-fd-defensive (2018-08-03) 1 commit
  (merged to 'next' on 2018-08-08 at a11d90d26f)
 + color: protect against out-of-bounds reads and writes

 Futureproofing a helper function that can easily misused.

 Will merge to 'master'.


* pw/rebase-i-author-script-fix (2018-08-07) 2 commits
 - sequencer: fix quoting in write_author_script
 - sequencer: handle errors from read_author_ident()
 (this branch uses es/rebase-i-author-script-fix.)

 Recent "git rebase -i" update started to write bogusly formatted
 author-script, with a matching broken reading code.  These are
 being fixed.

 Undecided.
 Is it the list consensus to favor this "with extra code, read the
 script written by bad writer" approach?


* rs/parse-opt-lithelp (2018-08-03) 7 commits
  (merged to 'next' on 2018-08-08 at 3a4e0142fe)
 + parse-options: automatically infer PARSE_OPT_LITERAL_ARGHELP
 + shortlog: correct option help for -w
 + send-pack: specify --force-with-lease argument help explicitly
 + pack-objects: specify --index-version argument help explicitly
 + difftool: remove angular brackets from argument help
 + add, update-index: fix --chmod argument help
 + push: use PARSE_OPT_LITERAL_ARGHELP instead of unbalanced brackets

 The parse-options machinery learned to refrain from enclosing
 placeholder string inside a "<bra" and "ket>" pair automatically
 without PARSE_OPT_LITERAL_ARGHELP.  Existing help text for option
 arguments that are not formatted correctly have been identified and
 fixed.

 Will merge to 'master'.


* pw/add-p-select (2018-07-26) 4 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select modified lines correctly
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Will hold.
 cf. <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
 I found the feature to be hard to explain, and may result in more
 end-user complaints, but let's see.


* mk/http-backend-content-length (2018-07-30) 4 commits
  (merged to 'next' on 2018-08-08 at 0091062ec4)
 + t5562: avoid non-portable "export FOO=bar" construct
 + http-backend: respect CONTENT_LENGTH for receive-pack
 + http-backend: respect CONTENT_LENGTH as specified by rfc3875
 + http-backend: cleanup writing to child process

 The http-backend (used for smart-http transport) used to slurp the
 whole input until EOF, without paying attention to CONTENT_LENGTH
 that is supplied in the environment and instead expecting the Web
 server to close the input stream.  This has been fixed.

 Will merge to 'master'.


* ds/commit-graph-with-grafts (2018-07-19) 8 commits
  (merged to 'next' on 2018-08-02 at 0ee624e329)
 + commit-graph: close_commit_graph before shallow walk
 + commit-graph: not compatible with uninitialized repo
 + commit-graph: not compatible with grafts
 + commit-graph: not compatible with replace objects
 + test-repository: properly init repo
 + commit-graph: update design document
 + refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
 + refs.c: migrate internal ref iteration to pass thru repository argument

 The recently introduced commit-graph auxiliary data is incompatible
 with mechanisms such as replace & grafts that "breaks" immutable
 nature of the object reference relationship.  Disable optimizations
 based on its use (and updating existing commit-graph) when these
 incompatible features are in use in the repository.

 Perhaps eject and replace with another reroll when it comes.
 cf. <a3640919-95cf-cca4-d552-4715a031dd7f@gmail.com>
 cf. <86bmap7l7a.fsf@gmail.com>


* ds/reachable (2018-07-20) 18 commits
 - commit-reach: use can_all_from_reach
 - commit-reach: make can_all_from_reach... linear
 - commit-reach: replace ref_newer logic
 - test-reach: test commit_contains
 - test-reach: test can_all_from_reach_with_flags
 - test-reach: test reduce_heads
 - test-reach: test get_merge_bases_many
 - test-reach: test is_descendant_of
 - test-reach: test in_merge_bases
 - test-reach: create new test tool for ref_newer
 - commit-reach: move can_all_from_reach_with_flags
 - upload-pack: generalize commit date cutoff
 - upload-pack: refactor ok_to_give_up()
 - upload-pack: make reachable() more generic
 - commit-reach: move commit_contains from ref-filter
 - commit-reach: move ref_newer from remote.c
 - commit.h: remove method declarations
 - commit-reach: move walk methods from commit.c

 The code for computing history reachability has been shuffled,
 obtained a bunch of new tests to cover them, and then being
 improved.

 Will merge to and cook in 'next'.


* es/format-patch-interdiff (2018-07-23) 6 commits
 - format-patch: allow --interdiff to apply to a lone-patch
 - log-tree: show_log: make commentary block delimiting reusable
 - interdiff: teach show_interdiff() to indent interdiff
 - format-patch: teach --interdiff to respect -v/--reroll-count
 - format-patch: add --interdiff option to embed diff in cover letter
 - format-patch: allow additional generated content in make_cover_letter()
 (this branch is used by es/format-patch-rangediff.)

 "git format-patch" learned a new "--interdiff" option to explain
 the difference between this version and the previous atttempt in
 the cover letter (or after the tree-dashes as a comment).

 Stuck in review?
 cf. <CAPig+cSuYUYSPTuKx08wcmQM-G12_-W2T4BS07fA=6grM1b8Gw@mail.gmail.com>


* es/format-patch-rangediff (2018-08-14) 10 commits
 - format-patch: allow --range-diff to apply to a lone-patch
 - format-patch: add --creation-factor tweak for --range-diff
 - format-patch: teach --range-diff to respect -v/--reroll-count
 - format-patch: extend --range-diff to accept revision range
 - format-patch: add --range-diff option to embed diff in cover letter
 - range-diff: relieve callers of low-level configuration burden
 - range-diff: publish default creation factor
 - range-diff: respect diff_option.file rather than assuming 'stdout'
 - Merge branch 'es/format-patch-interdiff' into es/format-patch-rangediff
 - Merge branch 'js/range-diff' into es/format-patch-rangediff
 (this branch uses es/format-patch-interdiff and js/range-diff; is tangled with sb/range-diff-colors.)

 "git format-patch" learned a new "--range-diff" option to explain
 the difference between this version and the previous atttempt in
 the cover letter (or after the tree-dashes as a comment).

 Need to wait for the prereq topics to solidify a bit more.


* nd/pack-deltify-regression-fix (2018-07-23) 1 commit
  (merged to 'next' on 2018-08-02 at f3b2bf0fef)
 + pack-objects: fix performance issues on packing large deltas

 In a recent update in 2.18 era, "git pack-objects" started
 producing a larger than necessary packfiles by missing
 opportunities to use large deltas.

 Will cook in 'next'.


* ab/newhash-is-sha256 (2018-08-07) 2 commits
  (merged to 'next' on 2018-08-15 at 2e808d75d3)
 + doc hash-function-transition: pick SHA-256 as NewHash
 + doc hash-function-transition: note the lack of a changelog

 Documentation update.

 Will merge to 'master'.


* jh/structured-logging (2018-07-25) 25 commits
 - structured-logging: add config data facility
 - structured-logging: t0420 tests for interacitve child_summary
 - structured-logging: t0420 tests for child process detail events
 - structured-logging: add child process classification
 - structured-logging: add detail-events for child processes
 - structured-logging: add structured logging to remote-curl
 - structured-logging: t0420 tests for aux-data
 - structured-logging: add aux-data for size of sparse-checkout file
 - structured-logging: add aux-data for index size
 - structured-logging: add aux-data facility
 - structured-logging: t0420 tests for timers
 - structured-logging: add timer around preload_index
 - structured-logging: add timer around wt-status functions
 - structured-logging: add timer around do_write_index
 - structured-logging: add timer around do_read_index
 - structured-logging: add timer facility
 - structured-logging: add detail-event for lazy_init_name_hash
 - structured-logging: add detail-event facility
 - structured-logging: t0420 basic tests
 - structured-logging: set sub_command field for checkout command
 - structured-logging: set sub_command field for branch command
 - structured-logging: add session-id to log events
 - structured-logging: add structured logging framework
 - structured-logging: add STRUCTURED_LOGGING=1 to Makefile
 - structured-logging: design document

 Will merge to 'next'.


* en/abort-df-conflict-fixes (2018-07-31) 2 commits
  (merged to 'next' on 2018-08-08 at a19cad0bb7)
 + read-cache: fix directory/file conflict handling in read_index_unmerged()
 + t1015: demonstrate directory/file conflict recovery failures

 "git merge --abort" etc. did not clean things up properly when
 there were conflicted entries in certain order that are involved
 in D/F conflicts.  This has been corrected.

 Will merge to 'master'.


* jn/gc-auto (2018-07-17) 3 commits
 - gc: do not return error for prior errors in daemonized mode
 - gc: exit with status 128 on failure
 - gc: improve handling of errors reading gc.log

 "gc --auto" ended up calling exit(-1) upon error, which has been
 corrected to use exit(1).  Also the error reporting behaviour when
 daemonized has been updated to exit with zero status when stopping
 due to a previously discovered error (which implies there is no
 point running gc to improve the situation); we used to exit with
 failure in such a case.

 Stuck in review?
 cf. <20180717201348.GD26218@sigill.intra.peff.net>


* sb/submodule-update-in-c (2018-08-14) 7 commits
 - submodule--helper: introduce new update-module-mode helper
 - submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree
 - builtin/submodule--helper: factor out method to update a single submodule
 - builtin/submodule--helper: store update_clone information in a struct
 - builtin/submodule--helper: factor out submodule updating
 - git-submodule.sh: rename unused variables
 - git-submodule.sh: align error reporting for update mode to use path

 "git submodule update" is getting rewritten piece-by-piece into C.

 Will merge to and cook in 'next'.


* tg/rerere (2018-08-06) 11 commits
 - rerere: recalculate conflict ID when unresolved conflict is committed
 - rerere: teach rerere to handle nested conflicts
 - rerere: return strbuf from handle path
 - rerere: factor out handle_conflict function
 - rerere: only return whether a path has conflicts or not
 - rerere: fix crash with files rerere can't handle
 - rerere: add documentation for conflict normalization
 - rerere: mark strings for translation
 - rerere: wrap paths in output in sq
 - rerere: lowercase error messages
 - rerere: unify error messages when read_cache fails

 Fixes to "git rerere" corner cases, especially when conflict
 markers cannot be parsed in the file.

 Will merge to and cook in 'next'.


* ag/rebase-i-in-c (2018-08-10) 20 commits
 - rebase -i: move rebase--helper modes to rebase--interactive
 - rebase -i: remove git-rebase--interactive.sh
 - rebase--interactive2: rewrite the submodes of interactive rebase in C
 - rebase -i: implement the main part of interactive rebase as a builtin
 - rebase -i: rewrite init_basic_state() in C
 - rebase -i: rewrite write_basic_state() in C
 - rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in C
 - rebase -i: implement the logic to initialize $revisions in C
 - rebase -i: remove unused modes and functions
 - rebase -i: rewrite complete_action() in C
 - t3404: todo list with commented-out commands only aborts
 - sequencer: change the way skip_unnecessary_picks() returns its result
 - sequencer: refactor append_todo_help() to write its message to a buffer
 - rebase -i: rewrite checkout_onto() in C
 - rebase -i: rewrite setup_reflog_action() in C
 - sequencer: add a new function to silence a command, except if it fails
 - rebase -i: rewrite the edit-todo functionality in C
 - editor: add a function to launch the sequence editor
 - rebase -i: rewrite append_todo_help() in C
 - sequencer: make three functions and an enum from sequencer.c public

 Rewrite of the remaining "rebase -i" machinery in C.

 Will merge to 'next'.


* js/range-diff (2018-08-13) 21 commits
  (merged to 'next' on 2018-08-15 at 8d56067806)
 + range-diff: use dim/bold cues to improve dual color mode
 + range-diff: make --dual-color the default mode
 + range-diff: left-pad patch numbers
 + completion: support `git range-diff`
 + range-diff: populate the man page
 + range-diff --dual-color: skip white-space warnings
 + range-diff: offer to dual-color the diffs
 + diff: add an internal option to dual-color diffs of diffs
 + color: add the meta color GIT_COLOR_REVERSE
 + range-diff: use color for the commit pairs
 + range-diff: add tests
 + range-diff: do not show "function names" in hunk headers
 + range-diff: adjust the output of the commit pairs
 + range-diff: suppress the diff headers
 + range-diff: indent the diffs just like tbdiff
 + range-diff: right-trim commit messages
 + range-diff: also show the diff between patches
 + range-diff: improve the order of the shown commits
 + range-diff: first rudimentary implementation
 + Introduce `range-diff` to compare iterations of a topic branch
 + linear-assignment: a function to solve least-cost assignment problems
 (this branch is used by es/format-patch-rangediff and sb/range-diff-colors.)

 "git tbdiff" that lets us compare individual patches in two
 iterations of a topic has been rewritten and made into a built-in
 command.

 Will merge to 'master'.


* lt/date-human (2018-07-09) 1 commit
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.


* ot/ref-filter-object-info (2018-07-17) 5 commits
  (merged to 'next' on 2018-08-08 at 9ed619941b)
 + ref-filter: use oid_object_info() to get object
 + ref-filter: merge get_obj and get_object
 + ref-filter: initialize eaten variable
 + ref-filter: fill empty fields with empty values
 + ref-filter: add info_source to valid_atom

 A few atoms like %(objecttype) and %(objectsize) in the format
 specifier of "for-each-ref --format=<format>" can be filled without
 getting the full contents of the object, but just with the object
 header.  These cases have been optimzied by calling
 oid_object_info() API.

 Will merge to 'master'.


* pk/rebase-in-c (2018-08-06) 3 commits
 - builtin/rebase: support running "git rebase <upstream>"
 - rebase: refactor common shell functions into their own file
 - rebase: start implementing it as a builtin
 (this branch is used by pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final.)

 Rewrite of the "rebase" machinery in C.


* jk/branch-l-1-repurpose (2018-06-22) 1 commit
  (merged to 'next' on 2018-08-08 at d2a08dd08e)
 + branch: make "-l" a synonym for "--list"

 Updated plan to repurpose the "-l" option to "git branch".

 Will merge to and cook in 'next'.


* ds/multi-pack-index (2018-07-20) 23 commits
  (merged to 'next' on 2018-08-08 at 1a56c52967)
 + midx: clear midx on repack
 + packfile: skip loading index if in multi-pack-index
 + midx: prevent duplicate packfile loads
 + midx: use midx in approximate_object_count
 + midx: use existing midx when writing new one
 + midx: use midx in abbreviation calculations
 + midx: read objects from multi-pack-index
 + config: create core.multiPackIndex setting
 + midx: write object offsets
 + midx: write object id fanout chunk
 + midx: write object ids in a chunk
 + midx: sort and deduplicate objects from packfiles
 + midx: read pack names into array
 + multi-pack-index: write pack names in chunk
 + multi-pack-index: read packfile list
 + packfile: generalize pack directory list
 + t5319: expand test data
 + multi-pack-index: load into memory
 + midx: write header information to lockfile
 + multi-pack-index: add 'write' verb
 + multi-pack-index: add builtin
 + multi-pack-index: add format details
 + multi-pack-index: add design document

 When there are too many packfiles in a repository (which is not
 recommended), looking up an object in these would require
 consulting many pack .idx files; a new mechanism to have a single
 file that consolidates all of these .idx files is introduced.

 Will merge to and cook in 'next'.

--------------------------------------------------
[Discarded]

* am/sequencer-author-script-fix (2018-07-18) 1 commit
 . sequencer.c: terminate the last line of author-script properly

 The author-script that records the author information created by
 the sequencer machinery lacked the closing single quote on the last
 entry.

 Superseded by another topic.


* jc/push-cas-opt-comment (2018-08-01) 1 commit
 . push: comment on a funny unbalanced option help

 Code clarification.

 Superseded by another topic.


* cc/remote-odb (2018-08-02) 9 commits
 . Documentation/config: add odb.<name>.promisorRemote
 . t0410: test fetching from many promisor remotes
 . Use odb.origin.partialclonefilter instead of core.partialclonefilter
 . Use remote_odb_get_direct() and has_remote_odb()
 . remote-odb: add remote_odb_reinit()
 . remote-odb: implement remote_odb_get_many_direct()
 . remote-odb: implement remote_odb_get_direct()
 . Add initial remote odb support
 . fetch-object: make functions return an error code

 Implement lazy fetches of missing objects to complement the
 experimental partial clone feature.

 Ejected; seems to break existing repositories that use partialclone
 repository extension.

 I haven't seen much interest in this topic on list.  What's the
 doneness of this thing?

 I do not particularly mind adding code to support a niche feature
 as long as it is cleanly made and it is clear that the feature
 won't negatively affect those who do not use it, so a review from
 that point of view may also be appropriate.
