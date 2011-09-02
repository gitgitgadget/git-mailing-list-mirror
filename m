From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] Clarify that '--tags' fetches tags only
Date: Fri,  2 Sep 2011 14:04:46 -0700
Message-ID: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 23:05:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzavR-00069P-PZ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 23:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913Ab1IBVFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 17:05:16 -0400
Received: from smtp-out.google.com ([74.125.121.67]:16255 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787Ab1IBVFP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 17:05:15 -0400
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com [172.25.149.11])
	by smtp-out.google.com with ESMTP id p82L5DEf016214;
	Fri, 2 Sep 2011 14:05:13 -0700
Received: from anatol.mtv.corp.google.com (anatol.mtv.corp.google.com [172.18.102.63])
	by hpaq11.eem.corp.google.com with ESMTP id p82L5CDr025413;
	Fri, 2 Sep 2011 14:05:12 -0700
Received: by anatol.mtv.corp.google.com (Postfix, from userid 67983)
	id D0D911E4161; Fri,  2 Sep 2011 14:05:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.72.g4b5ea.dirty
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180636>

---
 Documentation/fetch-options.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 39d326a..37d2316 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -63,7 +63,8 @@ ifndef::git-pull[]
 	flag lets all tags and their associated objects be
 	downloaded. The default behavior for a remote may be
 	specified with the remote.<name>.tagopt setting. See
-	linkgit:git-config[1].
+	linkgit:git-config[1]. Note that if this option is specified
+	then only tags are fetched, refs under refs/heads/* stay unchanged.
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
-- 
1.7.7.rc0.72.g4b5ea.dirty
