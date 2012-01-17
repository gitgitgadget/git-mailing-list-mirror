From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2012, #04; Mon, 16)
Date: Mon, 16 Jan 2012 19:27:49 -0800
Message-ID: <7vk44rt3d6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 04:28:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmzig-0005Of-Ck
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 04:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911Ab2AQD1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 22:27:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab2AQD1w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 22:27:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BCCB651D;
	Mon, 16 Jan 2012 22:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=RqgdmO69HT8DURobJWhlYViXz
	yE=; b=FR+wGOO6L1gQ1/V3vzl5NaJlW0CUuva3Bb2P8ep2Ruzm/V4MxVrzqyznZ
	sp+Fboudiv223TusoDbNTgGZ+4QqqRR0cUPPBdPfB/hkobdz8+mzG9AxowgyjAxL
	hGA5nQxNKvLqc7Ya2+tIXpH56y2c9ybpgst7JKVB2r+UVePcL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=w+lR1EggEPbedXzDtIn
	nz+sh1+l+T7s/d9wF15UoS6B2s14OHd6L+y6WLhPJ3S7Ko1is+txU+CXHAMIN9KI
	Ir92uMZZcDLFIlimKh4DKHuc45n29aSSAgwhaL3cjpEcp5nv2oXRbBsYCsj2NFLr
	+JzjCwxwHvPyirD09912mxVQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92F78651C;
	Mon, 16 Jan 2012 22:27:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6281651B; Mon, 16 Jan 2012
 22:27:50 -0500 (EST)
X-master-at: b63103e908af54e5e2eaa3faad350e4738ef0047
X-next-at: 01892647622b2d0497b1bd74eff0113b8e0abc5c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C00A08A-40BB-11E1-89DB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188682>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

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

* mh/maint-show-ref-doc (2012-01-13) 2 commits
  (merged to 'next' on 2012-01-16 at 8573f09)
 + git-show-ref doc: typeset regexp in fixed width font
 + git-show-ref: fix escaping in asciidoc source

Will merge to 'master' by v1.7.9-rc2.

* nd/pathspec-recursion-cleanup (2012-01-16) 2 commits
  (merged to 'next' on 2012-01-16 at 0189264)
 + diff-index: enable recursive pathspec matching in unpack_trees
 + Document limited recursion pathspec matching with wildcards

Will merge to 'master' by v1.7.9-rc2.

* tr/maint-word-diff-incomplete-line (2012-01-12) 1 commit
  (merged to 'next' on 2012-01-16 at 58ddaaf)
 + word-diff: ignore '\ No newline at eof' marker

Will merge to 'master' by v1.7.9-rc2.

--------------------------------------------------
[Graduated to "master"]

* jc/request-pull-show-head-4 (2012-01-10) 1 commit
  (merged to 'next' on 2012-01-11 at 8d98a6b)
 + request-pull: use the real fork point when preparing the message

Hopefully the final finishing touch to the request-pull script that was
updated during this cycle.

* jk/maint-upload-archive (2012-01-11) 1 commit
  (merged to 'next' on 2012-01-11 at 5c0bfa9)
 + archive: re-allow HEAD:Documentation on a remote invocation

Running "git archive" remotely and asking for a partial tree of a ref,
e.g. HEAD:$path was forbidden by a recent change to tighten security, b=
ut
was found to be overly restrictive.

* jn/maint-gitweb-grep-fix (2012-01-05) 2 commits
  (merged to 'next' on 2012-01-13 at a15e6ab)
 + gitweb: Harden "grep" search against filenames with ':'
 + gitweb: Fix file links in "grep" search

* ss/maint-msys-cvsexportcommit (2012-01-11) 2 commits
  (merged to 'next' on 2012-01-11 at 007aab1)
 + git-cvsexportcommit: Fix calling Perl's rel2abs() on MSYS
 + t9200: On MSYS, do not pass Windows-style paths to CVS

--------------------------------------------------
[Stalled]

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so that
somebody new can try to dip his or her toes in the development. Any
takers?

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
series to be usable locally, and then index-pack/unpack-objects needs t=
o
learn it to be used remotely.

--------------------------------------------------
[Cooking]

* jc/pull-signed-tag (2012-01-11) 1 commit
 - merge: use editor by default in interactive sessions

Per Linus's strong suggestion, sugarcoated (aka "taking blame for the
original UI screw-ups") so that it is easier for me to swallow and acce=
pt
a potentially huge backward incompatibility issue, "git merge" is made =
to
launch an editor to explain the merge in the merge commit by default in
interactive sessions.

May need renaming the backward compatibility "GIT_MERGE_LEGACY"
environment variable, and also will need a smoother migration plan.

Will defer till the next cycle.

* nd/commit-ignore-i-t-a (2012-01-16) 2 commits
 - commit, write-tree: allow to ignore CE_INTENT_TO_ADD while writing t=
rees
 - cache-tree: update API to take abitrary flags

May want to consider this as fixing an earlier UI mistake, and not as a
feature that devides the userbase.

Will defer till the next cycle.

