From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 10/38] i18n: rebase: mark placeholder for translation
Date: Tue,  7 Jun 2016 11:52:09 +0000
Message-ID: <1465300357-7557-11-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:54:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFaY-0007Nz-Jq
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbcFGLyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:54:12 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:54015 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753346AbcFGLyK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:54:10 -0400
Received: (qmail 23708 invoked from network); 7 Jun 2016 11:54:08 -0000
Received: (qmail 13559 invoked from network); 7 Jun 2016 11:54:08 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:54:03 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296639>

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
