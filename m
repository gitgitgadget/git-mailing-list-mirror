Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFCC21F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 06:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfDVGKh (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 02:10:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37219 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVGKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 02:10:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so2930541wrr.4
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 23:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=kAPS4gZwGhCrFjRn/G+ebH0QYZxr4HRwUmo1YRC881U=;
        b=YTTp18HDnf2zAn/3ybjf7DBnpHYsgPrg6fnySlYberIRpxpJvsYHQ20rXM2RjE2Rmg
         x66snTOw+llWcVuDURxWmmwjex9j+klEbS/3PvIy5EPZYtN1hNnX7bOFyUx3T9cijndg
         dc8FO/usTLhT+vGUBJPXucEIncMVVjuLjbR9idEaaSDWFKTbibJaXV3G+Qcbw8JsPYRZ
         7zWI5uX1UgD739Ya+ji6eh2htq6+36dPKUdqOuRfO4sDNOn+Wb0i6PyIQVXIVOU8nceB
         TWLkABBE0VQ7P3NHDcJZc8Rg0ir8yuLONIHSBImMKls5W271xia5ejO8vrbj908jMLli
         rlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kAPS4gZwGhCrFjRn/G+ebH0QYZxr4HRwUmo1YRC881U=;
        b=Y0UsOSv7/atBKxro5+7sXhabl5EQr4tislKxdCzWCZ4kNnTFvs4+pHXN+vmJaSi/wt
         WcOiUZoNIPkxT7xAYNR89g3aU0KUJmyj+0cffNJDvK0A4cV0nM9L5frTStxcERPrnnxi
         ff/b5ZhHGOhsgUsTugz9TFP0AQGmyJNa/vV5I8Y0kqlUoMjMquc6GCecx6qdpwDy9gQI
         FuNGsUsHBjqthoJh4OKJhB1LCTQrwz64pt51j/d0rrTXS/kM5dCRJdvmYR27Z9/oA3X2
         /W3E8rIFQlikAfqLN/+NfndQv6oqfKQGpXLkBZP/MB9r6l3fgVMgCWPL3/AQc2KbCXkD
         oHMg==
X-Gm-Message-State: APjAAAWxrpsMZ9EYJAN80bqSXjUAP7ErIYySaOZsfV3Ssx9kBZ9uYvrE
        wApe+2W28CgpZ9zL8/cN8wbz5ixtEQ4=
X-Google-Smtp-Source: APXvYqy2kA3+hV9QT+KZ7Cr9/SRMUGvgQmRuIo/5pXkk6lrP0ENRFlziQtliweWNforiGjA+fmB7ag==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr11454261wrm.277.1555913432115;
        Sun, 21 Apr 2019 23:10:32 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id s18sm11309546wmc.41.2019.04.21.23.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 23:10:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2019, #04; Mon, 22)
X-master-at: 14c0f8d3ab6c36672189cd2dd217f4617d12ccba
X-next-at: 7a2cf3c8d2cfe6df8d13e6d8a2e2431b74241674
Date:   Mon, 22 Apr 2019 15:10:30 +0900
Message-ID: <xmqqd0le8t9l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

* cb/doco-mono (2019-03-13) 2 commits
  (merged to 'next' on 2019-04-16 at 91f5d71452)
 + doc: format pathnames and URLs as monospace.
 + doc/CodingGuidelines: URLs and paths as monospace

 Clean-up markup in the documentation suite.


* da/smerge (2019-04-04) 2 commits
  (merged to 'next' on 2019-04-16 at 80bf79fee1)
 + contrib/completion: add smerge to the mergetool completion candidates
 + mergetools: add support for smerge (Sublime Merge)

 "git mergetool" learned to offer Sublime Merge (smerge) as one of
 its backends.


* dl/flex-str-cocci (2019-04-04) 2 commits
  (merged to 'next' on 2019-04-16 at e5cb2927b3)
 + cocci: FLEX_ALLOC_MEM to FLEX_ALLOC_STR
 + midx.c: convert FLEX_ALLOC_MEM to FLEX_ALLOC_STR

 Code clean-up.


* js/check-docs-exe (2019-04-01) 5 commits
  (merged to 'next' on 2019-04-16 at 98570caa8c)
 + check-docs: fix for setups where executables have an extension
 + check-docs: do not expect guide pages to correspond to commands
 + check-docs: really look at the documented commands again
 + docs: do not document the `git remote-testgit` command
 + docs: move gitremote-helpers into section 7
 (this branch is used by js/misc-doc-fixes.)

 Dev support update.


* js/spell-out-options-in-tests (2019-04-15) 8 commits
  (merged to 'next' on 2019-04-16 at 1cfd7698b6)
 + tests: disallow the use of abbreviated options (by default)
 + tests (pack-objects): use the full, unabbreviated `--revs` option
 + tests (status): spell out the `--find-renames` option in full
 + tests (push): do not abbreviate the `--follow-tags` option
 + t5531: avoid using an abbreviated option
 + t7810: do not abbreviate `--no-exclude-standard` nor `--invert-match`
 + tests (rebase): spell out the `--force-rebase` option
 + tests (rebase): spell out the `--keep-empty` option
 (this branch is tangled with dl/rebase-i-keep-base.)

 The tests have been updated not to rely on the abbreviated option
 names the parse-options API offers, to protect us from an
 abbreviated form of an option that used to be unique within the
 command getting non-unique when a new option that share the same
 prefix is added.


* js/stash-in-c-pathspec-fix (2019-03-12) 3 commits
  (merged to 'next' on 2019-03-20 at e81d08af7a)
 + stash: pass pathspec as pointer
 + built-in stash: handle :(glob) pathspecs again
 + legacy stash: fix "rudimentary backport of -q"
 (this branch uses ps/stash-in-c; is tangled with tb/stash-in-c-unused-param-fix and tg/stash-in-c-show-default-to-p-fix.)

 Further fixes to "git stash" reimplemented in C.


* nd/include-if-wildmatch (2019-04-01) 1 commit
  (merged to 'next' on 2019-04-16 at db8b6a578a)
 + config: correct '**' matching in includeIf patterns

 A buglet in configuration parser has been fixed.


* nd/interpret-trailers-docfix (2019-04-01) 1 commit
  (merged to 'next' on 2019-04-16 at 6a57abc7e6)
 + interpret-trailers.txt: start the desc line with a capital letter

 Doc update.


* nd/read-tree-reset-doc (2019-04-02) 1 commit
  (merged to 'next' on 2019-04-16 at f2bef91774)
 + read-tree.txt: clarify --reset and worktree changes

 The documentation for "git read-tree --reset -u" has been updated.


* ps/stash-in-c (2019-03-07) 29 commits
  (merged to 'next' on 2019-03-11 at f568e3be72)
 + tests: add a special setup where stash.useBuiltin is off
 + stash: optionally use the scripted version again
 + stash: add back the original, scripted `git stash`
 + stash: convert `stash--helper.c` into `stash.c`
 + stash: replace all `write-tree` child processes with API calls
 + stash: optimize `get_untracked_files()` and `check_changes()`
 + stash: convert save to builtin
 + stash: make push -q quiet
 + stash: convert push to builtin
 + stash: convert create to builtin
 + stash: convert store to builtin
 + stash: convert show to builtin
 + stash: convert list to builtin
 + stash: convert pop to builtin
 + stash: convert branch to builtin
 + stash: convert drop and clear to builtin
 + stash: convert apply to builtin
 + stash: mention options in `show` synopsis
 + stash: add tests for `git stash show` config
 + stash: rename test cases to be more descriptive
 + t3903: add test for --intent-to-add file
 + t3903: modernize style
 + stash: improve option parsing test coverage
 + ident: don't require calling prepare_fallback_ident first
 + ident: add the ability to provide a "fallback identity"
 + strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
 + strbuf.c: add `strbuf_join_argv()`
 + sha1-name.c: add `get_oidf()` which acts like `get_oid()`
 + Merge branch 'sd/stash-wo-user-name'
 (this branch is used by js/stash-in-c-pathspec-fix, tb/stash-in-c-unused-param-fix and tg/stash-in-c-show-default-to-p-fix.)

 Originally merged to 'next' on 2019-03-07

 "git stash" rewritten in C.


* sg/asciidoctor-in-ci (2019-04-05) 6 commits
  (merged to 'next' on 2019-04-16 at efdf919c16)
 + ci: fix AsciiDoc/Asciidoctor stderr check in the documentation build job
 + ci: stick with Asciidoctor v1.5.8 for now
 + ci: install Asciidoctor in 'ci/install-dependencies.sh'
 + Documentation/technical/protocol-v2.txt: fix formatting
 + Documentation/technical/api-config.txt: fix formatting
 + Documentation/git-diff-tree.txt: fix formatting

 Update our support to format documentation in the CI environment,
 either with AsciiDoc ro Asciidoctor.


* tb/stash-in-c-unused-param-fix (2019-03-11) 1 commit
  (merged to 'next' on 2019-03-20 at 5ccac5f80d)
 + stash: drop unused parameter
 (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-pathspec-fix and tg/stash-in-c-show-default-to-p-fix.)

 Code clean-up.


* tg/stash-in-c-show-default-to-p-fix (2019-03-21) 1 commit
  (merged to 'next' on 2019-04-10 at 9489a31a36)
 + stash: setup default diff output format if necessary
 (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-pathspec-fix and tb/stash-in-c-unused-param-fix.)

 A regression fix.


* tz/asciidoctor-fixes (2019-04-01) 2 commits
  (merged to 'next' on 2019-04-16 at 0cb17f579b)
 + Documentation/git-status: fix titles in porcelain v2 section
 + Documentation/rev-list-options: wrap --date=<format> block with "--"

 Doc updates.

--------------------------------------------------
[New Topics]

* es/first-contrib-tutorial (2019-04-21) 1 commit
 - documentation: add lab for first contribution

 A WIP of a new tutorial targetting specifically aspiring git-core
 developers.


* pw/clean-sequencer-state-upon-final-commit (2019-04-17) 2 commits
 - fix cherry-pick/revert status after commit
 - commit/reset: try to clean up sequencer state

 "git chery-pick" (and "revert" that shares the same runtime engine)
 that deals with multiple commits got confused when the final step
 gets stopped with a conflict and the user concluded the sequence
 with "git commit".  Attempt to fix it by cleaning up the state
 files used by these commands in such a situation.

 Will merge to 'next'.


* pw/sequencer-cleanup-with-signoff-x-fix (2019-04-18) 1 commit
 - sequencer: fix cleanup with --signoff and -x
 (this branch is used by dl/merge-cleanup-scissors-fix.)

 "git cherry-pick" run with the "-x" or the "--signoff" option used
 to (and more importantly, ought to) clean up the commit log message
 with the --cleanup=space option by default, but this has been
 broken since late 2017.  This has been fixed.

 Will merge to 'next'.


* dr/ref-filter-push-track-fix (2019-04-18) 1 commit
 - ref-filter: use correct branch for %(push:track)

 %(push:track) token used in the --format option to "git
 for-each-ref" and friends was not showing the right branch, which
 has been fixed.

 Will merge to 'next'.


* cc/aix-has-fileno-as-a-macro (2019-04-19) 1 commit
 - Makefile: use fileno macro work around on AIX

 AIX shared the same build issues with other BSDs around fileno(fp),
 which has been corrected.

 Will merge to 'next'.


* jk/prune-optim (2019-04-19) 1 commit
 - t5304: add a test for pruning with bitmaps

 A follow-up test for an earlier "git prune" improvements.

 Will merge to 'next'.


* jk/untracked-cache-more-fixes (2019-04-19) 3 commits
 - untracked-cache: simplify parsing by dropping "len"
 - untracked-cache: simplify parsing by dropping "next"
 - untracked-cache: be defensive about missing NULs in index
 (this branch uses js/untracked-cache-allocfix.)

 Code clean-up.

 Will merge to 'next'.


* jt/submodule-repo-is-with-worktree (2019-04-21) 1 commit
 - worktree: update is_bare heuristics

 The logic to tell if a Git repository has a working tree protects
 "git branch -D" from removing the branch that is currently checked
 out by mistake.  The implementation of this logic was broken for
 repositories with unusual name, which unfortunately is the norm for
 submodules these days.  This has been fixed.

 Will merge to 'next'.


* vk/autoconf-gettext (2019-04-19) 1 commit
 - autoconf: #include <libintl.h> when checking for gettext()

 The autoconf generated configure script failed to use the right
 gettext() implementations from -libintl by ignoring useless stub
 implementations shipped in some C library, which has been
 corrected.

 Will merge to 'next'.


* dl/no-extern-in-func-decl (2019-04-21) 4 commits
 - cocci: prevent extern function declarations
 - *.[ch]: manually align parameter lists
 - *.[ch]: remove extern from function declarations using sed
 - *.[ch]: remove extern from function declarations using spatch

 Mechanically and systematically drop "extern" from function
 declarlation.

 This is the kind of code churn patch that causes heavy conflicts
 with multiple topics in flight, which causes conflicts in slightly
 different shape when it gets merged with them in different order.
 I've queued it moderately early in 'pu' for the night, and I am
 reasonably sure the merge of the topic itself is OK, but I do not
 have much confidence in the resolutions of conflicts with other
 topics later merged to 'pu'.


* js/partial-clone-connectivity-check (2019-04-21) 1 commit
 - clone: do faster object check for partial clones

 During an initial "git clone --depth=..." partial clone, it is
 pointless to spend cycles for a large portion of the connectivity
 check that enumerates and skips promisor objects (which by
 definition is all objects fetched from the other side).  This has
 been optimized out.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* nb/branch-show-other-worktrees-head (2019-03-18) 3 commits
 - branch: add worktree info on verbose output
 - branch: update output to include worktree info
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 Getting there...
 cf. <20190316013807.38756-1-nbelakovski@gmail.com> (v9)
 cf. <20190318121054.GC24175@szeder.dev>


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 - SQUASH???
 - upload-pack: send part of packfile response as uri
 - fetch-pack: support more than one pack lockfile
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http: improve documentation of http_pack_request
 - http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).

 Waiting for the final version.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


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


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

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

