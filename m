From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: [PATCH] Fix worktree usage message
Date: Sun, 18 Oct 2015 17:45:30 +0530
Message-ID: <1445170530-31573-1-git-send-email-tigerkid001@gmail.com>
References: <20151018113902.GA12622@ikke.info>
Cc: Sidhant Sharma <tigerkid001@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 14:16:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znmsl-0003jK-7l
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 14:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbbJRMPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 08:15:45 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36352 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbbJRMPo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 08:15:44 -0400
Received: by pacfv9 with SMTP id fv9so66129305pac.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v7+e1bgyHV0+c0oMFIE07CgLMQ/tR33Tgy2VbJPJLpg=;
        b=VgFAurWMWql2eF5vFpngaLjHlbwo8E7lGPZUpVZ5V5qxEqcDBMnRKTmCeLE3f3vWna
         iXOVycgkoLHlg0mcgXJvjt7Sux9wOf84XAVKXxobH1H12Pv6aRgvQQi8wiEgZDqTfWc1
         nToZeEgllo6j2BOVd5yDvvzPFXtmy0MuddAMMlF1rpEicAeVVl2kvzJSkSkrlkgXqkQi
         Et640IiGfk+/rqZX2qWrLu1jiZXL98IM1SEAQjhVPxz0AYkQW1UeGo09xqVtUfhhqtFT
         JEv7a9Ax3YEOv/o+2KatcXL3WYdm0t6qTOwYbyvjiv2AeFeg60hiDt30S6cFoCU7Cqdk
         OTgg==
X-Received: by 10.68.164.98 with SMTP id yp2mr27757269pbb.125.1445170543897;
        Sun, 18 Oct 2015 05:15:43 -0700 (PDT)
Received: from localhost.localdomain ([182.68.185.98])
        by smtp.gmail.com with ESMTPSA id sn9sm31154334pac.16.2015.10.18.05.15.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Oct 2015 05:15:43 -0700 (PDT)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <20151018113902.GA12622@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279809>

Mark <branch> optional in worktree command line usage to maintain consistency with man pages.

Reported-by: ch3cooli@gmail.com

Signed-off-by: Sidhant Sharma <tigerkid001@gmail.com>
---

 It was reported here: http://marc.info/?l=git&m=144514145804787&w=2

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
