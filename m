From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Show URL in the "Getting <foo> list" http-fetch messages
Date: Sat, 12 Nov 2005 01:49:59 +0100
Message-ID: <20051112004958.21857.95728.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 01:51:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eajaq-0003mP-97
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 01:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVKLAuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 19:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVKLAuE
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 19:50:04 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50658 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750821AbVKLAuC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 19:50:02 -0500
Received: (qmail 21875 invoked from network); 12 Nov 2005 01:49:59 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 12 Nov 2005 01:49:59 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11653>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 http-fetch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index e7655d1..e6e7df6 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -795,7 +795,7 @@ static int fetch_alternates(char *base)
 	buffer.buffer = data;
 
 	if (get_verbosely)
-		fprintf(stderr, "Getting alternates list\n");
+		fprintf(stderr, "Getting alternates list for %s\n", base);
 	
 	url = xmalloc(strlen(base) + 31);
 	sprintf(url, "%s/objects/info/http-alternates", base);
@@ -918,7 +918,7 @@ static int fetch_indices(struct alt_base
 	buffer.buffer = data;
 
 	if (get_verbosely)
-		fprintf(stderr, "Getting pack list\n");
+		fprintf(stderr, "Getting pack list for %s\n", repo->base);
 	
 	url = xmalloc(strlen(repo->base) + 21);
 	sprintf(url, "%s/objects/info/packs", repo->base);
