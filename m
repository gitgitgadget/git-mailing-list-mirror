From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 100/104] Complete prototype of git_config_from_parameters()
Date: Wed, 26 May 2010 18:01:10 +1200
Message-ID: <1274853674-18521-100-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9mN-0005GU-DZ
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934102Ab0EZGHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:07:44 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49306 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933652Ab0EZGG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:29 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 02:06:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 3FDA7338E3;
	Wed, 26 May 2010 18:02:10 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WH+8dl9Gp6oP; Wed, 26 May 2010 18:02:07 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 405F0336E6;
	Wed, 26 May 2010 18:01:40 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147769>

From: Thomas Rast <trast@student.ethz.ch>

Add the missing argument list.  (Its lack triggered a compiler warning
for me.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 4a0c75d..73f0f7b 100644
--- a/cache.h
+++ b/cache.h
@@ -933,7 +933,7 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config_parse_parameter(const char *text);
-extern int git_config_from_parameters();
+extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
-- 
1.7.1.rc2.333.gb2668
