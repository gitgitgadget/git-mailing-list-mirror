From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 3/4] cat-file: add documentation for '--literally' option.
Date: Sat,  4 Apr 2015 11:14:24 +0530
Message-ID: <1428126264-19179-1-git-send-email-karthik.188@gmail.com>
References: <551F7984.5070902@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 07:44:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeGsr-0007dI-FD
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 07:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbbDDFoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 01:44:37 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32999 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbbDDFoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 01:44:37 -0400
Received: by pdbnk13 with SMTP id nk13so62970799pdb.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 22:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ARqFh2yNRrLdKah3F35SC8QcOD7K9Uteqpmhi/RMMSI=;
        b=zL/uK37o452wozx0DiSLwaidkignY3alT2CEiAELKN+jcuLzhzrMh3BoSEhQp06SuR
         ijB+AwY2dTdX82geo2Rz2WMyxuiPcqAvhmhIqLfz8W2YKY6LnEWzQkgE6pDA7Cwhopkv
         RiodfSdJXVJ9MARPcit7dJScFc6DuyNwXcgXxpU65kLXgF4O009O05B8ZvD/4S3+egaT
         rY7vTmlL1keJ+kMUoRzSUl4AUVxM9+jxnc8XRDZyUalCak/yzgQW/IhyusWP2PsfxQTP
         i/Mk+AXP2Hr3gQQuLa6gY4npI9r45pu9xW/zgMcu1p7ozr7lXS3Ljm3LGilZvt0nYxSG
         FlDQ==
X-Received: by 10.66.171.199 with SMTP id aw7mr9913736pac.6.1428126276633;
        Fri, 03 Apr 2015 22:44:36 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id pa6sm9822631pac.45.2015.04.03.22.44.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2015 22:44:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.249.g9f2ee54
In-Reply-To: <551F7984.5070902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266764>

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
2.4.0.rc1.249.g9f2ee54
