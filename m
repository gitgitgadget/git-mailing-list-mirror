From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 03/13] remote-helpers: fix failure message
Date: Wed, 28 Nov 2012 23:10:59 +0100
Message-ID: <1354140669-23533-4-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdprE-0002iy-QI
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514Ab2K1WLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:11:36 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab2K1WLf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:11:35 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QvlYwjJpg0KJURXqP2nEbhbHbyc2NraNKv3BxKCB9O4=;
        b=SJPJSyD/5+XK+V2SX+4brKh6Hz+LHFTEBMHynTPfnkAmxf4klC//RdN7bJh4y06tsz
         1dvFVGUtvUq30HhkLQdt7HJLzfA0+Ece7EVi0An6luEa/4XQOhvojHQzLIBTI/BVgN6i
         HOMBJQL8XTEQoIQEalxhn84RIZZ52Gb+TM5HiIGbhVwdpqVrqJeey5ovOsX4Qkr6Q/jg
         lH4xscD7pZbIsJIOxSvd5e3QQzESjxQSfiR9GubcVy7qAQQekj2ITHV72C53VkiKm0go
         xMTOBpfF8ozDc0Wnxxj7oYwidI7m7exbt3/AiCF2tpXjbcaBLngyPwb86ag42vtLOG2m
         Bk6Q==
Received: by 10.204.15.203 with SMTP id l11mr6073390bka.74.1354140694481;
        Wed, 28 Nov 2012 14:11:34 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id u3sm13787612bkw.9.2012.11.28.14.11.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:33 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210785>

This is remote-testgit, not remote-hg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5800-remote-helpers.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index e7dc668..d46fa40 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -8,7 +8,7 @@ test_description='Test remote-helper import and export commands'
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON ; then
-	skip_all='skipping git-remote-hg tests, python not available'
+	skip_all='skipping remote-testgit tests, python not available'
 	test_done
 fi
 
@@ -17,7 +17,7 @@ import sys
 if sys.hexversion < 0x02040000:
     sys.exit(1)
 ' || {
-	skip_all='skipping git-remote-hg tests, python version < 2.4'
+	skip_all='skipping remote-testgit tests, python version < 2.4'
 	test_done
 }
 
-- 
1.8.0.1