* nd/maint-refname-in-hierarchy-check (2012-01-11) 1 commit
 - Fix incorrect ref namespace check

Avoid getting confused by "ref/headxxx" and mistaking it as if it is un=
der
the "refs/heads/" hierarchy.
Not urgent.

* jc/advise-i18n (2011-12-22) 1 commit
 - i18n of multi-line advice messages

Allow localization of advice messages that tend to be longer and
multi-line formatted. For now this is deliberately limited to advise()
interface and not vreportf() in general as touching the latter has
interactions with error() that has plumbing callers whose prefix "error=
: "
should never be translated.
Not urgent.

* rr/sequencer (2012-01-11) 2 commits
 - sequencer: factor code out of revert builtin
 - revert: prepare to move replay_action to header

Moving large chunk of code out of cherry-pick/revert for later reuse,
primarily to prepare for the next cycle.
Not urgent.

* tr/maint-mailinfo (2012-01-16) 2 commits
 - mailinfo: with -b, keep space after [foo]
 - am: learn passing -b to mailinfo

Looked reasonable.
Not urgent.

* jk/credentials (2012-01-11) 3 commits
  (merged to 'next' on 2012-01-16 at 1c6c94a)
 + unix-socket: do not let close() or chdir() clobber errno during clea=
nup
 + credential-cache: report more daemon connection errors
 + unix-socket: handle long socket pathnames

Minor fix-ups to the new feature.
Will merge to 'master' by v1.7.9-rc2.

* pw/p4-view-updates (2012-01-11) 5 commits
 - git-p4: add tests demonstrating spec overlay ambiguities
 - git-p4: adjust test to adhere to stricter useClientSpec
 - git-p4: clarify comment
 - git-p4: fix verbose comment typo
 - git-p4: only a single ... wildcard is supported

* rs/diff-postimage-in-context (2012-01-06) 1 commit
  (merged to 'next' on 2012-01-09 at 9635032)
 + xdiff: print post-image for common records instead of pre-image

Looked reasonable.
Not urgent.

* cb/push-quiet (2012-01-08) 3 commits
 - t5541: avoid TAP test miscounting
 - fix push --quiet: add 'quiet' capability to receive-pack
 - server_supports(): parse feature list more carefully

Looked reasonable.
Not urgent.

* nd/clone-detached (2012-01-16) 10 commits
 - clone: print advice on checking out detached HEAD
 - clone: allow --branch to take a tag
 - clone: refuse to clone if --branch points to bogus ref
 - clone: --branch=3D<branch> always means refs/heads/<branch>
 - clone: delay cloning until after remote HEAD checking
 - clone: factor out remote ref writing
 - clone: factor out HEAD update code
 - clone: factor out checkout code
 - clone: write detached HEAD in bare repositories
 - t5601: add missing && cascade
 (this branch uses nd/clone-single-branch.)

Looking good.
Not urgent.

* nd/clone-single-branch (2012-01-08) 1 commit
  (merged to 'next' on 2012-01-09 at 6c3c759)
 + clone: add --single-branch to fetch only one branch
 (this branch is used by nd/clone-detached.)

Looked reasonable.
Not urgent.

* jn/gitweb-unspecified-action (2012-01-09) 1 commit
 - gitweb: Fix actionless dispatch for non-existent objects

Looked reasonable.
Not urgent.

* nd/index-pack-no-recurse (2012-01-16) 3 commits
 - index-pack: eliminate unlimited recursion in get_base_data()
 - index-pack: eliminate recursion in find_unresolved_deltas
 - Eliminate recursion in setting/clearing marks in commit list

Much better explained than the previous round.
Will defer till the next cycle.

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
 - names_conflict(): new function, extracted from is_refname_available(=
)
 - repack_without_ref(): reimplement using do_for_each_ref_in_array()
 - do_for_each_ref_in_arrays(): new function
 - do_for_each_ref_in_array(): new function
 - do_for_each_ref(): correctly terminate while processesing extra_refs

The API for extra anchoring points may require rethought first; that wo=
uld
hopefully make the "ref" part a lot simpler. And that is happening in
another topic (which has graduated to 'master').

Will defer till the next cycle.

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
  (merged to 'next' on 2012-01-05 at 954f125)
 + perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments from
=C3=86var. The second one needs more work, both in perl/Git.pm and prom=
pt.c, to
give precedence to tty over SSH_ASKPASS when terminal is available.

Will defer till the next cycle.

* cb/git-daemon-tests (2012-01-08) 5 commits
  (merged to 'next' on 2012-01-08 at 1db8351)
 + git-daemon tests: wait until daemon is ready
 + git-daemon: produce output when ready
 + git-daemon: add tests
 + dashed externals: kill children on exit
 + run-command: optionally kill children on exit

Will defer till the next cycle.

* jk/parse-object-cached (2012-01-06) 3 commits
  (merged to 'next' on 2012-01-08 at 8c6fa4a)
 + upload-pack: avoid parsing tag destinations
 + upload-pack: avoid parsing objects during ref advertisement
 + parse_object: try internal cache before reading object db

These are a bit scary changes, but I do think they are worth doing.
Will defer till the next cycle.
