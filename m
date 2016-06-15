From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Sat, 04 Dec 2010 22:30:21 -0800
Message-ID: <7voc90wx36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 05 07:30:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PP87b-0004Cy-KL
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 07:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab0LEGab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 01:30:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab0LEGa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 01:30:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C3223E22;
	Sun,  5 Dec 2010 01:30:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=3qm/
	kAILoaRvFbgKZ0++MB+PqJ0=; b=ICxrSMoPT7+313fcB0g3U+ZuXzeA2BON8SAr
	IpYkSf1AImBCH3uKrGRTjHyIdOixs4wNCvfw45Hc14ep48vyzWB+6OF5VAphdhAZ
	EIrobOAzUVfa315Dvt8NMbm9wrp2fD7N9wn2Zs1JYAiE1b3TVsYiYXggeo+9z/3F
	U0HZDYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ne9
	sYcPG2yEZoVMrkkoTCW53xlIc0QTjE36kYvhMOGwlmSUabLCs/affeL+VB5gdnhB
	I+/mi8Niz0xgsIAOOUsgdVqGZDxFeZ1Ug+gjCSuoivU6pQkPl8upyWFJfVAYZ81a
	9zLUtK+/SfbwkhIqmjc95G7rPhrKszL5L8ttTaVI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECCA03E21;
	Sun,  5 Dec 2010 01:30:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1A0743E20; Sun,  5 Dec 2010
 01:30:44 -0500 (EST)
X-master-at: 0b0cd0e0a29a139f418991dd769ea4266ffec370
X-next-at: 98527b968b3ba19b57ff8906ec69d51dceda9030
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 325E8934-0039-11E0-8517-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162929>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[New Topics]

* aa/status-hilite-branch (2010-11-18) 1 commit
 - status: show branchname with a configurable color

I am indifferent/uninterested; I don't see anything wrong with it, but I
do not find coloring the field particularly useful myself.

* ef/help-cmd-prefix (2010-11-26) 2 commits
 - (jc) review comments
 - help: always suggest common-cmds if prefix of cmd

Reroll, or squash?

* jn/fast-import-blob-access (2010-12-03) 5 commits
 - t9300: remove unnecessary use of /dev/stdin
 - fast-import: Allow cat-blob requests at arbitrary points in stream
 - fast-import: let importers retrieve blobs
 - fast-import: clarify documentation of "feature" command
 - fast-import: stricter parsing of integer options

Will merge to 'next' soon.

* jn/gitweb-per-request-config (2010-11-28) 2 commits
 - gitweb: document $per_request_config better
 - gitweb: selectable configurations that change with each request

Will merge to 'next' soon.

* kb/diff-C-M-synonym (2010-11-29) 1 commit
 - diff: add --detect-copies-harder as a synonym for --find-copies-harder

Will merge to 'next' soon.

* mg/cvsimport (2010-11-28) 3 commits
 - cvsimport.txt: document the mapping between config and options
 - cvsimport: fix the parsing of uppercase config options
 - cvsimport: partial whitespace cleanup

I was being lazy and said "Ok" to "cvsimport.capital-r" but luckily other
people injected sanity to the discussion.  Weatherbaloon patch sent, but
not queued here.

* mz/maint-rebase-stat-config (2010-11-09) 1 commit
 - rebase: only show stat if configured to true

Will merge to 'next' soon.

* mz/pull-rebase-rebased (2010-11-13) 1 commit
 - Use reflog in 'pull --rebase . foo'

Will merge to 'next' soon.

* nd/maint-hide-checkout-index-from-error (2010-11-28) 1 commit
 - entry.c: remove "checkout-index" from error messages

Will merge to 'next' soon.

* tf/commit-list-prefix (2010-11-26) 1 commit
 - commit: Add commit_list prefix in two function names.

* gb/web--browse (2010-12-03) 4 commits
 - web--browse: better support for chromium
 - web--browse: support opera, seamonkey and elinks
 - web--browse: split valid_tool list
 - web--browse: coding style

Will merge to 'next' soon.  The remainder of the series, which is mostly
Debian specific addition, can wait (or just left for the distro).

* ja/maint-pull-rebase-doc (2010-12-03) 1 commit
 - git-pull.txt: Mention branch.autosetuprebase

Will merge to 'next'.

* js/configurable-tab (2010-11-30) 2 commits
 - Make the tab width used for whitespace checks configurable
 - Merge branch 'js/maint-apply-tab-in-indent-fix' into HEAD
 (this branch uses js/maint-apply-tab-in-indent-fix.)

Will merge to 'next'.

* js/maint-apply-tab-in-indent-fix (2010-11-30) 1 commit
 - apply --whitespace=fix: fix tab-in-indent
 (this branch is used by js/configurable-tab.)

