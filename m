Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8651C1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbcFQUYp (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:45 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:60207 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964927AbcFQUYk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:40 -0400
Received: (qmail 21818 invoked from network); 17 Jun 2016 20:24:39 -0000
Received: (qmail 10039 invoked from network); 17 Jun 2016 20:24:39 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:38 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 32/38] i18n: remote: mark URL fallback text for translation
Date:	Fri, 17 Jun 2016 20:21:21 +0000
Message-Id: <1466194887-18236-33-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Marks fallback text for translation that may be displayed in git remote
show output.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index ae74da6..9f934cb 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1158,11 +1158,11 @@ static int show(int argc, const char **argv)
 			   the one in "  Fetch URL: %s" translation */
 			printf_ln(_("  Push  URL: %s"), url[i]);
 		if (!i)
-			printf_ln(_("  Push  URL: %s"), "(no URL)");
+			printf_ln(_("  Push  URL: %s"), _("(no URL)"));
 		if (no_query)
-			printf_ln(_("  HEAD branch: %s"), "(not queried)");
+			printf_ln(_("  HEAD branch: %s"), _("(not queried)"));
 		else if (!states.heads.nr)
-			printf_ln(_("  HEAD branch: %s"), "(unknown)");
+			printf_ln(_("  HEAD branch: %s"), _("(unknown)"));
 		else if (states.heads.nr == 1)
 			printf_ln(_("  HEAD branch: %s"), states.heads.items[0].string);
 		else {
-- 
2.6.6

