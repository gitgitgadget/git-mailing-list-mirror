From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 1/4] config.txt: Document gitcvs.allbinary
Date: Fri, 13 Apr 2007 18:02:30 +0200
Message-ID: <1176480153972-git-send-email-frank@lichtenheld.de>
References: <11764801533023-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 18:04:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcOGE-0000T6-Hl
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 18:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbXDMQD1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 12:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754070AbXDMQDX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 12:03:23 -0400
Received: from mail.lenk.info ([217.160.134.107]:2239 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbXDMQDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 12:03:12 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HcOEm-0008QF-OG; Fri, 13 Apr 2007 18:03:00 +0200
Received: from p3ee3f548.dip.t-dialin.net ([62.227.245.72] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HcOEw-0000xV-Eq; Fri, 13 Apr 2007 18:03:10 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HcOEL-0001nP-Ki; Fri, 13 Apr 2007 18:02:33 +0200
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <11764801533023-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44415>


Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/config.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cf1e040..061c585 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -408,6 +408,13 @@ gitcvs.logfile::
 	Path to a log file where the cvs pserver interface well... logs
 	various stuff. See gitlink:git-cvsserver[1].
 
+gitcvs.allbinary::
+	If true, all files are sent to the client in mode '-kb'. This
+	causes the client to treat all files as binary files which suppresses
+	any newline munging it otherwise might do. A work-around for the
+	fact that there is no way yet to set single files to mode '-kb'.
+	See gitlink:git-cvsserver[1].
+
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
-- 
1.5.1.1
