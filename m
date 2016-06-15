From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2012, #07; Sun, 29)
Date: Sun, 29 Jan 2012 15:48:20 -0800
Message-ID: <7vobtmdq9n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 00:49:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RreUc-0001rX-NI
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 00:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab2A2Xss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jan 2012 18:48:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334Ab2A2XsY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2012 18:48:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C2EC7B73;
	Sun, 29 Jan 2012 18:48:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=2RKhOSClSJUnugfpviUZFK1b6
	tY=; b=XRlRrbInrHvbwqqslDPkYAeCy5LPhsIfKoyIT+UsA8+oBmTkWw+hYHlKZ
	LNtB2Y9CShj8yltQLgi1Tnldue/l6Zsu6OEs+E8KNyt5ajT/YJiwb9+VVy6xfRE3
	FTsgFD4JLCUsQ6+lNCwWmoJjYix7w/QaV8nae6ek95cnn5T2iI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=LfqMeQyIa1RGGrPm3WY
	nHeWEEouVG3SCTFvACEKLer58S/rWAZ/MBw9l/LN2FyYcaSg2V7a9h+88VLWY8Df
	yMFo9iQ0m7DBu+IvfK8J8IIlITFfMZZdhccvabIKz2jCXzJdUNnmTu+wLWMqf+ds
	YD5u5dvMYFDpjP60UvOXtyqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 634FF7B72;
	Sun, 29 Jan 2012 18:48:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4432C7B70; Sun, 29 Jan 2012
 18:48:22 -0500 (EST)
X-master-at: 85da4d459bd6fe11189a2ccf560c952b31ed67b2
X-next-at: 001a395be8dff147088b94dda0892c87a949c033
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA5AE496-4AD3-11E1-8B49-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189307>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

As promised in the recent couple of issues of "What's cooking", the fir=
st
batch of topics that have been cooking in 'next' are now in 'master'. T=
he
tip of 'next' hasn't been rewound yet, but it soon will after the secon=
d
batch of topics graduate.

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

* bl/gitweb-project-filter (2012-01-29) 2 commits
 - gitweb: place links to parent directories in page header
 - gitweb: add project_filter to limit project list to a subdirectory

* rt/completion-branch-edit-desc (2012-01-29) 1 commit
 - completion: --edit-description option for git-branch

--------------------------------------------------
[Graduated to "master"]

* cb/git-daemon-tests (2012-01-08) 5 commits
  (merged to 'next' on 2012-01-08 at 1db8351)
 + git-daemon tests: wait until daemon is ready
 + git-daemon: produce output when ready
 + git-daemon: add tests
 + dashed externals: kill children on exit
 + run-command: optionally kill children on exit

* cb/push-quiet (2012-01-08) 3 commits
  (merged to 'next' on 2012-01-20 at 4326dda)
 + t5541: avoid TAP test miscounting
 + fix push --quiet: add 'quiet' capability to receive-pack
 + server_supports(): parse feature list more carefully

* jc/maint-log-first-parent-pathspec (2012-01-19) 1 commit
  (merged to 'next' on 2012-01-20 at fb2b35f)
 + Making pathspec limited log play nicer with --first-parent

* jk/parse-object-cached (2012-01-06) 3 commits
  (merged to 'next' on 2012-01-08 at 8c6fa4a)
 + upload-pack: avoid parsing tag destinations
 + upload-pack: avoid parsing objects during ref advertisement
 + parse_object: try internal cache before reading object db

These are a bit scary changes, but I do think they are worth doing.

* jl/test-pause (2012-01-17) 1 commit
  (merged to 'next' on 2012-01-20 at ee56335)
 + test-lib: add the test_pause convenience function

* jn/gitweb-unspecified-action (2012-01-09) 1 commit
  (merged to 'next' on 2012-01-20 at 2b31714)
 + gitweb: Fix actionless dispatch for non-existent objects

* mh/ref-clone-without-extra-refs (2012-01-17) 4 commits
  (merged to 'next' on 2012-01-20 at 2e9645e)
 + write_remote_refs(): create packed (rather than extra) refs
 + add_packed_ref(): new function in the refs API.
 + ref_array: keep track of whether references are sorted
 + pack_refs(): remove redundant check

Looked reasonable; will hopefully help making mh/ref-api-rest simpler a=
nd
cleaner.

* nd/clone-single-branch (2012-01-08) 1 commit
  (merged to 'next' on 2012-01-09 at 6c3c759)
 + clone: add --single-branch to fetch only one branch
 (this branch is used by nd/clone-detached.)

