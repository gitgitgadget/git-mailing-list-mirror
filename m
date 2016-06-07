From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 26/38] i18n: notes: mark options for translation
Date: Tue,  7 Jun 2016 11:52:25 +0000
Message-ID: <1465300357-7557-27-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:55:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFbG-000827-3s
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbcFGLzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:55:08 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:58281 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754975AbcFGLzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:55:04 -0400
Received: (qmail 1947 invoked from network); 7 Jun 2016 11:55:03 -0000
Received: (qmail 22399 invoked from network); 7 Jun 2016 11:55:03 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:55:01 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296655>

Mark options description of git prune for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/notes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d11e6eb..0572051 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -934,8 +934,8 @@ static int prune(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	int show_only = 0, verbose = 0;
 	struct option options[] = {
-		OPT__DRY_RUN(&show_only, "do not remove, show only"),
-		OPT__VERBOSE(&verbose, "report pruned notes"),
+		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
+		OPT__VERBOSE(&verbose, N_("report pruned notes")),
 		OPT_END()
 	};
 
-- 
2.7.3
