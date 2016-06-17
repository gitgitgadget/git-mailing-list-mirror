Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99BAA20179
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbcFQUYw (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:52 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35427 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964919AbcFQUYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:39 -0400
Received: (qmail 2434 invoked from network); 17 Jun 2016 20:24:37 -0000
Received: (qmail 9531 invoked from network); 17 Jun 2016 20:24:37 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:37 -0000
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
Subject: [PATCH v5 29/38] i18n: merge: change command option help to lowercase
Date:	Fri, 17 Jun 2016 20:21:18 +0000
Message-Id: <1466194887-18236-30-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Change command option description to lowercase, matching pull
counterpart option. Translators would have to translate such message
only once.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 961def5..d82f6c1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -211,7 +211,7 @@ static struct option builtin_merge_options[] = {
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
-		N_("Verify that the named commit has a valid GPG signature")),
+		N_("verify that the named commit has a valid GPG signature")),
 	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
 		N_("merge strategy to use"), option_parse_strategy),
 	OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=value"),
-- 
2.6.6

