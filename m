From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2010, #06 draft)
Date: Wed, 20 Jan 2010 02:24:51 -0800
Message-ID: <7veill3wgc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:25:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXXkJ-0005DC-1i
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 11:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab0ATKZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 05:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799Ab0ATKY7
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 05:24:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab0ATKY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 05:24:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1E479249B;
	Wed, 20 Jan 2010 05:24:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=RDRB
	bHs5HR87l+KDDz5s+zY3SsQ=; b=CvHPHiYKBpM8gr8y6SHXyjGCy+FTVJa+UwtU
	vcL4nEuDcxvLDajkvMit2vRBFjC0cX84G5qxSQFx0Q/CemzM9bIXl1NX0pSFAPV3
	kQ9sQWhe2zy6w84lYN3X4HrDgnTPOaTvEbIIMrLUnyIp/3y/XFjcP9rRcDQDSYkT
	E+MyMZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=q2e
	60YabMQi3O2mteN0gKK7JuC1DzOd89Hwt+uBimJrfcNycuxjJVNRKJLhYxJF3HWu
	EWuz5C+3nFBfZppNPwPnl9Z5Yr9DPJEEA0B5DZB4SdyNO83j2SmapI4OvL2C59Eg
	Rc89C36DKlwwqt/rHF8ACVY8fuKMx+iuknwDUmFU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD9F892499;
	Wed, 20 Jan 2010 05:24:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A456892495; Wed, 20 Jan
 2010 05:24:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D26557E-05AE-11DF-AEAC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137538>

This is a draft copy of the real one I would send out after my git
Wednesday is over.

But before that day begins, I need to go to sleep ;-)

---

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* sr/gfi-options (2009-12-04) 7 commits
  (merged to 'next' on 2010-01-10 at 8b305fb)
 + fast-import: add (non-)relative-marks feature
 + fast-import: allow for multiple --import-marks= arguments
 + fast-import: test the new option command
 + fast-import: add option command
 + fast-import: add feature command
 + fast-import: put marks reading in its own function
 + fast-import: put option parsing code in separate functions

* tc/smart-http-restrict (2010-01-14) 5 commits
  (merged to 'next' on 2010-01-16 at 71fc84c)
 + Test t5560: Fix test when run with dash
  (merged to 'next' on 2010-01-06 at 82736cb)
 + Smart-http tests: Test http-backend without curl or a webserver
 + Smart-http tests: Break test t5560-http-backend into pieces
 + Smart-http tests: Improve coverage in test t5560
 + Smart-http: check if repository is OK to export before serving it

* tc/clone-v-progress (2009-12-26) 4 commits
  (merged to 'next' on 2010-01-10 at ec2bfd7)
 + clone: use --progress to force progress reporting
 + clone: set transport->verbose when -v/--verbose is used
 + git-clone.txt: reword description of progress behaviour
 + check stderr with isatty() instead of stdout when deciding to show progress

Perhaps needs an entry in the Release Notes, but otherwise looked Ok.

* jk/run-command-use-shell (2010-01-01) 8 commits
  (merged to 'next' on 2010-01-10 at 7479e2a)
 + t4030, t4031: work around bogus MSYS bash path conversion
 + diff: run external diff helper with shell
 + textconv: use shell to run helper
 + editor: use run_command's shell feature
 + run-command: optimize out useless shell calls
 + run-command: convert simple callsites to use_shell
 + t0021: use $SHELL_PATH for the filter script
 + run-command: add "use shell" option

Shuffled the commits in the topic, following J6t's suggestion in
http://thread.gmane.org/gmane.comp.version-control.git/136128

* jn/makefile (2010-01-06) 4 commits
  (merged to 'next' on 2010-01-10 at f5a5d42)
 + Makefile: consolidate .FORCE-* targets
 + Makefile: learn to generate listings for targets requiring special flags
 + Makefile: use target-specific variable to pass flags to cc
 + Makefile: regenerate assembler listings when asked

* jc/maint-1.6.1-checkout-m-custom-merge (2010-01-06) 1 commit
  (merged to 'next' on 2010-01-10 at df14116)
 + checkout -m path: fix recreating conflicts

* jh/commit-status (2010-01-13) 2 commits
  (merged to 'next' on 2010-01-13 at 0905d59)
 + t7502: test commit.status, --status and --no-status
 + commit: support commit.status, --status, and --no-status

