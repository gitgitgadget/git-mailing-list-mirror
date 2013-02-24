From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 15/16] templates/hooks--update.sample: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:23 -0800
Message-ID: <1361667024-49776-16-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
 <1361667024-49776-5-git-send-email-davvid@gmail.com>
 <1361667024-49776-6-git-send-email-davvid@gmail.com>
 <1361667024-49776-7-git-send-email-davvid@gmail.com>
 <1361667024-49776-8-git-send-email-davvid@gmail.com>
 <1361667024-49776-9-git-send-email-davvid@gmail.com>
 <1361667024-49776-10-git-send-email-davvid@gmail.com>
 <1361667024-49776-11-git-send-email-davvid@gmail.com>
 <1361667024-49776-12-git-send-email-davvid@gmail.com>
 <1361667024-49776-13-git-send-email-davvid@gmail.com>
 <1361667024-49776-14-git-send-email-davvid@gmail.com>
 <1361667024-49776-15-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Pog-0000c0-64
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135Ab3BXAvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:51:16 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:62969 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759444Ab3BXAvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:51:12 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so940496dak.30
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=JHNRqG4Xd/a8FAkoDZRHD2DSl5NgaFI6Tl920UHxpQo=;
        b=OhFDBNTpOIeASTbRWkE2XKkkpuZDF8O+2zqwCgIvh6u5UB55/uERowwg/VIXrJL4R4
         hkDGwa4oXofP+4PsaFxPkdZIkSYg/zhF8TA6felUUXLSoWYGllGcuVfow2VP7aTudbHM
         WiPpbyS6nk7gRbGH7SyJ1UbfC7qXnR2EWdTRpdHDWuPK7VA0O8xOaeD29VNqyuf7WssE
         fy/H3h6jPYicHNvshwXXX6d65yD19I5BF/OeGaPUN/rvGliPJEiyRmHwXihq3i3l7XMl
         agGWanv8Ed2tsvCPeyOqgv1iukzLiC1cRKf6DeoGi+Mev/pMv7rUhpbIlJaY68lSVRYU
         7xuA==
X-Received: by 10.68.143.74 with SMTP id sc10mr10617184pbb.110.1361667072504;
        Sat, 23 Feb 2013 16:51:12 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.51.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:51:11 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-15-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216970>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 templates/hooks--update.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index 71ab04e..d847583 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -38,7 +38,7 @@ if [ -z "$GIT_DIR" ]; then
 fi
 
 if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
-	echo "Usage: $0 <ref> <oldrev> <newrev>" >&2
+	echo "usage: $0 <ref> <oldrev> <newrev>" >&2
 	exit 1
 fi
 
-- 
1.8.2.rc0.263.g20d9441
