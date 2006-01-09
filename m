From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUCNE] GIT 1.1.0
Date: Sun, 08 Jan 2006 17:20:49 -0800
Message-ID: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 02:21:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvliU-0007yv-5t
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 02:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWAIBUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 20:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWAIBUy
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 20:20:54 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:2481 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751501AbWAIBUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2006 20:20:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109011827.IYUM17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 Jan 2006 20:18:27 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14343>

The latest feature release GIT 1.1.0 is available at the usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.1.0.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.1.0-1.$arch.rpm	(RPM)

This contains all the fixes present in 1.0.8, with the following
enhancements:

 - "git clone -o $name" can name a branch other than "origin" to
   be used to keep track of upstream (Johannes).

 - Easier shared repository setup (Johannes).

 - "git describe" command (Linus).

 - "git --version" from an interim snapshot gives a more
   descriptive version name than "1.0-GIT" (Linus).

 - "git whatchanged" shows abbreviated object names by default.

 - "git checkout -- paths" and "git checkout treeish paths" use
   cwd relative pathname and work from a subdirectory.

 - "git checkout [-b newbranch] branch" works from a
   subdirectory and works on the entire tree.

 - "git ls-tree" shows cwd relative pathnames by default; full
   pathnames can be obtained with --full-name, just like "git
   ls-files" (Linus and me).

 - "git send-pack" and "git push" notice when the remote end
   refuses to update a ref (e.g. hooks/update) and exits with an
   error.  This hopefully would help Cogito as well.

 - "git fetch" and "git pull" automatically follows remote tags
   while tracking branches.

 - "git ls-files --others" can be used with "--directory" option
   to omit the contents of directories without any tracked file
   but instead to show the directories themselves (Linus).  "git
   status" uses this to unclutter "Untracked files" section.

 - Optimized "git pack-redundant" (Lukas).

 - "git daemon --base-path=/pub/git" can reroot the directory
   tree exposed to the outside world, similar to DOCUMENT_ROOT
   (Pasky).

 - "git cherry" can be told not to show everything we have (Yann
   Dirson).

 - git URL can use [IPv6address/IPvFuture] literal addresses
   (Hideaki).
