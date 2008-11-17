From: crquan@gmail.com
Subject: [PATCH 1/2] remote short help message updated
Date: Mon, 17 Nov 2008 17:12:29 +0800
Message-ID: <1226913150-26088-1-git-send-email-crquan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 10:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L20Ap-0008St-3v
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 10:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbYKQJLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 04:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbYKQJLx
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 04:11:53 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:43244 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbYKQJLw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 04:11:52 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1477357tic.23
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 01:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=XjCA/FP2HnsBb6yw9OZ/h7XPu9e8FgXFrwAnXtKHqWQ=;
        b=VtRF7F1iUZ8yRIDJ1NzqBK3/ay+OEtBmCkXWz+muF4aJaHa7/xYicEB6H72dMURE+A
         142r4fVA/5p+1a9dy3L8t+CXsa7Cu0tEXsc4LQ8NfDQPdryK0GqPHqiCSHcioeM2SmX1
         M9HdDlzOrHz81gRocMtnAXpxjk06CfZ1LDV4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=bvHzu60yzzhMymD2CmYganQ1uUz2Il/vOFfcf6ltCoZcFU5XRPPJVRIHAHVvlaqWL9
         M8RYfmNRailhH0BEsLqBrte7zgAZ6Uw6kHR7ek/Qo1nteNpbdhjSbVYnkYUgJ2rCJDYf
         TMaxaB7jgboBhbk3i/2rzU5EqmCFVcMLs3Prw=
Received: by 10.110.70.17 with SMTP id s17mr4890349tia.29.1226913110480;
        Mon, 17 Nov 2008 01:11:50 -0800 (PST)
Received: from tux ([219.134.89.155])
        by mx.google.com with ESMTPS id w5sm109508tib.14.2008.11.17.01.11.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 01:11:48 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Mon, 17 Nov 2008 17:12:30 +0800
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101201>

From: Cheng Renquan <crquan@gmail.com>

Synced from git help remote.

Signed-off-by: Cheng Renquan <crquan@gmail.com>
---
 builtin-remote.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 71696b5..d032f25 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -8,12 +8,12 @@
 #include "refs.h"
 
 static const char * const builtin_remote_usage[] = {
-	"git remote",
-	"git remote add <name> <url>",
+	"git remote [-v | --verbose]",
+	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
-	"git remote show <name>",
-	"git remote prune <name>",
+	"git remote show [-n] <name>",
+	"git remote prune [-n | --dry-run] <name>",
 	"git remote update [group]",
 	NULL
 };
-- 
1.6.0.2
