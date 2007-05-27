From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Various git-cvsserver patches
Date: Sun, 27 May 2007 14:33:05 +0200
Message-ID: <1180269190126-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 27 14:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsICD-000432-Vo
	for gcvg-git@gmane.org; Sun, 27 May 2007 14:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbXE0Mtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 08:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbXE0Mtr
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 08:49:47 -0400
Received: from v32413.1blu.de ([88.84.155.73]:41066 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbXE0Mtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 08:49:45 -0400
X-Greylist: delayed 981 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 May 2007 08:49:42 EDT
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HsHw0-0004cY-Vq; Sun, 27 May 2007 14:33:21 +0200
Received: from p3ee3d801.dip.t-dialin.net ([62.227.216.1] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HsHw0-0007Zg-5c; Sun, 27 May 2007 14:33:20 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HsHvq-0006Lj-7k; Sun, 27 May 2007 14:33:10 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48535>

Frank Lichtenheld (5):
      cvsserver: Correct inetd.conf example in asciidoc documentation
      cvsserver: Note that CVS_SERVER can also be specified as method variable
      cvsserver: Fix some typos in asciidoc documentation
      t9400: Work around CVS' deficiencies
      cvsserver: Handle 'cvs login'

 Documentation/git-cvsserver.txt |   27 ++++++++++++++++++---------
 git-cvsserver.perl              |    8 +++++---
 t/t9400-git-cvsserver-server.sh |   33 +++++++++++++++++++++++++++++++--
 3 files changed, 54 insertions(+), 14 deletions(-)

The first three patches are some fixes/improvements to the asciidoc
documentation. Just some random stuff that I noticed while working
on git-cvsserver.

The forth one is a good example how much CVS actually sucks
regarding data security and deterministic behaviour.

All of these should be suitable for maint.

The fifth is a small feature enhancement for git-cvsserver. It
adds support for 'cvs login' over pserver.

I think this is trivial enough to go to master directly, but feel free
to let it rot in next first.
