From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH 6/6] Document format.overwritecoverletter
Date: Sat, 18 Apr 2009 18:16:21 +0200
Message-ID: <1240071381-25165-7-git-send-email-ft@bewatermyfriend.org>
References: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
Cc: Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 18:18:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDFZ-0000ZQ-6q
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805AbZDRQRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 12:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756790AbZDRQRB
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 12:17:01 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:42041 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbZDRQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 12:16:56 -0400
Received: from [212.117.84.81] (helo=fsst.voodoo.lan)
	by smtprelay09.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDr-000462-8P; Sat, 18 Apr 2009 18:16:55 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDM-0006Yl-8A; Sat, 18 Apr 2009 18:16:24 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116838>

Signed-off-by: Frank Terbeck <ft@bewatermyfriend.org>
---
 Documentation/config.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 00b8f1f..616bfb5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -715,6 +715,11 @@ format.coveronepatch::
 	decides whether to create a cover letter or not (if that is
 	requested). The default is "true".
 
+format.overwritecoverletter::
+	If this boolean variable is set to "false", it will cause
+	linkgit:git-format-patch[1] fail fatally if it would overwrite an
+	existing coverletter. The default is "true".
+
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
-- 
1.6.2.2.446.gfbdc0
