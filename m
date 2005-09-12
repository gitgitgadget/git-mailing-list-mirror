From: Linus Torvalds <torvalds@osdl.org>
Subject: Add note about IANA confirmation
Date: Mon, 12 Sep 2005 11:23:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121057520.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Sep 12 20:23:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEsxW-0006tk-QH
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 20:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVILSXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 14:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVILSXL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 14:23:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932121AbVILSXK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 14:23:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CIN4Bo007991
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 11:23:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CIN1Iw009517;
	Mon, 12 Sep 2005 11:23:03 -0700
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8410>


The git port (9418) is officially listed by IANA now.

So document it.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Btw, another thing happened yesterday too: I'm now officially using a
packed archive for my core kernel stuff. The format hasn't changed in
I-don't-know-how-long, and I can't recall any pack-specific bug either
(apart from the obvious lack of support by some of the client-side stuff).

Goodie. Me happy.

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -50,6 +50,17 @@
  *	Your search - "port 9418" - did not match any documents.
  *
  * as www.google.com puts it.
+ *
+ * This port has been properly assigned for git use by IANA:
+ * git (Assigned-9418) [I06-050728-0001].
+ *
+ *	git  9418/tcp   git pack transfer service
+ *	git  9418/udp   git pack transfer service
+ *
+ * with Linus Torvalds <torvalds@osdl.org> as the point of
+ * contact. September 2005.
+ *
+ * See http://www.iana.org/assignments/port-numbers
  */
 #define DEFAULT_GIT_PORT 9418
 
