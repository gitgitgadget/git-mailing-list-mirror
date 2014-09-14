From: Matthias Ruester <matthias.ruester@gmail.com>
Subject: [PATCH] rerere.h: mark string for translation
Date: Mon, 15 Sep 2014 00:40:53 +0200
Message-ID: <1410734453-31621-1-git-send-email-matthias.ruester@gmail.com>
Cc: Matthias Ruester <matthias.ruester@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 00:41:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTITj-0007Lb-9J
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 00:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbaINWlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 18:41:03 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:62007 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbaINWlB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 18:41:01 -0400
Received: by mail-la0-f47.google.com with SMTP id mc6so3570544lab.6
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0qQQRTZhaLF86q2YKgtbG7g6KnIh5n7mGt2miF2IV18=;
        b=bBYVtxnI8kcYFevJ70GR+LbGsEW/Y0InbgDpyMmtDDUJdZXuqSY8F9+ENZAfVRYg/5
         JSkE3MtdvotuzqygjIHKsz6xe8/V7cBeWUzepW8V6k1RPSop3BWNrL27hTNiT1RGgona
         /EwK1Nb7nqUAJnMA3pzUaWiMYPWZ9kIqHUj7a2qrmlFM4zBF8RCu1Mav5MOZYRUvXoab
         SvhlW9b11clEiOwoyo6+9mGFglOG7Ietyn3cSD5vlXqjOWDxJ94k/WzxfPUz+Ji5YF/6
         2nzcbuQdUXzACkSzZQcvd3aOECzbmSMHifVwl2bUOpUgsbYydfvAxHLFuLOVKacv9B/v
         zGGA==
X-Received: by 10.152.88.97 with SMTP id bf1mr23980522lab.58.1410734460033;
        Sun, 14 Sep 2014 15:41:00 -0700 (PDT)
Received: from localhost.localdomain ([193.25.42.141])
        by mx.google.com with ESMTPSA id ai1sm3657621lbd.12.2014.09.14.15.40.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Sep 2014 15:40:59 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.240.g37ca4a2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257032>

Signed-off-by: Matthias Ruester <matthias.ruester@gmail.com>
---
 rerere.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rerere.h b/rerere.h
index 4aa06c9..2956c2e 100644
--- a/rerere.h
+++ b/rerere.h
@@ -24,6 +24,6 @@ extern void rerere_clear(struct string_list *);
 extern void rerere_gc(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
-	"update the index with reused conflict resolution if possible")
+	N_("update the index with reused conflict resolution if possible"))
 
 #endif
-- 
2.1.0.240.g37ca4a2.dirty
