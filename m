From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2 02/22] i18n: advice: mark string about detached head for translation
Date: Mon, 23 May 2016 19:27:21 +0000
Message-ID: <1464031661-18988-3-git-send-email-vascomalmeida@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:29:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vXW-0001WO-9y
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbcEWT3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:29:17 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:56274 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752974AbcEWT3R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:29:17 -0400
Received: (qmail 24451 invoked from network); 23 May 2016 19:29:13 -0000
Received: (qmail 30950 invoked from network); 23 May 2016 19:29:13 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 23 May 2016 19:29:09 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295357>

Mark string with advice seen by the user when in detached head.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 advice.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index 4dc5cf1..703a847 100644
--- a/advice.c
+++ b/advice.c
@@ -107,13 +107,13 @@ void NORETURN die_conclude_merge(void)
 void detach_advice(const char *new_name)
 {
 	const char fmt[] =
-	"Note: checking out '%s'.\n\n"
+	N_("Note: checking out '%s'.\n\n"
 	"You are in 'detached HEAD' state. You can look around, make experimental\n"
 	"changes and commit them, and you can discard any commits you make in this\n"
 	"state without impacting any branches by performing another checkout.\n\n"
 	"If you want to create a new branch to retain commits you create, you may\n"
 	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
-	"  git checkout -b <new-branch-name>\n\n";
+	"  git checkout -b <new-branch-name>\n\n");
 
 	fprintf(stderr, fmt, new_name);
 }
-- 
2.7.3
