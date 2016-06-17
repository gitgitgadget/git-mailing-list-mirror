Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73FA21FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbcFQUZs (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:25:48 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35348 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964849AbcFQUYX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:23 -0400
Received: (qmail 2199 invoked from network); 17 Jun 2016 20:24:17 -0000
Received: (qmail 4666 invoked from network); 17 Jun 2016 20:24:17 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:16 -0000
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
Subject: [PATCH v5 10/38] i18n: rebase: mark placeholder for translation
Date:	Fri, 17 Jun 2016 20:20:59 +0000
Message-Id: <1466194887-18236-11-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark placeholder "<branch>" in git-rebase.sh for translation. The string
containing the named placeholder is passed to shell function
error_on_missing_default_upstream in git-parse-remote.sh which uses it
to display a command hint for the user.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 1fadc04..9ba21ab 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -449,7 +449,7 @@ then
 		then
 			. git-parse-remote
 			error_on_missing_default_upstream "rebase" "rebase" \
-				"against" "git rebase <branch>"
+				"against" "git rebase $(gettext '<branch>')"
 		fi
 
 		test "$fork_point" = auto && fork_point=t
-- 
2.6.6

