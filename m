From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 7/7] i18n: builtin/branch.c: mark option for translation
Date: Thu, 12 May 2016 19:59:28 +0000
Message-ID: <1463083168-29213-8-git-send-email-vascomalmeida@sapo.pt>
References: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 22:00:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wms-0006Y8-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbcELUAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:00:41 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:53199 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751093AbcELUAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:00:40 -0400
Received: (qmail 32036 invoked from network); 12 May 2016 20:00:37 -0000
Received: (qmail 991 invoked from network); 12 May 2016 20:00:37 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 May 2016 20:00:35 -0000
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294446>

Mark description and parameter for option "set-upstream-to" for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0adba62..b7d906d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -630,7 +630,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			BRANCH_TRACK_EXPLICIT),
 		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
 			BRANCH_TRACK_OVERRIDE),
-		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
+		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
-- 
2.7.3
