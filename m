From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 3/4] config.txt: Change pserver to server in description of gitcvs.*
Date: Fri, 13 Apr 2007 18:02:32 +0200
Message-ID: <11764801632775-git-send-email-frank@lichtenheld.de>
References: <11764801533023-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 18:04:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcOGG-0000T6-Ha
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 18:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbXDMQDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 12:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbXDMQDx
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 12:03:53 -0400
Received: from mail.lenk.info ([217.160.134.107]:3681 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064AbXDMQDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 12:03:52 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HcOFQ-0008RI-Sb; Fri, 13 Apr 2007 18:03:40 +0200
Received: from p3ee3f548.dip.t-dialin.net ([62.227.245.72] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HcOFa-0000ya-JH; Fri, 13 Apr 2007 18:03:50 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HcOEf-0001nY-TZ; Fri, 13 Apr 2007 18:02:53 +0200
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <11764801533023-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44417>

These variables apply to the SSH access as well, so don't use
pserver here which might confuse users.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/config.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 09c355b..b6e6513 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -411,11 +411,11 @@ gc.rerereunresolved::
 	The default is 15 days.  See gitlink:git-rerere[1].
 
 gitcvs.enabled::
-	Whether the cvs pserver interface is enabled for this repository.
+	Whether the cvs server interface is enabled for this repository.
 	See gitlink:git-cvsserver[1].
 
 gitcvs.logfile::
-	Path to a log file where the cvs pserver interface well... logs
+	Path to a log file where the cvs server interface well... logs
 	various stuff. See gitlink:git-cvsserver[1].
 
 gitcvs.allbinary::
-- 
1.5.1.1
