From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 11/13] Add missing guides to list and regenerate
Date: Sat, 23 Feb 2013 23:05:59 +0000
Message-ID: <1361660761-1932-12-git-send-email-philipoakley@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:07:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9OBB-0005xi-PP
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 00:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759051Ab3BWXG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 18:06:29 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:26254 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758649Ab3BWXG3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 18:06:29 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EABtLKVFZ8rke/2dsb2JhbABFwVGBCBdzgiABBVYzCEk5HgYTiBe+fo8Vg0ADpyKDBw
X-IronPort-AV: E=Sophos;i="4.84,724,1355097600"; 
   d="scan'208";a="63627249"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 23 Feb 2013 23:06:05 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216935>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 common-guides.h |  3 +++
 guide-list.txt  | 17 +++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/common-guides.h b/common-guides.h
index a8ad8d1..ae57d75 100644
--- a/common-guides.h
+++ b/common-guides.h
@@ -3,10 +3,13 @@
 
 static struct cmdname_help common_guides[] = {
   {"attributes", "defining attributes per path"},
+  {"everyday", "Everyday GIT With 20 Commands Or So"},
   {"glossary", "A GIT Glossary"},
   {"ignore", "Specifies intentionally untracked files to ignore"},
   {"modules", "defining submodule properties"},
+  {"repository-layout", "Git Repository Layout"},
   {"revisions", "specifying revisions and ranges for git"},
   {"tutorial", "A tutorial introduction to git (for version 1.5.1 or newer)"},
+  {"user-manual", "Git User's Manual (for version 1.5.3 or newer)"},
   {"workflows", "An overview of recommended workflows with git"},
 };
diff --git a/guide-list.txt b/guide-list.txt
index a419ac4..9ba1b5b 100644
--- a/guide-list.txt
+++ b/guide-list.txt
@@ -10,7 +10,7 @@ githooks                                specialist
 gitignore                               concept	 guide
 gitmodules                              concept	 guide
 gitnamespaces                           specialist
-#gitrepository-layout                    reference guide
+gitrepository-layout                    reference guide
 gitrevisions                            concept	 guide
 gittutorial                             user	 guide
 gittutorial-2                           user
@@ -18,12 +18,13 @@ gitweb.conf                             specialist
 gitweb                                  specialist
 gitworkflows                            user	 guide
 
-#giteveryday                             user	 guide
-#gituser-manual                          user	 guide
+giteveryday                             user	 guide
+gituser-manual                          user	 guide
 
-# could embed inside common-cmds.h with [guide] as the second thing,
-# making the sed's in generate-cmdlist.sh more obvious
-# but drop the dash in 's/^git-\
+# Could embed inside common-cmds.h and move generate-guidelist.sh
+# into generate-cmdlist.sh 
 
-#gitrepository-layout is too long for the current char[16]
-#
+# Could also extend generate-guidelist.sh to create a second, complete
+# list of guides should -gg option be applied twice (It's a countup option)
+
+# use './generate-guidelist.sh >common-guides.h' to re-generate.
-- 
1.8.1.msysgit.1
