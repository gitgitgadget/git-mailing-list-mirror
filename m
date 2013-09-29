From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] Makefile: suppress false positive warnings of empty format string.
Date: Sun, 29 Sep 2013 14:08:54 +0200
Message-ID: <1380456534-7582-1-git-send-email-stefanbeller@googlemail.com>
References: <7vfvvkpt2k.fsf@alter.siamese.dyndns.org>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Sun Sep 29 14:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQFoK-0002Yf-KR
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 14:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab3I2MJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 08:09:09 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:59056 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab3I2MJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 08:09:08 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so2095295eak.4
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vljup5A0f/dhowJfsCLQYJnhF/kDNWLptvv20S1+oW8=;
        b=Svev/t3zg5R/VvYRXKmaYH0mF2PJzuqUt1p3GlvhVWlb8ZJBiikJYZcf5BTod0QbkO
         QQ7/arJzn0jNWXEz2d6MT2g340rW6l5PtISWI1JA8UqGY1OLsh+4NsAj0oBZLJu51UI+
         /VKlrJZyBYBWGOkq13Ckne7cB5g1aUOiddKF81N/PY6v/hMyaJlFOW6E+cYCKy+6gaje
         7Q0xvA6doRfUaDDE8w9d2mpXPtK7jj5LIO1ih56kPYI/nDRMvGOVC5N1cj5wWuYj6DU0
         +JlFbrTvOTTBOedJflWEdKb6O7X6Osn49LH7dBZ09sPNe8rWPF5euC/r4Umo7X5lnlE3
         ufew==
X-Received: by 10.14.172.133 with SMTP id t5mr27649997eel.35.1380456546800;
        Sun, 29 Sep 2013 05:09:06 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id z12sm38804677eev.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 05:09:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.474.g128a96c
In-Reply-To: <7vfvvkpt2k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235598>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index de3d72c..60afa51 100644
--- a/Makefile
+++ b/Makefile
@@ -349,7 +349,7 @@ GIT-VERSION-FILE: FORCE
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O2 -Wall -Wno-format-zero-length
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-- 
1.8.4.474.g128a96c
