From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2010, #07; Wed, 29)
Date: Wed, 29 Sep 2010 17:16:10 -0700
Message-ID: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 02:16:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P16ow-0005Cx-6b
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 02:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab0I3AQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 20:16:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab0I3AQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 20:16:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4076EDAAB1;
	Wed, 29 Sep 2010 20:16:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=7VHu
	KJp1qzf45ihiJsD8e9O3Y5c=; b=jQTIhsn6fAjBfuulaZw+to4y8RG7jktgpxOB
	NAE3MrBtbTwmCfnX9qGqt5FmdqbUKiBqVjNg4pHH3jLVouY96Mnb+NL5XIoiZwgl
	mEx/jiX7AGIax+afnck0vQE7RVLScSBo7WvSE/vV/wMTk5KuwGUCHbBgaRZRFrua
	ASjEItU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=AU6
	RZ1F21iNzwhYdVwuZHq/zhABFf4HSoQOYyUHfcapa/BRUgTjnfXfvwfAKCm2RrPW
	X1AiM+ocItVwSizhqNcDYI0rxbb38YV95/hukGdrY1v2Hh103HkT23FI1tgY5ijP
	ccummyQGrzZW3J/SobZfwcsPVi6A3rG+NNUjr9mM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28DC0DAAB0;
	Wed, 29 Sep 2010 20:16:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA6D6DAAAF; Wed, 29 Sep
 2010 20:16:11 -0400 (EDT)
X-master-at: 9855b08d35edf8a8a441f24ff7b00e220a29f261
X-next-at: 92b87a9bab1a84261d2381e813e58577967bdc79
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EFAA3E7A-CC27-11DF-B406-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157624>

What's cooking in git.git (Sep 2010, #07; Wed, 29)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

With fixes to a few brown paper bag regressions to "git stash", 1.7.3.1 is
out.  The first batch of topics that have been cooking have graduated on
the 'master' front.

--------------------------------------------------
[Graduated to "master"]

* ab/send-email-catfile (2010-09-14) 1 commit
  (merged to 'next' on 2010-09-22 at 5c53513)
 + send-email: use catfile() to concatenate files

* bc/fortran-userdiff (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-22 at f0c8ddb)
 + userdiff.c: add builtin fortran regex patterns

* gb/shell-ext (2010-08-27) 6 commits
  (merged to 'next' on 2010-09-22 at e529b2a)
 + shell: Display errors from improperly-formatted command lines
 + Merge branch 'gb/split-cmdline-errmsg' into gb/shell-ext
 + shell: Rewrite documentation and improve error message
 + Add sample commands for git-shell
 + Add interactive mode to git-shell for user-friendliness
 + Allow creation of arbitrary git-shell commands

* jc/grep-header-all-match-fix (2010-09-12) 2 commits
  (merged to 'next' on 2010-09-22 at c78a8aa)
 + log --author: take union of multiple "author" requests
 + grep: move logic to compile header pattern into a separate helper
 (this branch is used by jc/grep-header-all-match-fix-debug.)

We might want to give a more comprehensive revamp to the "filter by
grepping the commit log message" feature some day, somehow allowing the
full "git grep" boolean expression.  But until then, this should suffice.

* jc/no-branch-name-with-dash-at-front (2010-09-14) 1 commit
  (merged to 'next' on 2010-09-22 at 5918d77)
 + disallow branch names that start with a hyphen

This came up at $WORK.

* jc/pickaxe-grep (2010-08-31) 4 commits
  (merged to 'next' on 2010-09-22 at 2a33735)
 + diff/log -G<pattern>: tests
 + git log/diff: add -G<regexp> that greps in the patch text
 + diff: pass the entire diff-options to diffcore_pickaxe()
 + gitdiffcore doc: update pickaxe description

This is a re-roll of "grepping inside the log -p output" which is a
feature that is often asked for when people hear about -S option.

* jk/read-tree-empty (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-22 at a6a00bd)
 + read-tree: deprecate syntax without tree-ish args

* jn/gitweb-test-lib (2010-09-12) 2 commits
  (merged to 'next' on 2010-09-22 at 8a471ba)
 + t/gitweb-lib.sh: Use tabs for indent consistently
 + t/gitweb-lib.sh: Use GIT_BUILD_DIR

* po/etc-gitattributes (2010-09-01) 1 commit
  (merged to 'next' on 2010-09-22 at dc64419)
 + Add global and system-wide gitattributes

