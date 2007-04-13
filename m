From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 4/4] config.txt: Fix grammatical error in description of http.noEPSV
Date: Fri, 13 Apr 2007 18:02:33 +0200
Message-ID: <11764801732969-git-send-email-frank@lichtenheld.de>
References: <11764801533023-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 18:04:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcOGF-0000T6-6q
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 18:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbXDMQD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 12:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbXDMQD2
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 12:03:28 -0400
Received: from mail.lenk.info ([217.160.134.107]:2017 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069AbXDMQDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 12:03:18 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HcOEs-0008Qb-9U; Fri, 13 Apr 2007 18:03:06 +0200
Received: from p3ee3f548.dip.t-dialin.net ([62.227.245.72] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HcOF1-0000xj-TH; Fri, 13 Apr 2007 18:03:16 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HcOEg-0001ne-4s; Fri, 13 Apr 2007 18:02:54 +0200
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <11764801533023-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44416>

s/doesn't/don't/ since "ftp servers" is plural

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b6e6513..62168e6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -462,7 +462,7 @@ http.lowSpeedLimit, http.lowSpeedTime::
 
 http.noEPSV::
 	A boolean which disables using of EPSV ftp command by curl.
-	This can helpful with some "poor" ftp servers which doesn't
+	This can helpful with some "poor" ftp servers which don't
 	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
 	environment variable. Default is false (curl will use EPSV).
 
-- 
1.5.1.1