--------------------------------------------------
[Cooking]

* hs/send-email-transferencoding-fix (2019-04-10) 1 commit
 - send-email: honor transferencoding config option again

 Since "git send-email" learned to take 'auto' as the value for the
 transfer-encoding, it by mistake stopped honoring the values given
 to the configuration variables sendemail.transferencoding and/or
 sendemail.<ident>.transferencoding.  Attempt to correct this.

 Not quite.
 cf. <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>


* jk/xmalloc (2019-04-12) 4 commits
  (merged to 'next' on 2019-04-22 at 1a907289fa)
 + progress: use xmalloc/xcalloc
 + xdiff: use xmalloc/xrealloc
 + xdiff: use git-compat-util
 + test-prio-queue: use xmalloc

 The code is updated to check the result of memory allocation before
 it is used in more places, by using xmalloc and/or xcalloc calls.

 Will merge to 'master'.


* js/untracked-cache-allocfix (2019-04-12) 1 commit
  (merged to 'next' on 2019-04-22 at 004a544075)
 + untracked cache: fix off-by-one
 (this branch is used by jk/untracked-cache-more-fixes.)

 An underallocation in the code to read the untracked cache
 extension has been corrected.

 Will merge to 'master'.


* km/t3000-retitle (2019-04-12) 1 commit
  (merged to 'next' on 2019-04-22 at 2d5aa01ca6)
 + t3000 (ls-files -o): widen description to reflect current tests

 A test update.

 Will merge to 'master'.


