Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844C920179
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933077AbcFQUYM (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:12 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:60115 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932943AbcFQUYK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:10 -0400
Received: (qmail 21527 invoked from network); 17 Jun 2016 20:24:08 -0000
Received: (qmail 2426 invoked from network); 17 Jun 2016 20:24:08 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:06 -0000
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
Subject: [PATCH v5 06/38] i18n: sequencer: mark string for translation
Date:	Fri, 17 Jun 2016 20:20:55 +0000
Message-Id: <1466194887-18236-7-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark informative string "<action_name>: fast-forward" for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 88a7c78..57b3671 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -225,7 +225,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	if (checkout_fast_forward(from, to, 1))
 		exit(128); /* the callee should have complained already */
 
-	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
+	strbuf_addf(&sb, _("%s: fast-forward"), action_name(opts));
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-- 
2.6.6

