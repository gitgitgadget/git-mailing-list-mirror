Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC82A20248
	for <e@80x24.org>; Wed,  6 Mar 2019 01:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfCFBeZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 20:34:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40352 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfCFBeY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 20:34:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id g20so4275905wmh.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 17:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=aSGCg4uhY975xi3YJchA1UZqjB0ySo8h4Z/FI5QIUVQ=;
        b=JVxJ4yGSV/84SUFkBhp57W6W6s3g0mR8Xz9JIMWUxkqqIV89WbX9f5A5GmS9jxFIU8
         EusvJWszKI5uR7wA3NjTG/amc7ZvRsdsID58FBR2jIe9r/JGDRdsRCpz7yyutFyuGDUg
         BJX22KSoEFNW6gZbNRqjXzyDNjloBBiEJ9PfIiKrNPTbO81RdVj2kOZ5rbRyANKNDP4F
         T2Vz1Y+sy1zB4O54MKmkjjmTDpCWn2hkNMMLwH2fX7/0zYTmVgIoKnNrSTQ4pa9yRQGW
         Vw/D0gqzzCSCue24XepSjDC2+/OjDsSQhUH340Tcwb7tG34xbL6frlwID+lALvmBSnAt
         /Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=aSGCg4uhY975xi3YJchA1UZqjB0ySo8h4Z/FI5QIUVQ=;
        b=dqUs50HyW1I1zgheM4YsEjGrlw4c8A58WCAJWHpwl2tztcVLKd4iwTD5efBxF1WNg5
         Aqh0Cl9bogTXHfIvXJCM+KHxOB6ztxugi/2jtB5ZQ3H8KmFm7jIbh407e1ziB0+hguZ6
         HQnGBDuNqvoH5+eAAufTb7ZX4FhSwJ+9SFnsrL+svSFBNds8LZroTG3jOx79iY06FksG
         jJrWhAO3Khn0Zfcdim55LNjbK5OvKrZpKJK2iPD1oGWYXQSeSyFxPbiufb4OQzp693Rv
         SYxzAjtgSyZ29bCHSFv5sQHYYz24KUEz2MiTeMROZ7WkNRVKlhHaxcBCHJP5A3CiGp7L
         xMKg==
X-Gm-Message-State: APjAAAVaCW3LaehRJ9zjZHU1zP7Stur7ItsjdOQRjyAnCNEgtR2wKn4z
        st7qd0JJ4ycaH7Sla7bzCAiLHHX2pQU8iPyW
X-Google-Smtp-Source: APXvYqwok7PPOS4nW8CnVQ+o41me/+Y49Y0nQZ7CFY16X74yCLvF3K8Mgr5ggI5RKpLgaOj6t7IIzw==
X-Received: by 2002:a1c:9c04:: with SMTP id f4mr695260wme.149.1551836060013;
        Tue, 05 Mar 2019 17:34:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d9sm396200wrn.72.2019.03.05.17.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 17:34:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2019, #01; Wed, 6)
X-master-at: 36eb1cb9cfe327583128a4b0abdf9516c2ca815b
X-next-at: 471c308f928be87428876934301e2b25cb242d19
Date:   Wed, 06 Mar 2019 10:34:18 +0900
Message-ID: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


What's cooking in git.git (Mar 2019, #01; Wed, 6)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The maintenance track will be updated to preprare for 2.21.1 soonish,
to address breakages with certain versions of msgfmt in 2.21.0; the
tip of 'next' will also be updated at around the same time.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jk/bisect-final-output (2019-03-01) 3 commits
 - bisect: make diff-tree output prettier
 - bisect: fix internal diff-tree config loading
 - bisect: use string arguments to feed internal diff-tree

 The final report from "git bisect" used to show the suspected
 culprit using a raw "diff-tree", with which there is no output for
 a merge commit.  This has been updated to use a more modern and
 human readable output that still is concise enough.

 Will merge to 'next'.


* jk/fsck-doc (2019-03-05) 2 commits
 - fsck: always compute USED flags for unreachable objects
 - doc/fsck: clarify --connectivity-only behavior

 "git fsck --connectivity-only" omits computation necessary to sift
 the objects that are not reachable from any of the refs into
 unreachable and dangling.  This is now documented, and also the
 computation is done in order to show the dangling objects when
 requested (which is done by default, but can be overridden with
 the "--no-dangling" option).

 Will merge to 'next'.


