From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] read-cache.c: Slight parameter name improvement.
Date: Tue, 4 Apr 2006 17:42:51 +0200
Message-ID: <20060404154251.GA19410@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 04 17:42:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQngG-0004G8-TB
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 17:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWDDPmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 11:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWDDPmx
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 11:42:53 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:25781 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1750716AbWDDPmx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 11:42:53 -0400
Received: (qmail 19737 invoked by uid 5842); 4 Apr 2006 17:42:51 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18394>

From: Peter Eriksen <s022018@student.dtu.dk>
Date: Tue Apr 4 17:40:02 2006 +0200
Subject: [PATCH] read-cache.c: Slight parameter name improvement.

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

 read-cache.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

dde622db1412a556b216eceff4a9a677b41568c3
diff --git a/read-cache.c b/read-cache.c
index f97f92d..2e8fdc5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -257,7 +257,7 @@ int cache_name_compare(const char *name1
 	return 0;
 }
 
-int cache_name_pos(const char *name, int namelen)
+int cache_name_pos(const char *name, int flags)
 {
 	int first, last;
 
@@ -266,7 +266,7 @@ int cache_name_pos(const char *name, int
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct cache_entry *ce = active_cache[next];
-		int cmp = cache_name_compare(name, namelen, ce->name, ntohs(ce->ce_flags));
+		int cmp = cache_name_compare(name, flags, ce->name, ntohs(ce->ce_flags));
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
-- 
1.3.0.rc1.gfc99-dirty
