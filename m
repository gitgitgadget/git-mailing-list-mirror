From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2009, #01; Mon, 05)
Date: Mon, 05 Jan 2009 22:33:08 -0800
Message-ID: <7vbpulnduj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 07:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK5WU-000454-Nb
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 07:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbZAFGdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 01:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbZAFGdS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 01:33:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZAFGdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 01:33:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F25608D4F7;
	Tue,  6 Jan 2009 01:33:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5E6F78D4F6; Tue,
  6 Jan 2009 01:33:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E5AE6FC6-DBBB-11DD-ADDC-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104639>

What's cooking in git.git (Jan 2009, #01; Mon, 05)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The ones marked with '.' do not appear in any of the branches,
but I am still holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

Sorry to have been lagging a bit.  There are a few patches I am interested
in but haven't studied yet nor mentioned here.  I've been swamped outside
git lately for the past few days, but hopefully I can get to them shortly.

----------------------------------------------------------------
[New Topics]

* js/bundle-tags (Fri Jan 2 19:08:46 2009 +0100) 1 commit
 + bundle: allow rev-list options to exclude annotated tags

* js/add-not-submodule (Fri Jan 2 19:08:40 2009 +0100) 1 commit
 + git add: do not add files from a submodule

* pb/maint-git-pm-false-dir (Mon Dec 29 01:25:00 2008 +0100) 1 commit
 + Git.pm: correctly handle directory name that evaluates to "false"

* pj/maint-ldflags (Sun Jan 4 21:27:41 2009 -0500) 1 commit
 + configure clobbers LDFLAGS

* fe/cvsserver (Fri Jan 2 16:40:14 2009 +0100) 2 commits
 + cvsserver: change generation of CVS author names
 + cvsserver: add option to configure commit message

* js/maint-bisect-gitk (Fri Jan 2 19:08:00 2009 +0100) 1 commit
 + bisect view: call gitk if Cygwin's SESSIONNAME variable is set

* np/no-loosen-prune-expire-now (Tue Dec 30 14:45:11 2008 -0500) 1 commit
 + objects to be pruned immediately don't have to be loosened

* cb/maint-unpack-trees-absense (Thu Jan 1 21:54:33 2009 +0100) 3 commits
 + unpack-trees: remove redundant path search in verify_absent
 + unpack-trees: fix path search bug in verify_absent
 + unpack-trees: handle failure in verify_absent

* mc/cd-p-pwd (Tue Dec 30 07:10:24 2008 -0800) 1 commit
 + git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on
   OS X

All of the above are good fixes and clean-ups; will be fast-tracked to
'master' and maintenance branches as appropriate.

* mv/apply-parse-opt (Sun Dec 28 00:03:57 2008 +0100) 1 commit
 + parse-opt: migrate builtin-apply.

* mh/cherry-default (Thu Jan 1 22:56:29 2009 +0100) 2 commits
 + Documentation: clarify which parameters are optional to git-cherry
 + git-cherry: make <upstream> parameter optional

* rs/maint-shortlog-foldline (Mon Dec 29 23:15:50 2008 +0100) 1 commit
 - [Need tidying up the log] pretty: support multiline subjects with
   format:

* tr/rebase-root (Fri Jan 2 23:28:29 2009 +0100) 4 commits
 - rebase: update documentation for --root
 - rebase -i: learn to rebase root commit
 - rebase: learn to rebase root commit
 - rebase -i: execute hook only after argument checking

I should be able to find time to read this over again and merge to
'next' sometime this week.

* as/autocorrect-alias (Sun Jan 4 18:16:01 2009 +0100) 1 commit
 + git.c: make autocorrected aliases work

* as/commit-signoff (Mon Dec 29 12:16:45 2008 +0100) 1 commit
 - [WIP] Add a commit.signoff configuration option to always use --
   signoff in commit

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* wp/add-patch-find (Thu Nov 27 04:08:03 2008 +0000) 3 commits
 . In add --patch, Handle K,k,J,j slightly more gracefully.
 . Add / command in add --patch
 . git-add -i/-p: Change prompt separater from slash to comma

Will discard and wait for a resubmit.

* kb/am-directory (Fri Aug 29 15:27:50 2008 -0700) 1 commit
 . git-am: Pass the --directory option through to git-apply

A reroll of this by Simon Schubert triggered a series to fix a parameter
propagation bug, and another reroll to add "git am --directory=path/"
should be much easier now.  I am not likely to use the feature myself, so
it is up to intrested volunteers to carry it forward.

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 1 commit
 - autoconf: Enable threaded delta search when pthreads are supported

This automatically enables threaded delta search code when autoconf
detects pthreads are usable.  I haven't heard neither positive nor
negative comments from minority platforms that might be harmed, but
this feels like the right thing to do, so perhaps the best course of
action is to merge this down to 'master' and see if anybody screams.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _before_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  The line number in the "previous" information
may need refining, and sanity checking code for reference counting may
need to be resurrected before this can move forward.

----------------------------------------------------------------
[Actively cooking]

* nd/grep-assume-unchanged (Sat Dec 27 15:21:03 2008 +0700) 2 commits
 + grep: grep cache entries if they are "assume unchanged"
 + grep: support --no-ext-grep to test builtin grep

