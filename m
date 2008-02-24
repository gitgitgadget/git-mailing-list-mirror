From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] builtin-for-each-ref.c: fix typo in error message
Date: Mon, 25 Feb 2008 00:16:04 +0100
Message-ID: <200802250016.04649.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 00:08:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTPx4-00087G-Jv
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 00:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbYBXXHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 18:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYBXXHE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 18:07:04 -0500
Received: from smtp.katamail.com ([62.149.157.154]:49126 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750858AbYBXXHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 18:07:03 -0500
Received: (qmail 32625 invoked by uid 89); 24 Feb 2008 23:06:47 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host227-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.227)
  by smtp2-pc with SMTP; 24 Feb 2008 23:06:44 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74975>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-for-each-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index f36a43c..07d9c57 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -165,7 +165,7 @@ static int verify_format(const char *format)
 	for (cp = format; *cp && (sp = find_next(cp)); ) {
 		const char *ep = strchr(sp, ')');
 		if (!ep)
-			return error("malformatted format string %s", sp);
+			return error("malformed format string %s", sp);
 		/* sp points at "%(" and ep points at the closing ")" */
 		parse_atom(sp + 2, ep);
 		cp = ep + 1;
-- 
1.5.4.2
