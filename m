Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4321F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeJQHVu (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:21:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33708 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQHVt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:21:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id e4-v6so27498706wrs.0
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=UyqJ3PzlXdmZOnC6mYD2zcYSgHW0E0o0o08vwx0nWK8=;
        b=aN8n/9vJnnimJd9nd63h1qTSKL405I+nGa0057FG+R+SOXBXI6mlVkiQ04a8fhm2wV
         7Hc03IscBP1B8tS7MXKuIQ1wUfHhsEYhTb6Qr/J9gqbVAyEjDVJeXRoUAI5GfBSCNkTX
         sU1pROw3jB4Brq0h3QEFCEucD2A0Du25CSFOpdu2ij7QYKfRYU49fTWD9COkpI8nOi7b
         FEcGB55MXGzFMkmKlRoOzIGkiYFnHMgMs6LQXi6rmsSMDMoDVm76jLt/40hJbagctgFD
         xGM3nDlUQoR3ptSeIYLw+C/8f8E90CsByDcwAbtPGP+OYbOYWl/M9HABuBIsmu/8k+tt
         LuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=UyqJ3PzlXdmZOnC6mYD2zcYSgHW0E0o0o08vwx0nWK8=;
        b=A2lJG4GrBfa++PGCkCXoMziUlIv2vYZsLexm8niTkbbGpWTXZJtGcjvizF47oO/QCh
         OmanFMnnsWTBJasmyhgbzyvD+NsbC67IHOiiCv4pdAdLOoVIuieyXdEXcA+qS6rDRoMT
         VGAClSbuct9oiQ7qjIel2mfAgsV5ujZtghG7I9C1PUgs/bTwr6FoBMKhPHClocQyGDYu
         Q1i6foi5PtIUx4E+H3ocniZ4KFHzHS1IDze2t8BlPthUQtibf2DUeh9nh5G8KezKQnw8
         9BqUXwGphvTlbr6sTuTIIYjO1XlFq5c1jTGUidYaCIOLdRjyJtC0j+zf/0w5gTBa88vR
         SXDg==
X-Gm-Message-State: ABuFfohY9K6MQSJLCQTu2dktsY4wQm/bqE8CBJg8DtEp8kBHsrUlbGNv
        jbBFwWW9whpL/i5bItyK3lrzjeh4O1wW8InH
X-Google-Smtp-Source: ACcGV61Qnf3sXYzE059MJCQwVcyshPBJzq0FfGpekUQiU6BBfdgodf1IObrMsrS4hzZ5Se4BdYOPaQ==
X-Received: by 2002:adf:8483:: with SMTP id 3-v6mr22738625wrg.34.1539732540729;
        Tue, 16 Oct 2018 16:29:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d16-v6sm11736141wrw.78.2018.10.16.16.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 16:28:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2018, #03; Wed, 17)
X-master-at: a4b8ab5363a32f283a61ef3a962853556d136c0e
X-next-at: 3377e82b59874c0e626c00f29bf7526a27f29d65
Date:   Wed, 17 Oct 2018 08:28:59 +0900
Message-ID: <xmqqbm7txyh0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I expect to be offline for most of today during the day, so here
is the usual report but sent at an unusual time.

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Note that "cf. <msg-id>" are not meant as "clear all of these and
you are home free".  They are primarily to prevent me from merging
topics that are not ready to 'next' by mistake and remind me where
to go back to read the last state of the discussion in the archive.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/commit-graph-progress (2018-09-20) 3 commits
  (merged to 'next' on 2018-09-24 at 76f2f5c1e3)
 + gc: fix regression in 7b0f229222 impacting --quiet
 + commit-graph verify: add progress output
 + commit-graph write: add progress output
 (this branch is used by ds/commit-graph-leakfix.)

 (Originally merged to 'next' on 2018-09-20 at 24ca94b1d4)

 Generation of (experimental) commit-graph files have so far been
 fairly silent, even though it takes noticeable amount of time in a
 meaningfully large repository.  The users will now see progress
 output.


* ds/commit-graph-with-grafts (2018-08-21) 8 commits
  (merged to 'next' on 2018-10-09 at 851a457102)
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


* ds/reachable-final-cleanup (2018-09-25) 1 commit
  (merged to 'next' on 2018-10-12 at 32c6d5f55a)
 + commit-reach: cleanups in can_all_from_reach...

 Code already in 'master' is further cleaned-up by this patch.


* dz/credential-doc-url-matching-rules (2018-09-27) 1 commit
  (merged to 'next' on 2018-10-12 at 4547952530)
 + doc: clarify gitcredentials path component matching

 Doc update.


* en/merge-cleanup (2018-09-20) 4 commits
  (merged to 'next' on 2018-10-09 at f3a00b506f)
 + merge-recursive: rename merge_file_1() and merge_content()
 + merge-recursive: remove final remaining caller of merge_file_one()
 + merge-recursive: avoid wrapper function when unnecessary and wasteful
 + merge-recursive: set paths correctly when three-way merging content
 (this branch is used by en/merge-cleanup-more.)

 Code clean-up.


* en/status-multiple-renames-to-the-same-target-fix (2018-09-27) 1 commit
  (merged to 'next' on 2018-10-12 at 4976fc61a0)
 + commit: fix erroneous BUG, 'multiple renames on the same target? how?'

 The code in "git status" sometimes hit an assertion failure.  This
 was caused by a structure that was reused without cleaning the data
 used for the first run, which has been corrected.


* fe/doc-updates (2018-09-21) 3 commits
  (merged to 'next' on 2018-10-10 at 2eea3a88bc)
 + git-describe.1: clarify that "human readable" is also git-readable
 + git-column.1: clarify initial description, provide examples
 + git-archimport.1: specify what kind of Arch we're talking about

 Doc updates.


* jk/check-everything-connected-is-long-gone (2018-09-25) 1 commit
  (merged to 'next' on 2018-10-12 at 4ce30c9a30)
 + receive-pack: update comment with check_everything_connected

 Comment fix.


* jk/delta-islands-with-bitmap-reuse-delta-fix (2018-09-19) 1 commit
  (merged to 'next' on 2018-10-09 at 10e58be2af)
 + pack-objects: handle island check for "external" delta base

 Fix interactions between two recent topics.


* jk/oideq-hasheq-cleanup (2018-10-04) 1 commit
  (merged to 'next' on 2018-10-12 at 7c9b5681da)
 + more oideq/hasheq conversions

 Code clean-up.


* jn/gc-auto (2018-07-17) 1 commit
  (merged to 'next' on 2018-10-10 at 9f0f1f770e)
 + gc: do not return error for prior errors in daemonized mode
 (this branch uses jn/gc-auto-prep.)

 "gc --auto" ended up calling exit(-1) upon error, which has been
 corrected to use exit(1).  Also the error reporting behaviour when
 daemonized has been updated to exit with zero status when stopping
 due to a previously discovered error (which implies there is no
 point running gc to improve the situation); we used to exit with
 failure in such a case.


* jn/gc-auto-prep (2018-07-17) 2 commits
  (merged to 'next' on 2018-10-10 at 4ab6a62f62)
 + gc: exit with status 128 on failure
 + gc: improve handling of errors reading gc.log
 (this branch is used by jn/gc-auto.)

 Code clean-up.


* jn/mailmap-update (2018-09-25) 1 commit
  (merged to 'next' on 2018-10-10 at fa2b394bd5)
 + mailmap: consistently normalize brian m. carlson's name

 The mailmap file update.


* js/mingw-wants-vista-or-above (2018-10-04) 3 commits
  (merged to 'next' on 2018-10-12 at 3a174c3d43)
 + mingw: bump the minimum Windows version to Vista
 + mingw: set _WIN32_WINNT explicitly for Git for Windows
 + compat/poll: prepare for targeting Windows Vista

 The minimum version of Windows supported by Windows port fo Git is
 now set to Vista.


* ma/commit-graph-docs (2018-09-27) 4 commits
  (merged to 'next' on 2018-10-12 at eafaf79b5a)
 + Doc: refer to the "commit-graph file" with dash
 + git-commit-graph.txt: refer to "*commit*-graph file"
 + git-commit-graph.txt: typeset more in monospace
 + git-commit-graph.txt: fix bullet lists

 Doc update.


* ma/config-doc-update (2018-09-20) 2 commits
  (merged to 'next' on 2018-10-09 at 312a873a2a)
 + git-config.txt: fix 'see: above' note
 + Doc: use `--type=bool` instead of `--bool`

 Doc update.


* ma/mailing-list-address-in-git-help (2018-09-29) 1 commit
  (merged to 'next' on 2018-10-12 at 4c3737d234)
 + git doc: direct bug reporters to mailing list archive

 Doc update.


* ma/t1400-undebug-test (2018-09-28) 1 commit
  (merged to 'next' on 2018-10-12 at d736f83435)
 + t1400: drop debug `echo` to actually execute `test`

 Test fix.


* md/test-cleanup (2018-10-07) 7 commits
  (merged to 'next' on 2018-10-10 at 7e0bf1b573)
 + tests: order arguments to git-rev-list properly
 + t9109: don't swallow Git errors upstream of pipes
 + tests: don't swallow Git errors upstream of pipes
 + t/*: fix ordering of expected/observed arguments
 + tests: standardize pipe placement
 + Documentation: add shell guidelines
 + t/README: reformat Do, Don't, Keep in mind lists

 Various test scripts have been updated for style and also correct
 handling of exit status of various commands.


* mw/doc-typofixes (2018-10-07) 3 commits
  (merged to 'next' on 2018-10-12 at 97297b8ce9)
 + docs: typo: s/isimilar/similar/
 + docs: graph: remove unnecessary `graph_update()' call
 + docs: typo: s/go/to/

 Typofixes.


* nd/packobjectshook-doc-fix (2018-09-29) 1 commit
  (merged to 'next' on 2018-10-12 at 85d75f5219)
 + config.txt: correct the note about uploadpack.packObjectsHook

 Doc update.


* rj/header-check (2018-09-20) 8 commits
  (merged to 'next' on 2018-10-09 at 7fa9c68ef0)
 + delta-islands.h: add missing forward declarations (hdr-check)
 + midx.h: add missing forward declarations (hdr-check)
 + refs/refs-internal.h: add missing declarations (hdr-check)
 + refs/packed-backend.h: add missing declaration (hdr-check)
 + refs/ref-cache.h: add missing declarations (hdr-check)
 + ewah/ewok_rlw.h: add missing include (hdr-check)
 + json-writer.h: add missing include (hdr-check)
 + Makefile: add a hdr-check target

 Header files clean-up.


* rs/sequencer-oidset-insert-avoids-dups (2018-10-03) 1 commit
  (merged to 'next' on 2018-10-12 at b294394711)
 + sequencer: use return value of oidset_insert()

 Code clean-up.


* rt/rebase-typofix (2018-09-28) 1 commit
  (merged to 'next' on 2018-10-12 at 58691d20df)
 + git-rebase.sh: fix typos in error messages

 Typofix.


* sf/complete-stash-list (2018-10-07) 1 commit
  (merged to 'next' on 2018-10-12 at ff0e9a0805)
 + git-completion.bash: add completion for stash list

 The completion script (in contrib/) learned to complete a handful of
 options "git stash list" command takes.


* tg/t5551-with-curl-7.61.1 (2018-09-24) 2 commits
  (merged to 'next' on 2018-10-10 at 5ada84ed7a)
 + t5551: compare sorted cookies files
 + t5551: move setup code inside test_expect blocks

 Test update.
 Supersedes tz/t5551-with-curl-7.61.1 topic


* tq/refs-internal-comment-fix (2018-09-17) 1 commit
  (merged to 'next' on 2018-10-09 at 422313bbd0)
 + refs: docstring typo

 Fix for typo in a sample code in comment.


* ts/alias-of-alias (2018-09-17) 3 commits
  (merged to 'next' on 2018-10-09 at ac19b4730b)
 + t0014: introduce an alias testing suite
 + alias: show the call history when an alias is looping
 + alias: add support for aliases of an alias

 An alias that expands to another alias has so far been forbidden,
 but now it is allowed to create such an alias.

--------------------------------------------------
[New Topics]

* en/merge-cleanup-more (2018-10-16) 4 commits
 - merge-recursive: avoid showing conflicts with merge branch before HEAD
 - merge-recursive: improve auto-merging messages with path collisions
 - merge-recursive: increase marker length with depth of recursion
 - t6036: add testcase where virtual merge base contains nested conflicts

 Further clean-up of merge-recursive machinery.


* ld/p4-unshelve (2018-10-16) 3 commits
 - git-p4: fully support unshelving changelists
 - git-p4: unshelve into refs/remotes/p4-unshelved, not refs/remotes/p4/unshelved
 - git-p4: do not fail in verbose mode for missing 'fileSize' key

 "git p4 unshelve" improvements.

 Will merge to 'next'.


* mg/gpg-parse-tighten (2018-10-15) 1 commit
 - gpg-interface.c: detect and reject multiple signatures on commits

 Detect and reject a signature block that has more than one GPG
 signature.

 Expecting another round of polishing, which is promising.
 cf. <1539636266.1014.6.camel@gentoo.org>


* bc/sha-256 (2018-10-16) 14 commits
 - SQUASH???
 - commit-graph: specify OID version for SHA-256
 - hash: add an SHA-256 implementation using OpenSSL
 - sha256: add an SHA-256 implementation using libgcrypt
 - Add a base implementation of SHA-256 support
 - commit-graph: convert to using the_hash_algo
 - t/helper: add a test helper to compute hash speed
 - sha1-file: add a constant for hash block size
 - t: make the sha1 test-tool helper generic
 - t: add basic tests for our SHA-1 implementation
 - cache: make hashcmp and hasheq work with larger hashes
 - hex: introduce functions to print arbitrary hashes
 - sha1-file: provide functions to look up hash algorithms
 - sha1-file: rename algorithm to "sha1"

 Add sha-256 hash and plug it through the code to allow building Git
 with the "NewHash".


* ds/mingw-default-ident (2018-10-16) 3 commits
 - mingw: use domain information for default email
 - getpwuid(mingw): provide a better default for the user name
 - getpwuid(mingw): initialize the structure only once

 The logic to select the default user name and e-mail on Windows has
 been improved.

 Will merge to 'next'.


* ds/mingw-http-ssl (2018-10-16) 3 commits
 - http: when using Secure Channel, ignore sslCAInfo by default
 - http: add support for disabling SSL revocation checks in cURL
 - http: add support for selecting SSL backends at runtime

 On Windows with recent enough cURL library, the configuration
 variable http.sslBackend can be used to choose between OpenSSL and
 Secure Channel at runtime as the SSL backend while talking over
 the HTTPS protocol.

 Almost there.
 cf. <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>


* js/vsts-ci (2018-10-16) 13 commits
 - travis: fix skipping tagged releases
 - README: add a build badge (status of the Azure Pipelines build)
 - tests: record more stderr with --write-junit-xml in case of failure
 - tests: include detailed trace logs with --write-junit-xml upon failure
 - git-p4: use `test_atexit` to kill the daemon
 - git-daemon: use `test_atexit` in the tests
 - tests: introduce `test_atexit`
 - ci: add a build definition for Azure DevOps
 - ci/lib.sh: add support for Azure Pipelines
 - tests: optionally write results as JUnit-style .xml
 - test-date: add a subcommand to measure times in shell scripts
 - ci/lib.sh: encapsulate Travis-specific things
 - ci: rename the library of common functions

 Prepare to run test suite on Azure DevOps.

 On hold, monitoring the discussion.
 cf. <nycvar.QRO.7.76.6.1810151657080.4546@tvgsbejvaqbjf.bet>

--------------------------------------------------
[Stalled]

* lt/date-human (2018-07-09) 1 commit
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.

--------------------------------------------------
[Cooking]

* ab/gc-doc-update (2018-10-11) 1 commit
 - gc doc: mention the commit-graph in the intro

 The documentation of "git gc" has been updated to mention that it
 is no longer limited to "pruning away crufts" but also updates
 ancillary files like commit-graph as a part of repository
 optimization.

 Will merge to 'next'.


* du/branch-show-current (2018-10-16) 2 commits
 - SQUASH???
 - branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 Waiting for ack(s) on SQUASH??? fixup.
 cf. <xmqqk1mizb1c.fsf@gitster-ct.c.googlers.com>


* du/rev-parse-is-plumbing (2018-10-11) 1 commit
  (merged to 'next' on 2018-10-16 at 50aca759e2)
 + doc: move git-rev-parse from porcelain to plumbing

 Doc update.

 Will merge to 'master'.


* mm/doc-no-dashed-git (2018-10-11) 1 commit
  (merged to 'next' on 2018-10-16 at c26bcd740b)
 + doc: fix a typo and clarify a sentence

 Doc update.

 Will merge to 'master'.


* ot/ref-filter-plug-leaks (2018-10-11) 3 commits
 . ref-filter: free item->value and item->value->s
 . ls-remote: release memory instead of UNLEAK
 . ref-filter: free memory from used_atom

 Plugging a handful of memory leaks in the ref-filter codepath.

 Seems to break t6300 standalone and when merged to 'pu'.


* rv/send-email-cc-misc-by (2018-10-16) 3 commits
 - send-email: also pick up cc addresses from -by trailers
 - send-email: only consider lines containing @ or <> for automatic Cc'ing
 - Documentation/git-send-email.txt: style fixes

 "git send-email" learned to grab address-looking string on any
 trailer whose name ends with "-by"; --suppress-cc=misc-by on the
 command line, or setting sendemail.suppresscc configuration
 variable to "misc-by", can be used to disable this behaviour.

 This is a backward-incompatible change that may surprise existing
 users.

 Will merge to 'next'.


* du/cherry-is-plumbing (2018-10-12) 1 commit
 - doc: move git-cherry to plumbing

 Doc update to mark "git cherry" as a plumbing command.

 Will merge to 'next'.


* du/get-tar-commit-id-is-plumbing (2018-10-12) 1 commit
  (merged to 'next' on 2018-10-16 at 23e7f018cd)
 + doc: move git-get-tar-commit-id to plumbing

 Doc update to mark "git get-tar-commit-id" as a plumbing command.

 Will merge to 'master'.


* lm/range-diff-submodule-fix (2018-10-12) 1 commit
  (merged to 'next' on 2018-10-16 at 3e50d7a73b)
 + range-diff: allow to diff files regardless submodule

 "git range-diff" did not work well when the compared ranges had
 changes in submodules and the "--submodule=log" was used.

 Will merge to 'master'.


* sb/diff-emit-line-ws-markup-cleanup (2018-10-12) 1 commit
  (merged to 'next' on 2018-10-16 at a68a6f0003)
 + diff.c: pass sign_index to emit_line_ws_markup

 Code clean-up.

 Will merge to 'master'.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* jc/how-to-document-api (2018-09-29) 1 commit
  (merged to 'next' on 2018-10-12 at 7c9bd82285)
 + CodingGuidelines: document the API in *.h files

 Doc update.

 Will merge to 'master'.


* jc/rebase-in-c-5-test-typofix (2018-10-11) 1 commit
 - rebase: fix typoes in error messages
 (this branch uses pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test; is tangled with js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 Typofix.

 Will merge to 'next' together with pk/rebase-i-in-c-6-final.


* jc/war-on-string-list (2018-09-28) 1 commit
 - fetch: replace string-list used as a look-up table with a hashmap

 Replace two string-list instances used as look-up tables in "git
 fetch" with a pair of hashmaps.  WIP as there is another such use
 of string-list nearby that should be converted at the same time.


* js/rebase-i-break (2018-10-12) 2 commits
 - rebase -i: introduce the 'break' command
 - rebase -i: clarify what happens on a failed `exec`
 (this branch uses ag/rebase-i-in-c; is tangled with ag/sequencer-reduce-rewriting-todo, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 "git rebase -i" learned a new insn, 'break', that the user can
 insert in the to-do list.  Upon hitting it, the command returns
 control back to the user.

 Will merge to 'next' after 'pk/rebase-in-c-6-final'.


* js/remote-archive-v2 (2018-09-28) 4 commits
  (merged to 'next' on 2018-10-12 at 5f34377f60)
 + archive: allow archive over HTTP(S) with proto v2
 + archive: implement protocol v2 archive command
 + archive: use packet_reader for communications
 + archive: follow test standards around assertions

 The original implementation of "git archive --remote" more or less
 bypassed the transport layer and did not work over http(s).  The
 version 2 of the protocol is defined to allow going over http(s) as
 well as Git native transport.

 Will hold.
 cf. <20181016212008.GA249669@google.com>
 Breaks interoperability.


* jt/non-blob-lazy-fetch (2018-10-04) 2 commits
  (merged to 'next' on 2018-10-12 at 7466c6bd7d)
 + fetch-pack: exclude blobs when lazy-fetching trees
 + fetch-pack: avoid object flags if no_dependents

 A partial clone that is configured to lazily fetch missing objects
 will on-demand issue a "git fetch" request to the originating
 repository to fill not-yet-obtained objects.  The request has been
 optimized for requesting a tree object (and not the leaf blob
 objects contained in it) by telling the originating repository that
 no blobs are needed.

 Will merge to 'master'.


* ma/t7005-bash-workaround (2018-09-28) 1 commit
  (merged to 'next' on 2018-10-16 at 543e1e6574)
 + t7005-editor: quote filename to fix whitespace-issue

 Test fix.

 Will merge to 'master'.


* nd/help-commands-verbose-by-default (2018-10-03) 1 commit
  (merged to 'next' on 2018-10-12 at 32de8f53e0)
 + help -a: improve and make --verbose default

 "git help -a" and "git help -av" give different pieces of
 information, and generally the "verbose" version is more friendly
 to the new users.  "git help -a" by default now uses the more
 verbose output (with "--no-verbose", you can go back to the
 original).  Also "git help -av" now lists aliases and external
 commands, which it did not used to.

 Will merge to 'master'.


* pw/diff-color-moved-ws-fix (2018-10-04) 5 commits
  (merged to 'next' on 2018-10-12 at 73badc83fe)
 + diff --color-moved: fix a memory leak
 + diff --color-moved-ws: fix another memory leak
 + diff --color-moved-ws: fix a memory leak
 + diff --color-moved-ws: fix out of bounds string access
 + diff --color-moved-ws: fix double free crash

 Various fixes to "diff --color-moved-ws".

 Will merge to 'master'.


* rs/grep-no-recursive (2018-10-03) 1 commit
  (merged to 'next' on 2018-10-12 at 1499dc98ba)
 + grep: add -r/--[no-]recursive

 Unlike "grep", "git grep" by default recurses to the whole tree.
 The command learned "git grep --recursive" option, so that "git
 grep --no-recursive" can serve as a synonym to setting the
 max-depth to 0.

 Will merge to 'master'.


* rs/oidset-on-khash (2018-10-04) 5 commits
  (merged to 'next' on 2018-10-12 at 8bb0152b3f)
 + oidset: uninline oidset_init()
 + oidset: use khash
 + khash: factor out kh_release_*
 + fetch-pack: load tip_oids eagerly iff needed
 + fetch-pack: factor out is_unmatched_ref()

 The oidset API was built on top of the oidmap API which in turn is
 on the hashmap API.  Replace the implementation to build on top of
 the khash API and gain performance.

 Will merge to 'master'.


* rv/alias-help (2018-10-11) 3 commits
 - git-help.txt: document "git help cmd" vs "git cmd --help" for aliases
 - git.c: handle_alias: prepend alias info when first argument is -h
 - help: redirect to aliased commands for "git cmd --help"

 "git cmd --help" when "cmd" is aliased used to only say "cmd is
 aliased to ...".  Now it shows that to the standard error stream
 and runs "git $cmd --help" where $cmd is the first word of the
 alias expansion.  This could be misleading for those who alias a
 command with options (e.g. with "[alias] cpn = cherry-pick -n",
 "git cpn --help" would show the manual of "cherry-pick", and the
 reader would not be told to pay close attention to the part that
 describes the "--no-commit" option until closing the pager that
 showed the contents of the manual, if the pager is configured to
 restore the original screen, or would not be told at all, if the
 pager simply makes the message on the standard error scroll away.

 Will merge to 'next'.


* sb/strbuf-h-update (2018-09-29) 1 commit
 - strbuf.h: format according to coding guidelines

 Code clean-up to serve as a BCP example.

 Will merge to 'next'.
 Further clean-up patches may need to follow soon before this
 change escapes to 'master'.


* sg/split-index-racefix (2018-10-12) 7 commits
  (merged to 'next' on 2018-10-16 at c1d6563c51)
 + split-index: BUG() when cache entry refers to non-existing shared entry
 + split-index: smudge and add racily clean cache entries to split index
 + split-index: don't compare cached data of entries already marked for split index
 + split-index: count the number of deleted entries
 + t1700-split-index: date back files to avoid racy situations
 + split-index: add tests to demonstrate the racy split index problem
 + t1700-split-index: document why FSMONITOR is disabled in this test script

 The codepath to support the experimental split-index mode had
 remaining "racily clean" issues fixed.

 Will merge to 'master'.


* sm/show-superproject-while-conflicted (2018-09-28) 1 commit
  (merged to 'next' on 2018-10-12 at 0334353131)
 + rev-parse: --show-superproject-working-tree should work during a merge

 A corner-case bugfix.

 Will merge to 'master'.


* ag/sequencer-reduce-rewriting-todo (2018-10-09) 16 commits
 - rebase--interactive: move transform_todo_file() to rebase--interactive.c
 - sequencer: fix a call to error() in transform_todo_file()
 - sequencer: use edit_todo_list() in complete_action()
 - rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 - rebase-interactive: append_todo_help() changes
 - rebase-interactive: use todo_list_transform() in edit_todo_list()
 - sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 - sequencer: change complete_action() to use the refactored functions
 - sequencer: make sequencer_make_script() write its script to a strbuf
 - sequencer: refactor transform_todos() to work on a todo_list
 - sequencer: refactor rearrange_squash() to work on a todo_list
 - sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 - sequencer: refactor check_todo_list() to work on a todo_list
 - sequencer: make the todo_list structure public
 - sequencer: clear the number of items of a todo_list before parsing
 - Merge branch 'ag/rebase-i-in-c' into ag/sequencer-reduce-rewriting-todo
 (this branch uses ag/rebase-i-in-c; is tangled with js/rebase-i-break, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 Will hold, waiting for the "rebase-in-c" and "rebase-i-in-c" topics.


* bc/editorconfig (2018-10-09) 2 commits
  (merged to 'next' on 2018-10-16 at 81461ae0fd)
 + editorconfig: indicate settings should be kept in sync
 + editorconfig: provide editor settings for Git developers

 To help developers, an EditorConfig file that attempts to follow
 the project convention has been added.

 Will merge to 'master'.


* bc/hash-transition-part-15 (2018-10-15) 15 commits
 - rerere: convert to use the_hash_algo
 - submodule: make zero-oid comparison hash function agnostic
 - apply: rename new_sha1_prefix and old_sha1_prefix
 - apply: replace hard-coded constants
 - tag: express constant in terms of the_hash_algo
 - transport: use parse_oid_hex instead of a constant
 - upload-pack: express constants in terms of the_hash_algo
 - refs/packed-backend: express constants using the_hash_algo
 - packfile: express constants in terms of the_hash_algo
 - pack-revindex: express constants in terms of the_hash_algo
 - builtin/fetch-pack: remove constants with parse_oid_hex
 - builtin/mktree: remove hard-coded constant
 - builtin/repack: replace hard-coded constants
 - pack-bitmap-write: use GIT_MAX_RAWSZ for allocation
 - object_id.cocci: match only expressions of type 'struct object_id'

 More codepaths are moving away from hardcoded hash sizes.


* ch/subtree-build (2018-10-16) 2 commits
  (merged to 'next' on 2018-10-16 at 919599cc37)
 + subtree: make install targets depend on build targets
  (merged to 'next' on 2018-10-12 at 4ed9ff6300)
 + subtree: add build targets 'man' and 'html'

 Build update for "git subtree" (in contrib/) documentation pages.

 Will merge to 'master'.


* ds/commit-graph-leakfix (2018-10-07) 3 commits
  (merged to 'next' on 2018-10-12 at 8cc7f2f1e9)
 + commit-graph: reduce initial oid allocation
 + builtin/commit-graph.c: UNLEAK variables
 + commit-graph: clean up leaked memory during write

 Code clean-up.

 Will merge to 'master'.


* ds/test-multi-pack-index (2018-10-09) 3 commits
 - multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX
 - midx: close multi-pack-index on repack
 - midx: fix broken free() in close_midx()

 Tests for the recently introduced multi-pack index machinery.

 Expecting a reroll.
 cf. <8b5dbe3d-b382-bf48-b524-d9e8a074ac4d@gmail.com>


* js/fuzzer (2018-10-15) 2 commits
 - fuzz: add fuzz testing for packfile indices.
 - fuzz: add basic fuzz testing target.

 An experiment to fuzz test a few areas, hopefully we can gain more
 coverage to various areas.

 Will merge to 'next'.


* jt/avoid-ls-refs (2018-10-07) 4 commits
  (merged to 'next' on 2018-10-12 at 5775aabbc1)
 + fetch: do not list refs if fetching only hashes
 + transport: list refs before fetch if necessary
 + transport: do not list refs if possible
 + transport: allow skipping of ref listing

 Over some transports, fetching objects with an exact commit object
 name can be done without first seeing the ref advertisements.  The
 code has been optimized to exploit this.

 Will merge to 'master'.


* jt/cache-tree-allow-missing-object-in-partial-clone (2018-10-10) 1 commit
  (merged to 'next' on 2018-10-12 at 152ad8e336)
 + cache-tree: skip some blob checks in partial clone

 In a partial clone that will lazily be hydrated from the
 originating repository, we generally want to avoid "does this
 object exist (locally)?" on objects that we deliberately omitted
 when we created the clone.  The cache-tree codepath (which is used
 to write a tree object out of the index) however insisted that the
 object exists, even for paths that are outside of the partial
 checkout area.  The code has been updated to avoid such a check.

 Will merge to 'master'.


* nd/per-worktree-ref-iteration (2018-10-07) 9 commits
 . SQUASH???
 . reflog expire: cover reflog from all worktrees
 . fsck: check HEAD and reflog from other worktrees
 . fsck: Move fsck_head_link() to get_default_heads() to avoid some globals
 . revision.c: better error reporting on ref from different worktrees
 . revision.c: correct a parameter name
 . refs: new ref types to make per-worktree refs visible to all worktrees
 . Add a place for (not) sharing stuff between worktrees
 . refs.c: indent with tabs, not spaces

 Expecting a reroll.
 cf. <CACsJy8DNHCxz1cL+6rFxnWvQQz3T7_j8+=5u8=CxjraRzM89mw@mail.gmail.com>
 Ejected for now, as it seems to break t2025 when in 'pu'.


* np/log-graph-octopus-fix (2018-10-12) 1 commit
  (merged to 'next' on 2018-10-16 at aa00813683)
 + log: fix coloring of certain octopus merge shapes

 "git log --graph" showing an octopus merge sometimes miscounted the
 number of display columns it is consuming to show the merge and its
 parent commits, which has been corrected.

 Will merge to 'master'.


* rs/subtree-fixes (2018-10-12) 5 commits
  (merged to 'next' on 2018-10-16 at be23c9343c)
 + subtree: performance improvement for finding unexpected parent commits
  (merged to 'next' on 2018-10-12 at 2b47258e04)
 + subtree: improve decision on merges kept in split
 + subtree: use commits before rejoins for splits
 + subtree: make --ignore-joins pay attention to adds
 + subtree: refactor split of a commit into standalone method

 Various subtree fixes.

 Will merge to 'master'.
 Unless somebody objects, that is.


* tb/filter-alternate-refs (2018-10-09) 4 commits
  (merged to 'next' on 2018-10-12 at 21c14722f1)
 + transport.c: introduce core.alternateRefsPrefixes
 + transport.c: introduce core.alternateRefsCommand
 + transport.c: extract 'fill_alternate_refs_command'
 + transport: drop refnames from for_each_alternate_ref

 When pushing into a repository that borrows its objects from an
 alternate object store, "git receive-pack" that responds to the
 push request on the other side lists the tips of refs in the
 alternate to reduce the amount of objects transferred.  This
 sometimes is detrimental when the number of refs in the alternate
 is absurdly large, in which case the bandwidth saved in potentially
 fewer objects transferred is wasted in excessively large ref
 advertisement.  The alternate refs that are advertised are now
 configurable with a pair of configuration variables.

 Will merge to 'master'.


* nd/complete-fetch-multiple-args (2018-09-21) 1 commit
  (merged to 'next' on 2018-10-10 at f78e14123c)
 + completion: support "git fetch --multiple"

 Teach bash completion that "git fetch --multiple" only takes remote
 names as arguments and no refspecs.

 Will merge to 'master'.


* jt/fetch-tips-in-partial-clone (2018-09-21) 2 commits
  (merged to 'next' on 2018-10-12 at 521b3fb44d)
 + fetch: in partial clone, check presence of targets
 + connected: document connectivity in partial clones

 "git fetch $repo $object" in a partial clone did not correctly
 fetch the asked-for object that is referenced by an object in
 promisor packfile, which has been fixed.

 Will merge to 'master'.


* nd/status-refresh-progress (2018-09-17) 1 commit
  (merged to 'next' on 2018-10-12 at 9240c05add)
 + status: show progress bar if refreshing the index takes too long

 "git status" learns to show progress bar when refreshing the index
 takes a long time.

 Will merge to 'master'.


* nd/the-index (2018-09-21) 23 commits
  (merged to 'next' on 2018-10-10 at 16e2e2e947)
 + revision.c: reduce implicit dependency the_repository
 + revision.c: remove implicit dependency on the_index
 + ws.c: remove implicit dependency on the_index
 + tree-diff.c: remove implicit dependency on the_index
 + submodule.c: remove implicit dependency on the_index
 + line-range.c: remove implicit dependency on the_index
 + userdiff.c: remove implicit dependency on the_index
 + rerere.c: remove implicit dependency on the_index
 + sha1-file.c: remove implicit dependency on the_index
 + patch-ids.c: remove implicit dependency on the_index
 + merge.c: remove implicit dependency on the_index
 + merge-blobs.c: remove implicit dependency on the_index
 + ll-merge.c: remove implicit dependency on the_index
 + diff-lib.c: remove implicit dependency on the_index
 + read-cache.c: remove implicit dependency on the_index
 + diff.c: remove implicit dependency on the_index
 + grep.c: remove implicit dependency on the_index
 + diff.c: remove the_index dependency in textconv() functions
 + blame.c: rename "repo" argument to "r"
 + combine-diff.c: remove implicit dependency on the_index
 + diff.c: reduce implicit dependency on the_index
 + read-cache.c: remove 'const' from index_has_changes()
 + archive.c: remove implicit dependency the_repository
 (this branch is used by sb/more-repo-in-api.)

 Various codepaths in the core-ish part learn to work on an
 arbitrary in-core index structure, not necessarily the default
 instance "the_index".

 Will merge to 'master'.


* ds/reachable-topo-order (2018-09-21) 7 commits
 - revision.c: refactor basic topo-order logic
 - revision.h: add whitespace in flag definitions
 - commit/revisions: bookkeeping before refactoring
 - revision.c: begin refactoring --topo-order logic
 - test-reach: add rev-list tests
 - test-reach: add run_three_modes method
 - prio-queue: add 'peek' operation

 The revision walker machinery learned to take advantage of the
 commit generation numbers stored in the commit-graph file.

 Expecting a reroll.
 cf. <1c0eb7d3-7f31-9377-d42f-4ac2f36ac26a@gmail.com>


* bp/read-cache-parallel (2018-10-11) 7 commits
  (merged to 'next' on 2018-10-12 at ed6edde799)
 + read-cache: load cache entries on worker threads
 + ieot: add Index Entry Offset Table (IEOT) extension
 + read-cache: load cache extensions on a worker thread
 + config: add new index.threads config setting
 + eoie: add End of Index Entry (EOIE) extension
 + read-cache: clean up casting and byte decoding
 + read-cache.c: optimize reading index format v4

 A new extension to the index file has been introduced, which allows
 the file to be read in parallel.

 Will merge to 'master'.


* ds/coverage-diff (2018-10-10) 1 commit
  (merged to 'next' on 2018-10-16 at c12b7279d9)
 + contrib: add coverage-diff script

 The result of coverage test can be combined with "git blame" to
 check the test coverage of code introduced recently with a new
 'coverage-diff' tool (in contrib/).

 Will merge to 'master'.


* sb/submodule-recursive-fetch-gets-the-tip (2018-10-11) 9 commits
 . builtin/fetch: check for submodule updates for non branch fetches
 . fetch: retry fetching submodules if needed objects were not fetched
 . submodule: fetch in submodules git directory instead of in worktree
 . repository: repo_submodule_init to take a submodule struct
 . submodule.c: do not copy around submodule list
 . submodule.c: move global changed_submodule_names into fetch submodule struct
 . submodule.c: sort changed_submodule_names before searching it
 . submodule.c: fix indentation
 . sha1-array: provide oid_array_filter

 "git fetch --recurse-submodules" may not fetch the necessary commit
 that is bound to the superproject, which is getting corrected.

 Ejected for now, as it has fallouts in places like t/helper/.


* bp/rename-test-env-var (2018-09-28) 6 commits
  (merged to 'next' on 2018-10-12 at 201e451d20)
 + t0000: do not get self-test disrupted by environment warnings
 + preload-index: update GIT_FORCE_PRELOAD_TEST support
 + read-cache: update TEST_GIT_INDEX_VERSION support
 + fsmonitor: update GIT_TEST_FSMONITOR support
 + preload-index: use git_env_bool() not getenv() for customization
 + t/README: correct spelling of "uncommon"

 Some environment variables that control the runtime options of Git
 used during tests are getting renamed for consistency.

 Will merge to 'master'.


* ss/wt-status-committable (2018-10-03) 5 commits
  (merged to 'next' on 2018-10-10 at ea30d8819d)
 + roll wt_status_state into wt_status and populate in the collect phase
 + wt-status.c: set the committable flag in the collect phase
 + t7501: add test of "commit --dry-run --short"
 + wt-status: rename commitable to committable
 + wt-status.c: move has_unmerged earlier in the file

 Code clean-up in the internal machinery used by "git status" and
 "git commit --dry-run".

 Will merge to 'master'.


* js/rebase-in-c-5.5-work-with-rebase-i-in-c (2018-10-11) 2 commits
 - builtin rebase: prepare for builtin rebase -i
 - Merge branch 'ag/rebase-i-in-c' into js/rebase-in-c-5.5-work-with-rebase-i-in-c
 (this branch is used by pk/rebase-in-c-6-final; uses ag/rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test; is tangled with ag/sequencer-reduce-rewriting-todo, jc/rebase-in-c-5-test-typofix and js/rebase-i-break.)

 "rebase" that has been rewritten learns the new calling convention
 used by "rebase -i" that was rewritten in C, tying the loose end
 between two GSoC topics that stomped on each other's toes.

 Will merge to 'next' together with pk/rebase-i-in-c-6-final.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ao/submodule-wo-gitmodules-checked-out (2018-10-09) 10 commits
 - t/helper: add test-submodule-nested-repo-config
 - submodule: support reading .gitmodules when it's not in the working tree
 - submodule: add a helper to check if it is safe to write to .gitmodules
 - t7506: clean up .gitmodules properly before setting up new scenario
 - submodule: use the 'submodule--helper config' command
 - submodule--helper: add a new 'config' subcommand
 - t7411: be nicer to future tests and really clean things up
 - t7411: merge tests 5 and 6
 - submodule: factor out a config_set_in_gitmodules_file_gently function
 - submodule: add a print_config_from_gitmodules() helper

 The submodule support has been updated to read from the blob at
 HEAD:.gitmodules when the .gitmodules file is missing from the
 working tree.

 Expecting a reroll.
 cf. <20181010205645.e1529eff9099805029b1d6ef@ao2.it>


* md/filter-trees (2018-10-15) 9 commits
  (merged to 'next' on 2018-10-16 at 64d351d342)
 + filter-trees: code clean-up of tests
  (merged to 'next' on 2018-10-12 at c66e49d4ca)
 + list-objects-filter: implement filter tree:0
 + list-objects-filter-options: do not over-strbuf_init
 + list-objects-filter: use BUG rather than die
 + revision: mark non-user-given objects instead
 + rev-list: handle missing tree objects properly
 + list-objects: always parse trees gently
 + list-objects: refactor to process_tree_contents
 + list-objects: store common func args in struct

 The "rev-list --filter" feature learned to exclude all trees via
 "tree:0" filter.

 Will merge to 'master'.


* pk/rebase-in-c-2-basic (2018-09-06) 11 commits
 - builtin rebase: support `git rebase <upstream> <switch-to>`
 - builtin rebase: only store fully-qualified refs in `options.head_name`
 - builtin rebase: start a new rebase only if none is in progress
 - builtin rebase: support --force-rebase
 - builtin rebase: try to fast forward when possible
 - builtin rebase: require a clean worktree
 - builtin rebase: support the `verbose` and `diffstat` options
 - builtin rebase: support --quiet
 - builtin rebase: handle the pre-rebase hook and --no-verify
 - builtin rebase: support `git rebase --onto A...B`
 - builtin rebase: support --onto
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c.)

 Rewrite "git rebase" in C.

 Will merge to 'next' together with pk/rebase-i-in-c-6-final.


* pk/rebase-in-c-3-acts (2018-09-06) 7 commits
 - builtin rebase: stop if `git am` is in progress
 - builtin rebase: actions require a rebase in progress
 - builtin rebase: support --edit-todo and --show-current-patch
 - builtin rebase: support --quit
 - builtin rebase: support --abort
 - builtin rebase: support --skip
 - builtin rebase: support --continue
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c and pk/rebase-in-c-2-basic.)

 Rewrite "git rebase" in C.

 Will merge to 'next' together with pk/rebase-i-in-c-6-final.


* pk/rebase-in-c-4-opts (2018-10-11) 18 commits
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
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c, pk/rebase-in-c-2-basic and pk/rebase-in-c-3-acts.)

 Rewrite "git rebase" in C.

 Will merge to 'next' together with pk/rebase-i-in-c-6-final.


* pk/rebase-in-c-5-test (2018-10-11) 6 commits
 - builtin rebase: error out on incompatible option/mode combinations
 - builtin rebase: use no-op editor when interactive is "implied"
 - builtin rebase: show progress when connected to a terminal
 - builtin rebase: fast-forward to onto if it is a proper descendant
 - builtin rebase: optionally pass custom reflogs to reset_head()
 - builtin rebase: optionally auto-detect the upstream
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final; uses pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts and pk/rebase-in-c-4-opts.)

 Rewrite "git rebase" in C.

 Will merge to 'next' together with pk/rebase-i-in-c-6-final.


* pk/rebase-in-c-6-final (2018-10-11) 1 commit
 - rebase: default to using the builtin rebase
 (this branch uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test; is tangled with ag/sequencer-reduce-rewriting-todo, jc/rebase-in-c-5-test-typofix and js/rebase-i-break.)

 The final step of rewriting "rebase -i" in C.

 Will merge to 'next'.


* ps/stash-in-c (2018-10-15) 21 commits
 - stash: replace all `write-tree` child processes with API calls
 - stash: optimize `get_untracked_files()` and `check_changes()`
 - stash: convert `stash--helper.c` into `stash.c`
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
 - strbuf.c: add `strbuf_join_argv()`
 - sha1-name.c: add `get_oidf()` which acts like `get_oid()`

 "git stash" rewritten in C.

 Almost there.
 cf. <20181015221040.GD4883@hank.intra.tgummerer.com>


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


* ag/rebase-i-in-c (2018-10-09) 20 commits
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
 (this branch is used by ag/sequencer-reduce-rewriting-todo, js/rebase-i-break, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 Rewrite of the remaining "rebase -i" machinery in C.

 Will merge to 'next' together with pk/rebase-i-in-c-6-final.


* pk/rebase-in-c (2018-08-06) 3 commits
 - builtin/rebase: support running "git rebase <upstream>"
 - rebase: refactor common shell functions into their own file
 - rebase: start implementing it as a builtin
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final.)

 Rewrite of the "rebase" machinery in C.

 Will merge to 'next' together with pk/rebase-i-in-c-6-final.
