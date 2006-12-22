From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Fri, 22 Dec 2006 01:25:52 -0800
Message-ID: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 22 10:26:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxgfE-00062z-EW
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 10:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946001AbWLVJZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 04:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946005AbWLVJZy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 04:25:54 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60680 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946001AbWLVJZx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 04:25:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222092553.NJAX7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 04:25:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1lRA1W0031kojtg0000000; Fri, 22 Dec 2006 04:25:10 -0500
To: git@vger.kernel.org
X-maint-at: e6d40d65df07059fc655fabe62fa5b575ead7815
X-master-at: 2295e8d0c4cec41fbe257ddb957516a7c1a139df
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35152>

I guess I'll need to push another maintenance release out soon,
if only to fix the manual pages.

On the 'master' front there are a handful more topics pushed out
from 'next'.  I still need to apply the __FREEBSD__ fix yet, but
otherwise we should be able to start calming things down.

* The 'maint' branch has these fixes since the last announcement.

   Johannes Schindelin (1):
      diff --check: fix off by one error

   Junio C Hamano (1):
      spurious .sp in manpages

* The 'master' branch has these since the last announcement.

   Eric Wong (3):
      git-svn: convert to using Git.pm
      git-svn: remove support for the svn command-line client
      git-svn: rename 'commit' command to 'set-tree'

   Johannes Schindelin (5):
      Introduce GIT_TEMPLATE_DIR
      diff --check: fix off by one error
      Use git-merge-file in git-merge-one-file, too
      git-tag: support -F <file> option
      git-reset --hard: tell the user what the HEAD was reset to

   Josef Weidendorfer (1):
      Move "no merge candidate" warning into git-pull

   Junio C Hamano (22):
      git-clone: use wildcard specification for tracking branches
      git-pull: refuse default merge without branch.*.merge
      git-clone: lose the artificial "first" fetch refspec
      git-clone: lose the traditional 'no-separate-remote' layout
      rev-list --left-right
      Teach all of log family --left-right output.
      Make left-right automatic.
      fix testsuite: make sure they use templates freshly built from the source
      Teach git-branch to delete tracking branches with -r -d
      blame: -b (blame.blankboundary) and --root (blame.showroot)
      Revert "fix testsuite: make sure they use templates freshly
        built from the source"
      Do not create $GIT_DIR/remotes/ directory anymore.
      Use preprocessor constants for environment variable names.
      Revert "Make left-right automatic."
      git-add: error out when given no arguments.
      spurious .sp in manpages
      compat/inet_ntop: do not use u_int
      diff documentation: mostly talk about <commit>
      Revert "git-pull: refuse default merge without branch.*.merge"
      parse-remote: mark all refs not for merge only when fetching more
        than one
      _XOPEN_SOURCE problem also exists on FreeBSD
      commit-tree: do not overflow MAXPARENT

   Quy Tonthat (2):
      git-branch -d: do not stop at the first failure.
      Documentation/git-branch: new -r to delete remote-tracking branches.

   Shawn Pearce (3):
      Suggest 'add' in am/revert/cherry-pick.
      Rename imap-send's internal info/warn functions.
      Introduce a global level warn() function.

   Terje Sten Bjerkseth (1):
      Fix system header problems on Mac OS X
