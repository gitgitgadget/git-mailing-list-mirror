From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 1/2] i18n: branch: unmark string for translation
Date: Wed, 13 Apr 2016 10:29:53 +0000
Message-ID: <1460543394-11050-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 12:31:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqI5A-0001Dn-0I
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 12:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbcDMKb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 06:31:27 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:35289 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965432AbcDMKb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 06:31:26 -0400
Received: (qmail 18203 invoked from network); 13 Apr 2016 10:31:24 -0000
Received: (qmail 29280 invoked from network); 13 Apr 2016 10:31:24 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 13 Apr 2016 10:31:21 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291386>

Unmark strings for translation for command help/hint.
These strings can not be translated, just copied.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
Moreover, prevent a possible translation mistake, e.g. wrong leading
spacing.

 builtin/branch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..b327cca 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -828,8 +828,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (argc == 1 && track == BRANCH_TRACK_OVERRIDE &&
 		    !branch_existed && remote_tracking) {
 			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do this:\n\n"), head, branch->name);
-			fprintf(stderr, _("    git branch -d %s\n"), branch->name);
-			fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branch->name);
+			fprintf(stderr, "    git branch -d %s\n", branch->name);
+			fprintf(stderr, "    git branch --set-upstream-to %s\n", branch->name);
 		}
 
 	} else
-- 
2.1.4
