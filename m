From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] Clarify that '--tags' fetches tags only
Date: Wed, 21 Sep 2011 16:52:56 -0700
Message-ID: <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
Cc: computerdruid@gmail.com, Anatol Pomozov <anatol.pomozov@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 22 01:53:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Wbr-0006IZ-Ci
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 01:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975Ab1IUXxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 19:53:19 -0400
Received: from smtp-out.google.com ([216.239.44.51]:30477 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab1IUXxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 19:53:18 -0400
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id p8LNrGpm019889;
	Wed, 21 Sep 2011 16:53:16 -0700
Received: from anatol.mtv.corp.google.com (anatol.mtv.corp.google.com [172.18.102.63])
	by hpaq6.eem.corp.google.com with ESMTP id p8LNrDix000750;
	Wed, 21 Sep 2011 16:53:13 -0700
Received: by anatol.mtv.corp.google.com (Postfix, from userid 67983)
	id F029C1E41FC; Wed, 21 Sep 2011 16:53:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.72.g4b5ea.dirty
In-Reply-To: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181868>

'git fetch --tags' fetches tags only and leaves heads untouched.
Many people are confused by the fact that 'git fetch --tags'
does not fetch heads.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
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
