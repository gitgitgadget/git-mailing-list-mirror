From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2010, #03; Fri, 10)
Date: Fri, 10 Sep 2010 16:08:52 -0700
Message-ID: <7v1v91gprv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 11 01:09:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuCiQ-00045J-7x
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 01:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994Ab0IJXJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 19:09:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab0IJXI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 19:08:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0205D5210;
	Fri, 10 Sep 2010 19:08:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=3Hr1
	zgy624ednbmUDQo+qk6rugs=; b=GjWzuzqj3RyB6rwa2XKHpieMm8ZRc2b2SBVT
	wQ4aApCd7NQRzD8e5j1VuoCltZDHvZ/9TzKOB1Fy+ay7oXHo5tczQ0tns7It2av/
	MnwWJ+JYppAoJ4zLneWCZY0scHmvJQVRJq2B1NbcE/H2NadIXHDtkDktZMDBjIbB
	CfdFKQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Sr+
	Qqqp2mJbmsHflRrazE/mEUkWwdVnKRUjL9ydYJklLcfcPVPpYl9mKH1yC4GjCAYA
	NvNVUo6VQAHZRN4bLpAtmK21wWTj6JuIwyz2jId5vEOpkkM6UA3rESE0Seaqj7ru
	DuVND6igXQJz/Hr5vuTJzkdluPzmjYcVEJjy8L6Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A428D520F;
	Fri, 10 Sep 2010 19:08:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 768CAD520B; Fri, 10 Sep
 2010 19:08:54 -0400 (EDT)
X-master-at: 3b3a8ed4beadf5d9437597108355b23c7143bc81
X-next-at: 6997c032819c723ef892e89b21b9bf245420086d
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 634668BA-BD30-11DF-B247-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155983>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

We have in 'master' is more-or-less the final 1.7.3; it is tagged as rc1.

Please give it a good beating to find regressions.

--------------------------------------------------
[New Topics]

* jl/fix-test (2010-09-07) 7 commits
  (merged to 'next' on 2010-09-10 at 849b1bb)
 + t1020: Get rid of 'cd "$HERE"' at the start of each test
 + t2016 (checkout -p): add missing &&
 + t1302 (core.repositoryversion): style tweaks
 + t2105 (gitfile): add missing &&
 + t1450 (fsck): remove dangling objects
 + tests: subshell indentation stylefix
 + Merge branch 'jl/maint-fix-test'
 (this branch uses jl/maint-fix-test.)

* jl/maint-fix-test (2010-09-06) 1 commit
 + Several tests: cd inside subshell instead of around
 (this branch is used by jl/fix-test.)

* nd/index-doc (2010-09-06) 1 commit
  (merged to 'next' on 2010-09-10 at 2ab8572)
 + doc: technical details about the index file format

Half-written but it is a good start.

* tr/send-email-refuse-sending-unedited-cover-letter (2009-06-08) 1 commit
 - send-email: Refuse to send cover-letter template subject

* bc/describe-not-dirty-for-untracked-paths-in-submodule (2010-09-09) 1 commit
 - builtin/describe.c: ignore untracked changes in submodules

* bc/fortran-userdiff (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-10 at b76b831)
 + userdiff.c: add builtin fortran regex patterns

* en/rename-d-f (2010-09-08) 2 commits
 - merge-recursive: D/F conflicts where was_a_dir/file -> was_a_dir
 - t3509: Add rename + D/F conflict testcase that recursive strategy fails

* jk/read-tree-empty (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-10 at 2f3a995)
 + read-tree: deprecate syntax without tree-ish args

* kf/post-receive-sample-hook (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-10 at 53ebeba)
 + post-receive-email: ensure sent messages are not empty

* ml/completion-zsh (2010-09-06) 1 commit
  (merged to 'next' on 2010-09-10 at b509ebc)
 + completion: make compatible with zsh

* os/fix-rebase-diff-no-prefix (2010-09-09) 1 commit
  (merged to 'next' on 2010-09-10 at f1acd10)
 + Add --src/dst-prefix to git-formt-patch in git-rebase.sh

--------------------------------------------------
[Graduated to "master"]

* bc/maint-fetch-url-only (2010-08-25) 2 commits
  (merged to 'next' on 2010-09-04 at 710af12)
 + builtin/fetch.c: ignore merge config when not fetching from branch's remote
 + t/t5510: demonstrate failure to fetch when current branch has merge ref

