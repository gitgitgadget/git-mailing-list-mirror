From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH] remove superflous "const"
Date: Sun, 21 May 2006 22:45:46 +0200
Message-ID: <20060521204545.GA18749@limbo.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 22:47:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhupA-00070F-Mo
	for gcvg-git@gmane.org; Sun, 21 May 2006 22:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWEUUqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 16:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWEUUqk
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 16:46:40 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:20454 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751422AbWEUUqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 16:46:40 -0400
Received: from fwd34.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1Fhuot-0000l5-00; Sun, 21 May 2006 22:46:35 +0200
Received: from tigra.home (GEVgVUZVYegdL4JM0HBjsdNEA4kCHDB7yXv9AYHgSkjtyq-+ix9rcv@[84.160.115.180]) by fwd34.sul.t-online.de
	with esmtp id 1Fhuon-25qerQ0; Sun, 21 May 2006 22:46:29 +0200
Received: from limbo.home (unknown [192.168.1.26])
	by tigra.home (Postfix) with ESMTP id 9C4D8277B5;
	Sun, 21 May 2006 22:46:28 +0200 (CEST)
Received: by limbo.home (Postfix, from userid 1000)
	id A8A8CEC445; Sun, 21 May 2006 22:45:46 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: GEVgVUZVYegdL4JM0HBjsdNEA4kCHDB7yXv9AYHgSkjtyq-+ix9rcv
X-TOI-MSGID: 05a489ab-3048-4701-86d9-3407026783e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20460>

---

Someone probably forgot to clean it up.

8eecc10b942df988c2b6ea1141636f9674094b76
 builtin-grep.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8eecc10b942df988c2b6ea1141636f9674094b76
diff --git a/builtin-grep.c b/builtin-grep.c
index d09ddf0..53de8a8 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -518,7 +518,7 @@ static int external_grep(struct grep_opt
 	argc = nr;
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
-		const char *name;
+		char *name;
 		if (ce_stage(ce) || !S_ISREG(ntohl(ce->ce_mode)))
 			continue;
 		if (!pathspec_matches(paths, ce->name))
-- 
1.3.3.g58b5b
