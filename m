From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH] Fix typo: existant->existent
Date: Thu, 16 Jun 2011 18:22:39 +0600
Message-ID: <1308226959-10659-1-git-send-email-divanorama@gmail.com>
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 14:22:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXBaf-0005JT-8t
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 14:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757829Ab1FPMWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 08:22:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61511 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757736Ab1FPMWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 08:22:20 -0400
Received: by bwz15 with SMTP id 15so1194097bwz.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=He3E0KXMq9n0g97zOpFHWf9fmZY9ShQuohbd38Dl37s=;
        b=DHOR6HTwKgqtbokgurgPWFWSYbKgVKNH+5Bw+EwOrAr0YQi6t7HccNtt84iRYenewX
         r4LVMq4dDSmge4hnFucTao2g9YOEgi61In8UpgUge3aicLxEZ1CAG+Ca0g5+uKVzZfMU
         w+C6KK/N+OoMFOxRMsZoM6avEpLQrOz8OVWqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cPzldJ9Gl+Egl1PO3UO+3pt7sXz5e9mAQe20Bw1QTe5nduVBvNwHt9eJIplPHSZuML
         dFGMihhj5cMlOO1SSOpN7ktio3htNX+nXxY4EASOwTYWZ0rP8i54+s+JK4fj3DorZJKT
         c71c6XeJ9zz4bO9V00FkxnwIpKRRwWmoBXEXs=
Received: by 10.204.61.197 with SMTP id u5mr561034bkh.210.1308226939311;
        Thu, 16 Jun 2011 05:22:19 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id ek1sm1166275bkb.9.2011.06.16.05.22.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 05:22:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175894>

This typo was discovered in core git sources.
Clean in it up in git-gui too.
There is just one occurence in a comment line.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 git-gui/git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index fd6a43d..49efcee 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1526,7 +1526,7 @@ proc run_prepare_commit_msg_hook {} {
 
 	# prepare-commit-msg requires PREPARE_COMMIT_MSG exist.  From git-gui
 	# it will be .git/MERGE_MSG (merge), .git/SQUASH_MSG (squash), or an
-	# empty file but existant file.
+	# empty file but existent file.
 
 	set fd_pcm [open [gitdir PREPARE_COMMIT_MSG] a]
 
-- 
1.7.3.4