* bc/send-email-qp-cr (2019-04-14) 1 commit
  (merged to 'next' on 2019-04-22 at 69398b0ea8)
 + send-email: default to quoted-printable when CR is present

 "git send-email" has been taught to use quoted-printable when the
 payload contains carriage-return.  The use of the mechanism is in
 line with the design originally added the codepath that chooses QP
 when the payload has overly long lines.

 Will merge to 'master'.


* jc/gettext-test-fix (2019-04-15) 1 commit
  (merged to 'next' on 2019-04-22 at 7c57deeb04)
 + gettext tests: export the restored GIT_TEST_GETTEXT_POISON

 The GETTEXT_POISON test option has been quite broken ever since it
 was made runtime-tunable, which has been fixed.

 Will merge to 'master'.


* jk/fetch-reachability-error-fix (2019-04-15) 7 commits
  (merged to 'next' on 2019-04-22 at b4ce8375c0)
 + fetch: do not consider peeled tags as advertised tips
 + remote.c: make singular free_ref() public
 + fetch: use free_refs()
 + pkt-line: prepare buffer before handling ERR packets
 + upload-pack: send ERR packet for non-tip objects
 + t5530: check protocol response for "not our ref"
 + t5516: drop ok=sigpipe from unreachable-want tests

 Code clean-up and a fix for "git fetch" by an explicit object name
 (as opposed to fetching refs by name).

 Will merge to 'master'.


* jk/pack-objects-reports-num-objects-to-trace2 (2019-04-12) 1 commit
 - pack-objects: write objects packed to trace2

 The "git pack-objects" command learned to report the number of
 objects it packed via the trace2 mechanism.

 Will merge to 'next'.


* js/iso8895-test-on-apfs (2019-04-15) 1 commit
  (merged to 'next' on 2019-04-22 at c2fadead33)
 + t9822: skip tests if file names cannot be ISO-8859-1 encoded

 Test fix on APFS that is incapable of store paths in Latin-1.

 Will merge to 'master'.


* js/macos-gettext-build (2019-04-15) 1 commit
  (merged to 'next' on 2019-04-22 at de4cbb1431)
 + macOS: make sure that gettext is found

 Build with gettext breaks on recent macOS w/ Homebrew when
 /usr/local/bin is not on PATH, which has been corrected.

 Will merge to 'master'.


* js/misc-doc-fixes (2019-04-19) 8 commits
 - Turn `git serve` into a test helper
 - test-tool: handle the `-C <directory>` option just like `git`
 - check-docs: do not bother checking for legacy scripts' documentation
 - docs: exclude documentation for commands that have been excluded
 - check-docs: allow command-list.txt to contain excluded commands
 - help -a: do not list commands that are excluded from the build
 - Makefile: drop the NO_INSTALL variable
 - remote-testgit: move it into the support directory for t5801

 "make check-docs", "git help -a", etc. did not account for cases
 where a particular build may deliberately omit some subcommands,
 which has been corrected.

 Will merge to 'next'.


* nd/submodule-foreach-quiet (2019-04-15) 1 commit
  (merged to 'next' on 2019-04-22 at bf982bca7b)
 + submodule foreach: fix "<command> --quiet" not being respected

 "git submodule foreach <command> --quiet" did not pass the option
 down correctly, which has been corrected.

 Will merge to 'master'.


* bs/sendemail-tighten-anything-by (2019-04-04) 1 commit
  (merged to 'next' on 2019-04-22 at 0a0680f234)
 + send-email: don't cc *-by lines with '-' prefix

 The recently added feature to add addresses that are on
 anything-by: trailers in 'git send-email' was found to be way too
 eager and considered nonsense strings as if they can be legitimate
 beginning of *-by: trailer.  This has been tightened.

 Will merge to 'master'.


* dl/warn-tagging-a-tag (2019-04-12) 2 commits
 - tag: advise on nested tags
 - tag: fix formatting

 "git tag" learned to give an advice suggesting it might be a
 mistake when creating an annotated or signed tag that points at
 another tag.

 Will merge to 'next'.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* jk/revision-rewritten-parents-in-prio-queue (2019-04-04) 1 commit
  (merged to 'next' on 2019-04-16 at bdc1465128)
 + revision: use a prio_queue to hold rewritten parents

 Performance fix for "rev-list --parents -- pathspec".

 Will merge to 'master'.


