From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2010, #02; Tue, 26)
Date: Tue, 26 Oct 2010 23:13:18 -0700
Message-ID: <7v62woduyp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 08:13:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAzGQ-0007eF-5W
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 08:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab0J0GN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 02:13:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab0J0GN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 02:13:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70841290F;
	Wed, 27 Oct 2010 02:13:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=aOWJ
	xHSqrbV9yBzTgCUAJRbftvI=; b=oeAAktByL4sQMtPxx+6ZqRuCYVQNSej42bOE
	37xx0Z5CtgDCoTjZF107nO8f5sWbU1rC9X7h/kld2Iwezh/zxZRkqkli9ezVYT9H
	b4b4Hkz7taQCoobYaCr1U09nNWfu7Tj0eE2bFp8pGs9Cyv4X8eaU1P7tckWoYJTR
	ryAtvcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Era
	INI1diij6oLdZn9dvntUGrKyhTWU+WuEyWW0D2eIBGuQWSa45dpNrJ7GUDQ7Jge3
	2qQZ+8ZyJ608j8fkiT0XhJJXhLoLhNWaC/ovzhJTOxYbRhf1vHqkriajbBglZwOD
	vaX8UABiDikFhiWivVfM9HakxPvxO+ZZ7jyGsos4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9575A290E;
	Wed, 27 Oct 2010 02:13:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DDBF290D; Wed, 27 Oct
 2010 02:13:20 -0400 (EDT)
X-master-at: 7ebee44167fc25b975f5543472c851ab1840af1b
X-next-at: 2d0e57103f0af55abbbd7c61b29650463c3887cc
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DC69516-E191-11DF-851F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160021>

What's cooking in git.git (Oct 2010, #02; Tue, 26)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

Many topics have been cooking for a while in 'next', some of them for too
long.  Tonight's pushout is fairly large, and the result makes the set of
remaining topics on 'next' very thin.  A few people sent series based on
'next'; that was not a pleasant experience for me to try separating them
out, but I am in no position to complain---all of the topics that have
been cooking for a very long time are long overdue.

--------------------------------------------------
[New Topics]

* ao/send-email-irt (2010-10-19) 7 commits
 - t9001: send-email interation with --in-reply-to and --chain-reply-to
 - t/t9001-send-email.sh: fix stderr redirection in 'Invalid In-Reply-To'
 - Clarify and extend the "git diff" format documentation
 - git-show-ref.txt: clarify the pattern matching
 - documentation: git-config minor cleanups
 - Update test script annotate-tests.sh to handle missing/extra authors
 - {cvs,svn}import: use the new 'git read-tree --empty'

* aw/git-p4-deletion (2010-10-22) 1 commit
  (merged to 'next' on 2010-10-26 at 5847c40)
 + Fix handling of git-p4 on deleted files

* bg/maint-gitweb-test-lib (2010-10-20) 1 commit
 - t/gitweb-lib: Don't pass constant to decode_utf8

* cm/diff-check-at-eol (2010-10-10) 1 commit
 - diff --check: correct line numbers of new blank lines at EOF

* fc/apply-p2-get-header-name (2010-10-21) 3 commits
 - test: git-apply -p2 rename/chmod only
 - fixup! Fix git-apply with
 - Fix git-apply with -p greater than 1

* jk/add-e-doc (2010-10-21) 1 commit
 - docs: give more hints about how "add -e" works

* jk/diff-CBM (2010-10-21) 1 commit
 - diff: report bogus input to -C/-M/-B

* jk/missing-config (2010-10-21) 1 commit
 - config: treat non-existent config files as empty

* jn/fast-import-fix (2010-10-20) 4 commits
 - fast-import: do not clear notes in do_change_note_fanout()
 - t9300 (fast-import): another test for the "replace root" feature
 - fast-import: tighten M 040000 syntax
 - fast-import: filemodify after M 040000 <tree> "" crashes

* jn/git-cmd-h-bypass-setup (2010-10-22) 7 commits
 - update-index -h: show usage even with corrupt index
 - merge -h: show usage even with corrupt index
 - ls-files -h: show usage even with corrupt index
 - gc -h: show usage even with broken configuration
 - commit/status -h: show usage even with broken configuration
 - checkout-index -h: show usage even in an invalid repository
 - branch -h: show usage even in an invalid repository
 (this branch uses en/and-cascade-tests.)

