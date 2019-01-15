Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E65211B4
	for <e@80x24.org>; Tue, 15 Jan 2019 22:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391119AbfAOWbN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 17:31:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35486 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfAOWbN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 17:31:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so4822440wrb.2
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 14:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=luw6TAIXikW6der+0MpPimElAlpauRhvWpXJabmBnp8=;
        b=agrlcR4YaXzzCr/zDfHtv1v2sth1wIbNFBstvLMuHXzwUdkmMynQf7QKBUHAnS1gnY
         B6vZY99aFhnHU3A6btvTp8thT/E+nqkzyq+zq/FD5OQecEKnm83NQc8gopLlOjcZDpwQ
         zoWGOvBwL8S0II7PjOW3cy4gMmwExnylDVpIqQ87+jlch+o3atEwu/fERVaMYdBu8T9E
         xIYxIQWP8rxOiwYmcKcbn1TmX6ELa+vSWj38yqUyFjXMCli9Y0Eqpr+QT20YfdytdFaV
         GifIBn8ynBmz2Bb7Lxnioj24DfH4VTrMVsKvYyG1tJdbHjgZaQYBo0H177usMrXwj+Yk
         7KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=luw6TAIXikW6der+0MpPimElAlpauRhvWpXJabmBnp8=;
        b=PcrHrlMYdX1vR300MYA74CdAnAGFsA+HyUGnyqf6WGfMBK8mYS4C5415bnrZrYnsnf
         FiEnQ+kygECpiH1gf1m0jtVoUMBufs5BevIbOlkA/inVQkdYEeW+cd5CLazKW+3jJbxJ
         aFBOYkzCs6bszFVtVsWBKEHQjVz6YltP84S3LzJRBd2WO6cju9Co4G7VGyOa6aq3qgzC
         /hSKqKyg/ARbuuI44oB29vIgBPHQx+N9FMPfXbWBKoPSMjCM/mwTGjM5Hwsgc1Xs6GeP
         dOCKNBYRQ7tkWMs5Oej4rmbQIEFj+WoYErQqjQLyP/eW04vUkcXRSP6AX2gSASld+I0I
         1Y1A==
X-Gm-Message-State: AJcUukfy2TfArSiFtMweaRPPx747H2Hgob/RKoL1djxiNCR2Eg7OUltQ
        hFhrIWBQCPBKl0QjcBRfHvSMjxXs/eNOIQ==
X-Google-Smtp-Source: ALg8bN5tQM5AT1Ae2hzr7ulHCXa5I3Z117ELyppeafO1Jtqbuyf6giBJuLldsxF1vs944DE+4+nqog==
X-Received: by 2002:adf:ffca:: with SMTP id x10mr5095262wrs.289.1547591467985;
        Tue, 15 Jan 2019 14:31:07 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b18sm62491976wrr.43.2019.01.15.14.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 14:31:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2019, #02; Tue, 15)
X-master-at: 77556354bb7ac50450e3b28999e3576969869068
X-next-at: 40155ab247a57ccc696d2ded09336b2c5203e832
Date:   Tue, 15 Jan 2019 14:31:06 -0800
Message-ID: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
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

* ab/commit-graph-progress-fix (2018-11-20) 1 commit
  (merged to 'next' on 2019-01-04 at 405a1a2cf5)
 + commit-graph: split up close_reachable() progress output


* bw/mailmap (2018-12-09) 1 commit
  (merged to 'next' on 2019-01-04 at 02b6e83231)
 + mailmap: update brandon williams's email address


* cb/openbsd-allows-reading-directory (2018-12-03) 1 commit
  (merged to 'next' on 2019-01-04 at 9d865107fd)
 + config.mak.uname: OpenBSD uses BSD semantics with fread for directories

 BSD port update.


* cb/t5004-empty-tar-archive-fix (2018-12-03) 1 commit
  (merged to 'next' on 2019-01-04 at 39f4cf94ce)
 + t5004: avoid using tar for empty packages

 BSD port update.


* cb/test-lint-cp-a (2018-12-03) 1 commit
  (merged to 'next' on 2019-01-04 at d13e6cfcb0)
 + tests: add lint for non portable cp -a

 BSD port update.


