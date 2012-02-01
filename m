From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: git-commit whence_s "merge/cherry-pick" message
Date: Thu,  2 Feb 2012 01:20:30 +0800
Message-ID: <1328116830-61290-1-git-send-email-worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>, avarab@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 01 18:21:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsdrs-0001HX-0L
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 18:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab2BARVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 12:21:06 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36276 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab2BARVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 12:21:05 -0500
Received: by ghrr11 with SMTP id r11so688443ghr.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 09:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PMtT0kZQHHUFqXQ9e5OpCOsJ5ytnfSJVQ1yhkVjV4tY=;
        b=ClQwT/5GMz1Zw7HwCYUV0RwCWXAHlMpSxyA1jWi5242XaicoInqVPs9q4uyxrWwf07
         SHMtgU4jBaiYQAS/CwrEVJFBjQA2XOTfhylH3hz1MKBI/POghq0pnEKlnfmh6ar/Gl00
         HMKVRiXUqq6QtYqCm4N7HXXROGyKwTWg6L3JY=
Received: by 10.50.51.168 with SMTP id l8mr8179724igo.5.1328116864171;
        Wed, 01 Feb 2012 09:21:04 -0800 (PST)
Received: from localhost.foo.bar ([123.116.240.29])
        by mx.google.com with ESMTPS id r18sm27553124ibh.4.2012.02.01.09.20.47
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 09:21:02 -0800 (PST)
X-Mailer: git-send-email 1.7.9.3.g1fbd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189523>

Mark the "merge/cherry-pick" messages in whence_s for translation.
These messages returned from whence_s function are used as argument
to build other messages.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index eba137..663e1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -202,10 +202,10 @@ static const char *whence_s(void)
 	case FROM_COMMIT:
 		break;
 	case FROM_MERGE:
-		s = "merge";
+		s = _("merge");
 		break;
 	case FROM_CHERRY_PICK:
-		s = "cherry-pick";
+		s = _("cherry-pick");
 		break;
 	}
 
-- 
1.7.9.3.g1fbd7
