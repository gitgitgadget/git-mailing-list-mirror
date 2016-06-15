From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2008, #03; Fri, 19)
Date: Fri, 19 Sep 2008 13:52:35 -0700
Message-ID: <7vprmzrh7w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 22:54:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgmz9-0006JH-Rw
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 22:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbYISUwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 16:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbYISUwn
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 16:52:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbYISUwl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2008 16:52:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B156263B45;
	Fri, 19 Sep 2008 16:52:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3721C63B44; Fri, 19 Sep 2008 16:52:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E63AD67A-868C-11DD-A55F-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96315>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

By the way, I'll be on vacation from Sep 24 til Oct 08, but e-mail base=
d
proposal/review/discussion/improvement cycle and the distributed nature=
 of
git mean that it shouldn't keep the participants from further working o=
n
the system.  Hopefully when I come back I'll see a much improved git ;-=
).

----------------------------------------------------------------
[New Topics]

* mg/maint-remote-fix (Thu Sep 18 18:11:02 2008 +0200) 1 commit
 - make "git remote" report multiple URLs

Still with a minor nit but I think this is an improvement.

* pb/submodule (Fri Sep 12 23:09:19 2008 +0200) 1 commit
 - t7400: Add short "git submodule add" testsuite

Waiting for a reroll.

* tr/workflow-doc (Sat Sep 13 18:11:01 2008 +0200) 2 commits
 + Documentation: Refer to git-rebase(1) to warn against rewriting
 + Documentation: new upstream rebase recovery section in git-rebase

I think the last one on "recommended practice" needs discussion.  I do =
not
think it describes _the_ recommended workflow, although I think (1) wha=
t
is recommended in the draft does make sense within its own scope, and (=
2)
it may be impossible to come up with _the_ recommended workflow anyway.

* bc/maint-diff-hunk-header-fix (Thu Sep 18 17:44:33 2008 -0500) 3 comm=
its
 + diff.*.xfuncname which uses "extended" regex's for hunk header
   selection
 + diff.c: associate a flag with each pattern and use it for
   compiling regex
 + diff.c: return pattern entry pointer rather than just the hunk
   header pattern

* bc/master-diff-hunk-header-fix (Thu Sep 18 20:32:50 2008 -0700) 4 com=
mits
 + Merge branch 'bc/maint-diff-hunk-header-fix' into bc/master-diff-
   hunk-header-fix
 + diff.*.xfuncname which uses "extended" regex's for hunk header
   selection
 + diff.c: associate a flag with each pattern and use it for
   compiling regex
 + diff.c: return pattern entry pointer rather than just the hunk
   header pattern

I've commented on these two branches in a separate message.

----------------------------------------------------------------
[Graduated to "master"]

* mh/maint-honor-no-ssl-verify (Thu Feb 21 15:10:37 2008 -0800) 1 commi=
t
 + Don't verify host name in SSL certs when GIT_SSL_NO_VERIFY is set

* dp/maint-rebase-fix (Tue Sep 9 16:05:26 2008 +0400) 2 commits
 + git-rebase--interactive: auto amend only edited commit
 + git-rebase-interactive: do not squash commits on abort

* jc/maint-checkout-keep-remove (Sun Sep 7 19:49:25 2008 -0700) 1 commi=
t
 + checkout: do not lose staged removal

* jc/maint-template-permbits (Thu Aug 21 19:31:50 2008 -0500) 1 commit
 + Fix permission bits on sources checked out with an overtight umask

* np/pack (Tue Sep 2 10:22:22 2008 -0400) 4 commits
 + t5300: improve SHA1 collision test
 + pack-objects: don't include missing preferred base objects
 + sha1write: don't copy full sized buffers
 + Merge branch 'np/maint-safer-pack' into np/pack

* bw/shortref (Fri Sep 5 23:16:23 2008 +0200) 1 commit
 + for-each-ref: `:short` format for `refname`

* rs/decorate (Thu Sep 4 23:40:03 2008 +0200) 3 commits
 + add '%d' pretty format specifier to show decoration
 + move load_ref_decorations() to log-tree.c and export it
 + log: add load_ref_decorations()

* tr/rev-list-reverse (Mon Sep 1 00:31:37 2008 +0200) 2 commits
 + t6013: replace use of 'tac' with equivalent Perl
 + rev-list: fix --reverse interaction with --parents

