From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 08/40] whitespace: remediate t3406-rebase-message.sh
Date: Sat,  6 Aug 2011 18:44:22 +1000
Message-ID: <1312620294-18616-8-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVl-0004uu-Qo
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab1HFIpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:30 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1HFIpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:23 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LbnGw65nCXO8ypXk/myCSCPHnh/fa91puwzzROFydbs=;
        b=t7KBbSIjigmLTFOKnxd0U4069o5pvjpRNq84lHrKvndV9a3yLxHYTliIw4K0W1chvY
         vO6ISUCo6KqFnOGnzt/i2bNNSG9xJpk0DxRCQ3INFz4ryvN6e/ZpmDNG/fDuQPQDVKGW
         KOMNrm1JWEfYgiPSpEsTr7YKIWr53s9cTJj8s=
Received: by 10.43.51.130 with SMTP id vi2mr3124903icb.59.1312620322978;
        Sat, 06 Aug 2011 01:45:22 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178837>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3406-rebase-message.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index fe5f936..f4bc0a8 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -44,22 +44,22 @@ test_expect_success 'rebase -m' '
 
 test_expect_success 'rebase --stat' '
 	git reset --hard start &&
-        git rebase --stat master >diffstat.txt &&
-        grep "^ fileX |  *1 +$" diffstat.txt
+	git rebase --stat master >diffstat.txt &&
+	grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase w/config rebase.stat' '
 	git reset --hard start &&
-        git config rebase.stat true &&
-        git rebase master >diffstat.txt &&
-        grep "^ fileX |  *1 +$" diffstat.txt
+	git config rebase.stat true &&
+	git rebase master >diffstat.txt &&
+	grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase -n overrides config rebase.stat config' '
 	git reset --hard start &&
-        git config rebase.stat true &&
-        git rebase -n master >diffstat.txt &&
-        ! grep "^ fileX |  *1 +$" diffstat.txt
+	git config rebase.stat true &&
+	git rebase -n master >diffstat.txt &&
+	! grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_done
-- 
1.7.6.362.gf0e6
