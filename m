From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Makefile: keep LIB_H entries together and sorted
Date: Sat, 16 Mar 2013 16:58:28 +0100
Message-ID: <514496A4.2010904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 16 16:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGtVk-0004ns-Ll
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 16:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957Ab3CPP6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 11:58:37 -0400
Received: from india601.server4you.de ([85.25.151.105]:49215 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861Ab3CPP6g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 11:58:36 -0400
Received: from [192.168.2.105] (p579BE6C7.dip.t-dialin.net [87.155.230.199])
	by india601.server4you.de (Postfix) with ESMTPSA id 4ADAE18A;
	Sat, 16 Mar 2013 16:58:34 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218308>

As a follow-up to 60d24dd25 (Makefile: fold XDIFF_H and VCSSVN_H into
LIB_H), let the unconditional additions to LIB_H form a single sorted
list.  Also drop the duplicate entry for xdiff/xdiff.h, which was easy
to spot after sorting.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 26d3332..598d631 100644
--- a/Makefile
+++ b/Makefile
@@ -617,22 +617,6 @@ LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
-LIB_H += xdiff/xinclude.h
-LIB_H += xdiff/xmacros.h
-LIB_H += xdiff/xdiff.h
-LIB_H += xdiff/xtypes.h
-LIB_H += xdiff/xutils.h
-LIB_H += xdiff/xprepare.h
-LIB_H += xdiff/xdiffi.h
-LIB_H += xdiff/xemit.h
-
-LIB_H += vcs-svn/line_buffer.h
-LIB_H += vcs-svn/sliding_window.h
-LIB_H += vcs-svn/repo_tree.h
-LIB_H += vcs-svn/fast_export.h
-LIB_H += vcs-svn/svndiff.h
-LIB_H += vcs-svn/svndump.h
-
 GENERATED_H += common-cmds.h
 
 LIB_H += advice.h
@@ -734,11 +718,24 @@ LIB_H += url.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
 LIB_H += varint.h
+LIB_H += vcs-svn/fast_export.h
+LIB_H += vcs-svn/line_buffer.h
+LIB_H += vcs-svn/repo_tree.h
+LIB_H += vcs-svn/sliding_window.h
+LIB_H += vcs-svn/svndiff.h
+LIB_H += vcs-svn/svndump.h
 LIB_H += walker.h
 LIB_H += wildmatch.h
 LIB_H += wt-status.h
 LIB_H += xdiff-interface.h
 LIB_H += xdiff/xdiff.h
+LIB_H += xdiff/xdiffi.h
+LIB_H += xdiff/xemit.h
+LIB_H += xdiff/xinclude.h
+LIB_H += xdiff/xmacros.h
+LIB_H += xdiff/xprepare.h
+LIB_H += xdiff/xtypes.h
+LIB_H += xdiff/xutils.h
 
 LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
-- 
1.8.2
