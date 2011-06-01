From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/3] Fix typo: existant->existent
Date: Thu,  2 Jun 2011 04:27:57 +0600
Message-ID: <1306967278-1971-2-git-send-email-divanorama@gmail.com>
References: <1306967278-1971-1-git-send-email-divanorama@gmail.com>
Cc: Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 00:28:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRtto-0003FM-Vo
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758651Ab1FAW2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:28:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62533 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758627Ab1FAW2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:28:09 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so448770bwz.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=9yCponOJMxF3XwxB7yQsV7ayCnsdbXNzxfsnJeROPBc=;
        b=v8aF9NiKPTIzPlaqr/QECo+Y2lusf+VGDB0bkA/4rBV/cjNGHxGuCFPRvxBSNQOlaX
         n7p7SeahLAc277oaP1/QzM3n2djdFLIigk1DDbXE3g1ocJts3xAJCCjvGvUHEJBsKWMO
         vjU/tWY2kTTsgjVNSpNsn4hVkSxv835EtVGTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s0tAbkAxeDJpcrCSI5aWZqy368ZilEe6zpDPen+ZHECaT8SE9KESYkUmnqOhSeXbVO
         Qo0szrgvn2sOCwZojTnrcK5L8v5IHfCmeP356Peb6AxQ7v0Qjlu7qujF0tNvp9YCmz93
         zbmXHh5dGnXtFYmRiC3AayQwd7apnERB7bWTw=
Received: by 10.204.32.65 with SMTP id b1mr26292bkd.73.1306967288823;
        Wed, 01 Jun 2011 15:28:08 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm5071bkc.19.2011.06.01.15.28.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 15:28:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1306967278-1971-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174911>

Fix this typo in a comment.
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
