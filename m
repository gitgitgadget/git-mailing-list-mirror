From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2012, #02; Mon, 9)
Date: Mon, 09 Jan 2012 16:50:30 -0800
Message-ID: <7vzkdwbctl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 01:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkPvD-0000cm-Uz
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 01:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933617Ab2AJAue convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 19:50:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63080 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933592Ab2AJAud convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 19:50:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B41836813;
	Mon,  9 Jan 2012 19:50:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=GoVvPqBzLFu+x7OxaUMjTFp48
	lU=; b=JZq/Hdb7YR5c0P6P0NN8+r5nQzvLeln8kNEuMt/goggQH+/PVS6OyPKaa
	5lxOwSVQDgNCU70Qmhjh96Z2g0h2ysDLPXXITJuNA7jkS3k2/RqjJRdaRs4rEBFp
	PBBp25F58z5+LN6/3Sh/LWLKLRTzA3ks5LzT6xHQLZ/F5QIU/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=M8dp1DCstst0F63JXsX
	Bjuz8T2kMfNMRNSXA/KmsEyUnyDc3UZpjO24wBqjBufhZNoh5yRJDo4Nj8OJj4C6
	Cm97Ye6FbYc3OHAI7Yi8ITfrx6SbebjgHLO6JwkYXK+Ou66HIK10DxIr8iV1W4Rl
	oAqwgeqaZ+IpjdJmEY0AtgS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A29206812;
	Mon,  9 Jan 2012 19:50:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C761C680F; Mon,  9 Jan 2012
 19:50:31 -0500 (EST)
X-master-at: beecc7ab65b31c5471331e64acaa3f722125ea67
X-next-at: 6c3c759d2442c2dca37be91f899570e1396d5bd5
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 191221B6-3B25-11E1-A090-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188204>

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

* nd/clone-detached (2012-01-08) 6 commits
 - clone: print advice on checking out detached HEAD
 - clone: allow --branch to take a tag
 - clone: --branch=3D<branch> always means refs/heads/<branch>
 - clone: factor out checkout code
 - clone: write detached HEAD in bare repositories
 - t5601: add missing && cascade

I am not sure what the benefit of this is.

* nd/clone-single-branch (2012-01-08) 1 commit
  (merged to 'next' on 2012-01-09 at 6c3c759)
 + clone: add --single-branch to fetch only one branch

Looked reasonable.
Not urgent.

* jn/gitweb-unspecified-action (2012-01-09) 1 commit
 - gitweb: Fix actionless dispatch for non-existent objects

--------------------------------------------------
[Graduated to "master"]

* jc/show-sig (2012-01-05) 6 commits
  (merged to 'next' on 2012-01-05 at 5da3ae2)
 + log --show-signature: reword the common two-head merge case
 + log-tree: show mergetag in log --show-signature output
 + log-tree.c: small refactor in show_signature()
 + commit --amend -S: strip existing gpgsig headers
 + verify_signed_buffer: fix stale comment
 + Merge branch 'jc/signed-commit' and 'jc/pull-signed-tag'
 (this branch uses jc/signed-commit.)

=46inishing touches to the already graduated "pull signed tags" topic.

* jc/signed-commit (2011-11-29) 5 commits
  (merged to 'next' on 2011-12-21 at 8fcbf00)
 + gpg-interface: allow use of a custom GPG binary
 + pretty: %G[?GS] placeholders
 + test "commit -S" and "log --show-signature"
 + log: --show-signature
 + commit: teach --gpg-sign option
 (this branch is used by jc/show-sig.)

* jh/fetch-head-update (2012-01-03) 1 commit
  (merged to 'next' on 2012-01-04 at b5778e1)
 + write first for-merge ref to FETCH_HEAD first

* jk/credentials (2012-01-08) 1 commit
  (merged to 'next' on 2012-01-08 at 48766c9)
 + credentials: unable to connect to cache daemon

* jm/stash-diff-disambiguate (2012-01-01) 1 commit
  (merged to 'next' on 2012-01-05 at 75a283b)
 + stash: Don't fail if work dir contains file named 'HEAD'

* mh/ref-api-less-extra-refs (2012-01-06) 3 commits
  (merged to 'next' on 2012-01-06 at 3105696)
 + write_head_info(): handle "extra refs" locally
 + show_ref(): remove unused "flag" and "cb_data" arguments
 + receive-pack: move more work into write_head_info()

* mm/maint-gitweb-project-maxdepth (2012-01-04) 1 commit
  (merged to 'next' on 2012-01-06 at bcf3818)
 + gitweb: accept trailing "/" in $project_list

Looked quite sensible.

* pw/p4-view-updates (2012-01-03) 6 commits
  (merged to 'next' on 2012-01-03 at c3b5872)
 + git-p4: view spec documentation
 + git-p4: rewrite view handling
 + git-p4: support single file p4 client view maps
 + git-p4: sort client views by reverse View number
 + git-p4: fix test for unsupported P4 Client Views
 + git-p4: test client view handling

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

* jc/advise-i18n (2011-12-22) 1 commit
 - i18n of multi-line advice messages

Allow localization of advice messages that tend to be longer and
multi-line formatted. For now this is deliberately limited to advise()
interface and not vreportf() in general as touching the latter has
interactions with error() that has plumbing callers whose prefix "error=
: "
should never be translated.

--------------------------------------------------
[Cooking]

* nd/index-pack-no-recurse (2012-01-09) 3 commits
 - index-pack: eliminate unlimited recursion in get_delta_base()
 - index-pack: eliminate recursion in find_unresolved_deltas
 - Eliminate recursion in setting/clearing marks in commit list

The first one looked sensible; I am not sure if the second and third on=
es
take the right approach.

* bw/maint-t8006-sed-incomplete-line (2012-01-03) 1 commit
 - Work around sed portability issue in t8006-blame-textconv

Waiting for a clarification of the reasoning in the log message.

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

* jn/maint-gitweb-grep-fix (2012-01-05) 2 commits
 - gitweb: Harden "grep" search against filenames with ':'
 - gitweb: Fix file links in "grep" search

Waiting for a confirmation from bug reporter.
