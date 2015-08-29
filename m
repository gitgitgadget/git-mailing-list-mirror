From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] show-ref: place angle brackets around variables in usage string
Date: Fri, 28 Aug 2015 22:18:44 -0600
Message-ID: <1440821924-4289-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 29 06:18:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVXbU-0007mD-W2
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 06:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbbH2ESw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 00:18:52 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34474 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbH2ESw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 00:18:52 -0400
Received: by pabzx8 with SMTP id zx8so81920737pab.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 21:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OLEK75fdo3FUQHKnZtOz35NIcYczP3RgcrSzI4oiI1Y=;
        b=nWW6wJfcc1nXWX0ls+s/e1wtsZkjpUZ4UyPenP+EA5Tv4XSVvNjGBz7lHtp8kftK+3
         TJ12L+9ekucI6LzAR6tUauWGXlGhN5p6Ix1SXvHBraTWRg8mJ6yW1s0YpbJWs5DVcGEQ
         OLC5zitGDOOkKwcF07zxn1dXWuV8j5LDmjG23w25gJgg59aSYAHtS2l3MtE0Iez/JO4k
         qclPXYZ4/atLddXuXqTxsRbrn6hUKG5WeNIbNreGcyvDq0jM9ysu4svC0wKPIwuHi2Tg
         zilylZ7NLXQ50n3RQWYKP0vs+9gicf9AKzTo6dSiuG2aqJm7T1Md94U7z2oG6774Cx82
         ZdWA==
X-Received: by 10.68.249.36 with SMTP id yr4mr20799296pbc.18.1440821931629;
        Fri, 28 Aug 2015 21:18:51 -0700 (PDT)
Received: from alex-wolverine.lan ([2601:681:4d04:75d8:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id gw3sm7330087pbc.46.2015.08.28.21.18.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Aug 2015 21:18:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276766>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/show-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index dfbc314..131ef28 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -8,7 +8,7 @@
 
 static const char * const show_ref_usage[] = {
 	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [<pattern>...]"),
-	N_("git show-ref --exclude-existing[=pattern] < ref-list"),
+	N_("git show-ref --exclude-existing[=<pattern>] < <ref-list>"),
 	NULL
 };
 
-- 
2.5.0
