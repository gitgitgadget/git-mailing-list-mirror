From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] t9300-fast-import: fix typo in test description
Date: Sun, 21 Sep 2014 17:02:57 +0200
Message-ID: <1411311777-11115-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: pw@padd.com, gitster@pobox.com, git@vger.kernel.org,
	rhansen@bbn.com
X-From: git-owner@vger.kernel.org Sun Sep 21 17:03:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVifO-0006lH-2L
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 17:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbaIUPDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 11:03:05 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:52091 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaIUPDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 11:03:04 -0400
Received: by mail-wi0-f175.google.com with SMTP id r20so1647967wiv.2
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uoB3WDR9MRH4QHTJkwmmvTH/1nzb7VWinTqLI1Rj0Ik=;
        b=EHodbKP1eQ4Hjj6veFTJ6Csge/QccqIHsEpszaJyt/Bq7jMti62Oj4aafGyhbqiQoA
         tBXrvperwOJDb9GYQf1GlsHseec3jZ6qW4d1a4eFb3R6MUdAaDM1CgvLm91+wmfoQ20l
         5p+cLXd4fgfvfJWEeoYqszeZdFyxh/pw1RlD425QgRLmD+xSoOxSCPh0fYr8/5315KKh
         5P1uKr1x+cNgf1ml/cKdepuPtH9zO1UO26aD1Wm7+1F3i79iSIX85dhCBUlsTssNk7rF
         WfpOZ3fXQRDcMTzMUvVyd8F19O0HMlHqe77ncz03EWKJlRQpPzrvPbkgFHKjyOmK1FXB
         X7sw==
X-Received: by 10.180.10.9 with SMTP id e9mr9517742wib.74.1411311782663;
        Sun, 21 Sep 2014 08:03:02 -0700 (PDT)
Received: from localhost (p578F81B0.dip0.t-ipconnect.de. [87.143.129.176])
        by mx.google.com with ESMTPSA id et1sm9163168wjd.11.2014.09.21.08.03.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Sep 2014 08:03:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.238.gce1d3a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257352>

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 t/t9300-fast-import.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 8a05449..8df0445 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2866,7 +2866,7 @@ test_expect_success 'S: notemodify with garbage after sha1 dataref must fail' '
 #
 # notemodify, mark in commit-ish
 #
-test_expect_success 'S: notemodify with garbarge after mark commit-ish must fail' '
+test_expect_success 'S: notemodify with garbage after mark commit-ish must fail' '
 	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
 	commit refs/heads/Snotes
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-- 
2.1.0.238.gce1d3a9
