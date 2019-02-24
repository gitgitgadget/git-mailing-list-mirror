Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB7420248
	for <e@80x24.org>; Sun, 24 Feb 2019 18:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfBXSSH (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 13:18:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55361 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfBXSSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 13:18:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so6057273wme.5
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 10:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=nhkTUkhT+8vFmRfkHJmn7AJIn95LMFnVg0D4aVV1cxU=;
        b=LredYiG9djnxzK5FnpsfjWdbyqNGy8UGzAUYdUvbFQbp0kSuaijF7Wd2xRFnOZHueV
         jss3+Irk1yi6Vc1pzHAs0b49cvEGcjcS9Pc8mXmgU4hk4vn6pXn9CU0WW/6zazB99lyD
         RkSsmx1ZH3v/KuuqKCbZtfVE0LXRcxkMeZk8GRlJUfMR3CPqfSq72UHUE23+hESGv72C
         Rb7aZOgFqipssJKazVSzwmjxypSN/zgdGpJfm+3s9x77tAcvPb7mNUBWE/L2uw60sLs7
         bUWx4u1qT8Viyj2zs5j6lz/wjnS/qPqikRBccbbqZCfQK5gCyhIRPomY4X3Ip6rbRdDz
         jZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=nhkTUkhT+8vFmRfkHJmn7AJIn95LMFnVg0D4aVV1cxU=;
        b=GPTGLRrx76LVj498FEmf2rb3tTu+1c9ZbKQ8DrJkWXKL1bkEKyndTMJSOoolwErLhJ
         r50KeGrj1nteCZim9V5/nrWV3AMAQaZEn3LQtcxdo18hobP1xEuewF4f9ktv71kcMJWo
         CkNsKmcw7pSML64EnKcNb+bdWQr7TqCdaEM/wgXTRh2UvaoX9zUMirXizUSeLp+P7gc3
         uuFAacdLh2AgJrnYL21buWMyR4tqFN5jsXO433ASLHo8BIA6esZTWaPCCc9S9+UU8buC
         gvPhgrMXqX59LwQJ8YMzkuOy0zqFJoS3wTuTizMWNpiAJhhAX8cD3RLy99eXnQdCG1OA
         DcYQ==
X-Gm-Message-State: AHQUAuZukC7XiiZLo5dDn1u5lQmK09aVwLrY7GjfJOH8SYT28oyhpCcj
        9v5NrSNtYZm9i7B+g5VZNsT4wyf3M3l2Mg==
X-Google-Smtp-Source: AHgI3Ia4sUvexCgefsY1JoykIe/yXlufyqJxljIs+63dePQR1GrvMqya9viqxadyhZJas+Yezj6Pxg==
X-Received: by 2002:a1c:3d84:: with SMTP id k126mr8365015wma.60.1551032281594;
        Sun, 24 Feb 2019 10:18:01 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d2sm7517478wrq.94.2019.02.24.10.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 10:18:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2019, #04; Sun, 24)
X-master-at: 8104ec994ea3849a968b4667d072fedd1e688642
X-next-at: f09ad664505d66643a151851aa987add29db1009
Date:   Sun, 24 Feb 2019 10:18:00 -0800
Message-ID: <xmqqmumlkq3r.fsf@gitster-ct.c.googlers.com>
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

Git 2.21 has been tagged and pushed out.

I'll be offline for a week, and will reopen the tree for the next
cycle in Asia/Tokyo timezone after that.  Some topics marked as
"Will cook in 'next'" will be merged to 'master' then.  This also is
a good week to nominate the topics that are already in 'next' but
should be kicked back to 'pu' to allow them to be replaced with a
better iteration, instead of piling ugly "oops, that was wrong"
fixes on top.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/bsd-fixes (2019-02-21) 2 commits
  (merged to 'next' on 2019-02-21 at 28d0017056)
 + commit-graph tests: fix cryptic unportable "dd" invocation
 + tests: fix unportable "\?" and "\+" regex syntax

 Test portability fix.


* ab/workaround-dash-bug-in-test (2019-02-13) 1 commit
  (merged to 'next' on 2019-02-13 at c90e329c70)
 + tests: avoid syntax triggering old dash bug

 Test portability fix.


* js/test-tool-gen-nuls (2019-02-19) 2 commits
  (merged to 'next' on 2019-02-19 at 489765a538)
 + tests: teach the test-tool to generate NUL bytes and use it
 + Revert "t5562: replace /dev/zero with a pipe from generate_zero_bytes"
 (this branch is tangled with mk/t5562-no-input-to-too-large-an-input-test.)

 Part 3 of the test update, to rewrite "generate stream of NULs" in C.


* mk/t5562-do-not-reuse-output-files (2019-02-19) 1 commit
  (merged to 'next' on 2019-02-19 at 2978db23ef)
 + t5562: do not reuse output files

 Part 1 of the t5562 breakage fix.


* mk/t5562-no-input-to-too-large-an-input-test (2019-02-19) 2 commits
  (merged to 'next' on 2019-02-19 at 1134c39218)
 + t5562: do not depend on /dev/zero
 + Revert "t5562: replace /dev/zero with a pipe from generate_zero_bytes"
 (this branch is tangled with js/test-tool-gen-nuls.)

 Part 2 of the fix to t5562 regression, to avoid feeding
 http-backend from a pipe.


* yn/checkout-doc-fix (2019-02-23) 1 commit
  (merged to 'next' on 2019-02-23 at d72a40f470)
 + checkout doc: fix an unmatched double-quote pair

 Doc fix.

--------------------------------------------------
[New Topics]

* bp/post-index-change-hook (2019-02-15) 1 commit
  (merged to 'next' on 2019-02-23 at 70cc07cebe)
 + read-cache: add post-index-change hook

 A new hook "post-index-change" is called when the on-disk index
 file changes, which can help e.g. a virtualized working tree
 implementation.

 Will cook in 'next'.


* dl/doc-submodule-wo-subcommand (2019-02-15) 1 commit
  (merged to 'next' on 2019-02-23 at 2f1c1428f1)
 + submodule: document default behavior

 Doc update.

 Will cook in 'next'.


* jk/diff-no-index-initialize (2019-02-24) 1 commit
  (merged to 'next' on 2019-02-24 at f37a814eb0)
 + diff: reuse diff setup for --no-index case

 "git diff --no-index" may still want to access Git goodies like
 --ext-diff and --textconv, but so far these have been ignored,
 which has been corrected.

 Will cook in 'next'.


* jk/prune-optim (2019-02-14) 4 commits
  (merged to 'next' on 2019-02-23 at 7d03afc1c2)
 + t5304: rename "sha1" variables to "oid"
 + prune: check SEEN flag for reachability
 + prune: use bitmaps for reachability traversal
 + prune: lazily perform reachability traversal

 "git prune" has been taught to take advantage of reachability
 bitmap when able.

 Will cook in 'next'.


* jk/unused-params (2019-02-14) 10 commits
  (merged to 'next' on 2019-02-23 at 9b715907a1)
 + ref-filter: drop unused "sz" parameters
 + ref-filter: drop unused "obj" parameters
 + ref-filter: drop unused buf/sz pairs
 + files-backend: drop refs parameter from split_symref_update()
 + pack-objects: drop unused parameter from oe_map_new_pack()
 + merge-recursive: drop several unused parameters
 + diff: drop complete_rewrite parameter from run_external_diff()
 + diff: drop unused emit data parameter from sane_truncate_line()
 + diff: drop unused color reset parameters
 + diff: drop options parameter from diffcore_fix_diff_index()

 Code clean-up.

 Will cook in 'next'.


* jt/http-auth-proto-v2-fix (2019-02-22) 5 commits
  (merged to 'next' on 2019-02-23 at ea87895fa7)
 + remote-curl: use post_rpc() for protocol v2 also
 + remote-curl: refactor reading into rpc_state's buf
 + remote-curl: reduce scope of rpc_state.result
 + remote-curl: reduce scope of rpc_state.stdin_preamble
 + remote-curl: reduce scope of rpc_state.argv

 Unify RPC code for smart http in protocol v0/v1 and v2, which fixes
 a bug in the latter (lack of authentication retry) and generally
 improves the code base.

 Will cook in 'next'.


* en/merge-options-doc (2019-02-21) 1 commit
  (merged to 'next' on 2019-02-23 at 2eb5263dab)
 + merge-options.txt: correct wording of --no-commit option

 Doc update.

 Will cook in 'next'.


* ab/receive-pack-use-after-free-fix (2019-02-20) 1 commit
  (merged to 'next' on 2019-02-23 at 3f41dfe375)
 + receive-pack: fix use-after-free bug

 Memfix.

 Will cook in 'next'.


* nd/diff-parseopt-2 (2019-02-21) 21 commits
  (merged to 'next' on 2019-02-23 at 6f11d0af54)
 + diff-parseopt: convert --ignore-some-changes
 + diff-parseopt: convert --[no-]minimal
 + diff-parseopt: convert --relative
 + diff-parseopt: convert --no-renames|--[no--rename-empty
 + diff-parseopt: convert --find-copies-harder
 + diff-parseopt: convert -C|--find-copies
 + diff-parseopt: convert -D|--irreversible-delete
 + diff-parseopt: convert -M|--find-renames
 + diff-parseopt: convert -B|--break-rewrites
 + diff-parseopt: convert --output-*
 + diff-parseopt: convert --[no-]compact-summary
 + diff-parseopt: convert --stat*
 + diff-parseopt: convert -s|--no-patch
 + diff-parseopt: convert --name-status
 + diff-parseopt: convert --name-only
 + diff-parseopt: convert --patch-with-stat
 + diff-parseopt: convert --summary
 + diff-parseopt: convert --check
 + diff-parseopt: convert --dirstat and friends
 + diff-parseopt: convert --numstat and --shortstat
 + diff-parseopt: convert --patch-with-raw
 (this branch uses nd/diff-parseopt.)

 Second batch to teach the diff machinery to use the parse-options
 API.

 Will cook in 'next'.


* jc/format-patch-error-check (2019-02-22) 3 commits
 - format-patch: --no-clobber refrains from overwriting output files
 - format-patch: notice failure to open cover letter for writing
 - builtin/log: downcase the beginning of error messages


* nd/completion-more-parameters (2019-02-20) 1 commit
  (merged to 'next' on 2019-02-23 at 23133710f7)
 + completion: add more parameter value completion

 The command line completion (in contrib/) has been taught to
 complete more subcommand parameters.

 Will cook in 'next'.


* nd/no-more-check-racy (2019-02-22) 1 commit
  (merged to 'next' on 2019-02-23 at eda76b8f46)
 + Delete check-racy.c

 Unused code removal.

 Will cook in 'next'.


* rd/doc-hook-used-in-sample (2019-02-21) 1 commit
  (merged to 'next' on 2019-02-23 at e521400a66)
 + mention use of "hooks.allownonascii" in "man githooks"

 Doc update.

 Will merge to 'master'.


* ab/makefile-help-devs-more (2019-02-24) 6 commits
 - Makefile: allow for combining DEVELOPER=1 and CFLAGS="..."
 - Makefile: move the setting of *FLAGS closer to "include"
 - Makefile: Move *_LIBS assignment into its own section
 - Makefile: add/remove comments at top and tweak whitespace
 - Makefile: move "strip" assignment down from flags
 - Makefile: remove an out-of-date comment

 CFLAGS now can be tweked when invoking Make while using
 DEVELOPER=YesPlease; this did not work well before.


* jt/fetch-cdn-offload (2019-02-24) 8 commits
 - SQUASH???
 - upload-pack: send part of packfile response as uri
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http: improve documentation of http_pack_request
 - http: use --stdin and --keep when downloading pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).

--------------------------------------------------
[Cooking]

* dl/submodule-set-branch (2019-02-08) 3 commits
 - submodule: teach set-branch subcommand
 - submodule--helper: teach config subcommand --unset
 - git-submodule.txt: "--branch <branch>" option defaults to 'master'

 "git submodule" learns "set-branch" subcommand that allows the
 submodule.*.branch settings to be modified.

 Need to attach sign-off; other than that it seems OK to be in 'next'.


* jc/test-yes-doc (2019-02-11) 1 commit
  (merged to 'next' on 2019-02-13 at cffac01759)
 + test: caution on our version of 'yes'

 Test doc update.

 Will cook in 'next'.


* nd/split-index-null-base-fix (2019-02-13) 1 commit
  (merged to 'next' on 2019-02-13 at c404a19b7a)
 + read-cache.c: fix writing "link" index ext with null base oid

 Split-index fix.

 Will cook in 'next'.


* rj/prune-packed-excess-args (2019-02-11) 1 commit
  (merged to 'next' on 2019-02-13 at e026a2e7a7)
 + prune-packed: check for too many arguments

 "git prune-packed" did not notice and complain against excess
 arguments given from the command line, which now it does.

 Will cook in 'next'.


* js/doc-symref-in-proto-v1 (2019-02-21) 1 commit
  (merged to 'next' on 2019-02-21 at c7ca3bb974)
 + protocol-capabilities.txt: document symref

 Will cook in 'next'.


* dl/complete-submodule-absorbgitdirs (2019-02-06) 1 commit
  (merged to 'next' on 2019-02-06 at c4e0cd535a)
 + completion: complete git submodule absorbgitdirs

 Command-line completion (in contrib/) learned to tab-complete the
 "git submodule absorbgitdirs" subcommand.

 Will cook in 'next'.


* jt/test-protocol-version (2019-02-06) 8 commits
 - t5552: compensate for v2 filtering ref adv.
 - tests: fix protocol version for overspecifications
 - t5700: only run with protocol version 1
 - t5512: compensate for v0 only sending HEAD symrefs
 - t5503: fix overspecification of trace expectation
 - tests: always test fetch of unreachable with v0
 - tests: define GIT_TEST_PROTOCOL_VERSION
 - Merge branch 'js/protocol-advertise-multi' into jt/test-protocol-version
 (this branch uses js/protocol-advertise-multi.)

 Help developers by making it easier to run most of the tests under
 different versions of over-the-wire protocols.

 Blocked by js/protocol-advertise-multi


* dm/some-stdio-functions-are-macro-on-freebsd (2019-02-01) 1 commit
 - http: cast result to FILE *

 Variants of BSD define fileno(fh) as a macro, breaking a program
 that passes a "void *" to it.

 Expecting a reroll.
 cf. <49B9198C-53E5-42BD-8834-B1EDEB3332CB@usask.ca>


* en/combined-all-paths (2019-02-07) 1 commit
  (merged to 'next' on 2019-02-08 at 7057f38d6e)
 + log,diff-tree: add --combined-all-paths option

 Output from "diff --cc" did not show the original paths when the
 merge involved renames.  A new option adds the paths in the
 original trees to the output.

 Will cook in 'next'.


* ds/commit-graph-format-v2 (2019-01-29) 8 commits
 - SQUASH : misnamed variables and style fix
 - commit-graph: test verifying a corrupt v2 header
 - commit-graph: implement file format version 2
 - commit-graph: add --version=<n> option
 - commit-graph: create new version flags
 - commit-graph: collapse parameters into flags
 - commit-graph: return with errors during write
 - Merge branch 'bc/sha-256' into ds/commit-graph-format-v2

 Introduce version 2 of the commit-graph format to correct
 deficiency in the initial version.

 Needs update before merging to 'next'.


* jh/trace2 (2019-02-22) 15 commits
  (merged to 'next' on 2019-02-22 at 4c84c621fe)
 + trace2: add for_each macros to clang-format
 + trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
 + trace2:data: add subverb for rebase
 + trace2:data: add subverb to reset command
 + trace2:data: add subverb to checkout command
 + trace2:data: pack-objects: add trace2 regions
 + trace2:data: add trace2 instrumentation to index read/write
 + trace2:data: add trace2 hook classification
 + trace2:data: add trace2 transport child classification
 + trace2:data: add trace2 sub-process classification
 + trace2:data: add editor/pager child classification
 + trace2:data: add trace2 regions to wt-status
 + trace2: collect Windows-specific process information
 + trace2: create new combined trace facility
 + trace2: Documentation/technical/api-trace2.txt

 A more structured way to obtain execution trace has been added.

 Will cook in 'next'.


* sx/evolve (2019-02-15) 8 commits
 . evolve: add the git change list command
 . evolve: implement the git change command
 . evolve: add support for writing metacommits
 . evolve: add the change-table structure
 . evolve: add support for parsing metacommits
 . ref-filter: add the metas namespace to ref-filter
 . sha1-array: implement oid_array_readonly_contains
 . technical doc: add a design doc for the evolve command

 The beginning of "hg evolve" mimicry.


* br/blame-ignore (2019-02-13) 6 commits
 - SQUASH???
 - blame: add tests for ignoring revisions
 - blame: add a config option to mark ignored lines
 - blame: add the ability to ignore commits and their changes
 - blame: use a helper function in blame_chunk()
 - Move init_skiplist() outside of fsck

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Needs update before merging to 'next'.


* nd/diff-parseopt (2019-01-27) 14 commits
  (merged to 'next' on 2019-02-05 at 7c4b79aa79)
 + diff.c: convert --raw
 + diff.c: convert -W|--[no-]function-context
 + diff.c: convert -U|--unified
 + diff.c: convert -u|-p|--patch
 + diff.c: prepare to use parse_options() for parsing
 + diff.h: avoid bit fields in struct diff_flags
 + diff.h: keep forward struct declarations sorted
 + parse-options: allow ll_callback with OPTION_CALLBACK
 + parse-options: avoid magic return codes
 + parse-options: stop abusing 'callback' for lowlevel callbacks
 + parse-options: add OPT_BITOP()
 + parse-options: disable option abbreviation with PARSE_OPT_KEEP_UNKNOWN
 + parse-options: add one-shot mode
 + parse-options.h: remove extern on function prototypes
 (this branch is used by nd/diff-parseopt-2.)

 The diff machinery, one of the oldest parts of the system, which
 long predates the parse-options API, uses fairly long and complex
 handcrafted option parser.  This is being rewritten to use the
 parse-options API.

 Will cook in 'next'.
 Looking good.


* sc/pack-redundant (2019-02-04) 6 commits
  (merged to 'next' on 2019-02-08 at ba3f8f0bc0)
 + pack-redundant: consistent sort method
 + pack-redundant: rename pack_list.all_objects
 + pack-redundant: new algorithm to find min packs
 + pack-redundant: delete redundant code
 + pack-redundant: delay creation of unique_objects
 + t5323: test cases for git-pack-redundant

 Update the implementation of pack-redundant for performance in a
 repository with many packfiles.

 Will cook in 'next'.


* nd/config-move-to (2019-01-14) 7 commits
 - config.h: fix hdr-check warnings
 - config: add --move-to
 - config: factor out set_config_source_file()
 - config: use OPT_FILENAME()
 - config.c: add repo_config_set_worktree_gently()
 - worktree.c: add get_worktree_config()
 - config.c: avoid git_path() in do_git_config_sequence()

 Needs review.


* ma/clear-repository-format (2019-01-23) 2 commits
 - setup: fix memory leaks with `struct repository_format`
 - setup: free old value before setting `work_tree`

 The setup code has been cleaned up to avoid leaks around the
 repository_format structure.

 cf. <20190124001450.GR423984@genre.crustytoothpaste.net>


* wh/author-committer-ident-config (2019-02-04) 1 commit
  (merged to 'next' on 2019-02-06 at 6ab8bfa199)
 + config: allow giving separate author and committer idents

 Four new configuration variables {author,committer}.{name,email}
 have been introduced to override user.{name,email} in more specific
 cases.

 Will cook in 'next'.


* ds/midx-expire-repack (2019-01-27) 10 commits
 - midx: add test that 'expire' respects .keep files
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


* tg/checkout-no-overlay (2019-02-04) 9 commits
  (merged to 'next' on 2019-02-04 at 9968bcf4fb)
 + revert "checkout: introduce checkout.overlayMode config"
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

 Will hold.
 Waiting for "restore-files" & "switch-branches" pair.
 cf. <20190205204208.GC6085@hank.intra.tgummerer.com>


* dl/merge-cleanup-scissors-fix (2019-01-27) 4 commits
  (merged to 'next' on 2019-02-06 at f4fe5d759a)
 + merge: add scissors line on merge conflict
 + merge: cleanup messages like commit
 + t7600: clean up 'merge --squash c3 with c7' test
 + commit: extract cleanup_mode functions to sequencer

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Will cook in 'next'.


* aw/pretty-trailers (2019-01-29) 7 commits
  (merged to 'next' on 2019-02-06 at b7e5437702)
 + pretty: add support for separator option in %(trailers)
 + strbuf: separate callback for strbuf_expand:ing literals
 + pretty: add support for "valueonly" option in %(trailers)
 + pretty: allow showing specific trailers
 + pretty: single return path in %(trailers) handling
 + pretty: allow %(trailers) options with explicit value
 + doc: group pretty-format.txt placeholders descriptions

 The %(trailers) formatter in "git log --format=..."  now allows to
 optionally pick trailers selectively by keyword, show only values,
 etc.

 Will cook in 'next'.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 I am personally not yet quite convinced if this is worth pursuing.


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions
 (this branch is used by jt/test-protocol-version.)

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>


* nb/branch-show-other-worktrees-head (2019-02-01) 3 commits
 - branch: add an extra verbose output displaying worktree path for refs checked out in a linked worktree
 - branch: mark and color a branch differently if it is checked out in a linked worktree
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 The top one probably deserves retitling.
 The second one is of dubious value.


* du/branch-show-current (2018-10-26) 1 commit
  (merged to 'next' on 2019-02-08 at e662ed4aee)
 + branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 Will cook in 'next'.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* ag/sequencer-reduce-rewriting-todo (2019-01-29) 16 commits
 - rebase--interactive: move transform_todo_file() to rebase--interactive.c
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

 Was still being worked on, but seems to have stalled.
 cf. <c5e3c1cc-12fa-ddf6-7008-ae47659ddc19@gmail.com>
 cf. <97f77aca-bd19-f763-349a-de40c4b94161@talktalk.net>


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ps/stash-in-c (2019-02-04) 29 commits
 - strbuf_vinsertf: provide the correct buffer size to vsnprintf
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

 Still with known breakages.
 cf. <20190208113059.GV10587@szeder.dev>


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
