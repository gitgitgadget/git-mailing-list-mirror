From: "Simon A. Eugster" <simon.eu@gmail.com>
Subject: [PATCH 1/2] Documentation clarification on git-checkout regarding ours/theirs
Date: Mon, 15 Jun 2015 14:47:26 +0200
Message-ID: <1434372447-51230-2-git-send-email-simon.eu@gmail.com>
References: <xmqqwpzafe88.fsf@gitster.dls.corp.google.com>
 <1434372447-51230-1-git-send-email-simon.eu@gmail.com>
Cc: "Simon A. Eugster" <simon.eugster@eps.ch>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 15 14:48:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4To3-0001vU-ES
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 14:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbbFOMsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 08:48:00 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35850 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbbFOMr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 08:47:58 -0400
Received: by wgzl5 with SMTP id l5so43030245wgz.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 05:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=blBtmeXnvCdyn0EAU05zQh+yLKhzLQtcgIrrWAcaWnc=;
        b=grdKhmJD92zlYfDMIS2pukTvftIXtt7lzS/aHMahcUDi9R5uScPNBSiAHp3rBgOYfT
         EqWKbG4YYHE6uctEGN+utk9lhF4BdKDYx7Mate3lQ/xK1+wFkAXCF0kl3IjitPX4zt9J
         UcvSTLt6ehJvHGcKpjPo1Gt3o3foPTN3iZSpKlOm4XifxxsilHkvrG+rY7a7K6K+osIu
         1VVtSJXTp1oZOsrX+XMHhnvNPvWQ7WqgKXgFR8BaLfYIlf5sdcoyZwjE6/ro3d1d4cH6
         pKEUr6v6T2r6a6S6f8KRr9zdC3+fpaPN1dH7xhqmTGfGw1cOMaI0OEDT9OFg6SQK0OpH
         hWNA==
X-Received: by 10.194.186.198 with SMTP id fm6mr51889649wjc.101.1434372477368;
        Mon, 15 Jun 2015 05:47:57 -0700 (PDT)
Received: from sie-matemint.localdomain ([194.9.120.21])
        by mx.google.com with ESMTPSA id js3sm18780287wjc.5.2015.06.15.05.47.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 05:47:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1434372447-51230-1-git-send-email-simon.eu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271681>

From: "Simon A. Eugster" <simon.eugster@eps.ch>

Signed-off-by: Simon A. Eugster <simon.eugster@eps.ch>
---
 Documentation/git-checkout.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d263a56..5c3ef86 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -115,7 +115,11 @@ entries; instead, unmerged entries are ignored.
 --ours::
 --theirs::
 	When checking out paths from the index, check out stage #2
-	('ours') or #3 ('theirs') for unmerged paths.
+	('ours', HEAD) or #3 ('theirs', MERGE_HEAD) for unmerged paths.
++
+After a `git pull --rebase`, for example, 'ours' points to the remote
+version and 'theirs' points to the local version. See linkgit:git-merge[1]
+for details about stages #2 and #3.
 
 -b <new_branch>::
 	Create a new branch named <new_branch> and start it at
-- 
1.8.5.1
