Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E95920179
	for <e@80x24.org>; Fri, 17 Jun 2016 20:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094AbcFQUZA (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:25:00 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52153 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964910AbcFQUYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:36 -0400
Received: (qmail 23802 invoked from network); 17 Jun 2016 20:24:35 -0000
Received: (qmail 9019 invoked from network); 17 Jun 2016 20:24:35 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:34 -0000
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
Subject: [PATCH v5 26/38] i18n: notes: mark options for translation
Date:	Fri, 17 Jun 2016 20:21:15 +0000
Message-Id: <1466194887-18236-27-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

