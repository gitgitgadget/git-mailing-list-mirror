From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2011, #03; Fri, 9)
Date: Fri, 09 Dec 2011 16:09:51 -0800
Message-ID: <7vk465b834.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 01:10:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZAVs-0004sV-D2
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 01:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab1LJAJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 19:09:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721Ab1LJAJz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 19:09:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E3726ED3;
	Fri,  9 Dec 2011 19:09:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	RNULZuTwoNxuoyIfRjq1/M9pRw=; b=qR5fq97dDDvwGpCXhMi0uB/uYCnBZIKKN
	SWzEcn2d/ZqZFsWsV8rAtFjMHaIH5R+AbMHvpERl7B7gg425/WmjYarC2lTVzaYV
	4wnDR5GJqB9/Zpjz6WBv0/2q4+BG5JbuF0h7tPcTjm17yraTR0iiX6JBJ+s05S19
	9yYoe15cp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=sVI
	mIiv73DzfIMhUMyNxhT27stOLV4FXGu0wA1W13Dfy96a+NWcQ9AE3+WsrA5Fwj/b
	YrG1rJPiFTmY08n6WHW666fCMoJ6ws1XhLc82D5VvKZ4iXeWDD1VnbPvJEf74bhn
	7dmYxkvv3UfPmjh2xWyDsKNZQZB7gkBu5ZrNYkUY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 059576ED2;
	Fri,  9 Dec 2011 19:09:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2CF66ECF; Fri,  9 Dec 2011
 19:09:52 -0500 (EST)
X-master-at: 9859a023fef30ffebdd22ad9639c587ac720b8b6
X-next-at: b9cfa4e96be9817e744fb728360e7f37c730d133
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 489D1D48-22C3-11E1-B723-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186715>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

Two of the more important topics slated for 1.7.9 have been merged to
'master'. Let's hope the other ones also will stabilize soonish, so that
we can smoothly close this cycle early.

Here are the repositories that have my integration branches:

With maint, master, next, pu, todo:

        git://git.kernel.org/pub/scm/git/git.git
        git://repo.or.cz/alt-git.git
        https://code.google.com/p/git-core/
        https://github.com/git/git

With only maint and master:

        git://git.sourceforge.jp/gitroot/git-core/git.git
        git://git-core.git.sourceforge.net/gitroot/git-core/git-core

With all the topics and integration branches:

        https://github.com/gitster/git

The preformatted documentation in HTML and man format are found in:

        git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
        git://repo.or.cz/git-{htmldocs,manpages}.git/
        https://code.google.com/p/git-{htmldocs,manpages}.git/
        https://github.com/gitster/git-{htmldocs,manpages}.git/

--------------------------------------------------
[Graduated to "master"]

* ab/pull-rebase-config (2011-11-07) 1 commit
  (merged to 'next' on 2011-12-05 at 6d235a4)
 + pull: introduce a pull.rebase option to enable --rebase

* jc/pull-signed-tag (2011-11-12) 15 commits
  (merged to 'next' on 2011-12-05 at c949bd1)
 + commit-tree: teach -m/-F options to read logs from elsewhere
 + commit-tree: update the command line parsing
 + commit: teach --amend to carry forward extra headers
 + merge: force edit and no-ff mode when merging a tag object
 + commit: copy merged signed tags to headers of merge commit
 + merge: record tag objects without peeling in MERGE_HEAD
 + merge: make usage of commit->util more extensible
 + fmt-merge-msg: Add contents of merged tag in the merge message
 + fmt-merge-msg: package options into a structure
 + fmt-merge-msg: avoid early returns
 + refs DWIMmery: use the same rule for both "git fetch" and others
 + fetch: allow "git fetch $there v1.0" to fetch a tag
 + merge: notice local merging of tags and keep it unwrapped
 + fetch: do not store peeled tag object names in FETCH_HEAD
 + Split GPG interface into its own helper library
 (this branch is used by jc/signed-commit.)

Allow pulling/merging a signed tag instead of a branch tip, and record
the GPG signature in the merge commit for later audit.

* jc/request-pull-show-head-4 (2011-11-09) 12 commits
  (merged to 'next' on 2011-12-05 at 8f05b45)
 + request-pull: use the annotated tag contents
 + fmt-merge-msg.c: Fix an "dubious one-bit signed bitfield" sparse error
 + environment.c: Fix an sparse "symbol not declared" warning
 + builtin/log.c: Fix an "Using plain integer as NULL pointer" warning
 + fmt-merge-msg: use branch.$name.description
 + request-pull: use the branch description
 + request-pull: state what commit to expect
 + request-pull: modernize style
 + branch: teach --edit-description option
 + format-patch: use branch description in cover letter
 + branch: add read_branch_desc() helper function
 + Merge branch 'bk/ancestry-path' into jc/branch-desc