* tb/unexpected (2019-04-10) 7 commits
 - rev-list: detect broken root trees
 - rev-list: let traversal die when --missing is not in use
 - get_commit_tree(): return NULL for broken tree
 - list-objects.c: handle unexpected non-tree entries
 - list-objects.c: handle unexpected non-blob entries
 - t: introduce tests for unexpected object types
 - t: move 'hex2oct' into test-lib-functions.sh

 Code tightening against a "wrong" object appearing where an object
 of a different type is expected, instead of blindly assuming that
 the connection between objects are correctly made.

 Will merge to 'next'.


* en/merge-directory-renames (2019-04-08) 15 commits
 - merge-recursive: switch directory rename detection default
 - merge-recursive: give callers of handle_content_merge() access to contents
 - merge-recursive: track information associated with directory renames
 - t6043: fix copied test description to match its purpose
 - merge-recursive: switch from (oid,mode) pairs to a diff_filespec
 - merge-recursive: cleanup handle_rename_* function signatures
 - merge-recursive: track branch where rename occurred in rename struct
 - merge-recursive: remove ren[12]_other fields from rename_conflict_info
 - merge-recursive: shrink rename_conflict_info
 - merge-recursive: move some struct declarations together
 - merge-recursive: use 'ci' for rename_conflict_info variable name
 - merge-recursive: rename locals 'o' and 'a' to 'obuf' and 'abuf'
 - merge-recursive: rename diff_filespec 'one' to 'o'
 - merge-recursive: rename merge_options argument from 'o' to 'opt'
 - Use 'unsigned short' for mode, like diff_filespec does

 "git merge-recursive" backend recently learned a new heuristics to
 infer file movement based on how other files in the same directory
 moved.  As this is inherently less robust heuristics than the one
 based on the content similarity of the file itself (rather than
 based on what its neighbours are doing), it sometimes gives an
 outcome unexpected by the end users.  This has been toned down to
 leave the renamed paths in higher/conflicted stages in the index so
 that the user can examine and confirm the result.

 Will merge to 'next'.


* jk/server-info-rabbit-hole (2019-04-16) 13 commits
  (merged to 'next' on 2019-04-16 at 3dded8be9a)
 + update_info_refs(): drop unused force parameter
 + server-info: drop objdirlen pointer arithmetic
 + server-info: drop nr_alloc struct member
 + server-info: use strbuf to read old info/packs file
 + server-info: simplify cleanup in parse_pack_def()
 + server-info: fix blind pointer arithmetic
 + http: simplify parsing of remote objects/info/packs
 + packfile: fix pack basename computation
 + midx: check both pack and index names for containment
 + t5319: drop useless --buffer from cat-file
 + t5319: fix bogus cat-file argument
 + pack-revindex: open index if necessary
 + packfile.h: drop extern from function declarations

 Code clean-up around a much-less-important-than-it-used-to-be
 update_server_info() funtion.

 Will merge to 'master'.


* jt/clone-server-option (2019-04-18) 2 commits
 - clone: send server options when using protocol v2
 - transport: die if server options are unsupported

 "git clone" learned a new --server-option option when talking over
 the protocol version 2.

 Will merge to 'next'.


* po/describe-not-necessarily-7 (2019-04-08) 1 commit
  (merged to 'next' on 2019-04-22 at 65b47ca73f)
 + describe doc: remove '7-char' abbreviation reference

 Docfix.

 Will merge to 'master'.


* po/rerere-doc-fmt (2019-04-08) 1 commit
  (merged to 'next' on 2019-04-22 at 780c0d2450)
 + rerere doc: quote `rerere.enabled`

 Docfix.

 Will merge to 'master'.


* sg/blame-in-bare-start-at-head (2019-04-08) 1 commit
  (merged to 'next' on 2019-04-22 at 159777c280)
 + blame: default to HEAD in a bare repo when no start commit is given

 "git blame -- path" in a non-bare repository starts blaming from
 the working tree, and the same command in a bare repository errors
 out because there is no working tree by definition.  The command
 has been taught to instead start blaming from the commit at HEAD,
 which is more useful.

 Will merge to 'master'.


* tg/ls-files-debug-format-fix (2019-04-08) 1 commit
  (merged to 'next' on 2019-04-22 at a5ac1ca49f)
 + ls-files: use correct format string

 Debugging code fix.

 Will merge to 'master'.


* tz/doc-apostrophe-no-longer-needed (2019-04-10) 1 commit
  (merged to 'next' on 2019-04-22 at 8ff03863ce)
 + Documentation/git-show-branch: avoid literal {apostrophe}

 Doc formatting fix.

 Will merge to 'master'.


* tz/git-svn-doc-markup-fix (2019-04-10) 1 commit
 - Documentation/git-svn: improve asciidoctor compatibility

 Doc formatting fix.

 Will merge to 'next'.


* js/t3301-unbreak-notes-test (2019-04-09) 1 commit
  (merged to 'next' on 2019-04-22 at a015b00bd9)
 + t3301: fix false negative

 Test fix.

 Will merge to 'master'.


* ss/msvc-path-utils-fix (2019-04-09) 1 commit
 - MSVC: include compat/win32/path-utils.h for MSVC, too, for real_path()

 An earlier update for MinGW and Cygwin accidentally broke MSVC build,
 which has been fixed.

 Will merge to 'next'.


* cc/multi-promisor (2019-04-15) 17 commits
 - Move core_partial_clone_filter_default to promisor-remote.c
 - Move repository_format_partial_clone to promisor-remote.c
 - Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
 - remote: add promisor and partial clone config to the doc
 - partial-clone: add multiple remotes in the doc
 - t0410: test fetching from many promisor remotes
 - builtin/fetch: remove unique promisor remote limitation
 - promisor-remote: parse remote.*.partialclonefilter
 - diff: use promisor-remote.h instead of fetch-object.h
 - Use promisor_remote_get_direct() and has_promisor_remote()
 - promisor-remote: use repository_format_partial_clone
 - promisor-remote: add promisor_remote_reinit()
 - promisor-remote: implement promisor_remote_get_direct()
 - Add initial support for many promisor remotes
 - fetch-object: make functions return an error code
 - t0410: remove pipes after git commands
 - Merge branch 'jt/batch-fetch-blobs-in-diff' into cc/multi-promisor
 (this branch uses jt/batch-fetch-blobs-in-diff.)

 Teach the lazy clone machinery that there can be more than one
 promisor remote and consult them in order when downloading missing
 objects on demand.

 Needs review.


