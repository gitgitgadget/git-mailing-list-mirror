From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 31/39] i18n: sequencer: add period to error message
Date: Wed,  1 Jun 2016 16:41:21 +0000
Message-ID: <1464799289-7639-32-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:45:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89Gw-0005vB-Sb
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbcFAQpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:45:01 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:44046 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932751AbcFAQpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:45:00 -0400
Received: (qmail 14608 invoked from network); 1 Jun 2016 16:44:58 -0000
Received: (qmail 6196 invoked from network); 1 Jun 2016 16:44:58 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:44:56 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296124>

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
2.7.3