I have already given ample time for people to react, but ended up getting
tired of waiting for tests to materialize and doing it myself, as I want
to close merge window for 1.7.0-rc0 by the end of next week to have the
final release early next month.

* tc/test-locate-httpd (2010-01-02) 1 commit
  (merged to 'next' on 2010-01-06 at 9d913e5)
 + t/lib-http.sh: Restructure finding of default httpd location

* js/windows (2010-01-15) 7 commits
 - Do not use date.c:tm_to_time_t() from compat/mingw.c
 - MSVC: Windows-native implementation for subset of Pthreads API
 - MSVC: Fix an "incompatible pointer types" compiler warning
 - Windows: avoid the "dup dance" when spawning a child process
 - Windows: simplify the pipe(2) implementation
 - Windows: boost startup by avoiding a static dependency on shell32.dll
 - Windows: disable Python

* dp/maint-1.6.5-fast-import-non-commit-tag (2010-01-14) 1 commit
  (merged to 'next' on 2010-01-16 at f95ea8e)
 + fast-import: tag may point to any object type

* nd/include-termios-for-osol (2010-01-11) 1 commit
  (merged to 'next' on 2010-01-16 at 3160c76)
 + Add missing #include to support TIOCGWINSZ on Solaris

* pc/uninteresting-submodule-disappear-upon-switch-branches (2010-01-11) 1 commit
  (merged to 'next' on 2010-01-16 at b06ca1a)
 + Remove empty directories when checking out a commit with fewer submodules

Instead of using unlink(2) that will never succeed, use rmdir(2) to remove
an empty directory, knowing that this won't harm a populated directory.

* jc/rerere (2009-12-04) 1 commit
  (merged to 'next' on 2010-01-10 at e295b7f)
 + Teach --[no-]rerere-autoupdate option to merge, revert and friends

--------------------------------------------------
[New Topics]

* jc/conflict-marker-size (2010-01-16) 8 commits
  (merged to 'next' on 2010-01-18 at f1f6023)
 + rerere: honor conflict-marker-size attribute
 + rerere: prepare for customizable conflict marker length
 + conflict-marker-size: new attribute
 + rerere: use ll_merge() instead of using xdl_merge()
 + merge-tree: use ll_merge() not xdl_merge()
 + xdl_merge(): allow passing down marker_size in xmparam_t
 + xdl_merge(): introduce xmparam_t for merge specific parameters
 + git_attr(): fix function signature
 (this branch uses jc/cache-unmerge.)

* ag/maint-apply-too-large-p (2010-01-17) 1 commit
  (merged to 'next' on 2010-01-18 at 8bd106a)
 + builtin-apply.c: Skip filenames without enough components

* il/rev-namespace (2010-01-19) 2 commits
  (merged to 'next' on 2010-01-19 at 2dbc665)
 + Fix errors in t6018
  (merged to 'next' on 2010-01-18 at 3e68978)
 + rev-parse --namespace

This probably will be dropped and replaced with the --glob one, perhaps
with minor tweaks.

* jc/grep-author-all-match-implicit (2010-01-17) 1 commit
 - "log --author=me --grep=it" should find intersection, not union

* ag/patch-header-verify (2010-01-18) 1 commit
  (merged to 'next' on 2010-01-18 at 2cd0ddc)
 + builtin-apply.c: fix the --- and +++ header filename consistency check

* il/branch-set-upstream (2010-01-18) 2 commits
  (merged to 'next' on 2010-01-18 at b9b0993)
 + branch: warn and refuse to set a branch as a tracking branch of itself.
 + Add branch --set-upstream

* il/remote-updates (2010-01-18) 1 commit
  (merged to 'next' on 2010-01-18 at 5c3e805)
 + Add git remote set-url

* bw/cvsimport (2010-01-19) 3 commits
  (merged to 'next' on 2010-01-19 at 63f4c8d)
 + cvsimport: standarize system() calls to external git tools
 + cvsimport: standarize open() calls to external git tools
 + cvsimport: modernize callouts to git subcommands

* jc/checkout-merge-base (2010-01-19) 1 commit
  (merged to 'next' on 2010-01-19 at 3665110)
 + Fix "checkout A..." synonym for "checkout A...HEAD" on Windows

* jc/maint-refresh-index-is-optional-for-status (2010-01-19) 1 commit
 - status: don't require the repository to be writable

--------------------------------------------------
[Will merge to 'master' soon unless somebody complains]

* rr/core-tutorial (2010-01-16) 1 commit
  (merged to 'next' on 2010-01-16 at d9dd8bd)
 + Documentation: Update git core tutorial clarifying reference to scripts

