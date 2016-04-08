From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 6/7] l10n: mv.c: add a comma ',' to string
Date: Fri,  8 Apr 2016 20:02:44 +0000
Message-ID: <1460145765-7454-6-git-send-email-vascomalmeida@sapo.pt>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 22:10:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aock2-0003UZ-Ip
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819AbcDHUKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:10:20 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:43981 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932099AbcDHUKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:10:19 -0400
Received: (qmail 3689 invoked from network); 8 Apr 2016 20:03:37 -0000
Received: (qmail 17197 invoked from network); 8 Apr 2016 20:03:37 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Apr 2016 20:03:32 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291064>

Add a comma to string marked for translation. Make the string match the
one in rm.c. Now translators have do handle this string only once.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index aeae855..1bf8df1 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -69,7 +69,7 @@ static void prepare_move_submodule(const char *src, int first,
 	if (!S_ISGITLINK(active_cache[first]->ce_mode))
 		die(_("Directory %s is in index and no submodule?"), src);
 	if (!is_staging_gitmodules_ok())
-		die(_("Please stage your changes to .gitmodules or stash them to proceed"));
+		die(_("Please, stage your changes to .gitmodules or stash them to proceed"));
 	strbuf_addf(&submodule_dotgit, "%s/.git", src);
 	*submodule_gitfile = read_gitfile(submodule_dotgit.buf);
 	if (*submodule_gitfile)
-- 
2.1.4
