From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 5/5] cvsimport: Improve formating consistency
Date: Fri,  6 Apr 2007 23:52:43 +0200
Message-ID: <11758963644092-git-send-email-frank@lichtenheld.de>
References: <11758963633237-git-send-email-frank@lichtenheld.de> <11758963634155-git-send-email-frank@lichtenheld.de> <11758963643049-git-send-email-frank@lichtenheld.de> <11758963642149-git-send-email-frank@lichtenheld.de> <11758963643062-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 01:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwN9-0006I3-G5
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 23:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbXDFVxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 17:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbXDFVxR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 17:53:17 -0400
Received: from mail.lenk.info ([217.160.134.107]:59345 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbXDFVxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 17:53:11 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwN3-0006Iq-Jm; Fri, 06 Apr 2007 23:53:26 +0200
Received: from p54b0f96b.dip.t-dialin.net ([84.176.249.107] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwMl-0001cB-68; Fri, 06 Apr 2007 23:53:07 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HZwMO-00038I-W9; Fri, 06 Apr 2007 23:52:45 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <11758963643062-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43926>

Use ' ' syntax for all commandline options mentioned in text.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsimport.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index a5276f7..e0be856 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -65,7 +65,7 @@ the old cvs2git tool.
 	not create them if they do not exist.
 
 -k::
-	Kill keywords: will extract files with -kk from the CVS archive
+	Kill keywords: will extract files with '-kk' from the CVS archive
 	to avoid noisy changesets. Highly recommended, but off by default
 	to preserve compatibility with early imported trees. 
 
@@ -96,7 +96,7 @@ If you need to pass multiple options, separate them with a comma.
 
 -M <regex>::
 	Attempt to detect merges based on the commit message with a custom
-	regex. It can be used with -m to also see the default regexes. 
+	regex. It can be used with '-m' to also see the default regexes.
 	You must escape forward slashes. 
 
 -S <regex>::
@@ -126,7 +126,7 @@ their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
 all along.
 +
 For convenience, this data is saved to `$GIT_DIR/cvs-authors`
-each time the -A option is provided and read from that same
+each time the '-A' option is provided and read from that same
 file each time git-cvsimport is run.
 +
 It is not recommended to use this feature if you intend to
-- 
1.5.1
