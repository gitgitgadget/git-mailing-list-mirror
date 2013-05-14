From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/47] remote-hg: trivial cleanups
Date: Mon, 13 May 2013 23:36:24 -0500
Message-ID: <1368506230-19614-2-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:38:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc70m-0003jN-6T
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645Ab3ENEin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:38:43 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:46244 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab3ENEim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:38:42 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so98836obc.1
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0aXz/T5pPcMB0wm84zwjI6dfstmH01wRwaEp/FOdy5M=;
        b=JFreAe5MlQpNrp2LjJt4qYSk0zbkmp8rkv4nSbxSmuJR7rzyglL+uAZnddeGgHwmay
         VORKJvQbbN8rDOx5puXX1Y/8EFjQO4wK6h+NNu+QyPYV450uDRHrsZJSkbes3+Im5g1T
         +vAWN7blYuwv3KneYkLBnHNADK1tIUg8HtP9lh2IjW1aIzSdceu0JTQJdoJnxFIoJOdT
         cVnVTYBatY2SRWASOydDwZEzweqYWhkTWiUMBVdrsbZRu8zODAJffiMrZAXDgKgoCoFZ
         wSgCgZ2J/GkCSAx1exrg4ziGNSGZxBI/JJGneE6B+fPDi1srTuykONBEBu//gyQneelf
         8N/Q==
X-Received: by 10.60.37.98 with SMTP id x2mr15776938oej.44.1368506322125;
        Mon, 13 May 2013 21:38:42 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h8sm19967298obk.10.2013.05.13.21.38.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:38:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224236>

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