* nd/switch-and-restore (2019-04-12) 43 commits
 - help: move git-diff and git-reset to different groups
 - rm: add --staged as alias for --cached
 - doc: promote "git restore"
 - user-manual.txt: prefer 'merge --abort' over 'reset --hard'
 - completion: support restore
 - t: add tests for restore
 - restore: support --patch
 - restore: replace --force with --ignore-unmerged
 - restore: default to --source=HEAD when only --staged is specified
 - restore: reject invalid combinations with --staged
 - restore: add --worktree and --staged
 - checkout: factor out worktree checkout code
 - restore: disable overlay mode by default
 - restore: make pathspec mandatory
 - restore: take tree-ish from --source option instead
 - checkout: split part of it to new command 'restore'
 - doc: promote "git switch"
 - completion: support switch
 - t: add tests for switch
 - switch: make --orphan switch to an empty tree
 - switch: reject if some operation is in progress
 - switch: no worktree status unless real branch switch happens
 - switch: implicit dwim, use --no-guess to disable it
 - switch: add short option for --detach
 - switch: only allow explicit detached HEAD
 - switch: reject "do nothing" case
 - switch: stop accepting pathspec
 - switch: remove -l
 - switch: add --discard-changes
 - switch: better names for -b and -B
 - checkout: split part of it to new command 'switch'
 - checkout: split options[] array in three pieces
 - checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 - checkout: make "opts" in cmd_checkout() a pointer
 - checkout: factor out some code in parse_branchname_arg()
 - checkout: keep most #include sorted
 - checkout: inform the user when removing branch state
 - checkout: advice how to get out of detached HEAD mode
 - t: rename t2014-switch.sh to t2014-checkout-switch.sh
 - git-checkout.txt: fix monospace typeset
 - doc: document --overwrite-ignore
 - git-checkout.txt: fix one syntax line
 - git-checkout.txt: spell out --no-option

 Two new commands "git switch" and "git restore" are introduced to
 split "checking out a branch to work on advancing its history" and
 "checking out paths out of the index and/or a tree-ish to work on
 advancing the current history" out of the single "git checkout"
 command.

 The "switch" part seems more or less ready for testing.  Perhaps
 we should split this back into two topics and merge it to 'next'.
 cf. <20190329103919.15642-1-pclouds@gmail.com> (switch v6)
 cf. <20190411131218.19195-1-pclouds@gmail.com> (restore v2)


* ab/gc-reflog (2019-04-01) 7 commits
  (merged to 'next' on 2019-04-16 at aa27f951a8)
 + gc: handle & check gc.reflogExpire config
 + reflog tests: assert lack of early exit with expiry="never"
 + reflog tests: test for the "points nowhere" warning
 + reflog tests: make use of "test_config" idiom
 + gc: refactor a "call me once" pattern
 + gc: convert to using the_hash_algo
 + gc: remove redundant check for gc_auto_threshold

 Fix various glitches in "git gc" around reflog handling.

 Will merge to 'master'.


* ew/repack-with-bitmaps-by-default (2019-03-18) 3 commits
 - pack-objects: default to writing bitmap hash-cache
 - t5310: correctly remove bitmaps for jgit test
 - repack: enable bitmaps by default on bare repos

 The connectivity bitmaps are created by default in bare
 repositories now; also the pathname hash-cache is created by
 default to avoid making crappy deltas when repacking.

 Will merge to 'next'.


* js/difftool-no-index (2019-03-18) 3 commits
  (merged to 'next' on 2019-04-16 at 7313f9ff18)
 + difftool: allow running outside Git worktrees with --no-index
 + parse-options: make OPT_ARGUMENT() more useful
 + difftool: remove obsolete (and misleading) comment

 "git difftool" can now run outside a repository.

 Will merge to 'master'.


* pw/cherry-pick-continue (2019-03-18) 3 commits
  (merged to 'next' on 2019-04-16 at 1bfd7a7179)
 + cherry-pick --continue: remember options
 + cherry-pick: demonstrate option amnesia
 + sequencer: break some long lines

 "git cherry-pick --options A..B", after giving control back to the
 user to ask help resolving a conflicted step, did not honor the
 options it originally received, which has been corrected.

 Will merge to 'master'.


* sg/test-atexit (2019-03-14) 11 commits
  (merged to 'next' on 2019-04-10 at 7839135291)
 + t9811-git-p4-label-import: fix pipeline negation
 + git p4 test: disable '-x' tracing in the p4d watchdog loop
 + git p4 test: simplify timeout handling
 + git p4 test: clean up the p4d cleanup functions
 + git p4 test: use 'test_atexit' to kill p4d and the watchdog process
 + t0301-credential-cache: use 'test_atexit' to stop the credentials helper
 + tests: use 'test_atexit' to stop httpd
 + git-daemon: use 'test_atexit` to stop 'git-daemon'
 + test-lib: introduce 'test_atexit'
 + t/lib-git-daemon: make sure to kill the 'git-daemon' process
 + test-lib: fix interrupt handling with 'dash' and '--verbose-log -x'

 Test framework update to more robustly clean up leftover files and
 processes after tests are done.

 Will merge to 'master'.


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Undecided but inclined to discard.


* jk/unused-params-even-more (2019-03-21) 13 commits
  (merged to 'next' on 2019-04-10 at 12edf8872f)
 + parse_opt_ref_sorting: always use with NONEG flag
 + pretty: drop unused strbuf from parse_padding_placeholder()
 + pretty: drop unused "type" parameter in needs_rfc2047_encoding()
 + parse-options: drop unused ctx parameter from show_gitcomp()
 + fetch_pack(): drop unused parameters
 + report_path_error(): drop unused prefix parameter
 + unpack-trees: drop unused error_type parameters
 + unpack-trees: drop name_entry from traverse_by_cache_tree()
 + test-date: drop unused "now" parameter from parse_dates()
 + update-index: drop unused prefix_length parameter from do_reupdate()
 + log: drop unused "len" from show_tagger()
 + log: drop unused rev_info from early output
 + revision: drop some unused "revs" parameters

 Code cleanup.

 Will merge to 'master'.


* ab/commit-graph-fixes (2019-04-01) 8 commits
  (merged to 'next' on 2019-04-16 at 97f4ba02f0)
 + commit-graph: improve & i18n error messages
 + commit-graph write: don't die if the existing graph is corrupt
 + commit-graph verify: detect inability to read the graph
 + commit-graph: don't pass filename to load_commit_graph_one_fd_st()
 + commit-graph: don't early exit(1) on e.g. "git status"
 + commit-graph: fix segfault on e.g. "git status"
 + commit-graph tests: test a graph that's too small
 + commit-graph tests: split up corrupt_graph_and_verify()

 Code cleanup with more careful error checking before using data
 read from the commit-graph file.

 Will merge to 'master'.


