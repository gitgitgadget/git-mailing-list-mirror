Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFEA41F453
	for <e@80x24.org>; Thu, 14 Feb 2019 03:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404944AbfBNDd0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 22:33:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43227 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfBNDd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 22:33:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id r2so4809763wrv.10
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 19:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=OdC8O13YFaeMdZ1bOjtSKX2rVz1SKoa0rhrsbPVAdFs=;
        b=GO/mRsgEhnJTkOcB9Jwy/XURmW6ohauxcqgOsVkwAAMZYeYAYMGcsB3dtNYUgu77BW
         WcBnw2TYqPOm84tf8NJxpOgifLIaVtfulFDucSNBtYV6XpVVkjj+5lIZvZrpT7yx345/
         J/qbykSrnj0//NlfywJSCFBX1EVqHDRQVEy27lkPTVT5LWCdrY2P2ZeL4YmHqEQollQi
         4bL/rEhwg0E7LizNYQJL2ZvnDFjjx0FLLj/4XiVoiA3Y6DiapQ5pwJhnVP6R5w42b+HX
         zjJStuwuOONTtdA5L/tBKnCoY5ibq219GG5n2myly8blsN6hnrIdsWuuemAwTXftGB4h
         gSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=OdC8O13YFaeMdZ1bOjtSKX2rVz1SKoa0rhrsbPVAdFs=;
        b=OQqVjnVg9I18FUiORuMoHHibKs4YwYyJTr6VDdV1YmuMrXyZBAEEfzMneXAFkidycb
         PGV9Av5fMmPz6bff9t6iA/UK4DgjWCoga/e463mwEmH6X/yWlR69Qx62GzrZuMacGmCc
         XU5BxvJV98+TP+Pwjljja/ieq4byz8zQhd0iv8ma0NFzDYr4sMcCwmxRZT5kw/5DiWOk
         vgtX8qPAK3l6zOrNSSLqWjysjXNEW5bitwADf4WMrrapyUiq7bDTKFL3lpcoQevXBkTC
         gLeIyJJ6RdKa845nPpGD90vm2gVaeaI13kHUt3c17AFjv1K9i5caQ8A5KmMoN1EWH9rz
         aRcg==
X-Gm-Message-State: AHQUAuYEv1tLgwT4sYSxuV3qxc20hxA8joG1nAtTFOHHbnPQ+BPopmYZ
        MtB9vEhCcm0S2BwgOnIS8jxIu/J9
X-Google-Smtp-Source: AHgI3IYMjpHQ0AQVcu4mDM1UmAd3UtgxaJzIEPW9Kg4tfbk7j3AELchfw5rUszEf40QYpESNbwbgbw==
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr840646wrs.94.1550115203159;
        Wed, 13 Feb 2019 19:33:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b14sm1323297wrx.36.2019.02.13.19.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 19:33:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2019, #03; Wed, 13)
X-master-at: 8989e1950a845ceeb186d490321a4f917ca4de47
X-next-at: 12f185b1dd353fa64489f4c47ca0d58b4aa858f8
Date:   Wed, 13 Feb 2019 19:33:22 -0800
Message-ID: <xmqq4l979h8d.fsf@gitster-ct.c.googlers.com>
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

The first release candidate for the upcoming Git 2.21 has been
tagged and pushed out.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/utf16-portability-fix (2019-02-11) 1 commit
  (merged to 'next' on 2019-02-11 at a33208b3)
 + utf8: handle systems that don't write BOM for UTF-16

 The code and tests assume that the system supplied iconv() would
 always use BOM in its output when asked to encode to UTF-16 (or
 UTF-32), but apparently some implementations output big-endian
 without BOM.  A compile-time knob has been added to help such
 systems (e.g. NonStop) to add BOM to the output to increase
 portability.


* ds/coverage-prove (2019-01-29) 1 commit
  (merged to 'next' on 2019-02-06 at 0fc57228ec)
 + Makefile: add coverage-prove target

 A new target "coverage-prove" to run the coverage test under
 "prove" has been added.


* js/fuzz-commit-graph-update (2019-02-07) 2 commits
  (merged to 'next' on 2019-02-07 at 689019b0ca)
 + object: fix leak of shallow_stat
 + fuzz-commit-graph: initialize repo object

 Update to the fuzzer.


* js/mingw-host-cpu (2019-02-07) 1 commit
  (merged to 'next' on 2019-02-07 at cbd8634816)
 + mingw: fix CPU reporting in `git version --build-options`

 Windows update.


* js/rebase-i-redo-exec-fix (2019-02-06) 1 commit
  (merged to 'next' on 2019-02-06 at 9f99bee768)
 + Revert "rebase: introduce a shortcut for --reschedule-failed-exec"

 For "rebase -i --reschedule-failed-exec", we do not want the "-y"
 shortcut after all.