* do/gitweb-strict-export-conf-doc (2018-12-09) 1 commit
  (merged to 'next' on 2019-01-04 at 5249c9386a)
 + docs: fix $strict_export text in gitweb.conf.txt

 Doc update.


* en/directory-renames-nothanks-doc-update (2018-12-09) 1 commit
  (merged to 'next' on 2019-01-04 at cb7134b54c)
 + git-rebase.txt: update note about directory rename detection and am

 Doc update.


* fd/gitweb-snapshot-conf-doc-fix (2018-12-09) 1 commit
  (merged to 'next' on 2019-01-04 at 7ba71fca17)
 + docs/gitweb.conf: config variable typo

 Doc update.


* hb/t0061-dot-in-path-fix (2018-12-03) 1 commit
  (merged to 'next' on 2019-01-04 at 789f990c4e)
 + t0061: do not fail test if '.' is part of $PATH

 Test update.


* hn/highlight-sideband-keywords (2018-12-04) 1 commit
  (merged to 'next' on 2019-01-04 at b039601533)
 + sideband: color lines with keyword only

 Lines that begin with a certain keyword that come over the wire, as
 well as lines that consist only of one of these keywords, ought to
 be painted in color for easier eyeballing, but the latter was
 broken ever since the feature was introduced in 2.19, which has
 been corrected.


* km/rebase-doc-typofix (2018-12-10) 1 commit
  (merged to 'next' on 2019-01-04 at c89f646e8f)
 + rebase docs: drop stray word in merge command description

 Doc update.


* md/exclude-promisor-objects-fix-cleanup (2018-12-06) 1 commit
  (merged to 'next' on 2019-01-04 at c15362832d)
 + revision.c: put promisor option in specialized struct

 Code clean-up.


* md/list-lazy-objects-fix (2018-12-06) 1 commit
  (merged to 'next' on 2019-01-04 at 93bd38fff9)
 + list-objects.c: don't segfault for missing cmdline objects

 "git rev-list --exclude-promisor-objects" had to take an object
 that does not exist locally (and is lazily available) from the
 command line without barfing, but the code dereferenced NULL.


* nd/attr-pathspec-in-tree-walk (2018-11-19) 5 commits
  (merged to 'next' on 2019-01-04 at 6a07e5b905)
 + tree-walk: support :(attr) matching
 + dir.c: move, rename and export match_attrs()
 + pathspec.h: clean up "extern" in function declarations
 + tree-walk.c: make tree_entry_interesting() take an index
 + tree.c: make read_tree*() take 'struct repository *'

 The traversal over tree objects has learned to honor
 ":(attr:label)" pathspec match, which has been implemented only for
 enumerating paths on the filesystem.


* nd/checkout-noisy (2018-11-20) 2 commits
  (merged to 'next' on 2019-01-04 at 480172d3d7)
 + t0027: squelch checkout path run outside test_expect_* block
 + checkout: print something when checking out paths

 "git checkout [<tree-ish>] path..." learned to report the number of
 paths that have been checked out of the index or the tree-ish,
 which gives it the same degree of noisy-ness as the case in which
 the command checks out a branch.


* nd/indentation-fix (2018-12-09) 1 commit
  (merged to 'next' on 2019-01-04 at 738b17d365)
 + Indent code with TABs

 Code cleanup.


* sb/diff-color-moved-config-option-fixup (2018-11-14) 1 commit
  (merged to 'next' on 2019-01-04 at 46de5f42d1)
 + diff: align move detection error handling with other options

 Minor inconsistency fix.


* tb/log-G-binary (2018-12-26) 1 commit
  (merged to 'next' on 2019-01-04 at a713ef389c)
 + log -G: ignore binary files

 "git log -G<regex>" looked for a hunk in the "git log -p" patch
 output that contained a string that matches the given pattern.
 Optimize this code to ignore binary files, which by default will
 not show any hunk that would match any pattern (unless textconv or
 the --text option is in effect, that is).


* tb/use-common-win32-pathfuncs-on-cygwin (2018-12-26) 1 commit
  (merged to 'next' on 2019-01-04 at c3b2b1f3c3)
 + git clone <url> C:\cygwin\home\USER\repo' is working (again)

 Cygwin update.

