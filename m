Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5A61F453
	for <e@80x24.org>; Tue, 29 Jan 2019 22:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfA2WPn (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 17:15:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43000 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfA2WPn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 17:15:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so23861215wrx.9
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 14:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=VpRuZRc9rDTtXgBjm4KB1eDf1xjsiYyOFxdtDIfuxsk=;
        b=ZYZtsXYa2naHkjrMGD0K0BhEwhEzJX07PzqTXB+0zay+nEScaA0f0Mq9Qn+sXpf+Z/
         srvE8Ngcw+K7RkovaKKcJsCWz0W0q3iT11N1bEmXCpvcJx6xIo4jevQKaCxJfOqY7MiA
         nboD5ogDz9xZlFB/gQ76jGQV7abgwWTuJM5VhxgexjP779PnpxjxLEhrIb+c9KF1xm3f
         FXKfeDottRjxN3snzl7utePxRsSGZQu+lnbxEkytcdO8ARsBm2HttpVgOhpI+6/GGbjy
         LIopEmae73mvch39tGm2nr+ZG295xltSA1G/b1y1o6LryZiK/KOuJrAqfVNogTvPryEt
         yVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=VpRuZRc9rDTtXgBjm4KB1eDf1xjsiYyOFxdtDIfuxsk=;
        b=Ob4X8hS/SkN9AvGF2OFPWBU6nJLjKG/Ej8kM5xWUAHT2CoH/+AjAgKWY/MScJmU7ev
         3mVA/Vwgd9Nqr2r5Q1CSdBx+e7m0WApVodapc+c6UBSzglUat+RAZ97pan5DDGwqo02p
         m/4y8EBy6CN2RYPF0Az/t6l1QsBqJ4kPPhvgws6Tv4tQZlrSM9IQG955cV/+3t4RWZHp
         HBdSMHrCHjj11cq4IwpYe6veASTIjAiNOLFRtP1aBWAn3F/lXBDBEHjx8BvPTTiM9nEX
         YYMKwEVfOGdoi2MX/NB4vLZEs6YGKCbVVwNWVSmC0akpGweUZ4dc2fwO0Ruu0rnYP+gu
         +hgA==
X-Gm-Message-State: AJcUuke1YwRFu866iFfkpMVp6EY5QFz58nD5W84UQoyCW+Tg6mU5dYTc
        tq9lN8OR9YeugiBHaqOffwuJkfzm
X-Google-Smtp-Source: ALg8bN5jTx3ZZF/NvA58zNmNCWvC70YoZbraNuZa8M0I2YDGrjQS644v7X2z3VZg8IZ0St+iEFz4OQ==
X-Received: by 2002:a5d:5409:: with SMTP id g9mr28187413wrv.88.1548800137891;
        Tue, 29 Jan 2019 14:15:37 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g16sm106722172wru.41.2019.01.29.14.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 14:15:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2019, #05; Tue, 29)
X-master-at: b5101f929789889c2e536d915698f58d5c5c6b7a
X-next-at: fbb209baf1b5c34e4ec52fb4a5a73b00cfbecec1
Date:   Tue, 29 Jan 2019 14:15:36 -0800
Message-ID: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
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

The fourth batch of topics are in 'master', and we now have ~240
non-merge commits since the last feature release.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ds/commit-graph-format-v2 (2019-01-29) 8 commits
 - SQUASH : misnamed variables and style fix
 - commit-graph: test verifying a corrupt v2 header
 - commit-graph: implement file format version 2
 - commit-graph: add --version=<n> option
 - commit-graph: create new version flags
 - commit-graph: collapse parameters into flags
 - commit-graph: return with errors during write
 - Merge branch 'bc/sha-256' into ds/commit-graph-format-v2
 (this branch uses ab/commit-graph-write-optim and ab/commit-graph-write-progress.)

 Introduce version 2 of the commit-graph format to correct
 deficiency in the initial version.


* ds/coverage-prove (2019-01-29) 1 commit
 - Makefile: add coverage-prove target

 A new target "coverage-prove" to run the coverage test under
 "prove" has been added.

 Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

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
 (this branch is used by ds/commit-graph-format-v2.)

 Add sha-256 hash and plug it through the code to allow building Git
 with the "NewHash".


* bc/tree-walk-oid (2019-01-15) 5 commits
  (merged to 'next' on 2019-01-18 at 60c38b9e4a)
 + cache: make oidcpy always copy GIT_MAX_RAWSZ bytes
 + tree-walk: store object_id in a separate member
 + match-trees: use hashcpy to splice trees
 + match-trees: compute buffer offset correctly when splicing
 + tree-walk: copy object ID before use

 The code to walk tree objects has been taught that we may be
 working with object names that are not computed with SHA-1.


* cc/fetch-error-message-fix (2019-01-14) 1 commit
  (merged to 'next' on 2019-01-14 at 81078f86c0)
 + fetch: fix extensions.partialclone name in error message

 Error message fix.


* cc/partial-clone-doc-typofix (2019-01-14) 1 commit
  (merged to 'next' on 2019-01-14 at 0395de767e)
 + partial-clone: add missing 'is' in doc

 Doc fix.


* it/log-format-source (2019-01-11) 1 commit
  (merged to 'next' on 2019-01-18 at d660044e93)
 + log: add %S option (like --source) to log --format

 Custom userformat "log --format" learned %S atom that stands for
 the tip the traversal reached the commit from, i.e. --source.


* ja/doc-build-l10n (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-18 at 5dbe5ad3d7)
 + Documentation/Makefile add optional targets for l10n

 Prepare Documentation/Makefile so that manpage localization can
 reuse it by overriding and tweaking the list of build products.


* jk/proto-v2-hidden-refs-fix (2019-01-10) 1 commit
  (merged to 'next' on 2019-01-18 at 875dbbc71f)
 + upload-pack: support hidden refs with protocol v2

 The v2 upload-pack protocol implementation failed to honor
 hidden-ref configuration, which has been corrected.
 An earlier attempt reverted out of 'next'.


* jk/remote-insteadof-cleanup (2019-01-11) 1 commit
  (merged to 'next' on 2019-01-18 at 112c93eef3)
 + remote: check config validity before creating rewrite struct

 Code clean-up.


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


* js/add-e-clear-patch-before-stating (2019-01-15) 1 commit
  (merged to 'next' on 2019-01-18 at 9ea7fc4b49)
 + add --edit: truncate the patch file

 "git add -e" got confused when the change it wants to let the user
 edit is smaller than the previous change that was left over in a
 temporary file.


* js/rebase-i-redo-exec (2018-12-11) 3 commits
  (merged to 'next' on 2019-01-18 at 71be3fedb7)
 + rebase: introduce a shortcut for --reschedule-failed-exec
 + rebase: add a config option to default to --reschedule-failed-exec
 + rebase: introduce --reschedule-failed-exec

 "git rebase -i" learned to re-execute a command given with 'exec'
 to run after it failed the last time.


* jt/fetch-pack-v2 (2019-01-10) 1 commit
  (merged to 'next' on 2019-01-18 at 75ceb55ff8)
 + fetch-pack: support protocol version 2

 "git fetch-pack" now can talk the version 2 protocol.


* jt/upload-pack-deepen-relative-proto-v2 (2019-01-10) 2 commits
  (merged to 'next' on 2019-01-18 at 1483ad21db)
 + upload-pack: teach deepen-relative in protocol v2
 + fetch-pack: do not take shallow lock unnecessarily

 "git fetch --deepen=<more>" has been corrected to work over v2
 protocol.


* kg/external-diff-save-env (2019-01-11) 1 commit
  (merged to 'next' on 2019-01-14 at 8281bbd48b)
 + diff: ensure correct lifetime of external_diff_cmd

 The code to drive GIT_EXTERNAL_DIFF command relied on the string
 returned from getenv() to be non-volatile, which is not true, that
 has been corrected.


* ms/http-no-more-failonerror (2019-01-10) 5 commits
  (merged to 'next' on 2019-01-18 at 8938d70b6d)
 + test: test GIT_CURL_VERBOSE=1 shows an error
 + remote-curl: unset CURLOPT_FAILONERROR
 + remote-curl: define struct for CURLOPT_WRITEFUNCTION
 + http: enable keep_error for HTTP requests
 + http: support file handles for HTTP_KEEP_ERROR

 Debugging help for http transport.


* os/rebase-runs-post-checkout-hook (2019-01-02) 2 commits
  (merged to 'next' on 2019-01-18 at a03d536318)
 + rebase: run post-checkout hook on checkout
 + t5403: simplify by using a single repository

 "git rebase" internally runs "checkout" to switch between branches,
 and the command used to call the post-checkout hook, but the
 reimplementation stopped doing so, which is getting fixed.


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

--------------------------------------------------
[Cooking]

* js/filter-options-should-use-plain-int (2019-01-15) 1 commit
  (merged to 'next' on 2019-01-18 at 6714547e6d)
 + filter-options: expand scaled numbers
 (this branch uses md/list-objects-filter-by-depth and sb/more-repo-in-api; is tangled with jt/get-reference-with-commit-graph.)

 Update the protocol message specification to allow only the limited
 use of scaled quantities.  This is ensure potential compatibility
 issues will not go out of hand.

 Will merge to 'master'.


* jt/get-reference-with-commit-graph (2018-12-28) 1 commit
  (merged to 'next' on 2019-01-18 at bfc4eb9411)
 + revision: use commit graph in get_reference()
 (this branch uses sb/more-repo-in-api; is tangled with js/filter-options-should-use-plain-int and md/list-objects-filter-by-depth.)

 Micro-optimize the code that prepares commit objects to be walked
 by "git rev-list" when the commit-graph is available.

 Will merge to 'master'.


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

 Will merge to 'master'.


* br/commit-tree-fully-spelled-gpg-sign-option (2019-01-22) 2 commits
 - commit-tree: add missing --gpg-sign flag
 - t7510: invoke git as part of &&-chain

 The documentation of "git commit-tree" said that the command
 understands "--gpg-sign" in addition to "-S", but the command line
 parser did not know about the longhand, which has been corrected.

 Will merge to 'next'.


* dt/cat-file-batch-ambiguous (2019-01-18) 2 commits
 - t1512: test ambiguous cat-file --batch and --batch-output
 - Do not print 'dangling' for cat-file in case of ambiguity

 Needswork on the tip commit.
 cf. <20190123111117.GS840@szeder.dev>


* jk/attr-macro-fix (2019-01-22) 1 commit
  (merged to 'next' on 2019-01-29 at 740df172e1)
 + attr: do not mark queried macros as unset

 Asking "git check-attr" about a macro (e.g. "binary") on a specific
 path did not work correctly, even though "git check-attr -a" listed
 such a macro correctly.  This has been corrected.

 Will merge to 'master'.


* js/test-git-installed (2019-01-22) 1 commit
  (merged to 'next' on 2019-01-29 at bab6eabb20)
 + tests: explicitly use `test-tool.exe` on Windows

 Test fix for Windows.

 Will merge to 'master'.


* ph/pack-objects-mutex-fix (2019-01-28) 2 commits
  (merged to 'next' on 2019-01-29 at 7c886f6c33)
 + pack-objects: merge read_lock and lock in packing_data struct
 + pack-objects: move read mutex to packing_data struct

 "git pack-objects" incorrectly used uninitialized mutex, which has
 been corrected.

 Will merge to 'master'.


* sb/submodule-abort-update-upon-config-failure (2019-01-18) 1 commit
 - git-submodule: abort if core.worktree could not be set correctly

 "git submodule update" learned to abort early when core.worktree
 for the submodule is not set correctly to prevent spreading damage.

 Will merge to 'next'.


* tb/test-lint-sed-options (2019-01-28) 1 commit
 - test-lint: only use only sed [-n] [-e command] [-f command_file]

 The test lint learned to catch non-portable "sed" options.

 Will merge to 'next'.


* tb/utf-16-le-with-explicit-bom (2019-01-22) 1 commit
 - Support working-tree-encoding "UTF-16LE-BOM"

 A new encoding UTF-16LE-BOM has been invented to force encoding to
 UTF-16 with BOM in little endian byte order, which cannot be directly
 generated by using iconv.

 Hold.
 cf. <20190129072228.dcyyjpcgqk7c44j4@tb-raspi4>


* ja/doc-style-fix (2019-01-23) 1 commit
  (merged to 'next' on 2019-01-29 at 5b520a6fd3)
 + doc: tidy asciidoc style

 Doc typo/stylo fixes.

 Will merge to 'master'.


* az/instaweb-py3-http-server (2019-01-28) 1 commit
  (merged to 'next' on 2019-01-29 at 82f06b6774)
 + git-instaweb: add Python builtin http.server support

 "git instaweb" learned to drive http.server that comes with
 "batteries included" Python installation (both Python2 & 3).

 Will merge to 'master'.


* jh/trace2 (2019-01-28) 14 commits
 - trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
 - trace2:data: add subverb for rebase
 - trace2:data: add subverb to reset command
 - trace2:data: add subverb to checkout command
 - pack-objects: add trace2 regions
 - trace2:data: add trace2 instrumentation to index read/write
 - trace2:data: add trace2 hook classification
 - trace2:data: add trace2 transport child classification
 - trace2:data: add trace2 sub-process classification
 - trace2:data: add editor/pager child classification
 - trace2:data: add trace2 regions to wt-status
 - trace2: collect platform-specific process information
 - trace2: create new combined trace facility
 - trace2: Documentation/technical/api-trace2.txt

 A more structured way to obtain execution trace has been added.

 Ready?


* jk/diff-cc-stat-fixes (2019-01-24) 6 commits
  (merged to 'next' on 2019-01-29 at 8bd04f1749)
 + combine-diff: treat --dirstat like --stat
 + combine-diff: treat --summary like --stat
 + combine-diff: treat --shortstat like --stat
 + combine-diff: factor out stat-format mask
 + diff: clear emitted_symbols flag after use
 + t4006: resurrect commented-out tests

 "git diff --color-moved --cc --stat -p" did not work well due to
 funny interaction between a bug in color-moved and the rest, which
 has been fixed.

 Will merge to 'master'.


* jk/unused-parameter-cleanup (2019-01-24) 8 commits
 - convert: drop path parameter from actual conversion functions
 - convert: drop len parameter from conversion checks
 - config: drop unused parameter from maybe_remove_section()
 - show_date_relative(): drop unused "tz" parameter
 - column: drop unused "opts" parameter in item_length()
 - create_bundle(): drop unused "header" parameter
 - apply: drop unused "def" parameter from find_name_gnu()
 - match-trees: drop unused path parameter from score functions

 Code cleanup.

 Will merge to 'next'.


* nd/fetch-compact-update (2019-01-27) 1 commit
  (merged to 'next' on 2019-01-29 at b78e8841b0)
 + fetch: prefer suffix substitution in compact fetch.output

 "git fetch" output cleanup.

 Will merge to 'master'.


* sg/object-as-type-commit-graph-fix (2019-01-27) 1 commit
  (merged to 'next' on 2019-01-29 at cc714a044a)
 + object_as_type: initialize commit-graph-related fields of 'struct commit'

 The commit-graph facility did not work when in-core objects that
 are promoted from unknown type to commit (e.g. a commit that is
 accessed via a tag that refers to it) were involved, which has been
 corrected.

 Will merge to 'master'.


* sg/strbuf-addbuf-cocci (2019-01-27) 1 commit
  (merged to 'next' on 2019-01-29 at a9f7279d38)
 + strbuf.cocci: suggest strbuf_addbuf() to add one strbuf to an other

 Cocci rule update.

 Will merge to 'master'.


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


* jk/autocrlf-overrides-eol-doc (2019-01-29) 2 commits
 - docs/config: clarify "text property" in core.eol
 - doc/gitattributes: clarify "autocrlf overrides eol"

 Documentation around core.crlf has been updated.

 Will merge to 'next'.


* pw/no-editor-in-rebase-i-implicit (2019-01-28) 1 commit
  (merged to 'next' on 2019-01-29 at 9d06993725)
 + implicit interactive rebase: don't run sequence editor

 When GIT_SEQUENCE_EDITOR is set, the command was incorrectly
 started when modes of "git rebase" that implicitly uses the
 machinery for the interactive rebase are run, which has been
 corrected.

 Will merge to 'master'.


* pw/rebase-x-sanity-check (2019-01-29) 1 commit
 - rebase -x: sanity check command

 "git rebase -x $cmd" did not reject multi-line command, even though
 the command is incapable of handling such a command.  It now is
 rejected upfront.

 Will merge to 'next'.


* ab/commit-graph-write-optim (2019-01-22) 1 commit
  (merged to 'next' on 2019-01-29 at 17c894dfec)
 + commit-graph write: use pack order when finding commits
 (this branch is used by ab/commit-graph-write-progress and ds/commit-graph-format-v2.)

 The codepath to write out commit-graph has been optimized by
 following the usual pattern of visiting objects in in-pack order.

 Will merge to 'master'.


* ab/commit-graph-write-progress (2019-01-23) 9 commits
  (merged to 'next' on 2019-01-29 at e086b1cba6)
 + commit-graph write: emit a percentage for all progress
 + commit-graph write: add itermediate progress
 + commit-graph write: remove empty line for readability
 + commit-graph write: add more descriptive progress output
 + commit-graph write: show progress for object search
 + commit-graph write: more descriptive "writing out" output
 + commit-graph write: add "Writing out" progress output
 + commit-graph: don't call write_graph_chunk_extra_edges() unnecessarily
 + commit-graph: rename "large edges" to "extra edges"
 (this branch is used by ds/commit-graph-format-v2; uses ab/commit-graph-write-optim.)

 The codepath to show progress meter while writing out commit-graph
 file has been improved.

 Will merge to 'master'.


* cc/test-ref-store-typofix (2019-01-17) 1 commit
  (merged to 'next' on 2019-01-29 at 0cd264f864)
 + helper/test-ref-store: fix "new-sha1" vs "old-sha1" typo

 An obvious typo in an assertion error message has been fixed.

 Will merge to 'master'.


* jk/add-ignore-errors-bit-assignment-fix (2019-01-17) 1 commit
  (merged to 'next' on 2019-01-29 at a4ac7ccd4f)
 + add: use separate ADD_CACHE_RENORMALIZE flag

 "git add --ignore-errors" did not work as advertised and instead
 worked as an unintended synonym for "git add --renormalize", which
 has been fixed.

 Will merge to 'master'.


* js/mingw-unc-path-w-backslashes (2019-01-18) 2 commits
  (merged to 'next' on 2019-01-29 at 3adc177c1e)
 + mingw: special-case arguments to `sh`
 + mingw (t5580): document bug when cloning from backslashed UNC paths

 In Git for Windows, "git clone \\server\share\path" etc. that uses
 UNC paths from command line had bad interaction with its shell
 emulation.

 Will merge to 'master'.


* js/t6042-timing-fix (2019-01-17) 1 commit
  (merged to 'next' on 2019-01-29 at 9543c96249)
 + t6042: work around speed optimization on Windows

 Test update.

 Will merge to 'master'.


* jt/namespaced-ls-refs-fix (2019-01-18) 1 commit
  (merged to 'next' on 2019-01-29 at 049530f499)
 + ls-refs: filter refs using namespace-stripped name

 Fix namespace support in protocol v2.

 Will merge to 'master'.


* bp/checkout-new-branch-optim (2019-01-23) 2 commits
  (merged to 'next' on 2019-01-29 at 89d690634d)
 + checkout: fix regression in checkout -b on intitial checkout
 + checkout: add test demonstrating regression with checkout -b on initial commit

 "git checkout -b <new> [HEAD]" to create a new branch from the
 current commit and check it out ought to be a no-op in the index
 and the working tree in normal cases, but there are corner cases
 that do require updates to the index and the working tree.  Running
 it immediately after "git clone --no-checkout" is one of these
 cases that an earlier optimization kicked in incorrectly, which has
 been fixed.

 Will merge to 'master'.


* br/blame-ignore (2019-01-18) 3 commits
 - blame: add a config option to mark ignored lines
 - blame: add the ability to ignore commits and their changes
 - Move init_skiplist() outside of fsck

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Is this ready for 'next'?


* js/abspath-part-inside-repo (2019-01-18) 1 commit
  (merged to 'next' on 2019-01-29 at ac642158ec)
 + abspath_part_inside_repo: respect core.ignoreCase

 On a case-insensitive filesystem, we failed to compare the part of
 the path that is above the worktree directory in an absolute
 pathname, which has been corrected.

 Will merge to 'master'.


* nd/diff-parseopt (2019-01-27) 14 commits
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
 - parse-options: add one-shot mode
 - parse-options.h: remove extern on function prototypes

 The diff machinery, one of the oldest parts of the system, which
 long predates the parse-options API, uses fairly long and complex
 handcrafted option parser.  This is being rewritten to use the
 parse-options API.

 Will merge to 'next'.
 Looking good.


* sc/pack-redundant (2019-01-14) 5 commits
 - pack-redundant: consistent sort method
 - pack-redundant: rename pack_list.all_objects
 - pack-redundant: remove unused functions
 - pack-redundant: new algorithm to find min packs
 - t5323: test cases for git-pack-redundant

 Update the implementation of pack-redundant for performance in a
 repository with many packfiles.

 Comments?


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
  (merged to 'next' on 2019-01-29 at 568cafa7f4)
 + compat/obstack: fix -Wcast-function-type warnings

 The compat/obstack code had casts that -Wcast-function-type
 compilation option found questionable.

 Will merge to 'master'.


* jt/fetch-v2-sideband (2019-01-17) 5 commits
  (merged to 'next' on 2019-01-29 at c8c6f11f77)
 + tests: define GIT_TEST_SIDEBAND_ALL
 + {fetch,upload}-pack: sideband v2 fetch response
 + sideband: reverse its dependency on pkt-line
 + pkt-line: introduce struct packet_writer
 + Merge branch 'ms/packet-err-check' into jt/fetch-v2-sideband
 (this branch uses ms/packet-err-check.)

 "git fetch" and "git upload-pack" learned to send all exchange over
 the sideband channel while talking the v2 protocol.

 Will merge to 'master'.


* ld/git-p4-shelve-update-fix (2019-01-18) 2 commits
  (merged to 'next' on 2019-01-29 at 02e8752ec8)
 + git-p4: handle update of moved/copied files when updating a shelve
 + git-p4: add failing test for shelved CL update involving move/copy

 "git p4" failed to update a shelved change when there were moved
 files, which has been corrected.

 Will merge to 'master'.


* ma/clear-repository-format (2019-01-23) 2 commits
 - setup: fix memory leaks with `struct repository_format`
 - setup: free old value before setting `work_tree`

 The setup code has been cleaned up to avoid leaks around the
 repository_format structure.

 cf. <20190124001450.GR423984@genre.crustytoothpaste.net>


* nd/the-index-final (2019-01-24) 11 commits
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

 Will merge to 'next'.


* jp/author-committer-config (2019-01-02) 2 commits
 - DONTMERGE
 - Add author and committer configuration settings

 Four new configuration variables {author,committer}.{name,email}
 have been introduced to override user.{name,email} in more specific
 cases.

 Expecting a reroll.
 cf. <xmqq1s5uk6qh.fsf@gitster-ct.c.googlers.com>
 cf. <20190128233022.GA29068@whubbs1.gaikai.biz>


* js/rebase-am (2019-01-18) 4 commits
 - built-in rebase: call `git am` directly
 - rebase: teach `reset_head()` to optionally skip the worktree
 - rebase: avoid double reflog entry when switching branches
 - rebase: move `reset_head()` into a better spot

 Instead of going through "git-rebase--am" scriptlet to use the "am"
 backend, the built-in version of "git rebase" learned to drive the
 "am" backend directly.

 Will merge to 'next'.


* ms/packet-err-check (2019-01-02) 2 commits
 + pack-protocol.txt: accept error packets in any context
 + Use packet_reader instead of packet_read_line
 (this branch is used by jt/fetch-v2-sideband.)

 Error checking of data sent over the pack-protocol has been
 revamped so that error packets are always diagnosed properly.

 Will merge to 'next'.


* tt/bisect-in-c (2019-01-02) 7 commits
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C

 More code in "git bisect" has been rewritten in C.

 Will merge to 'next'.


* jk/loose-object-cache-oid (2019-01-08) 11 commits
 - prefer "hash mismatch" to "sha1 mismatch"
 - sha1-file: avoid "sha1 file" for generic use in messages
 - sha1-file: prefer "loose object file" to "sha1 file" in messages
 - sha1-file: drop has_sha1_file()
 - convert has_sha1_file() callers to has_object_file()
 - sha1-file: convert pass-through functions to object_id
 - sha1-file: modernize loose header/stream functions
 - sha1-file: modernize loose object file functions
 - http: use struct object_id instead of bare sha1
 - update comment references to sha1_object_info()
 - sha1-file: fix outdated sha1 comment references

 Code clean-up.

 Will merge to 'next'.


* lt/date-human (2019-01-29) 5 commits
 - Add `human` date format tests.
 - Add `human` format to test-tool
 - Add 'human' date format documentation
 - Replace the proposed 'auto' mode with 'auto:'
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 going to the pager or to the terminal and otherwise the default
 format.

 Will merge to 'next'.


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


* js/commit-graph-chunk-table-fix (2019-01-15) 3 commits
  (merged to 'next' on 2019-01-29 at 65ea01d4f2)
 + Makefile: correct example fuzz build
 + commit-graph: fix buffer read-overflow
 + commit-graph, fuzz: add fuzzer for commit-graph

 The codepath to read from the commit-graph file attempted to read
 past the end of it when the file's table-of-contents was corrupt.

 Will merge to 'master'.


* dl/merge-cleanup-scissors-fix (2019-01-27) 5 commits
 - init docs: correct a punctuation typo
 - merge: add scissors line on merge conflict
 - merge: cleanup messages like commit
 - t7600: clean up 'merge --squash c3 with c7' test
 - commit: extract cleanup_mode functions to sequencer

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Comments?


* aw/pretty-trailers (2019-01-29) 7 commits
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

 Comments?


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

 Will merge to 'next'.


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

 Is this ready for 'next'?


* js/smart-http-detect-remote-error (2019-01-07) 3 commits
 - remote-curl: die on server-side errors
 - remote-curl: tighten "version 2" check for smart-http
 - remote-curl: refactor smart-http discovery

 Some errors from the other side coming over smart HTTP transport
 were not noticed, which has been corrected.

 Will merge to 'next'.


* nb/branch-show-other-worktrees-head (2019-01-23) 3 commits
 - branch: add an extra verbose output displaying worktree path for refs checked out in a linked worktree
 - branch: mark and color a branch differently if it is checked out in a linked worktree
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 The second one is of dubious value.  Needs sign-off.


* js/vsts-ci (2019-01-29) 21 commits
 - ci: parallelize testing on Windows
 - ci: speed up Windows phase
 - tests: optionally skip bin-wrappers/
 - t0061: workaround issues with --with-dashes and RUNTIME_PREFIX
 - tests: add t/helper/ to the PATH with --with-dashes
 - mingw: try to work around issues with the test cleanup
 - tests: include detailed trace logs with --write-junit-xml upon failure
 - tests: avoid calling Perl just to determine file sizes
 - README: add a build badge (status of the Azure Pipelines build)
 - mingw: be more generous when wrapping up the setitimer() emulation
 - ci: use git-sdk-64-minimal build artifact
 - ci: add a Windows job to the Azure Pipelines definition
 - Add a build definition for Azure DevOps
 - ci/lib.sh: add support for Azure Pipelines
 - tests: optionally write results as JUnit-style .xml
 - test-date: add a subcommand to measure times in shell scripts
 - ci: use a junction on Windows instead of a symlink
 - ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
 - ci/lib.sh: encapsulate Travis-specific things
 - ci: rename the library of common functions
 - travis: fix skipping tagged releases

 Prepare to run test suite on Azure Pipeline.

 Will merge to 'next'.


* du/branch-show-current (2018-10-26) 1 commit
 - branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 I am personally not yet quite convinced if this is worth pursuing.


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

 Comments?


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
