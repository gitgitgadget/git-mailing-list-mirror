From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] reflog: remove i18n legos in pruning message
Date: Thu,  7 Jun 2012 19:05:11 +0700
Message-ID: <1339070715-31417-2-git-send-email-pclouds@gmail.com>
References: <0001-Remove-i18n-legos-in-notifying-new-branch-tracking-s.patch>
 <1339070715-31417-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 14:10:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScbXS-0000Um-R6
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 14:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233Ab2FGMJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 08:09:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42519 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab2FGMJy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 08:09:54 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so990370pbb.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9I3FLN13YfsehJ//5Gcf07V+/BPMboOH0/YZsgeZeOk=;
        b=j+ZqNe9XQBVdH9q8lyPRPYRKpQf9xw7/w6cgskdBm+c+7GvimnGvhJEfXdFcDz+pZc
         BasPcNzbfR3Z3ssmOgGf3sKVdAHjd2rSYRdvRKoPYvJBAtvMROSqw4pY11a0LDhMa2tM
         gT5I3d3nT6OvL1ANATU6njbCJsLAu+DURGtbAWZW4nSXWTD3pYg83+k6lbgIa4BamDjS
         wSlUZkILGyF7rEvLZL7k02/3rfrO5iq6HzDVzQZ3pGzM3G9Vl9ylRI2Lwa5aJQBky5I5
         j8maNrPDvt0ivphNHOUVgRU0QJJ3ZwwC9orvhJSLUCLVANYHjndU4YUZFmSteJPPdF9O
         bfgA==
Received: by 10.68.203.66 with SMTP id ko2mr8376987pbc.84.1339070994430;
        Thu, 07 Jun 2012 05:09:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.55.113])
        by mx.google.com with ESMTPS id rk4sm3919576pbc.48.2012.06.07.05.09.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 05:09:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Jun 2012 19:05:35 +0700
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1339070715-31417-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199395>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Jonathan's version

 builtin/reflog.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 062d7da..b3c9e27 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -330,8 +330,10 @@ static int expire_reflog_ent(unsigned char *osha1,=
 unsigned char *nsha1,
 		printf("keep %s", message);
 	return 0;
  prune:
-	if (!cb->newlog || cb->cmd->verbose)
-		printf("%sprune %s", cb->newlog ? "" : "would ", message);
+	if (!cb->newlog)
+		printf("would prune %s", message);
+	else if (cb->cmd->verbose)
+		printf("prune %s", message);
 	return 0;
 }
=20
--=20
1.7.8