* js/smart-http-detect-remote-error (2019-02-06) 3 commits
  (merged to 'next' on 2019-02-06 at ec1a6f67c1)
 + t5551: test server-side ERR packet
 + remote-curl: tighten "version 2" check for smart-http
 + remote-curl: refactor smart-http discovery

 Some errors from the other side coming over smart HTTP transport
 were not noticed, which has been corrected.


* kd/t0028-octal-del-is-377-not-777 (2019-02-11) 1 commit
  (merged to 'next' on 2019-02-11 at 1e1ee7e15d)
 + t0028: fix wrong octal values for BOM in setup

 Test fix.


* kl/pretty-doc-markup-fix (2019-02-07) 1 commit
  (merged to 'next' on 2019-02-07 at c01e44520b)
 + doc: prevent overflowing <code> tag in rendered HTML

 Doc update.


* ld/git-p4-remove-flakey-test (2019-02-06) 1 commit
  (merged to 'next' on 2019-02-06 at 0100bce8b6)
 + git-p4: remove ticket expiry test

 A flakey "p4" test has been removed.


* nd/checkout-noisy-unmerge (2019-02-06) 2 commits
  (merged to 'next' on 2019-02-06 at 7fe9bd5b4e)
 + checkout: count and print -m paths separately
 + checkout: update count-checkouts messages

 "git checkout [<tree-ish>] <pathspec>" started reporting the number
 of paths that have got updated recently, but the same messages were
 given when "git checkout -m <pathspec>" to unresolve conflicts that
 have just been resolved.  The message now reports these unresolved
 paths separately from the paths that are checked out from the index.


* os/rebase-runs-post-checkout-hook (2019-02-08) 1 commit
  (merged to 'next' on 2019-02-08 at da96987286)
 + t5403: correct bash ambiguous redirect error in subtest 8 by quoting $GIT_DIR

 Test fix.


* rj/sequencer-sign-off-header-static (2019-02-11) 1 commit
 + sequencer: make sign_off_header a file local symbol

 Code clean-up.


* sg/ci-parallel-build (2019-02-07) 2 commits
  (merged to 'next' on 2019-02-07 at 8cffe5a338)
 + ci: clear and mark MAKEFLAGS exported just once
 + ci: make sure we build Git parallel

 Build update.


* sg/stress-test (2019-02-11) 2 commits
  (merged to 'next' on 2019-02-11 at 1a5d4a249d)
 + test-lib: fix non-portable pattern bracket expressions
  (merged to 'next' on 2019-02-08 at c45c47bd7c)
 + test-lib: make '--stress' more bisect-friendly

 Test improvement.


* tz/gpg-test-fix (2019-02-08) 2 commits
  (merged to 'next' on 2019-02-08 at 72d7fc8099)
 + t/lib-gpg: drop redundant killing of gpg-agent
 + t/lib-gpg: quote path to ${GNUPGHOME}/trustlist.txt

 Test fix.

--------------------------------------------------
[New Topics]

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


* ab/workaround-dash-bug-in-test (2019-02-13) 1 commit
  (merged to 'next' on 2019-02-13 at c90e329c70)
 + tests: avoid syntax triggering old dash bug


* js/doc-symref-in-proto-v1 (2019-02-13) 1 commit
  (merged to 'next' on 2019-02-13 at 63b673d2a6)
 + protocol-capabilities.txt: document symref

--------------------------------------------------
[Cooking]

* dl/complete-submodule-absorbgitdirs (2019-02-06) 1 commit
  (merged to 'next' on 2019-02-06 at c4e0cd535a)
 + completion: complete git submodule absorbgitdirs

 Command-line completion (in contrib/) learned to tab-complete the
 "git submodule absorbgitdirs" subcommand.

 Will cook in 'next'.


* jt/test-protocol-version (2019-02-06) 9 commits
 - remote-curl: in v2, fill credentials if needed
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


* jh/trace2 (2019-02-11) 16 commits
  (merged to 'next' on 2019-02-11 at 25fb2164ff)
 + fixup! trace2: collect Windows-specific process information
  (merged to 'next' on 2019-02-08 at 0253db7fff)
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


* sx/evolve (2019-01-27) 8 commits
 . evolve: add the 'git change list' command
 . evolve: implement the 'git change' command
 . evolve: add support for writing metacommits
 . evolve: add the change-table structure
 . evolve: add support for parsing metacommits
 . ref-filter: add the metas namespace to ref-filter
 . sha1-array: implement oid_array_readonly_contains()
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

 The diff machinery, one of the oldest parts of the system, which
 long predates the parse-options API, uses fairly long and complex
 handcrafted option parser.  This is being rewritten to use the
 parse-options API.

 Will cook in 'next', waiting for the remainder.
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

 Still being worked on.
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