--------------------------------------------------
[New Topics]

* ds/gc-doc-typofix (2019-01-08) 1 commit
  (merged to 'next' on 2019-01-08 at f21ffc83e0)
 + git-gc.txt: fix typo about gc.writeCommitGraph

 Typofix.

 Will merge to 'master'.


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
 - diff --color-moved-ws: handle blank lines
 - diff --color-moved-ws: modify allow-indentation-change
 - diff --color-moved-ws: optimize allow-indentation-change
 - diff --color-moved=zebra: be stricter with color alternation
 - diff --color-moved-ws: fix false positives
 - diff --color-moved-ws: demonstrate false positives
 - diff: allow --no-color-moved-ws
 - Use "whitespace" consistently
 - diff: document --no-color-moved

 "git diff --color-moved-ws" updates.

 Will merge to 'next'.


* en/show-ref-doc-fix (2019-01-10) 1 commit
  (merged to 'next' on 2019-01-14 at f875bfb9a4)
 + git-show-ref.txt: fix order of flags

 Doc update.

 Will merge to 'master'.


* it/log-format-source (2019-01-11) 1 commit
 - log: add %S option (like --source) to log --format

 Custom userformat "log --format" learned %S atom that stands for
 the tip the traversal reached the commit from, i.e. --source.

 Will merge to 'next'.


* js/filter-options-should-use-plain-int (2019-01-08) 1 commit
 - filter-options: expand scaled numbers

 Update the protocol message specification to allow only the limited
 use of scaled quantities.  This is ensure potential compatibility
 issues will not go out of hand.

 Will merge to 'next'.


* js/gc-repack-close-before-remove (2019-01-11) 1 commit
  (merged to 'next' on 2019-01-14 at 9daedfee40)
 + gc/repack: release packs when needed

 "git gc" and "git repack" did not close the open packfiles that
 they found unneeded before removing them, which didn't work on a
 platform incapable of removing an open file.  This has been
 corrected.

 Will merge to 'master'.


* jt/upload-pack-deepen-relative-proto-v2 (2019-01-10) 2 commits
 - upload-pack: teach deepen-relative in protocol v2
 - fetch-pack: do not take shallow lock unnecessarily

 "git fetch --deepen=<more>" has been corrected to work over v2
 protocol.

 Will merge to 'next'.


* nd/config-move-to (2019-01-14) 7 commits
 - config.h: fix hdr-check warnings
 - config: add --move-to
 - config: factor out set_config_source_file()
 - config: use OPT_FILENAME()
 - config.c: add repo_config_set_worktree_gently()
 - worktree.c: add get_worktree_config()
 - config.c: avoid git_path() in do_git_config_sequence()

 Needs review.


* sg/travis-specific-cc (2019-01-10) 4 commits
 - travis-ci: build with the right compiler
 - travis-ci: switch to Xcode 10.1 macOS image
 - travis-ci: don't be '--quiet' when running the tests
 - .gitignore: ignore external debug symbols from GCC on macOS

 The travis CI scripts have been corrected to build Git with the
 compiler(s) of our choice.

 Will likely to break linux32 build due to outdated code in
 compat/obstack.


* sg/obstack-cast-function-type-fix (2019-01-14) 1 commit
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
 - remote: check config validity before creating rewrite struct

 Code clean-up.

 Will merge to 'next'.


* jk/save-getenv-result (2019-01-11) 6 commits
 - builtin_diff(): read $GIT_DIFF_OPTS closer to use
 - merge-recursive: copy $GITHEAD strings
 - init: make a copy of $GIT_DIR string
 - config: make a copy of $GIT_CONFIG string
 - commit: copy saved getenv() result
 - get_super_prefix(): copy getenv() result

 There were many places the code relied on the string returned from
 getenv() to be non-volatile, which is not true, that have been
 corrected.

 Will merge to 'next'.


* jt/fetch-v2-sideband (2019-01-15) 5 commits
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


