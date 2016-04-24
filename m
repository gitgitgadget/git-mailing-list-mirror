From: larsxschneider@gmail.com
Subject: [PATCH v3 1/3] travis-ci: update Git-LFS and P4 to the latest version
Date: Sun, 24 Apr 2016 20:58:10 +0200
Message-ID: <1461524292-20490-2-git-send-email-larsxschneider@gmail.com>
References: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com>
Cc: sschuberth@gmail.com, gitster@pobox.com, ben.woosley@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 20:58:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auPEc-0006Dm-TC
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 20:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbcDXS6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 14:58:20 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35339 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbcDXS6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 14:58:18 -0400
Received: by mail-wm0-f42.google.com with SMTP id e201so65148957wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ITctNAy64PhlGpB0LG+ZgMCpEcVQypND1eTHJ9KVW/M=;
        b=fqh2bLABw1pT4BlvKmILqEFIBP30r7TV0VIwaRRxHEHZKI5rAY6a8d9k84jGs9r2T2
         zrVhobfOyXktAH9GgmMgVgUIwuZ41s64x2qiXezDjILA/Wg/bs8Fq6JDETLxeg2ltoXQ
         yoErGE5fFEVWjB76Lsrgv5CLT2GF206xnqPdw9Ns2V6rlOsoYGQXqy+1TGuwgICTCLFT
         6fLIsEH+2GpM13vXhWo7B2MWSd/bU7wVt0VOZYSGjJiSpNp44816OglSNvb1Wlm4ORle
         K+1FJOKxgJdUpsxlr/oZ9agbqadHnhdsA/HbikWhI9pAhAGYXWy4RSwzgAQBK//EuZjJ
         T+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ITctNAy64PhlGpB0LG+ZgMCpEcVQypND1eTHJ9KVW/M=;
        b=RdgNNgRcHb7BWgPxWESjClMES07FjXS9nz8e36Fg87TltdUn7OxBhprWEGRxgv5QcO
         JSeiMiQL1x0dHQakU8Ep1CGmVLqAdYDK6ZU68s3X1JDsHex6VxiCum+jIvQsszZmNx/O
         2h164ei9ayxKTUwS2+UQjNIcb4yznfakFYnupdL8uCeJCnVdpRkCTByJCPRv5yqG4Wjp
         17+GWoHmEpIJW+G+19D0jQjghPxRVFGvy8RdRfskKfqdPp4jeRy0jMT0I6ybbqS6LhhE
         DKKY20eZgwbQK38+szExOfUDBrg+/1BsFtDfowfp4QEHqX1Zr7Dwt2I/JlcDZIk2ANrq
         Wdrg==
X-Gm-Message-State: AOPr4FXCSUyWkgvZgrYwJu+keRpHvhGQ/QGUEeW39ps3mfNR9oDCIPFaPx/yQayaNohmFQ==
X-Received: by 10.28.105.67 with SMTP id e64mr8294592wmc.80.1461524297024;
        Sun, 24 Apr 2016 11:58:17 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BA7B8.dip0.t-ipconnect.de. [80.139.167.184])
        by smtp.gmail.com with ESMTPSA id d79sm14948541wmi.23.2016.04.24.11.58.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 11:58:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292426>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 78e433b..4acf617 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -22,8 +22,8 @@ addons:
 env:
   global:
     - DEVELOPER=1
-    - P4_VERSION="15.2"
-    - GIT_LFS_VERSION="1.1.0"
+    - P4_VERSION="16.1"
+    - GIT_LFS_VERSION="1.2.0"
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     - GIT_TEST_OPTS="--verbose --tee"
-- 
2.5.1
