From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 4/5] cat-file: add documentation for '--allow-unkown-type' option.
Date: Wed, 29 Apr 2015 18:26:26 +0530
Message-ID: <1430312186-23542-1-git-send-email-karthik.188@gmail.com>
References: <5540D397.8020104@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 14:56:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnRXh-0006sV-W7
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 14:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423017AbbD2M4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 08:56:42 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36817 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422821AbbD2M4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 08:56:41 -0400
Received: by pdea3 with SMTP id a3so27567980pde.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mahK/xay3JglbiiNO1QGJHtvaWuSxgEkU05AfEKLW/A=;
        b=yq6uVhdbPSDYymOb+zV1Qaekubr/OSQFvR8fwqywbNiJ994OWyU5cZVgiXP1kWjMz1
         koVHH06V1fQYlmzSx9iot+1B4IW9xogx6NxXtz09bSOyubQy4ErvswOVPH6o+iQGJX+c
         TB4WIBaB7s2fCw8c6prb9nrtYx9gIFemN5XM1OILCtbOHh/r/ypIDOSJs0PI7X6JjWru
         hLPaU70ASrA7ReF4jNnrR39yFM9OwkcLBHA+Zxi0qZTm7tva6QFSJpt7nknB1ZzIdYU/
         JGESIzCvvzswY9XJKAFLHFDiZJC9E3WHZmnTKG1S/VR+DjGLqfuBLYfnLm7ikHYSztPA
         bLyQ==
X-Received: by 10.70.134.133 with SMTP id pk5mr41692681pdb.133.1430312201099;
        Wed, 29 Apr 2015 05:56:41 -0700 (PDT)
Received: from ashley.localdomain ([182.48.234.2])
        by mx.google.com with ESMTPSA id dv3sm13709814pbb.91.2015.04.29.05.56.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Apr 2015 05:56:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.250.g565e85b
In-Reply-To: <5540D397.8020104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267965>

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-cat-file.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6a16f4..f6f6064 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,7 +9,7 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <object>
+'git cat-file' (-t [--allow-unkown-type]| -s [--allow-unkown-type]| -e | -p | <type> | --textconv ) <object>
 'git cat-file' (--batch | --batch-check) < <list-of-objects>
 
 DESCRIPTION
@@ -69,6 +69,9 @@ OPTIONS
 	not be combined with any other options or arguments.  See the
 	section `BATCH OUTPUT` below for details.
 
+--allow-unkown-type::
+	Allow -s or -t to query broken/corrupt objects of unknown type.
+
 OUTPUT
 ------
 If '-t' is specified, one of the <type>.
-- 
2.4.0.rc1.250.g565e85b
