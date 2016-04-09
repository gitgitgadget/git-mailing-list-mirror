From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2 4/7] i18n: builtin/pull.c: mark strings for translation
Date: Sat,  9 Apr 2016 20:38:41 +0000
Message-ID: <1460234324-13506-4-git-send-email-vascomalmeida@sapo.pt>
References: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 22:39:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aozf7-00010m-6U
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 22:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbcDIUjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 16:39:12 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:53541 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754517AbcDIUjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 16:39:11 -0400
Received: (qmail 14505 invoked from network); 9 Apr 2016 20:39:08 -0000
Received: (qmail 16665 invoked from network); 9 Apr 2016 20:39:08 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 9 Apr 2016 20:39:03 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291129>

Some translations might also translate "<remote>" and "<branch>".

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/pull.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..9e8883c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -458,13 +458,13 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
-		fprintf_ln(stderr, "    git pull <remote> <branch>");
+		fprintf_ln(stderr, "    git pull <%s> <%s>", _("remote"), _("branch"));
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
+		fprintf_ln(stderr, "    git pull <%s> <%s>", _("remote"), _("branch"));
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:\n"
 				"\n"
-- 
2.1.4
