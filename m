From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 3/3] rename SHA1_FILE_DIRECTORY
Date: Tue, 19 Apr 2005 21:32:06 -0700
Message-ID: <mailbox-1370-1113971526-299194@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:29:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO6pR-0007ZK-Va
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVDTEcz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVDTEcz
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:32:55 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:23951 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261368AbVDTEcN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 00:32:13 -0400
Received: (qmail 1387 invoked by uid 5006); 19 Apr 2005 21:32:12 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-1370-1113971526-282751@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch applies on top of:
        [PATCH 1/3] add GIT_CACHE_DIRECTORY support
        [PATCH 2/3] rename object directory symbols

 cache.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Signed-Off-By: Zach Welch <zw@superlucidity.net>

Rename SHA1_FILE_DIRECTORY to GIT_OBJECT_DIRECTORY.  Scripts that
used to pass this setting will need to be updated.

cache.h: 218bec12fab3fb57ad03fafccedd4398c64c3646
--- a/cache.h
+++ b/cache.h
@@ -84,7 +84,7 @@ unsigned int active_nr, active_alloc;
 #define GIT_CACHE_ENVIRONMENT "GIT_CACHE_DIRECTORY"
 #define DEFAULT_GIT_CACHE_ENVIRONMENT ".git"
 
-#define GIT_OBJECT_ENVIRONMENT "SHA1_FILE_DIRECTORY"
+#define GIT_OBJECT_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define DEFAULT_GIT_OBJECT_ENVIRONMENT ".git/objects"
 
 #define alloc_nr(x) (((x)+16)*3/2)
