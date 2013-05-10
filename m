From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/6] remote-hg: test: be a little more quiet
Date: Fri, 10 May 2013 15:59:24 -0500
Message-ID: <1368219566-1399-5-git-send-email-felipe.contreras@gmail.com>
References: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 23:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UauRN-00011b-PE
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 23:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab3EJVBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 17:01:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33488 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab3EJVBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 17:01:04 -0400
Received: by mail-ob0-f174.google.com with SMTP id dn14so4659978obc.5
        for <git@vger.kernel.org>; Fri, 10 May 2013 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2tZfJT9zThATuI1dO/6MMA1wz+xZWclPaGwOh0TFa/U=;
        b=Un4w/SqsYCxe5AUT7sq7gAzzuU1Da4YCiKltTBSuVy58hL8viRiAd4Az7gSWHOgbL2
         L6uUSJRCurxwnpb7OIEgxphKmvIPuTtSSakVaX7GDLc9ODoMjf4GB+SDSK68bdfnK2dg
         zocXuuhA4532IttSpwZjLM2zgwnXr9UTqM53GVHcdQJDKtEtsw3Yh+9t/Ld99KFB8d//
         7q+/wqufY05cHKXgDXSVXuwdXzA8kmpNbUgqnGHZtu90cB42b0Z9c3aRP6flNg+FG8ad
         hXP7G8VGzGftE0+8o0tj12C05XilAnY8VD6/MWj4Xjn9spUqF5pQF997R5VO2lpC8DfJ
         CX9A==
X-Received: by 10.60.131.6 with SMTP id oi6mr7657657oeb.19.1368219664242;
        Fri, 10 May 2013 14:01:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm4651672obc.2.2013.05.10.14.01.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 14:01:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223911>

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
