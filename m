From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 5/7] missing #define DEBUG 0 that made the preprocessor whine
Date: Wed, 23 Aug 2006 12:39:14 +0200
Message-ID: <11563295573035-git-send-email-madcoder@debian.org>
References: 200608231238.10963.madcoder@debian.org <11563295562072-git-send-email-madcoder@debian.org> <11563295562422-git-send-email-madcoder@debian.org> <1156329556788-git-send-email-madcoder@debian.org> <11563295573215-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 12:41:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFq9C-0007TY-B2
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 12:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWHWKja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 06:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWHWKj2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 06:39:28 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:12456 "EHLO mx2.intersec.fr")
	by vger.kernel.org with ESMTP id S964828AbWHWKjU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 06:39:20 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id 47494D8242;
	Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id 13F7E409C0; Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g4caa
In-Reply-To: <11563295573215-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25915>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-grep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 0bd517b..3123494 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -14,6 +14,8 @@ #include <regex.h>
 #include <fnmatch.h>
 #include <sys/wait.h>
 
+#define DEBUG 0
+
 /*
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
  * pathname wildcards are allowed.
-- 
1.4.1.1
