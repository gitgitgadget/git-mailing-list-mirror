From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 7/7] i18n: builtin/branch.c: mark option for translation
Date: Tue, 19 Apr 2016 13:19:24 +0000
Message-ID: <1461071964-323-7-git-send-email-vascomalmeida@sapo.pt>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:21:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asVaJ-0003fN-IL
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 15:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbcDSNUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 09:20:50 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:40860 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932074AbcDSNUt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 09:20:49 -0400
Received: (qmail 18479 invoked from network); 19 Apr 2016 13:20:47 -0000
Received: (qmail 19297 invoked from network); 19 Apr 2016 13:20:47 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[147.203.126.136])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <git@vger.kernel.org>; 19 Apr 2016 13:20:41 -0000
X-PTMail-RemoteIP: 147.203.126.136
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291857>

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
2.1.4
