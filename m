From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 06/16] git-cvsexportcommit: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:44 -0800
Message-ID: <1361665254-42866-7-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
 <1361665254-42866-6-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:21:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLc-0000qC-5E
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759349Ab3BXAVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:15 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33000 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759111Ab3BXAVN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:13 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so1113386pad.21
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=vKoRfUPd0MfIEZUYZdnk0q3jPhMIuCHmPaoNoVtK6Xo=;
        b=ONEphEaGMkf/wmjWlrUtAhrSRJXGZH0msgC4m0+irNkGCnRudrTjntWKuYUAA3ZtxM
         XhjWOgFTzQuXGAMmAwE4RK9roRsINPP3eD33YgCnxSjST197hiX8v2BZmUTD9JuH8dmJ
         Wz0AGlX4Hz8JYouBvSm5KsH9EDRtqStxpY0gFTkGtGLMUm4Ty5B/1CTDo9cOtakVNrut
         C0sIKxRzTjBxhCUonbHz3dXrEu9xXM4akVMGSZVCIdWDjB0nGQb9rtnlC6u/PJPj3OC1
         fUmx/ssQ4o3iQFNl2NClH7y2t9DoU2dlNCwYSGPOGOJY8iCoNprsyCacV6yezFI2qQ9K
         psow==
X-Received: by 10.68.225.138 with SMTP id rk10mr10481845pbc.146.1361665272896;
        Sat, 23 Feb 2013 16:21:12 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.11
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:12 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-6-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216942>

Use a lowercase "usage:" string for consistency with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-cvsexportcommit.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index e6bf252..d13f02d 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -420,7 +420,7 @@ sleep(1);
 
 sub usage {
 	print STDERR <<END;
-Usage: GIT_DIR=/path/to/.git git cvsexportcommit [-h] [-p] [-v] [-c] [-f] [-u] [-k] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
+usage: GIT_DIR=/path/to/.git git cvsexportcommit [-h] [-p] [-v] [-c] [-f] [-u] [-k] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
 END
 	exit(1);
 }
-- 
1.8.2.rc0.247.g811e0c0