* ld/git-p4-shelve-update-fix (2019-01-14) 2 commits
 - git-p4: handle update of moved files when updating a shelve
 - git-p4: add failing test for shelved CL update involving move

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
 - cache: make oidcpy always copy GIT_MAX_RAWSZ bytes
 - tree-walk: store object_id in a separate member
 - match-trees: use hashcpy to splice trees
 - match-trees: compute buffer offset correctly when splicing
 - tree-walk: copy object ID before use

 The code to walk tree objects has been taught that we may be
 working with object names that are not computed with SHA-1.

 Will merge to 'next'.


* js/add-e-clear-patch-before-stating (2019-01-15) 1 commit
 - add --edit: truncate the patch file

 "git add -e" got confused when the change it wants to let the user
 edit is smaller than the previous change that was left over in a
 temporary file.

 Will merge to 'next'.


* js/commit-graph-read-overflow-fix (2019-01-15) 3 commits
 - Makefile: correct example fuzz build
 - commit-graph: fix buffer read-overflow
 - commit-graph, fuzz: add fuzzer for commit-graph

 The code to read the commit-graph file was not prepared to see a
 corrupt size field in the file, and ended up reading beyond the end
 of the buffer.

 Will merge to 'next'.

--------------------------------------------------
[Cooking]

* jt/fetch-pack-v2 (2019-01-10) 1 commit
 - fetch-pack: support protocol version 2

 "git fetch-pack" now can talk the version 2 protocol.

 Will merge to 'next'.


* jn/stripspace-wo-repository (2018-12-26) 1 commit
  (merged to 'next' on 2019-01-08 at 81815821c9)
 + stripspace: allow -s/-c outside git repository

 "git stripspace" should be usable outside a git repository, but
 under the "-s" or "-c" mode, it didn't.

 Will merge to 'master'.


* ma/asciidoctor (2018-12-26) 3 commits
  (merged to 'next' on 2019-01-08 at 3cfd4ad6cb)
 + git-status.txt: render tables correctly under Asciidoctor
 + Documentation: do not nest open blocks
 + git-column.txt: fix section header

 Some of the documentation pages formatted incorrectly with
 Asciidoctor, which have been fixed.

 Will merge to 'master'.


* nd/worktree-remove-with-uninitialized-submodules (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at e19cfe8741)
 + worktree: allow to (re)move worktrees with uninitialized submodules

 "git worktree remove" and "git worktree move" refused to work when
 there is a submodule involved.  This has been loosened to ignore
 uninitialized submodules.

 Will merge to 'master'.


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

 Will merge to 'master'.


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

 Will merge to 'master'.


* cy/completion-typofix (2019-01-03) 1 commit
  (merged to 'next' on 2019-01-08 at 6c6f01a07d)
 + completion: fix typo in git-completion.bash

 Typofix.

 Will merge to 'master'.


* cy/zsh-completion-SP-in-path (2019-01-03) 2 commits
  (merged to 'next' on 2019-01-08 at fee27de30b)
 + completion: treat results of git ls-tree as file paths
 + zsh: complete unquoted paths with spaces correctly

 With zsh, "git cmd path<TAB>" was completed to "git cmd path name"
 when the completed path has a special character like SP in it,
 without any attempt to keep "path name" a single filename.  This
 has been fixed to complete it to "git cmd path\ name" just like
 Bash completion does.

 Will merge to 'master'.


* ds/commit-graph-assert-missing-parents (2019-01-02) 1 commit
  (merged to 'next' on 2019-01-08 at d141f063e0)
 + commit-graph: writing missing parents is a BUG

 Tightening error checking in commit-graph writer.

 Will merge to 'master'.


* ed/simplify-setup-git-dir (2019-01-03) 1 commit
  (merged to 'next' on 2019-01-08 at 8722c7c2ef)
 + Simplify handling of setup_git_directory_gently() failure cases.

 Code simplification.

 Will merge to 'master'.


* es/doc-worktree-guessremote-config (2018-12-28) 1 commit
  (merged to 'next' on 2019-01-08 at f1dc5e39a6)
 + doc/config: do a better job of introducing 'worktree.guessRemote'

 Doc clarification.

 Will merge to 'master'.


* ew/ban-strncat (2019-01-02) 1 commit
  (merged to 'next' on 2019-01-08 at 3bba2ae2bb)
 + banned.h: mark strncat() as banned

 The "strncat()" function is now among the banned functions.

 Will merge to 'master'.


