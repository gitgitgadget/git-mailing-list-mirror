From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 06/39] i18n: sequencer: mark string for translation
Date: Wed,  1 Jun 2016 16:40:56 +0000
Message-ID: <1464799289-7639-7-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:43:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89En-0004Ip-Uk
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbcFAQnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:43:09 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47348 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932803AbcFAQnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:43:06 -0400
Received: (qmail 19524 invoked from network); 1 Jun 2016 16:42:59 -0000
Received: (qmail 8228 invoked from network); 1 Jun 2016 16:42:59 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:42:54 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296105>

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
2.7.3
