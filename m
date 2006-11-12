X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	SUBJ_ALL_CAPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.3.5
Date: Sat, 11 Nov 2006 21:23:20 -0800
Message-ID: <7v64dli6gn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 05:23:31 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31255>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj7oV-0003zJ-7X for gcvg-git@gmane.org; Sun, 12 Nov
 2006 06:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754974AbWKLFXW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 00:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754970AbWKLFXW
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 00:23:22 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56468 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1752694AbWKLFXV
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 00:23:21 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061112052320.EXOA97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Sun, 12
 Nov 2006 00:23:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id lhNv1V00S1kojtg0000000; Sun, 12 Nov 2006
 00:22:56 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The latest maintenance release GIT 1.4.3.5 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.5.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.5.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3.5-1.$arch.rpm	(RPM)

The 'master' front has been very quiet and it will hopefully
soon produce 1.4.4 but in the meantime here is primarily to fix
git-svn correctness issues.

----------------------------------------------------------------

Changes since v1.4.3.4 are as follows:

Alex Riesen (1):
      merge-recursive implicitely depends on trust_executable_bit

Eric Wong (3):
      git-svn: avoid printing filenames of files we're not tracking
      git-svn: don't die on rebuild when --upgrade is specified
      git-svn: fix dcommit losing changes when out-of-date from svn

Jakub Narebski (1):
      Documentation: Transplanting branch with git-rebase --onto

Jeff King (1):
      Fix git-runstatus for repositories containing a file named HEAD

Junio C Hamano (3):
      adjust_shared_perm: chmod() only when needed.
      path-list: fix path-list-insert return value
      git-cvsserver: read from git with -z to get non-ASCII pathnames.

Petr Baudis (1):
      Nicer error messages in case saving an object to db goes wrong

Robert Shearman (1):
      git-rebase: Use --ignore-if-in-upstream option when executing git-format-patch.

Tero Roponen (1):
      remove an unneeded test

