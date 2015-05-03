From: Alangi Derick <alangiderick@gmail.com>
Subject: [Patch] Fixed translation error in advice.c
Date: Sun, 03 May 2015 20:49:05 +0100
Message-ID: <55467bb2.toB888geiDsR9Zn7%alangiderick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 21:50:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yozu7-0000BL-Ft
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 21:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbbECTuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 15:50:05 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37567 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbECTuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 15:50:00 -0400
Received: by widdi4 with SMTP id di4so91650900wid.0
        for <git@vger.kernel.org>; Sun, 03 May 2015 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=e3s6g7GetbwvKoakmtJqx4i1NDd0oKKbTYoeiKkQp1g=;
        b=u2o7bYx6oLOdJwwhEW9T4H238qwmBqhsWyRiXOdXx9WhYosUhG+phIN0Q6KyTzGX/c
         RqSL/SWiY3E3obRNQUwjJKfd6PM7t1NbMRMO4f4XSegVqnNQLmnwQuas8sYigQsbu2cI
         4mG3kUPXKSFZrF52PAxvaWJADFWslIpEK76t4ERJd6SEWHTmKxKcP2qHFdz/m96mQUHy
         IBhFwLdr4hGLxUBwHoeMV4p6R6N2kUKOVM7HbdDu4PG0sADNkSqNJu8x8HwCSZtIt5yg
         cMcY8coo0X2QKiHEvAhRcffA99rERVRdciZtiNYwxe0x2TjLMLYTEbylO8KgkvxWyga8
         4KEA==
X-Received: by 10.180.82.133 with SMTP id i5mr13911315wiy.23.1430682598865;
        Sun, 03 May 2015 12:49:58 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id ao4sm17335647wjc.14.2015.05.03.12.49.57
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2015 12:49:58 -0700 (PDT)
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268287>

>From d0928311adf2c6ee03b3c2a2b451db704bce6d6b Mon Sep 17 00:00:00 2001
From: Alangi Derick <alangiderick@gmail.com>
Date: Sun, 3 May 2015 19:30:13 +0100
Subject: [PATCH] Fixed a translation error(die(_()) function)

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 advice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index 575bec2..a8b2909 100644
--- a/advice.c
+++ b/advice.c
@@ -93,7 +93,7 @@ int error_resolve_conflict(const char *me)
 void NORETURN die_resolve_conflict(const char *me)
 {
 	error_resolve_conflict(me);
-	die("Exiting because of an unresolved conflict.");
+	die(_("Exiting because of an unresolved conflict."));
 }
 
 void detach_advice(const char *new_name)
-- 
2.4.0
