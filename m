From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/10] diff: trivial style fix
Date: Sat, 28 Sep 2013 16:51:43 -0500
Message-ID: <1380405106-29430-8-git-send-email-felipe.contreras@gmail.com>
References: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:58:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2WV-0002LM-1U
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab3I1V54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:57:56 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35480 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab3I1V5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:57:53 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so4113383obc.6
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XI4mGMTXFPClR2qQ4IvHzQZN16zUwOR46/kUPxT6gtI=;
        b=eiQAneZjT3ZAkoeW1Wud/4usnGTxkp/0AUpmMYkLe8+eCd8u0zWinxgCqUHZuVpOcq
         nqnKL856kF1smMSKMejBlzkcT7k+X1v28nO06oobSa2v5ehmMNDjrqcuEVyqocJy9mIU
         IAS3M86R5UzRO+lqpEAPyrBOttvLaLjB8odBpCcAoe5hReEukxGNf61mYsq5Ri12bbuV
         6sMNqyhuDh6jYrSnPHW5N05o+L8BQAXclv1kETEeOPygW4Y3Z7D/lLm6z0jsZh7+HuIV
         NxN9SqrNZM0xL/GAsToGCVgViAjgnr119eP5WFbLmNlKdrfzj5xINk14YeAEXThDzGMe
         3DFw==
X-Received: by 10.182.129.42 with SMTP id nt10mr12132667obb.19.1380405473099;
        Sat, 28 Sep 2013 14:57:53 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm19436016obc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:57:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235515>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 2fb8c5d..adb93a9 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -169,7 +169,7 @@ static int builtin_diff_tree(struct rev_info *revs,
 	if (ent1->item->flags & UNINTERESTING)
 		swap = 1;
 	sha1[swap] = ent0->item->sha1;
-	sha1[1-swap] = ent1->item->sha1;
+	sha1[1 - swap] = ent1->item->sha1;
 	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 	return 0;
-- 
1.8.4-fc
