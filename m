From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 2/2] i18n: branch: move comment for translators
Date: Wed, 13 Apr 2016 10:29:54 +0000
Message-ID: <1460543394-11050-2-git-send-email-vascomalmeida@sapo.pt>
References: <1460543394-11050-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 12:31:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqI5A-0001Dn-JD
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 12:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbcDMKbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 06:31:33 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:45267 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965432AbcDMKbc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 06:31:32 -0400
Received: (qmail 22439 invoked from network); 13 Apr 2016 10:31:30 -0000
Received: (qmail 29957 invoked from network); 13 Apr 2016 10:31:30 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 13 Apr 2016 10:31:25 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460543394-11050-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291387>

Move and split comment for translators (marked by TRANSLATORS) to be
immediately above the strings marked for translation.

As a result, the comment can now be extracted by xgettext.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/branch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b327cca..8a0a181 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -369,12 +369,14 @@ static char *get_head_description(void)
 		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
 			    state.branch);
 	else if (state.detached_from) {
-		/* TRANSLATORS: make sure these match _("HEAD detached at ")
-		   and _("HEAD detached from ") in wt-status.c */
 		if (state.detached_at)
+			/* TRANSLATORS: make sure this matches
+			   "HEAD detached at " in wt-status.c */
 			strbuf_addf(&desc, _("(HEAD detached at %s)"),
 				state.detached_from);
 		else
+			/* TRANSLATORS: make sure this matches
+			   "HEAD detached from " in wt-status.c */
 			strbuf_addf(&desc, _("(HEAD detached from %s)"),
 				state.detached_from);
 	}
-- 
2.1.4