Allow setting "description" for branches and use it to help communications
between humans in various workflow elements. It also allows requesting for
a signed tag to be pulled and shows the tag message in the generated message.

* nd/resolve-ref (2011-12-05) 2 commits
  (merged to 'next' on 2011-12-05 at d55637f)
 + Copy resolve_ref() return value for longer use
 + Convert many resolve_ref() calls to read_ref*() and ref_exists()

* rs/allocate-cache-entry-individually (2011-10-26) 2 commits
  (merged to 'next' on 2011-12-05 at 241e711)
 + cache.h: put single NUL at end of struct cache_entry
 + read-cache.c: allocate index entries individually

* sg/complete-refs (2011-10-21) 9 commits
  (merged to 'next' on 2011-12-05 at 03e5527)
 + completion: remove broken dead code from __git_heads() and __git_tags()
 + completion: fast initial completion for config 'remote.*.fetch' value
 + completion: improve ls-remote output filtering in __git_refs_remotes()
 + completion: query only refs/heads/ in __git_refs_remotes()
 + completion: support full refs from remote repositories
 + completion: improve ls-remote output filtering in __git_refs()
 + completion: make refs completion consistent for local and remote repos
 + completion: optimize refs completion
 + completion: document __gitcomp()

--------------------------------------------------
[New Topics]

* rr/revert-cherry-pick (2011-12-09) 9 commits
 - revert: simplify communicating command-line arguments
 - revert: report fine-grained error messages from insn parser
 - revert: allow mixed pick and revert instructions
 - t3510 (cherry-pick-sequencer): remove malformed sheet 2
 - t3510 (cherry-pick-sequencer): use exit status
 - revert: simplify getting commit subject in format_todo()
 - revert: tolerate extra spaces, tabs in insn sheet
 - revert: make commit subjects in insn sheet optional
 - revert: free msg in format_todo()

This is not the latest one but the last one posted to the list.

* ew/keepalive (2011-12-05) 1 commit
 - enable SO_KEEPALIVE for connected TCP sockets

Comments?

* jc/checkout-m-twoway (2011-12-06) 1 commit
  (merged to 'next' on 2011-12-09 at c946009)
 + checkout -m: no need to insist on having all 3 stages

* tr/cache-tree (2011-12-06) 5 commits
 - reset: update cache-tree data when appropriate
 - commit: write cache-tree data when writing index anyway
 - Refactor cache_tree_update idiom from commit
 - Test the current state of the cache-tree optimization
 - Add test-scrap-cache-tree

Will merge to 'next' after taking another look.

* tr/userdiff-c-returns-pointer (2011-12-06) 1 commit
  (merged to 'next' on 2011-12-09 at 0b6a092)
 + userdiff: allow * between cpp funcname words

* jc/commit-amend-no-edit (2011-12-08) 5 commits
  (merged to 'next' on 2011-12-09 at b9cfa4e)
 + test: commit --amend should honor --no-edit
 + commit: honour --no-edit
 + t7501 (commit): modernize style
 + test: remove a porcelain test that hard-codes commit names
 + test: add missing "&&" after echo command

* jl/submodule-status-failure-report (2011-12-08) 1 commit
  (merged to 'next' on 2011-12-09 at 53eb3b3)
 + diff/status: print submodule path when looking for changes fails

* ks/tag-cleanup (2011-12-09) 1 commit
  (merged to 'next' on 2011-12-09 at cbea045)
 + git-tag: introduce --cleanup option

* rr/test-chaining (2011-12-09) 5 commits
 - t3040 (subprojects-basic): fix '&&' chaining, modernize style
 - t1510 (worktree): fix '&&' chaining
 - t3030 (merge-recursive): use test_expect_code
 - test: fix '&&' chaining
 - t3200 (branch): fix '&&' chaining

I think Martin's patches to t3401 should also be queued here.

--------------------------------------------------
[Cooking]

* bc/maint-apply-check-no-patch (2011-12-05) 2 commits
  (merged to 'next' on 2011-12-09 at fc780cd)
 + builtin/apply.c: report error on failure to recognize input
 + t/t4131-apply-fake-ancestor.sh: fix broken test

* aw/rebase-i-stop-on-failure-to-amend (2011-11-30) 1 commit
  (merged to 'next' on 2011-12-09 at a117e83)
 + rebase -i: interrupt rebase when "commit --amend" failed during "reword"

