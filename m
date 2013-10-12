From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/20] branch: trivial style fix
Date: Sat, 12 Oct 2013 02:07:00 -0500
Message-ID: <1381561636-20717-5-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOO-0005ga-Hu
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597Ab3JLHNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:32 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:64155 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab3JLHN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:27 -0400
Received: by mail-ob0-f181.google.com with SMTP id va2so3386569obc.26
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OPnHyJz+eGZzkyAGmwipJkKZWpUPhrcQYjmPzCfmv/0=;
        b=EgdUkbS32RPiW125a/f8X7RGzeeW9H8mWpdz2guwEx8GY8UwxEz+D83fAqdLXYr/yW
         bCNYSUPAt3+jyUqnyPwAy6HBdXhEvDtbj87EmFceeiPnqEyEljZ6TmzBnk/7HmtZzMRi
         fXq5j/g84keE01ahsQ/zyWePLy3zZFahwhlHZ0v5u1BRHKO/xoHg/lq0zsIt6upR5xAs
         4dWa/2OJLl9+cq1e9csPk3h6WdPWWTMUH+eM0SbxMUNLSQ/oaheUIua1i55lo5gUU8zj
         nZ5c9CEmKtgddSVOBmiqEPk3/+3NxPOQJrTGtWT3HpVUd0NNYPcENMSJxwcew475bT6O
         VLVQ==
X-Received: by 10.60.80.8 with SMTP id n8mr17668262oex.33.1381562007126;
        Sat, 12 Oct 2013 00:13:27 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm28647421obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236014>

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
1.8.4-fc
