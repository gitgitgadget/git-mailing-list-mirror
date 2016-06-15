From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2012, #06; Fri, 27)
Date: Fri, 27 Jan 2012 13:43:45 -0800
Message-ID: <7v7h0czur2.fsf@alter.siamese.dyndns.org>
References: <7vipjwzvc2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 22:43:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqtaP-0006rn-11
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 22:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab2A0Vnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 16:43:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009Ab2A0Vnt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 16:43:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A09C66FED;
	Fri, 27 Jan 2012 16:43:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZLb5LFIVYYM5
	7AVc/ivWoL42/98=; b=ub5TOq+4dDwwsl6PaRkiJT+A8xzfCaLotosQ1B2V2Blb
	cyAxqAGVY+LQKod89L7tsNM9NJq4h3P9IZcuD+2R0d4nqZ0axD/CwNJGY3ABkAyU
	mUBOqh21knMZM5EtMx4ZQAN3UXsnDXYXOR4AgpPRlibpztr1hCas06OCepbAgFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cP1YkI
	jzSDKpG9FEyQn/D0AE5gQ95G8bsfmaCqdhAWgIUhPBdg/JZeA+laN5eCRQvKFWQU
	EdXtR/TalyDGmGznRK2saizh/meGDejAm776Ae+yqTSFXrTMT+SoVZZ2tW40SdFp
	Akejvpv/qW4t/CiyJ/yKr/bNHtkPX7wMQrt4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 988126FEC;
	Fri, 27 Jan 2012 16:43:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64F736FEB; Fri, 27 Jan 2012
 16:43:46 -0500 (EST)
X-master-at: 828ea97de486c1693d6e4f2c7347acb50235a85d
X-next-at: db81badb8172f91f47582d00408dd94bbe9b4d93
In-Reply-To: <7vipjwzvc2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 27 Jan 2012 13:31:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD90B236-492F-11E1-9DC1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189238>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

Now 1.7.9 is out, the development cycle for 1.7.10 will start shortly.

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

* jl/submodule-re-add (2012-01-24) 1 commit
  (merged to 'next' on 2012-01-26 at 482553e)
 + submodule add: fix breakage when re-adding a deep submodule

Low-impact fix to an old issue.=20
Will merge early in the next cycle.

* jn/svn-fe (2012-01-27) 44 commits
 - vcs-svn/svndiff.c: squelch false "unused" warning from gcc
 - Merge branch 'svn-fe' of git://repo.or.cz/git/jrn into jn/svn-fe
 - vcs-svn: reset first_commit_done in fast_export_init
 - Merge branch 'db/text-delta' into svn-fe
 - vcs-svn: do not initialize report_buffer twice
 - Merge branch 'db/text-delta' into svn-fe
 - vcs-svn: avoid hangs from corrupt deltas
 - vcs-svn: guard against overflow when computing preimage length
 - Merge branch 'db/delta-applier' into db/text-delta
 - vcs-svn: implement text-delta handling
 - Merge branch 'db/delta-applier' into db/text-delta
 - Merge branch 'db/delta-applier' into svn-fe
 - vcs-svn: cap number of bytes read from sliding view
 - test-svn-fe: split off "test-svn-fe -d" into a separate function
 - vcs-svn: let deltas use data from preimage
 - vcs-svn: let deltas use data from postimage
 - vcs-svn: verify that deltas consume all inline data
 - vcs-svn: implement copyfrom_data delta instruction
 - vcs-svn: read instructions from deltas
 - vcs-svn: read inline data from deltas
 - vcs-svn: read the preimage when applying deltas
 - vcs-svn: parse svndiff0 window header
 - vcs-svn: skeleton of an svn delta parser
 - vcs-svn: make buffer_read_binary API more convenient
 - vcs-svn: learn to maintain a sliding view of a file
 - Makefile: list one vcs-svn/xdiff object or header per line
 - Merge branch 'db/svn-fe-code-purge' into svn-fe
 - vcs-svn: drop obj_pool
 - vcs-svn: drop treap
 - vcs-svn: drop string_pool
 - vcs-svn: pass paths through to fast-import
 - Merge branch 'db/strbufs-for-metadata' into db/svn-fe-code-purge
 - Merge branch 'db/length-as-hash' (early part) into db/svn-fe-code-pu=
rge
 - Merge branch 'db/vcs-svn-incremental' into svn-fe
 - vcs-svn: avoid using ls command twice
 - vcs-svn: use mark from previous import for parent commit
 - vcs-svn: handle filenames with dq correctly
 - vcs-svn: quote paths correctly for ls command
 - vcs-svn: eliminate repo_tree structure
 - vcs-svn: add a comment before each commit
 - vcs-svn: save marks for imported commits
 - vcs-svn: use higher mark numbers for blobs
 - vcs-svn: set up channel to read fast-import cat-blob response
 - Merge commit 'v1.7.5' into svn-fe

