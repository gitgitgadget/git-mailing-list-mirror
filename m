From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] git-svn: clarify documentation of dcommit sub-command
Date: Mon,  7 May 2012 19:18:47 +0530
Message-ID: <1336398527-4363-1-git-send-email-jon.seymour@gmail.com>
Cc: trast@student.ethz.ch, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 15:49:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SROJF-0001Pz-Ik
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 15:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533Ab2EGNtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 09:49:00 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51381 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab2EGNs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 09:48:59 -0400
Received: by pbbrp8 with SMTP id rp8so6696757pbb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=V6zQU+d6F5jbsV3ypcTTBh+yGUt9izdi8m3g6xz99d0=;
        b=kYIwR8RQWhvR9ck+FarkiN2bG5MQQmWfX+xPInnZdDyvvwDRlahSnk7+XGtyaHMAC5
         R3zk7EwFxsDpv+tbIAPtIeACTfDly2M7D/RnA/VFhIvYJzDCRUfoteW1FI5+2R4ervjb
         FESA+D6KrUjYcuq7W56yPSv3I84TtF//Sv5Sw4Acb5KvlfqZB0AwQRKWlKbiAUgNniqw
         R227ZuRZa88Xr7wiys0vXEDE7GWG3AGkOer3GC0JhJGYfEPmof2WabDswso9J+Fv/D9N
         Mx8eLc7d+fCJaLA6E9ehlEKmanJYuYBWHwgiYudI2XNQSS9ZZ9OnAwHQC4xhRQgdK7xV
         CJMA==
Received: by 10.68.204.227 with SMTP id lb3mr44314581pbc.92.1336398539401;
        Mon, 07 May 2012 06:48:59 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([122.166.39.99])
        by mx.google.com with ESMTPS id kd6sm8917633pbc.24.2012.05.07.06.48.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 06:48:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.264.g3fbfe6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197272>

Clarify that the optional "revision or branch" argument on dcommit sub-command refers to a
git branch not an SVN branch.

If the user's intent is to commit the current series of commits onto a specific SVN branch
rather than the trunk, the existing wording might lead them to believe that the optional
argument may be a means to achieve this.

The rewording clarifies that the optional argument actually refers to the source git
branch, not the target svn branch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-svn.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 34ee785..c516283 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -197,7 +197,7 @@ and have no uncommitted changes.
 	pull or merge) your commits against the latest changes in the
 	SVN repository.
 	An optional revision or branch argument may be specified, and
-	causes 'git svn' to do all work on that revision/branch
+	causes 'git svn' to do all work on that git revision/branch
 	instead of HEAD.
 	This is advantageous over 'set-tree' (below) because it produces
 	cleaner, more linear history.
-- 
1.7.9.264.g3fbfe6
