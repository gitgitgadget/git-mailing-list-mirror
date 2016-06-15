From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2011, #03; Wed, 12)
Date: Wed, 12 Jan 2011 21:52:46 -0800
Message-ID: <7vr5ch1hap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 13 06:53:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdG7J-0005xD-Ee
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 06:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab1AMFw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 00:52:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab1AMFwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 00:52:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9AF938C8;
	Thu, 13 Jan 2011 00:53:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=YTXJ
	noDWUdSpxcG+lc45EWx0qsc=; b=T9pt2WyCaDqSXV30kP9+wDNI874x+dsVaoaW
	xeWenzsOVmU8Uwcj/cK1vb6JcH3whdNEBGA+QXgtFqVNBB7F0KpJc0BwoZTgow3Y
	JoUzQgB1CgXn6admNYfWpBBL2FJmiU/uQRJ2Eso+9Ns0z+eMr+YgMr+6DBX4PH3A
	vhnDJbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=KJS
	+kBCsspNIDfE1wSIztCBOTjqatPdvwhX8rI3NuSXWIDNAnPL8AGU0r5C3sSo0Aj3
	tYpLOOm1XqzQS8Y15Z7T9xisKMkVmQwq7rueL0mdyJIh+gsnueYd3I+qo9wXZaAF
	ZKgj4wzZjpGz3lR56K+9kAdXunhyZLNpf5DPNoJM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 970C938C7;
	Thu, 13 Jan 2011 00:53:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4028738B9; Thu, 13 Jan 2011
 00:53:29 -0500 (EST)
X-master-at: d2f15e29a6161b40dbc0142eb59f82092268e1d6
X-next-at: b7420fc6b7d092b9cf75d0f348d4ea29ccad866a
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 741B669E-1ED9-11E0-93DB-C7CE2BC26F3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165040>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

I'll start paying much less attention to any new features and enhancements
and shift the focus almost entirely on trivial fixes and regressions from
now on.  Hopefully lists will do the same and we can have a fairly short
rc period this cycle.  Please remind if there are patches that ought to be
in 1.7.4 but are forgotten.

--------------------------------------------------
[New Topics]

* jk/diff-driver-binary-doc (2011-01-09) 1 commit
  (merged to 'next' on 2011-01-10 at 1aa4c70)
 + docs: explain diff.*.binary option

* jn/t9010-work-around-broken-svnadmin (2011-01-06) 1 commit
  (merged to 'next' on 2011-01-10 at bd2f619)
 + t9010: svnadmin can fail even if available

* tr/submodule-relative-scp-url (2011-01-10) 1 commit
  (merged to 'next' on 2011-01-10 at 895f887)
 + submodule: fix relative url parsing for scp-style origin

The above three should all be 1.7.4 material.

* js/test-windows (2011-01-11) 2 commits
  (merged to 'next' on 2011-01-11 at c8274ed)
 + t/README: hint about using $(pwd) rather than $PWD in tests
 + Fix expected values of setup tests on Windows

* ab/p4 (2011-01-11) 1 commit
 - git-p4: correct indenting and formatting

* as/userdiff-pascal (2011-01-11) 1 commit
 - userdiff: match Pascal class methods

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

* jc/rename-degrade-cc-to-c (2011-01-06) 3 commits
 - diffcore-rename: fall back to -C when -C -C busts the rename limit
 - diffcore-rename: record filepair for rename src
 - diffcore-rename: refactor "too many candidates" logic

* jc/rerere-remaining (2011-01-06) 1 commit
 - rerere "remaining"

Just a handful of weatherballoon patches without proper tests, in response
to feature/minor fix requests.

--------------------------------------------------
[Cooking]

* rj/test-fixes (2010-12-14) 4 commits
  (merged to 'next' on 2011-01-08 at 37ef456)
 + t4135-*.sh: Skip the "backslash" tests on cygwin
 + t3032-*.sh: Do not strip CR from line-endings while grepping on MinGW
 + t3032-*.sh: Pass the -b (--binary) option to sed on cygwin
 + t6038-*.sh: Pass the -b (--binary) option to sed on cygwin
 
