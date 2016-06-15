From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2011, #08; Thu, 22)
Date: Thu, 22 Dec 2011 12:59:25 -0800
Message-ID: <7vobv0cogi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 21:59:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rdpjx-0000Re-58
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 21:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab1LVU7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 15:59:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945Ab1LVU73 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 15:59:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 635AD638A;
	Thu, 22 Dec 2011 15:59:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	zU7HNyDe2LzDNn6pxcknm0Es+k=; b=KvG/+z9kwvxpLJch3IeJr4jQapNCVs2kT
	sPZ+hQ3wbrJifPvdEW8F8uTycLoHRNAd/7P06aTdSfy5cBAx+qriaWMHOH7uKcFA
	xIrXpv8Tp1GW2BZVv63935HxggkiGbSF4Vy+ExuQDb71y0GuSisVaS3qTxsNZT0M
	wooiN0kgJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ADW
	0OOclmscyScWS3tq168c7ILJv7+DaHglbRDCkV4xruZhSiIiiPKOTDIl15DR+OqT
	VQVkM3V9kEZOaaZF23Ri9GpPqiTkzU8SggvW5PqPq2H4exJUvfW3qujbGNraNEdF
	bFDV+Yzy7coEwD2s30ehebFKtBOexShuTNYUmJqQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A4D16389;
	Thu, 22 Dec 2011 15:59:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63FFE6388; Thu, 22 Dec 2011
 15:59:27 -0500 (EST)
X-master-at: 5d6dfc7cb140a6eb90138334fab2245b69bc8bc4
X-next-at: 7d1ccddcec7e93d27acda459c41e32851e845d51
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5CDDA7E-2CDF-11E1-AAF0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187616>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

The tip of 'master' is now feature complete for 1.7.9 so I could tag it as
the -rc0, but I'll let it simmer for several days to give people chance to
test over the holidays.

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
[New Topics]

* tr/doc-sh-setup (2011-12-20) 1 commit
  (merged to 'next' on 2011-12-21 at bd73695)
 + git-sh-setup: make require_clean_work_tree part of the interface

* ab/sun-studio-portability (2011-12-21) 3 commits
  (merged to 'next' on 2011-12-21 at 0cc5a63)
 + Appease Sun Studio by renaming "tmpfile"
 + Fix a bitwise negation assignment issue spotted by Sun Studio
 + Fix an enum assignment issue spotted by Sun Studio

* tr/bash-read-unescaped (2011-12-21) 1 commit
  (merged to 'next' on 2011-12-21 at de865c1)
 + bash completion: use read -r everywhere

* jc/advise-i18n (2011-12-22) 1 commit
 - i18n of multi-line advice messages

Allow localization of advice messages that tend to be longer and
multi-line formatted. For now this is deliberately limited to advise()
interface and not vreportf() in general as touching the latter has
interactions with error() that has plumbing callers whose prefix "error: "
should never be translated.

--------------------------------------------------
[Graduated to "master"]

* cn/maint-lf-to-crlf-filter (2011-12-16) 1 commit
  (merged to 'next' on 2011-12-20 at 83d6f7c)
 + lf_to_crlf_filter(): tell the caller we added "\n" when draining
 (this branch is used by jc/maint-lf-to-crlf-keep-crlf.)

A recent fix to the codepath was not quite correct.

* ef/setenv-putenv (2011-12-14) 2 commits
  (merged to 'next' on 2011-12-20 at 4845020)
 + compat/setenv.c: error if name contains '='
 + compat/setenv.c: update errno when erroring out
 (this branch is used by ef/x-setenv-putenv.)

* jc/advice-doc (2011-12-18) 1 commit
  (merged to 'next' on 2011-12-19 at 0b410e5)
 + advice: Document that they all default to true
 (this branch is used by jc/advise-push-default.)

* jc/maint-lf-to-crlf-keep-crlf (2011-12-18) 1 commit
  (merged to 'next' on 2011-12-20 at eee6eb3)
 + lf_to_crlf_filter(): resurrect CRLF->CRLF hack

The lf-to-crlf filter in the streaming checkout codepath forgot that we
try not to convert LF to CRLF if the repository data already has CRLF.

* jc/request-pull-show-head-4 (2011-12-19) 2 commits
  (merged to 'next' on 2011-12-19 at 771939b)
 + request-pull: do not emit "tag" before the tagname
  (merged to 'next' on 2011-12-16 at bea51ac)
 + request-pull: update the "pull" command generation logic

