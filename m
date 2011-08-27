From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 3/4] t/t3905: add missing '&&' linkage
Date: Fri, 26 Aug 2011 19:59:26 -0500
Message-ID: <1314406767-17832-3-git-send-email-drafnel@gmail.com>
References: <1314406767-17832-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, hilco.wijbenga@gmail.com, david@porkrind.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 27 03:01:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx7Gp-000794-7z
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 03:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab1H0BBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 21:01:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34692 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab1H0BBH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 21:01:07 -0400
Received: by mail-gy0-f174.google.com with SMTP id 6so3313241gya.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 18:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FEv2zm/EDiTYVAIWbx2VkOZKheHHjENYaCPiOwhTIKk=;
        b=CHzpt8uFM6ycuzP6xsgUZWss+IEu+jzLLQ/SF7yOJ6R/+e/U9kz+u5b31XezB7zv5Z
         A3hhe/q/7x0cnX9L0GDxOy6zqOZbQXC0QoqNrrlNp3ht211kfcnG9pH8g+skox99BBNK
         SDU0D3JlkqT66/lQMy2wF9Yb5nuwLOKYPlH+0=
Received: by 10.90.230.17 with SMTP id c17mr1790060agh.57.1314406867076;
        Fri, 26 Aug 2011 18:01:07 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id j45sm2756593yhe.36.2011.08.26.18.01.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Aug 2011 18:01:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1314406767-17832-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180212>


Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t3905-stash-include-untracked.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index adc2524..ca1a46c 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -28,7 +28,7 @@ cat > expect <<EOF
 EOF
 
 test_expect_success 'stash save --include-untracked cleaned the untracked files' '
-	git status --porcelain >actual
+	git status --porcelain >actual &&
 	test_cmp expect actual
 '
 
@@ -71,7 +71,7 @@ EOF
 
 test_expect_success 'stash pop after save --include-untracked leaves files untracked again' '
 	git stash pop &&
-	git status --porcelain >actual
+	git status --porcelain >actual &&
 	test_cmp expect actual
 '
 
@@ -136,7 +136,7 @@ test_expect_success 'stash save --include-untracked respects .gitignore' '
 
 test_expect_success 'stash save -u can stash with only untracked files different' '
 	echo 4 > file4 &&
-	git stash -u
+	git stash -u &&
 	test "!" -f file4
 '
 
-- 
1.7.6