* jh/error-removing-missing-note (2010-08-31) 1 commit
  (merged to 'next' on 2010-09-04 at 428b078)
 + notes: Don't create (empty) commit when removing non-existing notes

* jk/maint-pass-c-config-in-env (2010-08-24) 2 commits
  (merged to 'next' on 2010-09-04 at f4ed3ac)
 + do not pass "git -c foo=bar" params to transport helpers
 + pass "git -c foo=bar" params through environment

* jk/test-must-fail-missing (2010-08-31) 4 commits
  (merged to 'next' on 2010-09-04 at cc5c1c4)
 + tests: make test_might_fail fail on missing commands
 + tests: make test_might_fail more verbose
 + tests: make test_must_fail fail on missing commands
 + tests: make test_must_fail more verbose

* kf/askpass-config (2010-08-30) 3 commits
  (merged to 'next' on 2010-09-04 at c49783f)
 + Extend documentation of core.askpass and GIT_ASKPASS.
 + Allow core.askpass to override SSH_ASKPASS.
 + Add a new option 'core.askpass'.

* np/relnotes-in-subdir (2010-09-09) 2 commits
 + install-webdoc: keep installed RelNotes-*.txt
 + Documentation: move RelNotes into a directory of their own

Needed to devise a way to grandfather URLs that point at release notes of
older versions, but other than that, this is a good thing to do.

* tf/cleanup-builtin-help-headers (2010-08-31) 1 commit
  (merged to 'next' on 2010-09-06 at dbf0d4b)
 + builtin.h: Move two functions definitions to help.h.

--------------------------------------------------
[Stalled]

* jj/icase-directory (2010-08-16) 6 commits
  (merged to 'next' on 2010-08-26 at 9d8e1bc)
 + Support case folding in git fast-import when core.ignorecase=true
 + Support case folding for git add when core.ignorecase=true
 + Add case insensitivity support when using git ls-files
 + Add case insensitivity support for directories when using git status
 + Case insensitivity support for .gitignore via core.ignorecase
 + Add string comparison functions that respect the ignore_case variable.

Depends on GNU FNM_CASEFOLD.  Presumably a bit of tweak in Makefile for
non-windows but non-GNU platforms is all it takes?

* by/line-log (2010-08-11) 17 commits
  (merged to 'next' on 2010-08-26 at a160ff1)
 + Document line history browser
 + Add tests for line history browser
 + Add --full-line-diff option
 + Add --graph prefix before line history output
 + Add parent rewriting to line history browser
 + Make graph_next_line external to other part of git
 + Make rewrite_parents public to other part of git
 + Hook line history into cmd_log, ensuring a topo-ordered walk
 + Print the line log
 + map/take range to the parent of commits
 + Add range clone functions
 + Export three functions from diff.c
 + Parse the -L options
 + Refactor parse_loc
 + Add the basic data structure for line level history
 + parse-options: add two helper functions
 + parse-options: enhance STOP_AT_NON_OPTION

There is a reported crash with valgrind trace.  Bo seems to be looking
into it.

* il/rfc-remote-fd-ext (2010-08-26) 7 commits
 - remote-ext/fd style fixup
 - Fix build on Windows
 - Simplify send_git_request()
 - Rewrite bidirectional traffic loop
 - gitignore: Ignore the new /git-remote-{ext,fd} helpers
 - New remote helper: git-remote-ext
 - New remote helper git-remote-fd

Needs a bit of usage illustration (this does not seem to come with any
documentation nor tests).

* zl/mailinfo-recode-patch (2010-06-14) 2 commits
 - add --recode-patch option to git-am
 - add --recode-patch option to git-mailinfo

I recall there was another round of re-roll planned for this one.

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

* ks/recursive-rename-add-identical (2010-09-01) 1 commit
  (merged to 'next' on 2010-09-03 at 1a5082f)
 + RE: [PATCH] Avoid rename/add conflict when contents are identical

* po/sendemail (2010-09-06) 3 commits
  (merged to 'next' on 2010-09-10 at d39274d)
 + New send-email option smtpserveroption.
 + Remove @smtp_host_parts variable as not used.
 + Minor indentation fix.

