From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 03/16] git-relink: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:41 -0800
Message-ID: <1361665254-42866-4-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PMG-0003gJ-EU
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759391Ab3BXAV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:58 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:60382 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759317Ab3BXAVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:08 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj3so1121290pad.34
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bXX6NhhnoIBy2S+J0FQaIjhUyuTAeFWfeZvkKOYiRa4=;
        b=CocxQ58svXZpuhwFfQBsd7NN8esiY6etkJiG3cGAk5cgua6Wd+6ESXqpLc/zlNtB25
         9kX7+XH2XcSJ/CHKsEKgxMn/Y6RDHqqfU94vdtfSdskvT0miOxZxrNF/KVUsZ5HM3NiY
         x9ERkW4WNyaFumg3HlEW/e7Ish0gpP2+6v+x6zpeA2kDr4J88yiHrnPQU5xsOQYrac23
         QtGfm/jGHjRlQj39ikOSUlU0wGGotaPSlvbCsD62OxtwbIxHnkcpxIf6NjphLhjGtGrA
         v7WWcQeXk8m+WbNsDdOQfpkatgnoipYYFtex1R5M+SEMgu9E+pD0BwlnGycz9qGXuxrM
         itlw==
X-Received: by 10.66.248.105 with SMTP id yl9mr11732224pac.183.1361665267095;
        Sat, 23 Feb 2013 16:21:07 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.05
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:06 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216953>

Use a lowercase "usage:" string for consistency with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-relink.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-relink.perl b/git-relink.perl
index f29285c..236a352 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -163,7 +163,7 @@ sub link_two_files($$) {
 
 
 sub usage() {
-	print("Usage: git relink [--safe] <dir>... <master_dir> \n");
+	print("usage: git relink [--safe] <dir>... <master_dir> \n");
 	print("All directories should contain a .git/objects/ subdirectory.\n");
 	print("Options\n");
 	print("\t--safe\t" .
-- 
1.8.2.rc0.247.g811e0c0
