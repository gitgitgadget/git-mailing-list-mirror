From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: [PATCH] Fix missing brackets in worktree usage
Date: Sun, 18 Oct 2015 15:54:33 +0530
Message-ID: <1445163873-18485-1-git-send-email-tigerkid001@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 12:25:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znl9c-00081G-3j
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 12:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbbJRKYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 06:24:48 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34159 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbJRKYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 06:24:47 -0400
Received: by padhk11 with SMTP id hk11so514043pad.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=ZvHKXAF2iXJ4XcV47F9wxiofLFvI54ucygpqXauoE5w=;
        b=ZDI6IGmXBY7spQxDwM5u1T/LMQRD9fVDTVEo+8PK/GdMxsLircP6Zx/hZs3DGvEwkH
         6NSQ7tVNg9CWK9uOTdLWGSJQd91m0G81HrWb36pgOtlckWep4gZUFRIqF4uzqvqkq+hM
         42ywbu0RVTI7NzEyMmJrOsStOrq5ZouM1BOrVXTd7Lpwhaw9e0KNKk+hMj4DK8j7P2O/
         3v37IT7ZU+8oPEs3ICWFIW6fAWWmC4OJLANEdTtBlJP8qKrb6bfRUiDDzzUFhja1XI4v
         LNIBg7ittOE3zn3gBILrVDa3ua5o+MG7kKADpPxKNkT5A+MB7UPcthlGl9+ohSKQpABd
         hMJw==
X-Received: by 10.66.253.99 with SMTP id zz3mr27429076pac.38.1445163887357;
        Sun, 18 Oct 2015 03:24:47 -0700 (PDT)
Received: from localhost.localdomain ([182.68.185.98])
        by smtp.gmail.com with ESMTPSA id pw7sm8211402pbc.4.2015.10.18.03.24.46
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Oct 2015 03:24:46 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279805>

H, I'm just starting out with development for Git. Found this super easy to fix,
so here is a patch :)

Sidhant Sharma (1):
  builtin/worktree.c: Fix usage message

 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.6.2

>From 6b9bc79b698d4c9e1a0f74c37887caf2a05f9978 Mon Sep 17 00:00:00 2001
From: Sidhant Sharma <tigerkid001@gmail.com>
Date: Sun, 18 Oct 2015 13:29:02 +0530
Subject: [PATCH] builtin/worktree.c: Fix usage message

Mark <branch> as optional in worktree command line usage.

Signed-off-by: Sidhant Sharma <tigerkid001@gmail.com>
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
