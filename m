From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 29/38] i18n: merge: change command option help to lowercase
Date: Tue,  7 Jun 2016 11:52:28 +0000
Message-ID: <1465300357-7557-30-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:56:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFc3-0000Ej-J6
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbcFGLz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:55:56 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:54474 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161146AbcFGLzT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:55:19 -0400
Received: (qmail 25125 invoked from network); 7 Jun 2016 11:55:17 -0000
Received: (qmail 24839 invoked from network); 7 Jun 2016 11:55:17 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:55:12 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296661>

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
2.7.3
