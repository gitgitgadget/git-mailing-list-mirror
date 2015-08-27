From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] pack-objects: place angle brackets around variables in usage strings
Date: Wed, 26 Aug 2015 22:26:36 -0600
Message-ID: <1440649596-3598-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 06:26:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUolz-0002R1-G4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 06:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbbH0E0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 00:26:43 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33769 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbbH0E0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 00:26:42 -0400
Received: by pacti10 with SMTP id ti10so11225797pac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 21:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hAPENfBQOUBS7ni8jzZ/xEScJrWcUbxVEtf6waBB9/0=;
        b=vosmhWAOQIKLFYUFlzY0AIVQmWq8RO0KvqycRCYoU37FskMpQodGvmnyGVQCmhVqY6
         BpSymUo0VKR1OGqZF9jtxMczbpCa6fGElK2+hUFHPjknlIjvSWPKYI2V3WBDDtIC3bxM
         lvCFl0T3sXlU2QQARy6JGno2C0Zzq7TocRKLM0Zsit5O9eKraqhlzDn2BAmHzWxjqCfB
         bPA2nH3T0t/YRcm7luvxBBnhoXlXJEPoyxt/sYdyg8YqZwHR14M17i2O6YHVOsEIL135
         WX6tR1ucYhM7/8NGMknvGE6R86qPUrPGX1qE6j3zjMno6qWjBUjvEJSMExFJsTeB+Pab
         yS6w==
X-Received: by 10.68.206.74 with SMTP id lm10mr3327314pbc.117.1440649602503;
        Wed, 26 Aug 2015 21:26:42 -0700 (PDT)
Received: from alex-wolverine.lan ([2601:681:4d04:75d8:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id fm5sm686953pbb.60.2015.08.26.21.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Aug 2015 21:26:41 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276658>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 62cc16d..1c63f8f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -25,8 +25,8 @@
 #include "argv-array.h"
 
 static const char *pack_usage[] = {
-	N_("git pack-objects --stdout [options...] [< ref-list | < object-list]"),
-	N_("git pack-objects [options...] base-name [< ref-list | < object-list]"),
+	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects [<options>...] <base-name> [< <ref-list> | < <object-list>]"),
 	NULL
 };
 
-- 
2.5.0
