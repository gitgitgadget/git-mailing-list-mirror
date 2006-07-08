From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2] Teach make clean about configure and autoconf
Date: Sat,  8 Jul 2006 23:07:07 +0200
Message-ID: <1152392835436-git-send-email-jnareb@gmail.com>
References: <200607030156.50455.jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 08 23:07:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzK1S-0003iK-MK
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 23:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWGHVH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWGHVH1
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 17:07:27 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:59585 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030383AbWGHVH0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 17:07:26 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k68L6nOA021743
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jul 2006 23:06:49 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k68L7Go0015567;
	Sat, 8 Jul 2006 23:07:16 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k68L7FEI015566;
	Sat, 8 Jul 2006 23:07:15 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <200607030156.50455.jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23502>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Part of this patch is needed also for handcrafted ./configure script
(if not already przesent in some patch of those series)

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 3c2c257..200e58a 100644
--- a/Makefile
+++ b/Makefile
@@ -749,6 +749,8 @@ clean:
 		$(LIB_FILE) $(XDIFF_LIB)
 	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
+	rm -rf autom4te.cache configure config.status config.cache
+	rm -f  config.log config.mak.autogen
 	rm -rf $(GIT_TARNAME) .doc-tmp-dir
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	rm -f $(htmldocs).tar.gz $(manpages).tar.gz
-- 
1.4.0