* il/push-set-upstream (2010-01-16) 1 commit
  (merged to 'next' on 2010-01-16 at e3a7a60)
 + Add push --set-upstream

* jk/warn-author-committer-after-commit (2010-01-17) 6 commits
  (merged to 'next' on 2010-01-17 at c2bb7fd)
 + user_ident_sufficiently_given(): refactor the logic to be usable from elsewhere
 + commit.c::print_summary: do not release the format string too early
  (merged to 'next' on 2010-01-16 at f22c077)
 + commit: allow suppression of implicit identity advice
 + commit: show interesting ident information in summary
 + strbuf: add strbuf_addbuf_percentquote
 + strbuf_expand: convert "%%" to "%"

* jc/ident (2010-01-17) 5 commits
  (merged to 'next' on 2010-01-19 at 9fba1c0)
 + ident.c: replace fprintf with fputs to suppress compiler warning
  (merged to 'next' on 2010-01-17 at 625670d)
 + user_ident_sufficiently_given(): refactor the logic to be usable from elsewhere
 + ident.c: treat $EMAIL as giving user.email identity explicitly
  (merged to 'next' on 2010-01-10 at f1f9ded)
 + ident.c: check explicit identity for name and email separately
 + ident.c: remove unused variables

* tr/http-push-ref-status (2010-01-08) 6 commits
  (merged to 'next' on 2010-01-16 at 7e872ac)
 + transport-helper.c::push_refs(): emit "no refs" error message
 + transport-helper.c::push_refs(): ignore helper-reported status if ref is not to be pushed
 + transport.c::transport_push(): make ref status affect return value
 + refactor ref status logic for pushing
 + t5541-http-push.sh: add test for unmatched, non-fast-forwarded refs
 + t5541-http-push.sh: add tests for non-fast-forward pushes

* bk/fix-relative-gitdir-file (2010-01-08) 2 commits
  (merged to 'next' on 2010-01-16 at cc4ae57)
 + Handle relative paths in submodule .git files
 + Test update-index for a gitlink to a .git file

* sd/cd-p-show-toplevel (2010-01-12) 2 commits
  (merged to 'next' on 2010-01-16 at 57d6d31)
 + Use $(git rev-parse --show-toplevel) in cd_to_toplevel().
 + Add 'git rev-parse --show-toplevel' option.

Avoid having to use "cd -P" that may not be available on some platforms'
shells.

* jc/symbol-static (2010-01-18) 17 commits
  (merged to 'next' on 2010-01-18 at d063267)
 + Replace parse_blob() with an explanatory comment
 + symlinks.c: remove unused functions
 + object.c: remove unused functions
 + strbuf.c: remove unused function
 + sha1_file.c: remove unused function
 + mailmap.c: remove unused function
  (merged to 'next' on 2010-01-17 at d7346b1)
 + utf8.c: mark file-local function static
 + submodule.c: mark file-local function static
 + quote.c: mark file-local function static
 + remote-curl.c: mark file-local function static
 + read-cache.c: mark file-local functions static
 + parse-options.c: mark file-local function static
 + entry.c: mark file-local function static
 + http.c: mark file-local functions static
 + pretty.c: mark file-local function static
 + builtin-rev-list.c: mark file-local function static
 + bisect.c: mark file-local function static

Mark file-local symbols "static", and remove unused functions.

--------------------------------------------------
[Will merge to 'master' after a bit more cooking in 'next']

* nd/status-partial-refresh (2010-01-17) 2 commits
  (merged to 'next' on 2010-01-19 at 64f0c0b)
 + rm: only refresh entries that we may touch
  (merged to 'next' on 2010-01-16 at f77bc8f)
 + status: only touch path we may need to check

