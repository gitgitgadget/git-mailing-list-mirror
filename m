From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 2/2] t0303: resurrect commit message as test documentation
Date: Mon, 12 Mar 2012 13:05:07 +0100
Message-ID: <1331553907-19576-3-git-send-email-zbyszek@in.waw.pl>
References: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 12 13:06:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7419-00034C-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 13:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab2CLMGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 08:06:17 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55721 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715Ab2CLMGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 08:06:17 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S740v-0005xL-6y; Mon, 12 Mar 2012 13:06:12 +0100
X-Mailer: git-send-email 1.7.9.3.467.g8f1c7
In-Reply-To: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192861>

The commit message which added those tests (861444f 't: add test
harness for external credential helpers' 2011-12-10) provided nice
documentation in the commit message. Let's make it more visible.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t0303-credential-external.sh |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-extern=
al.sh
index f1e0e75..4ab9a54 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -1,5 +1,23 @@
 #!/bin/sh
=20
+# Test harness for external credential helpers
+#
+# This is a tool for authors of external helper tools to sanity-check
+# their helpers. If you have written the "git-credential-foo" helper,
+# you check it with:
+#
+# GIT_TEST_CREDENTIAL_HELPER=3Dfoo make t0303-credential-external.sh
+#
+# This assumes that your helper is capable of both storing and
+# retrieving credentials (some helpers may be read-only, and
+# they will fail these tests).
+#
+# If your helper supports time-based expiration with a
+# configurable timeout, you can test that feature with:
+#
+#  GIT_TEST_CREDENTIAL_HELPER_TIMEOUT=3D"foo --timeout=3D1" \
+#      make t0303-credential-external.sh
+
 test_description=3D'external credential helper tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
--=20
1.7.9.3.467.g8f1c7