* rr/fmt-merge-msg (2010-09-08) 5 commits
  (merged to 'next' on 2010-09-22 at 958ca95)
 + t6200-fmt-merge-msg: Exercise '--log' to configure shortlog length
 + t6200-fmt-merge-msg: Exercise 'merge.log' to configure shortlog length
 + merge: Make 'merge.log' an integer or boolean option
 + merge: Make '--log' an integer option for number of shortlog entries
 + fmt_merge_msg: Change fmt_merge_msg API to accept shortlog_len

* rr/format-patch-count-without-merges (2010-08-28) 2 commits
  (merged to 'next' on 2010-09-22 at 4ae3edc)
 + format-patch: Don't go over merge commits
 + t4014-format-patch: Call test_tick before committing

* tr/send-email-refuse-sending-unedited-cover-letter (2009-06-08) 1 commit
  (merged to 'next' on 2010-09-22 at e306400)
 + send-email: Refuse to send cover-letter template subject

--------------------------------------------------
[New Topics]

* mg/reset-doc (2010-09-15) 6 commits
  (merged to 'next' on 2010-09-22 at 2a10b71)
 + git-reset.txt: make modes description more consistent
 + git-reset.txt: point to git-checkout
 + git-reset.txt: use "working tree" consistently
 + git-reset.txt: reset --soft is not a no-op
 + git-reset.txt: reset does not change files in target
 + git-reset.txt: clarify branch vs. branch head

Will merge to 'master' shortly.

* ab/makefile-track-cc (2010-09-12) 1 commit
  (merged to 'next' on 2010-09-27 at 51daee0)
 + Makefile: add CC to TRACK_CFLAGS

Will merge to 'master' shortly.

* ab/require-perl-5.8 (2010-09-24) 2 commits
  (merged to 'next' on 2010-09-27 at 1fcdd3c)
 + perl: use "use warnings" instead of -w
 + perl: bump the required Perl version to 5.8 from 5.6.[21]

* bc/fix-cherry-pick-root (2010-09-27) 1 commit
  (merged to 'next' on 2010-09-27 at e27f4c9)
 + builtin/revert.c: don't dereference a NULL pointer

Will merge to 'master' shortly.

* cw/gitweb-hilite-config (2010-09-21) 1 commit
  (merged to 'next' on 2010-09-27 at dd234ba)
 + Enable highlight executable path as a configuration option

Will merge to 'master' shortly.

* en/and-cascade-tests (2010-09-26) 12 commits
 - Add missing &&'s throughout the testsuite
 - t7601 (merge-pull-config): add missing &&
 - t7001 (mv): add missing &&
 - t6016 (rev-list-graph-simplify-history): add missing &&
 - t4026 (color): remove unneeded and unchained command
 - t4019 (diff-wserror): add lots of missing &&
 - t3600 (rm): add lots of missing &&
 - t4202 (log): Replace '<git-command> || :' with test_might_fail
 - t4002 (diff-basic): use test_might_fail for commands that might fail
 - t100[12] (read-tree-m-2way, read_tree_m_u_2way): add missing &&
 - t4017 (diff-retval): replace manual exit code check with test_expect_code
 - t3020 (ls-files-error-unmatch): remove stray '1' from end of file

I've rejected a few patches in the series; will merge this to 'next'
perhaps after a reroll or two.

* jk/no-textconv-symlink (2010-09-21) 1 commit
 - diff: don't use pathname-based diff drivers for symlinks
 (this branch is used by ks/no-textconv-symlink.)

* ks/no-textconv-symlink (2010-09-29) 3 commits
 - blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''
 - blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
 - blame,cat-file: Prepare --textconv tests for correctly-failing conversion program
 (this branch uses jk/no-textconv-symlink.)

* jk/repack-reuse-object (2010-09-27) 2 commits
  (merged to 'next' on 2010-09-27 at 5719f72)
 + Documentation: pack.compression: explain how to recompress
 + repack: add -F flag to let user choose between --no-reuse-delta/object

Will merge to 'master' shortly.

* jp/send-email-to-cmd (2010-09-24) 1 commit
 - git-send-email.perl: Add --to-cmd

Should be Ok for 'next'.