Will merge to 'master' soonish.

* rj/svn-test (2010-12-30) 1 commit
  (merged to 'next' on 2011-01-05 at ff38429)
 + lib-git-svn.sh: Move web-server handling code into separate function

Looked low-impact and trivial.  Might merge to 'master' sometime before
1.7.4, but we are in no hurry.

* sr/gitweb-hilite-more (2010-12-30) 2 commits
  (merged to 'next' on 2011-01-05 at 6b52e7e)
 + gitweb: remove unnecessary test when closing file descriptor
 + gitweb: add extensions to highlight feature map

Looked low-impact and trivial.  Might merge to 'master' sometime before
1.7.4, especially highlighting itself is a new feature.

* mz/rebase (2010-12-28) 31 commits
 - rebase -i: remove unnecessary state rebase-root
 - rebase -i: don't read unused variable preserve_merges
 - git-rebase--am: remove unnecessary --3way option
 - rebase -m: don't print exit code 2 when merge fails
 - rebase -m: remember allow_rerere_autoupdate option
 - rebase: remember strategy and strategy options
 - rebase: remember verbose option
 - rebase: extract code for writing basic state
 - rebase: factor out sub command handling
 - rebase: make -v a tiny bit more verbose
 - rebase -i: align variable names
 - rebase: show consistent conflict resolution hint
 - rebase: extract am code to new source file
 - rebase: extract merge code to new source file
 - rebase: remove $branch as synonym for $orig_head
 - rebase -i: support --stat
 - rebase: factor out call to pre-rebase hook
 - rebase: factor out clean work tree check
 - rebase: factor out reference parsing
 - rebase: reorder validation steps
 - rebase -i: remove now unnecessary directory checks
 - rebase: factor out command line option processing
 - rebase: align variable content
 - rebase: align variable names
 - rebase: stricter check of standalone sub command
 - rebase: act on command line outside parsing loop
 - rebase: improve detection of rebase in progress
 - rebase: remove unused rebase state 'prev_head'
 - rebase: read state outside loop
 - rebase: refactor reading of state
 - rebase: clearer names for directory variables

I personally haven't finished reading this one yet; Thomas said the
general direction of the series basically seemed sound (with nits here
and there), which I trust.  Hopefully we will see a re-roll of this
series sometime soon, but we are not in a hurry.

* ef/alias-via-run-command (2011-01-07) 1 commit
  (merged to 'next' on 2011-01-06 at 1fbd4a0)
 + alias: use run_command api to execute aliases

* uk/checkout-ambiguous-ref (2011-01-11) 1 commit
  (merged to 'next' on 2011-01-11 at 2aa30de)
 + checkout: fix bug with ambiguous refs

* jn/gitweb-no-logo (2010-09-03) 1 commit
  (merged to 'next' on 2011-01-04 at a5d186c)
 + gitweb: make logo optional

Seems trivial but came a bit too late for the cycle.

* cb/setup (2010-12-27) 1 commit
  (merged to 'next' on 2011-01-05 at 790b288)
 + setup: translate symlinks in filename when using absolute paths

Seems trivial but came a bit too late for the cycle.

* ae/better-template-failure-report (2010-12-18) 1 commit
  (merged to 'next' on 2011-01-05 at d3f9142)
 + Improve error messages when temporary file creation fails

* jc/unpack-trees (2010-12-22) 2 commits
 - unpack_trees(): skip trees that are the same in all input
 - unpack-trees.c: cosmetic fix

* jn/cherry-pick-strategy-option (2010-12-10) 1 commit
  (merged to 'next' on 2011-01-05 at 3ccc590)
 + cherry-pick/revert: add support for -X/--strategy-option