* nd/index-pack-no-recurse (2012-01-16) 3 commits
  (merged to 'next' on 2012-01-20 at d1e964e)
 + index-pack: eliminate unlimited recursion in get_base_data()
 + index-pack: eliminate recursion in find_unresolved_deltas
 + Eliminate recursion in setting/clearing marks in commit list

* nd/maint-refname-in-hierarchy-check (2012-01-11) 1 commit
  (merged to 'next' on 2012-01-20 at acb5611)
 + Fix incorrect ref namespace check

* pw/p4-view-updates (2012-01-11) 5 commits
  (merged to 'next' on 2012-01-20 at 8ca2c7b)
 + git-p4: add tests demonstrating spec overlay ambiguities
 + git-p4: adjust test to adhere to stricter useClientSpec
 + git-p4: clarify comment
 + git-p4: fix verbose comment typo
 + git-p4: only a single ... wildcard is supported

* rs/diff-postimage-in-context (2012-01-06) 1 commit
  (merged to 'next' on 2012-01-09 at 9635032)
 + xdiff: print post-image for common records instead of pre-image

* sp/smart-http-failure-to-push (2012-01-20) 1 commit
  (merged to 'next' on 2012-01-20 at a892434)
 + remote-curl: Fix push status report when all branches fail

* tr/maint-mailinfo (2012-01-16) 2 commits
  (merged to 'next' on 2012-01-20 at 278fae1)
 + mailinfo: with -b, keep space after [foo]
 + am: learn passing -b to mailinfo

--------------------------------------------------
[Stalled]

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so that
somebody new can try to dip his or her toes in the development. Any
takers?

Waiting for a reroll.

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

* jl/submodule-re-add (2012-01-24) 1 commit
  (merged to 'next' on 2012-01-26 at 482553e)
 + submodule add: fix breakage when re-adding a deep submodule

"git submodule add" forgot to recompute the name to be stored in .gitmo=
dules
when the module was once added to the superproject and already initiali=
zed.

Will merge to 'master' in the second batch.

* jn/svn-fe (2012-01-27) 44 commits
  (merged to 'next' on 2012-01-29 at 001a395)
 + vcs-svn/svndiff.c: squelch false "unused" warning from gcc
 + Merge branch 'svn-fe' of git://repo.or.cz/git/jrn into jn/svn-fe
 + vcs-svn: reset first_commit_done in fast_export_init
 + Merge branch 'db/text-delta' into svn-fe
 + vcs-svn: do not initialize report_buffer twice
 + Merge branch 'db/text-delta' into svn-fe
 + vcs-svn: avoid hangs from corrupt deltas
 + vcs-svn: guard against overflow when computing preimage length
 + Merge branch 'db/delta-applier' into db/text-delta
 + vcs-svn: implement text-delta handling
 + Merge branch 'db/delta-applier' into db/text-delta
 + Merge branch 'db/delta-applier' into svn-fe
 + vcs-svn: cap number of bytes read from sliding view
 + test-svn-fe: split off "test-svn-fe -d" into a separate function
 + vcs-svn: let deltas use data from preimage
 + vcs-svn: let deltas use data from postimage
 + vcs-svn: verify that deltas consume all inline data
 + vcs-svn: implement copyfrom_data delta instruction
 + vcs-svn: read instructions from deltas
 + vcs-svn: read inline data from deltas
 + vcs-svn: read the preimage when applying deltas
 + vcs-svn: parse svndiff0 window header
 + vcs-svn: skeleton of an svn delta parser
 + vcs-svn: make buffer_read_binary API more convenient
 + vcs-svn: learn to maintain a sliding view of a file
 + Makefile: list one vcs-svn/xdiff object or header per line
 + Merge branch 'db/svn-fe-code-purge' into svn-fe
 + vcs-svn: drop obj_pool
 + vcs-svn: drop treap
 + vcs-svn: drop string_pool
 + vcs-svn: pass paths through to fast-import
 + Merge branch 'db/strbufs-for-metadata' into db/svn-fe-code-purge
 + Merge branch 'db/length-as-hash' (early part) into db/svn-fe-code-pu=
rge
 + Merge branch 'db/vcs-svn-incremental' into svn-fe
 + vcs-svn: avoid using ls command twice
 + vcs-svn: use mark from previous import for parent commit
 + vcs-svn: handle filenames with dq correctly
 + vcs-svn: quote paths correctly for ls command
 + vcs-svn: eliminate repo_tree structure
 + vcs-svn: add a comment before each commit
 + vcs-svn: save marks for imported commits
 + vcs-svn: use higher mark numbers for blobs
 + vcs-svn: set up channel to read fast-import cat-blob response
 + Merge commit 'v1.7.5' into svn-fe

