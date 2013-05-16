From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] color: set color.ui to auto by default
Date: Thu, 16 May 2013 18:34:28 +0530
Message-ID: <1368709468-18610-1-git-send-email-artagnon@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 15:03:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucxph-00006W-KU
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 15:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843Ab3EPNCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 09:02:51 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:54241 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab3EPNCu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 09:02:50 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so2505291pad.30
        for <git@vger.kernel.org>; Thu, 16 May 2013 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=EtQFs24TLi5YckA94X4NXBW7vsDFGO31u///gEoEVis=;
        b=EMkUlSrOBouFvTSUPiCmszVMHIsFmKAYIFRjqYVJpp0xsJPKS4TJ4M6vng7KJjH8zK
         iZKSR+zBAT4lK9CYSrEZMWJN97p3L07apO2XiDSeGG/OHRiYBuLSkqeqGWLek+p39M+p
         sGhQfSuQnmKBXCf1QJ6XW2VQpZd9Y5Dui5OIgMvKeiTYvdT31+/elj+y+2uJ403lEOC2
         Ljl0GdVk0fParcSGJ9inV96wITUSdqmsEBhRtjSiWKmUxnUrBavyDTTNJElhvYCMO9/V
         K1mumDHSzf3B6yZio95aeQQutH+lYdUmUI46geLldtUKXeONM/OeyI15yQB/S5HbHzjw
         KAPg==
X-Received: by 10.68.211.73 with SMTP id na9mr43554233pbc.90.1368709369910;
        Thu, 16 May 2013 06:02:49 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id gi2sm6759398pbb.2.2013.05.16.06.02.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 16 May 2013 06:02:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.10.g0c2b1cf.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224561>

This is a good default.  Users who don't want color can look for "color"
in the git-config(1), and turn it off.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 color.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/color.c b/color.c
index e8e2681..f672885 100644
--- a/color.c
+++ b/color.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "color.h"
 
-static int git_use_color_default = 0;
+static int git_use_color_default = GIT_COLOR_AUTO;
 int color_stdout_is_tty = -1;
 
 /*
-- 
1.8.3.rc2.10.g0c2b1cf.dirty
