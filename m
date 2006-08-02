From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] use declarations from builtin.h for builtin commands
Date: Wed,  2 Aug 2006 23:52:00 +0200
Message-ID: <1154555520792-git-send-email-matthias@spinlock.ch>
References: <11545555203975-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
X-From: git-owner@vger.kernel.org Wed Aug 02 23:52:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Odi-0006oh-6l
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 23:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWHBVwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 17:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWHBVwZ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 17:52:25 -0400
Received: from mail15.bluewin.ch ([195.186.18.63]:42670 "EHLO
	mail15.bluewin.ch") by vger.kernel.org with ESMTP id S932245AbWHBVwZ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 17:52:25 -0400
Received: from spinlock.ch (81.62.57.222) by mail15.bluewin.ch (Bluewin 7.3.110.2)
        id 4492529600B13342; Wed, 2 Aug 2006 21:52:21 +0000
Received: (nullmailer pid 19136 invoked by uid 1000);
	Wed, 02 Aug 2006 21:52:00 -0000
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2.rc2.g93b2c
In-Reply-To: <11545555203975-git-send-email-matthias@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24692>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 builtin-fmt-merge-msg.c |    3 ++-
 builtin-prune-packed.c  |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index c84224e..485ede7 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "commit.h"
 #include "diff.h"
@@ -242,7 +243,7 @@ static void shortlog(const char *name, u
 	free_list(&subjects);
 }
 
-int cmd_fmt_merge_msg(int argc, char **argv, const char *prefix)
+int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
 	int limit = 20, i = 0;
 	char line[1024];
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index d0ff336..d3dd94d 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 
 static const char prune_packed_usage[] =
@@ -54,7 +55,7 @@ static void prune_packed_objects(void)
 	}
 }
 
-int cmd_prune_packed(int argc, char **argv, const char *prefix)
+int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
 	int i;
 
-- 
1.4.2.rc2.g93b2c
