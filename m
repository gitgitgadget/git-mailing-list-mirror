From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/10] transport-helper: trivial style fix
Date: Sat, 28 Sep 2013 16:51:37 -0500
Message-ID: <1380405106-29430-2-git-send-email-felipe.contreras@gmail.com>
References: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:57:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2WD-00028E-Ks
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab3I1V5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:57:34 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:41916 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab3I1V5b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:57:31 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so4145741obc.36
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rrZ5vDDUzQ1cYKB2oshXt44pOtHuHOKDtkFUBpgbmbw=;
        b=Mf34HW9xjd7RN0ZaBk8sYE1hb9rFryv6JHkuCgjST/4Hdo5qurbePFSI2+/bZ+ywoc
         bPeQ7zVdOqS2VCxS6kDWk5NO3Muepge9LbkfStznN/gMZLbh3StXmPN3+2ieMYzU1+us
         vo+8Q09MhxrhXhsdnFIMxXlKUVuNkOJngI70P2anepC+QDxNUbZWPVrii73cPowCazM3
         th3L8N6ofBCSIpuddSC/NR4k18Ly97pCxDlNLnhwNdu+2P3P3YKwXXnOnEpWb/VmOl3Z
         hFe30SH7nzC3/fpo7/ee/frlcr7loUxvKcQ+2VzmFdmIbL0kuVW+EbUW2NTalXQBqFcK
         ofkg==
X-Received: by 10.182.114.231 with SMTP id jj7mr12363279obb.33.1380405451056;
        Sat, 28 Sep 2013 14:57:31 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm19411902obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:57:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235511>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/transport-helper.c b/transport-helper.c
index b32e2d6..673b7c2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -269,6 +269,7 @@ static const char *unsupported_options[] = {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP
 	};
+
 static const char *boolean_options[] = {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP,
-- 
1.8.4-fc