* kb/blame-author-email (2010-10-15) 1 commit
 - blame: Add option to show author email instead of name

* kb/maint-diff-ws-check (2010-10-20) 2 commits
 - diff: handle lines containing only whitespace and tabs better
 - test-lib: extend test_decode_color to handle more color codes

* mg/make-prove (2010-10-14) 1 commit
 - test: allow running the tests under "prove"

* np/diff-in-corrupt-repository (2010-10-22) 1 commit
 - diff: don't presume empty file when corresponding object is missing

* np/pack-broken-boundary (2010-10-22) 1 commit
 - make pack-objects a bit more resilient to repo corruption

* tr/maint-git-repack-tmpfile (2010-10-19) 1 commit
 - repack: place temporary packs under .git/objects/pack/

* tr/maint-merge-file-subdir (2010-10-17) 2 commits
 - merge-file: correctly find files when called in subdir
 - prefix_filename(): safely handle the case where pfx_len=0

--------------------------------------------------
[Graduated to "master"]

* ab/require-perl-5.8 (2010-09-24) 2 commits
  (merged to 'next' on 2010-09-27 at 1fcdd3c)
 + perl: use "use warnings" instead of -w
 + perl: bump the required Perl version to 5.8 from 5.6.[21]

* ab/send-email-perl (2010-09-30) 16 commits
  (merged to 'next' on 2010-09-30 at cf8e58e)
 + send-email: extract_valid_address use qr// regexes
 + send-email: is_rfc2047_quoted use qr// regexes
 + send-email: use Perl idioms in while loop
 + send-email: make_message_id use "require" instead of "use"
 + send-email: send_message die on $!, not $?
 + send-email: use (?:) instead of () if no match variables are needed
 + send-email: sanitize_address use qq["foo"], not "\"foo\""
 + send-email: sanitize_address use $foo, not "$foo"
 + send-email: use \E***\Q instead of \*\*\*
 + send-email: cleanup_compose_files doesn't need a prototype
 + send-email: unique_email_list doesn't need a prototype
 + send-email: file_declares_8bit_cte doesn't need a prototype
 + send-email: get_patch_subject doesn't need a prototype
 + send-email: use lexical filehandles during sending
 + send-email: use lexical filehandles for $compose
 + send-email: use lexical filehandle for opendir

* as/daemon-multi-listen (2010-08-30) 2 commits
  (merged to 'next' on 2010-09-30 at 8083bf4)
 + daemon: allow more than one host address given via --listen
 + daemon: add helper function named_sock_setup

* dm/mergetool-vimdiff (2010-09-27) 3 commits
  (merged to 'next' on 2010-09-29 at c8e22ea)
 + mergetool-lib: make the three-way diff the default for vim/gvim
  (merged to 'next' on 2010-09-22 at 12f7559)
 + mergetool-lib: add a three-way diff view for vim/gvim
 + mergetool-lib: combine vimdiff and gvimdiff run blocks

* en/tree-walk-optim (2010-08-26) 4 commits
  (merged to 'next' on 2010-09-22 at 0601f1b)
 + diff_tree(): Skip skip_uninteresting() when all remaining paths interesting
 + tree_entry_interesting(): Make return value more specific
 + tree-walk: Correct bitrotted comment about tree_entry()
 + Document pre-condition for tree_entry_interesting

* jf/merge-ignore-ws (2010-08-26) 4 commits
  (merged to 'next' on 2010-09-22 at 5161fb8)
 + merge-recursive: options to ignore whitespace changes
 + merge-recursive --patience
 + ll-merge: replace flag argument with options struct
 + merge-recursive: expose merge options for builtin merge
 (this branch is used by kb/merge-recursive-rename-threshold.)

Possibly one of the star features of the coming release.

* jp/send-email-to-cmd (2010-09-24) 1 commit
  (merged to 'next' on 2010-09-30 at 4284ddb)
 + git-send-email.perl: Add --to-cmd

* kb/merge-recursive-rename-threshold (2010-09-27) 2 commits
  (merged to 'next' on 2010-09-30 at 4f33817)
 + diff: add synonyms for -M, -C, -B
 + merge-recursive: option to specify rename threshold
 (this branch uses jf/merge-ignore-ws.)

* kf/post-receive-sample-hook (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-22 at db674a3)
 + post-receive-email: ensure sent messages are not empty

