From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/16] branch: trivial style fix
Date: Thu, 31 Oct 2013 03:25:38 -0600
Message-ID: <1383211547-9145-8-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbocg-0008Ez-Vy
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671Ab3JaJcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:48 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:58237 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab3JaJcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:46 -0400
Received: by mail-oa0-f45.google.com with SMTP id i4so2793550oah.32
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T66WwR6uEHViMSz4yx/TS04gE8uCTbgwxsI+V2YwY7s=;
        b=Ct0f43lcEGpyCefxfRAbaudbLjNp+pIAH/WuvA1p/ReWNUuwmo5sZLPIEN+3Sm8lpB
         LjMOs2RhROBdjoiyd02bcCASH8vX79drNOck/Rj2qNiACMrJd7DxrPt/tT+88u3/v6K9
         mP3P2B9pudWLukZiaVvOlOGVtlGRJgGflE0LfZOClisUHCPDZ+eFbYzIgDMzvpWjZpmk
         iDgLXItT6z/1L3KJ+Xj3+FUTwPDG0XeNuspj4cuYX/xTLih8opu8RLbF1vO9r4pMFtNC
         etiKH+kS3Jakj+d82QkOU9J38GuhaglZe/rRVtUa8b1uOQrxI2XjqoMOYp1ValkhnRGS
         98eg==
X-Received: by 10.182.88.202 with SMTP id bi10mr1841845obb.52.1383211965910;
        Thu, 31 Oct 2013 02:32:45 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm4455297obc.12.2013.10.31.02.32.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237091>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/branch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ad0f86d..5696cf0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -975,9 +975,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
-		if (!branch_has_merge_config(branch)) {
+		if (!branch_has_merge_config(branch))
 			die(_("Branch '%s' has no upstream information"), branch->name);
-		}
 
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
-- 
1.8.4.2+fc1
