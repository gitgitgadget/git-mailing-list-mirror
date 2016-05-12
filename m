From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 4/7] i18n: builtin/pull.c: mark placeholders for translation
Date: Thu, 12 May 2016 19:59:25 +0000
Message-ID: <1463083168-29213-5-git-send-email-vascomalmeida@sapo.pt>
References: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 22:00:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wmi-0006J5-MR
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbcELUAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:00:32 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:58928 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751006AbcELUA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:00:29 -0400
Received: (qmail 11899 invoked from network); 12 May 2016 20:00:26 -0000
Received: (qmail 30683 invoked from network); 12 May 2016 20:00:26 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 May 2016 20:00:25 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
In-Reply-To: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294442>

Some translations might also translate "<remote>" and "<branch>".

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/pull.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 596b92f..96b98ea 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -478,13 +478,13 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
-		fprintf_ln(stderr, "    git pull <remote> <branch>");
+		fprintf_ln(stderr, "    git pull %s %s", _("<remote>"), _("<branch>"));
 		fprintf(stderr, "\n");
 	} else if (!curr_branch->merge_nr) {
 		const char *remote_name = NULL;
 
 		if (for_each_remote(get_only_remote, &remote_name) || !remote_name)
-			remote_name = "<remote>";
+			remote_name = _("<remote>");
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
 		if (opt_rebase)
@@ -493,7 +493,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
-		fprintf_ln(stderr, "    git pull <remote> <branch>");
+		fprintf_ln(stderr, "    git pull %s %s", _("<remote>"), _("<branch>"));
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:\n"
 				"\n"
-- 
2.7.3
