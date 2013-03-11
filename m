From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] add: add a newline at the end of pathless 'add [-u|-A]' warning
Date: Mon, 11 Mar 2013 09:01:33 +0100
Message-ID: <1362988893-27539-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqk3pefjs4.fsf@grenoble-inp.fr>
 <1362988893-27539-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 11 09:02:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UExhB-0001NZ-6F
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 09:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107Ab3CKIC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 04:02:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41339 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab3CKICW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 04:02:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r2B81Zui005553
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 09:01:35 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UExfs-0004zY-Db; Mon, 11 Mar 2013 09:01:36 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UExfs-0007B1-A6; Mon, 11 Mar 2013 09:01:36 +0100
X-Mailer: git-send-email 1.8.2.rc3.16.g0a33571.dirty
In-Reply-To: <1362988893-27539-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Mar 2013 09:01:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2B81Zui005553
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1363593697.10099@hUxfKrsMcBsRuVWNx+4R3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217860>

When the commands give an actual output (e.g. when ran with -v), the
output is visually mixed with the warning. The newline makes the actual
output more visible.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index ab1c9e8..620bf00 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -344,7 +344,7 @@ static void warn_pathless_add(const char *option_name, const char *short_name) {
 		  "  git add %s .\n"
 		  "  (or git add %s .)\n"
 		  "\n"
-		  "With the current Git version, the command is restricted to the current directory."),
+		  "With the current Git version, the command is restricted to the current directory.\n"),
 		option_name, short_name,
 		option_name, short_name,
 		option_name, short_name);
-- 
1.8.2.rc3.16.g0a33571.dirty