Will merge to 'next'.

* pd/bash-4-completion (2010-12-01) 2 commits
 - Use the new functions to get the current cword.
 - Introduce functions from bash-completion project.

There is a "here is a better way to do this" from Jonathan, still in
flight.

--------------------------------------------------
[Graduated to "master"]

* ak/apply-non-git-epoch (2010-09-29) 2 commits
  (merged to 'next' on 2010-11-17 at a00579c)
 + apply: handle patches with funny filename and colon in timezone
 + apply: Recognize epoch timestamps with : in the timezone

* cb/leading-path-removal (2010-11-15) 6 commits
  (merged to 'next' on 2010-11-17 at ec7d709)
 + use persistent memory for rejected paths
  (merged to 'next' on 2010-11-05 at 55ea322)
 + do not overwrite files in leading path
 + lstat_cache: optionally return match_len
 + add function check_ok_to_remove()
 + t7607: add leading-path tests
 + t7607: use test-lib functions and check MERGE_HEAD

* cm/diff-check-at-eol (2010-10-10) 1 commit
  (merged to 'next' on 2010-11-17 at ad7005a)
 + diff --check: correct line numbers of new blank lines at EOF

* en/merge-recursive (2010-11-08) 40 commits
  (merged to 'next' on 2010-11-17 at 1b6f865)
 + t6022: Use -eq not = to test output of wc -l
  (merged to 'next' on 2010-11-05 at 16902eb)
 + merge-recursive:make_room_for_directories - work around dumb compilers
 + merge-recursive: Remove redundant path clearing for D/F conflicts
 + merge-recursive: Make room for directories in D/F conflicts
 + handle_delete_modify(): Check whether D/F conflicts are still present
 + merge_content(): Check whether D/F conflicts are still present
 + conflict_rename_rename_1to2(): Fix checks for presence of D/F conflicts
 + conflict_rename_delete(): Check whether D/F conflicts are still present
 + merge-recursive: Delay modify/delete conflicts if D/F conflict present
 + merge-recursive: Delay content merging for renames
 + merge-recursive: Delay handling of rename/delete conflicts
 + merge-recursive: Move handling of double rename of one file to other file
 + merge-recursive: Move handling of double rename of one file to two
 + merge-recursive: Avoid doubly merging rename/add conflict contents
 + merge-recursive: Update merge_content() call signature
 + merge-recursive: Update conflict_rename_rename_1to2() call signature
 + merge-recursive: Structure process_df_entry() to handle more cases
 + merge-recursive: Have process_entry() skip D/F or rename entries
 + merge-recursive: New function to assist resolving renames in-core only
 + merge-recursive: New data structures for deferring of D/F conflicts
 + merge-recursive: Move process_entry's content merging into a function
 + merge-recursive: Move delete/modify handling into dedicated function
 + merge-recursive: Move rename/delete handling into dedicated function
 + merge-recursive: Nuke rename/directory conflict detection
 + merge-recursive: Rename conflict_rename_rename*() for clarity
 + merge-recursive: Small code clarification -- variable name and comments
 + t6036: Add testcase for undetected conflict
 + t6036: Add a second testcase similar to the first but with content changes
 + t6036: Test index and worktree state, not just that merge fails
 + t6020: Add a testcase for modify/delete + directory/file conflict
 + t6020: Modernize style a bit
 + t6022: Add tests for rename/rename combined with D/F conflicts
 + t6022: Add paired rename+D/F conflict: (two/file, one/file) -> (one, two)
 + t6022: Add tests with both rename source & dest involved in D/F conflicts
 + t6022: Add tests for reversing order of merges when D/F conflicts present
 + t6022: Add test combinations of {content conflict?, D/F conflict remains?}
 + t6032: Add a test checking for excessive output from merge
 + merge-recursive: Restructure showing how to chain more process_* functions
 + t3030: Add a testcase for resolvable rename/add conflict with symlinks
 + Merge branch 'en/rename-d-f' into en/merge-recursive
 (this branch uses en/rename-d-f.)

* en/rename-d-f (2010-09-08) 2 commits
 + merge-recursive: D/F conflicts where was_a_dir/file -> was_a_dir
 + t3509: Add rename + D/F conflict testcase that recursive strategy fails
 (this branch is used by en/merge-recursive.)

* fc/apply-p2-get-header-name (2010-10-21) 2 commits
  (merged to 'next' on 2010-11-17 at 05a8e94)
 + test: git-apply -p2 rename/chmod only
 + Fix git-apply with -p greater than 1

* jc/abbrev-guard (2010-10-28) 1 commit
  (merged to 'next' on 2010-11-24 at f26c943)
 + core.abbrevguard: Ensure short object names stay unique a bit longer

