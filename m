From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2 7/7] i18n: builtin/branch.c: mark option for translation
Date: Sat,  9 Apr 2016 20:38:44 +0000
Message-ID: <1460234324-13506-7-git-send-email-vascomalmeida@sapo.pt>
References: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 22:39:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aozfZ-0001SF-Tl
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 22:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588AbcDIUj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 16:39:27 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:56866 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754517AbcDIUj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 16:39:26 -0400
Received: (qmail 8353 invoked from network); 9 Apr 2016 20:39:24 -0000
Received: (qmail 18505 invoked from network); 9 Apr 2016 20:39:24 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 9 Apr 2016 20:39:19 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291133>

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
