From: Matthias Ruester <matthias.ruester@gmail.com>
Subject: [PATCH] builtin/log.c: proper use of usage description array
Date: Sun, 14 Sep 2014 22:11:31 +0200
Message-ID: <1410725491-29789-1-git-send-email-matthias.ruester@gmail.com>
Cc: Matthias Ruester <matthias.ruester@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 22:12:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTG9W-00016G-Rr
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 22:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbaINULx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 16:11:53 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:38132 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbaINULw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 16:11:52 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so3545968lam.0
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=phBOPbqh+laB4x8ZT32zBCGUsYA/hO+t+iV7rSpZFMk=;
        b=X8PzA7A3xvcTZVOU9qn9NqLlMhibiiq38fT0nMouIBAuQdXaUe3YnXGup4vevCzPJK
         IcMcZbuImUmJemdfHxmwHsxs2/GCHfdh+KGc6NgHMkyBLaaUbU57BhkLuLVTud5tYnte
         VX09HLsil31+uWG0T2kn2bzWY3ViP+R9EiHgNv721jp5L5DtqUgDvxI5SfHESS2u7nQ0
         cJe8XMHWML6YFhlNl0ms8eJ484jxGagk+sCtO7aZq9meAsLS21eFzGFURvgU+QrMMEwv
         ZqyF3WUFBmc7jLdljDESGLadlN6JVJHGRHABwFV1650alyeWYi7TDHKrdBxOUtioU+ON
         CVWQ==
X-Received: by 10.112.17.2 with SMTP id k2mr22289184lbd.28.1410725511033;
        Sun, 14 Sep 2014 13:11:51 -0700 (PDT)
Received: from localhost.localdomain ([193.25.42.141])
        by mx.google.com with ESMTPSA id n4sm3374015lah.2.2014.09.14.13.11.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Sep 2014 13:11:50 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.239.g0161978.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257026>

Signed-off-by: Matthias Ruester <matthias.ruester@gmail.com>
---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e4d8122..e713618 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -38,8 +38,8 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
-	N_("git log [<options>] [<revision range>] [[--] <path>...]\n")
-	N_("   or: git show [options] <object>..."),
+	N_("git log [<options>] [<revision range>] [[--] <path>...]"),
+	N_("git show [options] <object>..."),
 	NULL
 };
 
-- 
1.9.1
