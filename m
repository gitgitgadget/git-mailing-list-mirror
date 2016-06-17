Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759F020179
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbcFQUYp (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:45 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:60200 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964908AbcFQUYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:39 -0400
Received: (qmail 21799 invoked from network); 17 Jun 2016 20:24:37 -0000
Received: (qmail 9654 invoked from network); 17 Jun 2016 20:24:37 -0000
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
Subject: [PATCH v5 30/38] i18n: sequencer: add period to error message
Date:	Fri, 17 Jun 2016 20:21:19 +0000
Message-Id: <1466194887-18236-31-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add a period to error message so it matches others instances in
sequencer.c. Now translator would have to translate such message only
once.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 57b3671..e916387 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -190,7 +190,7 @@ static void write_message(struct strbuf *msgbuf, const char *filename)
 		die_errno(_("Could not write to %s"), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die(_("Error wrapping up %s"), filename);
+		die(_("Error wrapping up %s."), filename);
 }
 
 static struct tree *empty_tree(void)
-- 
2.6.6

