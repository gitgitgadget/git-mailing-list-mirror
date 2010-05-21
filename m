From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH next] Complete prototype of git_config_from_parameters()
Date: Fri, 21 May 2010 12:07:47 +0200
Message-ID: <0c117d8ae7550689d0f19814872ccefe68fb4e62.1274436375.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alex Riesen <raa.lkml@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 21 12:08:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFP99-000279-Ll
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 12:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab0EUKH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 06:07:58 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:8605 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280Ab0EUKH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 06:07:57 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 21 May
 2010 12:07:56 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 21 May
 2010 12:07:46 +0200
X-Mailer: git-send-email 1.7.1.312.g24d42.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147445>

Add the missing argument list.  (Its lack triggered a compiler warning
for me.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

On top of 8b1fa778, which is only in 'next' so far.

 cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 51d9678..c966023 100644
--- a/cache.h
+++ b/cache.h
@@ -940,7 +940,7 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config_parse_parameter(const char *text);
-extern int git_config_from_parameters();
+extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
-- 
1.7.1.312.g24d42.dirty