* ch/filter-branch-deprecate-remap-to-ancestor (2010-08-27) 1 commit
  (merged to 'next' on 2010-09-10 at f91d974)
 + filter-branch: retire --remap-to-ancestor

* ch/maint-cannot-create-bundle-error (2010-08-27) 1 commit
  (merged to 'next' on 2010-09-10 at ba139f1)
 + bundle: detect if bundle file cannot be created

* rr/format-patch-count-without-merges (2010-08-28) 2 commits
  (merged to 'next' on 2010-09-10 at c23bd48)
 + format-patch: Don't go over merge commits
 + t4014-format-patch: Call test_tick before committing

* as/daemon-multi-listen (2010-08-29) 2 commits
  (merged to 'next' on 2010-09-10 at 69e4b23)
 + daemon: allow more than one host address given via --listen
 + daemon: add helper function setup_named_sock()

I think the idea is sound.  It came a bit late in the cycle for the next
release and probably needs a bit more polish.

* jc/pickaxe-grep (2010-08-31) 4 commits
  (merged to 'next' on 2010-09-10 at 3604fc3)
 + diff/log -G<pattern>: tests
 + git log/diff: add -G<regexp> that greps in the patch text
 + diff: pass the entire diff-options to diffcore_pickaxe()
 + gitdiffcore doc: update pickaxe description

This is a re-roll of "grepping inside the log -p output" which is a
feature that is often asked for when people hear about -S option.

* jl/fetch-submodule-recursive (2010-08-30) 2 commits
  (merged to 'next' on 2010-09-10 at 67a5138)
 + Submodules: Add the new "fetch" config option for fetch and pull
 + fetch/pull: Recursively fetch populated submodules

I think the idea is sound and hopefully the end result will help the heavy
users of subprojects.  It came a bit late in the cycle for the next
release, though.

* en/object-list-with-pathspec (2010-08-26) 2 commits
 - Make rev-list --objects work together with pathspecs
 - Add testcases showing how pathspecs are ignored with rev-list --objects

* jf/merge-ignore-ws (2010-08-26) 4 commits
 - merge-recursive: options to ignore whitespace changes
 - merge-recursive --patience
 - ll-merge: replace flag argument with options struct
 - merge-recursive: expose merge options for builtin merge

I think the idea is sound.  It came a bit late in the cycle for the next
release, though.

* rr/fmt-merge-msg (2010-09-08) 5 commits
  (merged to 'next' on 2010-09-10 at 40fe79e)
 + t6200-fmt-merge-msg: Exercise '--log' to configure shortlog length
 + t6200-fmt-merge-msg: Exercise 'merge.log' to configure shortlog length
 + merge: Make 'merge.log' an integer or boolean option
 + merge: Make '--log' an integer option for number of shortlog entries
 + fmt_merge_msg: Change fmt_merge_msg API to accept shortlog_len

* tr/merge-unborn-clobber (2010-08-22) 1 commit
 - Exhibit merge bug that clobbers index&WT

* en/tree-walk-optim (2010-08-26) 4 commits
  (merged to 'next' on 2010-09-10 at 65a9cde)
 + diff_tree(): Skip skip_uninteresting() when all remaining paths interesting
 + tree_entry_interesting(): Make return value more specific
 + tree-walk: Correct bitrotted comment about tree_entry()
 + Document pre-condition for tree_entry_interesting

I think the idea is sound.  For a patch that touches fairly core part of
the system, it came a bit late in the cycle, though.

* cb/ignored-paths-are-precious (2010-08-21) 1 commit
 - checkout/merge: optionally fail operation when ignored files need to be overwritten

I fixed up a trivial error in the configuration parser (which didn't
return immediately after parsing), and while at it flipped the default 
value of the configuration and the command line option to false.

This probably needs tests; also we know of longstanding bugs in related
area that needs to be addressed---they do not have to be part of this
series but their reproduction recipe would belong to the test script for
this topic.

It may hurt users to make the new feature on by default, especially the
ones with subdirectories that come and go.  For a patch that changes a
long established semantics, it came a bit late in the cycle, so it will
have to wait until the next release.

* po/etc-gitattributes (2010-09-01) 1 commit
  (merged to 'next' on 2010-09-10 at c503fd5)
 + Add global and system-wide gitattributes

I think the idea is sound.  For a patch that touches fairly core part of
the system, it came a bit late in the cycle, though.

