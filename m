From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.2.3
Date: Mon, 02 Oct 2006 01:17:19 -0700
Message-ID: <7vu02nw2r4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 10:17:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUIzT-0003wx-Hx
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 10:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWJBIRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 04:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWJBIRV
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 04:17:21 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35529 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750835AbWJBIRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 04:17:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061002081720.NNZT6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Oct 2006 04:17:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VLHE1V00E1kojtg0000000
	Mon, 02 Oct 2006 04:17:14 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28221>

The latest maintenance release GIT 1.4.2.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.2.3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.2.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.2.3.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.2.3-1.$arch.rpm	(RPM)

Sorry to be doing two maintenance releases in rapid succession,
but git-mv breakage causes random tree corruption and is rather
serious.

----------------------------------------------------------------

Changes since v1.4.2.2 are as follows:

Junio C Hamano:
      git-mv: invalidate the removed path properly in cache-tree
      git-push: .git/remotes/ file does not require SP after colon