* jc/split-blob (2011-12-01) 6 commits
 . WIP (streaming chunked)
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding
 (this branch uses jc/stream-to-pack.)

Not ready. At least pack-objects and fsck need to learn the new encoding
for the series to be usable locally, and then index-pack/unpack-objects
needs to learn it to be used remotely.

* jh/fast-import-notes (2011-11-28) 3 commits
  (merged to 'next' on 2011-12-09 at 2b01132)
 + fast-import: Fix incorrect fanout level when modifying existing notes refs
 + t9301: Add 2nd testcase exposing bugs in fast-import's notes fanout handling
 + t9301: Fix testcase covering up a bug in fast-import's notes fanout handling

Comments?

* tj/maint-imap-send-remove-unused (2011-11-23) 2 commits
  (merged to 'next' on 2011-12-09 at 877cc11)
 + Merge branch 'maint' into tj/imap-send-remove-unused
 + imap-send: Remove unused 'use_namespace' variable

* cn/maint-lf-to-crlf-filter (2011-11-28) 1 commit
  (merged to 'next' on 2011-12-09 at c374d14)
 + convert: track state in LF-to-CRLF filter

* jn/branch-move-to-self (2011-11-28) 2 commits
  (merged to 'next' on 2011-12-09 at 7d27260)
 + Allow checkout -B <current-branch> to update the current branch
 + branch: allow a no-op "branch -M <current-branch> HEAD"

* jk/credentials (2011-12-09) 20 commits
 - credential: use git_prompt instead of git_getpass
 - prompt: use git_terminal_prompt
 - add generic terminal prompt function
 - refactor git_getpass into generic prompt function
 - move git_getpass to its own source file
 - imap-send: don't check return value of git_getpass
 - imap-send: avoid buffer overflow
 - t: add test harness for external credential helpers
 - credentials: add "store" helper
 - strbuf: add strbuf_add*_urlencode
 - credentials: add "cache" helper
 - docs: end-user documentation for the credential subsystem
 - credential: make relevance of http path configurable
 - credential: add credential.*.username
 - credential: apply helper config
 - http: use credential API to get passwords
 - credential: add function for parsing url components
 - introduce credentials API
 - t5550: fix typo
 - test-lib: add test_config_global variant

Looking good.

* nd/ignore-might-be-precious (2011-11-28) 2 commits
  (merged to 'next' on 2011-12-09 at 1a94553)
 + checkout,merge: disallow overwriting ignored files with --no-overwrite-ignore
 + Merge branch 'nd/maint-ignore-exclude' into nd/ignore-might-be-precious

* jk/upload-archive-use-start-command (2011-11-21) 1 commit
  (merged to 'next' on 2011-12-09 at 88cb83a)
 + upload-archive: use start_command instead of fork

* jk/maint-1.6.2-upload-archive (2011-11-21) 1 commit
 + archive: don't let remote clients get unreachable commits
 (this branch is used by jk/maint-upload-archive.)

* jk/maint-upload-archive (2011-11-21) 1 commit
  (merged to 'next' on 2011-12-09 at 03deb16)
 + Merge branch 'jk/maint-1.6.2-upload-archive' into jk/maint-upload-archive
 (this branch uses jk/maint-1.6.2-upload-archive.)

* ab/enable-i18n (2011-12-05) 1 commit
 - i18n: add infrastructure for translating Git with gettext

Will merge to 'next'.

* jc/signed-commit (2011-11-29) 5 commits
 - gpg-interface: allow use of a custom GPG binary
 - pretty: %G[?GS] placeholders
 - test "commit -S" and "log --show-signature"
 - log: --show-signature
 - commit: teach --gpg-sign option

Not exactly urgent.

* jc/stream-to-pack (2011-12-01) 5 commits
  (merged to 'next' on 2011-12-09 at d0fd605)
 + bulk-checkin: replace fast-import based implementation
 + csum-file: introduce sha1file_checkpoint
 + finish_tmp_packfile(): a helper function
 + create_tmp_packfile(): a helper function
 + write_pack_header(): a helper function
 (this branch is used by jc/split-blob.)

Teaches "git add" to send large-ish blob data straight to a packfile.
This is a continuation to the "large file support" topic. The codepath to
move data from worktree to repository is made aware of streaming, just
like the checkout codepath that goes the other way, which was done in the
previous "large file support" topic in the 1.7.7 cycle.