I notice that it uses "PAGER= generate_email" where generate_email is a
shell function, which may break in some implementations of POSIX /bin/sh.
This is not a regression (the original also had the same issue), but
somebody who cares enough might want to look into it.

* mg/fix-build-remote-helpers (2010-09-17) 1 commit
  (merged to 'next' on 2010-09-30 at 0583d5f)
 + remote-helpers: build in platform independent directory

* ml/completion-zsh (2010-09-06) 1 commit
  (merged to 'next' on 2010-09-22 at d62d10e)
 + completion: make compatible with zsh

Reported as breaking people with "set -u".

* po/sendemail (2010-09-06) 3 commits
  (merged to 'next' on 2010-09-22 at 1105f62)
 + New send-email option smtpserveroption.
 + Remove @smtp_host_parts variable as not used.
 + Minor indentation fix.

* sb/send-email-use-to-from-input (2010-10-04) 2 commits
  (merged to 'next' on 2010-10-06 at 5e9cb61)
 + send-email: Don't leak To: headers between patches
  (merged to 'next' on 2010-09-30 at 513b6f1)
 + send-email: Use To: headers in patch files

* sn/doc-opt-notation (2010-10-08) 6 commits
  (merged to 'next' on 2010-10-13 at 53ea256)
 + Fix {update,checkout}-index usage strings
 + Put a space between `<' and argument in pack-objects usage string
 + Remove stray quotes in --pretty and --format documentation
 + Use parentheses and `...' where appropriate
 + Fix odd markup in --diff-filter documentation
 + Use angles for placeholders consistently

--------------------------------------------------
[Stalled]

* yd/dir-rename (2010-10-15) 5 commits
 . Allow hiding renames of individual files involved in a directory rename.
 . Consider all parents of a file as candidates for bulk rename.
 . Handle the simpler case of a subdir invalidating bulk move.
 . Add testcases for the --detect-bulk-moves diffcore flag.
 . Introduce bulk-move detection in diffcore.

Need to replace this with a rerolled one posted recently.

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

--------------------------------------------------
[Cooking]

* cb/diff-fname-optim (2010-09-26) 3 commits
 - diff: avoid repeated scanning while looking for funcname
 - do not search functions for patch ID
 - add rebase patch id tests

* en/merge-recursive (2010-10-21) 39 commits
 - merge-recursive:make_room_for_directories - work around dumb compilers
 - merge-recursive: Remove redundant path clearing for D/F conflicts
 - merge-recursive: Make room for directories in D/F conflicts
 - handle_delete_modify(): Check whether D/F conflicts are still present
 - merge_content(): Check whether D/F conflicts are still present
 - conflict_rename_rename_1to2(): Fix checks for presence of D/F conflicts
 - conflict_rename_delete(): Check whether D/F conflicts are still present
 - merge-recursive: Delay modify/delete conflicts if D/F conflict present
 - merge-recursive: Delay content merging for renames
 - merge-recursive: Delay handling of rename/delete conflicts
 - merge-recursive: Move handling of double rename of one file to other file
 - merge-recursive: Move handling of double rename of one file to two
 - merge-recursive: Avoid doubly merging rename/add conflict contents
 - merge-recursive: Update merge_content() call signature
 - merge-recursive: Update conflict_rename_rename_1to2() call signature
 - merge-recursive: Structure process_df_entry() to handle more cases
 - merge-recursive: Have process_entry() skip D/F or rename entries
 - merge-recursive: New function to assist resolving renames in-core only
 - merge-recursive: New data structures for deferring of D/F conflicts
 - merge-recursive: Move process_entry's content merging into a function
 - merge-recursive: Move delete/modify handling into dedicated function
 - merge-recursive: Move rename/delete handling into dedicated function
 - merge-recursive: Nuke rename/directory conflict detection
 - merge-recursive: Rename conflict_rename_rename*() for clarity
 - merge-recursive: Small code clarification -- variable name and comments
 - t6036: Add testcase for undetected conflict
 - t6036: Add a second testcase similar to the first but with content changes
 - t6036: Test index and worktree state, not just that merge fails
 - t6020: Add a testcase for modify/delete + directory/file conflict
 - t6020: Modernize style a bit
 - t6022: Add tests for rename/rename combined with D/F conflicts
 - t6022: Add paired rename+D/F conflict: (two/file, one/file) -> (one, two)
 - t6022: Add tests with both rename source & dest involved in D/F conflicts
 - t6022: Add tests for reversing order of merges when D/F conflicts present
 - t6022: Add test combinations of {content conflict?, D/F conflict remains?}
 - t6032: Add a test checking for excessive output from merge
 - merge-recursive: Restructure showing how to chain more process_* functions
 - t3030: Add a testcase for resolvable rename/add conflict with symlinks
 - Merge branch 'en/rename-d-f' into en/merge-recursive
 (this branch uses en/rename-d-f.)

