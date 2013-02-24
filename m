From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 08/16] git-cvsimport: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:46 -0800
Message-ID: <1361665254-42866-9-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
 <1361665254-42866-6-git-send-email-davvid@gmail.com>
 <1361665254-42866-7-git-send-email-davvid@gmail.com>
 <1361665254-42866-8-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLj-0001gI-6N
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759368Ab3BXAVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:25 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:41168 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759111Ab3BXAVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:17 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so928046dae.31
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=OG4Edm6ImSx2gISet9KfnIs3AVlkCJfGatTLLrJxub4=;
        b=dgvmSpIPlBEx8JB6+jmXoPQmqCJOQSCgtEuPqJ05umMo2dJPyL/aLl6w44xMMBmnU6
         YF5IZqWus/JnTmxrKJJIivpKsve7skz6LyuiJ3mIpCkbs1qswZWJXanE6qbB/icDYP/q
         bjiX3tvIioA2dg7Q5QZgvghz6QyqgJ5c3rr91DEHfULeGz/hzAVgKlYkrmiSGha37sLQ
         ika83JimBfNjEE52e+/kHgGQ+7PIRmzPfOKfCCBGtnDyuKVcYWcY9N0Z+Q+sCPPmct9b
         lvdNtty6Vr5DNWvGUr/pH39lQxOyTD6AfmWtdXpxH/BgQgeHxO5OmpMGHCfv4Y4UPFDQ
         DnNA==
X-Received: by 10.66.27.241 with SMTP id w17mr11685647pag.59.1361665276762;
        Sat, 23 Feb 2013 16:21:16 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.14
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:15 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-8-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216944>

Use a lowercase "usage:" string for consistency with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-cvsserver.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 3679074..f1c3f49 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -107,7 +107,7 @@ my $work =
 $log->info("--------------- STARTING -----------------");
 
 my $usage =
-    "Usage: git cvsserver [options] [pserver|server] [<directory> ...]\n".
+    "usage: git cvsserver [options] [pserver|server] [<directory> ...]\n".
     "    --base-path <path>  : Prepend to requested CVSROOT\n".
     "                          Can be read from GIT_CVSSERVER_BASE_PATH\n".
     "    --strict-paths      : Don't allow recursing into subdirectories\n".
-- 
1.8.2.rc0.247.g811e0c0
