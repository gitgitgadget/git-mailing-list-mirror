From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/7] builtin/shortlog.c: make usage string consistent with log
Date: Sun, 21 Apr 2013 14:20:47 +0530
Message-ID: <1366534252-12099-3-git-send-email-artagnon@gmail.com>
References: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:51:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpzK-0008EI-5O
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652Ab3DUIvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:51:06 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:54686 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab3DUIvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:51:03 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so3003834pab.7
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=h8z15GAue9xWVYbKdbUkZE5DIDUtcBtyPhEXbxIuuBU=;
        b=cqo9kHnN030GVJYabq8EqYceC7Mhwh57856ZhT3XwVCJnFdZPmtdAVSK/gDQFglIkw
         dnLnrDtMNrZ0QR/VIC3NnpW9j9e5It3jlGfTOZLhuX5axy9R5iKc6hz0AN830nkKuOZI
         hMtIiolwyLiupugie8EE18Bp8kHMTodF5nWkUT+pYGEkyTqX3wulH0SPWQhwQMvwb0dv
         LQL0gaxVaLd5wV5bnge7A+088RMkMZVJNknOqZyzbULkcq5S5jm7rwtQUtj7JKCemyH/
         f/QSSydWdrzBaDqHU3LKwWTpg8ltHM0SSoaVQdo3X972n90U9UHIV1Nu7eUT7oqg6saU
         yRGg==
X-Received: by 10.68.117.135 with SMTP id ke7mr27310154pbb.0.1366534262858;
        Sun, 21 Apr 2013 01:51:02 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id mm9sm20241909pbc.43.2013.04.21.01.51.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:51:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221929>

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
1.8.2.1.501.gd2949c7
