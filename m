From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] Documentation/Makefile: remove extra /
Date: Thu, 25 May 2006 14:37:46 +0200
Message-ID: <20060525123746.GA14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 14:38:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjF6G-0002ce-NG
	for gcvg-git@gmane.org; Thu, 25 May 2006 14:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbWEYMhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 08:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWEYMhs
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 08:37:48 -0400
Received: from admingilde.org ([213.95.32.146]:30956 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S965128AbWEYMhs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 08:37:48 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FjF62-0006sN-C5; Thu, 25 May 2006 14:37:46 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20736>

As both DESTDIR and the prefix are supposed to be absolute pathnames
they can simply be concatenated without an extra / (like in the main Makefile).
The extra slash may even break installation on Windows.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 Documentation/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2a08f59..2b0efe7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -52,9 +52,9 @@ man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
 install: man
-	$(INSTALL) -d -m755 $(DESTDIR)/$(man1) $(DESTDIR)/$(man7)
-	$(INSTALL) $(DOC_MAN1) $(DESTDIR)/$(man1)
-	$(INSTALL) $(DOC_MAN7) $(DESTDIR)/$(man7)
+	$(INSTALL) -d -m755 $(DESTDIR)$(man1) $(DESTDIR)$(man7)
+	$(INSTALL) $(DOC_MAN1) $(DESTDIR)$(man1)
+	$(INSTALL) $(DOC_MAN7) $(DESTDIR)$(man7)
 
 
 #
-- 
1.3.3.g29c7

-- 
Martin Waitz
