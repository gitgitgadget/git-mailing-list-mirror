From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] wrap git's main usage string.
Date: Sat, 12 Sep 2009 12:39:30 +0200
Message-ID: <1252751970-15978-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 12 12:39:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmQ1H-0004Hf-3X
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 12:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbZILKjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 06:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbZILKjm
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 06:39:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59715 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971AbZILKjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 06:39:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8CAb2gd002930
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 12 Sep 2009 12:37:02 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MmQ14-00065P-KL; Sat, 12 Sep 2009 12:39:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MmQ14-0004AQ-J6; Sat, 12 Sep 2009 12:39:38 +0200
X-Mailer: git-send-email 1.6.5.rc0.12.gbebb.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 12 Sep 2009 12:37:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8CAb2gd002930
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253356623.66371@yCkU8WxwsJYata516qJcBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128247>

It's now similar wrapped the same way as in Documentation/git.txt, and
fits in a 67 characters wide terminal.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 0b22595..271579c 100644
--- a/git.c
+++ b/git.c
@@ -5,7 +5,10 @@
 #include "run-command.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]\n"
+	"           [-p|--paginate|--no-pager]\n"
+	"           [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]\n"
+	"           [--help] COMMAND [ARGS]";
 
 const char git_more_info_string[] =
 	"See 'git help COMMAND' for more information on a specific command.";
-- 
1.6.5.rc0.12.gbebb.dirty
