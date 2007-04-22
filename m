From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/5] Add S_IFINVALID mode
Date: Sun, 22 Apr 2007 18:43:56 +0200
Message-ID: <1177260240326-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 18:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HffAs-0001Lv-AS
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 18:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbXDVQoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 12:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161479AbXDVQoF
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 12:44:05 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:51164 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161468AbXDVQoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 12:44:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 7EB397833E03;
	Sun, 22 Apr 2007 18:44:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P-DmAxa05EtB; Sun, 22 Apr 2007 18:44:00 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 8EE2D7A522A9; Sun, 22 Apr 2007 18:44:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45247>

S_IFINVALID is used to signal, that no mode information is available.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
If somebody thinks, that S_IFINVALID should have an different impossible value, 
please feel free to change it.

 cache.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 53c2341..d425c26 100644
--- a/cache.h
+++ b/cache.h
@@ -24,6 +24,9 @@
 #define DTYPE(de)	DT_UNKNOWN
 #endif
 
+/* unknown mode (impossible combination S_IFIFO|S_IFCHR) */
+#define S_IFINVALID     0030000
+
 /*
  * Intensive research over the course of many years has shown that
  * port 9418 is totally unused by anything else. Or
-- 
1.5.1.1.206.g4a12-dirty