* jk/dev-build-format-security (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at 3761ab7026)
 + config.mak.dev: add -Wall, primarily for -Wformat, to help autoconf users

 Earlier we added "-Wformat-security" to developer builds, assuming
 that "-Wall" (which includes "-Wformat" which in turn is required
 to use "-Wformat-security") is always in effect.  This is not true
 when config.mak.autogen is in use, unfortunately.  This has been
 fixed by unconditionally adding "-Wall" to developer builds.

 Will merge to 'master'.


* jp/author-committer-config (2019-01-02) 2 commits
 - DONTMERGE
 - Add author and committer configuration settings

 Four new configuration variables {author,committer}.{name,email}
 have been introduced to override user.{name,email} in more specific
 cases.

 Expecting a reroll.
 cf. <xmqq1s5uk6qh.fsf@gitster-ct.c.googlers.com>


* js/rebase-am (2019-01-03) 4 commits
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
 - rebase: run post-checkout hook on checkout
 - t5403: simplify by using a single repository

 "git rebase" internally runs "checkout" to switch between branches,
 and the command used to call the post-checkout hook, but the
 reimplementation stopped doing so, which is getting fixed.

 Will merge to 'next'.


* rb/hpe (2019-01-03) 5 commits
  (merged to 'next' on 2019-01-08 at 52d6995399)
 + compat/regex/regcomp.c: define intptr_t and uintptr_t on NonStop
 + git-compat-util.h: add FLOSS headers for HPE NonStop
 + config.mak.uname: support for modern HPE NonStop config.
 + transport-helper: drop read/write errno checks
 + transport-helper: use xread instead of read

 Portability updates for the HPE NonStop platform.

 Will merge to 'master'.


* sg/test-bash-version-fix (2019-01-03) 2 commits
  (merged to 'next' on 2019-01-08 at f83a0628a0)
 + Merge branch 'sg/test-bash-version-fix'
 + test-lib: check Bash version for '-x' without using shell arrays
 (this branch is used by sg/stress-test.)

 The test suite tried to see if it is run under bash, but the check
 itself failed under some other implementations of shell (notably
 under NetBSD).  This has been corrected.

 Will merge to 'master'.


* ms/http-no-more-failonerror (2019-01-10) 5 commits
 - test: test GIT_CURL_VERBOSE=1 shows an error
 - remote-curl: unset CURLOPT_FAILONERROR
 - remote-curl: define struct for CURLOPT_WRITEFUNCTION
 - http: enable keep_error for HTTP requests
 - http: support file handles for HTTP_KEEP_ERROR

 Debugging help for http transport.

 Will merge to 'next'.


* tg/t5570-drop-racy-test (2019-01-07) 2 commits
  (merged to 'next' on 2019-01-08 at 9fc753bbdc)
 + Revert "t/lib-git-daemon: record daemon log"
 + t5570: drop racy test

 An inherently racy test that caused intermittent failures has been
 removed.

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
 - Documentation/Makefile add optional targets for l10n

 Prepare Documentation/Makefile so that manpage localization can
 reuse it by overriding and tweaking the list of build products.

 Will merge to 'next'.


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
 (this branch uses rs/loose-object-cache-perffix.)

 Code clean-up.

 Later parts of the series crash heavily with sb/more-repo-in-api
 and are left out for now.  I am not sure if keeping that other
 topic is worth keeping to block the clean-up value of this topic
 which is probably more clear.


* mm/multimail-1.5 (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at 8c872af48e)
 + git-multimail: update to release 1.5.0

 Update "git multimail" from the upstream.

 Will merge to 'master'.


* po/git-p4-wo-login (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at a7cc58d6b9)
 + git-p4: fix problem when p4 login is not necessary

 "git p4" update.

 Will merge to 'master'.


* rs/loose-object-cache-perffix (2019-01-08) 4 commits
  (merged to 'next' on 2019-01-08 at 36e355e099)
 + object-store: retire odb_load_loose_cache()
 + object-store: use one oid_array per subdirectory for loose cache
 + object-store: factor out odb_clear_loose_cache()
 + object-store: factor out odb_loose_cache()
 (this branch is used by jk/loose-object-cache-oid.)

 The loose object cache used to optimize existence look-up has been
 updated.

 Will merge to 'master'.


