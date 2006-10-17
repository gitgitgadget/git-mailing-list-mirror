From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.2.4
Date: Mon, 16 Oct 2006 22:31:56 -0700
Message-ID: <7vvemjqzhv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 07:32:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZhYa-0000aF-8Q
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 07:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423114AbWJQFb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 01:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423116AbWJQFb7
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 01:31:59 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:37255 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1423114AbWJQFb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 01:31:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017053157.SEPL6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 01:31:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bHXj1V01L1kojtg0000000
	Tue, 17 Oct 2006 01:31:45 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29025>

The latest maintenance release GIT 1.4.2.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.2.4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.2.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.2.4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.2.4-1.$arch.rpm	(RPM)

We are close to 1.4.3, so this update coulc become moot very
soon, but just in case we have to delay it, I am pushing this
out for a rather important performance fix.  Without it, "git
diff" on 64-bit machines can run 100x times slower than it
should be on unfortunate input.

Many thanks go to Jim Mayering for giving an easy to reproduce
initial problem report, and Linus and Davide Libenzi to quickly
come up with a fix.

Unfortunately I do not have access to any RPM capable machine
other than an x86-64 right now hence there is no RPM for x86-32
for this release yet (but 32-bit machines do not need this fix
to begin with, so it's Ok).

----------------------------------------------------------------

There is only one change since v1.4.2.3.

Linus Torvalds:
      Fix hash function in xdiff library
