From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 4/7] l10n: builtin/pull.c: mark strings for translation
Date: Fri,  8 Apr 2016 20:02:42 +0000
Message-ID: <1460145765-7454-4-git-send-email-vascomalmeida@sapo.pt>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 22:10:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aocjW-00036Q-3D
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758915AbcDHUKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:10:09 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:54177 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758876AbcDHUKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:10:08 -0400
Received: (qmail 28743 invoked from network); 8 Apr 2016 20:03:26 -0000
Received: (qmail 16750 invoked from network); 8 Apr 2016 20:03:26 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Apr 2016 20:03:21 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291062>

Some translations might also translate "<remote>" and "<branch>".

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/pull.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..a99d6b9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -458,13 +458,13 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
-		fprintf_ln(stderr, "    git pull <remote> <branch>");
+		fprintf_ln(stderr, _("    git pull <remote> <branch>"));
 		fprintf(stderr, "\n");
 	} else if (!curr_branch->merge_nr) {
 		const char *remote_name = NULL;
 
 		if (for_each_remote(get_only_remote, &remote_name) || !remote_name)
-			remote_name = "<remote>";
+			remote_name = _("<remote>");
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
 		if (opt_rebase)
@@ -473,7 +473,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
-		fprintf_ln(stderr, "    git pull <remote> <branch>");
+		fprintf_ln(stderr, _("    git pull <remote> <branch>"));
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:\n"
 				"\n"
-- 
2.1.4
