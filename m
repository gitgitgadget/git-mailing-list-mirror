From: larsxschneider@gmail.com
Subject: [PATCH v1 2/3] travis-ci: disable verbose test output
Date: Sun, 22 May 2016 13:00:55 +0200
Message-ID: <1463914856-64745-3-git-send-email-larsxschneider@gmail.com>
References: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 13:01:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4R8H-0001yu-CQ
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 13:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbcEVLBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 07:01:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33851 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbcEVLBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 07:01:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so7685111wmn.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PzRfjyCKFqMTyEx0HGc77aNLSLPEne6tW+2IML3bOoI=;
        b=YG1p/oh+00WYcNAMrQ56+mt8rb8MtrM9xmgWTpSg2qMklPhMnbEvot42gFPW6OJXPd
         QzDsolHM6KahHCugwvepNnYyrAgRddxrYVD6fgdJM88m2QpOW/5duLOGCY5eeAPzY8J+
         /2AaruyJnqmBtghCbrRFb5a+1LDkj1XL1Q0CrTiFS35qDm8/7fJ60kSM7QjsHMf8EQ3h
         bbng2cEEjOijt33iSafFa0LBkHqHyljF1so4oFoxT8UkhYyPnOnh98fZe4E6r5LvUIVo
         LnRSzWKlM7lg6WTT7QZ+DDx+c42WPKnoz3f2cdjKN0sD2tFrCE3MFvb4/uwhwzBg8Hnj
         c1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PzRfjyCKFqMTyEx0HGc77aNLSLPEne6tW+2IML3bOoI=;
        b=SENGTAjzy/cbnXH0x0r+VNKf3nFxbjcZvL403Nmcwi6AELG4ncNCm7q+C2S3aG2L9D
         TMUz2EAZZadxsGNWewWRS7zN/iKJXgRywOJXpZHuTdnS3u5BYjpDTJGXgZVaf+fdCSKU
         Ajslw+IHmeZqILqrLyEDJ3ytSAJXLVLtEQTewGiG/K2I51SQvJgQDUV/cehRzr0SzQNm
         gZszSGWgaUkEqXK7EuW2SgiNcnKJrkrtZIur2Jf2Pg0/hF72rGl6YDsduvhTaiERIwXQ
         EflsMfdeqoC19iOIXgkMl7bLf3W89DrF4rLAyY+51zAVAz64rxawJTMRqlfat1WDEVdx
         cYuw==
X-Gm-Message-State: AOPr4FXejeCCFQN+L/35K+3Jw3PefrvabthytCZkZan59AxMytKow4hTdLpKrP827AhQ8A==
X-Received: by 10.28.27.151 with SMTP id b145mr12131094wmb.7.1463914860339;
        Sun, 22 May 2016 04:01:00 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB5ECD.dip0.t-ipconnect.de. [93.219.94.205])
        by smtp.gmail.com with ESMTPSA id u4sm29343478wjz.4.2016.05.22.04.00.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 May 2016 04:00:59 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295276>

From: Lars Schneider <larsxschneider@gmail.com>

The verbose output clutters the Travis CI webview and is not really
useful since test debugging usually happens on a local machine.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index a93ecb3..81d2027 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -29,7 +29,7 @@ env:
     - LINUX_GIT_LFS_VERSION="1.2.0"
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
-    - GIT_TEST_OPTS="--verbose --tee"
+    - GIT_TEST_OPTS="--tee"
     - GIT_TEST_CLONE_2GB=YesPlease
     # t9810 occasionally fails on Travis CI OS X
     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
-- 
2.5.1