* kb/merge-recursive-rename-threshold (2010-09-27) 2 commits
 - diff: add synonyms for -M, -C, -B
 - merge-recursive: option to specify rename threshold
 (this branch uses jf/merge-ignore-ws.)

Should be Ok for 'next'.

* mg/fix-build-remote-helpers (2010-09-17) 1 commit
 - remote-helpers: build in platform independent directory

Should be Ok for 'next'.

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
 - pathspec: cache string length when initialize pathspec
 - diff-no-index: use diff_tree_setup_paths()
 - Add struct pathspec
 (this branch is used by nd/struct-pathspec.)

* sb/send-email-use-to-from-input (2010-09-29) 1 commit
 - send-email: Use To: headers in patch files

Should be Ok for 'next'.

* tc/smart-http-post-redirect (2010-09-25) 1 commit
 - smart-http: Don't change POST to GET when following redirect

* uk/fix-author-ident-sed-script (2010-09-23) 1 commit
  (merged to 'next' on 2010-09-27 at 5ad7d90)
 + get_author_ident_from_commit(): remove useless quoting

Will merge to 'master' shortly.

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

* jj/icase-directory (2010-08-16) 6 commits
 - Support case folding in git fast-import when core.ignorecase=true
 - Support case folding for git add when core.ignorecase=true
 - Add case insensitivity support when using git ls-files
 - Add case insensitivity support for directories when using git status
 - Case insensitivity support for .gitignore via core.ignorecase
 - Add string comparison functions that respect the ignore_case variable.

Depends on GNU FNM_CASEFOLD.  Presumably a bit of tweak in Makefile for
non-windows but non-GNU platforms is all it takes?

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

* as/daemon-multi-listen (2010-08-30) 2 commits
 - daemon: allow more than one host address given via --listen
 - daemon: add helper function named_sock_setup

Should be Ok for 'next'.

* jc/grep-header-all-match-fix-debug (2010-09-13) 1 commit
 - grep debugging, just in case

Not necessary; will drop shortly.

* dm/mergetool-vimdiff (2010-09-27) 3 commits
  (merged to 'next' on 2010-09-29 at c8e22ea)
 + mergetool-lib: make the three-way diff the default for vim/gvim
  (merged to 'next' on 2010-09-22 at 12f7559)
 + mergetool-lib: add a three-way diff view for vim/gvim
 + mergetool-lib: combine vimdiff and gvimdiff run blocks

* en/rename-d-f (2010-09-08) 2 commits
 - merge-recursive: D/F conflicts where was_a_dir/file -> was_a_dir
 - t3509: Add rename + D/F conflict testcase that recursive strategy fails

I am not entirely convinced this is a regression free band-aid; need to
look at this a few more times.

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

Comments from bash users regarding regressions?

* po/sendemail (2010-09-06) 3 commits
  (merged to 'next' on 2010-09-22 at 1105f62)
 + New send-email option smtpserveroption.
 + Remove @smtp_host_parts variable as not used.
 + Minor indentation fix.

Comments from potential users?

* jl/fetch-submodule-recursive (2010-09-19) 4 commits
 - fetch: Get submodule paths from index and not from .gitmodules
 - fetch: Fix a bug swallowing the output of recursive submodule fetching
 - Submodules: Add the new "fetch" config option for fetch and pull
 - fetch/pull: Recursively fetch populated submodules

Further work expected after 1.7.3 between Jens and Kevin.

* jf/merge-ignore-ws (2010-08-26) 4 commits
  (merged to 'next' on 2010-09-22 at 5161fb8)
 + merge-recursive: options to ignore whitespace changes
 + merge-recursive --patience
 + ll-merge: replace flag argument with options struct
 + merge-recursive: expose merge options for builtin merge
 (this branch is used by kb/merge-recursive-rename-threshold.)

Possibly one of the star features of the release after 1.7.3, whether it
is called 1.7.4 or 1.8.0.

* tr/merge-unborn-clobber (2010-08-22) 1 commit
 - Exhibit merge bug that clobbers index&WT

* en/tree-walk-optim (2010-08-26) 4 commits
  (merged to 'next' on 2010-09-22 at 0601f1b)
 + diff_tree(): Skip skip_uninteresting() when all remaining paths interesting
 + tree_entry_interesting(): Make return value more specific
 + tree-walk: Correct bitrotted comment about tree_entry()
 + Document pre-condition for tree_entry_interesting

Need to look at this a few more times to convince myself that this is Ok.

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
