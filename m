X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	SUBJ_ALL_CAPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.3.3
Date: Wed, 25 Oct 2006 15:45:27 -0700
Message-ID: <7v7iyokoag.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 22:45:38 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30119>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcrV7-0002Km-HR for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965247AbWJYWpa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbWJYWpa
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:45:30 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27792 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S965248AbWJYWp3
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:45:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025224528.JWX22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 18:45:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id emlA1V00h1kojtg0000000 Wed, 25 Oct 2006
 18:45:11 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The latest maintenance release GIT 1.4.3.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.3.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3.3-1.$arch.rpm	(RPM)

Sorry to be doing three follow-up releases in a row.  This is
primarily fix the partitioning of programs in generated RPM.  If
you are installing all of git it does not matter, but by mistake
we were placing git-archive into git-arch subpackage, which
meant that you need to install tla only to use git-tar-tree and
git-archive --format=zip.

Thanks for Gerrit for noticing and reporting it, although he is
from Debian camp ;-).

----------------------------------------------------------------

Changes since v1.4.3.2 are as follows:

Eric Wong (1):
      git-svn: fix symlink-to-file changes when using command-line svn 1.4.0

Gerrit Pape (1):
      Set $HOME for selftests

Junio C Hamano (5):
      Documentation: note about contrib/.
      RPM package re-classification.
      Refer to git-rev-parse:Specifying Revisions from git.txt
      Update cherry documentation.
      Documentation/SubmittingPatches: 3+1 != 6

Petr Baudis (1):
      xdiff: Match GNU diff behaviour when deciding hunk comment worthiness of lines

Tuncer Ayaz (1):
      git-fetch.sh printed protocol fix

