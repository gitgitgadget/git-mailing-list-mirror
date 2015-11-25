From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2] Documentation/git-update-index: add missing opts to synopsys
Date: Wed, 25 Nov 2015 07:53:12 +0100
Message-ID: <1448434392-21983-1-git-send-email-chriscool@tuxfamily.org>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 07:53:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1TxL-000610-Ey
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 07:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbbKYGx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 01:53:29 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35965 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbbKYGx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 01:53:28 -0500
Received: by wmww144 with SMTP id w144so167032166wmw.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 22:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4f1EdEJ41WCGwpDLhgzs5BjVv/mhKe9Ml6Vzb3Q4q50=;
        b=fJrFXL+Ck6stOxBF58lc7me677T1STwcx0VeW7qGu9rwLgR5IIkN/W7a7WCZKBJFl/
         7O2KNf9/Cvu0mHy6CfuM8p+svTNElO8frbg/TL1ShJ3cM3v96x4ET2HplR+s6m1TLG3D
         vjhDxxsgYB/gCzIj3Bf8NFQniTDKDjHfBZ+ITG463wDLI1W4pg1Ftx6E73+va8TVJO1m
         H/tYGQzVvmehFRIRTnczuqeNDcQmNFwb5Z5jr1jtCjGpOBrPHmAPVBspv/yGVZm0S2mq
         ZdOT8LJyunUe7lnYZuzYz29CRtBjWyszmUbnaTioFUluOoOvjGRhOuvNlHPJD4yb6Ujc
         LJ3w==
X-Received: by 10.28.195.138 with SMTP id t132mr2377121wmf.86.1448434407287;
        Tue, 24 Nov 2015 22:53:27 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id c13sm1900679wmd.14.2015.11.24.22.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 22:53:26 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.380.g494b52d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281680>

Untracked cache and split index related options should appear
in the 'SYNOPSIS' section.

These options are already documented in the 'OPTIONS' section.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Soon after sending the first version I realized that the split index
options were not in the synopsys either...

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
