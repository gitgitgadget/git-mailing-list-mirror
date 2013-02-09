From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-bisect.txt: clarify that reset finishes bisect
Date: Sat,  9 Feb 2013 20:47:13 +0100
Message-ID: <5e23d4c420f150b700dd5100bffb38d32f874200.1360439176.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Mohr <andi@lisas.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 20:48:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4GP5-0001uu-Lc
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 20:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496Ab3BITrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 14:47:35 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41349 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932485Ab3BITre (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2013 14:47:34 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2959820F18;
	Sat,  9 Feb 2013 14:47:33 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 09 Feb 2013 14:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=whhOsBnREMiTZ2wQnwGjJEdyENI=; b=j6cUd5PBq3qzniVv6R0R
	1xB1IazpkJsAs23m9g3riQiSBYN8sZ8Ly2+18QmxG/8RHsv3Xay4A6CxDKhMBC8w
	PMYD+UHk2D+hCTFU7r0RFZDqS0r4964Nyq53d8+kEwlZXuO1x0gd6vJvaItQ/W1D
	E141EY69b1JmPcsUX2ppdfs=
X-Sasl-enc: hxSAU9ffY9lgm92qNkPFWBxjGaUQaSO8QmIztR3/xSIh 1360439252
Received: from localhost (unknown [88.71.185.238])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9F94B4827D8;
	Sat,  9 Feb 2013 14:47:32 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.752.g32d147e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215870>

"reset" can be easily misunderstood as resetting a bisect session to its
start without finishing it. Clarify that it actually finishes the bisect
session.

Reported-by: Andreas Mohr <andi@lisas.de>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-bisect.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index b4831bb..d50bd89 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -83,7 +83,7 @@ Bisect reset
 ~~~~~~~~~~~~
 
 After a bisect session, to clean up the bisection state and return to
-the original HEAD, issue the following command:
+the original HEAD (i.e., to finish bisect), issue the following command:
 
 ------------------------------------------------
 $ git bisect reset
-- 
1.8.1.2.752.g32d147e
