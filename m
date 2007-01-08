From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.4.4
Date: Sun, 07 Jan 2007 19:30:50 -0800
Message-ID: <7v7ivyyz2t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 04:30:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3lDr-0003pm-Ud
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 04:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbXAHDaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 22:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbXAHDaw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 22:30:52 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32861 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030470AbXAHDav (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 22:30:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108033051.DTZO2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jan 2007 22:30:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8TW11W0061kojtg0000000; Sun, 07 Jan 2007 22:30:01 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36232>

The latest maintenance release GIT 1.4.4.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.4.4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.4.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.4.4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.4.4-1.$arch.rpm	(RPM)

This is to push out a handful bugfixes since 1.4.4.3.

On the 'master' development front, the stabilization for v1.5.0
will start soonish.

----------------------------------------------------------------

Changes since v1.4.4.3 are as follows:

Johannes Schindelin (1):
      diff --check: fix off by one error

Junio C Hamano (3):
      spurious .sp in manpages
      Fix infinite loop when deleting multiple packed refs.
      pack-check.c::verify_packfile(): don't run SHA-1 update on huge data
