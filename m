From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 6/7] i18n: builtin/rm.c: remove a comma ',' from string
Date: Tue, 19 Apr 2016 13:19:23 +0000
Message-ID: <1461071964-323-6-git-send-email-vascomalmeida@sapo.pt>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:20:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asVaB-0003ai-PO
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 15:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbcDSNUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 09:20:42 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:42685 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932074AbcDSNUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 09:20:39 -0400
Received: (qmail 13272 invoked from network); 19 Apr 2016 13:20:37 -0000
Received: (qmail 16469 invoked from network); 19 Apr 2016 13:20:37 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[147.203.126.136])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <git@vger.kernel.org>; 19 Apr 2016 13:20:32 -0000
X-PTMail-RemoteIP: 147.203.126.136
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291858>

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
