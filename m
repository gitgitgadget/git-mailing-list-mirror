From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/7] t: trivial whitespace cleanups
Date: Sat,  7 Dec 2013 23:56:57 -0600
Message-ID: <1386482220-18558-5-git-send-email-felipe.contreras@gmail.com>
References: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 07:06:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpXVG-0004iR-BQ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 07:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114Ab3LHGF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 01:05:58 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:63303 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab3LHGEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 01:04:42 -0500
Received: by mail-oa0-f42.google.com with SMTP id i4so2566429oah.15
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 22:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9swEa4j+syn+cpK7DvMNrsVKnMA2u3xAv3EAoPjw0eM=;
        b=DZ9NDRDI+25UcOLrDyTbX7tKozS5hwxcodzQ8N69KyegjjO5DmBE1M58/DjJKh/ykG
         UuvEiTi4G0p5L3yXZHhegW0JrY6wQhxABPNRr6hgCaNFPdVue59HpWxw9Mn4TSbpmfLs
         2DU0XMpFOwzRAi7L+FuzMel8IGGSdS5urN5hBeatebcG9m0P0WpDgE59O1Ga5yByGMPF
         0btjSiC5hdQ939coe+HgvSAIzQHhAKAuwU9+JQQUH3hvQ4Hnnt+jRmsNTZXyMtUt+4ZD
         JPWgw3mukPSX4N/m1ndHikAgWRqtAIvL6ggwD4vl11nNrXKHMturOf+MVM/xGTyi5/eP
         p3pA==
X-Received: by 10.60.63.141 with SMTP id g13mr396878oes.60.1386482682267;
        Sat, 07 Dec 2013 22:04:42 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm8178984obc.10.2013.12.07.22.04.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 22:04:41 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1.2.gebd1fb1
In-Reply-To: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239038>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t0002-gitfile.sh    | 3 +--
 t/t0003-attributes.sh | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index cb14425..37e9396 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -7,7 +7,7 @@ Verify that plumbing commands work when .git is a file
 . ./test-lib.sh
 
 objpath() {
-    echo "$1" | sed -e 's|\(..\)|\1/|'
+	echo "$1" | sed -e 's|\(..\)|\1/|'
 }
 
 objck() {
@@ -19,7 +19,6 @@ objck() {
 	fi
 }
 
-
 test_expect_success 'initial setup' '
 	REAL="$(pwd)/.real" &&
 	mv .git "$REAL"
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 0b98b6f..b9d7947 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -13,7 +13,6 @@ attr_check () {
 	test_line_count = 0 err
 }
 
-
 test_expect_success 'setup' '
 	mkdir -p a/b/d a/c b &&
 	(
-- 
1.8.5.1+fc1.2.gebd1fb1
