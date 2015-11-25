From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3] Documentation/git-update-index: add missing opts to synopsis
Date: Wed, 25 Nov 2015 08:59:06 +0100
Message-ID: <1448438346-22808-1-git-send-email-chriscool@tuxfamily.org>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 08:59:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Uz3-0004fT-74
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 08:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbbKYH7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 02:59:19 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34731 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbbKYH7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 02:59:18 -0500
Received: by wmvv187 with SMTP id v187so244088051wmv.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 23:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/UML+3YsBT9bL1Pk2YQHmspAabfsg7xFCBAORtLd+Pk=;
        b=UX1qXRP36btxJ9woOtCsaxfMEKnnFtw6YrpQvIqy+97kAbzCtBplSLnC547UEsNp45
         n/if8r6yZo7Gqa8QvX9dEcUYe7+qq6CDNfV//DdsumMg0eHqDbhWjnGp86ZEFeWNJwl5
         q4J1Lv9MZVASljAoMMiM0uia1wbMQHE77bxg9R35wtDQ5a3HQpncAySg51KnayvtMV1M
         2obkwQgZjBML7GgKE6x+FfrUYq31nDIb48dIOvA6Qd6pHd9EC63jHtZJv2ARdKjnAr+3
         rogTd9gT96vajU6K34v2jwDcbjRmvhW0guhG/Gv7pFczVhIs0zEweFkA+BH3DA5R2EnR
         EsEA==
X-Received: by 10.28.14.209 with SMTP id 200mr2857970wmo.103.1448438357762;
        Tue, 24 Nov 2015 23:59:17 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id h189sm2211303wme.1.2015.11.24.23.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 23:59:16 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.380.g494b52d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281685>

Untracked cache and split index related options should appear
in the 'SYNOPSIS' section.

These options are already documented in the 'OPTIONS' section.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
The only change compared to v2 is s/synopsys/synopsis/ thanks to Eric.

 Documentation/git-update-index.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1a296bc..f4e5a85 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -17,6 +17,8 @@ SYNOPSIS
 	     [--[no-]assume-unchanged]
 	     [--[no-]skip-worktree]
 	     [--ignore-submodules]
+	     [--[no-]split-index]
+	     [--[no-|force-]untracked-cache]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
-- 
2.6.3.380.g494b52d
