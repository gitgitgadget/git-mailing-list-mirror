From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] push: fix typo in advice message
Date: Mon, 29 Jul 2013 06:23:52 +0200
Message-ID: <1375071832-2959-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 06:24:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3f07-00009V-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 06:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab3G2EX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 00:23:59 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:51344 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab3G2EX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 00:23:58 -0400
Received: by mail-ee0-f52.google.com with SMTP id c41so1921186eek.11
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 21:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=zdOohrE+EiUAsLpJF3YM3pYGnvSrnBL3QjC66+wilF4=;
        b=rRzPD5uIvqc7Iw5WXNOYcQk5bkjKAQ2O4AlJJ5AIPnMRKQdEG9ksy1YpshxOR9W5Af
         7bhO5khCaYZ+FC1FB7a57gGzZt0GG2fKTO8DxF1Jm0Cs2NQG0s3myeyAZfPn9+s2YVEO
         m9KjwRPE2j5TpN5BgNTUW/BXnUnDVDnXCKuSELpmCeOEN7z047lnpvBRiSWe/rslpiz/
         9WKBeeJI7ZnOo//1eKU9EG73VTao0OjN5mO3KPL3oAC5rBigCM+KP+QTlp7oZ5/We4Dw
         HRsCgZmONJ1yhYJJNvtHIa9GhOGAw2eoZAfPQSQlr9ovaZ19W/D5/Hsxm6iVUsX0klXQ
         bK0A==
X-Received: by 10.15.82.132 with SMTP id a4mr58111904eez.107.1375071837617;
        Sun, 28 Jul 2013 21:23:57 -0700 (PDT)
Received: from localhost (dslb-088-073-170-058.pools.arcor-ip.net. [88.73.170.58])
        by mx.google.com with ESMTPSA id n5sm99282164eed.9.2013.07.28.21.23.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jul 2013 21:23:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1873.gfc589a4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231272>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6d36c24..04abd2d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -250,7 +250,7 @@ static const char message_advice_ref_fetch_first[] =
 	N_("Updates were rejected because the remote contains work that you do\n"
 	   "not have locally. This is usually caused by another repository pushing\n"
 	   "to the same ref. You may want to first integrate the remote changes\n"
-	   "(e.g., 'git pull ...') before pushing again.\n"
+	   "(e.g. 'git pull ...') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_already_exists[] =
-- 
1.8.2.1873.gfc589a4
