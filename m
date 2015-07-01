From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH] rev-list: add --count to usage guide
Date: Wed,  1 Jul 2015 02:24:11 -0700
Message-ID: <1435742651-15053-1-git-send-email-lawrencesiebert@gmail.com>
Cc: Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 11:24:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAEG0-0007jW-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 11:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbbGAJYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 05:24:36 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36540 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbGAJYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 05:24:33 -0400
Received: by ykdr198 with SMTP id r198so33467345ykd.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UuV62BzyBFblfg7b7G3hA3VbR29uPVgeEEpSKxIDUB0=;
        b=R6HheDQPN52KnBhs2mvyCgUdQyj7SnHdSkjy5ZoLh/9+JadCSM/JXR/VhT7g9UVMz4
         1jcvDEDkJ0ws0GTYrcjUT8wuBHA7vnwCbTFmGyeFtZXZer3bPFAoEL9PHOcYj6ntAwhv
         mM6qlY9G6T5iRMqpKKBlo67qhK72lIxdZNrq47fQzjr32j4wHOavPhje3I8nVPiXHLWt
         1fzyG2EOx34olXBm/90CZpLT4IxLbPR0jR0agBOumVXnjXLCCxIQDsBe2LAkoWGvpb4x
         O2dCV1oFGXuChYbtOmL4YEFyW51BellZRUO8TEi8apl1aseGASlUkHqBcVztneLMASw1
         9o+Q==
X-Received: by 10.170.53.87 with SMTP id 84mr31040244ykv.68.1435742673086;
        Wed, 01 Jul 2015 02:24:33 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id b85sm1409141ywa.29.2015.07.01.02.24.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 02:24:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273145>

--count should be mentioned in the usage guide, this updates code and
documentation.

Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
---
 Documentation/git-rev-list.txt | 1 +
 builtin/rev-list.c             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index b10ea60..7b49c85 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -56,6 +56,7 @@ SYNOPSIS
 	     [ --reverse ]
 	     [ --walk-reflogs ]
 	     [ --no-walk ] [ --do-walk ]
+	     [ --count ]
 	     [ --use-bitmap-index ]
 	     <commit>... [ \-- <paths>... ]
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff84a82..ee9e872 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -42,6 +42,7 @@ static const char rev_list_usage[] =
 "    --abbrev=<n> | --no-abbrev\n"
 "    --abbrev-commit\n"
 "    --left-right\n"
+"    --count\n"
 "  special purpose:\n"
 "    --bisect\n"
 "    --bisect-vars\n"
-- 
1.9.1
