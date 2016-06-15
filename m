From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2010, #01; Wed, 13)
Date: Wed, 13 Oct 2010 21:46:38 -0700
Message-ID: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 06:46:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6FiR-0008PV-TR
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 06:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab0JNEqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 00:46:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab0JNEqp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 00:46:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EED34DE809;
	Thu, 14 Oct 2010 00:46:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=SOnf
	S5gu6eJeFrwf+dU/NdyNEBE=; b=fSzx6nghJkhzVi8cP8HlRPRBKvUvo1WPhHPv
	UiWbcutjQtdqkv/2KidCIJpslJ8Liq8VrV8grh2kbYKj6M6+ZaIOL1u81nZceBvp
	ybAAprraeR5kVevqhGc4XmgRsQi495CsoOurkZ1lmMBspm064q2kVY3Id6T4QRnt
	FALovXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=MvA
	7fxefJVt/ittaxb4KaFMzb0dnBEihtZAS0FwHenG6eMMvcoXj9oiuIUKH+xm4NXG
	dxX3QegeZu3I9TtbGTSVrMhshALnQZuKlWHv+UP5U47D2PvEKBAkFDI13LHUwFD3
	E6txjUKlfTaskzOa3psk2AubRsiHDk/ao3ReDuIo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7229DE808;
	Thu, 14 Oct 2010 00:46:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99DF5DE806; Thu, 14 Oct
 2010 00:46:40 -0400 (EDT)
X-master-at: 38a18873b21f6f2eebedc65aff2249fd6ec2168c
X-next-at: 53ea256ab9071d54b4f09772408e442ad43bc73a
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A885CA0-D74E-11DF-894A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159023>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* ab/makefile-track-cc (2010-09-12) 1 commit
  (merged to 'next' on 2010-09-27 at 51daee0)
 + Makefile: add CC to TRACK_CFLAGS

* bc/fix-cherry-pick-root (2010-09-27) 1 commit
  (merged to 'next' on 2010-09-27 at e27f4c9)
 + builtin/revert.c: don't dereference a NULL pointer

* cw/gitweb-hilite-config (2010-09-21) 1 commit
  (merged to 'next' on 2010-09-27 at dd234ba)
 + Enable highlight executable path as a configuration option

* jk/repack-reuse-object (2010-09-27) 2 commits
  (merged to 'next' on 2010-09-27 at 5719f72)
 + Documentation: pack.compression: explain how to recompress
 + repack: add -F flag to let user choose between --no-reuse-delta/object

* mg/reset-doc (2010-09-15) 6 commits
  (merged to 'next' on 2010-09-22 at 2a10b71)
 + git-reset.txt: make modes description more consistent
 + git-reset.txt: point to git-checkout
 + git-reset.txt: use "working tree" consistently
 + git-reset.txt: reset --soft is not a no-op
 + git-reset.txt: reset does not change files in target
 + git-reset.txt: clarify branch vs. branch head

* uk/fix-author-ident-sed-script (2010-09-23) 1 commit
  (merged to 'next' on 2010-09-27 at 5ad7d90)
 + get_author_ident_from_commit(): remove useless quoting

--------------------------------------------------
[New Topics]

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

* cb/diff-fname-optim (2010-09-26) 3 commits
 - diff: avoid repeated scanning while looking for funcname
 - do not search functions for patch ID
 - add rebase patch id tests

* en/merge-recursive (2010-09-20) 38 commits
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

* jh/notes-merge (2010-10-09) 21 commits
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

Breaks build with arithmetic on (void *).

* jk/maint-rev-list-nul (2010-10-07) 1 commit
 - rev-list: handle %x00 NUL in user format

* jk/push-progress (2010-10-14) 2 commits
 - push: pass --progress down to git-pack-objects
 - t5523-push-upstream: test progress messages

* jm/mailmap (2010-10-11) 1 commit
 - mailmap: fix use of freed memory

The new test seems to make t4203 break intermittently.

* jn/send-pack-error (2010-10-12) 1 commit
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

* sn/doc-opt-notation (2010-10-08) 6 commits
  (merged to 'next' on 2010-10-13 at 53ea256)
 + Fix {update,checkout}-index usage strings
 + Put a space between `<' and argument in pack-objects usage string
 + Remove stray quotes in --pretty and --format documentation
 + Use parentheses and `...' where appropriate
 + Fix odd markup in --diff-filter documentation
 + Use angles for placeholders consistently

* yd/dir-rename (2010-10-10) 5 commits
 - diff --check: correct line numbers of new blank lines at EOF
 - Transfer special display of toplevel dir to display-time.
 - Only show bulkmoves in output.
 - Add testcases for the --detect-bulk-moves diffcore flag.
 - Introduce bulk-move detection in diffcore.

This seems to break the build with decl-after-stmt.

--------------------------------------------------
[Stalled]

* nd/index-doc (2010-09-06) 1 commit
 - doc: technical details about the index file format

Half-written but it is a good start.  I may need to give some help in
describing more recent index extensions.

