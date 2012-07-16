From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH v2 2/8] t4012: Unquote git command fragment in test title
Date: Mon, 16 Jul 2012 22:43:39 +0200
Message-ID: <5cc05d1229d56ad1577e1f43524a9f9c57f78325.1342468069.git.eclipse7@gmx.net>
References: <cover.1342468069.git.eclipse7@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 22:48:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqsDU-0005YN-9C
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 22:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864Ab2GPUsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 16:48:23 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:40734 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752799Ab2GPUsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 16:48:22 -0400
Received: (qmail invoked by alias); 16 Jul 2012 20:43:43 -0000
Received: from p5DC37C42.dip.t-dialin.net (EHLO gmx.net) [93.195.124.66]
  by mail.gmx.net (mp071) with SMTP; 16 Jul 2012 22:43:43 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX19+CpFDKsx+Du4wFQgxlIZndVlYKNM7188e+Chq/7
	ytolAdfIo9f4X7
Received: by gmx.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 22:43:39 +0200
Content-Disposition: inline
In-Reply-To: <cover.1342468069.git.eclipse7@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201577>

The command fragments are quoted nowhere else in title texts of
this file, thus make this one consistent with all other titles.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
