From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] standardize usage strings that were missed the first time
Date: Thu,  2 Apr 2015 15:26:56 -0600
Message-ID: <1428010016-12968-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: gitster@pobox.com, pclouds@gmail.com, artagnon@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 23:27:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydmdo-0000Th-6S
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 23:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbbDBV1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 17:27:04 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36804 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbbDBV1C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 17:27:02 -0400
Received: by pdea3 with SMTP id a3so49902934pde.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xpl7Ac/hgWWP+1wcoNATS7/o1TfrBbGiRUdqdtkES1w=;
        b=kMIB7Vwpw/NzX9DYw6AdfMH3Ey0fbOAfkNSRY43QGr4okPEBUhGsEdvOOZvThEacVB
         dQVVEcLxclWRD0hjVuZlalxx/6bZ2kocv85kPLxju02PAdCvv6OtnR3ljvzkNNdZL6WE
         gQ2oEbGcDjzNbu86iY39AiB1s8nZqMV6SIzsyz2vxJ38DyxzQbVtu/iG2DWp8Z+zyOMo
         KHHB90nyz0iOS3QvtaD9mZvnkpLQujCAwd6EGFCMk5uhdTYyeBON2Bvp08Q9avUA8a/x
         iCxarqnyiXewWQb/CjNULqLLYutg4o9oN4bDs1DxYU/h6tlLJgDnUTf49J6NniiHLrfk
         sVxg==
X-Received: by 10.70.126.225 with SMTP id nb1mr90966465pdb.40.1428010022096;
        Thu, 02 Apr 2015 14:27:02 -0700 (PDT)
Received: from alex-wolverine.uconnect.utah.edu ([155.99.227.128])
        by mx.google.com with ESMTPSA id fk4sm6111651pbb.80.2015.04.02.14.27.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2015 14:27:00 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266680>

This is a follow-up to commit 9c9b4f2f8b7f27f3984e80d053106d5d41cbb03b.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/blame.c | 2 +-
 builtin/log.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 06484c2..0b2f4ed 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -27,7 +27,7 @@
 #include "line-range.h"
 #include "line-log.h"
 
-static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] file");
+static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
 static const char *blame_opt_usage[] = {
 	blame_usage,
diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..4c4e6be 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -38,7 +38,7 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
-	N_("git log [<options>] [<revision range>] [[--] <path>...]"),
+	N_("git log [<options>] [<revision-range>] [[--] <path>...]"),
 	N_("git show [<options>] <object>..."),
 	NULL
 };
-- 
2.3.5