* jc/emfile (2010-10-28) 2 commits
  (merged to 'next' on 2010-11-17 at dac1bc6)
 + A loose object is not corrupt if it cannot be read due to EMFILE
 + read_sha1_file(): report correct name of packfile with a corrupt object
 (this branch is used by sp/emfile.)

* jj/icase-directory (2010-10-03) 8 commits
  (merged to 'next' on 2010-11-24 at 0da9385)
 + Support case folding in git fast-import when core.ignorecase=true
 + Support case folding for git add when core.ignorecase=true
 + Add case insensitivity support when using git ls-files
 + Add case insensitivity support for directories when using git status
 + Case insensitivity support for .gitignore via core.ignorecase
 + Add string comparison functions that respect the ignore_case variable.
 + Makefile & configure: add a NO_FNMATCH_CASEFOLD flag
 + Makefile & configure: add a NO_FNMATCH flag

* jl/add-p-reverse-message (2010-10-27) 1 commit
  (merged to 'next' on 2010-11-17 at db2ce14)
 + Correct help blurb in checkout -p and friends

* jl/clone-recurse-sm-synonym (2010-11-04) 1 commit
  (merged to 'next' on 2010-11-17 at 8c326c2)
 + clone: Add the --recurse-submodules option as alias for --recursive

* jn/cherry-pick-refresh-index (2010-10-31) 1 commit
  (merged to 'next' on 2010-11-17 at 75e9103)
 + cherry-pick/revert: transparently refresh index

* jn/fast-import-fix (2010-10-20) 4 commits
  (merged to 'next' on 2010-11-17 at ef3b791)
 + fast-import: do not clear notes in do_change_note_fanout()
 + t9300 (fast-import): another test for the "replace root" feature
 + fast-import: tighten M 040000 syntax
 + fast-import: filemodify after M 040000 <tree> "" crashes

* jn/ignore-doc (2010-11-10) 2 commits
  (merged to 'next' on 2010-11-24 at c0a9730)
 + Documentation: point to related commands from gitignore
 + Documentation: split gitignore page into sections

* jn/thinner-wrapper (2010-11-06) 7 commits
  (merged to 'next' on 2010-11-24 at 3f2227d)
 + Remove pack file handling dependency from wrapper.o
 + pack-objects: mark file-local variable static
 + wrapper: give zlib wrappers their own translation unit
 + strbuf: move strbuf_branchname to sha1_name.c
 + path helpers: move git_mkstemp* to wrapper.c
 + wrapper: move odb_* to environment.c
 + wrapper: move xmmap() to sha1_file.c

* js/configuable-tab (2010-11-29) 1 commit
 - Make the tab width used for whitespace checks configurable

* kb/blame-author-email (2010-10-15) 1 commit
  (merged to 'next' on 2010-11-17 at 6fd6a2f)
 + blame: Add option to show author email instead of name

* kb/maint-status-cquote (2010-11-08) 1 commit
  (merged to 'next' on 2010-11-24 at e15b73d)
 + status: Quote paths with spaces in short format

* md/interix (2010-10-27) 2 commits
  (merged to 'next' on 2010-11-17 at 2a8b562)
 + Interix: add configure checks
 + add support for the SUA layer (interix; windows)

* np/diff-in-corrupt-repository (2010-10-22) 1 commit
  (merged to 'next' on 2010-11-17 at b57a6cb)
 + diff: don't presume empty file when corresponding object is missing

* np/pack-broken-boundary (2010-10-22) 1 commit
  (merged to 'next' on 2010-11-17 at 69a9f46)
 + make pack-objects a bit more resilient to repo corruption

* pn/commit-autosquash (2010-11-02) 6 commits
  (merged to 'next' on 2010-11-24 at acc9c78)
 + add tests of commit --squash
 + commit: --squash option for use with rebase --autosquash
 + add tests of commit --fixup
 + commit: --fixup option for use with rebase --autosquash
 + pretty.c: teach format_commit_message() to reencode the output
 + commit: helper methods to reduce redundant blocks of code

* rr/needs-clean-work-tree (2010-10-19) 1 commit
  (merged to 'next' on 2010-11-17 at b8aee21)
 + Porcelain scripts: Rewrite cryptic "needs update" error message

* sn/diff-doc (2010-11-04) 3 commits
  (merged to 'next' on 2010-11-24 at 77190a5)
 + docs: clarify git diff modes of operation
 + diff,difftool: Don't use the {0,2} notation in usage strings
 + CodingGuidelines: Add a section on writing documentation

* sp/emfile (2010-11-01) 2 commits
  (merged to 'next' on 2010-11-24 at f46d2ce)
 + Work around EMFILE when there are too many pack files
 + Use git_open_noatime when accessing pack data

