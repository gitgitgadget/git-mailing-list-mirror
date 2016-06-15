From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's cooking in git.git (Sep 2008, #05; Mon, 29)
Date: Tue, 30 Sep 2008 11:37:59 -0700
Message-ID: <20080930183759.GF21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 20:39:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkk7w-0004e4-61
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 20:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbYI3SiB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Sep 2008 14:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752992AbYI3SiB
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 14:38:01 -0400
Received: from george.spearce.org ([209.20.77.23]:54238 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbYI3SiA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 14:38:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4A0083835F; Tue, 30 Sep 2008 18:37:59 +0000 (UTC)
Content-Disposition: inline
X-master-at: 9800c0df412869c7949935b61581b9361fc49bd1
X-next-at: 37dbc802cfed9d39ff15dfd333bdd2e74ca9f458
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97140>

Sorry for sending out two issues in two days; yesterday I resent
issue #4 by mistake.  :-)

Everything below is worded for yesterday, as that is when I wrote
it, and when I meant to mail it.

*sigh*
----

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

If I have dropped anything recently its not because I don't want
to apply it, it just slipped through the cracks.  Please feel free
to give me a gentle prod (and a patch resend or a pointer to the
series on gmane).  Thanks.

----------------------------------------------------------------
[New Topics]

* gb/gitweb-pathinfo (Mon Sep 29 17:26:57 2008 +0200) 4 commits
 - gitweb: generate parent..current URLs
 - gitweb: parse parent..current syntax from pathinfo
 - gitweb: generate project/action/hash URLs
 - gitweb: parse project/action/hash_base:filename PATH_INFO

This series just came in today.  I haven't had a chance to look at
it beyond stashing in `pu`.

* mw/sendemail (Mon Sep 29 12:41:06 2008 -0500) 8 commits
 - send-email: signedoffcc -> signedoffbycc, but handle both
 - Docs: send-email: Create logical groupings for man text
 - Docs: send-email: Remove unnecessary config variable description
 - Docs: send-email: --chain_reply_to -> --[no-]chain-reply-to
 - send-email: change --no-validate to boolean --[no-]validate
 - Docs: send-email: Man page option ordering
 - Docs: send-email usage text much sexier
 - Docs: send-email's usage text and man page mention same options

This series has already gone through 3 iterations before I could
start to carry it in-tree.  I haven't had a chance to read it yet
myself, so its sitting around in `pu` for futher review.

* pb/gitweb (Thu Sep 25 18:48:48 2008 +0200) 2 commits
 - gitweb: Sort the list of forks on the summary page by age
 - gitweb: Clean-up sorting of project list

I forgot to look at this series today.  I meant to review and try
to merge it to `next` before publishing.  Will do that tomorrow.

* ae/preservemerge (Tue Sep 23 22:58:20 2008 +0200) 3 commits
 - git pull: Support --preserve-merges as a flag to rebase
 - git rebase: Support non-interactive merge-preserving rebase
 - Prepare for non-interactive merge-preserving rebase

Andreas says there's some issues in here.  I'm waiting for a respin
on the series before I look at it futher.

* mg/verboseprune (Mon Sep 29 18:49:52 2008 +0200) 1 commit
 - make prune report removed objects on -v

Just came in today.  Looks sane.  I'll drop it onto `next` tomorrow.

----------------------------------------------------------------
[Graduated to "master"]

* mv/merge-recursive (Sat Sep 6 18:29:49 2008 +0200) 11 commits
 + builtin-merge: release the lockfile in try_merge_strategy()
 + merge-recursive: get rid of virtual_id
 + merge-recursive: move current_{file,directory}_set to struct
   merge_options
 + merge-recursive: move the global obuf to struct merge_options
 + merge-recursive: get rid of the index_only global variable
 + merge-recursive: move call_depth to struct merge_options
 + cherry-pick/revert: make direct internal call to merge_tree()
 + builtin-merge: avoid run_command_v_opt() for recursive and subtree
 + merge-recursive: introduce merge_options
 + merge-recursive.c: Add more generic merge_recursive_generic()
 + Split out merge_recursive() to merge-recursive.c

(Tip at 4271666)

* ho/dirstat-by-file (Fri Sep 5 22:27:35 2008 +0300) 1 commit
 + diff --dirstat-by-file: count changed files, not lines

(Tip at fd33777)

* jc/safe-c-l-d (Tue Sep 2 14:10:15 2008 -0700) 1 commit
 + safe_create_leading_directories(): make it about "leading"
   directories

(Tip at 5f0bdf5)

* jc/apply-include-exclude (Mon Aug 25 01:05:31 2008 -0700) 1 commit
 + git-apply:--include=3Dpathspec

(Tip at 6ecb1ee)

* mv/commit-tree (Wed Sep 10 22:10:33 2008 +0200) 3 commits
 + t7603: add new testcases to ensure builtin-commit uses
   reduce_heads()
 + builtin-commit: use commit_tree()
 + commit_tree(): add a new author parameter

(Tip at 7a172b0)

* pb/autocorrect-wrapper (Wed Sep 10 17:54:28 2008 +0200) 1 commit
 + git wrapper: also use aliases to correct mistyped commands

(Tip at 746c221)

* jc/better-conflict-resolution (Thu Sep 4 23:48:48 2008 +0200) 15 comm=
its
 + Fix AsciiDoc errors in merge documentation
 + git-merge documentation: describe how conflict is presented
 + checkout --conflict=3D<style>: recreate merge in a non-default style
 + checkout -m: recreate merge when checking out of unmerged index
 + Merge branch 'jc/maint-checkout-fix' into 'jc/better-conflict-
   resolution'
 + git-merge-recursive: learn to honor merge.conflictstyle
 + merge.conflictstyle: choose between "merge" and "diff3 -m" styles
 + rerere: understand "diff3 -m" style conflicts with the original
 + rerere.c: use symbolic constants to keep track of parsing states
 + xmerge.c: "diff3 -m" style clips merge reduction level to EAGER or
   less
 + xmerge.c: minimum readability fixups
 + xdiff-merge: optionally show conflicts in "diff3 -m" style
 + xdl_fill_merge_buffer(): separate out a too deeply nested function
 + checkout --ours/--theirs: allow checking out one side of a
   conflicting merge
 + checkout -f: allow ignoring unmerged paths when checking out of
   the index

(Tip at 3407a7a)

* jc/alternate-push (Tue Sep 9 01:27:10 2008 -0700) 4 commits
 + push: receiver end advertises refs from alternate repositories
 + push: prepare sender to receive extended ref information from the
   receiver
 + receive-pack: make it a builtin
 + is_directory(): a generic helper function

(Tip at d79796b)

* bc/master-diff-hunk-header-fix (Sat Sep 20 18:36:22 2008 -0700) 10 co=
mmits
 + Merge branch 'bc/maint-diff-hunk-header-fix' into bc/master-diff-
   hunk-header-fix
 + diff hunk pattern: fix misconverted "\{" tex macro introducers
 + diff: fix "multiple regexp" semantics to find hunk header comment
 + diff: use extended regexp to find hunk headers
 + Merge branch 'bc/maint-diff-hunk-header-fix' into bc/master-diff-
   hunk-header-fix
 + diff: use extended regexp to find hunk headers
 + Merge branch 'bc/maint-diff-hunk-header-fix' into bc/master-diff-
   hunk-header-fix
 + diff.*.xfuncname which uses "extended" regex's for hunk header
   selection
 + diff.c: associate a flag with each pattern and use it for
   compiling regex
 + diff.c: return pattern entry pointer rather than just the hunk
   header pattern

(Tip at 92bb978)

* am/status (Mon Sep 8 00:05:03 2008 +0200) 2 commits
 + wt-status: Teach how to discard changes in the working directory
 + wt-status: Split header generation into three functions

(Tip at 4d6e4c4)

* mg/maint-remote-fix (Mon Sep 22 10:57:51 2008 +0200) 1 commit
 + make "git remote" report multiple URLs

(Tip at 7d20e21)

* bc/maint-diff-hunk-header-fix (Sat Sep 20 15:30:12 2008 -0700) 5 comm=
its
 + diff hunk pattern: fix misconverted "\{" tex macro introducers
 + diff: use extended regexp to find hunk headers
 + diff.*.xfuncname which uses "extended" regex's for hunk header
   selection
 + diff.c: associate a flag with each pattern and use it for
   compiling regex
 + diff.c: return pattern entry pointer rather than just the hunk
   header pattern

(Tip at 96d1a8e)

----------------------------------------------------------------
[Old New Topics]

* nd/narrow (Sun Sep 14 20:07:59 2008 +0700) 9 commits
 - grep: skip files that have not been checked out
 - checkout_entry(): CE_NO_CHECKOUT on checked out entries.
 - Prevent diff machinery from examining worktree outside narrow
   checkout
 - Add tests for updating no-checkout entries in index
 - ls-files: add --narrow-checkout option to "will checkout" entries
 - update-index: add --checkout/--no-checkout to update
   CE_NO_CHECKOUT bit
 - update-index: refactor mark_valid() in preparation for new options
 - Introduce CE_NO_CHECKOUT bit
 - Extend index to save more flags

[jc: This is an early half of the earlier series (I haven't had
 chance to look at the updated series yet), and should be replaced
 with the updated one posted recently.]

I haven't touched this branch since I inherited it from Junio.
I'd appreciate a resend or a pointer to the updated series so I
can at least replace it.

----------------------------------------------------------------
[Stalled -- Needs Action to Proceed (or to be dropped)]

* pb/submodule (Fri Sep 12 23:09:19 2008 +0200) 1 commit
 - t7400: Add short "git submodule add" testsuite

[jc: Waiting for a reroll.]

* bd/blame (Thu Aug 21 18:22:01 2008 -0500) 5 commits
 - Use xdiff caching to improve git blame performance
 - Allow xdiff machinery to cache hash results for a file
 - Always initialize xpparam_t to 0
 - Bypass textual patch generation and parsing in git blame
 - Allow alternate "low-level" emit function from xdl_diff

[jc: R=C3=A9ne had good comments on how the callback should be
 structured.]

* kb/am-directory (Fri Aug 29 15:27:50 2008 -0700) 1 commit
 - git-am: Pass the --directory option through to git-apply

[jc: I think this is still buggy and drops the option when am stops
 with conflicts.]

All three of these are stalled.  I'm not going to drop them just
yet, but Junio's comments still hold.  If there's no action on
these next week we may seem them drop off.

----------------------------------------------------------------
[Will be merged to 'master/maint' soon]

* jc/add-ita (Thu Aug 21 01:44:53 2008 -0700) 1 commit
 + git-add --intent-to-add (-N)

Teaches "git add" to record only the intent to add a path later.
[jc: I rerolled this without the fake empty blob object.]

I'm inclined to merge this next week.

(Tip at 3942581)

----------------------------------------------------------------
[Actively Cooking]

* tr/workflow-doc (Sat Sep 13 18:11:01 2008 +0200) 2 commits
 + Documentation: Refer to git-rebase(1) to warn against rewriting
 + Documentation: new upstream rebase recovery section in git-rebase

[jc: My impression from the last round of discusson on the third
 patch in this series (not queued here) was that as long as we
 do not present it as "One True Workflow", the description was
 a good starting point, possibly others to add other recommended
 flows later.]

I haven't looked at this series yet.  Based on Junios remarks above
I'm looking for more input on this series before it goes anywhere.

* pb/commit-where (Mon Sep 8 01:05:41 2008 +0200) 1 commit
 + builtin-commit.c: show on which branch a commit was added

[jc: Tentatively kicked back to "still cooking" status after
 Jeff voiced his annoyance.  I personally do not like making this
 multi-line as Jeff suggested as an alternative (the message already
 is too verbose to my taste).]

Agree with Junio.  Hence its still here.

* lt/time-reject-fractional-seconds (Sat Aug 16 21:25:40 2008 -0700) 1 =
commit
 + date/time: do not get confused by fractional seconds

I need to look at this in more detail.  I suspect we can merge
this to master soon, but its been kicking around since Aug 16th.
I need to look at it to see if there's any obvious reason why Junio
has no notes on this branch and why it hasn't merged yet.

----------------------------------------------------------------
[On Hold]

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 - revision --simplify-merges: incremental simplification
 - revision --simplify-merges: prepare for incremental simplification

[jc: I started making this incremental but the progress is not so great=
=2E]

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

[jc: The one at second from the tip needs reworking.]

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

* jc/merge-whitespace (Sun Feb 24 23:29:36 2008 -0800) 1 commit
 . WIP: start teaching the --whitespace=3Dfix to merge machinery

This has a merge conflict with `next` and isn't even in pu right now.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

I should look at this in more detail.  We may be able to merge it
to next soon-ish.

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

[jc: This was previously in "will be in master soon" category,
 but it turns out that the synonyms to the ones this one deletes
 are fairly new invention that happend in 1.5.6 timeframe, and
 we cannot do this just yet.  Perhaps in 1.7.0, but with the loud
 whining about moving git-foo out of $PATH we have been hearing,
 it might not be a bad idea to drop this.]

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

[jc: This would be the right thing to do for command line use,
 but gitk will be hit due to tcl/tk's limitation, so I am holding
 this back for now.]
--=20
Shawn.
