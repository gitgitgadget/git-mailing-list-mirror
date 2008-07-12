From: Stephan Beyer <s-beyer@gmx.net>
Subject: [SQUASH PATCH] t9001: Use "test_must_fail git" instead of "! git"
Date: Sat, 12 Jul 2008 23:30:29 +0200
Message-ID: <1215898229-21363-1-git-send-email-s-beyer@gmx.net>
References: <1215877672-17049-2-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 23:32:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHmhC-0004oa-Eg
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 23:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbYGLVag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 17:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbYGLVag
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 17:30:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:50800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752768AbYGLVaf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 17:30:35 -0400
Received: (qmail invoked by alias); 12 Jul 2008 21:30:33 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp025) with SMTP; 12 Jul 2008 23:30:33 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18Pa6tqbGMPL/G+zFk+QtefD0K+TPl7MyUJV69trX
	oGuBFHspSyQEcG
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHmfl-0005Yx-UT; Sat, 12 Jul 2008 23:30:29 +0200
X-Mailer: git-send-email 1.5.6.2.303.g79662
In-Reply-To: <1215877672-17049-2-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88265>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

This one was mysteriously *g* excluded from the last patch :(
Junio, if you apply, can you squash this?

Sorry,
  Stephan

 t/t9001-send-email.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 3e4eb63..de5b980 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -91,7 +91,7 @@ test_expect_success 'reject long lines' '
 	clean_fake_sendmail &&
 	cp $patches longline.patch &&
 	echo $z512$z512 >>longline.patch &&
-	! git send-email \
+	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
-- 
1.5.6.2.303.g79662