* tc/smart-http-post-redirect (2010-09-25) 1 commit
  (merged to 'next' on 2010-11-17 at 6478f7f)
 + smart-http: Don't change POST to GET when following redirect

--------------------------------------------------
[Stalled]

* nd/index-doc (2010-09-06) 1 commit
 - doc: technical details about the index file format

Half-written but it is a good start.  I may need to give some help in
describing more recent index extensions.

* cb/ignored-paths-are-precious (2010-08-21) 1 commit
 - checkout/merge: optionally fail operation when ignored files need to be overwritten

This needs tests; also we know of longstanding bugs in related area that
needs to be addressed---they do not have to be part of this series but
their reproduction recipe would belong to the test script for this topic.

It would hurt users to make the new feature on by default, especially the
ones with subdirectories that come and go.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* tr/config-doc (2010-10-24) 2 commits
 . Documentation: complete config list from other manpages
 . Documentation: Move variables from config.txt to separate file

This unfortunately heavily conflicts with patches in flight...

--------------------------------------------------
[Cooking]

* ef/win32-dirent (2010-11-23) 6 commits
 - win32: use our own dirent.h
 - msvc: opendir: handle paths ending with a slash
 - win32: dirent: handle errors
 - msvc: opendir: do not start the search
 - msvc: opendir: allocate enough memory
 - msvc: opendir: fix malloc-failure

Will merge to 'next' soon.

* jk/asciidoc-update (2010-11-19) 1 commit
 - docs: default to more modern toolset

Will merge to 'next' soon.

* jk/maint-reflog-bottom (2010-11-21) 1 commit
 - reflogs: clear flags properly in corner case

Will merge to 'next' soon.

* jn/fast-import-ondemand-checkpoint (2010-11-22) 1 commit
 - fast-import: treat SIGUSR1 as a request to access objects early

* jn/maint-fast-import-object-reuse (2010-11-23) 1 commit
 - fast-import: insert new object entries at start of hash bucket

Will merge to 'next' soon.

* jn/maint-svn-fe (2010-10-10) 1 commit
 - t9010 (svn-fe): Eliminate dependency on svn perl bindings

Will merge to 'next' soon.

* jn/svn-fe (2010-11-19) 17 commits
 - vcs-svn: Implement Prop-delta handling
 - vcs-svn: Sharpen parsing of property lines
 - vcs-svn: Split off function for handling of individual properties
 - vcs-svn: Make source easier to read on small screens
 - vcs-svn: More dump format sanity checks
 - vcs-svn: Reject path nodes without Node-action
 - vcs-svn: Delay read of per-path properties
 - vcs-svn: Combine repo_replace and repo_modify functions
 - vcs-svn: Replace = Delete + Add
 - vcs-svn: handle_node: Handle deletion case early
 - vcs-svn: Use mark to indicate nodes with included text
 - vcs-svn: Unclutter handle_node by introducing have_props var
 - vcs-svn: Eliminate node_ctx.mark global
 - vcs-svn: Eliminate node_ctx.srcRev global
 - vcs-svn: Check for errors from open()
 - vcs-svn: Allow simple v3 dumps (no deltas yet)
 - vcs-svn: Error out for v3 dumps

Some RFC patches, to give them early and wider exposure.

* mz/rebase-abort-reflog-fix (2010-11-21) 1 commit
 - rebase --abort: do not update branch ref

* mz/rebase-i-verify (2010-11-22) 1 commit
 - rebase: support --verify

Will merge to 'next' soon.

* nd/maint-relative (2010-11-20) 1 commit
 - get_cwd_relative(): do not misinterpret root path

Will merge to 'next' soon.

* tc/format-patch-p (2010-11-23) 1 commit
 - format-patch: page output with --stdout

I am indifferent/uninterested; I don't see anything wrong with it,
though.

* tc/http-urls-ends-with-slash (2010-11-25) 9 commits
 - http-fetch: rework url handling
 - http-push: add trailing slash at arg-parse time, instead of later on
 - http-push: check path length before using it
 - http-push: Normalise directory names when pushing to some WebDAV servers
 - http-backend: use end_url_with_slash()
 - url: add str wrapper for end_url_with_slash()
 - shift end_url_with_slash() from http.[ch] to url.[ch]
 - t5550-http-fetch: add test for http-fetch
 - t5550-http-fetch: add missing '&&'

Will merge to 'next' soon.

* gb/gitweb-remote-heads (2010-11-11) 11 commits
  (merged to 'next' on 2010-11-24 at 6fb4a6f)
 + git instaweb: enable remote_heads
 + gitweb: group remote heads by remote
 + gitweb: provide a routine to display (sub)sections
 + gitweb: refactor repository URL printing
 + gitweb: remotes view for a single remote
 + gitweb: allow action specialization in page header
 + gitweb: nagivation menu for tags, heads and remotes
 + gitweb: separate heads and remotes lists
 + gitweb: git_get_heads_list accepts an optional list of refs
 + gitweb: introduce remote_heads feature
 + gitweb: use fullname as hash_base in heads link

