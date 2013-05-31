From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH] git.txt: remove stale comment regarding GIT_WORK_TREE
Date: Thu, 30 May 2013 20:11:41 -0500
Message-ID: <1369962701-13820-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 03:13:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiDu9-0003kd-1Q
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 03:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab3EaBNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 21:13:14 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34091 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab3EaBNM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 21:13:12 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so2333507iec.5
        for <git@vger.kernel.org>; Thu, 30 May 2013 18:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=dcNbSMt0tJrTJo0hDxWjO83PmPqWBoV4y7NldbSTp4U=;
        b=H/gXn/QGYHnvVGc8gz3x/t1YIudpZvmcm5Ql0WEhsBSqxg8CxrzbqPTfktGoPVW7nm
         l4lGZFn2OIwqFKuQOIqbgnYSDTA0wT4qL50fBypOGeFm6bqs82HBwT7stwe3xuuswrnD
         rqtLeBjycE6MEyUF8qDIdGlqpkE3hsw6sFspNYxLym6NzlLBnyEGa3khfOrQXrfmtYoV
         AIo/EcUDain7XBltRw/MPAecl0G1RA84myTdGoD8nmVuVESu/EV5gqvv4MnqD1z2P2Da
         gV8vzC8oLC4ia/gsxpdugF2RywxPhmKnCL8IShxBJ2A7rJgC6zkyBoGf9vpbEL8GYp7O
         Nztg==
X-Received: by 10.50.7.36 with SMTP id g4mr610812iga.64.1369962792022;
        Thu, 30 May 2013 18:13:12 -0700 (PDT)
Received: from marlin.localdomain (adsl-70-131-101-82.dsl.emhril.sbcglobal.net. [70.131.101.82])
        by mx.google.com with ESMTPSA id gz1sm1115471igb.5.2013.05.30.18.13.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 18:13:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.450.gf3f2a46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226042>

Official support for specifying --work-tree/GIT_WORK_TREE without
--git-dir/GIT_DIR was added with v1.7.4-rc3~2^2~2.  Update description
of GIT_WORK_TREE to reflect this.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---

Commit ea472c1 made most of the relevant updates.  Noticed this while
troubleshooting a script that failed when using an old version of Git.

Chris

 Documentation/git.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 68f1ee6..54b87d9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -682,9 +682,7 @@ Git so take care if using Cogito etc.
 	The '--git-dir' command-line option also sets this value.
 
 'GIT_WORK_TREE'::
-	Set the path to the working tree.  The value will not be
-	used in combination with repositories found automatically in
-	a .git directory (i.e. $GIT_DIR is not set).
+	Set the path to the root of the working tree.
 	This can also be controlled by the '--work-tree' command line
 	option and the core.worktree configuration variable.
 
-- 
1.8.3.450.gf3f2a46
