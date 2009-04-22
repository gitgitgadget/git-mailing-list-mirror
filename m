From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Fix more typos/spelling in comments
Date: Wed, 22 Apr 2009 23:15:56 +0200
Message-ID: <1240434956-4852-1-git-send-email-git@drmicha.warpmail.net>
References: <7veivq21zv.fsf@gitster.siamese.dyndns.org>
Cc: Mike Ralphson <mike@abacus.co.uk>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 23:17:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwjp9-0006tk-WA
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbZDVVQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbZDVVQH
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:16:07 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43827 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754779AbZDVVQG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 17:16:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C84DD3213BD;
	Wed, 22 Apr 2009 17:16:03 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 22 Apr 2009 17:16:03 -0400
X-Sasl-enc: HlZxTnlIaTqWWKAKc1EDLK6GdpNQnvcAAgoLqjOiYXHO 1240434962
Received: from localhost (p5DCC188B.dip0.t-ipconnect.de [93.204.24.139])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D75F74D7E6;
	Wed, 22 Apr 2009 17:16:02 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc1.34.g0be9b
In-Reply-To: <7veivq21zv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117263>

A few more fixes on top of the automatic spell checker generated ones.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Sorry it took me so long...

 builtin-reflog.c         |    2 +-
 compat/cygwin.c          |    2 +-
 compat/fnmatch/fnmatch.c |    2 +-
 fast-import.c            |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index ff8b4f6..ddfdf5a 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -240,7 +240,7 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
 static void mark_reachable(struct commit *commit, unsigned long expire_limit)
 {
 	/*
-	 * We need to compute if commit on either side of an reflog
+	 * We need to compute whether the commit on either side of a reflog
 	 * entry is reachable from the tip of the ref for all entries.
 	 * Mark commits that are reachable from the tip down to the
 	 * time threshold first; we know a commit marked thusly is
diff --git a/compat/cygwin.c b/compat/cygwin.c
index 1192874..b4a51b9 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -89,7 +89,7 @@ static int cygwin_stat(const char *path, struct stat *buf)
 /*
  * At start up, we are trying to determine whether Win32 API or cygwin stat
  * functions should be used. The choice is determined by core.ignorecygwinfstricks.
- * Reading this option is not always possible immediately as git_dir may be
+ * Reading this option is not always possible immediately as git_dir may
  * not be set yet. So until it is set, use cygwin lstat/stat functions.
  * However, if core.filemode is set, we must use the Cygwin posix
  * stat/lstat as the Windows stat functions do not determine posix filemode.
diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 03157a4..14feac7 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -39,7 +39,7 @@
 # include <stdlib.h>
 #endif
 
-/* For platform which support the ISO C amendment 1 functionality we
+/* For platforms which support the ISO C amendment 1 functionality we
    support user defined character classes.  */
 #if defined _LIBC || (defined HAVE_WCTYPE_H && defined HAVE_WCHAR_H)
 /* Solaris 2.5 has a bug: <wchar.h> must be included before <wctype.h>.  */
diff --git a/fast-import.c b/fast-import.c
index 53617a1..8d959af 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -133,7 +133,7 @@ Format of STDIN stream:
      # always escapes the related input from comment processing.
      #
      # In case it is not clear, the '#' that starts the comment
-     # must be the first character on that the line (an lf have
+     # must be the first character on that line (an lf
      # preceded it).
      #
   comment ::= '#' not_lf* lf;
-- 
1.6.3.rc1.34.g0be9b
