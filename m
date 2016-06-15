From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2008, #03; Tue, 14)
Date: Tue, 14 Oct 2008 15:08:54 -0700
Message-ID: <7v8wsq7rt5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 00:10:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kps5w-0005Vg-Nd
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 00:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbYJNWJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Oct 2008 18:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYJNWJF
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 18:09:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYJNWJB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2008 18:09:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E3C478A7B4;
	Tue, 14 Oct 2008 18:08:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 70C5B8A7AF; Tue, 14 Oct 2008 18:08:56 -0400 (EDT)
X-master-at: 67faaaba8338cf59c212ce5239eeb223a77acdf0
X-next-at: f1ba443bf7f7fae740f81058fca0bcff3613d999
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B361BC00-9A3C-11DD-9095-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98216>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

This round I haven't added anything new yet.  Just getting my developme=
nt
repository back into shape and in sync with what I received from Shawn.

----------------------------------------------------------------
[New Topics]

* js/maint-fetch-update-head (Mon Oct 13 11:36:52 2008 +0200) 1 commit
 - Fix fetch/pull when run without --update-head-ok

This looked sane to me.

----------------------------------------------------------------
[Stuck Topics]

* nd/narrow (Wed Oct 1 11:04:09 2008 +0700) 9 commits
 - grep: skip files outside sparse checkout area
 - checkout_entry(): CE_NO_CHECKOUT on checked out entries.
 - Prevent diff machinery from examining worktree outside sparse
   checkout
 - ls-files: Add tests for --sparse and friends
 - update-index: add --checkout/--no-checkout to update
   CE_NO_CHECKOUT bit
 - update-index: refactor mark_valid() in preparation for new options
 - ls-files: add options to support sparse checkout
 - Introduce CE_NO_CHECKOUT bit
 - Extend index to save more flags

Recently updated with a repost.  Shawn says he's been too swamped at
day-job to actively review the series.  There has been some discussion =
on
list about it so its not stalled, but it needs more eyeballs.

----------------------------------------------------------------
[Stalled -- Needs Action to Proceed (or to be dropped)]

* pb/submodule (Fri Sep 12 23:09:19 2008 +0200) 1 commit
 - t7400: Add short "git submodule add" testsuite

Still waiting for a reroll.  Should be dropped next week if we don't
get one during this coming week.

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
[Will be merged to 'master' soon]

* pb/commit-where (Fri Oct 3 22:13:49 2008 -0400) 4 commits
 + tutorial: update output of git commit
 + reformat informational commit message
 + git commit: Reformat output somewhat
 + builtin-commit.c: show on which branch a commit was added

Shawn thinks this topic is settled for now, and I see that the new outp=
ut
format does not bother me very much, so please expect this to be merged
soon.

----------------------------------------------------------------
[Actively Cooking]

* tr/workflow-doc (Sat Sep 13 18:11:01 2008 +0200) 2 commits
 + Documentation: Refer to git-rebase(1) to warn against rewriting
 + Documentation: new upstream rebase recovery section in git-rebase

Shawn says that an update came in recently, but they are not here yet.
I'd need to dig it up, but I haven't had time.

* ns/rebase-noverify (Mon Oct 6 14:14:29 2008 +0900) 1 commit
 + rebase --no-verify

This adds --no-verify to git rebase, to avoid the pre-rebase hook.  Lac=
ks
documentation but otherwise looks sound.

* mv/merge-noff (Fri Oct 3 14:04:47 2008 +0200) 1 commit
 + builtin-commit: use reduce_heads() only when appropriate

=46ixes "git merge --no-ff --no-commit".

* ae/preservemerge (Mon Sep 29 22:28:57 2008 +0200) 1 commit
 + rebase: Support preserving merges in non-interactive mode

