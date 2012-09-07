From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH] Document MKDIR_WO_TRAILING_SLASH in Makefile
Date: Fri, 7 Sep 2012 14:10:49 +0200
Message-ID: <003301cd8cf1$d26258c0$77270a40$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:11:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9xOu-00043U-MT
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 14:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760531Ab2IGMLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 08:11:00 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:62132 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760505Ab2IGMLA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 08:11:00 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Lql1O-1TnzF20neU-00eIcL; Fri, 07 Sep 2012 14:10:58 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2M8c4xykRNLMNkT1esBmGfIQgF0A==
Content-Language: de
X-Provags-ID: V02:K0:9wyHvJLgjeIeXeJSykHCQapaXjyRXn5gFY+pJBvaTyS
 TNZEBcS7GIaXqr084qhyFTPpIWrpSo2Tr8SELLILL9CGwWyUJ4
 50ur/b2AUThleZoPSFYxd27T0SsoaQGJXRjnBv/HMzYz0mMcyD
 pRk866PGhgLC4Tk5rRw1KnBeIM1ICIymgH9gD2hT5z3uERFSSr
 bqbgWovcAHNLHiamCqrT151CuJ4XrmgGcan3a0mgFaQTuyqIcY
 err1TyITul3Cx1oTGWx1A4aYPcdcGSbVDMHo/IepDJSxqQ0KRU
 8xco7dRVeRqsX7bFZwYElRsphq1f+R2Htsf+N10dMOGb23ZAIZ
 plTw3nOfatTv7q7nGn/u6HfbIm5/3xhH/GIilz3hE2e9il7ppr
 jPPqd1kaF3VnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204959>


Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index ac49320..03e245a 100644
--- a/Makefile
+++ b/Makefile
@@ -90,6 +90,8 @@ all::
 #
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 #
+# Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
+#
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 #
 # Define NO_STRTOK_R if you don't have strtok_r in the C library.
-- 
1.7.12
