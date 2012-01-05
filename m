From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2012, #01; Thu, 5)
Date: Thu, 05 Jan 2012 13:55:47 -0800
Message-ID: <7vaa61n7a4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 22:55:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RivHw-0005b6-Sy
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 22:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932869Ab2AEVzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 16:55:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299Ab2AEVzv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 16:55:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3159D6D24;
	Thu,  5 Jan 2012 16:55:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=u1cV83uKWratpoQ/yrhmw1lNO
	ug=; b=uJ2APlZTFzr/Pztuw8e3YbqKQ/Z4O9b3vtsFRyFI0rcgisQyC9QZv/+Vy
	yushb/jFfEQ0Q1g7ksA1bG5wm3OdIDfYxKjwLAl81gx6vzcQS9BbsOvEN+NMtn6+
	BoZmdj60U5oSygd6MJ9HuWp2se2PTuhp3FkhjaHvRISl7WQBFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=xYZk72gFA9imAhlezNJ
	tGY3eJMy41K/4clUVmlTMYUWdm9Q2ctROkvmHL7ED9o8Au6qxtIVL4mu1mlbvkFS
	oNWTB57W3bph/P+aijDGDgzCOoSAC4mHKyige01deA2uWnGxsH+1TICtAbIt321Q
	RhsYHCdTvGKszaW6oqmNxJhU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27F0A6D23;
	Thu,  5 Jan 2012 16:55:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 209A26D22; Thu,  5 Jan 2012
 16:55:49 -0500 (EST)
X-master-at: 247f9d23da8cfd255533433ad2aa07d172afac0b
X-next-at: 5da3ae2f29b4c8b897e934b1856cbb7753383aee
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0740606E-37E8-11E1-BABC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187999>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

I'll be tagging 1.7.9-rc0 after merging a few topics to "master" to mak=
e
it feature complete for the upcoming release tomorrow.

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

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
  (merged to 'next' on 2012-01-05 at 954f125)
 + perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments from
=C3=86var. The second one needs more work, both in perl/Git.pm and prom=
pt.c, to
give precedence to tty over SSH_ASKPASS when terminal is available.

I think it is OK to include the first one in the upcoming release, but =
we
may want to wait and defer both to the next cycle.

* pw/p4-view-updates (2012-01-03) 6 commits
  (merged to 'next' on 2012-01-03 at c3b5872)
 + git-p4: view spec documentation
 + git-p4: rewrite view handling
 + git-p4: support single file p4 client view maps
 + git-p4: sort client views by reverse View number
 + git-p4: fix test for unsupported P4 Client Views
 + git-p4: test client view handling

Will merge to 'master' by 1.7.9 final.
Unless real git-p4 users object (I am not one of them, so I cannot real=
ly
judge), that is.

* cb/git-daemon-tests (2012-01-04) 1 commit
  (merged to 'next' on 2012-01-05 at 86f3e93)
 + daemon: add tests

It stirred a related discussion on how the process termination should b=
e
handled in the daemon, but the test queued should be OK as-is on system=
s
that have "pkill" (which is outside POSIX).

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

Will merge to 'master' by 1.7.9 final.

* jm/stash-diff-disambiguate (2012-01-01) 1 commit
  (merged to 'next' on 2012-01-05 at 75a283b)
 + stash: Don't fail if work dir contains file named 'HEAD'

Will merge to 'master' by 1.7.9 final.

* mm/maint-gitweb-project-maxdepth (2012-01-04) 1 commit
 - gitweb: accept trailing "/" in $project_list

Looked quite sensible.
Will merge to 'master' by 1.7.9 final.

* nd/shallow-clone-without-tag-following (2012-01-05) 1 commit
 - Limit refs to fetch to minimum in shallow clones

Needs adjustment of t5500 at least, and possibly an option to ask for t=
he
traditional "shallowly clone all branches" behaviour.

* jk/parse-object-cached (2012-01-05) 1 commit
 - parse_object: try internal cache before reading object db

This is a bit scary change, but I do not think of a way it would break
anything that is currently working correctly.

* jn/maint-gitweb-grep-fix (2012-01-05) 2 commits
 - gitweb: Harden "grep" search against filenames with ':'
 - gitweb: Fix file links in "grep" search

Waiting for a confirmation from bug reporter.

--------------------------------------------------
[Graduated to "master"]

* jv/maint-config-set (2011-12-27) 1 commit
  (merged to 'next' on 2011-12-27 at 551ac8f)
 + Fix an incorrect reference to --set-all.

* pw/p4-docs-and-tests (2011-12-27) 11 commits
  (merged to 'next' on 2011-12-28 at 8acf26e)
 + git-p4: document and test submit options
 + git-p4: test and document --use-client-spec
 + git-p4: test --keep-path
 + git-p4: test --max-changes
 + git-p4: document and test --import-local
 + git-p4: honor --changesfile option and test
 + git-p4: document and test clone --branch
 + git-p4: test cloning with two dirs, clarify doc
 + git-p4: clone does not use --git-dir
 + git-p4: introduce asciidoc documentation
 + rename git-p4 tests

--------------------------------------------------
[Stalled]

* bw/maint-t8006-sed-incomplete-line (2012-01-03) 1 commit
 - Work around sed portability issue in t8006-blame-textconv

Waiting for a clarification of the reasoning in the log message.

* nd/index-pack-no-recurse (2011-12-27) 4 commits
 - fixup! 3413d4d
 - index-pack: eliminate unlimited recursion in get_delta_base()
 - index-pack: eliminate recursion in find_unresolved_deltas
 - Eliminate recursion in setting/clearing marks in commit list

Expecting a reroll.

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

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
 - names_conflict(): new function, extracted from is_refname_available(=
)
 - repack_without_ref(): reimplement using do_for_each_ref_in_array()
 - do_for_each_ref_in_arrays(): new function
 - do_for_each_ref_in_array(): new function
 - do_for_each_ref(): correctly terminate while processesing extra_refs

The API for extra anchoring points may require rethought first; that wo=
uld
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

* jh/fetch-head-update (2012-01-03) 1 commit
  (merged to 'next' on 2012-01-04 at b5778e1)
 + write first for-merge ref to FETCH_HEAD first

Will merge to 'master' by 1.7.9 final.

* jc/signed-commit (2011-11-29) 5 commits
  (merged to 'next' on 2011-12-21 at 8fcbf00)
 + gpg-interface: allow use of a custom GPG binary
 + pretty: %G[?GS] placeholders
 + test "commit -S" and "log --show-signature"
 + log: --show-signature
 + commit: teach --gpg-sign option
 (this branch is used by jc/show-sig.)

The infrastructure this series adds is used by the finishing touches to
the earlier "pull signed tags" topic, so this will graduate to "master"
together with it when the latter matures, hopefully before 1.7.9 final.

--------------------------------------------------
[Discarded]

* ss/git-svn-askpass (2011-12-27) 5 commits
 - make askpass_prompt a global prompt method for asking users
 - ignore empty *_ASKPASS variables
 - honour *_ASKPASS for querying username and for querying further acti=
ons like unknown certificates
 - switch to central prompt method
 - add central method for prompting a user using GIT_ASKPASS or SSH_ASK=
PASS

This has become more about "prompt without terminal", and was rerolled
into a two-patch series, which is structured a lot nicer than this
original.
