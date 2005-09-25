From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.7d, and end of week status.
Date: Sun, 25 Sep 2005 01:36:25 -0700
Message-ID: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 25 10:37:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJRzs-0006A9-7u
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 10:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVIYIg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 04:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVIYIg3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 04:36:29 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:18656 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751245AbVIYIg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 04:36:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050925083625.NTMC29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Sep 2005 04:36:25 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9262>

* The fourth minor fix release, GIT 0.99.7d, is available at the
  usual places.

  RPMs and Debs are found in http://kernel.org/pub/software/scm/

  With git:

  $ git fetch http://kernel.org/pub/scm/git/git.git tag v0.99.7d
  $ git checkout -b <new-branch> v0.99.7d

  Fixes since 0.99.7c are:

  - Fix show-branch output that named commits incorrectly.
  - Fix git-grep -e not passing -e to underlying grep.

* Recent updates to the master branch includes:

  - The GIT_VERSION is now 0.99.7.GIT (thanks Pasky for the
    idea).

  - The symlinks for backward compatible names are not installed
    anymore (but existing ones are not automatically removed).

  - git-diff-* family acquired a new option, --name-status, to
    show the status and name for changed files.  Also -l<num>
    option disables rename/copy detection when the number of
    rename target candidates are more than <num> (idea by Linus
    some time ago).

* Proposed updates, not yet graduated to the master branch
  includes:

  - git-merge fix, not to require a clean tree.

  - Likewise for git-revert and git-cherry-pick fix, not to
    require a clean tree.

  - Use git-merge from git-pull, again.

  - A couple of test fixes for further Solaris portability.

  - update-index takes -z --stdin to read NUL terminated list of
    paths from the standard input instead of from the command
    line.  This is to help platforms with xargs that cannot grok
    -0.  git-commit is updated to use this.
