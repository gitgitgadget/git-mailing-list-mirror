From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH 2/6] t4012: Unquote git command fragment in test title
Date: Thu, 12 Jul 2012 00:12:21 +0200
Message-ID: <20120711221221.GA21329@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 00:12:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp597-0003ov-IE
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 00:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933357Ab2GKWM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 18:12:28 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:42451 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932203Ab2GKWM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 18:12:27 -0400
Received: (qmail invoked by alias); 11 Jul 2012 22:12:24 -0000
Received: from p5B06F836.dip.t-dialin.net (EHLO gmx.net) [91.6.248.54]
  by mail.gmx.net (mp033) with SMTP; 12 Jul 2012 00:12:24 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX1+KnlRRx/yK7qaD0qAS4U4UYv+dfpD1p6wTBbAtHa
	LwxSE39mZfMKvs
Received: by gmx.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 00:12:21 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201336>

The command fragments are quoted nowhere else in title texts of
this file, thus make this one consistent with all other titles.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
---
 t/t4012-diff-binary.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 2a8b68e..3c54269 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -31,7 +31,7 @@ cat > expected <<\EOF
  d |  Bin
  4 files changed, 2 insertions(+), 2 deletions(-)
 EOF
-test_expect_success '"apply --stat" output for binary file change' '
+test_expect_success 'apply --stat output for binary file change' '
 	git diff >diff &&
 	git apply --stat --summary <diff >current &&
 	test_i18ncmp expected current
-- 
1.7.10.2.552.gaa3bb87
