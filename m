From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 13 Jun 2007 13:29:57 -0700
Message-ID: <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	<7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	<7virac547s.fsf@assigned-by-dhcp.cox.net>
	<7v6466oygl.fsf@assigned-by-dhcp.cox.net>
	<7vfy54tt3l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 22:30:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyZTe-0004kt-Af
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 22:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbXFMUaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 16:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754989AbXFMUaA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 16:30:00 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56791 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbXFMU37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 16:29:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613202958.JFRW2558.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 Jun 2007 16:29:58 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B8Vx1X00X1kojtg0000000; Wed, 13 Jun 2007 16:29:58 -0400
In-Reply-To: <7vfy54tt3l.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 06 Jun 2007 19:07:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50127>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* lh/submodule (Tue Jun 12 09:05:21 2007 +0200) 5 commits
 + Add gitmodules(5)
 + git-submodule: give submodules proper names
 + Rename sections from "module" to "submodule" in .gitmodules
 + git-submodule: remember to checkout after clone
 + t7400: barf if git-submodule removes or replaces a file

Soon to be merged to 'master' as 1.5.3 material, but still needs a
trivial fix to the Documentation/gitmodules.txt, though.

* js/filter (Fri Jun 8 23:28:50 2007 +0200) 11 commits
 + filter-branch: subdirectory filter needs --full-history
 + filter-branch: Simplify parent computation.
 + Teach filter-branch about subdirectory filtering
 + filter-branch: also don't fail in map() if a commit cannot be
   mapped
 + filter-branch: Use rev-list arguments to specify revision ranges.
 + filter-branch: fix behaviour of '-k'
 + filter-branch: use $(($i+1)) instead of $((i+1))
 + chmod +x git-filter-branch.sh
 + filter-branch: prevent filters from reading from stdin
 + t7003: make test repeatable
 + Add git-filter-branch

Soon to be merged to 'master' as 1.5.3 material, but still needs
documentation, and culling of empty side branches.

* fl/cvsserver (Thu Jun 7 16:57:01 2007 +0200) 1 commit
 + cvsserver: Add some useful commandline options

To merge.

* gp/branch (Sat Jun 9 12:40:35 2007 +0000) 1 commit
 + git-branch: cleanup config file when deleting branches

To merge.

* jc/remote (Sat Jun 9 11:01:23 2007 -0700) 6 commits
 + git-push: Update description of refspecs and add examples
 + remote.c: "git-push frotz" should update what matches at the
   source.
 + remote.c: fix "git push" weak match disambiguation
 + remote.c: minor clean-up of match_explicit()
 + remote.c: refactor creation of new dst ref
 + remote.c: refactor match_explicit_refs()

To merge; this is an fix to fairly annoying breakage.

* ew/svn (Wed Jun 13 02:23:28 2007 -0700) 1 commit
 + git-svn: allow dcommit to retain local merge information

Hoping to be able to merge it to 'master', as it would be a big
usability improvement for people who use "git to merge because
SVN cannot" (without this, life ater such a merge will
unfortunately be miserable).

* jk/add-empty (Tue Jun 12 23:42:14 2007 +0200) 2 commits
 + builtin-add: simplify (and increase accuracy of) exclude handling
 + dir_struct: add collect_ignored option

Hoping to be able to merge them to 'master', but haven't
convinced myself that these changes are correct.  Help is
appreciated.

* jc/oneline (Mon Jun 11 22:10:55 2007 -0700) 2 commits
 + Extend --pretty=oneline to cover the first paragraph,
 + Lift 16kB limit of log message output

Hoping to be able to merge them to 'master', but haven't
convinced myself that these changes are correct.  Help is
appreciated.

* jo/init (Thu Jun 7 07:50:30 2007 -0500) 2 commits
 - Quiet the output from git-init when cloning, if requested.
 - Add an option to quiet git-init.

Undecided.  I do not have anything against these two patches, as
they are obviously correct.  It's just the fact that nobody
complained my keeping these packed on 'pu' suggests there is not
much desire, and it is an extra option we need to maintain.

* ei/worktree+filter (Wed Jun 6 09:16:56 2007 +0200)
 - filter-branch: always export GIT_DIR if it is set
* ml/worktree (Fri Jun 8 22:57:55 2007 +0200) 9 commits
 - make git barf when an alias changes environment variables
 - setup_git_directory: fix segfault if repository is found in cwd
 - test GIT_WORK_TREE
 - extend rev-parse test for --is-inside-work-tree
 - Use new semantics of is_bare/inside_git_dir/inside_work_tree
 - introduce GIT_WORK_TREE to specify the work tree
 - test git rev-parse
 - rev-parse: introduce --is-bare-repository
 - rev-parse: document --is-inside-git-dir

Undecided.  Some people would want to have a way to have GIT_DIR
point at somewhere unusual and still want to work from within a
subdirectory, which is probably a valid thing to support.  This
is not something I would use myself, so I am mostly worried
about the impact these changes may have on people who do not use
this feature.