* jn/gitweb-side-by-side-diff (2011-10-31) 8 commits
 - gitweb: Add navigation to select side-by-side diff
 - gitweb: Use href(-replay=>1,...) for formats links in "commitdiff"
 - t9500: Add basic sanity tests for side-by-side diff in gitweb
 - t9500: Add test for handling incomplete lines in diff by gitweb
 - gitweb: Give side-by-side diff extra CSS styling
 - gitweb: Add a feature to show side-by-side diff
 - gitweb: Extract formatting of diff chunk header
 - gitweb: Refactor diff body line classification

Replaces a series from Kato Kazuyoshi on the same topic.
Is this ready for 'next'?

--------------------------------------------------
[Discarded]

* hv/submodule-merge-search (2011-10-13) 4 commits
 . submodule.c: make two functions static
 . allow multiple calls to submodule merge search for the same path
 . push: Don't push a repository with unpushed submodules
 . push: teach --recurse-submodules the on-demand option

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 . t5800: point out that deleting branches does not work
 . t5800: document inability to push new branch with old content

* sr/fix-fast-export-tips (2011-11-05) 3 commits
 . fast-export: output reset command for commandline revs
 . fast-export: do not refer to non-existing marks
 . t9350: point out that refs are not updated correctly

* jc/lookup-object-hash (2011-08-11) 6 commits
 . object hash: replace linear probing with 4-way cuckoo hashing
 . object hash: we know the table size is a power of two
 . object hash: next_size() helper for readability
 . pack-objects --count-only
 . object.c: remove duplicated code for object hashing
 . object.c: code movement for readability

* jc/verbose-checkout (2011-10-16) 2 commits
 . checkout -v: give full status output after switching branches
 . checkout: move the local changes report to the end

* eh/grep-scale-to-cpunum (2011-11-05) 1 commit
 . grep: detect number of CPUs for thread spawning

* jc/commit-tree-extra (2011-11-12) 2 commits
 . commit-tree: teach -C <extra-commit>
 . commit-tree: teach -x <extra>
 (this branch uses jc/pull-signed-tag; is tangled with jc/signed-commit.)

* cb/daemon-permission-errors (2011-10-17) 2 commits
 . daemon: report permission denied error to clients
 . daemon: add tests

* ld/p4-labels-branches (2011-11-30) 4 commits
 . git-p4: importing labels should cope with missing owner
 . git-p4: add test for p4 labels
 . git-p4: cope with labels with empty descriptions
 . git-p4: handle p4 branches and labels containing shell chars

* mh/ref-api-2 (2011-11-16) 15 commits
 . refs: loosen over-strict "format" check
 . resolve_gitlink_ref_recursive(): change to work with struct ref_cache
 . Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
 . resolve_gitlink_ref(): improve docstring
 . get_ref_dir(): change signature
 . refs: change signatures of get_packed_refs() and get_loose_refs()
 . is_dup_ref(): extract function from sort_ref_array()
 . add_ref(): add docstring
 . parse_ref_line(): add docstring
 . is_refname_available(): remove the "quiet" argument
 . clear_ref_array(): rename from free_ref_array()
 . refs: rename parameters result -> sha1
 . refs: rename "refname" variables
 . struct ref_entry: document name member
 . cache.h: add comments for git_path() and git_path_submodule()
 (this branch is tangled with mh/ref-api-3.)

* mh/ref-api-3 (2011-11-16) 26 commits
 . refs: loosen over-strict "format" check
 . is_refname_available(): reimplement using do_for_each_ref_in_array()
 . names_conflict(): simplify implementation
 . names_conflict(): new function, extracted from is_refname_available()
 . repack_without_ref(): reimplement using do_for_each_ref_in_array()
 . do_for_each_ref_in_array(): new function
 . do_for_each_ref(): correctly terminate while processesing extra_refs
 . add_ref(): take a (struct ref_entry *) parameter
 . create_ref_entry(): extract function from add_ref()
 . parse_ref_line(): add a check that the refname is properly formatted
 . repack_without_ref(): remove temporary
 . Rename another local variable name -> refname
 . resolve_gitlink_ref_recursive(): change to work with struct ref_cache
 . Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
 . resolve_gitlink_ref(): improve docstring
 . get_ref_dir(): change signature
 . refs: change signatures of get_packed_refs() and get_loose_refs()
 . is_dup_ref(): extract function from sort_ref_array()
 . add_ref(): add docstring
 . parse_ref_line(): add docstring
 . is_refname_available(): remove the "quiet" argument
 . clear_ref_array(): rename from free_ref_array()
 . refs: rename parameters result -> sha1
 . refs: rename "refname" variables
 . struct ref_entry: document name member
 . cache.h: add comments for git_path() and git_path_submodule()
 (this branch is tangled with mh/ref-api-2.)
