From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 7/7] l10n: builtin/branch.c: mark option for translation
Date: Fri,  8 Apr 2016 20:02:45 +0000
Message-ID: <1460145765-7454-7-git-send-email-vascomalmeida@sapo.pt>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 22:10:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aock3-0003UZ-5o
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbcDHUK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:10:27 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:43997 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932099AbcDHUKY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:10:24 -0400
Received: (qmail 3728 invoked from network); 8 Apr 2016 20:03:42 -0000
Received: (qmail 17519 invoked from network); 8 Apr 2016 20:03:42 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Apr 2016 20:03:37 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291063>

Mark description and parameter for option "set-upstream-to" for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..5ab106b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -620,7 +620,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			BRANCH_TRACK_EXPLICIT),
 		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
 			BRANCH_TRACK_OVERRIDE),
-		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
+		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
-- 
2.1.4