* ab/gc-docs (2019-04-08) 11 commits
  (merged to 'next' on 2019-04-22 at 02785d40f5)
 + gc docs: remove incorrect reference to gc.auto=0
 + gc docs: clarify that "gc" doesn't throw away referenced objects
 + gc docs: note "gc --aggressive" in "fast-import"
 + gc docs: downplay the usefulness of --aggressive
 + gc docs: note how --aggressive impacts --window & --depth
 + gc docs: fix formatting for "gc.writeCommitGraph"
 + gc docs: re-flow the "gc.*" section in "config"
 + gc docs: include the "gc.*" section from "config" in "gc"
 + gc docs: clean grammar for "gc.bigPackThreshold"
 + gc docs: stop noting "repack" flags
 + gc docs: modernize the advice for manually running "gc"

 Update docs around "gc".

 Will merge to 'master'.


* ab/test-lib-pass-trace2-env (2019-04-01) 1 commit
  (merged to 'next' on 2019-04-16 at 4dad6d6d7a)
 + test-lib: whitelist GIT_TR2_* in the environment

 Allow tracing of Git executable while running the testsuite.

 Will merge to 'master'.


* am/p4-branches-excludes (2019-04-02) 8 commits
 - git-p4: respect excluded paths when detecting branches
 - git-p4: add failing test for "git-p4: respect excluded paths when detecting branches"
 - git-p4: don't exclude other files with same prefix
 - git-p4: add failing test for "don't exclude other files with same prefix"
 - git-p4: don't groom exclude path list on every commit
 - git-p4: match branches case insensitively if configured
 - git-p4: add failing test for "git-p4: match branches case insensitively if configured"
 - git-p4: detect/prevent infinite loop in gitCommitByP4Change()

 "git p4" update.

 Is this ready for 'next'?


* bc/hash-transition-16 (2019-04-01) 35 commits
  (merged to 'next' on 2019-04-16 at 8227fea6fa)
 + gitweb: make hash size independent
 + Git.pm: make hash size independent
 + read-cache: read data in a hash-independent way
 + dir: make untracked cache extension hash size independent
 + builtin/difftool: use parse_oid_hex
 + refspec: make hash size independent
 + archive: convert struct archiver_args to object_id
 + builtin/get-tar-commit-id: make hash size independent
 + get-tar-commit-id: parse comment record
 + hash: add a function to lookup hash algorithm by length
 + remote-curl: make hash size independent
 + http: replace sha1_to_hex
 + http: compute hash of downloaded objects using the_hash_algo
 + http: replace hard-coded constant with the_hash_algo
 + http-walker: replace sha1_to_hex
 + http-push: remove remaining uses of sha1_to_hex
 + http-backend: allow 64-character hex names
 + http-push: convert to use the_hash_algo
 + builtin/pull: make hash-size independent
 + builtin/am: make hash size independent
 + fast-import: replace sha1_to_hex
 + fast-import: make hash-size independent
 + builtin/name-rev: make hash-size independent
 + object-store: rename and expand packed_git's sha1 member
 + notes: replace sha1_to_hex
 + notes: make hash size independent
 + notes-merge: switch to use the_hash_algo
 + submodule: avoid hard-coded constants
 + pack-bitmap: switch hash tables to use struct object_id
 + pack-bitmap: switch hard-coded constants to the_hash_algo
 + pack-bitmap: replace sha1_to_hex
 + pack-bitmap: convert struct stored_bitmap to object_id
 + pack-bitmap: make bitmap header handling hash agnostic
 + khash: move oid hash table definition
 + t/lib-submodule-update: use appropriate length constant

 Conversion from unsigned char[20] to struct object_id continues.

 Will merge to 'master'.


* cc/replace-graft-peel-tags (2019-04-15) 4 commits
 - replace: peel tag when passing a tag first to --graft
 - replace: peel tag when passing a tag as parent to --graft
 - t6050: redirect expected error output to a file
 - t6050: use test_line_count instead of wc -l

 When given a tag that points at a commit-ish, "git replace --graft"
 failed to peel the tag before writing a replace ref, which did not
 make sense because the old graft mechanism the feature wants to
 mimick only allowed to replace one commit object with another.
 This has been fixed.

 Will merge to 'next'.


* dk/blame-keep-origin-blob (2019-04-03) 1 commit
  (merged to 'next' on 2019-04-16 at 39679dde8b)
 + blame.c: don't drop origin blobs as eagerly

 Performance fix around "git blame", especially in a linear history
 (which is the norm we should optimize for).

 Will merge to 'master'.


* dl/rebase-i-keep-base (2019-04-21) 6 commits
 - rebase: teach rebase --keep-base
 - rebase: fast-forward --fork-point in more cases
 - rebase: fast-forward --onto in more cases
 - rebase: refactor can_fast_forward into goto tower
 - t3432: test rebase fast-forward behavior
 - t3431: add rebase --fork-point tests

 "git rebase --keep-base <upstream>" tries to find the original base
 of the topic being rebased and rebase on top of that same base,
 which is useful when running the "git rebase -i" (and its limited
 variant "git rebase -x").

 The command also has learned to fast-forward in more cases where it
 can instead of replaying to recreate identical commits.

 Will merge to 'next'.


* en/fast-import-parsing-fix (2019-04-01) 5 commits
  (merged to 'next' on 2019-04-16 at b318831bde)
 + fast-import: fix erroneous handling of get-mark with empty orphan commits
 + fast-import: only allow cat-blob requests where it makes sense
 + fast-import: check most prominent commands first
 + git-fast-import.txt: fix wording about where ls command can appear
 + t9300: demonstrate bug with get-mark and empty orphan commits

 "git fast-import" update.

 Will merge to 'master'.


* jh/trace2-sid-fix (2019-04-16) 10 commits
 - trace2: update docs to describe system/global config settings
 - trace2: make SIDs more unique
 - trace2: clarify UTC datetime formatting
 - trace2: report peak memory usage of the process
 - trace2: use system/global config for default trace2 settings
 - config: add read_very_early_config()
 - trace2: find exec-dir before trace2 initialization
 - trace2: add absolute elapsed time to start event
 - trace2: refactor setting process starting time
 - config: initialize opts structure in repo_read_config()

 Polishing of the new trace2 facility continues.  The system-level
 configuration can specify site-wide trace2 settings, which can be
 overridden with per-user configuration and environment variables.

 Will merge to 'next'.
 cf. <pull.169.v4.git.gitgitgadget@gmail.com> (v4)


* js/trace2-to-directory (2019-03-22) 1 commit
 - trace2: write to directory targets

 The trace2 tracing facility learned to auto-generate a filename
 when told to log to a directory.

 Will merge to 'next'.


