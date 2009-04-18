From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH 3/6] Document format.coverletter and format.coveronepatch
Date: Sat, 18 Apr 2009 18:16:18 +0200
Message-ID: <1240071381-25165-4-git-send-email-ft@bewatermyfriend.org>
References: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
Cc: Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 18:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDKw-0002Kp-8K
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbZDRQWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 12:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757196AbZDRQWW
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 12:22:22 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:59845 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbZDRQWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 12:22:21 -0400
Received: from [212.117.84.81] (helo=fsst.voodoo.lan)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDq-0006jr-Hw; Sat, 18 Apr 2009 18:16:54 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDL-0006Yb-Ix; Sat, 18 Apr 2009 18:16:23 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116840>

Signed-off-by: Frank Terbeck <ft@bewatermyfriend.org>
---
 Documentation/config.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5319df5..00b8f1f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -705,6 +705,16 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+format.coverletter::
+	A boolean variable, if enabled causes the creation of cover letters
+	for patch series without manually using the --cover-letter option
+	of linkgit:git-format-patch[1]. This variable defaults to "false".
+
+format.coveronepatch::
+	If a patch series consists of only one patch, this boolean variable
+	decides whether to create a cover letter or not (if that is
+	requested). The default is "true".
+
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
-- 
1.6.2.2.446.gfbdc0
