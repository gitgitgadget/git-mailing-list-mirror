From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix stupid typo in lookup_tag()
Date: Tue, 29 May 2007 01:21:25 +0200
Message-ID: <200705290121.25653.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 29 01:21:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsoX2-00082Z-5V
	for gcvg-git@gmane.org; Tue, 29 May 2007 01:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbXE1XVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 19:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXE1XVf
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 19:21:35 -0400
Received: from smtp.getmail.no ([84.208.20.33]:61996 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbXE1XVe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 19:21:34 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIR00001Y7XL700@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 29 May 2007 01:21:33 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIR00BXBY7Q3180@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 29 May 2007 01:21:26 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIR00MKPY7PT120@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 29 May 2007 01:21:26 +0200 (CEST)
Content-disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48651>

Signed-off-by: Johan Herland <johan@herland.net>
---
 tag.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tag.c b/tag.c
index 330d287..bbacd59 100644
--- a/tag.c
+++ b/tag.c
@@ -26,7 +26,7 @@ struct tag *lookup_tag(const unsigned char *sha1)
 	if (!obj->type)
 		obj->type = OBJ_TAG;
         if (obj->type != OBJ_TAG) {
-                error("Object %s is a %s, not a tree",
+                error("Object %s is a %s, not a tag",
                       sha1_to_hex(sha1), typename(obj->type));
                 return NULL;
         }
-- 
1.5.2.101.gee49f
