From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] apply: comment grammar fix
Date: Wed,  9 Sep 2015 15:33:18 +0200
Message-ID: <1441805598-29761-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 15:36:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZfXc-0003Dg-TW
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 15:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbbIINd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 09:33:27 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37589 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568AbbIINdX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 09:33:23 -0400
Received: by wicfx3 with SMTP id fx3so22002942wic.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gEASJuyn05w/QAjPjSbmR6BNkgCTcXh4QgBZRpTEXmU=;
        b=I8XQA1QoePtC2jEhPJUrVdP0Qpl9sP4jDIw5AE3Is1YIeeOJhiiTCOzXaBU6DwDQUf
         qSQf20uArL7r67Rtba75SLNZCsfoHxwI/ZSl9kR5kivfXxZv9mL0IGBun2UY2RkKCtt1
         n4dP10EMAxz4bLYYDigl3JF6B0Aw6L5ocmQqbb+1qVS/JRq+O1/b2TJzv/phJB5l+wOn
         gLQq7jg044qgEKz+/9j1u+5pyG1B7H0DG5ja4y9xQq3LDf5VAFUG4+EqWi/MtNlAm8hm
         Tr7XNVsNksFwXE+gUV9XzYtOOGy52UOy4/hSD7PshzXoX6oB9F4t0H4glij91G+Bq4Eo
         I2eQ==
X-Received: by 10.180.182.107 with SMTP id ed11mr55855391wic.52.1441805601856;
        Wed, 09 Sep 2015 06:33:21 -0700 (PDT)
Received: from localhost ([193.206.223.108])
        by smtp.gmail.com with ESMTPSA id fs2sm3037118wib.12.2015.09.09.06.33.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2015 06:33:21 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc1.170.g51893f9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277555>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 54aba4e..4aa53f7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -785,7 +785,7 @@ static int guess_p_value(const char *nameline)
 }
 
 /*
- * Does the ---/+++ line has the POSIX timestamp after the last HT?
+ * Does the ---/+++ line have the POSIX timestamp after the last HT?
  * GNU diff puts epoch there to signal a creation/deletion event.  Is
  * this such a timestamp?
  */
-- 
2.6.0.rc1.170.g51893f9.dirty