* gc/http-with-non-ascii-username-url (2010-11-14) 2 commits
  (merged to 'next' on 2010-11-24 at 08f317f)
 + Fix username and password extraction from HTTP URLs
 + t5550: test HTTP authentication and userinfo decoding

* jk/maint-decorate-01-bool (2010-11-17) 1 commit
  (merged to 'next' on 2010-11-24 at 347f73b)
 + log.decorate: accept 0/1 bool values
 (this branch is used by jk/pager-per-command.)

* jk/pager-per-command (2010-11-17) 1 commit
  (merged to 'next' on 2010-11-24 at 9ebcffc)
 + allow command-specific pagers in pager.<cmd>
 (this branch uses jk/maint-decorate-01-bool.)

* jn/getenv-poison (2010-11-12) 1 commit
 . add GETENV_POISON option to simulate unfriendly getenv()
 (this branch uses ks/maint-getenv-fix.)

* jn/gitweb-time-hires-comes-with-5.8 (2010-11-09) 1 commit
  (merged to 'next' on 2010-11-24 at 6b91b41)
 + gitweb: Time::HiRes is in core for Perl 5.8

* ks/maint-getenv-fix (2010-11-11) 1 commit
  (merged to 'next' on 2010-11-24 at fa89826)
 + setup: make sure git_dir path is in a permanent buffer, getenv(3) case
 (this branch is used by jn/getenv-poison.)

* nd/extended-sha1-relpath (2010-11-28) 2 commits
 - get_sha1: support relative path ":path" syntax
 - Make prefix_path() return char* without const
 (this branch uses jn/parse-options-extra.)

As jn/parse-options-extra seems to be still rerolled, this needs to stay
outside 'next' waiting for it.

* nd/maint-fix-add-typo-detection (2010-11-27) 6 commits
 - Revert "excluded_1(): support exclude files in index"
 - unpack-trees: fix sparse checkout's "unable to match directories"
 - unpack-trees: move all skip-worktree checks back to unpack_trees()
 - dir.c: add free_excludes()
 - cache.h: realign and use (1 << x) form for CE_* constants
  (merged to 'next' on 2010-11-24 at 6832306)
 + add: do not rely on dtype being NULL behavior

Will merge to 'next'.

* jh/gitweb-caching (2010-12-03) 4 commits
 - gitweb: Minimal testing of gitweb caching
 - gitweb: File based caching layer (from git.kernel.org)
 - gitweb: add output buffering and associated functions
 - gitweb: Prepare for splitting gitweb

Slightly updated.

* jn/parse-options-extra (2010-12-01) 10 commits
 - update-index: migrate to parse-options API
 - setup: save prefix (original cwd relative to toplevel) in startup_info
 - parse-options: make resuming easier after PARSE_OPT_STOP_AT_NON_OPTION
 - parse-options: allow git commands to invent new option types
 - parse-options: never suppress arghelp if LITERAL_ARGHELP is set
 - parse-options: do not infer PARSE_OPT_NOARG from option type
 - parse-options: sanity check PARSE_OPT_NOARG flag
 - parse-options: move NODASH sanity checks to parse_options_check
 - parse-options: clearer reporting of API misuse
 - parse-options: Don't call parse_options_check() so much
 (this branch is used by nd/extended-sha1-relpath.)

Rerolled.

* nd/setup (2010-11-26) 47 commits
 - git.txt: correct where --work-tree path is relative to
 - Revert "Documentation: always respect core.worktree if set"
 - t0001: test git init when run via an alias
 - Remove all logic from get_git_work_tree()
 - setup: rework setup_explicit_git_dir()
 - setup: clean up setup_discovered_git_dir()
 - t1020-subdirectory: test alias expansion in a subdirectory
 - setup: clean up setup_bare_git_dir()
 - setup: limit get_git_work_tree()'s to explicit setup case only
 - Use git_config_early() instead of git_config() during repo setup
 - Add git_config_early()
 - rev-parse: prints --git-dir relative to user's cwd
 - git-rev-parse.txt: clarify --git-dir
 - t1510: setup case #31
 - t1510: setup case #30
 - t1510: setup case #29
 - t1510: setup case #28
 - t1510: setup case #27
 - t1510: setup case #26
 - t1510: setup case #25
 - t1510: setup case #24
 - t1510: setup case #23
 - t1510: setup case #22
 - t1510: setup case #21
 - t1510: setup case #20
 - t1510: setup case #19
 - t1510: setup case #18
 - t1510: setup case #17
 - t1510: setup case #16
 - t1510: setup case #15
 - t1510: setup case #14
 - t1510: setup case #13
 - t1510: setup case #12
 - t1510: setup case #11
 - t1510: setup case #10
 - t1510: setup case #9
 - t1510: setup case #8
 - t1510: setup case #7
 - t1510: setup case #6
 - t1510: setup case #5
 - t1510: setup case #4
 - t1510: setup case #3
 - t1510: setup case #2
 - t1510: setup case #1
 - t1510: setup case #0
 - Add t1510 and basic rules that run repo setup
 - builtins: print setup info if repo is found