* jt/batch-fetch-blobs-in-diff (2019-04-08) 2 commits
  (merged to 'next' on 2019-04-22 at 0598bae567)
 + diff: batch fetching of missing blobs
 + sha1-file: support OBJECT_INFO_FOR_PREFETCH
 (this branch is used by cc/multi-promisor.)

 While running "git diff" in a lazy clone, we can upfront know which
 missing blobs we will need, instead of waiting for the on-demand
 machinery to discover them one by one.  Aim to achieve better
 performance by batching the request for these promised blobs.

 Will merge to 'master'.


* jt/fetch-no-update-shallow-in-proto-v2 (2019-04-01) 3 commits
  (merged to 'next' on 2019-04-16 at 05c5ebe471)
 + fetch-pack: respect --no-update-shallow in v2
 + fetch-pack: call prepare_shallow_info only if v0
 + Merge branch 'jt/test-protocol-version' into jt/fetch-no-update-shallow-in-proto-v2

 Fix for protocol v2 support in "git fetch-pack" of shallow clones.

 Will merge to 'master'.


* jt/fetch-pack-wanted-refs-optim (2019-04-01) 1 commit
  (merged to 'next' on 2019-04-16 at 051f6bd38a)
 + fetch-pack: binary search when storing wanted-refs

 Performance fix around "git fetch" that grabs many refs.

 Will merge to 'master'.


* km/empty-repo-is-still-a-repo (2019-04-10) 3 commits
 - add: error appropriately on repository with no commits
 - dir: do not traverse repositories with no commits
 - submodule: refuse to add repository with no commits

 Running "git add" on a repository created inside the current
 repository is an explicit indication that the user wants to add it
 as a submodule, but when the HEAD of the inner repository is on an
 unborn branch, it cannot be added as a submodule.  Worse, the files
 in its working tree can be added as if they are a part of the outer
 repository, which is not what the user wants.  These problems are
 being addressed.

 Will merge to 'next'.


* nd/checkout-m (2019-03-24) 4 commits
  (merged to 'next' on 2019-04-16 at 4d7c322bed)
 + checkout: prevent losing staged changes with --merge
 + read-tree: add --quiet
 + unpack-trees: rename "gently" flag to "quiet"
 + unpack-trees: keep gently check inside add_rejected_path

 "git checkout -m <other>" was about carrying the differences
 between HEAD and the working-tree files forward while checking out
 another branch, and ignored the differences between HEAD and the
 index.  The command has been taught to abort when the index and the
 HEAD are different.

 Will merge to 'master'.


* nd/commit-a-with-paths-msg-update (2019-03-22) 1 commit
  (merged to 'next' on 2019-04-16 at a36c712b39)
 + commit: improve error message in "-a <paths>" case

 The message given when "git commit -a <paths>" errors out has been
 updated.

 Will merge to 'master'.


* nd/diff-parseopt-4 (2019-03-24) 20 commits
  (merged to 'next' on 2019-04-10 at 893b135f10)
 + am: avoid diff_opt_parse()
 + diff --no-index: use parse_options() instead of diff_opt_parse()
 + range-diff: use parse_options() instead of diff_opt_parse()
 + diff.c: allow --no-color-moved-ws
 + diff-parseopt: convert --color-moved-ws
 + diff-parseopt: convert --[no-]color-moved
 + diff-parseopt: convert --inter-hunk-context
 + diff-parseopt: convert --no-prefix
 + diff-parseopt: convert --line-prefix
 + diff-parseopt: convert --[src|dst]-prefix
 + diff-parseopt: convert --[no-]abbrev
 + diff-parseopt: convert --diff-filter
 + diff-parseopt: convert --find-object
 + diff-parseopt: convert -O
 + diff-parseopt: convert --pickaxe-all|--pickaxe-regex
 + diff-parseopt: convert -S|-G
 + diff-parseopt: convert -l
 + diff-parseopt: convert -z
 + diff-parseopt: convert --ita-[in]visible-in-index
 + diff-parseopt: convert --ws-error-highlight

 Fourth batch to teach the diff machinery to use the parse-options
 API.

 Will merge to 'master'.


* nd/precious (2019-04-09) 1 commit
 - Introduce "precious" file concept

 "git clean" learned to pay attention to the 'precious' attributes
 and keep untracked paths with the attribute instead of removing
 when the "--keep-precious" is given.

 Retracted.
 cf. <CACsJy8AEZ-Lz6zgEsuNukvphB9TTa9FAC1gK05fhnie2xtfc9w@mail.gmail.com>

 I am not sure what aspect of this longer-term "precious" vision,
 which gets taught to various commands and use cases individually
 and incrementally, Ævar finds problematic, which I understand is
 the reason of redtraction.


* nd/sha1-name-c-wo-the-repository (2019-04-16) 34 commits
 - sha1-name.c: remove the_repo from get_oid_mb()
 - sha1-name.c: remove the_repo from other get_oid_*
 - sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
 - submodule-config.c: use repo_get_oid for reading .gitmodules
 - sha1-name.c: add repo_get_oid()
 - sha1-name.c: remove the_repo from get_oid_with_context_1()
 - sha1-name.c: remove the_repo from resolve_relative_path()
 - sha1-name.c: remove the_repo from diagnose_invalid_index_path()
 - sha1-name.c: remove the_repo from handle_one_ref()
 - sha1-name.c: remove the_repo from get_oid_1()
 - sha1-name.c: remove the_repo from get_oid_basic()
 - sha1-name.c: remove the_repo from get_describe_name()
 - sha1-name.c: remove the_repo from get_oid_oneline()
 - sha1-name.c: add repo_interpret_branch_name()
 - sha1-name.c: remove the_repo from interpret_branch_mark()
 - sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
 - sha1-name.c: remove the_repo from get_short_oid()
 - sha1-name.c: add repo_for_each_abbrev()
 - sha1-name.c: store and use repo in struct disambiguate_state
 - sha1-name.c: add repo_find_unique_abbrev_r()
 - sha1-name.c: remove the_repo from find_abbrev_len_packed()
 - sha1-name.c: remove the_repo from sort_ambiguous()
 - commit.c: add repo_get_commit_tree()
 - commit.cocci: refactor code, avoid double rewrite
 - refs.c: remove the_repo from read_ref_at()
 - refs.c: add repo_dwim_log()
 - refs.c: add repo_dwim_ref()
 - refs.c: remove the_repo from expand_ref()
 - refs.c: remove the_repo from substitute_branch_name()
 - refs.c: add refs_shorten_unambiguous_ref()
 - refs.c: add refs_ref_exists()
 - packfile.c: add repo_approximate_object_count()
 - builtin rebase: use oideq()
 - builtin rebase: use FREE_AND_NULL

 Further code clean-up to allow the lowest level of name-to-object
 mapping layer to work with a passed-in repository other than the
 default one.

 Will merge to 'next'.


* pw/rebase-i-internal (2019-04-19) 13 commits
 - rebase -i: run without forking rebase--interactive
 - rebase: use a common action enum
 - rebase -i: use struct rebase_options in do_interactive_rebase()
 - rebase -i: use struct rebase_options to parse args
 - rebase -i: use struct object_id for squash_onto
 - rebase -i: use struct commit when parsing options
 - rebase -i: remove duplication
 - rebase -i: combine rebase--interactive.c with rebase.c
 - rebase: use OPT_RERERE_AUTOUPDATE()
 - rebase: rename write_basic_state()
 - rebase: don't translate trace strings
 - sequencer: always discard index after checkout
 - Merge branch 'ag/sequencer-reduce-rewriting-todo' into pw/rebase-i-internal
 (this branch uses ag/sequencer-reduce-rewriting-todo.)

 The internal implementation of "git rebase -i" has been updated to
 avoid forking a separate "rebase--interactive" process.

 Will merge to 'next'.


* sg/index-pack-progress (2019-04-01) 1 commit
  (merged to 'next' on 2019-04-16 at a10bfdd950)
 + index-pack: show progress while checking objects

 A progress indicator has been added to the "index-pack" step, which
 often makes users wait for completion during "git clone".

 Will merge to 'master'.


* sg/overlong-progress-fix (2019-04-15) 4 commits
  (merged to 'next' on 2019-04-22 at 69921cdf09)
 + progress: break too long progress bar lines
 + progress: clear previous progress update dynamically
 + progress: assemble percentage and counters in a strbuf before printing
 + progress: make display_progress() return void

 Updating the display with progress message has been cleaned up to
 deal better with overlong messages.

 Will merge to 'master'.


* nd/worktree-name-sanitization (2019-03-20) 2 commits
 - SQUASH???
 - worktree add: sanitize worktree names

 In recent versions of Git, per-worktree refs are exposed in
 refs/worktrees/<wtname>/ hierarchy, which means that worktree names
 must be a valid refname component.  The code now sanitizes the names
 given to worktrees, to make sure these refs are well-formed.


* bp/post-index-change-hook (2019-02-15) 1 commit
  (merged to 'next' on 2019-03-11 at cb96d1d7c4)
 + read-cache: add post-index-change hook

 Originally merged to 'next' on 2019-02-23

 A new hook "post-index-change" is called when the on-disk index
 file changes, which can help e.g. a virtualized working tree
 implementation.

 Will merge to 'master'.


* dl/submodule-set-branch (2019-04-10) 3 commits
  (merged to 'next' on 2019-04-22 at 3b640715ae)
 + submodule: teach set-branch subcommand
 + submodule--helper: teach config subcommand --unset
 + git-submodule.txt: "--branch <branch>" option defaults to 'master'

 "git submodule" learns "set-branch" subcommand that allows the
 submodule.*.branch settings to be modified.

 Will merge to 'master'.


* dm/some-stdio-functions-are-macro-on-freebsd (2019-02-01) 1 commit
 - http: cast result to FILE *

 Variants of BSD define fileno(fh) as a macro, breaking a program
 that passes a "void *" to it.

 Expecting a reroll.
 cf. <49B9198C-53E5-42BD-8834-B1EDEB3332CB@usask.ca>


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


* br/blame-ignore (2019-04-14) 6 commits
 - blame: use a fingerprint heuristic to match ignored lines
 - blame: optionally track line fingerprints during fill_blame_origin()
 - blame: add config options to handle output for ignored lines
 - blame: add the ability to ignore commits and their changes
 - blame: use a helper function in blame_chunk()
 - Move init_skiplist() outside of fsck

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Expecting a reroll.
 cf. <20190410162409.117264-1-brho@google.com> (v6)
 cf. <a742dd62-c84e-1f85-0663-4a3aa4d14989@google.com>
 cf. <3db6bad3-e7a5-af1d-3fe2-321bd17db2c6@google.com>


* nd/config-move-to (2019-01-14) 7 commits
 - config.h: fix hdr-check warnings
 - config: add --move-to
 - config: factor out set_config_source_file()
 - config: use OPT_FILENAME()
 - config.c: add repo_config_set_worktree_gently()
 - worktree.c: add get_worktree_config()
 - config.c: avoid git_path() in do_git_config_sequence()

 Needs review.


* dl/merge-cleanup-scissors-fix (2019-04-19) 10 commits
 - cherry-pick/revert: add scissors line on merge conflict
 - sequencer.c: save and restore cleanup mode
 - merge: add scissors line on merge conflict
 - merge: cleanup messages like commit
 - parse-options.h: extract common --cleanup option
 - commit: extract cleanup_mode functions to sequencer
 - t7502: clean up style
 - t7604: clean up style
 - t3507: clean up style
 - t7600: clean up style
 (this branch uses pw/sequencer-cleanup-with-signoff-x-fix.)

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Will merge to 'next'.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* ag/sequencer-reduce-rewriting-todo (2019-03-07) 18 commits
  (merged to 'next' on 2019-04-10 at 7eab7c7800)
 + rebase--interactive: move transform_todo_file()
 + sequencer: use edit_todo_list() in complete_action()
 + rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 + rebase-interactive: append_todo_help() changes
 + rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 + sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 + rebase--interactive: move rearrange_squash_in_todo_file()
 + rebase--interactive: move sequencer_add_exec_commands()
 + sequencer: change complete_action() to use the refactored functions
 + sequencer: make sequencer_make_script() write its script to a strbuf
 + sequencer: refactor rearrange_squash() to work on a todo_list
 + sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 + sequencer: refactor check_todo_list() to work on a todo_list
 + sequencer: introduce todo_list_write_to_file()
 + sequencer: refactor transform_todos() to work on a todo_list
 + sequencer: remove the 'arg' field from todo_item
 + sequencer: make the todo_list structure public
 + sequencer: changes in parse_insn_buffer()
 (this branch is used by pw/rebase-i-internal.)

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 Will merge to 'master'.
 cf. <20190305191805.13561-1-alban.gruin@gmail.com> (v8)

--------------------------------------------------
[Discarded]

* js/rev-list-exclude-promisor-objects (2019-04-09) 1 commit
 . rev-list: exclude promisor objects at walk time

 "git rev-list --exclude-promisor-objects" learned not to bother
 enumerating all promisor objects, and instead filter these objects
 at walk time for performance.

 Discarded; js/partial-clone-connectivity-check replaces this.
 cf. <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com> (v3)
 cf. <20190413053434.GA31884@sigill.intra.peff.net>
