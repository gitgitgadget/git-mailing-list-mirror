From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v2 1/3] INSTALL: Update description of our SHA-1 code
Date: Tue,  8 Sep 2009 21:50:59 -0400
Message-ID: <1252461061-75840-2-git-send-email-brian@gernhardtsoftware.com>
References: <1252461061-75840-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 03:51:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlCLa-0003a3-QB
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 03:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbZIIBve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 21:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbZIIBve
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 21:51:34 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48303 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbZIIBvd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 21:51:33 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 9DA521FFC087; Wed,  9 Sep 2009 01:51:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-67-240-168-84.rochester.res.rr.com [67.240.168.84])
	by silverinsanity.com (Postfix) with ESMTPA id 368D11FFC080;
	Wed,  9 Sep 2009 01:50:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.2.420.g30ecf
In-Reply-To: <1252461061-75840-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128054>

We haven't had Mozilla's code or an ARM optimized algorithm since
30ae47b.  Reword the paragraph to give credit but not authorship to
Mozilla.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 The only change from v1 here is "based on" -> "inspired by".

 INSTALL |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index ae7f750..5267468 100644
--- a/INSTALL
+++ b/INSTALL
@@ -56,8 +56,8 @@ Issues of note:
 	  library from here.
 
 	  If you don't have openssl, you can use one of the SHA1 libraries
-	  that come with git (git includes the one from Mozilla, and has
-	  its own PowerPC and ARM optimized ones too - see the Makefile).
+	  that come with git (git includes one inspired by Mozilla's and a
+	  PowerPC optimized one too - see the Makefile).
 
 	- libcurl library; git-http-fetch and git-fetch use them.  You
 	  might also want the "curl" executable for debugging purposes.
-- 
1.6.4.2.420.g30ecf