* jk/no-sigpipe-during-network-transport (2019-03-05) 2 commits
 - fetch: ignore SIGPIPE during network operation
 - fetch: avoid calling write_or_die()

 On platforms where "git fetch" is killed with SIGPIPE (e.g. OSX),
 the upload-pack that runs on the other end that hangs up after
 detecting an error could cause "git fetch" to die with a signal,
 which led to a flakey test.  "git fetch" now ignores SIGPIPE during
 the network portion of its operation (this is not a problem as we
 check the return status from our write(2)s).

 Will merge to 'next'.


* jk/virtual-objects-do-exist (2019-03-05) 1 commit
 - rev-list: allow cached objects in existence check

 A recent update broke "is this object available to us?" check for
 well-known objects like an empty tree (which should yield "yes",
 even when there is no on-disk object for an empty tree), which has
 been corrected.

 Will merge to 'next'.


* js/anonymize-remote-curl-diag (2019-03-06) 2 commits
 - remote-curl: mark all error messages for translation
 - curl: anonymize URLs in error messages and warnings

 remote-http transport did not anonymize URLs reported in its error
 messages at places.

 Will merge to 'next' the bottom one.
 The i18n of die() messages conflicts with topics in flight, so will
 be dealt with separately when the tree is more quiescent.


* js/find-lib-h-with-ls-files-when-possible (2019-03-05) 1 commit
 - Makefile: use `git ls-files` to list header files, if possible

 The Makefile uses 'find' utility to enumerate all the *.h header
 files, which is expensive on platforms with slow filesystems; it
 now optionally uses "ls-files" if working within a repository,
 which is a trick similar to how all sources are enumerated to run
 ETAGS on.

 Will merge to 'next'.


* js/rebase-orig-head-fix (2019-03-04) 4 commits
 - built-in rebase: set ORIG_HEAD just once, before the rebase
 - built-in rebase: demonstrate that ORIG_HEAD is not set correctly
 - built-in rebase: use the correct reflog when switching branches
 - built-in rebase: no need to check out `onto` twice

 "gir rebase" that was reimplemented in C did not set ORIG_HEAD
 correctly, which has been corrected.

 Will merge to 'next'.


* js/rebase-recreate-merge (2019-03-01) 1 commit
 - rebase docs: fix "gitlink" typo

 Docfix.

 Will merge to 'next'.


* js/stress-test-ui-tweak (2019-03-04) 2 commits
 - tests: introduce --stress-jobs=<N>
 - tests: let --stress-limit=<N> imply --stress

 Dev support.

 Will merge to 'next'.


* js/untravis-windows (2019-03-01) 1 commit
 - travis: remove the hack to build the Windows job on Azure Pipelines

 Dev support.

 Will merge to 'next'.


* ma/asciidoctor-fixes (2019-03-01) 3 commits
 - asciidoctor-extensions: fix spurious space after linkgit
 - Documentation/Makefile: add missing dependency on asciidoctor-extensions
 - Documentation/Makefile: add missing xsl dependencies for manpages

 Build fix around use of asciidoctor instead of asciidoc

 Will merge to 'next'.


* nd/worktree-name-sanitization (2019-03-01) 1 commit
 - worktree add: sanitize worktree names

 Need to pick up a newer version.


* ra/t3600-test-path-funcs (2019-03-04) 3 commits
 - t3600: use helpers to replace test -d/f/e/s <path>
 - t3600: restructure code according to contemporary guidelines
 - test functions: add function `test_file_not_empty`

 A GSoC micro.

 Need to pick up a newer version.


* rd/gc-prune-doc-fix (2019-03-03) 1 commit
 - docs/git-gc: fix typo "--prune=all" to "--prune=now"

 Doxfix.

 Will merge to 'next'.


* dl/reset-doc-no-wrt-abbrev (2019-03-06) 1 commit
 - git-reset.txt: clarify documentation


* ja/dir-rename-doc-markup-fix (2019-03-06) 1 commit
 - Doc: fix misleading asciidoc formating

--------------------------------------------------
[Stalled]

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


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions
 (this branch is used by jt/test-protocol-version.)

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.


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

--------------------------------------------------
[Cooking]

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

 Will merge to 'master'.


* jc/format-patch-error-check (2019-02-22) 3 commits
 - format-patch: --no-clobber refrains from overwriting output files
 - format-patch: notice failure to open cover letter for writing
 - builtin/log: downcase the beginning of error messages

 "git format-patch" used overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Will merge to 'next' after dropping the tip commit.
 I think the bottom two were indenendently good changes; the top one
 was met with "Meh" by reviewer(s), and I tend to agree.


* jk/diff-no-index-initialize (2019-02-24) 1 commit
  (merged to 'next' on 2019-02-24 at f37a814eb0)
 + diff: reuse diff setup for --no-index case

 "git diff --no-index" may still want to access Git goodies like
 --ext-diff and --textconv, but so far these have been ignored,
 which has been corrected.

 Will merge to 'master'.


