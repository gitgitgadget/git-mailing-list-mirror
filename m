From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] show-ref: place angle brackets around variable in usage string
Date: Wed, 26 Aug 2015 22:26:52 -0600
Message-ID: <1440649612-3667-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 06:27:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUomF-0002db-5W
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 06:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbbH0E06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 00:26:58 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34056 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbbH0E06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 00:26:58 -0400
Received: by pabzx8 with SMTP id zx8so11050245pab.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 21:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Fm0hw5EV/0F4CWXE1MJZibMWuea4SAwyaYDHEmmaZb4=;
        b=nhKBbCxxjskzlACFSL4Ui05djiG+zzAo7dGQgMaudIvGrYwWQBcj9XuOmX9c2Dq8yi
         VyEwSbqAx/ZB13gd4Oq8sX5qO+QU6sPo4AoHRPulwyBdz7cfWa0JBRuU9g2XvirKlG4p
         cS2suAA1OGCOpI2F3/2IBhTXrPiTPuJpPMZioIcrCunhXcAnXHhYipqwXN/y6PKPkuS4
         1bA1eXpvyZxhu0Yib8lfqPyf9z5Yhjpi8lclUMQ1y4RdYqqYU54anMG/agyRa2OHLN8n
         mIbiyGwpTCUccsI8lzMmVYs4PZ7zrfvzyT9QTeSRRAsGx1vR4yY9a0JIDRe+vxhiNoPO
         0T1w==
X-Received: by 10.66.174.174 with SMTP id bt14mr3330051pac.109.1440649617974;
        Wed, 26 Aug 2015 21:26:57 -0700 (PDT)
Received: from alex-wolverine.lan ([2601:681:4d04:75d8:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id c2sm690647pds.56.2015.08.26.21.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Aug 2015 21:26:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276659>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/show-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index dfbc314..d9c1633 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -8,7 +8,7 @@
 
 static const char * const show_ref_usage[] = {
 	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [<pattern>...]"),
-	N_("git show-ref --exclude-existing[=pattern] < ref-list"),
+	N_("git show-ref --exclude-existing[=pattern] < <ref-list>"),
 	NULL
 };
 
-- 
2.5.0