Will merge early in the next cycle.

--------------------------------------------------
[Stalled]

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so that
somebody new can try to dip his or her toes in the development. Any
takers?

Waiting for a reroll.

* mh/ref-api-rest (2011-12-12) 35 commits
 . repack_without_ref(): call clear_packed_ref_cache()
 . read_packed_refs(): keep track of the directory being worked in
 . is_refname_available(): query only possibly-conflicting references
 . refs: read loose references lazily
 . read_loose_refs(): take a (ref_entry *) as argument
 . struct ref_dir: store a reference to the enclosing ref_cache
 . sort_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 . do_for_each_ref_in_dir*(): take (ref_entry *) instead of (ref_dir *)
 . add_entry(): take (ref_entry *) instead of (ref_dir *)
 . search_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 . find_containing_direntry(): use (ref_entry *) instead of (ref_dir *)
 . add_ref(): take (ref_entry *) instead of (ref_dir *)
 . read_packed_refs(): take (ref_entry *) instead of (ref_dir *)
 . find_ref(): take (ref_entry *) instead of (ref_dir *)
 . is_refname_available(): take (ref_entry *) instead of (ref_dir *)
 . get_loose_refs(): return (ref_entry *) instead of (ref_dir *)
 . get_packed_refs(): return (ref_entry *) instead of (ref_dir *)
 . refs: wrap top-level ref_dirs in ref_entries
 . get_ref_dir(): keep track of the current ref_dir
 . do_for_each_ref(): only iterate over the subtree that was requested
 . refs: sort ref_dirs lazily
 . sort_ref_dir(): do not sort if already sorted
 . refs: store references hierarchically
 . refs.c: rename ref_array -> ref_dir
 . struct ref_entry: nest the value part in a union
 . check_refname_component(): return 0 for zero-length components
 . free_ref_entry(): new function
 . refs.c: reorder definitions more logically
 . is_refname_available(): reimplement using do_for_each_ref_in_array()
 . names_conflict(): simplify implementation
 . names_conflict(): new function, extracted from is_refname_available(=
)
 . repack_without_ref(): reimplement using do_for_each_ref_in_array()
 . do_for_each_ref_in_arrays(): new function
 . do_for_each_ref_in_array(): new function
 . do_for_each_ref(): correctly terminate while processesing extra_refs

I had to remove this temporarily out of 'pu' as I didn't want to deal w=
ith
merge conflicts with the mh/ref-clone-without-extra-refs topic that
removes yet another caller of add_extra_ref() that this series touches.

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

* nd/commit-ignore-i-t-a (2012-01-16) 2 commits
 - commit, write-tree: allow to ignore CE_INTENT_TO_ADD while writing t=
rees
 - cache-tree: update API to take abitrary flags

May want to consider this as fixing an earlier UI mistake, and not as a
feature that devides the userbase.

Will defer till the next cycle.

--------------------------------------------------
[Cooking]

* jc/split-blob (2012-01-24) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

Not ready.

I finished the streaming checkout codepath, but as explained in 127b177
(bulk-checkin: support chunked-object encoding, 2011-11-30), these are
still early steps of a long and painful journey. At least pack-objects =
and
fsck need to learn the new encoding for the series to be usable locally=
,
and then index-pack/unpack-objects needs to learn it to be used remotel=
y.

