From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 1/2] INSTALL: Update description of our SHA-1 code
Date: Tue,  8 Sep 2009 11:55:12 -0400
Message-ID: <1252425313-69793-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 17:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml32X-0007VI-Kh
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 17:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbZIHPzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 11:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbZIHPzR
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 11:55:17 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:50089 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbZIHPzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 11:55:17 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 3E13B1FFC08B; Tue,  8 Sep 2009 15:55:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	by silverinsanity.com (Postfix) with ESMTPA id B27001FFC06B;
	Tue,  8 Sep 2009 15:55:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.2.420.g30ecf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128016>

We haven't had Mozilla's code or an ARM optimized algorithm since
30ae47b.  Reword the paragraph to give credit but not authorship to
Mozilla.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Minor nit I noticed while in the INSTALL file.

 INSTALL |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index ae7f750..4a57e47 100644
--- a/INSTALL
+++ b/INSTALL
@@ -56,8 +56,8 @@ Issues of note:
 	  library from here.
 
 	  If you don't have openssl, you can use one of the SHA1 libraries
-	  that come with git (git includes the one from Mozilla, and has
-	  its own PowerPC and ARM optimized ones too - see the Makefile).
+	  that come with git (git includes one based on Mozilla's as well
+	  as a PowerPC optimized one - see the Makefile).
 
 	- libcurl library; git-http-fetch and git-fetch use them.  You
 	  might also want the "curl" executable for debugging purposes.
-- 
1.6.4.2.420.g30ecf
