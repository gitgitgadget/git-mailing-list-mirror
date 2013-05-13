From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 01/10] remote-hg: trivial cleanups
Date: Mon, 13 May 2013 18:11:51 -0500
Message-ID: <1368486720-2716-2-git-send-email-felipe.contreras@gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:14:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1wr-0007Jj-J3
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab3EMXNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:13:50 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:50457 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab3EMXNs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:13:48 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so8342533oag.1
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0aXz/T5pPcMB0wm84zwjI6dfstmH01wRwaEp/FOdy5M=;
        b=LXb/vm/Mrc2DDa4+ZQfnxKhJWn2c9UQAsrCEjDS06XyJQtNqKJdD1r8AjVgkiTuGZD
         +9dxsJ/6QXDR6NhMV5vhcG2xyZMXHY7LF44IkTkLUDZ/lwSrEiHd4ygxwbUGoSDsmLbE
         8Q/FgIHgIRIBSGyzqBvrMmm1fweUk2ur1eKFkEQ51EXaMvJ5LHnlfgn7Jcc1aAI6nkqE
         tufPp6vBcIXpYDG2KqqR/WqjCuRBMEM/PSQoIwF/Jt+VVzVUH7HPK3znNkkhuF5veMWR
         hBrc9Piiq25FByGCLd3radWSrqQjI+szfvEdrpN6Cj2scyNodRcN3GsQeVQinuydnub1
         StpA==
X-Received: by 10.60.134.71 with SMTP id pi7mr11643794oeb.107.1368486827713;
        Mon, 13 May 2013 16:13:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n6sm19208214oel.8.2013.05.13.16.13.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:13:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224219>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg     | 2 +-
 contrib/remote-helpers/test-hg-hg-git.sh | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 96ad30d..d33c7ba 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -538,7 +538,7 @@ def list_head(repo, cur):
     g_head = (head, node)
 
 def do_list(parser):
-    global branches, bmarks, mode, track_branches
+    global branches, bmarks, track_branches
 
     repo = parser.repo
     for bmark, node in bookmarks.listbookmarks(repo).iteritems():
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 8440341..0c36573 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -455,8 +455,6 @@ test_expect_success 'hg author' '
 		git_log gitrepo-$x > git-log-$x
 	done &&
 
-	test_cmp git-log-hg git-log-git &&
-
 	test_cmp hg-log-hg hg-log-git &&
 	test_cmp git-log-hg git-log-git
 '
-- 
1.8.3.rc1.579.g184e698
