From: =?UTF-8?q?Christof=20Kr=C3=BCger?= <git@christof-krueger.de>
Subject: [PATCH] Documentation: git diff --check respects core.whitespace
Date: Wed, 22 Jun 2011 17:33:02 +0200
Message-ID: <1308756782-30241-1-git-send-email-git@christof-krueger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Christof=20Kr=C3=BCger?= <git@christof-krueger.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 22 17:33:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZPQk-0004ht-Q8
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 17:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246Ab1FVPdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jun 2011 11:33:21 -0400
Received: from vserver.localhost.li ([85.214.46.152]:50702 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab1FVPdU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2011 11:33:20 -0400
Received: from p5794c765.dip.t-dialin.net ([87.148.199.101]:41052 helo=oxylap)
	by mail.localhost.li with esmtpa (Exim 4.69)
	(envelope-from <oxygene@localhost.li>)
	id 1QZPQY-0005BL-4N; Wed, 22 Jun 2011 17:33:15 +0200
Received: by oxylap (Postfix, from userid 1000)
	id 50A72DC14D7; Wed, 22 Jun 2011 17:33:13 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.rc2
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176247>

=46ix documentation on "git diff --check" by adopting the description f=
rom
"git apply --whitespace".

Signed-off-by: Christof Kr=C3=BCger <git@christof-krueger.de>
---
 Documentation/diff-options.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index c7ed946..24f189f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -224,10 +224,14 @@ endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
 --check::
-	Warn if changes introduce trailing whitespace
-	or an indent that uses a space before a tab. Exits with
-	non-zero status if problems are found. Not compatible with
-	--exit-code.
+	Warn if changes introduce whitespace errors.  What are
+	considered whitespace errors is controlled by `core.whitespace`
+	configuration.  By default, trailing whitespaces (including
+	lines that solely consist of whitespaces) and a space character
+	that is immediately followed by a tab character inside the
+	initial indent of the line are considered whitespace errors.
+	Exits with non-zero status if problems are found. Not compatible
+	with --exit-code.
 endif::git-format-patch[]
=20
 --full-index::
--=20
1.7.6.rc2
