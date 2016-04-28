From: larsxschneider@gmail.com
Subject: [PATCH v4 1/3] travis-ci: update Git-LFS and P4 to the latest version
Date: Thu, 28 Apr 2016 08:26:31 +0200
Message-ID: <1461824793-43235-2-git-send-email-larsxschneider@gmail.com>
References: <1461824793-43235-1-git-send-email-larsxschneider@gmail.com>
Cc: sschuberth@gmail.com, gitster@pobox.com, ben.woosley@gmail.com,
	sunshine@sunshineco.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 08:26:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avfPR-0006RM-1S
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 08:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbcD1G0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 02:26:39 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37130 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbcD1G0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 02:26:38 -0400
Received: by mail-wm0-f52.google.com with SMTP id a17so47431437wme.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 23:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ITctNAy64PhlGpB0LG+ZgMCpEcVQypND1eTHJ9KVW/M=;
        b=Lki9aDpu/++vy62Us0HlOXbsUpke9X8EW+meIdffa4lUED9CAJbmtZz0iIof5EK4lg
         sxxeJRVCtdw9sH941UaaD882I4pvltw9deM0bP0gWv/z2rjyqf9P1aTgx2SG7siwNzln
         NKHJZoDLM4hexreETGVXCrX4ZqK89ayDwzOKFQCExb3cqxrPKLNWwZJ+Qt8SUPndvmCX
         HY7Jvq5OgqLviwtI33h4nC1jK3h8FvAVGt1qIoyz0HxRpqE3BtCC7WMVloBbgr2CQ3QT
         ljTaITQVCXvWmdjtKOqr0syXlpqEpGzE15z+5JafwLLnU85Mrzr3RGiuoXdRiIHbaKIP
         ODKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ITctNAy64PhlGpB0LG+ZgMCpEcVQypND1eTHJ9KVW/M=;
        b=Lxy3w5NUNLbt0kboH2WSdS+ygYEnGqtxDeHIHNfXccaU/OQT+h6olI7mTeV/tzG2JL
         4JK8EExGgFxOO1ypfBfOu/YGHI0Bj5C4XfhaB5DQGTI0ed5pjqtIkcRBjN2Ea82/3JQy
         KbS8AzTf5GEtaya/9JQ/W5JIpzeX58LPTAHWNdTyWjzYEd8j+Uope6WXO8LciBX6ieto
         YUKjMqHTHptmNVg2PiiE+u9c+MYoyObSMfpWPyzvp5ovBSpZbMeMQyBxGml/IjTwY+if
         gV2dJqYg+uBtjodxx4y9nDL8eFWx6P/g59P6WHKsN/sefe4PqTfRbS24TNC8a6gDqCvF
         9AdQ==
X-Gm-Message-State: AOPr4FWJ01pt1b0mfUi6a6TYYEZREQTuRE/PneQntAkYBA0i3+R6G3SxgkQNJVTr3OQeTw==
X-Received: by 10.194.81.135 with SMTP id a7mr13195032wjy.170.1461824796840;
        Wed, 27 Apr 2016 23:26:36 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAD07.dip0.t-ipconnect.de. [80.139.173.7])
        by smtp.gmail.com with ESMTPSA id y91sm12225405wmh.10.2016.04.27.23.26.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 23:26:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1461824793-43235-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292847>

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
