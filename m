From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 16/16] Documentation/user-manual.txt: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:54 -0800
Message-ID: <1361665254-42866-17-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
 <1361665254-42866-6-git-send-email-davvid@gmail.com>
 <1361665254-42866-7-git-send-email-davvid@gmail.com>
 <1361665254-42866-8-git-send-email-davvid@gmail.com>
 <1361665254-42866-9-git-send-email-davvid@gmail.com>
 <1361665254-42866-10-git-send-email-davvid@gmail.com>
 <1361665254-42866-11-git-send-email-davvid@gmail.com>
 <1361665254-42866-12-git-send-email-davvid@gmail.com>
 <1361665254-42866-13-git-send-email-davvid@gmail.com>
 <1361665254-42866-14-git-send-email-davvid@gmail.com>
 <1361665254-42866-15-git-send-email-davvid@gmail.com>
 <1361665254-42866-16-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLx-0002It-Jt
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759380Ab3BXAVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:37 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:44670 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759364Ab3BXAVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:33 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so935036dak.30
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6E247XlddqUOGgJVlyPE3M/G7ncMTp+QvD03kFksTrc=;
        b=MYI9HShIWCoytXp4DJwBA5HVLSp1RmPAcVkLUwR/MA6DbV7kO9V6GT6ObLfMVHnt27
         NcJxp58C6t0eI2sVUbGoHbAtW4MRonau4dq75rj9ZKSUPd9AkV0sGNUp9JPEVdqQGK0+
         aFs7e2H3LJJQTvgByRawLj/F5iXp/o5XwuwiZVczpg39dNAo2fXXcRtTLrC/B+MB4MeX
         5ApS27h0vFHA75CsvrubbKkZcsLj6wgRPWaVHd5ZYAPhddYrGt9E/ukXxLd69Lqtu2an
         jlMcavx1UjtbJguGBj/ncsSdacb7YlB9wGe6xIC0ZvhOHkiSY93maTUUUdUUuCRTxKbn
         7lDA==
X-Received: by 10.68.2.132 with SMTP id 4mr10529459pbu.221.1361665293233;
        Sat, 23 Feb 2013 16:21:33 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.31
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:32 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-16-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216949>

Use a lowercase "usage:" string in the example script
for consistency with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/user-manual.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5f36f81..35a279a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2337,7 +2337,7 @@ origin)
 	fi
 	;;
 *)
-	echo "Usage: $0 origin|test|release" 1>&2
+	echo "usage: $0 origin|test|release" 1>&2
 	exit 1
 	;;
 esac
@@ -2351,7 +2351,7 @@ pname=$0
 
 usage()
 {
-	echo "Usage: $pname branch test|release" 1>&2
+	echo "usage: $pname branch test|release" 1>&2
 	exit 1
 }
 
-- 
1.8.2.rc0.247.g811e0c0