* by/line-log (2010-09-11) 18 commits
 . log -L: do not free parents lists we might need again
 . Document line history browser
 . Add tests for line history browser
 . Add --full-line-diff option
 . Add --graph prefix before line history output
 . Add parent rewriting to line history browser
 . Make graph_next_line external to other part of git
 . Make rewrite_parents public to other part of git
 . Hook line history into cmd_log, ensuring a topo-ordered walk
 . Print the line log
 . map/take range to the parent of commits
 . Add range clone functions
 . Export three functions from diff.c
 . Parse the -L options
 . Refactor parse_loc
 . Add the basic data structure for line level history
 . parse-options: add two helper functions
 . parse-options: enhance STOP_AT_NON_OPTION

Temporarily ejected to give room to nd/struct-pathspec topic as this
conflicts with it.

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

* jj/icase-directory (2010-10-03) 8 commits
 - Support case folding in git fast-import when core.ignorecase=true
 - Support case folding for git add when core.ignorecase=true
 - Add case insensitivity support when using git ls-files
 - Add case insensitivity support for directories when using git status
 - Case insensitivity support for .gitignore via core.ignorecase
 - Add string comparison functions that respect the ignore_case variable.
 - Makefile & configure: add a NO_FNMATCH_CASEFOLD flag
 - Makefile & configure: add a NO_FNMATCH flag

* ab/require-perl-5.8 (2010-09-24) 2 commits
  (merged to 'next' on 2010-09-27 at 1fcdd3c)
 + perl: use "use warnings" instead of -w
 + perl: bump the required Perl version to 5.8 from 5.6.[21]

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

Somewhat rerolled, but the largest one among the series was Nacked by a
few people and needs to be rerolled again.

* jk/no-textconv-symlink (2010-09-21) 1 commit
 - diff: don't use pathname-based diff drivers for symlinks
 (this branch is used by ks/no-textconv-symlink.)

* ks/no-textconv-symlink (2010-09-29) 3 commits
 - blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''
 - blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
 - blame,cat-file: Prepare --textconv tests for correctly-failing conversion program
 (this branch uses jk/no-textconv-symlink.)

* jp/send-email-to-cmd (2010-09-24) 1 commit
  (merged to 'next' on 2010-09-30 at 4284ddb)
 + git-send-email.perl: Add --to-cmd

* kb/merge-recursive-rename-threshold (2010-09-27) 2 commits
  (merged to 'next' on 2010-09-30 at 4f33817)
 + diff: add synonyms for -M, -C, -B
 + merge-recursive: option to specify rename threshold
 (this branch uses jf/merge-ignore-ws.)

* mg/fix-build-remote-helpers (2010-09-17) 1 commit
  (merged to 'next' on 2010-09-30 at 0583d5f)
 + remote-helpers: build in platform independent directory

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

* sb/send-email-use-to-from-input (2010-10-04) 2 commits
  (merged to 'next' on 2010-10-06 at 5e9cb61)
 + send-email: Don't leak To: headers between patches
  (merged to 'next' on 2010-09-30 at 513b6f1)
 + send-email: Use To: headers in patch files

* tc/smart-http-post-redirect (2010-09-25) 1 commit
 - smart-http: Don't change POST to GET when following redirect

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

* en/rename-d-f (2010-09-08) 2 commits
 - merge-recursive: D/F conflicts where was_a_dir/file -> was_a_dir
 - t3509: Add rename + D/F conflict testcase that recursive strategy fails
 (this branch is used by en/merge-recursive.)

* kf/post-receive-sample-hook (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-22 at db674a3)
 + post-receive-email: ensure sent messages are not empty

I notice that it uses "PAGER= generate_email" where generate_email is a
shell function, which may break in some implementations of POSIX /bin/sh.
This is not a regression (the original also had the same issue), but
somebody who cares enough might want to look into it.

* ml/completion-zsh (2010-09-06) 1 commit
  (merged to 'next' on 2010-09-22 at d62d10e)
 + completion: make compatible with zsh

Reported as breaking people with "set -u".

* po/sendemail (2010-09-06) 3 commits
  (merged to 'next' on 2010-09-22 at 1105f62)
 + New send-email option smtpserveroption.
 + Remove @smtp_host_parts variable as not used.
 + Minor indentation fix.

Will merge to 'master' shortly.

* jl/fetch-submodule-recursive (2010-09-19) 4 commits
 - fetch: Get submodule paths from index and not from .gitmodules
 - fetch: Fix a bug swallowing the output of recursive submodule fetching
 - Submodules: Add the new "fetch" config option for fetch and pull
 - fetch/pull: Recursively fetch populated submodules

I haven't picked up the rerolled one yet.

* jf/merge-ignore-ws (2010-08-26) 4 commits
  (merged to 'next' on 2010-09-22 at 5161fb8)
 + merge-recursive: options to ignore whitespace changes
 + merge-recursive --patience
 + ll-merge: replace flag argument with options struct
 + merge-recursive: expose merge options for builtin merge
 (this branch is used by kb/merge-recursive-rename-threshold.)

Possibly one of the star features of the coming release.

* tr/merge-unborn-clobber (2010-08-22) 1 commit
 - Exhibit merge bug that clobbers index&WT

* en/tree-walk-optim (2010-08-26) 4 commits
  (merged to 'next' on 2010-09-22 at 0601f1b)
 + diff_tree(): Skip skip_uninteresting() when all remaining paths interesting
 + tree_entry_interesting(): Make return value more specific
 + tree-walk: Correct bitrotted comment about tree_entry()
 + Document pre-condition for tree_entry_interesting

Will merge to 'master' shortly.

* ab/i18n (2010-09-12) 159 commits
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