* il/remote-fd-ext (2010-10-12) 3 commits
 - git-remote-ext
 - git-remote-fd
 - Add bidirectional_transfer_loop()

* jn/gitweb-test (2010-09-26) 4 commits
 - gitweb/Makefile: Include gitweb/config.mak
 - gitweb/Makefile: Add 'test' and 'test-installed' targets
 - t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
 - gitweb: Move call to evaluate_git_version after evaluate_gitweb_config

* ak/apply-non-git-epoch (2010-09-29) 1 commit
 - apply: Recognize epoch timestamps with : in the timezone

* ak/submodule-sync (2010-10-08) 1 commit
 - submodule sync: Update "submodule.<name>.url" for empty directories

* cb/leading-path-removal (2010-10-09) 5 commits
 - do not overwrite files in leading path
 - lstat_cache: optionally return match_len
 - add function check_ok_to_remove()
 - t7607: add leading-path tests
 - t7607: use test-lib functions and check MERGE_HEAD

* jh/notes-merge (2010-10-21) 21 commits
 - Provide 'git notes get-ref' to easily retrieve current notes ref
 - git notes merge: Add testcases for merging notes trees at different fanouts
 - git notes merge: Add another auto-resolving strategy: "cat_sort_uniq"
 - git notes merge: --commit should fail if underlying notes ref has moved
 - git notes merge: List conflicting notes in notes merge commit message
 - git notes merge: Manual conflict resolution, part 2/2
 - git notes merge: Manual conflict resolution, part 1/2
 - Documentation: Preliminary docs on 'git notes merge'
 - git notes merge: Add automatic conflict resolvers (ours, theirs, union)
 - git notes merge: Handle real, non-conflicting notes merges
 - builtin/notes.c: Refactor creation of notes commits.
 - git notes merge: Initial implementation handling trivial merges only
 - builtin/notes.c: Split notes ref DWIMmery into a separate function
 - notes.c: Use two newlines (instead of one) when concatenating notes
 - (trivial) t3303: Indent with tabs instead of spaces for consistency
 - notes.h/c: Propagate combine_notes_fn return value to add_note() and beyond
 - notes.h/c: Clarify the handling of notes objects that are == null_sha1
 - notes.c: Reorder functions in preparation for next commit
 - notes.h: Make default_notes_ref() available in notes API
 - (trivial) notes.h: Minor documentation fixes to copy_notes()
 - notes.c: Hexify SHA1 in die() message from init_notes()

* jk/maint-rev-list-nul (2010-10-07) 1 commit
 - rev-list: handle %x00 NUL in user format

* jk/push-progress (2010-10-17) 8 commits
 - push: pass --progress down to git-pack-objects
 - t5523-push-upstream: test progress messages
 - t5523-push-upstream: add function to ensure fresh upstream repo
 - test_terminal: ensure redirections work reliably
 - test_terminal: catch use without TTY prerequisite
 - test-lib: allow test code to check the list of declared prerequisites
 - tests: test terminal output to both stdout and stderr
 - tests: factor out terminal handling from t7006

* jm/mailmap (2010-10-19) 3 commits
 - t4203: do not let "git shortlog" DWIM based on tty
 - t4203 (mailmap): stop hardcoding commit ids and dates
 - mailmap: fix use of freed memory

The new test seems to make t4203 break intermittently.

* jn/send-pack-error (2010-10-16) 1 commit
 - send-pack: avoid redundant "pack-objects died with strange error"

* kb/completion-checkout (2010-10-12) 1 commit
 - completion: Support the DWIM mode for git checkout

* pn/commit-autosquash (2010-10-07) 8 commits
 - add tests of commit --squash
 - commit: --squash option for use with rebase --autosquash
 - add tests of commit --fixup
 - commit: --fixup option for use with rebase --autosquash
 - pretty.c: teach format_commit_message() to reencode the output
 - pretty.c: helper methods for getting output encodings
 - commit.c: new function for looking up a comit by name
 - commit.c: prefer get_header() to manual searching

