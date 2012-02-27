From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] git-p4: missing she-bang line in t9804 confuses prove
Date: Mon, 27 Feb 2012 18:40:14 +0100
Message-ID: <1330364414-29332-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 27 18:40:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S24Yr-0007aw-JE
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 18:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690Ab2B0Rk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 12:40:29 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55269 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519Ab2B0Rk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 12:40:28 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S24Yk-0007jI-Sb; Mon, 27 Feb 2012 18:40:27 +0100
X-Mailer: git-send-email 1.7.9.2.396.ga883d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191633>

Without the magic line, prove shows lots and lots of errors:
% prove ./t9804-git-p4-label.sh
=2E/t9804-git-p4-label.sh .. syntax error at ./t9804-git-p4-label.sh li=
ne 3, near ". ."
=2E..

When #!/bin/sh is added, tests are skipped (I have no p4d).

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t9804-git-p4-label.sh |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
index 80d01ea..a9e04ef 100755
--- a/t/t9804-git-p4-label.sh
+++ b/t/t9804-git-p4-label.sh
@@ -1,3 +1,5 @@
+#!/bin/sh
+
 test_description=3D'git-p4 p4 label tests'
=20
 . ./lib-git-p4.sh
--=20
1.7.9.2.396.ga883d.dirty
