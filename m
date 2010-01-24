From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [PATCH] git-gui: use different icon for new and modified files in the index
Date: Sun, 24 Jan 2010 19:54:19 +0100
Organization: 
Message-ID: <201001241954.19626.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 24 19:55:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ7co-0000Op-NY
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 19:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab0AXSzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 13:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470Ab0AXSzu
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 13:55:50 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:37333 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752273Ab0AXSzr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2010 13:55:47 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id 0C9AB1AF7FE;
	Sun, 24 Jan 2010 19:55:46 +0100 (CET)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 0467A2D2AAC;
	Sun, 24 Jan 2010 19:55:46 +0100 (CET)
Received: from oberndorfer.lan (91-113-125-234.adsl.highway.telekom.at [91.113.125.234])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-05.arcor-online.net (Postfix) with ESMTPSA id C0ADD332A38;
	Sun, 24 Jan 2010 19:55:45 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-05.arcor-online.net C0ADD332A38
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1264359345; bh=Cc/6g9bwa5xIvbWZN5rdwBDex7tjsjZmQ7xd6FMKfU8=;
	h=From:Date:Subject:To:Cc:MIME-Version:Message-Id:
	 Content-Transfer-Encoding;
	b=SvW9OW/E/erUVebGiz7dLf/0fUMuN9T5VyvbBNS5fcCrrsaKXQM7LFZCFZkhL8S12
	 VVxpAjnxESKp1TS1TvP6Z4n1t3aJQtMc/xNIcsIlhKcE3n3RojBk1aWCYqQDr+ShSG
	 MjqNq1074J30DXF/XJGesPoOALsFp1KD6mCdWcLY=
X-Mailbox-Line: From 3dbeaed93fc31dd61ee474106a6d48e1e11f9386 Mon Sep 17 00:00:00 2001
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137909>

This allows to quickly differentiate between new and modified files
in the index without selecting the file and looking at the diff.

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---

At work i often use git add '*_en.properties' and after that i like to check
which files are new and which ones where changed.

I hope this is useful for somebody else too.

While creating the patch i found out that file_parttick seems to be unused.

 git-gui/git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 718277a..880252d 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1844,7 +1844,7 @@ set ui_index .vpane.files.index.list
 set ui_workdir .vpane.files.workdir.list
 
 set all_icons(_$ui_index)   file_plain
-set all_icons(A$ui_index)   file_fulltick
+set all_icons(A$ui_index)   file_plain
 set all_icons(M$ui_index)   file_fulltick
 set all_icons(D$ui_index)   file_removed
 set all_icons(U$ui_index)   file_merge
-- 
1.6.6.1