* rs/sha1-file-close-mapped-file-on-error (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at 5841cbc153)
 + sha1-file: close fd of empty file in map_sha1_file_1()

 Code clean-up.

 Will merge to 'master'.


* lt/date-human (2019-01-02) 3 commits
 - t0006-date.sh: add `human` date format tests.
 - Add 'human' date format documentation
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


* ds/push-sparse-tree-walk (2019-01-14) 7 commits
 - revision.c: fix sparse warnings (sparse algorithm)
 - pack-objects: create GIT_TEST_PACK_SPARSE
 - pack-objects: create pack.useSparse setting
 - revision: implement sparse algorithm
 - pack-objects: add --sparse option
 - list-objects: consume sparse tree walk
 - revision: add mark_tree_uninteresting_sparse

 "git pack-objects" learned another algorithm to compute the set of
 objects to send, that trades the resulting packfile off to save
 traversal cost to favor small pushes.

 May need a further update, including squashing the tip commit to a
 releavant place.


* js/rebase-i-redo-exec (2018-12-11) 3 commits
 - rebase: introduce a shortcut for --reschedule-failed-exec
 - rebase: add a config option to default to --reschedule-failed-exec
 - rebase: introduce --reschedule-failed-exec

 "git rebase -i" learned to re-execute a command given with 'exec'
 to run after it failed the last time.

 Will merge to 'next'.


* md/list-objects-filter-by-depth (2019-01-10) 4 commits
 - tree:<depth>: skip some trees even when collecting omits
 - list-objects-filter: teach tree:# how to handle >0
 - Merge branch 'nd/the-index' into md/list-objects-filter-by-depth
 - Merge branch 'sb/more-repo-in-api' into md/list-objects-filter-by-depth
 (this branch uses sb/more-repo-in-api; is tangled with jt/get-reference-with-commit-graph.)

 The objects-filter machinery learned "tree:<depth>" to filter
 objects up to a given depth; earlier it only supported depth=0,
 i.e. usable to create a commit-only lazy clone.

 Will merge to 'next'.


* nd/style-opening-brace (2018-12-10) 1 commit
  (merged to 'next' on 2019-01-08 at 80de026e14)
 + style: the opening '{' of a function is in a separate line

 Code clean-up.

 Will merge to 'master'.


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

 Will merge to 'master'.


* tg/checkout-no-overlay (2019-01-08) 8 commits
 - checkout: introduce checkout.overlayMode config
 - checkout: introduce --{,no-}overlay option
 - checkout: factor out mark_cache_entry_for_checkout function
 - checkout: clarify comment
 - read-cache: add invalidate parameter to remove_marked_cache_entries
 - entry: support CE_WT_REMOVE flag in checkout_entry
 - entry: factor out unlink_entry function
 - move worktree tests to t24*

 "git checkout --no-overlay" can be used to trigger a new mode of
 checking out paths out of the tree-ish, that allows paths that
 match the pathspec that are in the current index and working tree
 and are not in the tree-ish.

 Will merge to 'next'.


* jk/proto-v2-hidden-refs-fix (2019-01-10) 1 commit
 - upload-pack: support hidden refs with protocol v2

 The v2 upload-pack protocol implementation failed to honor
 hidden-ref configuration, which has been corrected.

 Will merge to 'next'.
 An earlier attempt reverted out of 'next'.


* la/quiltimport-keep-non-patch (2019-01-07) 1 commit
  (merged to 'next' on 2019-01-08 at 37cb490792)
 + git-quiltimport: add --keep-non-patch option

 "git quiltimport" learned "--keep-non-patch" option.

 Will merge to 'master'.


* sb/submodule-fetchjobs-default-to-one (2018-12-14) 1 commit
  (merged to 'next' on 2019-01-08 at 97a522ef5e)
 + submodule update: run at most one fetch job unless otherwise set

 "git submodule update" ought to use a single job unless asked, but
 by mistake used multiple jobs, which has been fixed.

 Will merge to 'master'.


* js/commit-graph-chunk-table-fix (2018-12-14) 3 commits
 - Makefile: correct example fuzz build
 - commit-graph: fix buffer read-overflow
 - commit-graph, fuzz: add fuzzer for commit-graph

 The codepath to read from the commit-graph file attempted to read
 past the end of it when the file's table-of-contents was corrupt.


