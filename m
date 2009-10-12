From: Vietor Liu <vietor@vxwo.org>
Subject: [PATCH] git-gui: Fixed _main window_ for screen height equal 600 px
Date: Mon, 12 Oct 2009 14:33:14 +0800
Message-ID: <1255329194-2757-1-git-send-email-vietor@vxwo.org>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 08:32:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxESX-0001wI-So
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 08:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbZJLGbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 02:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbZJLGbN
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 02:31:13 -0400
Received: from mail-px0-f111.google.com ([209.85.216.111]:48311 "EHLO
	mail-px0-f111.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbZJLGbM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 02:31:12 -0400
Received: by pxi9 with SMTP id 9so507625pxi.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 23:30:35 -0700 (PDT)
Received: by 10.115.117.4 with SMTP id u4mr9288475wam.43.1255329035612;
        Sun, 11 Oct 2009 23:30:35 -0700 (PDT)
Received: from localhost.localdomain ([123.113.93.118])
        by mx.google.com with ESMTPS id 23sm92829pxi.9.2009.10.11.23.30.33
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 23:30:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129988>

When the screen height equal 600 px(e.g. Asus EeePC 1024x600), The
_main window_ should be hide the _Push button_ and _Status bar_.

Signed-off-by: Vietor Liu <vietor@vxwo.org>
---
 git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 09b2720..037a1f2 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3083,7 +3083,7 @@ frame .vpane.lower.diff.body
 set ui_diff .vpane.lower.diff.body.t
 text $ui_diff -background white -foreground black \
 	-borderwidth 0 \
-	-width 80 -height 15 -wrap none \
+	-width 80 -height 5 -wrap none \
 	-font font_diff \
 	-xscrollcommand {.vpane.lower.diff.body.sbx set} \
 	-yscrollcommand {.vpane.lower.diff.body.sby set} \
-- 
1.6.5