* jk/prune-optim (2019-02-14) 4 commits
  (merged to 'next' on 2019-02-23 at 7d03afc1c2)
 + t5304: rename "sha1" variables to "oid"
 + prune: check SEEN flag for reachability
 + prune: use bitmaps for reachability traversal
 + prune: lazily perform reachability traversal

 "git prune" has been taught to take advantage of reachability
 bitmap when able.

 Will merge to 'master'.


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

 Will merge to 'master'.


* jt/http-auth-proto-v2-fix (2019-03-03) 5 commits
  (merged to 'next' on 2019-03-03 at d0fdc53f3a)
 + remote-curl: use post_rpc() for protocol v2 also
 + remote-curl: refactor reading into rpc_state's buf
 + remote-curl: reduce scope of rpc_state.result
 + remote-curl: reduce scope of rpc_state.stdin_preamble
 + remote-curl: reduce scope of rpc_state.argv

 Unify RPC code for smart http in protocol v0/v1 and v2, which fixes
 a bug in the latter (lack of authentication retry) and generally
 improves the code base.

 Will merge to 'master'.


* en/merge-options-doc (2019-02-21) 1 commit
  (merged to 'next' on 2019-02-23 at 2eb5263dab)
 + merge-options.txt: correct wording of --no-commit option

 Doc update.

 Will merge to 'master'.


* ab/receive-pack-use-after-free-fix (2019-02-20) 1 commit
  (merged to 'next' on 2019-02-23 at 3f41dfe375)
 + receive-pack: fix use-after-free bug

 Memfix.

 Will merge to 'master'.


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

 Will merge to 'master'.


* nd/completion-more-parameters (2019-02-20) 1 commit
  (merged to 'next' on 2019-02-23 at 23133710f7)
 + completion: add more parameter value completion

 The command line completion (in contrib/) has been taught to
 complete more subcommand parameters.

 Will merge to 'master'.


* nd/no-more-check-racy (2019-02-22) 1 commit
  (merged to 'next' on 2019-02-23 at eda76b8f46)
 + Delete check-racy.c

 Unused code removal.

 Will merge to 'master'.


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

 Will merge to 'next'.


* jt/fetch-cdn-offload (2019-03-01) 9 commits
 - fixup! upload-pack: refactor reading of pack-objects out
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

 Will merge to 'master'.


* nd/split-index-null-base-fix (2019-02-13) 1 commit
  (merged to 'next' on 2019-02-13 at c404a19b7a)
 + read-cache.c: fix writing "link" index ext with null base oid

 Split-index fix.

 Will merge to 'master'.


* rj/prune-packed-excess-args (2019-02-11) 1 commit
  (merged to 'next' on 2019-02-13 at e026a2e7a7)
 + prune-packed: check for too many arguments

 "git prune-packed" did not notice and complain against excess
 arguments given from the command line, which now it does.

 Will merge to 'master'.


* js/doc-symref-in-proto-v1 (2019-02-21) 1 commit
  (merged to 'next' on 2019-02-21 at c7ca3bb974)
 + protocol-capabilities.txt: document symref

 Doc update.

 Will merge to 'master'.


* dl/complete-submodule-absorbgitdirs (2019-02-06) 1 commit
  (merged to 'next' on 2019-02-06 at c4e0cd535a)
 + completion: complete git submodule absorbgitdirs

 Command-line completion (in contrib/) learned to tab-complete the
 "git submodule absorbgitdirs" subcommand.

 Will merge to 'master'.


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

 Will merge to 'master'.


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

 Will merge to 'master'.


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

 Will merge to 'master'.


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


* ma/clear-repository-format (2019-03-01) 2 commits
 - setup: fix memory leaks with `struct repository_format`
 - setup: free old value before setting `work_tree`

 The setup code has been cleaned up to avoid leaks around the
 repository_format structure.

 Will merge to 'next'.


* wh/author-committer-ident-config (2019-02-04) 1 commit
  (merged to 'next' on 2019-02-06 at 6ab8bfa199)
 + config: allow giving separate author and committer idents

 Four new configuration variables {author,committer}.{name,email}
 have been introduced to override user.{name,email} in more specific
 cases.

 Will merge to 'master'.


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

 Will merge to 'master'.


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

 Will merge to 'master'.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* du/branch-show-current (2018-10-26) 1 commit
  (merged to 'next' on 2019-02-08 at e662ed4aee)
 + branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 Will merge to 'master'.


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

 Need to pick up a newer version.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ps/stash-in-c (2019-03-01) 28 commits
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
 - t3903: add test for --intent-to-add file
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
