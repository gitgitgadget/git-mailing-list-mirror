From: larsxschneider@gmail.com
Subject: [PATCH v1 1/2] travis-ci: update Git-LFS and P4 to the latest version
Date: Tue, 19 Apr 2016 22:08:49 +0200
Message-ID: <1461096530-82448-2-git-send-email-larsxschneider@gmail.com>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 22:09:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asbxH-0005MG-6e
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 22:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbcDSUI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 16:08:56 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33733 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbcDSUIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 16:08:55 -0400
Received: by mail-wm0-f42.google.com with SMTP id 127so7204675wmz.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 13:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ITctNAy64PhlGpB0LG+ZgMCpEcVQypND1eTHJ9KVW/M=;
        b=Y5F7IJ0FdB4Jkufcq2GTqjPt7TVv/0A4wlgn8ql9OiHMe4oJTUDJHFOFIqMmo+cerY
         r15ebMbV9i0sfxx1IwiyG5p1kmooVmdf7S0XYWDbXAhjPSLtW3Z1Yhf7I6YHZ/AC2efL
         qZtavTw4/dSG2VnxAUxMnmnhHeYvxJSW59LBewu5ATEn/0KX2bKLRSJyOJsGcOIF1feV
         ulYYOSpgUzUx01Go4CNyw5DreCtHm3I87CFdHTYOEaATyjW14fvkyxfrLxm5VwZ6tcpc
         0wLdFZmBEhZurwTpSs4epDqo9lkTn3/8lJsjbunoDoS4uKhGp3HZCsGckl+UxnS+3S/t
         YzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ITctNAy64PhlGpB0LG+ZgMCpEcVQypND1eTHJ9KVW/M=;
        b=H5NZtqDLT3gXvLoCAGkZ6q6URZAlLeZDqekm26LNjgIvGBdZoauXYL1h0NXkqJVJSL
         X8HDgkoJmHVahYb7t/CxJEu2i1rOmvJE+ECAIjHLkV3cP6Z+HWUAwTEnbBuslkj/74h2
         1zUjjUljwJ6nd5L8XaAy7JRicofkGc8ToRK9/8rh7Uz5izygscqBaAgPeMZuw72fxw96
         ppS3ettJ2htLmFdD5HaKlEP+VQSAjfBvoSkmMl6NaIOr+8+eWgGGxcFP51lzYa14OInz
         /LgM1yxqxv8qDP5hFMekgQAxHjCNBY2FLslj9mETV6mDKvjEkFdT8KtM//6qt+WlovZy
         XXnA==
X-Gm-Message-State: AOPr4FVxvtvEKNmkd01tTsvWyC2cSGDWwJkjYO62D9ISisxgLJ38GFoaemrQX/dgA6NT0w==
X-Received: by 10.194.96.10 with SMTP id do10mr5609169wjb.113.1461096533860;
        Tue, 19 Apr 2016 13:08:53 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAC17.dip0.t-ipconnect.de. [80.139.172.23])
        by smtp.gmail.com with ESMTPSA id 188sm5999993wmk.6.2016.04.19.13.08.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 13:08:53 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291919>

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
