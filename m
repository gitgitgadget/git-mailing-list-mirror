From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Makefile: resort filenames alphabetically
Date: Mon,  9 Feb 2009 23:00:45 +0100
Message-ID: <1234216845-27904-1-git-send-email-s-beyer@gmx.net>
Cc: gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 23:02:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWeCp-0001yq-Th
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbZBIWAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbZBIWAw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:00:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:59122 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752722AbZBIWAv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:00:51 -0500
Received: (qmail invoked by alias); 09 Feb 2009 22:00:49 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp032) with SMTP; 09 Feb 2009 23:00:49 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18mA7MMZB0mNxnRPSg4z7RCyr67UI/Fjj7hZ02pVM
	8iHX9cKplOun1Z
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LWeBJ-0003ln-8I; Mon, 09 Feb 2009 23:00:45 +0100
X-Mailer: git-send-email 1.6.2.rc0.458.g97dd
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109142>

Some filenames in the Makefile got out of order.
This patch resorts the filename lists which makes it easier
to grasp that it is sorted and that this should be kept.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Makefile |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 27b9569..124efa0 100644
--- a/Makefile
+++ b/Makefile
@@ -318,8 +318,8 @@ PROGRAMS += git-var$X
 # builtin-$C.o but is linked in as part of some other command.
 BUILT_INS += $(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
-BUILT_INS += git-cherry-pick$X
 BUILT_INS += git-cherry$X
+BUILT_INS += git-cherry-pick$X
 BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-get-tar-commit-id$X
@@ -358,8 +358,8 @@ LIB_H += builtin.h
 LIB_H += cache.h
 LIB_H += cache-tree.h
 LIB_H += commit.h
-LIB_H += compat/mingw.h
 LIB_H += compat/cygwin.h
+LIB_H += compat/mingw.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -385,7 +385,6 @@ LIB_H += pack-refs.h
 LIB_H += pack-revindex.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
-LIB_H += string-list.h
 LIB_H += pkt-line.h
 LIB_H += progress.h
 LIB_H += quote.h
@@ -399,6 +398,7 @@ LIB_H += sha1-lookup.h
 LIB_H += sideband.h
 LIB_H += sigchain.h
 LIB_H += strbuf.h
+LIB_H += string-list.h
 LIB_H += tag.h
 LIB_H += transport.h
 LIB_H += tree.h
@@ -437,8 +437,8 @@ LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
 LIB_OBJS += diff-delta.o
-LIB_OBJS += diff-no-index.o
 LIB_OBJS += diff-lib.o
+LIB_OBJS += diff-no-index.o
 LIB_OBJS += diff.o
 LIB_OBJS += dir.o
 LIB_OBJS += editor.o
@@ -471,9 +471,9 @@ LIB_OBJS += pager.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
-LIB_OBJS += string-list.o
 LIB_OBJS += path.o
 LIB_OBJS += pkt-line.o
+LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
 LIB_OBJS += progress.o
 LIB_OBJS += quote.o
@@ -487,13 +487,14 @@ LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
-LIB_OBJS += sha1_file.o
 LIB_OBJS += sha1-lookup.o
+LIB_OBJS += sha1_file.o
 LIB_OBJS += sha1_name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
 LIB_OBJS += strbuf.o
+LIB_OBJS += string-list.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
@@ -502,8 +503,8 @@ LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
 LIB_OBJS += unpack-trees.o
-LIB_OBJS += userdiff.o
 LIB_OBJS += usage.o
+LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
 LIB_OBJS += walker.o
 LIB_OBJS += wrapper.o
@@ -511,7 +512,6 @@ LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
-LIB_OBJS += preload-index.o
 
 BUILTIN_OBJS += builtin-add.o
 BUILTIN_OBJS += builtin-annotate.o
-- 
1.6.2.rc0.458.g97dd
