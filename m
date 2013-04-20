From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] builtin/shortlog.c: make usage string consistent with log
Date: Sat, 20 Apr 2013 17:15:10 +0530
Message-ID: <1366458313-7186-3-git-send-email-artagnon@gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 20 13:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTWEo-0000g4-L2
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 13:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060Ab3DTLpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 07:45:36 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:57547 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab3DTLp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 07:45:26 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so2320071dal.26
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4Nd1HdQAyRxxPigACrdDqGNm56ztaNytgIwWkwSg2lk=;
        b=CZsF2SsEAa4prxGFEzrgemh6EU+GGnSDZ6iewIaeJwdh8CH1vGFyKH80P0g53+sl5I
         xPDWNp8UFwUKSUjgEsxlIfZuuU6VkJgK2WhBLwEBFBmkVGQTHeiDxQKNpwJXTpa3UfLq
         JluVwpHMtx8pbxUAvxSlXsYBPMzTSZsd107bneRlcZU6knnkQITw/Hemp+NoWTq9kLbO
         Rv/YooA+DQNWW8n69scSQtFYkbzQL6ZRizdDCmv9UyMGbJ2n0YphjBURhkuDTVlJeenr
         NdIFB6fwAMKsczApbdUsRuhjVZjSMNlVuwHEKH2Z7cAG5rQ83c0EIfL3tH8NfRga3i4o
         xh3A==
X-Received: by 10.68.170.99 with SMTP id al3mr10953612pbc.201.1366458325758;
        Sat, 20 Apr 2013 04:45:25 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id ag4sm629048pbc.20.2013.04.20.04.45.23
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 04:45:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.506.gbce9ff0
In-Reply-To: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221851>

"--" is used to separate pathspecs from the rev specs, and not rev
specs from the options, as the shortlog_usage string currently
indicates.  In correcting this usage string, make it consistent with
the log_usage string.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/shortlog.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 240bff3..a2f54f2 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -10,9 +10,7 @@
 #include "parse-options.h"
 
 static char const * const shortlog_usage[] = {
-	N_("git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>... ]"),
-	"",
-	N_("[rev-opts] are documented in git-rev-list(1)"),
+	N_("git shortlog [<options>] [<since>..<until>] [[--] [<path>...]]"),
 	NULL
 };
 
-- 
1.8.2.1.506.gbce9ff0
