From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 7/7] gitweb: Adapt gitweb.js to new git_treeview calling convention
Date: Sun, 15 Apr 2007 22:46:10 +0200
Message-ID: <117666997124-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699701308-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699713715-git-send-email-mkoegler@auto.tuwien.ac.at> <1176669971694-git-send-email-mkoegler@auto.tuwien.ac.at> <1176669971921-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699714077-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:46:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBcP-00044c-Nt
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbXDOUqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbXDOUqV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:46:21 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58504 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbXDOUqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:46:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 4C9377A4D1A6;
	Sun, 15 Apr 2007 22:46:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hZFHtfKGWiK3; Sun, 15 Apr 2007 22:46:12 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 346DF7A4D1A5; Sun, 15 Apr 2007 22:46:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11766699714077-git-send-email-mkoegler@auto.tuwien.ac.at>
Message-Id: <aba7141dc09643b4d6233f1bfb15677163991a27.1176659095.git.mkoegler@auto.tuwien.ac.at>
In-Reply-To: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at>
References: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

---

Necessary changes for patch 5, if patch 6 is applied.

 gitweb/gitweb.js |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index 2e1a94d..51eeedb 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -105,8 +105,12 @@ function ToURL()
     parts.push("a="+this.a);
   if(this.f)
     parts.push("f="+this.f);
+  else if(this.hb)
+    parts.push("f=");
   if(this.fp)
     parts.push("fp="+this.fp);
+  else if(this.hpb)
+    parts.push("fp=");
   if(this.h)
     parts.push("h="+this.h);
   if(this.hp)
-- 
1.5.1.1.85.gf1888
