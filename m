From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: [PATCH] Fix worktree usage message
Date: Sun, 18 Oct 2015 16:32:24 +0530
Message-ID: <1445166144-29509-1-git-send-email-tigerkid001@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 13:02:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znljh-00016e-Nn
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 13:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbbJRLCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 07:02:41 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35920 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbJRLCk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 07:02:40 -0400
Received: by pacfv9 with SMTP id fv9so65209598pac.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=tjTdW9IsBnqxnUmNMxJKjEU1mti8WilSFmIaCHl8i2Q=;
        b=gz2GmfsJZw2LAGUUNqcwTy5l9bidKXcsYq1sdwKHRngKKShaB74jt6n7rEHN72bNil
         tO1jukeQGad1yNf1fQmQDXXUtsyZ9z3m2LBotrSQRqRTm/y6JW/2Bp/48GpEsiJCHE53
         M2DQ+vePatffVQCuDWq7WSV7aePswFBYmj5eBYC2Njz8FcaZ8oKzBngkb17iEFvKZySI
         VrAUK9++XbTuW64oCpgkFVl7jzbb9s2hXiZKepsN9NLOdkT9FaZhrxqi0yjwL1vvwAv8
         yQqWpfuUs3TCfRouga8dlzTcfEXSWcxbX1GbboK8wf0Wbb66audFdtj7uNhwc6Qc7rCz
         RRgw==
X-Received: by 10.66.132.37 with SMTP id or5mr27389844pab.5.1445166160523;
        Sun, 18 Oct 2015 04:02:40 -0700 (PDT)
Received: from localhost.localdomain ([182.68.185.98])
        by smtp.gmail.com with ESMTPSA id po7sm30577021pbc.56.2015.10.18.04.02.39
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Oct 2015 04:02:40 -0700 (PDT)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279806>

Mark <branch> as optional in worktree command line usage.

Hi, just starting out with development for Git. Found this one super easy to fix,
so made a patch :)

---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 71bb770..33d2d37 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -10,7 +10,7 @@
 #include "refs.h"

 static const char * const worktree_usage[] = {
-	N_("git worktree add [<options>] <path> <branch>"),
+	N_("git worktree add [<options>] <path> [<branch>]"),
 	N_("git worktree prune [<options>]"),
 	NULL
 };
--
2.6.2
