From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] builtin/remote.c: add missing space to user-facing message
Date: Wed, 17 Dec 2014 02:20:34 -0700
Message-ID: <20141217022034.5259c7879ecedd905f9ba633@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 10:38:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1B0a-00079y-2k
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 10:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbaLQJUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 04:20:40 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40943 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbaLQJUj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 04:20:39 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so13777732pdi.7
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 01:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=wnO7A4Vw9pQIkY0EXhULBXnFIjuOVHmOfjQ0AMg4T3E=;
        b=A9tkZEqm5XaUUfPod/MuUwmb3P7D+r2wbcOhABclJw6S9JMnr/n30Z+lrMOesVIRjD
         wXW/se4rE0eyWWJsu1l7YhzmvjGjDaXoshGUHVfAr1U8lY8L8o8bZVMgxSfl8PcciQFZ
         WgnEVZ3WQmXhDAA6VJYoU6IcR7vPu8OFmv4JBb71j/p1SwYpaGPmy3vxTqD/KUxV8lm+
         Tt9eSPdHF9DYTMN14nqlEO+sc2+YNsdIUEuB5+tgBgz1P3ITQJEVVT47ONk80WMlr3ue
         08BJZLQbGSnH4a+ReIqs0AQ69ldCEBdH8Uv+PgKNi6VT5lB31/KdnBdTlHPpuQsqGDlm
         zU+Q==
X-Received: by 10.70.103.141 with SMTP id fw13mr68619693pdb.148.1418808038606;
        Wed, 17 Dec 2014 01:20:38 -0800 (PST)
Received: from localhost.localdomain ([2601:b:5a00:1827:e8b:fdff:fecc:2734])
        by mx.google.com with ESMTPSA id v3sm3333614pdf.22.2014.12.17.01.20.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Dec 2014 01:20:38 -0800 (PST)
X-Mailer: Sylpheed 3.4.2 (GTK+ 2.24.25; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261476>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..c55c7ce 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -13,7 +13,7 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>"),
 	N_("git remote rename <old> <new>"),
 	N_("git remote remove <name>"),
-	N_("git remote set-head <name> (-a | --auto | -d | --delete |<branch>)"),
+	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
 	N_("git remote [-v | --verbose] show [-n] <name>"),
 	N_("git remote prune [-n | --dry-run] <name>"),
 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
-- 
2.1.3
