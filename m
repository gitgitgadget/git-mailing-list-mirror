From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: [PATCH 2/2] i18n translate builtin warning, error, usage, fatal messages
Date: Fri,  5 Sep 2014 14:57:25 -0400
Message-ID: <1409943445-12283-3-git-send-email-sandy.carter@savoirfairelinux.com>
References: <1409943445-12283-1-git-send-email-sandy.carter@savoirfairelinux.com>
Cc: sandy.carter@savoirfairelinux.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 21:02:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPym3-0001Jf-2n
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 21:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbaIETCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 15:02:15 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:54136 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbaIETCN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 15:02:13 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Sep 2014 15:02:13 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 22823C9600E
	for <git@vger.kernel.org>; Fri,  5 Sep 2014 14:54:02 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdFoi1+d93kN; Fri,  5 Sep 2014 14:54:01 -0400 (EDT)
Received: from scarter-X220.mtl.sfl (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A624CC9600F;
	Fri,  5 Sep 2014 14:54:01 -0400 (EDT)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409943445-12283-1-git-send-email-sandy.carter@savoirfairelinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256513>

Allow warnings, errors, usage and fatal messages to be translated to user
when checking out a ambiguous refname for example

Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
---
 usage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/usage.c b/usage.c
index ed14645..24a450e 100644
--- a/usage.c
+++ b/usage.c
@@ -27,24 +27,24 @@ void vwritef(int fd, const char *prefix, const char *err, va_list params)
 
 static NORETURN void usage_builtin(const char *err, va_list params)
 {
-	vreportf("usage: ", err, params);
+	vreportf(_("usage: "), err, params);
 	exit(129);
 }
 
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	vreportf("fatal: ", err, params);
+	vreportf(_("fatal: "), err, params);
 	exit(128);
 }
 
 static void error_builtin(const char *err, va_list params)
 {
-	vreportf("error: ", err, params);
+	vreportf(_("error: "), err, params);
 }
 
 static void warn_builtin(const char *warn, va_list params)
 {
-	vreportf("warning: ", warn, params);
+	vreportf(_("warning: "), warn, params);
 }
 
 static int die_is_recursing_builtin(void)
-- 
2.1.0
