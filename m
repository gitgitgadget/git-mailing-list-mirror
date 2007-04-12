From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Document the GIT branches -> CVS modules mapping more prominently
Date: Thu, 12 Apr 2007 16:54:28 +0200
Message-ID: <11763896683800-git-send-email-frank@lichtenheld.de>
References: <7v64879rwd.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 16:55:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc0hZ-0006DE-8Z
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 16:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbXDLOzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 10:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbXDLOzF
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 10:55:05 -0400
Received: from mail.lenk.info ([217.160.134.107]:4618 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886AbXDLOzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 10:55:03 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hc0hI-0005WO-WA; Thu, 12 Apr 2007 16:54:53 +0200
Received: from p54b0ded2.dip.t-dialin.net ([84.176.222.210] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1Hc0hQ-0006dn-5o; Thu, 12 Apr 2007 16:55:00 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hc0gu-0003P4-HD; Thu, 12 Apr 2007 16:54:28 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <7v64879rwd.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44339>

Add a note about the branches -> modules mapping to LIMITATIONS because
I really think it should be noted there and not just at the end of
the installation step-by-step HOWTO.

I used "git branches" there and changed "heads" to "branches" in
my section about database configuration. I'm reluctant to replace
all occourences of "head" with "branch" though because you always
have to say "git branch" because CVS also has the concept of
branches. You can say "head" though, because there is no such
concept in CVS. In all the existing occourences of head other than
the one I changed I think "head" flows better in the text.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

 Caused by me thinking about Junio's comment.
 Better patches welcome but my motivation to try to write clear
 and concise sentences in English is depleted for now,
 so no critical comments without patches, plz :)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 9fbaf75..3615ce5 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -31,6 +31,10 @@ over pserver for anonymous CVS access.
 
 CVS clients cannot tag, branch or perform GIT merges.
 
+git-cvsserver maps GIT branches to CVS modules. This is very different
+from what most CVS users would expect since in CVS modules usually represent
+one or more directories.
+
 INSTALLATION
 ------------
 
@@ -110,7 +114,7 @@ Example:
 Database Backend
 ----------------
 
-git-cvsserver uses one database per git head (i.e. CVS module) to
+git-cvsserver uses one database per git branch (i.e. CVS module) to
 store information about the repository for faster access. The
 database doesn't contain any persitent data and can be completly
 regenerated from the git repository at any time. The database
-- 
1.5.1
