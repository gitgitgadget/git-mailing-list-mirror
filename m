From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.9c
Date: Thu, 03 Nov 2005 20:04:02 -0800
Message-ID: <7vwtjp2h59.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 04 05:05:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXsoZ-0005mN-Dc
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 05:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbVKDEEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 23:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbVKDEEF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 23:04:05 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:57496 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030550AbVKDEEE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 23:04:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104040341.DTYW4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 23:03:41 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11120>

GIT 0.99.9c is found at http://kernel.org/pub/software/scm/git/
as usual.  It includes the following fixes and documentation
updates since 0.99.9b:

	Alex Riesen:
	      remove CR/LF from .gitignore

	Jon Loeliger
	      Illustration: "Fundamental Git Index Operations"
	      Illustration: "Git Diff Types"
	      Illustration: "Commit DAG Revision Naming"

	Junio C Hamano:
	      Do not put automatic merge message after signed-off-by line.
	      git-clone: do not forget to create origin branch.
	      Make test-date buildable again.
	      Do not fail on hierarchical branch names.
	      Ignore '\r' at the end of line in $GIT_DIR/config
	      Be careful when dereferencing tags (credits Pasky).
	      Document --since and --until options to rev-parse.
	      Add --no-commit to git-merge/git-pull.
	      Add 'ours' merge strategy.
	      git-merge-ours: make sure our index matches HEAD
	      GIT 0.99.9c

	Peter Eriksen:
	      Clean up the SunOS Makefile rule

The slow and steady march toward 1.0 continues.  

I plan to do another full sweep in the documentation directory
on my next GIT day.

On the proposed updates front, I am hoping to include Nick's
http-push using DAV in the "master" branch soon.  And I would
appreciate somebody who actually uses svnimport to Ack on
Yaacov's svnimport fix.
