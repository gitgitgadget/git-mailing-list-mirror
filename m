From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/4] difftool--helper: Update copyright and remove distracting comments
Date: Sat,  9 Jan 2010 20:02:40 -0800
Message-ID: <1263096163-15743-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 10 05:03:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTp18-000212-PS
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 05:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191Ab0AJECw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 23:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150Ab0AJECw
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 23:02:52 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:44885 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab0AJECw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 23:02:52 -0500
Received: by ywh6 with SMTP id 6so20613351ywh.4
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 20:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Z94HhToidTF5iDkaaAfnDdUhyg2fCHTLhngDg8t/uTc=;
        b=DeBmIZ5dafsmBLSIweY/o+2rXh8e7URlOULCiIuN5rHcoZKNGIoYurItIafLxUC/qB
         /kfxuX3I1e8F3pxWDgaROJIdmVq3QGM+h9QiYor0xs4yp9kAz7yOe2RVd/EMP07i3ztI
         1i7VzuIqpRSwwp6zi38+6XApvmwRXh8zT3oOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=N4mI5l0HePwwUFZZgzrZ1+fuOKzO/frGg0vMT/HFPIZ+7AkVXobDkvcEL6FkmfxWqM
         /3/4YKMhgtQjcRbVf616Uf+istittAzGW/+a1XXBY++uP9gpA9nlCCsGqOZjoS1SEFKq
         fbVQA4yg8VFZTGwnd7eGQtaEMQ68qYZwKJWLg=
Received: by 10.101.133.13 with SMTP id k13mr4748864ann.14.1263096170639;
        Sat, 09 Jan 2010 20:02:50 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 39sm9922123yxd.45.2010.01.09.20.02.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 20:02:49 -0800 (PST)
X-Mailer: git-send-email 1.6.6.4.g20a38b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136551>

Some of the comments in git-difftool--helper are not needed because
the code is sufficiently readable without them.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool--helper.sh |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 57e8e32..1b13808 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -3,9 +3,8 @@
 # This script is typically launched by using the 'git difftool'
 # convenience command.
 #
-# Copyright (c) 2009 David Aguilar
+# Copyright (c) 2009-2010 David Aguilar
 
-# Load common functions from git-mergetool--lib
 TOOL_MODE=diff
 . git-mergetool--lib
 
@@ -20,7 +19,6 @@ should_prompt () {
 	fi
 }
 
-# Sets up shell variables and runs a merge tool
 launch_merge_tool () {
 	# Merged is the filename as it appears in the work tree
 	# Local is the contents of a/filename
@@ -39,7 +37,6 @@ launch_merge_tool () {
 		read ans
 	fi
 
-	# Run the appropriate merge tool command
 	run_merge_tool "$merge_tool"
 }
 
-- 
1.6.6.4.g20a38b.dirty
