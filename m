From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.2.1
Date: Wed, 13 Sep 2006 12:19:21 -0700
Message-ID: <7vsliv8thi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 21:19:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNaGd-0002Cx-AW
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 21:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWIMTTX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 15:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWIMTTX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 15:19:23 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54449 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751138AbWIMTTW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 15:19:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913191922.BPKJ22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 15:19:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MvKB1V0091kojtg0000000
	Wed, 13 Sep 2006 15:19:11 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26935>

The latest maintenance release GIT 1.4.2.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.2.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.2.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.2.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.2.1-1.$arch.rpm	(RPM)

This release is primarily for these two fixes:

 * git-mv was broken.  Notably, this did not work:

	git-mv foo foo-renamed

 * git-http-fetch failed to follow objects/info/alternates on
   the remote side.  This broke a fetch from Paul's powerpc.git
   repository.

I have built i386 and x86_64 RPM this time, since the machine I
do the former has become available again.

----------------------------------------------------------------

Changes since v1.4.2 are as follows:

Dennis Stosberg:
      Solaris does not support C99 format strings before version 10

Johannes Schindelin:
      git-mv: succeed even if source is a prefix of destination
      git-mv: add more path normalization
      git-mv: special case destination "."
      git-mv: fix off-by-one error
      builtin-mv: readability patch

Junio C Hamano:
      finish_connect(): thinkofix
      http-fetch: fix alternates handling.

Luben Tuikov:
      Fix regex pattern in commit-msg
      sample commit-msg hook: no silent exit on duplicate Signed-off-by lines