Given that I heard a lot of noise that people want large files, and tha=
t I
was asked by somebody at GitTogether'11 privately for an advice on how =
to
pay developers (not me) to help adding necessary support, I am somewhat
dissapointed that the original patch series that was sent almost two
months ago still remains here without much comments and updates from th=
e
developer community. I even made the interface to the logic that decide=
s
where to split chunks easily replaceable, and I deliberately made the
logic in the original patch extremely stupid to entice others, especial=
ly
the "bup" fanboys, to come up with a better logic, thinking that giving
people an easy target to shoot for, they may be encouraged to help
out. The plan is not working :-(.

* jl/test-pause (2012-01-17) 1 commit
  (merged to 'next' on 2012-01-20 at ee56335)
 + test-lib: add the test_pause convenience function

Looked reasonable.
Will merge early in the next cycle.

* mh/ref-clone-without-extra-refs (2012-01-17) 4 commits
  (merged to 'next' on 2012-01-20 at 2e9645e)
 + write_remote_refs(): create packed (rather than extra) refs
 + add_packed_ref(): new function in the refs API.
 + ref_array: keep track of whether references are sorted
 + pack_refs(): remove redundant check

Looked reasonable; will hopefully help making mh/ref-api-rest simpler a=
nd
cleaner.

Will merge early in the next cycle.

* mm/zsh-completion-regression-fix (2012-01-17) 1 commit
  (merged to 'next' on 2012-01-23 at 7bc2e0a)
 + bash-completion: don't add quoted space for ZSH (fix regression)

Will merge early in the next cycle and deal with any fallout in 'master=
'.

* ar/i18n-no-gettext (2012-01-27) 4 commits
  (merged to 'next' on 2012-01-27 at 0ecf258)
 + i18n: Do not force USE_GETTEXT_SCHEME=3Dfallthrough on NO_GETTEXT
  (merged to 'next' on 2012-01-23 at 694a94e)
 + i18n: Make NO_GETTEXT imply fallthrough scheme in shell l10n
 + add a Makefile switch to avoid gettext translation in shell scripts
 + git-sh-i18n: restructure the logic to compute gettext.sh scheme

Will merge early in the next cycle and deal with any fallout in 'master=
'.

* da/maint-mergetool-twoway (2012-01-23) 1 commit
  (merged to 'next' on 2012-01-23 at f927323)
 + mergetool: Provide an empty file when needed

Caters to GUI merge backends that cannot merge two files without
a base by giving them an empty file as a "pretend" common ancestor.

Will merge early in the next cycle and deal with any fallout in 'master=
'.

* jc/maint-log-first-parent-pathspec (2012-01-19) 1 commit
  (merged to 'next' on 2012-01-20 at fb2b35f)
 + Making pathspec limited log play nicer with --first-parent

A bugfix.
Will merge early in the next cycle.

* ld/git-p4-branches-and-labels (2012-01-20) 5 commits
  (merged to 'next' on 2012-01-23 at 9020ec4)
 + git-p4: label import fails with multiple labels at the same changeli=
st
 + git-p4: add test for p4 labels
 + git-p4: importing labels should cope with missing owner
 + git-p4: cope with labels with empty descriptions
 + git-p4: handle p4 branches and labels containing shell chars
 (this branch is used by va/git-p4-branch.)

Will merge early in the next cycle.

* va/git-p4-branch (2012-01-26) 4 commits
  (merged to 'next' on 2012-01-26 at e67c52a)
 + t9801: do not overuse test_must_fail
 + git-p4: Change p4 command invocation
 + git-p4: Add test case for complex branch import
 + git-p4: Search for parent commit on branch creation
 (this branch uses ld/git-p4-branches-and-labels.)

Rerolled and Acked.
Will merge early in the next cycle.

* sp/smart-http-failure-to-push (2012-01-20) 1 commit
  (merged to 'next' on 2012-01-20 at a892434)
 + remote-curl: Fix push status report when all branches fail

Looked reasonable.
Will merge early in the next cycle.

* ks/sort-wildcard-in-makefile (2012-01-22) 1 commit
  (merged to 'next' on 2012-01-23 at e2e0c1d)
 + t/Makefile: Use $(sort ...) explicitly where needed

Looked reasonable.
Will merge early in the next cycle.

* tr/grep-l-with-decoration (2012-01-23) 1 commit
  (merged to 'next' on 2012-01-23 at 42b8795)
 + grep: fix -l/-L interaction with decoration lines

Looked reasonable.
Will merge early in the next cycle.

* jc/pull-signed-tag (2012-01-23) 1 commit
  (merged to 'next' on 2012-01-23 at 4257553)
 + merge: use editor by default in interactive sessions

Per Linus's strong suggestion, sugarcoated (aka "taking blame for the
original UI screw-ups") so that it is easier for me to swallow and acce=
pt
a potentially huge backward incompatibility issue, "git merge" is made =
to
launch an editor to explain the merge in the merge commit by default in
interactive sessions.

I've updated the special-case environment variable to MERGE_AUTOEDIT th=
at
scripts can set to "no" when they start. There is no plan to encourage
humans to keep using the historical behaviour, hence there is no suppor=
t
for configuration variable (e.g. merge.autoedit) that can be set to 'no=
'.
Oh, also I updated the documentation a bit.

Will merge early in the next cycle and deal with any fallout in 'master=
'.

* nd/maint-refname-in-hierarchy-check (2012-01-11) 1 commit
  (merged to 'next' on 2012-01-20 at acb5611)
 + Fix incorrect ref namespace check

Avoid getting confused by "ref/headxxx" and mistaking it as if it is un=
der
the "refs/heads/" hierarchy.
Will merge early in the next cycle.

* jc/advise-i18n (2011-12-22) 1 commit
  (merged to 'next' on 2012-01-23 at 6447013)
 + i18n of multi-line advice messages

Allow localization of advice messages that tend to be longer and
multi-line formatted. For now this is deliberately limited to advise()
interface and not vreportf() in general as touching the latter has
interactions with error() that has plumbing callers whose prefix "error=
: "
should never be translated.

Will merge early in the next cycle.

* rr/sequencer (2012-01-11) 2 commits
  (merged to 'next' on 2012-01-23 at f349b56)
 + sequencer: factor code out of revert builtin
 + revert: prepare to move replay_action to header

Moving large chunk of code out of cherry-pick/revert for later reuse,
primarily to prepare for the next cycle.

Will merge early in the next cycle.

* tr/maint-mailinfo (2012-01-16) 2 commits
  (merged to 'next' on 2012-01-20 at 278fae1)
 + mailinfo: with -b, keep space after [foo]
 + am: learn passing -b to mailinfo

Looked reasonable.
Will merge early in the next cycle.

* pw/p4-view-updates (2012-01-11) 5 commits
  (merged to 'next' on 2012-01-20 at 8ca2c7b)
 + git-p4: add tests demonstrating spec overlay ambiguities
 + git-p4: adjust test to adhere to stricter useClientSpec
 + git-p4: clarify comment
 + git-p4: fix verbose comment typo
 + git-p4: only a single ... wildcard is supported

Will merge early in the next cycle.

* rs/diff-postimage-in-context (2012-01-06) 1 commit
  (merged to 'next' on 2012-01-09 at 9635032)
 + xdiff: print post-image for common records instead of pre-image

Looked reasonable.
Will merge early in the next cycle and deal with any fallout in 'master=
'.

* cb/push-quiet (2012-01-08) 3 commits
  (merged to 'next' on 2012-01-20 at 4326dda)
 + t5541: avoid TAP test miscounting
 + fix push --quiet: add 'quiet' capability to receive-pack
 + server_supports(): parse feature list more carefully

Looked reasonable.
Will merge early in the next cycle.

* nd/clone-detached (2012-01-24) 12 commits
  (merged to 'next' on 2012-01-26 at 7b0cc8a)
 + clone: fix up delay cloning conditions
  (merged to 'next' on 2012-01-23 at bee31c6)
 + push: do not let configured foreign-vcs permanently clobbered
  (merged to 'next' on 2012-01-23 at 9cab64e)
 + clone: print advice on checking out detached HEAD
 + clone: allow --branch to take a tag
 + clone: refuse to clone if --branch points to bogus ref
 + clone: --branch=3D<branch> always means refs/heads/<branch>
 + clone: delay cloning until after remote HEAD checking
 + clone: factor out remote ref writing
 + clone: factor out HEAD update code
 + clone: factor out checkout code
 + clone: write detached HEAD in bare repositories
 + t5601: add missing && cascade
 (this branch uses nd/clone-single-branch.)

Applied two band-aids to a corner-case regression.
Will merge early in the next cycle and deal with any fallout in 'master=
'.

* nd/clone-single-branch (2012-01-08) 1 commit
  (merged to 'next' on 2012-01-09 at 6c3c759)
 + clone: add --single-branch to fetch only one branch
 (this branch is used by nd/clone-detached.)

Looked reasonable.
Will merge early in the next cycle.

* jn/gitweb-unspecified-action (2012-01-09) 1 commit
  (merged to 'next' on 2012-01-20 at 2b31714)
 + gitweb: Fix actionless dispatch for non-existent objects

Looked reasonable.
Will merge early in the next cycle.

* nd/index-pack-no-recurse (2012-01-16) 3 commits
  (merged to 'next' on 2012-01-20 at d1e964e)
 + index-pack: eliminate unlimited recursion in get_base_data()
 + index-pack: eliminate recursion in find_unresolved_deltas
 + Eliminate recursion in setting/clearing marks in commit list

Much better explained than the previous round.
Will merge early in the next cycle and deal with any fallout in 'master=
'.

* cb/git-daemon-tests (2012-01-08) 5 commits
  (merged to 'next' on 2012-01-08 at 1db8351)
 + git-daemon tests: wait until daemon is ready
 + git-daemon: produce output when ready
 + git-daemon: add tests
 + dashed externals: kill children on exit
 + run-command: optionally kill children on exit

Will merge early in the next cycle.

* jk/parse-object-cached (2012-01-06) 3 commits
  (merged to 'next' on 2012-01-08 at 8c6fa4a)
 + upload-pack: avoid parsing tag destinations
 + upload-pack: avoid parsing objects during ref advertisement
 + parse_object: try internal cache before reading object db

These are a bit scary changes, but I do think they are worth doing.
Will merge early in the next cycle and deal with any fallout in 'master=
'.
