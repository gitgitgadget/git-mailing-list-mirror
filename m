From: larsxschneider@gmail.com
Subject: [PATCH v2 1/2] travis-ci: update Git-LFS and P4 to the latest version
Date: Wed, 20 Apr 2016 10:10:08 +0200
Message-ID: <1461139809-6573-2-git-send-email-larsxschneider@gmail.com>
References: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sschuberth@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 10:10:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asnDh-0005m9-MO
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 10:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbcDTIK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 04:10:26 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36861 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbcDTIKP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 04:10:15 -0400
Received: by mail-wm0-f51.google.com with SMTP id v188so192404894wme.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 01:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ITctNAy64PhlGpB0LG+ZgMCpEcVQypND1eTHJ9KVW/M=;
        b=px0T4yhrO4chWA11+AzWUyAHp84iMMjF9X7C8g39S/SFBFxCvKKDP6FOx//yMN0/8y
         ni1NYVEMccLD/lG0Fy1DVs3X2HJd73B4gY6PJ6JP05ZJVdJuENjt6gnJPbSvXlImZs4B
         XfME93nyPLqi+J8fsmxtegP4RjaEuNTayj50qOybSHSxc/WzstUxpSu+jrDTXTWxSmrv
         lmjVlzuNqFf/zCRjmIn93Ed/v+3rNHk94LmkuJJF41Wvv9p8gbdwUrVtNoflREbqBPXH
         qf1qv6VnQ7uNBb42WfcpqdNZ5DuLSRv5eFawKWE6E3DRXdJt+lK3t/+hA4AXF5FQM9U0
         MubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ITctNAy64PhlGpB0LG+ZgMCpEcVQypND1eTHJ9KVW/M=;
        b=lDivK64/TU9aYyltih0AFbS7wT87SAb4QGYDln7YDpq6sOrNlZo/koJvwYqoLgrciV
         +F13Y/qH/TtODYdDVp0xpR9MXNCdBhdEzLEcinQSLKmqZh1OpeaMdib00cFEXSWrYuMe
         lGB9JSSOGkQw6UKZcug3bBH83qK+XGKEqx4qnPgk31wD1DSUJCuOOp/L40thEHDri+Cb
         QlJV/2Fz8WuEPXMsNdRE5vWBTY0Hy5JLuWLyQqQCK0rn/eSV/WdclR10kKSrIzlFK6aj
         czZncthsaTYld8VgNqE/sRvCdVzz8yEIeJ2pLKA2zxN5ACzpZDPZzojJeC5/ivf+Jz9A
         ywUQ==
X-Gm-Message-State: AOPr4FWyrE9ssG/5BtB9gmloaXLiQy3aoBs2CPJKPYcIwK0e3pj2/RV649+P+TGzbWn3MQ==
X-Received: by 10.194.74.231 with SMTP id x7mr7087625wjv.60.1461139814268;
        Wed, 20 Apr 2016 01:10:14 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAD5D.dip0.t-ipconnect.de. [80.139.173.93])
        by smtp.gmail.com with ESMTPSA id r8sm1502008wme.14.2016.04.20.01.10.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 01:10:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291992>

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
