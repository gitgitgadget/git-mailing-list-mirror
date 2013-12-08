From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/7] abspath: trivial style fix
Date: Sat,  7 Dec 2013 23:56:56 -0600
Message-ID: <1386482220-18558-4-git-send-email-felipe.contreras@gmail.com>
References: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 07:06:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpXVE-0004iR-2Z
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 07:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab3LHGFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 01:05:49 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:44579 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab3LHGEk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 01:04:40 -0500
Received: by mail-ob0-f180.google.com with SMTP id wo20so2430699obc.25
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 22:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FiLn59rTjCLrwkK/D6GuiKYC5kajkYVpYIdDDbGblHY=;
        b=tQBqNXYcIh7bXmN0CXo5VKBUhQvCT8cO+2QWdkP8505tV8blNsOK7kPaqT0X6/FTNc
         rtYjY3+BPML/rP7uGL9kJcCzKYfwZ/8p7Zh/FQlogefMqFhWKZk2g3hTR5Q+P5IYzRof
         7kwpyRnAki5xzVCYiNu9Fa38HWjTMd4gf1hdw2ilSEM/V4NvCkj0OmRLWlTkTX+IOKFF
         SrIuRpvWETvquj7PVQ9lYP54GFXLTv6TedaUp6sJpGG6PYhnKqh4J2xww/oMSZAedz2b
         ViuJa9TYUu2MAKS4w+z0WogpWLz981RcRFS1er99ix026ki6yqjpLRN+DjAfRi0XCm/V
         MU2A==
X-Received: by 10.60.60.105 with SMTP id g9mr8668262oer.8.1386482679701;
        Sat, 07 Dec 2013 22:04:39 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ee7sm10697906oeb.5.2013.12.07.22.04.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 22:04:38 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1.2.gebd1fb1
In-Reply-To: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239039>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 abspath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/abspath.c b/abspath.c
index e390994..8b3385a 100644
--- a/abspath.c
+++ b/abspath.c
@@ -143,7 +143,7 @@ static const char *real_path_internal(const char *path, int die_on_error)
 error_out:
 	free(last_elem);
 	if (*cwd && chdir(cwd))
-		die_errno ("Could not change back to '%s'", cwd);
+		die_errno("Could not change back to '%s'", cwd);
 
 	return retval;
 }
-- 
1.8.5.1+fc1.2.gebd1fb1
