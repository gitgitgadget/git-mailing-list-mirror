From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 30/38] i18n: sequencer: add period to error message
Date: Tue,  7 Jun 2016 11:52:29 +0000
Message-ID: <1465300357-7557-31-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:55:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFbb-0008LO-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbcFGLz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:55:28 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:58436 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161162AbcFGLzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:55:24 -0400
Received: (qmail 2472 invoked from network); 7 Jun 2016 11:55:23 -0000
Received: (qmail 25787 invoked from network); 7 Jun 2016 11:55:22 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:55:17 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296657>

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