* mh/rebase-fixup (2010-01-14) 23 commits
  (merged to 'next' on 2010-01-16 at 7ccb228)
 + rebase -i: Retain user-edited commit messages after squash/fixup conflicts
 + t3404: Set up more of the test repo in the "setup" step
 + rebase -i: For fixup commands without squashes, do not start editor
 + rebase -i: Change function make_squash_message into update_squash_message
 + rebase -i: Extract function do_with_author
 + rebase -i: Handle the author script all in one place in do_next
 + rebase -i: Extract a function "commit_message"
 + rebase -i: Simplify commit counting for generated commit messages
 + rebase -i: Improve consistency of commit count in generated commit messages
 + t3404: Test the commit count in commit messages generated by "rebase -i"
 + rebase -i: Introduce a constant AMEND
 + rebase -i: Introduce a constant AUTHOR_SCRIPT
 + rebase -i: Document how temporary files are used
 + rebase -i: Use symbolic constant $MSG consistently
 + rebase -i: Use "test -n" instead of "test ! -z"
 + rebase -i: Inline expression
 + rebase -i: Remove dead code
 + rebase -i: Make the condition for an "if" more transparent
  (merged to 'next' on 2010-01-12 at e84eab0)
 + rebase-i: Ignore comments and blank lines in peek_next_command
 + lib-rebase: Allow comments and blank lines to be added to the rebase script
 + lib-rebase: Provide clearer debugging info about what the editor did
 + Add a command "fixup" to rebase --interactive
 + t3404: Use test_commit to set up test repository
 (this branch is used by ns/rebase-auto-squash.)

* ns/rebase-auto-squash (2009-12-08) 1 commit
  (merged to 'next' on 2010-01-06 at da4e2f5)
 + rebase -i --autosquash: auto-squash commits
 (this branch uses mh/rebase-fixup.)

* da/difftool (2010-01-15) 10 commits
  (merged to 'next' on 2010-01-16 at 609f0da)
 + difftool: Update copyright notices to list each year separately
 + difftool: Use eval to expand '--extcmd' expressions
 + difftool: Add '-x' and as an alias for '--extcmd'
 + t7800-difftool.sh: Simplify the --extcmd test
  (merged to 'next' on 2010-01-10 at 749c870)
 + git-diff.txt: Link to git-difftool
 + difftool: Allow specifying unconfigured commands with --extcmd
 + difftool--helper: Remove use of the GIT_MERGE_TOOL variable
 + difftool--helper: Update copyright and remove distracting comments
  (merged to 'next' on 2010-01-06 at e957395)
 + git-difftool: Add '--gui' for selecting a GUI tool
 + t7800-difftool: Set a bogus tool for use by tests

* mm/conflict-advice (2010-01-12) 1 commit
  (merged to 'next' on 2010-01-16 at b83be11)
 + Be more user-friendly when refusing to do something because of conflict.

* jc/maint-strbuf-add-fix-doubling (2010-01-12) 1 commit
  (merged to 'next' on 2010-01-16 at 5959eee)
 + strbuf_addbuf(): allow passing the same buf to dst and src

* jc/maint-1.6.4-grep-lookahead (2010-01-10) 1 commit
  (merged to 'next' on 2010-01-13 at 20f8f4b)
 + grep: optimize built-in grep by skipping lines that do not hit
 (this branch is used by jc/grep-lookahead and jc/maint-grep-lookahead.)

Optimize the "line-by-line" internal grep by skiping en masse over lines
that cannot possibly match.

* jc/maint-grep-lookahead (2010-01-12) 0 commits
 (this branch uses jc/maint-1.6.4-grep-lookahead; is used by jc/grep-lookahead.)

Early conflict resolution for the above for recent git.

* jc/grep-lookahead (2010-01-15) 4 commits
  (merged to 'next' on 2010-01-17 at 4a5be2d)
 + grep --no-index: allow use of "git grep" outside a git repository
 + grep: prepare to run outside of a work tree
  (merged to 'next' on 2010-01-13 at 20f8f4b)
 + grep: rip out pessimization to use fixmatch()
 + grep: rip out support for external grep
 (this branch uses jc/maint-1.6.4-grep-lookahead and jc/maint-grep-lookahead.)

* jl/submodule-diff (2010-01-18) 4 commits
 - Performance optimization for detection of modified submodules
  (merged to 'next' on 2010-01-17 at 525075b)
 + git status: Show uncommitted submodule changes too when enabled
  (merged to 'next' on 2010-01-16 at 0a99e3c)
 + Teach diff that modified submodule directory is dirty
 + Show submodules as modified when they contain a dirty work tree

* jc/ls-files-ignored-pathspec (2010-01-08) 4 commits
  (merged to 'next' on 2010-01-16 at d36016a)
 + ls-files: fix overeager pathspec optimization
 + read_directory(): further split treat_path()
 + read_directory_recursive(): refactor handling of a single path into a separate function
 + t3001: test ls-files -o ignored/dir

* js/exec-error-report (2010-01-12) 4 commits
  (merged to 'next' on 2010-01-16 at 0e28d02)
 + Improve error message when a transport helper was not found
 + start_command: detect execvp failures early
 + run-command: move wait_or_whine earlier
 + start_command: report child process setup errors to the parent's stderr