* as/maint-shortlog-cleanup (Tue Dec 30 22:01:44 2008 +0100) 1 commit
 + builtin-shortlog.c: use string_list_append(), and don't strdup
   unnecessarily

* jc/maint-ls-tree (Wed Dec 31 19:00:50 2008 +0900) 2 commits
 + Document git-ls-tree --full-tree
 + ls-tree: add --full-tree option

* js/notes (Sat Dec 20 13:06:03 2008 +0100) 4 commits
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

* gb/gitweb-patch (Thu Dec 18 08:13:19 2008 +0100) 4 commits
 - gitweb: link to patch(es) view in commit(diff) and (short)log view
 - gitweb: add patches view
 - gitweb: change call pattern for git_commitdiff
 - gitweb: add patch view

----------------------------------------------------------------
[Graduated to "master"]

* cb/mergetool (Fri Dec 12 21:48:41 2008 +0000) 4 commits
 + mergetool: Don't keep temporary merge files unless told to
 + mergetool: Add prompt to continue after failing to merge a file
 + Add -y/--no-prompt option to mergetool
 + Fix some tab/space inconsistencies in git-mergetool.sh

----------------------------------------------------------------
[Will merge to "master" soon]

* mh/maint-sendmail-cc-doc (Mon Dec 29 00:37:25 2008 +0100) 1 commit
 + doc/git-send-email: mention sendemail.cc config variable

* rs/diff-ihc (Sun Dec 28 19:45:32 2008 +0100) 1 commit
 + diff: add option to show context between close hunks

* js/maint-merge-recursive-r-d-conflict (Mon Dec 22 23:10:20 2008 +0100) 1 commit
 + merge-recursive: mark rename/delete conflict as unmerged

* mk/gitweb-feature (Mon Dec 15 22:16:19 2008 -0800) 1 commit
 + gitweb: unify boolean feature subroutines

* cb/merge-recursive-fix (Mon Dec 15 02:41:24 2008 -0800) 3 commits
 + Merge branch 'cb/maint-merge-recursive-fix' into cb/merge-
   recursive-fix
 + merge-recursive: do not clobber untracked working tree garbage
 + modify/delete conflict resolution overwrites untracked file

* cb/maint-merge-recursive-fix (Sun Dec 14 19:40:09 2008 -0800) 2 commits
 + merge-recursive: do not clobber untracked working tree garbage
 + modify/delete conflict resolution overwrites untracked file

* wp/add-p-goto (Thu Dec 4 10:22:40 2008 +0000) 2 commits
 + Add 'g' command to go to a hunk
 + Add subroutine to display one-line summary of hunks

* jn/gitweb-blame (Thu Dec 11 01:33:29 2008 +0100) 3 commits
 + gitweb: cache $parent_commit info in git_blame()
 + gitweb: A bit of code cleanup in git_blame()
 + gitweb: Move 'lineno' id from link to row element in git_blame

* mv/um-pdf (Wed Dec 10 23:44:50 2008 +0100) 1 commit
 + Add support for a pdf version of the user manual

* kk/maint-http-push (Tue Dec 23 11:31:15 2008 +0300) 1 commit
 + http-push: support full URI in handle_remote_ls_ctx()

----------------------------------------------------------------
[On Hold]

* nd/narrow (Sun Nov 30 17:54:38 2008 +0700) 17 commits
 - wt-status: show sparse checkout info
 - Introduce default sparse patterns (core.defaultsparse)
 - checkout: add new options to support sparse checkout
 - clone: support sparse checkout with --sparse-checkout option
 - unpack_trees(): add support for sparse checkout
 - unpack_trees(): keep track of unmerged entries
 - Introduce "sparse patterns"
 - Merge branch 'master' into nd/narrow
 - t2104: touch portability fix
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

Will drop shortly, but there may be some other fixes to CE_VALID, like
nd/grep-assume-unchanged topic above, that we may want to resurrect.

* jc/clone-symref-2 (Sat Nov 29 23:38:21 2008 -0800) 7 commits
 - clone: test the new HEAD detection logic
 - Merge commit 'HEAD@{2}' into HEAD
 - upload-pack: send the HEAD information
 - clone: find the current branch more explicitly
 - connect.c::read_extra_info(): find where HEAD points at
 - connect.c::read_extra_info(): prepare to receive more than server
   capabilities
 - get_remote_heads(): refactor code to read "server capabilities"

An attempt to extend the fetch protocol to make the logic to detect where
HEAD on the origin site points to more robust.  Will drop shortly as the
protocol extension was not very popular.

* cc/bisect-replace (Mon Nov 24 22:20:30 2008 +0100) 9 commits
 - bisect: add "--no-replace" option to bisect without using replace
   refs
 - rev-list: make it possible to disable replacing using "--no-
   bisect-replace"
 - bisect: use "--bisect-replace" options when checking merge bases
 - merge-base: add "--bisect-replace" option to use fixed up revs
 - commit: add "bisect_replace_all" prototype to "commit.h"
 - rev-list: add "--bisect-replace" to list revisions with fixed up
   history
 - Documentation: add "git bisect replace" documentation
 - bisect: add test cases for "git bisect replace"
 - bisect: add "git bisect replace" subcommand

Will drop and replace it with the resubmitted series when it comes.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

This seems to have a deadlock during communication between the peers.
Will drop shortly.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use,
but gitk will be hit due to tcl/tk's limitation, so I am holding
this back for now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer
