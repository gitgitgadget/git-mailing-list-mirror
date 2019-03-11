Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05DC20248
	for <e@80x24.org>; Mon, 11 Mar 2019 09:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfCKJJD (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 05:09:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39575 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKJJD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 05:09:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id p8so2527573wrq.6
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 02:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=b+9QFzDDVYGeYFogprWpzCT5fqJngWlq+OZeAwK3iV8=;
        b=e81W4W0hj4Hgv5LPS0qZMJPAahj4Za98CTFN6Psm9iUTWV9DmxKMtIZqW2pWBJ6Ol8
         6xIzSKBmMqRONLaxymtXY2I4usJvo98yWnQHkFjjNyWGNoBAuQQ9H5pIx3qM70q5PU+m
         7QkZ/KhFA8iZUSPKSDTfMJ7hiBQWxSf/jECrGfcwu6kv9teAeRRTrtVurQpOERvxupVV
         hoxpnabD0OGc7LfkkpfYQ8r8eqbgTcEYCjRZQuODbo1BASm3X+LDYUnEgs4T3vBWnm5o
         L7bjzr8oAj1p8Kcj+5K8M0bldKknoPG9Nm8jizrfkLh93/cmOEPqWCe/we7B1qqccMsx
         MtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=b+9QFzDDVYGeYFogprWpzCT5fqJngWlq+OZeAwK3iV8=;
        b=WS5TX6o+PFxLNVBmn/bWskvy2ZsKmAe+sajnmVMqLf9Gk2Gsr9h7QDPOFSAXX8ipfq
         +KhkoTVna/iJlpoybZYvseOPTd955Vm3eVCPxKvOvtqNZ5UhWnnPpcSgrfbyd8+KQDWp
         DPfunrSf4U3r8nDWYfWJu5eCKcP5B2qjOcLGNNQaf7h29kE5VvFJ2pJMWHYkrL9Zd+Lm
         nN5gJB1sg7QVO8st+fp4qfO+OkbsSwvWltdkfqJzkw2iCNou9Y+EIEZ/Glelwy/Vqgfn
         D9dpej7XruAOWu0K9jXEO3gF4ho01EJZruDtTII9h1yrevtww/LkQbKN/a4oGuZIIj05
         acTg==
X-Gm-Message-State: APjAAAUrkC1r08kfepX59i1+UIccmAw44RSwgTIPEAvMcSziGsHfyRUc
        Epk16xqlK4ccPpaNsKUbWFx+8abAaBs=
X-Google-Smtp-Source: APXvYqx96hTHt2viGANwCSMJGmX5YUUhmZQ+a8LCjcOMRsDZMry0veoHNfJQ2y/D7qxhonGIQGvjKw==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr14294782wrw.226.1552295339046;
        Mon, 11 Mar 2019 02:08:59 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a82sm15305072wmf.11.2019.03.11.02.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 02:08:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2019, #03; Mon, 11)
X-master-at: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
X-next-at: 810b269d1ac4b032a1c9788e5590ee2dd9ccd984
Date:   Mon, 11 Mar 2019 18:08:57 +0900
Message-ID: <xmqq8sxlkcba.fsf@gitster-ct.c.googlers.com>
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

The tip of 'next' has been rewound, ejecting a few topics that
deserve a chance for a fresh restart.  I plan to flush most of the
other topics still in 'next' to 'master' sometime this week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/guard-bswap-header (2019-03-07) 1 commit
  (merged to 'next' on 2019-03-07 at 8ba06b29d4)
 + compat/bswap: add include header guards

 The include file compat/bswap.h has been updated so that it is safe
 to (accidentally) include it more than once.


* js/find-lib-h-with-ls-files-when-possible (2019-03-05) 1 commit
  (merged to 'next' on 2019-03-07 at 0572e4704c)
 + Makefile: use `git ls-files` to list header files, if possible

 The Makefile uses 'find' utility to enumerate all the *.h header
 files, which is expensive on platforms with slow filesystems; it
 now optionally uses "ls-files" if working within a repository,
 which is a trick similar to how all sources are enumerated to run
 ETAGS on.


* js/rebase-recreate-merge (2019-03-01) 1 commit
  (merged to 'next' on 2019-03-07 at da81e64430)
 + rebase docs: fix "gitlink" typo

 Docfix.


* js/untravis-windows (2019-03-01) 1 commit
  (merged to 'next' on 2019-03-07 at 54ca7ffeea)
 + travis: remove the hack to build the Windows job on Azure Pipelines

 Dev support.


* rd/attr.c-comment-typofix (2019-03-07) 1 commit
  (merged to 'next' on 2019-03-07 at bf8e985dd8)
 + attr.c: ".gitattribute" -> ".gitattributes" (comments)

 In-code comment typofix.


* rd/gc-prune-doc-fix (2019-03-03) 1 commit
  (merged to 'next' on 2019-03-07 at fdd4dda2e0)
 + docs/git-gc: fix typo "--prune=all" to "--prune=now"

 Docfix.


* rj/hdr-check-gcrypt-fix (2019-03-06) 1 commit
  (merged to 'next' on 2019-03-07 at ef95cd3878)
 + Makefile: fix 'hdr-check' when GCRYPT not installed

 The set of header files used by "make hdr-check" unconditionally
 included sha256/gcrypt.h, even when it is not used, causing the
 make target to fail.  We now skip it when GCRYPT_SHA256 is not in
 use.


* yb/utf-16le-bom-spellfix (2019-03-07) 1 commit
  (merged to 'next' on 2019-03-07 at 541d9dca55)
 + gitattributes.txt: fix typo

 Doc update.

--------------------------------------------------
[New Topics]

* dl/ignore-docs (2019-03-08) 2 commits
 - docs: move core.excludesFile from git-add to gitignore
 - git-clean.txt: clarify ignore pattern files

 Doc update.

 Will merge to 'next'.


* jh/resize-convert-scratch-buffer (2019-03-08) 1 commit
 - convert: avoid malloc of original file size

 When the "clean" filter can reduce the size of a huge file in the
 working tree down to a small "token" (a la Git LFS), there is no
 point in allocating a huge scratch area upfront, but the buffer is
 sized based on the original file size.  The convert mechanism now
 allocates very minimum and reallocates as it receives the output
 from the clean filter process.

 Will merge to 'next'.


* jk/line-log-with-patch (2019-03-11) 2 commits
 - line-log: detect unsupported formats
 - line-log: suppress diff output with "-s"

 "git log -L<from>,<to>:<path>" with "-s" did not suppress the patch
 output as it should.  This has been corrected.

 Will merge to 'next'.


* js/rebase-deprecate-preserve-merges (2019-03-08) 1 commit
 - rebase: deprecate --preserve-merges

 "git rebase --rebase-merges" replaces its old "--preserve-merges"
 option; the latter is now marked as deprecated.

 Will merge to 'next'.


* js/init-db-update-for-mingw (2019-03-08) 1 commit
 - mingw: respect core.hidedotfiles = false in git-init again

 "git init" forgot to read platform-specific repository
 configuration, which made Windows port to ignore settings of
 core.hidedotfiles, for example.

 cf. <xmqqva0ujboi.fsf@gitster-ct.c.googlers.com>


* js/stash-in-c-pathspec-fix (2019-03-08) 2 commits
 - built-in stash: handle :(glob) pathspecs again
 - legacy stash: fix "rudimentary backport of -q"
 (this branch uses ps/stash-in-c; is tangled with tb/stas-in-c-unused-param-fix.)

 Further fixes to "git stash" reimplemented in C.

 Will merge to 'next'.


* nd/rewritten-ref-is-per-worktree (2019-03-08) 3 commits
 - Make sure refs/rewritten/ is per-worktree
 - files-backend.c: reduce duplication in add_per_worktree_entries_to_dir()
 - files-backend.c: factor out per-worktree code in loose_fill_ref_dir()

 "git rebase" uses the refs/rewritten/ hierarchy to store its
 intermediate states, which inherently makes the hierarchy per
 worktree, but it didn't quite work well.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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


* nb/branch-show-other-worktrees-head (2019-02-01) 3 commits
 - branch: add an extra verbose output displaying worktree path for refs checked out in a linked worktree
 - branch: mark and color a branch differently if it is checked out in a linked worktree
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 The top one probably deserves retitling.
 The second one is of dubious value, but if we are keeping it,
 it should also be retitled.

--------------------------------------------------
[Cooking]

* br/commit-tree-parseopt (2019-03-08) 1 commit
  (merged to 'next' on 2019-03-11 at e1228ef04f)
 + commit-tree: utilize parse-options api

 Originally merged to 'next' on 2019-03-08

 The command line parser of "git commit-tree" has been rewritten to
 use the parse-options API.

 Will merge to 'master'.


* jk/config-type-color-ends-with-lf (2019-03-07) 1 commit
  (merged to 'next' on 2019-03-11 at 810b269d1a)
 + config: document --type=color output is a complete line

 Originally merged to 'next' on 2019-03-07

 "git config --type=color ..." is meant to replace "git config --get-color"
 but there is a slight difference that wasn't documented, which is
 now fixed.

 Will merge to 'master'.


* js/remote-curl-i18n (2019-03-06) 1 commit
 - remote-curl: mark all error messages for translation
 (this branch uses js/anonymize-remote-curl-diag.)

 Error messages given from the http transport have been updated so
 that they can be localized.

 The i18n of die() messages conflicts with topics in flight, so will
 be dealt with separately when the tree is more quiescent.


* ma/asciidoctor-fixes-more (2019-03-07) 5 commits
 - Documentation: turn middle-of-line tabs into spaces
 - git-svn.txt: drop escaping '\' that ends up being rendered
 - git.txt: remove empty line before list continuation
 - config/fsck.txt: avoid starting line with dash
 - config/diff.txt: drop spurious backtick

 Documentation mark-up fixes.

 Will merge to 'next'.


* nd/diff-parseopt-3 (2019-03-07) 20 commits
 - diff-parseopt: convert --submodule
 - diff-parseopt: convert --ignore-submodules
 - diff-parseopt: convert --textconv
 - diff-parseopt: convert --ext-diff
 - diff-parseopt: convert --quiet
 - diff-parseopt: convert --exit-code
 - diff-parseopt: convert --color-words
 - diff-parseopt: convert --word-diff-regex
 - diff-parseopt: convert --word-diff
 - diff-parseopt: convert --[no-]color
 - diff-parseopt: convert --[no-]follow
 - diff-parseopt: convert -R
 - diff-parseopt: convert -a|--text
 - diff-parseopt: convert --full-index
 - diff-parseopt: convert --binary
 - diff-parseopt: convert --anchored
 - diff-parseopt: convert --diff-algorithm
 - diff-parseopt: convert --histogram
 - diff-parseopt: convert --patience
 - diff-parseopt: convert --[no-]indent-heuristic

 Third batch to teach the diff machinery to use the parse-options
 API.


* jt/test-protocol-version (2019-03-07) 8 commits
 - t5552: compensate for v2 filtering ref adv.
 - tests: fix protocol version for overspecifications
 - t5700: only run with protocol version 1
 - t5512: compensate for v0 only sending HEAD symrefs
 - t5503: fix overspecification of trace expectation
 - tests: always test fetch of unreachable with v0
 - t5601: check ssh command only with protocol v0
 - tests: define GIT_TEST_PROTOCOL_VERSION

 Help developers by making it easier to run most of the tests under
 different versions of over-the-wire protocols.


* jk/bisect-final-output (2019-03-01) 3 commits
  (merged to 'next' on 2019-03-11 at dea599eb04)
 + bisect: make diff-tree output prettier
 + bisect: fix internal diff-tree config loading
 + bisect: use string arguments to feed internal diff-tree

 Originally merged to 'next' on 2019-03-07

 The final report from "git bisect" used to show the suspected
 culprit using a raw "diff-tree", with which there is no output for
 a merge commit.  This has been updated to use a more modern and
 human readable output that still is concise enough.

 Will merge to 'master'.


* jk/fsck-doc (2019-03-05) 2 commits
  (merged to 'next' on 2019-03-11 at 5cd610f73e)
 + fsck: always compute USED flags for unreachable objects
 + doc/fsck: clarify --connectivity-only behavior

 Originally merged to 'next' on 2019-03-07

 "git fsck --connectivity-only" omits computation necessary to sift
 the objects that are not reachable from any of the refs into
 unreachable and dangling.  This is now enabled when dangling
 objects are requested (which is done by default, but can be
 overridden with the "--no-dangling" option).

 Will merge to 'master'.


* jk/no-sigpipe-during-network-transport (2019-03-05) 2 commits
  (merged to 'next' on 2019-03-11 at 25900acd0d)
 + fetch: ignore SIGPIPE during network operation
 + fetch: avoid calling write_or_die()

 Originally merged to 'next' on 2019-03-07

 On platforms where "git fetch" is killed with SIGPIPE (e.g. OSX),
 the upload-pack that runs on the other end that hangs up after
 detecting an error could cause "git fetch" to die with a signal,
 which led to a flakey test.  "git fetch" now ignores SIGPIPE during
 the network portion of its operation (this is not a problem as we
 check the return status from our write(2)s).

 Will merge to 'master'.


* jk/virtual-objects-do-exist (2019-03-05) 1 commit
  (merged to 'next' on 2019-03-11 at 748c79a1f0)
 + rev-list: allow cached objects in existence check

 Originally merged to 'next' on 2019-03-07

 A recent update broke "is this object available to us?" check for
 well-known objects like an empty tree (which should yield "yes",
 even when there is no on-disk object for an empty tree), which has
 been corrected.

 Will merge to 'master'.


* js/anonymize-remote-curl-diag (2019-03-05) 1 commit
 - curl: anonymize URLs in error messages and warnings
 (this branch is used by js/remote-curl-i18n.)

 remote-http transport did not anonymize URLs reported in its error
 messages at places.

 Will merge to 'next'.


* js/rebase-orig-head-fix (2019-03-04) 4 commits
  (merged to 'next' on 2019-03-11 at 4b1b19d391)
 + built-in rebase: set ORIG_HEAD just once, before the rebase
 + built-in rebase: demonstrate that ORIG_HEAD is not set correctly
 + built-in rebase: use the correct reflog when switching branches
 + built-in rebase: no need to check out `onto` twice

 Originally merged to 'next' on 2019-03-07

 "git rebase" that was reimplemented in C did not set ORIG_HEAD
 correctly, which has been corrected.

 Will merge to 'master'.


* js/stress-test-ui-tweak (2019-03-04) 2 commits
  (merged to 'next' on 2019-03-11 at 223afded1c)
 + tests: introduce --stress-jobs=<N>
 + tests: let --stress-limit=<N> imply --stress

 Originally merged to 'next' on 2019-03-07

 Dev support.

 Will merge to 'master'.


* ma/asciidoctor-fixes (2019-03-11) 5 commits
 - asciidoctor-extensions: fix spurious space after linkgit in *.html
 - Documentation/Makefile: add missing dependencies on asciidoctor-extensions
 - asciidoctor-extensions: fix spurious space after linkgit
 - Documentation/Makefile: add missing dependency on asciidoctor-extensions
 - Documentation/Makefile: add missing xsl dependencies for manpages

 Build fix around use of asciidoctor instead of asciidoc

 Ejected out of 'next' to allow a cleaner reroll.


* nd/worktree-name-sanitization (2019-03-11) 2 commits
 - SQUASH???
 - worktree add: sanitize worktree names

 In recent versions of Git, per-worktree refs are exposed in
 refs/worktrees/<wtname>/ hierarchy, which means that worktree names
 must be a valid refname component.  The code now sanitizes the names
 given to worktrees, to make sure these refs are not malforked.


* ra/t3600-test-path-funcs (2019-03-08) 3 commits
 - t3600: use helpers to replace test -d/f/e/s <path>
 - t3600: modernize style
 - test functions: add function `test_file_not_empty`

 A GSoC micro.

 I think this is almost there.


* dl/reset-doc-no-wrt-abbrev (2019-03-06) 1 commit
 - git-reset.txt: clarify documentation

 Doc update.

 Will merge to 'next'.


* ja/dir-rename-doc-markup-fix (2019-03-06) 1 commit
 - Doc: fix misleading asciidoc formating

 Doc update.

 Will merge to 'next'.


* bp/post-index-change-hook (2019-02-15) 1 commit
  (merged to 'next' on 2019-03-11 at cb96d1d7c4)
 + read-cache: add post-index-change hook

 Originally merged to 'next' on 2019-02-23

 A new hook "post-index-change" is called when the on-disk index
 file changes, which can help e.g. a virtualized working tree
 implementation.

 Will cook in 'next'.


* jc/format-patch-error-check (2019-02-22) 3 commits
 - format-patch: --no-clobber refrains from overwriting output files
 - format-patch: notice failure to open cover letter for writing
 - builtin/log: downcase the beginning of error messages

 "git format-patch" used overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Will merge to 'next' after dropping the tip commit.
 I think the bottom two were indenendently good changes; the top one
 was met with "Meh" by reviewer(s), and I tend to agree.


* ab/makefile-help-devs-more (2019-02-24) 6 commits
  (merged to 'next' on 2019-03-11 at 898f5f44bc)
 + Makefile: allow for combining DEVELOPER=1 and CFLAGS="..."
 + Makefile: move the setting of *FLAGS closer to "include"
 + Makefile: Move *_LIBS assignment into its own section
 + Makefile: add/remove comments at top and tweak whitespace
 + Makefile: move "strip" assignment down from flags
 + Makefile: remove an out-of-date comment

 Originally merged to 'next' on 2019-03-07

 CFLAGS now can be tweaked when invoking Make while using
 DEVELOPER=YesPlease; this did not work well before.

 Will merge to 'master'.


* jt/fetch-cdn-offload (2019-03-11) 8 commits
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


* dl/submodule-set-branch (2019-02-08) 3 commits
 - submodule: teach set-branch subcommand
 - submodule--helper: teach config subcommand --unset
 - git-submodule.txt: "--branch <branch>" option defaults to 'master'

 "git submodule" learns "set-branch" subcommand that allows the
 submodule.*.branch settings to be modified.

 Needs sign-off on the tip commit; other than that it seems OK to be in 'next'.


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
  (merged to 'next' on 2019-03-11 at f3db1c278f)
 + setup: fix memory leaks with `struct repository_format`
 + setup: free old value before setting `work_tree`

 Originally merged to 'next' on 2019-03-07

 The setup code has been cleaned up to avoid leaks around the
 repository_format structure.

 Will merge to 'master'.


* dl/merge-cleanup-scissors-fix (2019-03-11) 8 commits
 - cherry-pick/revert: add scissors line on merge conflict
 - sequencer.c: define get_config_from_cleanup
 - merge: add scissors line on merge conflict
 - merge: cleanup messages like commit
 - sequencer.c: remove duplicate code
 - commit: extract cleanup_mode functions to sequencer
 - t3507: cleanup space after redirection operators
 - t7600: clean up 'merge --squash c3 with c7' test

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 cf. <cover.1552275703.git.liu.denton@gmail.com>


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* ag/sequencer-reduce-rewriting-todo (2019-03-07) 18 commits
 - rebase--interactive: move transform_todo_file()
 - sequencer: use edit_todo_list() in complete_action()
 - rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 - rebase-interactive: append_todo_help() changes
 - rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 - sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 - rebase--interactive: move rearrange_squash_in_todo_file()
 - rebase--interactive: move sequencer_add_exec_commands()
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
 (this branch is used by js/stash-in-c-pathspec-fix and tb/stas-in-c-unused-param-fix.)

 Originally merged to 'next' on 2019-03-07

 "git stash" rewritten in C.

 Will cook in 'next'.
