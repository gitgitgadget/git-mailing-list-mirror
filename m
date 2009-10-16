From: Vietor Liu <vietor@vxwo.org>
Subject: [PATCH v4] git-gui: adjust the minimum height of diff pane for shorter screen height
Date: Fri, 16 Oct 2009 17:41:26 +0800
Message-ID: <1255686086-3949-1-git-send-email-vietor@vxwo.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 11:41:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyjIy-0002hB-OM
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 11:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbZJPJjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 05:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbZJPJjZ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 05:39:25 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:63650 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbZJPJjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 05:39:24 -0400
Received: by pzk26 with SMTP id 26so1482990pzk.4
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 02:38:47 -0700 (PDT)
Received: by 10.114.33.29 with SMTP id g29mr1376053wag.215.1255685927745;
        Fri, 16 Oct 2009 02:38:47 -0700 (PDT)
Received: from localhost.localdomain ([123.113.93.118])
        by mx.google.com with ESMTPS id 23sm709363pxi.9.2009.10.16.02.38.43
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 16 Oct 2009 02:38:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130472>

When the main window is maximized, if the screen height is shorter (e.g.
Netbook screen 1024x600), both the partial commit pane and the status bar
are hidden. The diff pane is resizable, so that it can use less vertical
height, allowing the overall window to be shorter and still display both
the entire commit pane and status bar.

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
