From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 09/10] remote-hg: test: be a little more quiet
Date: Mon, 13 May 2013 18:11:59 -0500
Message-ID: <1368486720-2716-10-git-send-email-felipe.contreras@gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:15:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1xY-0007fA-96
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500Ab3EMXPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:15:06 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:54064 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab3EMXPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:15:04 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so8133648oag.39
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2tZfJT9zThATuI1dO/6MMA1wz+xZWclPaGwOh0TFa/U=;
        b=ZsQghka4o3/0XS1qKkt60X8lASflqOYtyr/Z5oMyAQ0jUAcTT4lKLoJlQPUTsIRekA
         lEH4/+yUNC7BXhFwuRa06tt86IGCPWqDjCLLY6INokawt0gEu2x8diNTq2om16u5oZ28
         PjfRrtA7FqGvk+nvodUzvr2Nyks4++Xa4jewQW55MM9ZIe2aA6l4KmqTi2x3u+WA48IY
         ypxCMSgSXIHDUntwdYYkcKm3QWgmozMyXOVrJzzYRb3jmzRAf4wap5Pqa6ph5d7/GUYf
         Wk2pn4pbiT167qV3oYp63r1Mfo4qsVhjd2gfNJFYTQ0vixeNkCoqnFh11Rt5CtNBb2Q6
         Z31Q==
X-Received: by 10.60.65.5 with SMTP id t5mr14904463oes.139.1368486904550;
        Mon, 13 May 2013 16:15:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm18828751obl.1.2013.05.13.16.15.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:15:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224227>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 8de2aa7..f8d1f9e 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -109,10 +109,10 @@ test_expect_success 'update bookmark' '
   (
   git clone "hg::$PWD/hgrepo" gitrepo &&
   cd gitrepo &&
-  git checkout devel &&
+  git checkout --quiet devel &&
   echo devel > content &&
   git commit -a -m devel &&
-  git push
+  git push --quiet
   ) &&
 
   hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
-- 
1.8.3.rc1.579.g184e698
