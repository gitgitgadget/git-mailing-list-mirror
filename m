From: Vietor Liu <vietor@vxwo.org>
Subject: [PATCH v3] git-gui: adjust the minimum height of diff pane for shorter screen height
Date: Thu, 15 Oct 2009 13:05:27 +0800
Message-ID: <1255583127-14893-1-git-send-email-vietor@vxwo.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 07:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyIVV-00015p-Mq
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 07:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbZJOFD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 01:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbZJOFD4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 01:03:56 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:35045 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbZJOFD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 01:03:56 -0400
Received: by pzk26 with SMTP id 26so447861pzk.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 22:02:44 -0700 (PDT)
Received: by 10.114.2.3 with SMTP id 3mr2531693wab.109.1255582963924;
        Wed, 14 Oct 2009 22:02:43 -0700 (PDT)
Received: from localhost.localdomain ([123.113.93.118])
        by mx.google.com with ESMTPS id 21sm1087502pzk.3.2009.10.14.22.02.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 22:02:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130377>

When the screen height is shorter (e.g. Netbook screen 1024x600), both the
partial commit pane and the status bar will hide. This patch adjust the
minimum height of the diff pane, allowing the overall window to be shorter
and still display both the entire commit pane and status bar.

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
