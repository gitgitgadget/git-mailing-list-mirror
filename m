From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6.5/7] builtin/log.c: make usage string consistent with doc
Date: Mon, 22 Apr 2013 12:50:44 +0530
Message-ID: <1366615244-21825-1-git-send-email-artagnon@gmail.com>
References: <1366608631-21734-8-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 09:19:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUB21-00027F-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 09:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab3DVHTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 03:19:18 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34330 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab3DVHTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 03:19:17 -0400
Received: by mail-pa0-f53.google.com with SMTP id bh4so3403910pad.26
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 00:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=tL3XOB+aypNkSAQjrrkvw5aVvon8yZxaDAsUBnomRao=;
        b=UZTFNmy+pFdF94S+78zS7mD1En/e/4ZR6qlwlf8lPJZzqCCyzxvlpkkHlIVh64bR9S
         bAlG/v54SpJOxM0hdBRvG7J7bb+jgBaRpd6t706ptHquAQGJuEVI58yCm201RtEUlHNk
         F5jTHF+jtLInCJKLzndogXci298mjxIH/Z3ohNivi9/PMCNOcGgmM2pxj6/YAyEuOyuc
         JZpZzGZXLHMsciFSe41qMRT68Jp1GJhsZhe5ChcLTEIO17+jeHuI0WodyF3aZrq8Kgxf
         vo3jQO7jMTl13wWfOwrOTa5uPSSORRpimZSPu77/3y5hLMyI3CddXXndosRoOz3d74yN
         UvwA==
X-Received: by 10.68.202.4 with SMTP id ke4mr31779061pbc.185.1366615157221;
        Mon, 22 Apr 2013 00:19:17 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ky10sm25918964pab.23.2013.04.22.00.19.13
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 00:19:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.423.g9a53c75.dirty
In-Reply-To: <1366608631-21734-8-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221997>

Replace '<since>..<until>' with '<revision range>', in accordance with
the documentation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Junio: sorry I missed this detail.  Can you squeeze this patch
 between [6/7] and [7/7] so that the commit message in [7/7] makes
 sense?

 Thanks.

 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index ad46f72..6e56a50 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -37,7 +37,7 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
-	N_("git log [<options>] [<since>..<until>] [[--] <path>...]\n")
+	N_("git log [<options>] [<revision range>] [[--] <path>...]\n")
 	N_("   or: git show [options] <object>..."),
 	NULL
 };
-- 
1.8.2.1.423.g9a53c75.dirty