* jk/doc-fsck (2011-12-16) 1 commit
  (merged to 'next' on 2011-12-20 at 70df8a4)
 + docs: brush up obsolete bits of git-fsck manpage

* jk/follow-rename-score (2011-12-16) 1 commit
  (merged to 'next' on 2011-12-20 at 74db2a9)
 + use custom rename score during --follow

* jk/git-prompt (2011-12-12) 10 commits
  (merged to 'next' on 2011-12-20 at 24aff90)
 + contrib: add credential helper for OS X Keychain
 + Makefile: OS X has /dev/tty
 + Makefile: linux has /dev/tty
 + credential: use git_prompt instead of git_getpass
 + prompt: use git_terminal_prompt
 + add generic terminal prompt function
 + refactor git_getpass into generic prompt function
 + move git_getpass to its own source file
 + imap-send: don't check return value of git_getpass
 + imap-send: avoid buffer overflow

* jk/http-push-to-empty (2011-12-19) 1 commit
  (merged to 'next' on 2011-12-19 at 845e2a1)
 + remote-curl: don't pass back fake refs

* jk/maint-do-not-feed-stdin-to-tests (2011-12-15) 1 commit
  (merged to 'next' on 2011-12-20 at 43e83c5)
 + test-lib: redirect stdin of tests

* jk/maint-push-v-is-verbose (2011-12-17) 1 commit
  (merged to 'next' on 2011-12-20 at b79f101)
 + make "git push -v" actually verbose

* jk/maint-strbuf-missing-init (2011-12-18) 2 commits
  (merged to 'next' on 2011-12-20 at 72fa8ae)
 + Update jk/maint-strbuf-missing-init to builtin/ rename
 + commit, merge: initialize static strbuf

* jk/pretty-reglog-ent (2011-12-16) 1 commit
  (merged to 'next' on 2011-12-20 at 949b010)
 + pretty: give placeholders to reflog identity

* jn/test-cleanup-7006 (2011-12-14) 1 commit
  (merged to 'next' on 2011-12-20 at 952f48f)
 + test: errors preparing for a test are not special

* mh/ref-api (2011-12-12) 16 commits
  (merged to 'next' on 2011-12-15 at d65a830)
 + add_ref(): take a (struct ref_entry *) parameter
 + create_ref_entry(): extract function from add_ref()
 + repack_without_ref(): remove temporary
 + resolve_gitlink_ref_recursive(): change to work with struct ref_cache
 + Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
 + resolve_gitlink_ref(): improve docstring
 + get_ref_dir(): change signature
 + refs: change signatures of get_packed_refs() and get_loose_refs()
 + is_dup_ref(): extract function from sort_ref_array()
 + add_ref(): add docstring
 + parse_ref_line(): add docstring
 + is_refname_available(): remove the "quiet" argument
 + clear_ref_array(): rename from free_ref_array()
 + refs: rename parameters result -> sha1
 + refs: rename "refname" variables
 + struct ref_entry: document name member
 (this branch is used by mh/ref-api-rest.)

Later part split out to expedite moving the earlier good bits forward.

* nd/war-on-nul-in-commit (2011-12-15) 3 commits
  (merged to 'next' on 2011-12-20 at d441111)
 + commit_tree(): refuse commit messages that contain NULs
 + Convert commit_tree() to take strbuf as message
 + merge: abort if fails to commit

* rs/diff-tree-combined-clean-up (2011-12-17) 3 commits
  (merged to 'next' on 2011-12-20 at 265e049)
 + submodule: use diff_tree_combined_merge() instead of diff_tree_combined()
 + pass struct commit to diff_tree_combined_merge()
 + use struct sha1_array in diff_tree_combined()

* tr/grep-threading (2011-12-16) 3 commits
  (merged to 'next' on 2011-12-20 at 1a852ef)
 + grep: disable threading in non-worktree case
 + grep: enable threading with -p and -W using lazy attribute lookup
 + grep: load funcname patterns for -W

--------------------------------------------------
[Stalled]

* pw/p4-docs-and-tests (2011-12-18) 11 commits
 - git-p4: document and test submit options
 - git-p4: test and document --use-client-spec
 - git-p4: test --keep-path
 - git-p4: test --max-changes
 - git-p4: document and test --import-local
 - git-p4: honor --changesfile option and test
 - git-p4: document and test clone --branch
 - git-p4: test cloning with two dirs, clarify doc
 - git-p4: clone does not use --git-dir
 - git-p4: test debug macro
 - git-p4: introduce asciidoc documentation

