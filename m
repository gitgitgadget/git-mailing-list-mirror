From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] builtin/clean.c: Use STRING_LIST_INIT_NODUP.
Date: Mon,  6 Sep 2010 20:32:55 -0300
Message-ID: <1283815975-11107-1-git-send-email-tfransosi@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 01:33:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslBa-0007kf-1X
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 01:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab0IFXdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 19:33:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33093 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0IFXdF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 19:33:05 -0400
Received: by gyd8 with SMTP id 8so1770444gyd.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 16:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Blay7QftyO8nxuThaMLQ4sTVn96Bo54p4DnxZW4j5cY=;
        b=AoTJsHDjoAnrLjqoYsGUyFyRQezV21n41cqVPqaNFInOnIw7z42we3jbIgWHlKC9Np
         5cNOptoXw8MmLrQ3Q6aPkLI++l1Rd8bQ9yAhW+jUd43/i2pzp/0xGuuIaC6yFe2LJ//U
         VDkBeLMjnvCrfN1GZx9OlcX/MnKfCdqEhkjLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YHrQDDrNWyANOYMV75F3XbMkZtoem9XtsEMgaTVychRE5dmF5fEYCWnXUrTKfmoiMV
         AFWBx7iPQEnYRyR4o2WmCoxohJcAuxBSAcFwlqzGlbLAPGHr8+miaMmuWtwo0Sl8DNGH
         a96WuJfrD9G8zs8kGHx+yqiZXZVxGoOTABO/0=
Received: by 10.150.212.11 with SMTP id k11mr61044ybg.337.1283815983591;
        Mon, 06 Sep 2010 16:33:03 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id c2sm4203674ybi.21.2010.09.06.16.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 16:33:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155639>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin/clean.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index b508d2c..c8798f5 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -44,7 +44,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
-	struct string_list exclude_list = { NULL, 0, 0, 0 };
+	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
-- 
1.7.2.3.313.gcd15
