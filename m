From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 33/33] Document the exit status of guilt push and guilt pop.
Date: Mon, 19 May 2014 00:00:09 +0200
Message-ID: <1400450409-30998-34-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:15:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9MY-0006Mt-8Q
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbaERWPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:15:17 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:40048 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbaERWPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:15:16 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so3452411lab.38
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NgoSwX9jR8V8hu7+oO1FqP32RUyrrilUGhl9LB26l2Q=;
        b=GLhuaW14Lyq92OO/75bRraUNSFY2XmpVRQef4vFA3vS5aVT7DpspFGR+I6kFcVPT4U
         6guSGj5t0iPAJ+bQ4+qglkEEYAlLM7ZyPt1cn0M5sanrAor2/NGOUBvWL6gCiRn47TmU
         X9ypLO2oWfkUiswrwRlQsBWiecJDVNuuzFMuFcivj1VNu9N1wsiiVWkMgYGENsGvqy5I
         nojrxuXgK2O2bJTVpMNcf5VBcGOucyIej6yU7aeaoMFUaoaJ2yEmXQeCOXAHQTVTsnmY
         BpaGVGdtWO0IxcKQ+2UhYwJDwzN+HFEmTd/ZMvaMC3umVSOuYYP3t3oJCk1qP9QLv65A
         X2iA==
X-Gm-Message-State: ALoCoQmaW7pYWvM3xPNha+6dUrmhnYznuh7u+XvaKDzCVP3jkITv9GXAyHDzzhEI0JrJXlp7KVF2
X-Received: by 10.152.87.52 with SMTP id u20mr3318887laz.52.1400451314880;
        Sun, 18 May 2014 15:15:14 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.15.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:15:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249548>

---
 Documentation/guilt-pop.txt  | 3 +++
 Documentation/guilt-push.txt | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/guilt-pop.txt b/Documentation/guilt-pop.txt
index 36fea9e..b0b89cc 100644
--- a/Documentation/guilt-pop.txt
+++ b/Documentation/guilt-pop.txt
@@ -26,6 +26,9 @@ OPTIONS
 
 If no patchname is given, pop the top-most patch.
 
+Exit with a non-zero exit status if requested to pop more patches
+than there are on the stack.
+
 Author
 ------
 Written by Josef "Jeff" Sipek <jeffpc@josefsipek.net>
diff --git a/Documentation/guilt-push.txt b/Documentation/guilt-push.txt
index 6ee86b9..6439f21 100644
--- a/Documentation/guilt-push.txt
+++ b/Documentation/guilt-push.txt
@@ -26,6 +26,9 @@ OPTIONS
 
 If no patchname is given, push the next patch in the series onto the tree.
 
+Exit with a non-zero exit status if requested to push more patches
+than there are in the series.
+
 Author
 ------
 Written by Josef "Jeff" Sipek <jeffpc@josefsipek.net>
-- 
1.8.3.1
