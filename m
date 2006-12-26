From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable) and announcing GIT 1.5.0 preview
Date: Mon, 25 Dec 2006 19:22:04 -0800
Message-ID: <7v3b73gx43.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 04:22:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz2tP-0003AF-RK
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 04:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWLZDWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 22:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWLZDWI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 22:22:08 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:37825 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbWLZDWG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 22:22:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061226032205.RTUV20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 Dec 2006 22:22:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3FNJ1W00h1kojtg0000000; Mon, 25 Dec 2006 22:22:18 -0500
To: git@vger.kernel.org
X-maint-at: e6d40d65df07059fc655fabe62fa5b575ead7815
X-master-at: d5e86da89155b462c30a59bc724037fb111d3894
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35406>

GIT v1.5.0 preview

This is not yet -rc1 where all new topics close, but I think it
is getting pretty closer.  I'd still want to merge updates to
fsck/prune to honor reflog entries before -rc1.

I think there are quite a lot of documentation updates remaining
after that.  There is no patch for "fixed HEAD" yet, and while I
would not object people to try to get it working in time, it is
purely a feature enhancement and does not have backward
compatibility issues, so it does not have to block v1.5.0; it
can wait for later releases.  So is sliding mmap().


* The 'master' branch has these since the last announcement.

   Alexandre Julliard (1):
      vc-git: Ignore errors caused by a non-existent directory
          in vc-git-registered.

   Brian Gernhardt (2):
      Keep "git --git-dir" from causing a bus error.
      Make git-show-branch options similar to git-branch.

   Eric Wong (3):
      Remove NO_ACCURATE_DIFF options from build systems
      git-svn: enable common fetch/commit options for dcommit
      Makefile: add quick-install-doc for installing pre-built manpages

   Johannes Schindelin (4):
      move read_mmfile() into xdiff-interface
      Add a test for git-rerere
      Make git-rerere a builtin
      commit-tree: encourage UTF-8 commit messages.

   Junio C Hamano (19):
      git-add --interactive
      git-add --interactive: hunk splitting
      revision: --skip=<n>
      merge and reset: adjust for "reset --hard" messages
      default pull: forget about "newbie protection" for now.
      Do not support "partial URL shorthand" anymore.
      Really fix headers for __FreeBSD__
      git-tag: lose exit after die
      Allow branch.*.merge to talk about remote tracking branches.
      git-add --interactive: add documentation
      match_pathspec() -- return how well the spec matched
      git-rm: update to saner semantics
      t3600: update the test for updated git rm
      git-rm: Documentation
      read_directory: show_both option.
      git-add: add ignored files when asked explicitly.
      git-add: warn when adding an ignored file with an explicit request.
      git-add -f: allow adding otherwise ignored files.
      GIT v1.5.0 preview

   Nicolas Pitre (1):
      checkout: make the message about the need for a new branch a bit clearer

   Robert Fitzsimons (16):
      gitweb: Add missing show '...' links change.
      gitweb: optimize git_get_last_activity.
      gitweb: optimize git_shortlog_body.
      gitweb: optimize git_summary.
      gitweb: Use rev-list pattern search options.
      gitweb: Require a minimum of two character for the search text.
      gitweb: Allow search to be disabled from the config file.
      gitweb: Paginate commit/author/committer search output
      gitweb: Add parse_commits, used to bulk load commit objects.
      gitweb: We do longer need the --parents flag in rev-list.
      gitweb: Change summary, shortlog actions to use parse_commits.
      gitweb: Change log action to use parse_commits.
      gitweb: Change header search action to use parse_commits.
      gitweb: Change atom, rss actions to use parse_commits.
      gitweb: Change history action to use parse_commits.
      gitweb: Use rev-list --skip option.

   Shawn Pearce (4):
      Use extended SHA1 syntax in merge-recursive conflicts.
      Display 'theirs' branch name when possible in merge.
      Rename gitfakemmap to git_mmap.
      Switch git_mmap to use pread.
