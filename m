Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9801120969
	for <e@80x24.org>; Wed, 29 Mar 2017 22:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932381AbdC2WDG (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 18:03:06 -0400
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:52906 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753966AbdC2WDE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 18:03:04 -0400
Received: from pb-sasl-trial3.pobox.com (ro.sql.listbox.com [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id A714B2C72F;
        Wed, 29 Mar 2017 18:03:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=n
        PcZiO8N4tAqE+GikDGJbL1rgxY=; b=kuW6nwvSHUwS4bE9B0SyozPgWhTOETVe8
        5w3cES619P2proZ8gV7G7XWqgGhELjWFQGl+rqEdkoDAkuRgO2hsBhRm1LZIBU/T
        aBcOOqUAQHZvAME5sqNGyebbCNtGVOD5/RClFN+L9SjNOk+OnO5JJgD5yrSrrJ5s
        p7Kp0EIDv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=bEB
        JbGTr2tA6CNSHgSiWDsqa0Fi6/fyGKsuFs9MxYsYpNk9dTqg4Ay+09qwHFjdeL7c
        jDzuoMcrDxdQD0N4w/tiovIEj1cWNkKcaizW8Bra/5uHbf/FA6RP1LnCgjlGyBuu
        WtXGn1h8+L/SkhqGUerwTwzXsV9NZLG9YYZu9KiI=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 80A3A2C72E;
        Wed, 29 Mar 2017 18:03:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39EF488BF2;
        Wed, 29 Mar 2017 18:03:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2017, #12; Wed, 29)
X-master-at: e1104a5ee539408b81566066aaa6963cb87d5cd6
X-next-at: c2a70e75825ac7c7f54f8cb0fff83ac7cf042a3a
Date:   Wed, 29 Mar 2017 15:02:59 -0700
Message-ID: <xmqqk27791ws.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 793ED0B8-14CB-11E7-A999-FC50AE2156B6-77302942!pb-smtp2.pobox.com
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

* ab/branch-list-doc (2017-03-24) 2 commits
  (merged to 'next' on 2017-03-27 at 4bb47907ee)
 + branch doc: update description for `--list`
 + branch doc: change `git branch <pattern>` to use `<branchname>`

 Doc update.


* bw/grep-recurse-submodules (2017-03-18) 2 commits
  (merged to 'next' on 2017-03-21 at a57e2f0129)
 + grep: fix builds with with no thread support
 + grep: set default output method

 Build fix for NO_PTHREADS build.


* jh/memihash-opt (2017-03-24) 8 commits
  (merged to 'next' on 2017-03-24 at f1aa0c4d37)
 + name-hash: add test-lazy-init-name-hash to .gitignore
 + name-hash: add perf test for lazy_init_name_hash
 + name-hash: add test-lazy-init-name-hash
 + name-hash: perf improvement for lazy_init_name_hash
 + hashmap: document memihash_cont, hashmap_disallow_rehash api
 + hashmap: add disallow_rehash setting
 + hashmap: allow memihash computation to be continued
 + name-hash: specify initial size for istate.dir_hash table

 The name-hash used for detecting paths that are different only in
 cases (which matter on case insensitive filesystems) has been
 optimized to take advantage of multi-threading when it makes sense.


* jk/fast-import-cleanup (2017-03-24) 4 commits
  (merged to 'next' on 2017-03-27 at 9f6058007f)
 + pack.h: define largest possible encoded object size
 + encode_in_pack_object_header: respect output buffer length
 + fast-import: use xsnprintf for formatting headers
 + fast-import: use xsnprintf for writing sha1s

 Code clean-up.


* jk/pager-in-use (2017-03-24) 1 commit
  (merged to 'next' on 2017-03-27 at 513f007025)
 + pager_in_use: use git_env_bool()

 Code clean-up.


* jk/sha1dc (2017-03-26) 1 commit
  (merged to 'next' on 2017-03-27 at 91bf9f06b4)
 + sha1dc: avoid CPP macro collisions

 sha1dc/sha1.c wanted to check the endianness of the target platform
 at compilation time and used a CPP macro with a rather overly
 generic name, "BIGENDIAN", to pass the result of the check around
 in the file.  It wasn't prepared for the same macro set to 0
 (false) by the platform to signal that the target is _not_ a big
 endian box, and assumed that the endianness detection logic it has
 alone would be the one that is setting the macro, resulting in a
 breakage on Windows.  This has been fixed by using a bit less
 generic name for the same purpose.


* sb/checkout-recurse-submodules (2017-03-16) 19 commits
  (merged to 'next' on 2017-03-22 at 48b49d572c)
 + builtin/read-tree: add --recurse-submodules switch
 + builtin/checkout: add --recurse-submodules switch
 + entry.c: create submodules when interesting
 + unpack-trees: check if we can perform the operation for submodules
 + unpack-trees: pass old oid to verify_clean_submodule
 + update submodules: add submodule_move_head
 + submodule.c: get_super_prefix_or_empty
 + update submodules: move up prepare_submodule_repo_env
 + submodules: introduce check to see whether to touch a submodule
 + update submodules: add a config option to determine if submodules are updated
 + update submodules: add submodule config parsing
 + make is_submodule_populated gently
 + lib-submodule-update.sh: define tests for recursing into submodules
 + lib-submodule-update.sh: replace sha1 by hash
 + lib-submodule-update: teach test_submodule_content the -C <dir> flag
 + lib-submodule-update.sh: do not use ./. as submodule remote
 + lib-submodule-update.sh: reorder create_lib_submodule_repo
 + submodule--helper.c: remove duplicate code
 + connect_work_tree_and_git_dir: safely create leading directories

 "git checkout" is taught the "--recurse-submodules" option.


* sg/skip-prefix-in-prettify-refname (2017-03-23) 1 commit
  (merged to 'next' on 2017-03-27 at f7d0c115f9)
 + refs.c: use skip_prefix() in prettify_refname()

 Code cleanup.


* tg/stash-push-fixup (2017-03-22) 3 commits
  (merged to 'next' on 2017-03-24 at e6b9e04213)
 + stash: keep untracked files intact in stash -k
 + stash: pass the pathspec argument to git reset
 + stash: don't show internal implementation details

 Recent enhancement to "git stash push" command to support pathspec
 to allow only a subset of working tree changes to be stashed away
 was found to be too chatty and exposed the internal implementation
 detail (e.g. when it uses reset to match the index to HEAD before
 doing other things, output from reset seeped out).  These, and
 other chattyness has been fixed.

--------------------------------------------------
[New Topics]

* bc/push-cert-receive-fix (2017-03-28) 1 commit
 - builtin/receive-pack: fix incorrect pointer arithmetic

 "git receive-pack" could have been forced to die by attempting
 allocate an unreasonably large amount of memory with a crafted push
 certificate; this has been fixed.

 Will merge to 'next'.


* mh/notes-tree-consolidate-fix (2017-03-27) 1 commit
 - notes: do not break note_tree structure in note_tree_consolidate()

 Removing an entry from a notes tree and then looking another note
 entry from the resulting tree using the internal notes API
 functions did not work as expected.  No in-tree users of the API
 has such access pattern, but it still is worth fixing.

 Will merge to 'next'.


* ls/travis-relays-for-windows-ci (2017-03-28) 1 commit
 - travis-ci: build and test Git on Windows

 Define a new task in .travis.yml that triggers a test session on
 Windows run elsewhere.


* bp/sub-process-convert-filter (2017-03-29) 8 commits
 - convert: update subprocess_read_status to not die on EOF
 - sub-process: move sub-process functions into separate files
 - convert: rename reusable sub-process functions
 - convert: update generic functions to only use generic data structures
 - convert: separate generic structures and variables from the filter specific ones
 - convert: split start_multi_file_filter into two separate functions
 - convert: update convert to use new packet_writel() function
 - pkt-line: add packet_writel() and packet_read_line_gently()

 Code from "conversion using external process" codepath has been
 extracted to a separate sub-process.[ch] module.


* cc/split-index-config (2017-03-29) 1 commit
 - read-cache: avoid git_path() race in freshen_shared_index()

 The split-index code configuration code used an unsafe git_path()
 function without copying its result out.

 Needs to be explained better.
 The code looked OK, though.


* jk/make-coccicheck-detect-errors (2017-03-29) 1 commit
 - Makefile: detect errors in running spatch

 Build fix.

 Will merge to 'next'.


* jk/snprintf-cleanups (2017-03-28) 18 commits
 - daemon: use an argv_array to exec children
 - gc: replace local buffer with git_path
 - transport-helper: replace checked snprintf with xsnprintf
 - convert unchecked snprintf into xsnprintf
 - combine-diff: replace malloc/snprintf with xstrfmt
 - replace unchecked snprintf calls with heap buffers
 - receive-pack: print --pack-header directly into argv array
 - name-rev: replace static buffer with strbuf
 - create_branch: use xstrfmt for reflog message
 - create_branch: move msg setup closer to point of use
 - avoid using mksnpath for refs
 - avoid using fixed PATH_MAX buffers for refs
 - fetch: use heap buffer to format reflog
 - tag: use strbuf to format tag header
 - diff: avoid fixed-size buffer for patch-ids
 - odb_mkstemp: use git_path_buf
 - odb_mkstemp: write filename into strbuf
 - do not check odb_mkstemp return value for errors

 Code clean-up.

 Will merge to 'next'.


* mg/name-rev-debug (2017-03-29) 3 commits
 - name-rev: provide debug output
 - name-rev: favor describing with tags and use committer date to tiebreak
 - name-rev: refactor logic to see if a new candidate is a better name
 (this branch uses mg/describe-debug-l10n.)

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.

 Waiting for jc/p4-current-branch-fix to settle.
 This replaces jc/name-rev.

--------------------------------------------------
[Stalled]

* sg/clone-refspec-from-command-line-config (2017-02-27) 1 commit
 - clone: respect configured fetch respecs during initial fetch

 Expecting a reroll.
 cf. <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 cf. <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
 Some nits but looks ok.


* sk/dash-is-previous (2017-03-01) 5 commits
 - revert.c: delegate handling of "-" shorthand to setup_revisions
 - sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
 - revision.c: args starting with "-" might be a revision
 - revision.c: swap if/else blocks
 - revision.c: do not update argv with unknown option

 A dash "-" can be written to mean "the branch that was previously
 checked out" in more places.

 Needs review.
 cf. <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 What's the status of this one???
 cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>


* nd/worktree-move (2017-01-27) 7 commits
 . fixup! worktree move: new command
 . worktree remove: new command
 . worktree move: refuse to move worktrees with submodules
 . worktree move: accept destination as directory
 . worktree move: new command
 . worktree.c: add update_worktree_location()
 . worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Tentatively ejected as it seems to break 'pu' when merged.


* pb/bisect (2017-02-18) 28 commits
 - fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: remove the dequote in bisect_start()
 - bisect--helper: retire `--bisect-auto-next` subcommand
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--bisect-write` subcommand
 - bisect--helper: `bisect_replay` shell function in C
 - bisect--helper: `bisect_log` shell function in C
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: `bisect_state` & `bisect_head` shell function in C
 - bisect--helper: `bisect_autostart` shell function in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 - t6030: no cleanup with bad merge base
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Expecting a reroll.
 cf. <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
 cf. <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>
 cf. <CAFZEwPNUXcNY9Qdz=_B7q2kQuaecPzJtTMGdv8YMUPEz2vnp8A@mail.gmail.com>


* sh/grep-tree-obj-tweak-output (2017-01-20) 2 commits
 - grep: use '/' delimiter for paths
 - grep: only add delimiter if there isn't one already

 "git grep", when fed a tree-ish as an input, shows each hit
 prefixed with "<tree-ish>:<path>:<lineno>:".  As <tree-ish> is
 almost always either a commit or a tag that points at a commit, the
 early part of the output "<tree-ish>:<path>" can be used as the
 name of the blob and given to "git show".  When <tree-ish> is a
 tree given in the extended SHA-1 syntax (e.g. "<commit>:", or
 "<commit>:<dir>"), however, this results in a string that does not
 name a blob (e.g. "<commit>::<path>" or "<commit>:<dir>:<path>").
 "git grep" has been taught to be a bit more intelligent about these
 cases and omit a colon (in the former case) or use slash (in the
 latter case) to produce "<commit>:<path>" and
 "<commit>:<dir>/<path>" that can be used as the name of a blob.

 Expecting a reroll?  Is this good enough with known limitations?


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.

 Will discard.

--------------------------------------------------
[Cooking]

* ab/case-insensitive-upstream-and-push-marker (2017-03-27) 1 commit
  (merged to 'next' on 2017-03-28 at 166654719e)
 + rev-parse: match @{upstream}, @{u} and @{push} case-insensitively

 On many keyboards, typing "@{" involves holding down SHIFT key and
 one can easily end up with "@{Up..." when typing "@{upstream}".  As
 the upstream/push keywords do not appear anywhere else in the syntax,
 we can safely accept them case insensitively without introducing
 ambiguity or confusion  to solve this.

 Will merge to 'master'.


* bc/object-id (2017-03-28) 20 commits
 - Documentation: update and rename api-sha1-array.txt
 - Rename sha1_array to oid_array
 - Convert sha1_array_for_each_unique and for_each_abbrev to object_id
 - Convert sha1_array_lookup to take struct object_id
 - Convert remaining callers of sha1_array_lookup to object_id
 - Make sha1_array_append take a struct object_id *
 - sha1-array: convert internal storage for struct sha1_array to object_id
 - builtin/pull: convert to struct object_id
 - submodule: convert check_for_new_submodule_commits to object_id
 - sha1_name: convert disambiguate_hint_fn to take object_id
 - sha1_name: convert struct disambiguate_state to object_id
 - test-sha1-array: convert most code to struct object_id
 - parse-options-cb: convert sha1_array_append caller to struct object_id
 - fsck: convert init_skiplist to struct object_id
 - builtin/receive-pack: convert portions to struct object_id
 - builtin/pull: convert portions to struct object_id
 - builtin/diff: convert to struct object_id
 - Convert GIT_SHA1_RAWSZ used for allocation to GIT_MAX_RAWSZ
 - Convert GIT_SHA1_HEXSZ used for allocation to GIT_MAX_HEXSZ
 - Define new hash-size constants for allocating memory

 Conversion from unsigned char [40] to struct object_id continues.

 Will merge to 'next'.


* rs/freebsd-getcwd-workaround (2017-03-26) 1 commit
  (merged to 'next' on 2017-03-28 at 3f3c1553a7)
 + strbuf: support long paths w/o read rights in strbuf_getcwd() on FreeBSD

 FreeBSD implementation of getcwd(3) behaved differently when an
 intermediate directory is unreadable/unsearchable depending on the
 length of the buffer provided, which our strbuf_getcwd() was not
 aware of.  strbuf_getcwd() has been taught to cope with it better.

 Will merge to 'master'.


* mg/describe-debug-l10n (2017-03-27) 2 commits
  (merged to 'next' on 2017-03-28 at 16ad604828)
 + l10n: de: translate describe debug terms
 + describe: localize debug output fully
 (this branch is used by mg/name-rev-debug.)

 Some debugging output from "git describe" were marked for l10n,
 but some weren't.  Mark missing ones for l10n.

 Will merge to 'master'.


* ab/test-readme-updates (2017-03-26) 3 commits
  (merged to 'next' on 2017-03-28 at abdc7b3b15)
 + t/README: clarify the test_have_prereq documentation
 + t/README: change "Inside <X> part" to "Inside the <X> part"
 + t/README: link to metacpan.org, not search.cpan.org

 Doc updates.

 Will merge to 'master'.


* js/rebase-i-reword-to-run-hooks (2017-03-27) 3 commits
  (merged to 'next' on 2017-03-28 at d23d60f63d)
 + sequencer: allow the commit-msg hooks to run during a `reword`
 + sequencer: make commit options more extensible
 + t7504: document regression: reword no longer calls commit-msg

 A recent update to "rebase -i" stopped running hooks for the "git
 commit" command during "reword" action, which has been fixed.

 Will merge to 'master'.


* sg/completion-ctags (2017-03-23) 3 commits
  (merged to 'next' on 2017-03-27 at cf8c081f7d)
 + completion: offer ctags symbol names for 'git log -S', '-G' and '-L:'
 + completion: extract completing ctags symbol names into helper function
 + completion: put matching ctags symbol names directly into COMPREPLY
 (this branch uses sg/completion-refs-speedup.)

 Command line completion updates.

 Will merge to 'master'.


* sb/submodule-short-status (2017-03-27) 7 commits
 - submodule.c: correctly handle nested submodules in is_submodule_modified
 - short status: improve reporting for submodule changes
 - submodule.c: stricter checking for submodules in is_submodule_modified
 - submodule.c: port is_submodule_modified to use porcelain 2
 - submodule.c: convert is_submodule_modified to use strbuf_getwholeline
 - submodule.c: factor out early loop termination in is_submodule_modified
 - submodule.c: use argv_array in is_submodule_modified

 The output from "git status --short" has been extended to show
 various kinds of dirtyness in submodules differently; instead of to
 "M" for modified, 'm' and '?' can be shown to signal changes only
 to the working tree of the submodule but not the commit that is
 checked out.

 Waiting for further comments.
 The endgame looked mostly OK.


* sg/completion-refs-speedup (2017-03-23) 14 commits
  (merged to 'next' on 2017-03-27 at 6bb275710d)
 + completion: speed up branch and tag completion
 + completion: fill COMPREPLY directly when completing fetch refspecs
 + completion: fill COMPREPLY directly when completing refs
 + completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
 + completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
 + completion: let 'for-each-ref' strip the remote name from remote branches
 + completion: let 'for-each-ref' and 'ls-remote' filter matching refs
 + completion: don't disambiguate short refs
 + completion: don't disambiguate tags and branches
 + completion: support excluding full refs
 + completion: support completing fully qualified non-fast-forward refspecs
 + completion: support completing full refs after '--option=refs/<TAB>'
 + completion: wrap __git_refs() for better option parsing
 + completion: remove redundant __gitcomp_nl() options from _git_commit()
 (this branch is used by sg/completion-ctags.)

 The refs completion for large number of refs has been sped up,
 partly by giving up disambiguating ambiguous refs and partly by
 eliminating most of the shell processing between 'git for-each-ref'
 and 'ls-remote' and Bash's completion facility.

 Will merge to 'master'.


* mh/separate-ref-cache (2017-03-27) 20 commits
 - do_for_each_entry_in_dir(): delete function
 - files_pack_refs(): use reference iteration
 - commit_packed_refs(): use reference iteration
 - cache_ref_iterator_begin(): make function smarter
 - get_loose_ref_cache(): new function
 - get_loose_ref_dir(): function renamed from get_loose_refs()
 - do_for_each_entry_in_dir(): eliminate `offset` argument
 - refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
 - ref-cache: use a callback function to fill the cache
 - refs: record the ref_store in ref_cache, not ref_dir
 - ref-cache: introduce a new type, ref_cache
 - refs: split `ref_cache` code into separate files
 - ref-cache: rename `remove_entry()` to `remove_entry_from_dir()`
 - ref-cache: rename `find_ref()` to `find_ref_entry()`
 - ref-cache: rename `add_ref()` to `add_ref_entry()`
 - refs_verify_refname_available(): use function in more places
 - refs_verify_refname_available(): implement once for all backends
 - refs_ref_iterator_begin(): new function
 - refs_read_raw_ref(): new function
 - get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
 (this branch uses nd/files-backend-git-dir; is tangled with nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 The internals of the refs API around the cached refs has been
 streamlined.

 Waiting for nd/files-backend-git-dir to settle.


* ah/log-decorate-default-to-auto (2017-03-24) 1 commit
  (merged to 'next' on 2017-03-24 at ce353ebfb5)
 + log: if --decorate is not given, default to --decorate=auto

 The default behaviour of "git log" in an interactive session has
 been changed to enable "--decorate".

 Will merge to 'master'.


* ab/doc-submitting (2017-03-26) 2 commits
  (merged to 'next' on 2017-03-28 at 49e23678df)
 + doc/SubmittingPatches: show how to get a CLI commit summary
 + doc/SubmittingPatches: clarify the casing convention for "area: change..."

 Doc update.

 Will merge to 'master'.


* ja/doc-l10n (2017-03-20) 3 commits
 - SQUASH???
 - l10n: add git-add.txt to localized man pages
 - l10n: introduce framework for localizing man pages

 A proposal to use po4a to localize our manual pages.


* nd/prune-in-worktree (2017-03-27) 12 commits
 - rev-list: expose and document --single-worktree
 - revision.c: --reflog add HEAD reflog from all worktrees
 - files-backend: make reflog iterator go through per-worktree reflog
 - revision.c: --all adds HEAD from all worktrees
 - refs: remove dead for_each_*_submodule()
 - revision.c: use refs_for_each*() instead of for_each_*_submodule()
 - refs: add refs_head_ref()
 - refs: move submodule slash stripping code to get_submodule_ref_store
 - refs.c: refactor get_submodule_ref_store(), share common free block
 - revision.c: --indexed-objects add objects from all worktrees
 - revision.c: refactor add_index_objects_to_pending()
 - revision.h: new flag in struct rev_info wrt. worktree-related refs
 (this branch uses nd/files-backend-git-dir and nd/worktree-kill-parse-ref; is tangled with mh/separate-ref-cache.)

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Waiting for nd/files-backend-git-dir to settle.


* nd/worktree-kill-parse-ref (2017-03-27) 4 commits
 - refs: kill set_worktree_head_symref()
 - worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
 - refs: introduce get_worktree_ref_store()
 - environment.c: fix potential segfault by get_git_common_dir()
 (this branch is used by nd/prune-in-worktree; uses nd/files-backend-git-dir; is tangled with mh/separate-ref-cache.)

 (hopefully) a beginning of safer "git worktree" that is resistant
 to "gc".

 Waiting for nd/files-backend-git-dir to settle.


* nd/files-backend-git-dir (2017-03-27) 28 commits
 - refs.h: add a note about sorting order of for_each_ref_*
 - t1406: new tests for submodule ref store
 - t1405: some basic tests on main ref store
 - t/helper: add test-ref-store to test ref-store functions
 - refs: delete pack_refs() in favor of refs_pack_refs()
 - files-backend: avoid ref api targetting main ref store
 - refs: new transaction related ref-store api
 - refs: add new ref-store api
 - refs: rename get_ref_store() to get_submodule_ref_store() and make it public
 - files-backend: replace submodule_allowed check in files_downcast()
 - refs: move submodule code out of files-backend.c
 - path.c: move some code out of strbuf_git_path_submodule()
 - refs.c: make get_main_ref_store() public and use it
 - refs.c: kill register_ref_store(), add register_submodule_ref_store()
 - refs.c: flatten get_ref_store() a bit
 - refs: rename lookup_ref_store() to lookup_submodule_ref_store()
 - refs.c: introduce get_main_ref_store()
 - files-backend: remove the use of git_path()
 - files-backend: add and use files_ref_path()
 - files-backend: add and use files_reflog_path()
 - files-backend: move "logs/" out of TMP_RENAMED_LOG
 - files-backend: convert git_path() to strbuf_git_path()
 - files-backend: make sure files_rename_ref() always reach the end
 - files-backend: add and use files_packed_refs_path()
 - files-backend: delete dead code in files_init_db()
 - files-backend.c: delete dead code in files_ref_iterator_begin()
 - files-backend: make files_log_ref_write() static
 - refs.h: add forward declaration for structs used in this file
 (this branch is used by mh/separate-ref-cache, nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 The "submodule" specific field in the ref_store structure is
 replaced with a more generic "gitdir" that can later be used also
 when dealing with ref_store that represents the set of refs visible
 from the other worktrees.

 Will merge to 'next' after waiting for a few days for further comments.
 Looking good.


* ab/ref-filter-no-contains (2017-03-24) 16 commits
  (merged to 'next' on 2017-03-28 at bdce986928)
 + tag: add tests for --with and --without
 + ref-filter: reflow recently changed branch/tag/for-each-ref docs
 + ref-filter: add --no-contains option to tag/branch/for-each-ref
 + tag: change --point-at to default to HEAD
 + tag: implicitly supply --list given another list-like option
 + tag: change misleading --list <pattern> documentation
 + parse-options: add OPT_NONEG to the "contains" option
 + tag: add more incompatibles mode tests
 + for-each-ref: partly change <object> to <commit> in help
 + tag tests: fix a typo in a test description
 + tag: remove a TODO item from the test suite
 + ref-filter: add test for --contains on a non-commit
 + ref-filter: make combining --merged & --no-merged an error
 + tag doc: reword --[no-]merged to talk about commits, not tips
 + tag doc: split up the --[no-]merged documentation
 + tag doc: move the description of --[no-]merged earlier

 "git tag/branch/for-each-ref" family of commands long allowed to
 filter the refs by "--contains X" (show only the refs that are
 descendants of X), "--merged X" (show only the refs that are
 ancestors of X), "--no-merged X" (show only the refs that are not
 ancestors of X).  One curious omission, "--no-contains X" (show
 only the refs that are not descendants of X) has been added to
 them.

 Will merge to 'master'.


* bw/recurse-submodules-relative-fix (2017-03-17) 5 commits
  (merged to 'next' on 2017-03-28 at d0cef6234e)
 + ls-files: fix bug when recursing with relative pathspec
 + ls-files: fix typo in variable name
 + grep: fix bug when recursing with relative pathspec
 + setup: allow for prefix to be passed to git commands
 + grep: fix help text typo

 A few commands that recently learned the "--recurse-submodule"
 option misbehaved when started from a subdirectory of the
 superproject.

 Will merge to 'master'.


* jc/p4-current-branch-fix (2017-03-27) 2 commits
 - DONTMERGE git-p4: "name-rev HEAD" is not a way to find the current branch
 - git-p4: add failing test for name-rev rather than symbolic-ref

 "git p4" used "name-rev HEAD" when it wants to learn what branch is
 checked out; it should use "symbolic-ref HEAD".

 The tip one (i.e. real fix) needs to be redone by somebody
 competent with Python and git-p4 codebase.


* bw/submodule-is-active (2017-03-18) 10 commits
  (merged to 'next' on 2017-03-22 at 4c05cb5ab4)
 + submodule add: respect submodule.active and submodule.<name>.active
 + submodule--helper init: set submodule.<name>.active
 + clone: teach --recurse-submodules to optionally take a pathspec
 + submodule init: initialize active submodules
 + submodule: decouple url and submodule interest
 + submodule--helper clone: check for configured submodules using helper
 + submodule sync: use submodule--helper is-active
 + submodule sync: skip work for inactive submodules
 + submodule status: use submodule--helper is-active
 + submodule--helper: add is-active subcommand

 "what URL do we want to update this submodule?" and "are we
 interested in this submodule?" are split into two distinct
 concepts, and then the way used to express the latter got extended,
 paving a way to make it easier to manage a project with many
 submodules and make it possible to later extend use of multiple
 worktrees for a project with submodules.

 Will merge to 'master'.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2017-02-27 at 7373a1b73d)
 + setup_git_env: avoid blind fall-back to ".git"

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2017-02-27 at 2c0f5f73d8)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will merge to 'master'.


* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.

--------------------------------------------------
[Discarded]

* jc/name-rev (2017-03-16) 2 commits
 . name-rev: favor describing with tags and use committer date to tiebreak
 . name-rev: refactor logic to see if a new candidate is a better name

 "git name-rev" penalized lightweight tags too much, making them
 almost useless especially when the command is run with "--tags".
 Give the same precedence to lightweight tags as annotated tags as
 the base for naming a commit.

 Now part of mg/name-rev-debug topic.
