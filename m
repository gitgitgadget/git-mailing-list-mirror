From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 5/5] git-gui i18n: mark string in lib/error.tcl for translation
Date: Sun,  8 May 2016 10:52:58 +0000
Message-ID: <1462704778-4722-5-git-send-email-vascomalmeida@sapo.pt>
References: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 12:54:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azMM0-0006aR-Av
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 12:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbcEHKyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 06:54:23 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:56709 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750791AbcEHKyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 06:54:16 -0400
Received: (qmail 21227 invoked from network); 8 May 2016 10:54:13 -0000
Received: (qmail 14805 invoked from network); 8 May 2016 10:54:13 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 May 2016 10:54:12 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293963>

Mark string "$hook hook failed:" in lib/error.tcl for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 lib/error.tcl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/error.tcl b/lib/error.tcl
index 71dc860..8968a57 100644
--- a/lib/error.tcl
+++ b/lib/error.tcl
@@ -77,7 +77,7 @@ proc hook_failed_popup {hook msg {is_fatal 1}} {
 	wm withdraw $w
 
 	${NS}::frame $w.m
-	${NS}::label $w.m.l1 -text "$hook hook failed:" \
+	${NS}::label $w.m.l1 -text [mc "%s hook failed:" $hook] \
 		-anchor w \
 		-justify left \
 		-font font_uibold
-- 
2.7.3
