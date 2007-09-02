From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 5/5] Show Difflinks in an other color
Date: Sun,  2 Sep 2007 16:46:08 +0200
Message-ID: <11887443694-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11887443682216-git-send-email-mkoegler@auto.tuwien.ac.at> <11887443692839-git-send-email-mkoegler@auto.tuwien.ac.at> <11887443693783-git-send-email-mkoegler@auto.tuwien.ac.at> <11887443693173-git-send-email-mkoegler@auto.tuwien.ac.at> <11887443693825-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Sep 02 16:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRqij-0000tU-2h
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 16:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbXIBOqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 10:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754243AbXIBOqO
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 10:46:14 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:45582 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbXIBOqM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 10:46:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id E75457437389;
	Sun,  2 Sep 2007 16:46:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 34jXrbSu2uo6; Sun,  2 Sep 2007 16:46:10 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 57419743738F; Sun,  2 Sep 2007 16:46:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11887443693825-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57328>

Suggested by Petr Baudis

The style for the links was randomly selected.

No sign-off, as somebody else should select a suiteable style.
---
 gitweb/gitweb.css |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 1b88879..ac15c0e 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -499,3 +499,7 @@ span.match {
 div.binary {
 	font-style: italic;
 }
+
+span.difflinks a {
+	color: #ff0000;
+}
-- 
1.5.3.rc7.849.g2f5f
