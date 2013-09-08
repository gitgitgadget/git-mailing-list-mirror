From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] diffcore-break: fix typo in comment
Date: Sun,  8 Sep 2013 11:48:42 +0530
Message-ID: <1378621122-1083-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 08 08:24:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIYQU-0003bF-Gr
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 08:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab3IHGYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 02:24:45 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:65148 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3IHGYo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 02:24:44 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so4973451pad.5
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=OlQLTRrJReTTl52wpu/z8jD0zohKdS+3edKqqaHGUxY=;
        b=ffpiUR0KGL1Nap5lzl470Kc0PlIQgX/FA1BndjfLGtw5DW/EpsI53L108Kwvowjgg8
         ir7XRBnKokXfnS7sUUKmZ6k8OK82+h+S859LnpGdhqUWoD/Jg1bxcdiQ254Jy9jHUQTO
         WFX3AurD1fBge3PpY+p/pRBfq4IaUD841OyFYPuhV7QAx608kLZEFusn1dV7VgRIO+C/
         WcbX9AGOm8xQ5l6h9r7mMAHFCq1yAgv5OGd5fGI4WW7Y6bgOCHogkHPD9080bshx6kDZ
         11PqepidGYK+Ztrd1yZw1QcgFjKf1/rbEyTiFn342ErxRjnIvDmmMOWS5fACrpUugmbM
         6XKA==
X-Received: by 10.66.179.143 with SMTP id dg15mr13272644pac.52.1378621484226;
        Sat, 07 Sep 2013 23:24:44 -0700 (PDT)
Received: from localhost.localdomain ([122.164.84.79])
        by mx.google.com with ESMTPSA id yk1sm9028101pac.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 23:24:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.100.gd1e2c27.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234191>

The parameter is called break_score, not minimum_edit.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 diffcore-break.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 1d9e530..34dd1e0 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -37,7 +37,7 @@ static int should_break(struct diff_filespec *src,
 	 * back together.  The break operation itself happens
 	 * according to the former definition.
 	 *
-	 * The minimum_edit parameter tells us when to break (the
+	 * The break_score parameter tells us when to break (the
 	 * amount of "edit" required for us to consider breaking the
 	 * pair).  We leave the amount of deletion in *merge_score_p
 	 * when we return.
-- 
1.8.4.100.gde18f6d.dirty
