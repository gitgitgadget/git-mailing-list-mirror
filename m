From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/4] contrib/git-svn: make sure our git-svn is up-to-date for test
Date: Mon, 03 Apr 2006 15:18:49 -0700
Message-ID: <11441027293976-git-send-email-normalperson@yhbt.net>
References: <11441027292908-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 04 00:19:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQXOe-0002qQ-5V
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 00:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWDCWTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 18:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWDCWTg
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 18:19:36 -0400
Received: from hand.yhbt.net ([66.150.188.102]:65516 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751732AbWDCWTf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 18:19:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 0A8592DC03A;
	Mon,  3 Apr 2006 15:19:35 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
X-Mailer: git-send-email 1.3.0.rc1.g595e
In-Reply-To: <11441027292908-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18356>

Bugs like the last one could've been avoided if it weren't for
this...

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

d3ce1325c4933cd0e5f8f9810b2ffc33ddf45aac
diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
index d7f1643..acedf73 100644
--- a/contrib/git-svn/Makefile
+++ b/contrib/git-svn/Makefile
@@ -28,7 +28,7 @@ git-svn.xml : git-svn.txt
 git-svn.html : git-svn.txt
 	asciidoc -b xhtml11 -d manpage \
 		-f ../../Documentation/asciidoc.conf $<
-test:
+test: git-svn
 	cd t && $(SHELL) ./t0000-contrib-git-svn.sh
 
 clean:
-- 
1.3.0.rc1.g595e