* gb/shell-ext (2010-08-27) 6 commits
  (merged to 'next' on 2010-08-27 at e1ef3c1)
 + shell: Display errors from improperly-formatted command lines
 + Merge branch 'gb/split-cmdline-errmsg' into gb/shell-ext
  (merged to 'next' on 2010-08-24 at 49ea7b8)
 + shell: Rewrite documentation and improve error message
 + Add sample commands for git-shell
 + Add interactive mode to git-shell for user-friendliness
 + Allow creation of arbitrary git-shell commands

I am not very happy about adding these backdoors to git-shell, which is
primarily a security mechanism, and obviously security and backdoor do not
mix well.

* ab/i18n (2010-09-09) 94 commits
 - po/hi.po: add Hindi Translation
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
 - gettext: add GETTEXT_POISON tests for shell scripts
 - gettext: add GETTEXT_POISON support for shell scripts
 - Makefile: MSGFMT="msgfmt --check" under GNU_GETTEXT
 - Makefile: add GNU_GETTEXT, set when we expect GNU gettext
 - po/de.po: make the German translation msgfmt --check clean
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
 - po/en_GB.po: add British English Translation
 - po/de.po: add German translation
 - gettextize: git-status shortstatus messages
 - gettextize: git-status basic messages
 - gettextize: git-push basic messages
 - gettextize: git-tag tag_template message
 - gettextize: git-tag basic messages
 - gettextize: git-reset reset_type_names messages
 - gettextize: git-reset basic messages
 - gettextize: git-rm basic messages
 - gettextize: git-mv "bad" messages
 - gettextize: git-mv basic messages
 - gettextize: git-merge basic messages
 - gettextize: git-log basic messages
 - gettextize: git-grep basic messages
 - gettextize: git-fetch split up "(non-fast-forward)" message
 - gettextize: git-fetch update_local_ref messages
 - gettextize: git-fetch formatting messages
 - gettextize: git-fetch basic messages
 - gettextize: git-diff basic messages
 - gettextize: git-commit advice messages
 - gettextize: git-commit formatting messages
 - gettextize: git-commit basic messages
 - gettextize: git-checkout "Switched to a .. branch" message
 - gettextize: git-checkout describe_detached_head messages
 - gettextize: git-checkout basic messages
 - gettextize: git-checkout: our/their version message
 - gettextize: git-branch "(no branch)" message
 - gettextize: git-branch "git branch -v" messages
 - gettextize: git-branch "remote branch '%s' not found" message
 - gettextize: git-branch basic messages
 - gettextize: git-add refresh_index message
 - gettextize: git-add basic messages
 - gettextize: git-clone "Cloning into" message
 - gettextize: git-clone basic messages
 - gettext tests: skip breaking tests under GETTEXT_POISON
 - gettext tests: skip lib-gettext.sh tests under GETTEXT_POISON
 - gettext tests: add GETTEXT_POISON=YesPlease Makefile parameter
 - gettext docs: add po/README file documenting Git's gettext
 - gettext tests: remove old sanity test under NO_GETTEXT
 - gettext tests: test message re-encoding under C
 - po/pl.po: add Polish translation
 - po/is.po: add Icelandic translation
 - po/is.po: msgmerge and add Language: header
 - gettext tests: mark a test message as not needing translation
 - gettext tests: test re-encoding with a UTF-8 msgid under Shell
 - gettext tests: test message re-encoding under Shell
 - gettext tests: add detection for is_IS.ISO-8859-1 locale
 - gettext tests: update test/is.po to match t/t0200/test.c
 - gettext tests: test if $VERSION exists before using it
 - gettext.c: work around us not using setlocale(LC_CTYPE, "")
 - gettext: localize the main git-init message
 - gettext: make the simple parts of git-init localizable
 - builtin.h: Include gettext.h
 - Makefile: use variables and shorter lines for xgettext
 - Makefile: tell xgettext(1) that our source is in UTF-8
 - Makefile: provide a --msgid-bugs-address to xgettext(1)
 - Makefile: A variable for options used by xgettext(1) calls
 - tests: locate i18n lib&data correctly under --valgrind
 - gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
 - tests: rename test to work around GNU gettext bug
 - Add infrastructure for translating Git with gettext
 - builtin: use builtin.h for all builtin commands
