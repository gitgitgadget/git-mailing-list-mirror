From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 5/7] l10n: builtin/pull.c: split strings marked for translation
Date: Fri,  8 Apr 2016 20:02:43 +0000
Message-ID: <1460145765-7454-5-git-send-email-vascomalmeida@sapo.pt>
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
	id 1aock3-0003UZ-Op
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbcDHUKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:10:37 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:59697 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932169AbcDHUKP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:10:15 -0400
Received: (qmail 16965 invoked from network); 8 Apr 2016 20:03:32 -0000
Received: (qmail 16976 invoked from network); 8 Apr 2016 20:03:32 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Apr 2016 20:03:27 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291065>

Split string "If you wish to set tracking information
for this branch you can do so with:\n" to match occurring string in
git-parse-remote.sh. In this case, the translator handles it only once.

On the other hand, the translations of the string that were already made
are mark as fuzzy and the translator needs to correct it herself.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/pull.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a99d6b9..ac942f6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -475,9 +475,9 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, _("    git pull <remote> <branch>"));
 		fprintf(stderr, "\n");
-		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:\n"
-				"\n"
-				"    git branch --set-upstream-to=%s/<branch> %s\n"),
+		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:"));
+		fprintf(stderr, "\n");
+		fprintf_ln(stderr, _("    git branch --set-upstream-to=%s/<branch> %s\n"),
 				remote_name, curr_branch->name);
 	} else
 		fprintf_ln(stderr, _("Your configuration specifies to merge with the ref '%s'\n"
-- 
2.1.4
