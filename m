From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 10/39] i18n: rebase: mark placeholder for translation
Date: Wed,  1 Jun 2016 16:41:00 +0000
Message-ID: <1464799289-7639-11-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:45:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89Gu-0005vB-Pk
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbcFAQou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:44:50 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:46419 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755104AbcFAQnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:43:23 -0400
Received: (qmail 10883 invoked from network); 1 Jun 2016 16:43:16 -0000
Received: (qmail 12225 invoked from network); 1 Jun 2016 16:43:16 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:43:11 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296126>

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
2.7.3
