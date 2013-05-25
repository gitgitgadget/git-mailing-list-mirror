From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/48] remote-hg: test: be a little more quiet
Date: Fri, 24 May 2013 21:29:17 -0500
Message-ID: <1369449004-17981-2-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:31:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Gt-0001GX-T2
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab3EYCbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:31:45 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:54573 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab3EYCbp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:31:45 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so7029923oah.12
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FAYnQATRlt6JcmaUPcWDWjzrBsNL6xPwfsPa39dod5c=;
        b=ZFpHcFvWJEhiXW0Fd1t4WmVPZoBuFcByF6EMa/B6EgITpVBsXEToDToP1JFgqhxbdp
         C4a3seYa8tOQphKuV3wxcGWt3JqIPhHbw+qHGOqIftJxSkLvRcSWqAPA9w/Bc09TF9vQ
         6M/N/p31YmLFU6DUe6GiGsVewUVtGAkkMdIIADM5DcLZc2s6YHqkYKzWeWGb3igJvZOf
         /bVZv+43dF6FIllp/BmgF9RqKKdcPLt1iBOfstmilEOJLDZGJlv29WavEQrnu2DKBGPI
         4nM/PIuPPnD+hro5AAzUNmtD8+xBqs9jjRETE2l91DlqblYW36+P09enInxb2pqIYXhG
         PT5g==
X-Received: by 10.60.93.67 with SMTP id cs3mr13141353oeb.88.1369449104628;
        Fri, 24 May 2013 19:31:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm20050066obx.9.2013.05.24.19.31.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:31:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225415>

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
1.8.3.rc3.312.g47657de