Waiting for a reroll.

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=upstream when appropriate

Peff had a good suggestion outlining an updated code structure so that
somebody new can try to dip his or her toes in the development. Any
takers?

Waiting for a reroll.

* mh/ref-api-rest (2011-12-12) 35 commits
 - repack_without_ref(): call clear_packed_ref_cache()
 - read_packed_refs(): keep track of the directory being worked in
 - is_refname_available(): query only possibly-conflicting references
 - refs: read loose references lazily
 - read_loose_refs(): take a (ref_entry *) as argument
 - struct ref_dir: store a reference to the enclosing ref_cache
 - sort_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 - do_for_each_ref_in_dir*(): take (ref_entry *) instead of (ref_dir *)
 - add_entry(): take (ref_entry *) instead of (ref_dir *)
 - search_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 - find_containing_direntry(): use (ref_entry *) instead of (ref_dir *)
 - add_ref(): take (ref_entry *) instead of (ref_dir *)
 - read_packed_refs(): take (ref_entry *) instead of (ref_dir *)
 - find_ref(): take (ref_entry *) instead of (ref_dir *)
 - is_refname_available(): take (ref_entry *) instead of (ref_dir *)
 - get_loose_refs(): return (ref_entry *) instead of (ref_dir *)
 - get_packed_refs(): return (ref_entry *) instead of (ref_dir *)
 - refs: wrap top-level ref_dirs in ref_entries
 - get_ref_dir(): keep track of the current ref_dir
 - do_for_each_ref(): only iterate over the subtree that was requested
 - refs: sort ref_dirs lazily
 - sort_ref_dir(): do not sort if already sorted
 - refs: store references hierarchically
 - refs.c: rename ref_array -> ref_dir
 - struct ref_entry: nest the value part in a union
 - check_refname_component(): return 0 for zero-length components
 - free_ref_entry(): new function
 - refs.c: reorder definitions more logically
 - is_refname_available(): reimplement using do_for_each_ref_in_array()
 - names_conflict(): simplify implementation
 - names_conflict(): new function, extracted from is_refname_available()
 - repack_without_ref(): reimplement using do_for_each_ref_in_array()
 - do_for_each_ref_in_arrays(): new function
 - do_for_each_ref_in_array(): new function
 - do_for_each_ref(): correctly terminate while processesing extra_refs

The API for extra anchoring points may require rethought first; that would
hopefully make the "ref" part a lot simpler.

Waiting for a reroll.

* jc/split-blob (2011-12-01) 6 commits
 . WIP (streaming chunked)
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

Not ready.

At least pack-objects and fsck need to learn the new encoding for the
series to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

--------------------------------------------------
[Cooking]

* jn/maint-gitweb-utf8-fix (2011-12-19) 4 commits
  (merged to 'next' on 2011-12-20 at b816812)
 + gitweb: Fix fallback mode of to_utf8 subroutine
 + gitweb: Output valid utf8 in git_blame_common('data')
 + gitweb: esc_html() site name for title in OPML
 + gitweb: Call to_utf8() on input string in chop_and_escape_str()

* tr/pty-all (2011-12-19) 1 commit
  (merged to 'next' on 2011-12-20 at 9b637d3)
 + test-terminal: set output terminals to raw mode

Kept only the second one from the original.

* rr/revert-cherry-pick (2011-12-15) 6 commits
  (merged to 'next' on 2011-12-21 at d0428dc)
 + t3502, t3510: clarify cherry-pick -m failure
 + t3510 (cherry-pick-sequencer): use exit status
 + revert: simplify getting commit subject in format_todo()
 + revert: tolerate extra spaces, tabs in insn sheet
 + revert: make commit subjects in insn sheet optional
 + revert: free msg in format_todo()

* jc/signed-commit (2011-11-29) 5 commits
  (merged to 'next' on 2011-12-21 at 8fcbf00)
 + gpg-interface: allow use of a custom GPG binary
 + pretty: %G[?GS] placeholders
 + test "commit -S" and "log --show-signature"
 + log: --show-signature
 + commit: teach --gpg-sign option

* jc/push-ignore-stale (2011-12-14) 2 commits
 - push: --ignore-stale option
 - set_ref_status_for_push(): use transport-flags abstraction

Probably solving a wrong problem and encouraging a wrong workflow while at
it. jc/advise-push-default might be a better approach.

Will drop.
