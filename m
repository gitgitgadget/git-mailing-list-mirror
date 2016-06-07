From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 32/38] i18n: remote: mark URL fallback text for translation
Date: Tue,  7 Jun 2016 11:52:31 +0000
Message-ID: <1465300357-7557-33-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:56:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFc2-0000Ej-18
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbcFGLzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:55:38 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:33379 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161162AbcFGLzh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:55:37 -0400
Received: (qmail 29004 invoked from network); 7 Jun 2016 11:55:35 -0000
Received: (qmail 27870 invoked from network); 7 Jun 2016 11:55:34 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:55:29 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296659>

Marks fallback text for translation that may be displayed in git remote
show output.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index ae74da6..9f934cb 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1158,11 +1158,11 @@ static int show(int argc, const char **argv)
 			   the one in "  Fetch URL: %s" translation */
 			printf_ln(_("  Push  URL: %s"), url[i]);
 		if (!i)
-			printf_ln(_("  Push  URL: %s"), "(no URL)");
+			printf_ln(_("  Push  URL: %s"), _("(no URL)"));
 		if (no_query)
-			printf_ln(_("  HEAD branch: %s"), "(not queried)");
+			printf_ln(_("  HEAD branch: %s"), _("(not queried)"));
 		else if (!states.heads.nr)
-			printf_ln(_("  HEAD branch: %s"), "(unknown)");
+			printf_ln(_("  HEAD branch: %s"), _("(unknown)"));
 		else if (states.heads.nr == 1)
 			printf_ln(_("  HEAD branch: %s"), states.heads.items[0].string);
 		else {
-- 
2.7.3
