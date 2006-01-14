From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.1.2
Date: Fri, 13 Jan 2006 20:53:29 -0800
Message-ID: <7vd5ivwgty.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 14 05:53:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExdQ1-0000MP-2g
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 05:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423035AbWANExd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 23:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423061AbWANExd
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 23:53:33 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:43427 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1423035AbWANExc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 23:53:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060114045113.MGGP17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 23:51:13 -0500
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14661>

The latest maintenance release GIT 1.1.2 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.1.2.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.1.2-1.$arch.rpm	(RPM)

----------------------------------------------------------------

Changes since v1.1.1 are as follows:

J. Bruce Fields:
      Documentation: clarify fetch parameter descriptions.

Junio C Hamano:
      update-index: work with c-quoted name
      describe: do not silently ignore indescribable commits
      name-rev: do not omit leading components of ref name.
      show-branch: handle [] globs as well.
      Documentation: git-commit -a
      Documentation: git-reset - interrupted workflow.

Tom Prince:
      Add git-describe to .gitignore.

----------------------------------------------------------------

These have been added to the "master" branch lately, in addition
to all of the above fixes:

      Makefile: add 'strip' target.
      octopus: allow criss-cross and clarify the message when it rejects.
      checkout: automerge local changes while switching branches.
      checkout: merge local modifications while switching branches.
      git-push: avoid falling back on pushing "matching" refs.
      Exec git programs without using PATH (Michal Ostrowski)
      Fix the installation location.

These are still waiting their turn in the proposed updates
("pu") branch:

      git-cvsimport: Add -A <author-conv-file> option (Andreas Ericsson)
      convert-packs: futureproofing.
      Require packfiles to follow the naming convention (preparation).
      format-patch: always --mbox and show sane Date:
      octopus: allow manual resolve on the last round.
      Documentation: show-branch.
      show-branch: make the current branch and merge commits stand out.
      Disable USE_SYMLINK_HEAD by default (Pavel Roskin)