* jt/get-reference-with-commit-graph (2018-12-28) 1 commit
 - revision: use commit graph in get_reference()
 (this branch uses sb/more-repo-in-api; is tangled with md/list-objects-filter-by-depth.)

 Micro-optimize the code that prepares commit objects to be walked
 by "git rev-list" when the commit-graph is available.

 Will merge to 'next'.


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


* nb/branch-show-other-worktrees-head (2019-01-07) 4 commits
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

 Will merge to 'master'.


* sb/more-repo-in-api (2018-12-28) 23 commits
 - t/helper/test-repository: celebrate independence from the_repository
 - path.h: make REPO_GIT_PATH_FUNC repository agnostic
 - commit: prepare free_commit_buffer and release_commit_memory for any repo
 - commit-graph: convert remaining functions to handle any repo
 - submodule: don't add submodule as odb for push
 - submodule: use submodule repos for object lookup
 - pretty: prepare format_commit_message to handle arbitrary repositories
 - commit: prepare logmsg_reencode to handle arbitrary repositories
 - commit: prepare repo_unuse_commit_buffer to handle any repo
 - commit: prepare get_commit_buffer to handle any repo
 - commit-reach: prepare in_merge_bases[_many] to handle any repo
 - commit-reach: prepare get_merge_bases to handle any repo
 - commit-reach.c: allow get_merge_bases_many_0 to handle any repo
 - commit-reach.c: allow remove_redundant to handle any repo
 - commit-reach.c: allow merge_bases_many to handle any repo
 - commit-reach.c: allow paint_down_to_common to handle any repo
 - commit: allow parse_commit* to handle any repo
 - object: parse_object to honor its repository argument
 - object-store: prepare has_{sha1, object}_file to handle any repo
 - object-store: prepare read_object_file to deal with any repo
 - object-store: allow read_object_file_extended to read from any repo
 - packfile: allow has_packed_and_bad to handle arbitrary repositories
 - sha1_file: allow read_object to read objects in arbitrary repositories
 (this branch is used by jt/get-reference-with-commit-graph and md/list-objects-filter-by-depth.)

 The in-core repository instances are passed through more codepaths.

 Will merge to 'next'.


* bc/sha-256 (2018-11-14) 12 commits
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

 Will merge to 'next'.


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
 - fetch: ensure submodule objects fetched
 - submodule.c: fetch in submodules git directory instead of in worktree
 - submodule: migrate get_next_submodule to use repository structs
 - repository: repo_submodule_init to take a submodule struct
 - submodule: store OIDs in changed_submodule_names
 - submodule.c: tighten scope of changed_submodule_names struct
 - submodule.c: sort changed_submodule_names before searching it
 - submodule.c: fix indentation
 - sha1-array: provide oid_array_filter

 "git fetch --recurse-submodules" may not fetch the necessary commit
 that is bound to the superproject, which is getting corrected.

 Will merge to 'next'.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ps/stash-in-c (2019-01-04) 27 commits
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

 Comments?


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

--------------------------------------------------
[Discarded]

* nd/backup-log (2018-12-10) 24 commits
 . FIXME
 . rebase: keep backup of overwritten files on --skip or --abort
 . am: keep backup of overwritten files on --skip or --abort
 . checkout -f: keep backup of overwritten files
 . reset --hard: keep backup of overwritten files
 . unpack-trees.c: keep backup of ignored files being overwritten
 . refs: keep backup of deleted reflog
 . config --edit: support backup log
 . sha1-file.c: let index_path() accept NULL istate
 . backup-log: keep all blob references around
 . gc: prune backup logs
 . backup-log: add prune command
 . backup-log: add log command
 . backup-log: add diff command
 . backup-log: add cat command
 . backup-log.c: add API for walking backup log
 . add--interactive: support backup log
 . apply: support backup log with --keep-backup
 . commit: support backup log
 . update-index: support backup log with --keep-backup
 . add: support backup log
 . read-cache.c: new flag for add_index_entry() to write to backup log
 . backup-log: add "update" subcommand
 . doc: introduce new "backup log" concept
