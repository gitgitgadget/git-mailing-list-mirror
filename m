From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/16] diff: trivial style fix
Date: Thu, 31 Oct 2013 03:25:44 -0600
Message-ID: <1383211547-9145-14-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbocx-0008Mw-An
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831Ab3JaJdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:33:04 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:55646 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab3JaJdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:33:00 -0400
Received: by mail-oa0-f50.google.com with SMTP id j6so2775183oag.37
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KGlhjzNFXM18kAeGyMnxGRvEAuAOLRrWyhswpfjgAl4=;
        b=uoPgOCcNAW9I1rIbo+ZUfXjGCMpzHPkFIoL6tpEnPpwQ13fy4CaUDGLn2xpf0Oetsv
         ett5Vwkq2laEY65QqWuN06LGMP7RtwLmluWq9w1G7+MfsBK9rJsakZireA3jqHCGKKc2
         4lBxy8YXGOr5NkGl2X+1/9qoR2QwMw1uk2J0u/t/fahVx0pWVvTEfK9owxr0w8csvCEd
         gATsM4ozWqZdFKZF4X3pRIyLTrK8aA3AEGflOgi5j3dMLWDjouA5EExw0dEfe/QNIer6
         Zjci+WyJWJfdFaCi0a/V8w3QolwSdARPcKJwPbtpYGQXyjx+6+/H+YWp4LM9PeLzEZqN
         VKiw==
X-Received: by 10.182.96.100 with SMTP id dr4mr1901242obb.22.1383211979918;
        Thu, 31 Oct 2013 02:32:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm4455423obi.14.2013.10.31.02.32.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237097>

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
1.8.4.2+fc1