* jc/fix-tree-walk (2009-09-14) 7 commits
  (merged to 'next' on 2010-01-13 at 1c01b87)
 + read-tree --debug-unpack
 + unpack-trees.c: look ahead in the index
 + unpack-trees.c: prepare for looking ahead in the index
 + Aggressive three-way merge: fix D/F case
 + traverse_trees(): handle D/F conflict case sanely
 + more D/F conflict tests
 + tests: move convenience regexp to match object names to test-lib.sh

Resurrected from "Ejected" category.  This is fix for a tricky codepath
and testing and improving before it hits 'master' is greatly appreciated.
(I have been using this in my private build for some time).

* jc/cache-unmerge (2009-12-25) 9 commits
  (merged to 'next' on 2010-01-13 at 2290c44)
 + rerere forget path: forget recorded resolution
 + rerere: refactor rerere logic to make it independent from I/O
 + rerere: remove silly 1024-byte line limit
 + resolve-undo: teach "update-index --unresolve" to use resolve-undo info
 + resolve-undo: "checkout -m path" uses resolve-undo information
 + resolve-undo: allow plumbing to clear the information
 + resolve-undo: basic tests
 + resolve-undo: record resolved conflicts in a new index extension section
 + builtin-merge.c: use standard active_cache macros
 (this branch is used by jc/conflict-marker-size.)

* ap/merge-backend-opts (2008-07-18) 7 commits
  (merged to 'next' on 2010-01-18 at cb1f6b7)
 + Document that merge strategies can now take their own options
 + Extend merge-subtree tests to test -Xsubtree=dir.
 + Make "subtree" part more orthogonal to the rest of merge-recursive.
 + pull: Fix parsing of -X<option>
 + Teach git-pull to pass -X<option> to git-merge
 + git merge -X<option>
 + git-merge-file --ours, --theirs

--------------------------------------------------
[Cooking]

* js/refer-upstream (2010-01-19) 3 commits
 - Teach @{upstream} syntax to strbuf_branchanme()
 - t1506: more test for @{upstream} syntax
 - Introduce <branch>@{upstream} notation

Updated to teach the new syntax to commands like "checkout" and "merge"
that want to behave better when they know what were given was a branch
name, not a random SHA-1 or a full refname.

* jh/notes (2010-01-17) 23 commits
 - builtin-gc: Teach the new --notes option to garbage-collect notes
 - Notes API: gc_notes(): Prune notes that belong to non-existing objects
 - t3305: Verify that removing notes triggers automatic fanout consolidation
 - builtin-notes: Teach -d option for deleting existing notes
 - Teach builtin-notes to remove empty notes
 - Teach notes code to properly preserve non-notes in the notes tree
 - t3305: Verify that adding many notes with git-notes triggers increased fanout
 - t3301: Verify successful annotation of non-commits
 - Builtin-ify git-notes
 - Refactor notes concatenation into a flexible interface for combining notes
 - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 - Notes API: write_notes_tree(): Store the notes tree in the database
 - Notes API: for_each_note(): Traverse the entire notes tree with a callback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: remove_note(): Remove note objects from the notes tree structure
 - Notes API: add_note(): Add note objects to the internal notes tree structure
 - Notes API: init_notes(): Initialize the notes tree from the given notes ref
 - Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
 - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 - Minor non-functional fixes to notes.c
  (merged to 'next' on 2010-01-02 at ae42130)
 + Add more testcases to test fast-import of notes
 + Rename t9301 to t9350, to make room for more fast-import tests
 + fast-import: Proper notes tree manipulation

Updated with a re-roll.

* jh/gitweb-cached (2010-01-13) 9 commits
 - gitweb: File based caching layer (from git.kernel.org)
 - gitweb: Convert output to using indirect file handle
 - gitweb: cleanup error message produced by undefined $site_header
 - gitweb: add a get function to compliment print_sort_th
 - gitweb: add a get function to compliment print_local_time
 - gitweb: Makefile improvements
 - gitweb: Add option to force version match
 - gitweb: change die_error to take "extra" argument for extended die information
 - gitweb: Load checking

Replaced with a re-roll.  Update to t9500 is probably needed.

* jc/branch-d (2009-12-29) 1 commit
  (merged to 'next' on 2010-01-10 at 61a14b7)
 + branch -d: base the "already-merged" safety on the branch it merges with
