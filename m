From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 3/4] cat-file: add documentation for '--literally' option.
Date: Wed, 15 Apr 2015 22:30:13 +0530
Message-ID: <1429117213-5040-1-git-send-email-karthik.188@gmail.com>
References: <552E9816.6040502@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 19:00:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQgF-0007qx-DX
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 19:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802AbbDORAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 13:00:41 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36442 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614AbbDORAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 13:00:25 -0400
Received: by pabsx10 with SMTP id sx10so57076034pab.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=asVkf/NUIwKI+yk4tKJpRhQSUQaDgmo4EM84Jp97Fb8=;
        b=LeV97zWmPelsBursN/wQ7wkXpJ/st7BQxEd0JTXMnTHBTSflbQxqI3ZaibBbXHswd7
         XISBXILPM1F9vcKYL1Ntyq9Xv2ULky1piGxzAgIdXUX1ziaq1w28M1aC4h6rsZJ5HDQ9
         qn3DbIg3CNfLU3aS/0aSFPWOoVMyk1DCc7eGY2KVxR7uUKi2+dXhHU0iybOX1J8qs5bn
         PQUQHBCa67mPSjiMdq99K0u319/eRT0sUhjcwpX0WkCWA/4qtbElxwB2skVDFt/hDAHt
         agmoqw20r2JPOwjd8KvswltdDdndC0MWgyAN8KVNbWhbVV3qiDvVbZicabVwJ+Q4K5fJ
         tYmg==
X-Received: by 10.68.68.208 with SMTP id y16mr47928092pbt.34.1429117224731;
        Wed, 15 Apr 2015 10:00:24 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id dc5sm4635077pbc.53.2015.04.15.10.00.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Apr 2015 10:00:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.249.g1310741
In-Reply-To: <552E9816.6040502@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267216>

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-cat-file.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6a16f4..226a9c4 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,7 +9,7 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <object>
+'git cat-file' (-t [--literally]| -s [--literally]| -e | -p | <type> | --textconv ) <object>
 'git cat-file' (--batch | --batch-check) < <list-of-objects>
 
 DESCRIPTION
@@ -69,6 +69,9 @@ OPTIONS
 	not be combined with any other options or arguments.  See the
 	section `BATCH OUTPUT` below for details.
 
+--literally::
+	Allow -s or -t to query broken/corrupt objects of unknown type.
+
 OUTPUT
 ------
 If '-t' is specified, one of the <type>.
-- 
2.4.0.rc1.249.gb598846