* jn/perl-funcname (2010-12-27) 2 commits
  (merged to 'next' on 2011-01-05 at 20542ed)
 + userdiff/perl: catch BEGIN/END/... and POD as headers
 + diff: funcname and word patterns for perl

Looked low-impact and trivial.  Might merge to 'master' sometime before
1.7.4, but we are in no hurry.

* tr/maint-branch-no-track-head (2010-12-14) 1 commit
 - branch: do not attempt to track HEAD implicitly

Probably needs a re-roll to exclude either (1) any ref outside the
hierarchies for branches (i.e. refs/{heads,remotes}/), or (2) only refs
outside refs/ hierarchies (e.g. HEAD, ORIG_HEAD, ...).  The latter feels
safer and saner.

* hv/mingw-fs-funnies (2010-12-14) 5 commits
 - mingw_rmdir: set errno=ENOTEMPTY when appropriate
 - mingw: add fallback for rmdir in case directory is in use
 - mingw: make failures to unlink or move raise a question
 - mingw: work around irregular failures of unlink on windows
 - mingw: move unlink wrapper to mingw.c

Will be rerolled (Heiko, 2010-12-23)

* nd/struct-pathspec (2010-12-15) 21 commits
 - t7810: overlapping pathspecs and depth limit
 - grep: drop pathspec_matches() in favor of tree_entry_interesting()
 - grep: use writable strbuf from caller for grep_tree()
 - grep: use match_pathspec_depth() for cache/worktree grepping
 - grep: convert to use struct pathspec
 - Convert ce_path_match() to use match_pathspec_depth()
 - Convert ce_path_match() to use struct pathspec
 - struct rev_info: convert prune_data to struct pathspec
 - pathspec: add match_pathspec_depth()
 - tree_entry_interesting(): optimize wildcard matching when base is matched
 - tree_entry_interesting(): support wildcard matching
 - tree_entry_interesting(): fix depth limit with overlapping pathspecs
 - tree_entry_interesting(): support depth limit
 - tree_entry_interesting(): refactor into separate smaller functions
 - diff-tree: convert base+baselen to writable strbuf
 - glossary: define pathspec
 - Move tree_entry_interesting() to tree-walk.c and export it
 - tree_entry_interesting(): remove dependency on struct diff_options
 - Convert struct diff_options to use struct pathspec
 - diff-no-index: use diff_tree_setup_paths()
 - Add struct pathspec
 (this branch is used by en/object-list-with-pathspec.)

On hold, perhaps in 'next', til 1.7.4 final.

* en/object-list-with-pathspec (2010-09-20) 2 commits
 - Add testcases showing how pathspecs are handled with rev-list --objects
 - Make rev-list --objects work together with pathspecs
 (this branch uses nd/struct-pathspec.)

On hold, perhaps in 'next', til 1.7.4 final.

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

--------------------------------------------------
[Ejected]

* jn/svn-fe (2010-12-06) 17 commits
 . vcs-svn: Allow change nodes for root of tree (/)
 . vcs-svn: Implement Prop-delta handling
 . vcs-svn: Sharpen parsing of property lines
 . vcs-svn: Split off function for handling of individual properties
 . vcs-svn: Make source easier to read on small screens
 . vcs-svn: More dump format sanity checks
 . vcs-svn: Reject path nodes without Node-action
 . vcs-svn: Delay read of per-path properties
 . vcs-svn: Combine repo_replace and repo_modify functions
 . vcs-svn: Replace = Delete + Add
 . vcs-svn: handle_node: Handle deletion case early
 . vcs-svn: Use mark to indicate nodes with included text
 . vcs-svn: Unclutter handle_node by introducing have_props var
 . vcs-svn: Eliminate node_ctx.mark global
 . vcs-svn: Eliminate node_ctx.srcRev global
 . vcs-svn: Check for errors from open()
 . vcs-svn: Allow simple v3 dumps (no deltas yet)

Some RFC patches, to give them early and wider exposure.  Ejected for now.