* cc/bisect (Sat Sep 6 07:27:03 2008 +0200) 3 commits
 + bisect: remove "checkout_done" variable used when checking merge
   bases
 + bisect: only check merge bases when needed
 + bisect: test merge base if good rev is not an ancestor of bad rev

* jc/setlinebuf-setvbuf (Wed Sep 3 20:33:29 2008 -0700) 1 commit
 + daemon.c: avoid setlinebuf()

* jc/maint-diff-quiet (Mon Sep 1 23:20:26 2008 -0700) 2 commits
 + diff --quiet: make it synonym to --exit-code >/dev/null
 + diff Porcelain: do not disable auto index refreshing on -C -C

* jc/maint-name-hash-clear (Sat Aug 23 13:05:10 2008 -0700) 1 commit
 + discard_cache: reset lazy name_hash bit

* jc/diff-prefix (Mon Aug 18 20:08:09 2008 -0700) 1 commit
 + diff: vary default prefix depending on what are compared

----------------------------------------------------------------
[Stalled -- Needs Action to Proceed (or to be dropped)]

* bd/blame (Thu Aug 21 18:22:01 2008 -0500) 5 commits
 - Use xdiff caching to improve git blame performance
 - Allow xdiff machinery to cache hash results for a file
 - Always initialize xpparam_t to 0
 - Bypass textual patch generation and parsing in git blame
 - Allow alternate "low-level" emit function from xdl_diff

R=C3=A9ne had good comments on how the callback should be structured.

* kb/am-directory (Fri Aug 29 15:27:50 2008 -0700) 1 commit
 - git-am: Pass the --directory option through to git-apply

I think this is still buggy and drops the option when am stops with
conflicts.

----------------------------------------------------------------
[Will be merged to "master" soon]

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

* ho/dirstat-by-file (Fri Sep 5 22:27:35 2008 +0300) 1 commit
 + diff --dirstat-by-file: count changed files, not lines

* jc/safe-c-l-d (Tue Sep 2 14:10:15 2008 -0700) 1 commit
 + safe_create_leading_directories(): make it about "leading"
   directories

* jc/apply-include-exclude (Mon Aug 25 01:05:31 2008 -0700) 1 commit
 + git-apply:--include=3Dpathspec

* mv/commit-tree (Wed Sep 10 22:10:33 2008 +0200) 3 commits
 + t7603: add new testcases to ensure builtin-commit uses
   reduce_heads()
 + builtin-commit: use commit_tree()
 + commit_tree(): add a new author parameter

* pb/autocorrect-wrapper (Wed Sep 10 17:54:28 2008 +0200) 1 commit
 + git wrapper: also use aliases to correct mistyped commands

* pb/commit-where (Mon Sep 8 01:05:41 2008 +0200) 1 commit
 + builtin-commit.c: show on which branch a commit was added

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

* jc/alternate-push (Tue Sep 9 01:27:10 2008 -0700) 4 commits
 + push: receiver end advertises refs from alternate repositories
 + push: prepare sender to receive extended ref information from the
   receiver
 + receive-pack: make it a builtin
 + is_directory(): a generic helper function

----------------------------------------------------------------
[Actively Cooking]

* am/status (Mon Sep 8 00:05:03 2008 +0200) 2 commits
 + wt-status: Teach how to discard changes in the working directory
 + wt-status: Split header generation into three functions

* lt/time-reject-fractional-seconds (Sat Aug 16 21:25:40 2008 -0700) 1 =
commit
 + date/time: do not get confused by fractional seconds

* jc/add-ita (Thu Aug 21 01:44:53 2008 -0700) 1 commit
 + git-add --intent-to-add (-N)

Teaches "git add" to record only the intent to add a path later.
I rerolled this without the fake empty blob object.

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 - revision --simplify-merges: incremental simplification
 - revision --simplify-merges: prepare for incremental simplification

I started making this incremental but the progress is not so great.

----------------------------------------------------------------
[On Hold]

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

The one at second from the tip needs reworking.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

* jc/merge-whitespace (Sun Feb 24 23:29:36 2008 -0800) 1 commit
 - WIP: start teaching the --whitespace=3Dfix to merge machinery

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

This was previously in "will be in master soon" category, but it turns =
out
that the synonyms to the ones this one deletes are fairly new invention
that happend in 1.5.6 timeframe, and we cannot do this just yet.  Perha=
ps
in 1.7.0, but with the loud whining about moving git-foo out of $PATH w=
e
have been hearing, it might not be a bad idea to drop this.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will=
 be
hit due to tcl/tk's limitation, so I am holding this back for now.