"vcs-svn"/"svn-fe" learned to read dumps with svn-deltas and support
incremental imports.

Will merge to 'master' in the second batch.

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

* ar/i18n-no-gettext (2012-01-27) 4 commits
  (merged to 'next' on 2012-01-27 at 0ecf258)
 + i18n: Do not force USE_GETTEXT_SCHEME=3Dfallthrough on NO_GETTEXT
  (merged to 'next' on 2012-01-23 at 694a94e)
 + i18n: Make NO_GETTEXT imply fallthrough scheme in shell l10n
 + add a Makefile switch to avoid gettext translation in shell scripts
 + git-sh-i18n: restructure the logic to compute gettext.sh scheme

Will merge to 'master' in the second batch and deal with any fallout in=
 'master'.

* da/maint-mergetool-twoway (2012-01-23) 1 commit
  (merged to 'next' on 2012-01-23 at f927323)
 + mergetool: Provide an empty file when needed

Caters to GUI merge backends that cannot merge two files without
a base by giving them an empty file as a "pretend" common ancestor.

Will merge to 'master' in the second batch and deal with any fallout in=
 'master'.

* ld/git-p4-branches-and-labels (2012-01-20) 5 commits
  (merged to 'next' on 2012-01-23 at 9020ec4)
 + git-p4: label import fails with multiple labels at the same changeli=
st
 + git-p4: add test for p4 labels
 + git-p4: importing labels should cope with missing owner
 + git-p4: cope with labels with empty descriptions
 + git-p4: handle p4 branches and labels containing shell chars
 (this branch is used by va/git-p4-branch.)

Will merge to 'master' in the second batch.

* va/git-p4-branch (2012-01-26) 4 commits
  (merged to 'next' on 2012-01-26 at e67c52a)
 + t9801: do not overuse test_must_fail
 + git-p4: Change p4 command invocation
 + git-p4: Add test case for complex branch import
 + git-p4: Search for parent commit on branch creation
 (this branch uses ld/git-p4-branches-and-labels.)

Rerolled and Acked.
Will merge to 'master' in the second batch.

* ks/sort-wildcard-in-makefile (2012-01-22) 1 commit
  (merged to 'next' on 2012-01-23 at e2e0c1d)
 + t/Makefile: Use $(sort ...) explicitly where needed

t/Makefile is adjusted to prevent newer versions of GNU make from runni=
ng
tests in seemingly random order.

Will merge to 'master' in the second batch.

* tr/grep-l-with-decoration (2012-01-23) 1 commit
  (merged to 'next' on 2012-01-23 at 42b8795)
 + grep: fix -l/-L interaction with decoration lines

Using "git grep -l/-L" together with options -W or --break may not make
much sense as the output is to only count the number of hits and there =
is
no place for file breaks, but the latter options made "-l/-L" to miscou=
nt
the hits.

Will merge to 'master' in the second batch.

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

"git merge" in an interactive session learned to spawn the editor by
default to let the user edit the auto-generated merge message, to
encourage people to explain their merges better.

Will merge to 'master' in the second batch and deal with any fallout in=
 'master'.

* jc/advise-i18n (2011-12-22) 1 commit
  (merged to 'next' on 2012-01-23 at 6447013)
 + i18n of multi-line advice messages

Allow localization of advice messages that tend to be longer and
multi-line formatted. For now this is deliberately limited to advise()
interface and not vreportf() in general as touching the latter has
interactions with error() that has plumbing callers whose prefix "error=
: "
should never be translated.

Will merge to 'master' in the second batch.

* rr/sequencer (2012-01-11) 2 commits
  (merged to 'next' on 2012-01-23 at f349b56)
 + sequencer: factor code out of revert builtin
 + revert: prepare to move replay_action to header

Moving large chunk of code out of cherry-pick/revert for later reuse,
primarily to prepare for the next cycle.

Will merge to 'master' in the second batch.

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

"git clone" learned to detach the HEAD in the resulting repository when
the source repository's HEAD does not point to a branch.

Will merge to 'master' in the second batch and deal with any fallout in=
 'master'.

--------------------------------------------------
[Discarded]

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

Will be re-rolled. Discarded without prejudice.

* mm/zsh-completion-regression-fix (2012-01-17) 1 commit
  (merged to 'next' on 2012-01-23 at 7bc2e0a)
 + bash-completion: don't add quoted space for ZSH (fix regression)

Superseded by a better fix already in 'master'.