* sg/bisect (2010-10-10) 3 commits
 - bisect: check for mandatory argument of 'bisect replay'
 - bisect: improve error msg of 'bisect reset' when original HEAD is deleted
 - bisect: improve error message of 'bisect log' while not bisecting

* sg/completion (2010-10-11) 4 commits
 - bash: support pretty format aliases
 - bash: support more 'git notes' subcommands and their options
 - bash: not all 'git bisect' subcommands make sense when not bisecting
 - bash: offer refs for 'git bisect start'

* jj/icase-directory (2010-10-03) 8 commits
 - Support case folding in git fast-import when core.ignorecase=true
 - Support case folding for git add when core.ignorecase=true
 - Add case insensitivity support when using git ls-files
 - Add case insensitivity support for directories when using git status
 - Case insensitivity support for .gitignore via core.ignorecase
 - Add string comparison functions that respect the ignore_case variable.
 - Makefile & configure: add a NO_FNMATCH_CASEFOLD flag
 - Makefile & configure: add a NO_FNMATCH flag

* en/and-cascade-tests (2010-10-03) 13 commits
 - Introduce sane_unset and use it to ensure proper && chaining
 - t7800 (difftool): add missing &&
 - t7601 (merge-pull-config): add missing &&
 - t7001 (mv): add missing &&
 - t6016 (rev-list-graph-simplify-history): add missing &&
 - t5602 (clone-remote-exec): add missing &&
 - t4026 (color): remove unneeded and unchained command
 - t4019 (diff-wserror): add lots of missing &&
 - t4202 (log): Replace '<git-command> || :' with test_might_fail
 - t4002 (diff-basic): use test_might_fail for commands that might fail
 - t100[12] (read-tree-m-2way, read_tree_m_u_2way): add missing &&
 - t4017 (diff-retval): replace manual exit code check with test_expect_code
 - test-lib: make test_expect_code a test command
 (this branch is used by jn/git-cmd-h-bypass-setup.)

* jk/no-textconv-symlink (2010-09-21) 1 commit
 - diff: don't use pathname-based diff drivers for symlinks
 (this branch is used by ks/no-textconv-symlink.)

* ks/no-textconv-symlink (2010-09-29) 3 commits
 - blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''
 - blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
 - blame,cat-file: Prepare --textconv tests for correctly-failing conversion program
 (this branch uses jk/no-textconv-symlink.)

* nd/struct-pathspec (2010-09-20) 5 commits
 - ce_path_match: drop prefix matching in favor of match_pathspec
 - Convert ce_path_match() to use struct pathspec
 - tree_entry_interesting: turn to match_pathspec if wildcard is present
 - pathspec: add tree_recursive_diff parameter
 - pathspec: mark wildcard pathspecs from the beginning
 (this branch uses en/object-list-with-pathspec.)

* en/object-list-with-pathspec (2010-09-20) 8 commits
 - Add testcases showing how pathspecs are handled with rev-list --objects
 - Make rev-list --objects work together with pathspecs
 - Move tree_entry_interesting() to tree-walk.c and export it
 - tree_entry_interesting(): remove dependency on struct diff_options
 - Convert struct diff_options to use struct pathspec
 - pathspec: cache string length when initializing pathspec
 - diff-no-index: use diff_tree_setup_paths()
 - Add struct pathspec
 (this branch is used by nd/struct-pathspec.)

* tc/smart-http-post-redirect (2010-09-25) 1 commit
 - smart-http: Don't change POST to GET when following redirect

* en/rename-d-f (2010-09-08) 2 commits
 - merge-recursive: D/F conflicts where was_a_dir/file -> was_a_dir
 - t3509: Add rename + D/F conflict testcase that recursive strategy fails
 (this branch is used by en/merge-recursive.)

* jl/fetch-submodule-recursive (2010-09-19) 4 commits
 - fetch: Get submodule paths from index and not from .gitmodules
 - fetch: Fix a bug swallowing the output of recursive submodule fetching
 - Submodules: Add the new "fetch" config option for fetch and pull
 - fetch/pull: Recursively fetch populated submodules

I haven't picked up the rerolled one yet.

* tr/merge-unborn-clobber (2010-08-22) 1 commit
 - Exhibit merge bug that clobbers index&WT

* ab/i18n (2010-09-12) 160 commits
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