Rerolled.

* mg/maint-tag-rfc1991 (2010-11-10) 5 commits
  (merged to 'next' on 2010-11-24 at 03864ed)
 + tag: recognize rfc1991 signatures
 + tag: factor out sig detection for tag display
 + tag: factor out sig detection for body edits
 + verify-tag: factor out signature detection
 + t/t7004-tag: test handling of rfc1991 signatures

* jk/diff-CBM (2010-10-21) 1 commit
  (merged to 'next' on 2010-11-05 at 9d1ec14)
 + diff: report bogus input to -C/-M/-B

Will merge to master soonish.

* jn/git-cmd-h-bypass-setup (2010-10-22) 7 commits
 - update-index -h: show usage even with corrupt index
 - merge -h: show usage even with corrupt index
 - ls-files -h: show usage even with corrupt index
 - gc -h: show usage even with broken configuration
 - commit/status -h: show usage even with broken configuration
 - checkout-index -h: show usage even in an invalid repository
 - branch -h: show usage even in an invalid repository

Will merge to 'next'.

* yd/dir-rename (2010-10-29) 5 commits
 - Allow hiding renames of individual files involved in a directory rename.
 - Unified diff output format for bulk moves.
 - Add testcases for the --detect-bulk-moves diffcore flag.
 - Raw diff output format for bulk moves.
 - Introduce bulk-move detection in diffcore.

Yet to be rerolled.

* il/remote-fd-ext (2010-11-17) 4 commits
  (merged to 'next' on 2010-11-24 at ef80cf1)
 + remote-fd/ext: finishing touches after code review
  (merged to 'next' on 2010-11-05 at 7413413)
 + git-remote-ext
 + git-remote-fd
 + Add bidirectional_transfer_loop()

* jh/notes-merge (2010-11-09) 23 commits
  (merged to 'next' on 2010-11-24 at 6218115)
 + Provide 'git merge --abort' as a synonym to 'git reset --merge'
 + cmd_merge(): Parse options before checking MERGE_HEAD
 + Provide 'git notes get-ref' to easily retrieve current notes ref
 + git notes merge: Add testcases for merging notes trees at different fanouts
 + git notes merge: Add another auto-resolving strategy: "cat_sort_uniq"
 + git notes merge: --commit should fail if underlying notes ref has moved
 + git notes merge: List conflicting notes in notes merge commit message
 + git notes merge: Manual conflict resolution, part 2/2
 + git notes merge: Manual conflict resolution, part 1/2
 + Documentation: Preliminary docs on 'git notes merge'
 + git notes merge: Add automatic conflict resolvers (ours, theirs, union)
 + git notes merge: Handle real, non-conflicting notes merges
 + builtin/notes.c: Refactor creation of notes commits.
 + git notes merge: Initial implementation handling trivial merges only
 + builtin/notes.c: Split notes ref DWIMmery into a separate function
 + notes.c: Use two newlines (instead of one) when concatenating notes
 + (trivial) t3303: Indent with tabs instead of spaces for consistency
 + notes.h/c: Propagate combine_notes_fn return value to add_note() and beyond
 + notes.h/c: Allow combine_notes functions to remove notes
 + notes.c: Reorder functions in preparation for next commit
 + notes.h: Make default_notes_ref() available in notes API
 + (trivial) notes.h: Minor documentation fixes to copy_notes()
 + notes.c: Hexify SHA1 in die() message from init_notes()

* nd/struct-pathspec (2010-09-20) 5 commits
 - ce_path_match: drop prefix matching in favor of match_pathspec
 - Convert ce_path_match() to use struct pathspec
 - tree_entry_interesting: turn to match_pathspec if wildcard is present
 - pathspec: add tree_recursive_diff parameter
 - pathspec: mark wildcard pathspecs from the beginning
 (this branch is tangled with en/object-list-with-pathspec.)

This is related to something I have long been wanting to see happen.
Wait Nguyen for another round (2010-11-11).

