From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 15/16] templates/hooks--update.sample: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:53 -0800
Message-ID: <1361665254-42866-16-git-send-email-davvid@gmail.com>
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
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PM1-0002nz-Iq
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759382Ab3BXAVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:44 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43416 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759371Ab3BXAVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:31 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so1117069pad.38
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=chmoI4Q+z1gMOOZRY1c2dyZHeEh1V2gkUVI6NTRFoPY=;
        b=FLlpUnLU1qNP81Vb9yZHG8kRJKBc9meUIQmwD1UL+q3SxKAn5pqkr406s8tCQZFEzD
         kv5fgqxbiX2DhLlGytsWdlRb9fb7/Ep25cFfAqfEx+OzjZ2GpZJQHkD/uVoDBhjQPeIg
         5MP/ZXtZ+gQPlVSoOltQWyryrM0w3gXT1Kgi35Qqp4Dryx/mlOH+wI5FGtK1PZJej1vR
         si+CENhD2ElRrWJpEwyFVC0uCTSdOkn71/bidI/+cxI7nm51JX/Nu8GEM/LcidVIW5A0
         ynhn1Tfvt1Ib921rgKTTQytMBi1O/6BD/eRXD72qCVNDw+BenJZzBEAaToiPIsCYNgtL
         Alxg==
X-Received: by 10.66.248.105 with SMTP id yl9mr11733326pac.183.1361665291260;
        Sat, 23 Feb 2013 16:21:31 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:30 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-15-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216952>

Use a lowercase "usage:" string for consistency with Git.

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
1.8.2.rc0.247.g811e0c0
