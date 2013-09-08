From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] sequencer: trivial cleanup
Date: Mon,  9 Sep 2013 04:12:40 +0530
Message-ID: <1378680160-4720-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 09 00:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VInmi-0005TW-5W
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 00:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960Ab3IHWso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 18:48:44 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62115 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3IHWso (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 18:48:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so5393589pbb.33
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=o048OSeOGnRBbAdBHicy5AwWH4704fTR5i4aeWlyXLA=;
        b=bNaiLNKT0MWpP5Nhromfpn1rVpTb5lqMxUfdqGTGrLAxnGZwRkiozkzaHsLdfxuSs9
         DANntCl6aMNW4rfhKrzCS12AZZVLLIUegkCHBfbzmRLJ5guCPHGVAFAZf5xtMB+kQyIl
         HVmaeYysKsvGEEOYSztN5P68V8dqAVyUp6yg9c4HcC5GZi6dCGGLXzgXNbCJ+OBr4XEJ
         kKCPHjzrIvvieXxZ87f+TOO9hOfBbIwCpH4sGJxFEX48NBw03sG16e/FNXsPefAvnAWH
         6/fnseZbbkKdgxzHrxCakR2f9uT2s6ovPEf+RXCapPdO58iEgjTvQop1NLTPtmW7zPYc
         9xSw==
X-Received: by 10.68.228.230 with SMTP id sl6mr15615611pbc.98.1378680523756;
        Sun, 08 Sep 2013 15:48:43 -0700 (PDT)
Received: from localhost.localdomain ([122.164.161.56])
        by mx.google.com with ESMTPSA id os4sm12160332pbb.25.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 15:48:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.100.gd1e2c27.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234275>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 351548f..8ed9f98 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -466,10 +466,7 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 	empty_commit = is_original_commit_empty(commit);
 	if (empty_commit < 0)
 		return empty_commit;
-	if (!empty_commit)
-		return 0;
-	else
-		return 1;
+	return empty_commit ? 0 : 1;
 }
 
 static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
-- 
1.8.4.100.gde18f6d.dirty