* en/object-list-with-pathspec (2010-09-20) 8 commits
 - Add testcases showing how pathspecs are handled with rev-list --objects
 - Make rev-list --objects work together with pathspecs
 - Move tree_entry_interesting() to tree-walk.c and export it
 - tree_entry_interesting(): remove dependency on struct diff_options
 - Convert struct diff_options to use struct pathspec
 - pathspec: cache string length when initializing pathspec
 - diff-no-index: use diff_tree_setup_paths()
 - Add struct pathspec
 (this branch is tangled with nd/struct-pathspec.)

* jl/fetch-submodule-recursive (2010-11-11) 3 commits
 - Submodules: Add the "fetchRecurseSubmodules" config option
 - Add the 'fetch.recurseSubmodules' config setting
 - fetch/pull: Add the --recurse-submodules option

Will merge to 'next' soonish.

* tr/merge-unborn-clobber (2010-08-22) 1 commit
 - Exhibit merge bug that clobbers index&WT

* ab/i18n (2010-10-07) 161 commits
 - po/de.po: complete German translation
 - po/sv.po: add Swedish translation
 - gettextize: git-bisect bisect_next_check "You need to" message
 - gettextize: git-bisect [Y/n] messages
 - gettextize: git-bisect bisect_replay + $1 messages
 - gettextize: git-bisect bisect_reset + $1 messages
 - gettextize: git-bisect bisect_run + $@ messages
 - gettextize: git-bisect die + eval_gettext messages
 - gettextize: git-bisect die + gettext messages
 - gettextize: git-bisect echo + eval_gettext message
 - gettextize: git-bisect echo + gettext messages
 - gettextize: git-bisect gettext + echo message
 - gettextize: git-bisect add git-sh-i18n
 - gettextize: git-stash drop_stash say/die messages
 - gettextize: git-stash "unknown option" message
 - gettextize: git-stash die + eval_gettext $1 messages
 - gettextize: git-stash die + eval_gettext $* messages
 - gettextize: git-stash die + eval_gettext messages
 - gettextize: git-stash die + gettext messages
 - gettextize: git-stash say + gettext messages
 - gettextize: git-stash echo + gettext message
 - gettextize: git-stash add git-sh-i18n
 - gettextize: git-submodule "blob" and "submodule" messages
 - gettextize: git-submodule "path not initialized" message
 - gettextize: git-submodule "[...] path is ignored" message
 - gettextize: git-submodule "Entering [...]" message
 - gettextize: git-submodule $errmsg messages
 - gettextize: git-submodule "Submodule change[...]" messages
 - gettextize: git-submodule "cached cannot be used" message
 - gettextize: git-submodule $update_module say + die messages
 - gettextize: git-submodule die + eval_gettext messages
 - gettextize: git-submodule say + eval_gettext messages
 - gettextize: git-submodule echo + eval_gettext messages
 - gettextize: git-submodule add git-sh-i18n
 - gettextize: git-pull "rebase against" / "merge with" messages
 - gettextize: git-pull "[...] not currently on a branch" message
 - gettextize: git-pull "You asked to pull" message
 - gettextize: git-pull split up "no candidate" message
 - gettextize: git-pull eval_gettext + warning message
 - gettextize: git-pull eval_gettext + die message
 - gettextize: git-pull die messages
 - gettextize: git-pull add git-sh-i18n
 - gettext docs: add "Testing marked strings" section to po/README
 - gettext docs: the Git::I18N Perl interface
 - gettext docs: the git-sh-i18n.sh Shell interface
 - gettext docs: the gettext.h C interface
 - gettext docs: add "Marking strings for translation" section in po/README
 - gettext docs: add a "Testing your changes" section to po/README
 - po/pl.po: add Polish translation
 - po/hi.po: add Hindi Translation
 - po/en_GB.po: add British English translation
 - po/de.po: add German translation
 - Makefile: only add gettext tests on XGETTEXT_INCLUDE_TESTS=YesPlease
 - gettext docs: add po/README file documenting Git's gettext
 - gettextize: git-am printf(1) message to eval_gettext
 - gettextize: git-am core say messages
 - gettextize: git-am "Apply?" message
 - gettextize: git-am clean_abort messages
 - gettextize: git-am cannot_fallback messages
 - gettextize: git-am die messages
 - gettextize: git-am eval_gettext messages
 - gettextize: git-am multi-line getttext $msg; echo
 - gettextize: git-am one-line gettext $msg; echo
 - gettextize: git-am add git-sh-i18n
 - gettext tests: add GETTEXT_POISON tests for shell scripts
 - gettext tests: add GETTEXT_POISON support for shell scripts
 - Makefile: MSGFMT="msgfmt --check" under GNU_GETTEXT
 - Makefile: add GNU_GETTEXT, set when we expect GNU gettext
 - gettextize: git-shortlog basic messages
 - gettextize: git-revert split up "could not revert/apply" message
 - gettextize: git-revert literal "me" messages
 - gettextize: git-revert "Your local changes" message
 - gettextize: git-revert basic messages
 - gettextize: git-notes "Refusing to %s notes in %s" message
 - gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
 - gettextize: git-notes basic commands
 - gettextize: git-gc "Auto packing the repository" message
 - gettextize: git-gc basic messages
 - gettextize: git-describe basic messages
 - gettextize: git-clean clean.requireForce messages
 - gettextize: git-clean basic messages
 - gettextize: git-bundle basic messages
 - gettextize: git-archive basic messages
 - gettextize: git-status "renamed: " message
 - gettextize: git-status "Initial commit" message
 - gettextize: git-status "Changes to be committed" message
 - gettextize: git-status shortstatus messages
 - gettextize: git-status "nothing to commit" messages
 - gettextize: git-status basic messages
 - gettextize: git-push "prevent you from losing" message
 - gettextize: git-push basic messages
 - gettextize: git-tag tag_template message
 - gettextize: git-tag basic messages
 - gettextize: git-reset "Unstaged changes after reset" message
 - gettextize: git-reset reset_type_names messages
 - gettextize: git-reset basic messages
 - gettextize: git-rm basic messages
 - gettextize: git-mv "bad" messages
 - gettextize: git-mv basic messages
 - gettextize: git-merge "Wonderful" message
 - gettextize: git-merge "You have not concluded your merge" messages
 - gettextize: git-merge "Updating %s..%s" message
 - gettextize: git-merge basic messages
 - gettextize: git-log "--OPT does not make sense" messages
 - gettextize: git-log basic messages
 - gettextize: git-grep "--open-files-in-pager" message
 - gettextize: git-grep basic messages
 - gettextize: git-fetch split up "(non-fast-forward)" message
 - gettextize: git-fetch update_local_ref messages
 - gettextize: git-fetch formatting messages
 - gettextize: git-fetch basic messages
 - gettextize: git-diff basic messages
 - gettextize: git-commit advice messages
 - gettextize: git-commit "enter the commit message" message
 - gettextize: git-commit print_summary messages
 - gettextize: git-commit formatting messages
 - gettextize: git-commit "middle of a merge" message
 - gettextize: git-commit basic messages
 - gettextize: git-checkout "Switched to a .. branch" message
 - gettextize: git-checkout "HEAD is now at" message
 - gettextize: git-checkout describe_detached_head messages
 - gettextize: git-checkout: our/their version message
 - gettextize: git-checkout basic messages
 - gettextize: git-branch "(no branch)" message
 - gettextize: git-branch "git branch -v" messages
 - gettextize: git-branch "Deleted branch [...]" message
 - gettextize: git-branch "remote branch '%s' not found" message
 - gettextize: git-branch basic messages
 - gettextize: git-add refresh_index message
 - gettextize: git-add "remove '%s'" message
 - gettextize: git-add "pathspec [...] did not match" message
 - gettextize: git-add "Use -f if you really want" message
 - gettextize: git-add "no files added" message
 - gettextize: git-add basic messages
 - gettextize: git-clone "Cloning into" message
 - gettextize: git-clone basic messages
 - gettext tests: test message re-encoding under C
 - po/is.po: add Icelandic translation
 - gettext tests: mark a test message as not needing translation
 - gettext tests: test re-encoding with a UTF-8 msgid under Shell
 - gettext tests: test message re-encoding under Shell
 - gettext tests: add detection for is_IS.ISO-8859-1 locale
 - gettext tests: test if $VERSION exists before using it
 - gettextize: git-init "Initialized [...] repository" message
 - gettextize: git-init basic messages
 - gettext tests: skip lib-gettext.sh tests under GETTEXT_POISON
 - gettext tests: add GETTEXT_POISON=YesPlease Makefile parameter
 - gettext.c: use libcharset.h instead of langinfo.h when available
 - gettext.c: work around us not using setlocale(LC_CTYPE, "")
 - builtin.h: Include gettext.h
 - Makefile: use variables and shorter lines for xgettext
 - Makefile: tell xgettext(1) that our source is in UTF-8
 - Makefile: provide a --msgid-bugs-address to xgettext(1)
 - Makefile: A variable for options used by xgettext(1) calls
 - gettext tests: locate i18n lib&data correctly under --valgrind
 - gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
 - gettext tests: rename test to work around GNU gettext bug
 - gettext: add infrastructure for translating Git with gettext
 - builtin: use builtin.h for all builtin commands
 - tests: use test_cmp instead of piping to diff(1)
 - t7004-tag.sh: re-arrange git tag comment for clarity

It is getting ridiculously painful to keep re-resolving the conflicts with
other topics in flight, even with the help with rerere.

Needs a bit more minor work to get the basic code structure right.
