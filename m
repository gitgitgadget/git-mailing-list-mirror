From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] Documentation: added long options for -v and -n
Date: Fri,  9 Jan 2015 13:48:40 +0600
Message-ID: <1420789720-8688-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 08:50:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9UJl-0004NY-89
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 08:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbbAIHtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 02:49:03 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:49972 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbbAIHtB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 02:49:01 -0500
Received: by mail-lb0-f180.google.com with SMTP id l4so6830789lbv.11
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 23:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4HhsW+Fj56yvMYWoCqDQB96MTtnkuqOqBaHjL40FSEY=;
        b=ly1NvGm8CzDx3BrB5U5yE3WpP37EDmOJycCGYvgXbmPXrK3S/MDTKSV1NPaor08eBO
         e1PaX51Y4sAEGkWALqegBkLrBZSDoHa7gAR9EdozH6ek6xLWfwQb1Hqje01FTUntgjLw
         H0gytkddtCuArgVijkXTJfd1Hd5uUodak1oXmFSEfY9nCVBgi92Qd4ShXaA43xBoqseC
         OC3YJNt9AnKBTDt7DMCtXuyIPJzugDhSd6hPbXExzYDJRRQkdlT7r0ctgFa/4COFM5xT
         Z4TXcohg7bb7LOaGMlMPo6wKawFVmtQ/XNCBy2NcV4QUrawO4UptPInlcFkkjeFg1x/4
         00CQ==
X-Received: by 10.113.11.12 with SMTP id ee12mr19845626lbd.79.1420789739810;
        Thu, 08 Jan 2015 23:48:59 -0800 (PST)
Received: from localhost.localdomain ([92.46.69.16])
        by mx.google.com with ESMTPSA id wq1sm1682537lbb.24.2015.01.08.23.48.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jan 2015 23:48:59 -0800 (PST)
X-Mailer: git-send-email 2.2.1.522.g2561c04.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262231>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-add.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9631526..1c74907 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -8,7 +8,7 @@ git-add - Add file contents to the index
 SYNOPSIS
 --------
 [verse]
-'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
+'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
 	  [--] [<pathspec>...]
-- 
2.2.1.522.g2561c04.dirty
