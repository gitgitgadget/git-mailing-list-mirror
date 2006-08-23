From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 7/7] n is in fact unused, and is later shadowed.
Date: Wed, 23 Aug 2006 12:39:16 +0200
Message-ID: <1156329557613-git-send-email-madcoder@debian.org>
References: 200608231238.10963.madcoder@debian.org <11563295562072-git-send-email-madcoder@debian.org> <11563295562422-git-send-email-madcoder@debian.org> <1156329556788-git-send-email-madcoder@debian.org> <11563295573215-git-send-email-madcoder@debian.org> <11563295573035-git-send-email-madcoder@debian.org> <1156329557424-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 12:41:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFq8u-0007Mz-CK
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 12:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWHWKjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 06:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWHWKjW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 06:39:22 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:15498 "EHLO mx2.intersec.fr")
	by vger.kernel.org with ESMTP id S964834AbWHWKjV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 06:39:21 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id 733F4D829C;
	Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id 21074409C2; Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g4caa
In-Reply-To: <1156329557424-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25913>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 date.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/date.c b/date.c
index 66be23a..63d1d5b 100644
--- a/date.c
+++ b/date.c
@@ -584,10 +584,9 @@ static const char *approxidate_alpha(con
 	const struct typelen *tl;
 	const struct special *s;
 	const char *end = date;
-	int n = 1, i;
+	int i;
 
-	while (isalpha(*++end))
-		n++;
+	while (isalpha(*++end));
 
 	for (i = 0; i < 12; i++) {
 		int match = match_string(date, month_names[i]);
-- 
1.4.1.1
