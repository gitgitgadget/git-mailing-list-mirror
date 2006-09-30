From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.2.2
Date: Fri, 29 Sep 2006 23:53:41 -0700
Message-ID: <7v8xk1j156.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 08:53:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTYjN-0006aK-MS
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 08:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWI3Gxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 02:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWI3Gxn
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 02:53:43 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:42434 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751076AbWI3Gxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 02:53:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930065342.NNDU6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Sep 2006 02:53:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UWtd1V00K1kojtg0000000
	Sat, 30 Sep 2006 02:53:38 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28140>

The latest maintenance release GIT 1.4.2.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.2.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.2.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.2.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.2.2-1.$arch.rpm	(RPM)

This is strictly a bugfix release.  While we will soon be in
stabilization slow-down for 1.4.3, one of the bugs this release
contains fixes for actually has bitten people who use the kernel
commits mailing list, so this is to push the fixes out early.

----------------------------------------------------------------

Changes since v1.4.2.1 are as follows:

Junio C Hamano:
      Fix git-am safety checks
      git-diff -B output fix.

Liu Yubao:
      Fix duplicate xmalloc in builtin-add
