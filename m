From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 04/16] git-merge-one-file: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:42 -0800
Message-ID: <1361665254-42866-5-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:21:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLV-0000io-Ne
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759344Ab3BXAVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:12 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:41317 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759111Ab3BXAVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:09 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so935368dak.19
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Ri/lDVXICql6LBBYpUzfBKAfrdzuFzM4lzWhwQEdKtU=;
        b=xXIsFcm+oCB8ItHd1IkTBmegNKStcshFiTpwPnzBIcWch2wgP/IXzH+ZsFbtMEYAkk
         PmWn49cmKjpPYBLwUof8ssYGupesPmKDmNVVELRolMg+hQ25FO4izUVSpTkCs/HbrS2d
         mmaGqkAwXDMrS3zk9SYA/3BfXiRnIvbhA7+4yw/LbcCaQaQHteoYK4ArdPhyybKFyjPA
         VFj4mKsvNiHKMsbn1I2usr9AUhjgPHqFTmOnPwnjmXDAZ7YfJtmXE4flle2H6gDAcfZk
         bp/B71jH528NdRvvh62Q7PtodPGLbXpLaFKvNC8odIfkUmTm5N2dVTRZJ9hYrr26jTxj
         BZgw==
X-Received: by 10.68.83.68 with SMTP id o4mr10624496pby.42.1361665269083;
        Sat, 23 Feb 2013 16:21:09 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.07
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:08 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216938>

Use a lowercase "usage:" string for consistency with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-merge-one-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index f612cb8..3373c04 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -18,7 +18,7 @@
 
 USAGE='<orig blob> <our blob> <their blob> <path>'
 USAGE="$USAGE <orig mode> <our mode> <their mode>"
-LONG_USAGE="Usage: git merge-one-file $USAGE
+LONG_USAGE="usage: git merge-one-file $USAGE
 
 Blob ids and modes should be empty for missing files."
 
-- 
1.8.2.rc0.247.g811e0c0
