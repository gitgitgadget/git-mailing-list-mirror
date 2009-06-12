From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit] Remove unused enum for key bindings
Date: Fri, 12 Jun 2009 14:07:56 +0200
Message-ID: <1244808481-13012-2-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 14:09:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5ZY-0007bq-Mk
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 14:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbZFLMJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 08:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbZFLMJS
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 08:09:18 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55983 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbZFLMJR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 08:09:17 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3002B102F0F22;
	Fri, 12 Jun 2009 14:08:12 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF5YK-0007lD-00; Fri, 12 Jun 2009 14:08:12 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1862RgHqOQZ8Zy7AiHWLkKaDx5i5j9lkRAeIm+q
	nQQKG/rvNI8Dl1wOa8ht0fy2Gq0meYgU3mvXoPCv4zJe2suw8J
	kKUE18xzLrm7fBa1fYxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121415>

These were replaced during conversion from Qt3 to Qt4, see commit
5df81c7 (Convert Q3PopupMenu to QMenu and Q3Accel to QShortcutEvent,
2007-02-20).

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/common.h |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/src/common.h b/src/common.h
index 49a28c0..ceb62fb 100644
--- a/src/common.h
+++ b/src/common.h
@@ -66,27 +66,6 @@ namespace QGit {
 	// minimum git version required
 	extern const QString GIT_VERSION;
 
-	// key bindings
-	enum KeyType {
-		KEY_UP,
-		KEY_DOWN,
-		SHIFT_KEY_UP,
-		SHIFT_KEY_DOWN,
-		KEY_LEFT,
-		KEY_RIGHT,
-		CTRL_PLUS,
-		CTRL_MINUS,
-		KEY_U,
-		KEY_D,
-		KEY_DELETE,
-		KEY_B,
-		KEY_BCKSPC,
-		KEY_SPACE,
-		KEY_R,
-		KEY_P,
-		KEY_F
-	};
-
 	// tab pages
 	enum TabType {
 		TAB_REV,
-- 
1.6.3.2.236.ge505d
