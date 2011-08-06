From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 20/40] whitespace: remediate t6005-rev-list-count.sh
Date: Sat,  6 Aug 2011 18:44:34 +1000
Message-ID: <1312620294-18616-20-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWS-0005FS-TY
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab1HFIqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:03 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab1HFIpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:52 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/ZoyJnYjvSlD5eRJ57a+oXIWyhjd92CyQdn8l4V9Ddw=;
        b=q/9j8563jYDnAPJ6uiKU25zFQOjrZNWYlLOLkiq29NwGSFAqFgED5UmUrKpHMgft8G
         Es/DCcl6jWrL9iey1nyLF7STcDBdh5HxyHAcLuInjoMrkpAkWMjs3mme9CQ18FvzJE2T
         vrl+Rmy5qpkirIVObmNmf7VNBT3rYI1Yd575s=
Received: by 10.231.1.146 with SMTP id 18mr928278ibf.75.1312620352240;
        Sat, 06 Aug 2011 01:45:52 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178848>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6005-rev-list-count.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
index 0b64822..ee9bf64 100755
--- a/t/t6005-rev-list-count.sh
+++ b/t/t6005-rev-list-count.sh
@@ -6,9 +6,9 @@ test_description='git rev-list --max-count and --skip test'
 
 test_expect_success 'setup' '
     for n in 1 2 3 4 5 ; do \
-        echo $n > a ; \
-        git add a ; \
-        git commit -m "$n" ; \
+	echo $n > a ; \
+	git add a ; \
+	git commit -m "$n" ; \
     done
 '
 
-- 
1.7.6.362.gf0e6
