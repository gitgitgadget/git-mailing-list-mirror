From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 3/4] cat-file: add documentation for '--literally' option.
Date: Thu,  2 Apr 2015 16:30:04 +0530
Message-ID: <1427972404-15565-1-git-send-email-karthik.188@gmail.com>
References: <551D1F99.5040306@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 13:00:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdcrG-0001wd-DR
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 13:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbbDBLAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 07:00:18 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33477 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbDBLAR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 07:00:17 -0400
Received: by pdbnk13 with SMTP id nk13so6068439pdb.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+HwgG5DBH5nYq05rgV9KIBrn1SGh1kfbkSVwUT6ORPk=;
        b=Kfp6LbDurLsc6SB/qcIRSKESh/aCX6rLg+aTDLabu/I89JDOoMlYrgr68bIxK1svJ2
         0oAsIfBVUAxLmfyrIXgUjlTA4omwyg+aKuJnZ9rxFKitDoryfPXlHxYqOHzS3UkNN5dH
         xHXkJWJ3+hBQVWa7VEL0e6f9OXMYdqGy5bAoLX2XAOl29Eh09KqFIQ4i0v2DdvI1cesv
         tjII+Q1nq2cBO0JK1kbCovWaIoFaHyl4UwzACqcOg6yR9o/VMwq2P4xtkSXXJPFedNSE
         jo3KHeYv+ZkG1o1+GV+1Df2NwhgjBNtMWnsj8Wp7M8CF/HHdsoIr7ZtWCrsA3lFw90tM
         +jRg==
X-Received: by 10.70.36.198 with SMTP id s6mr30498924pdj.143.1427972416383;
        Thu, 02 Apr 2015 04:00:16 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id pr1sm4851060pbc.66.2015.04.02.04.00.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2015 04:00:15 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.172.g04a1281
In-Reply-To: <551D1F99.5040306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266637>

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-cat-file.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6a16f4..8bac7bd 100644
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
@@ -69,6 +69,10 @@ OPTIONS
 	not be combined with any other options or arguments.  See the
 	section `BATCH OUTPUT` below for details.
 
+--literally::
+	Print information of broken/corrupt objects of unknown type without
+	throwing an error. To be used combined with '-s' or '-t' option.
+
 OUTPUT
 ------
 If '-t' is specified, one of the <type>.
-- 
2.3.1.172.g04a1281
