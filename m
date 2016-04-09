From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2 6/7] i18n: builtin/rm.c: remove a comma ',' from string
Date: Sat,  9 Apr 2016 20:38:43 +0000
Message-ID: <1460234324-13506-6-git-send-email-vascomalmeida@sapo.pt>
References: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 22:39:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aozfa-0001SF-GO
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 22:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759100AbcDIUjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 16:39:42 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:53552 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754517AbcDIUjl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 16:39:41 -0400
Received: (qmail 14561 invoked from network); 9 Apr 2016 20:39:19 -0000
Received: (qmail 17724 invoked from network); 9 Apr 2016 20:39:19 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 9 Apr 2016 20:39:14 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291132>

Remove a comma from string marked for translation. Make the string match the
one in builtin/mv.c. Now translators have do handle this string only once.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 8829b09..be83c43 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -314,7 +314,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
 		if (list.entry[list.nr++].is_submodule &&
 		    !is_staging_gitmodules_ok())
-			die (_("Please, stage your changes to .gitmodules or stash them to proceed"));
+			die (_("Please stage your changes to .gitmodules or stash them to proceed"));
 	}
 
 	if (pathspec.nr) {
-- 
2.1.4