* sh/rebase-i-p (Wed Oct 8 01:41:57 2008 -0500) 7 commits
 - rebase-i-p: if todo was reordered use HEAD as the rewritten parent
 - rebase-i-p: do not include non-first-parent commits touching
   UPSTREAM
 - rebase-i-p: only list commits that require rewriting in todo
 - rebase-i-p: fix 'no squashing merges' tripping up non-merges
 - rebase-i-p: delay saving current-commit to REWRITTEN if squashing
 - rebase-i-p: use HEAD for updating the ref instead of mapping
   OLDHEAD
 - rebase-i-p: test to exclude commits from todo based on its parents

Changes the `rebase -i -p` behavior to behave like git sequencer's
rewrite of `rebase -i` would behave.

* sh/maint-rebase3 (Sun Oct 5 23:26:52 2008 -0500) 1 commit
 . rebase--interactive: fix parent rewriting for dropped commits

Tentatively dropped from everwhere, waiting for a reroll together with
sh/rebase-i-p.

* pb/rename-rowin32 (Sun Oct 12 21:01:23 2008 -0700) 2 commits
 - (squash): index-pack: do not unconditionally make packfile read-
   only
 - Do not rename read-only files during a push

Supposedly fixes pack file renames on Windows.  The (squash) patch is m=
y
attempt to fix its breakage.

* sp/describe-lwtag (Mon Oct 13 07:39:46 2008 -0700) 1 commit
 - describe: Make --tags and --all match lightweight tags more often

When the user gives --tags, the request is asking to treat lightweight =
and
annotated tags at equal weight, and if lightweight ones are closer, the=
y
should be used.

* gb/formatpatch-autonbr (Sun Oct 12 22:18:02 2008 -0700) 2 commits
 - (squash) adjust test vector for new behaviour of format-patch
 - format-patch: autonumber by default

* jk/diff-convfilter (Sun Oct 5 17:43:45 2008 -0400) 4 commits
 - diff: add filter for converting binary to text
 - diff: introduce diff.<driver>.binary
 - diff: unify external diff and funcname parsing code
 - t4012: use test_cmp instead of cmp

A general cleanup on how diff drivers are implemented.  Its still
missing documentation updates and tests but doesn't break anything
current as far as I can tell.  It needs more review before it can
be slated for 'next'.

* dp/checkattr (Tue Oct 7 04:16:52 2008 +0400) 2 commits
 + check-attr: Add --stdin option
 + check-attr: add an internal check_attr() function

Batch attr lookup via --stdin, for gitk and git-gui.

* mv/clonev (Thu Oct 9 01:40:32 2008 +0200) 1 commit
 + Implement git clone -v

Does what it says it does.  This may be ready for master soon,
its a pretty trivial change.

* gb/refactor-pathinfo (Fri Oct 10 20:42:26 2008 +0200) 1 commit
 + gitweb: refactor input parameters parse/validation

A major cleanup on the way gitweb parses its input arguments.
=46uture gitweb patches to add more arguments into the PATH_INFO
depend upon this initial cleanup work.

* ml/cygwin-filemode (Mon Oct 13 00:33:31 2008 -0400) 1 commit
 - compat/cygwin.c - Use cygwin's stat if core.filemode =3D=3D true

Is ready for 'next'.

* jn/gitweb-customlinks (Sun Oct 12 00:02:32 2008 +0200) 1 commit
 - gitweb: Better processing format string in custom links in navbar

Waiting for some sort of response from Pasky.

----------------------------------------------------------------
[On Hold]

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 - revision --simplify-merges: incremental simplification
 - revision --simplify-merges: prepare for incremental simplification

I started making this incremental but the progress is not
so great.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 . git-am --forge: add Signed-off-by: line for the author
 . git-am: clean-up Signed-off-by: lines
 . stripspace: add --log-clean option to clean up signed-off-by:
   lines
 . stripspace: use parse_options()
 . Add "git am -s" test
 . git-am: refactor code to add signed-off-by line for the committer

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

This seems to have a deadlock during communication between the peers.
Someone needs to pick up this topic and resolve the deadlock before it =
can
continue.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use,
but gitk will be hit due to tcl/tk's limitation, so I am holding
this back for now.
