From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/7] missing 'static' keywords
Date: Wed, 23 Aug 2006 12:39:12 +0200
Message-ID: <1156329556788-git-send-email-madcoder@debian.org>
References: 200608231238.10963.madcoder@debian.org <11563295562072-git-send-email-madcoder@debian.org> <11563295562422-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 12:39:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFq9B-0007TY-Oj
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 12:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWHWKj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 06:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWHWKj1
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 06:39:27 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:48550 "EHLO mx2.intersec.fr")
	by vger.kernel.org with ESMTP id S964830AbWHWKjU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 06:39:20 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id 31DB5D81BB;
	Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id 066E0409BC; Wed, 23 Aug 2006 12:39:16 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g4caa
In-Reply-To: <11563295562422-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25908>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-tar-tree.c |    2 +-
 http-push.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index e0bcb0a..61a4135 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -275,7 +275,7 @@ static void traverse_tree(struct tree_de
 	}
 }
 
-int git_tar_config(const char *var, const char *value)
+static int git_tar_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "tar.umask")) {
 		if (!strcmp(value, "user")) {
diff --git a/http-push.c b/http-push.c
index 4849779..7d12f69 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1700,7 +1700,7 @@ static int locking_available(void)
 	return lock_flags;
 }
 
-struct object_list **add_one_object(struct object *obj, struct object_list **p)
+static struct object_list **add_one_object(struct object *obj, struct object_list **p)
 {
 	struct object_list *entry = xmalloc(sizeof(struct object_list));
 	entry->item = obj;
-- 
1.4.1.1
