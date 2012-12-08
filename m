From: yannicklm <yannicklm1337@gmail.com>
Subject: [PATCH] shortlog: add --format to the usage
Date: Sat,  8 Dec 2012 01:46:33 +0100
Message-ID: <1354927593-4315-1-git-send-email-yannicklm1337@gmail.com>
Cc: yannicklm <yannicklm1337@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 01:47:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th8a5-00050g-Qh
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 01:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359Ab2LHAre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 19:47:34 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:59875 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932316Ab2LHArd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 19:47:33 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so617316wgb.1
        for <git@vger.kernel.org>; Fri, 07 Dec 2012 16:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=DqwKdrfjA0Su8ME7oDX8OGz89sjjlPCxdQvxhPD17/w=;
        b=cUxnWNMmz9H1PrZUzkLX5bK5O9nuX30pftjJUR12b3ygxXID42VhH0dp8x4H1motmR
         8lGrziJkIex9nZim2oMxtwG3rbNqtgkdIsCZrYsNVkOzklgMCu5AMgO7puXNMyJ44QpR
         njLsnljy1pPctdwg9h2C0S4K/Y21K+bZKjqU6mibwew8yW0IjacI1f6nYWmCHoFnWoyP
         ff5bX2C71FyVtpLjC90CtTiYEYo6SWnr9xc7NlMyHCuL7jRaeSJmaqQdRtHirsNED7uU
         lWJ417zAmDXyVICMZijAzdACiT7V4g6of2gcD8SN4CMNNmZi+Y3tR2rW3cq4eAjtTOEl
         c6rg==
Received: by 10.180.107.197 with SMTP id he5mr1204461wib.1.1354927652140;
        Fri, 07 Dec 2012 16:47:32 -0800 (PST)
Received: from localhost.localdomain (bne75-6-82-229-247-16.fbx.proxad.net. [82.229.247.16])
        by mx.google.com with ESMTPS id eu8sm439251wib.1.2012.12.07.16.47.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Dec 2012 16:47:31 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211206>

---
 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index b316cf3..cb85ede 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static char const * const shortlog_usage[] = {
-	N_("git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>... ]"),
+	N_("git shortlog [-n] [-s] [-e] [-w] [--format=...] [rev-opts] [--] [<commit-id>... ]"),
 	"",
 	N_("[rev-opts] are documented in git-rev-list(1)"),
 	NULL
-- 
1.8.0.1
