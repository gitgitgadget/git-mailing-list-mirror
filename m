From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] Rename builtin-zip-tree.c to archive-zip.c
Date: Sat, 23 Sep 2006 17:06:35 +0200
Message-ID: <45154D7B.9080909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 23 17:06:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR95Q-0003J8-W0
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 17:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWIWPGd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 11:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWIWPGd
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 11:06:33 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:46486
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751223AbWIWPGc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 11:06:32 -0400
Received: from [10.0.1.3] (p508E4EB9.dip.t-dialin.net [80.142.78.185])
	by neapel230.server4you.de (Postfix) with ESMTP id 8A29C19052;
	Sat, 23 Sep 2006 17:06:31 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27594>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile                            |    5 ++---
 builtin-zip-tree.c => archive-zip.c |    0 
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 8467447..739d7e3 100644
--- a/Makefile
+++ b/Makefile
@@ -254,7 +254,7 @@ LIB_OBJS = \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
-	color.o wt-status.o
+	color.o wt-status.o archive-zip.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
@@ -300,8 +300,7 @@ BUILTIN_OBJS = \
 	builtin-upload-archive.o \
 	builtin-upload-tar.o \
 	builtin-verify-pack.o \
-	builtin-write-tree.o \
-	builtin-zip-tree.o
+	builtin-write-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-zip-tree.c b/archive-zip.c
similarity index 100%
rename from builtin-zip-tree.c
rename to archive-zip.c
