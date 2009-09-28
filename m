From: Vietor Liu <vietor.liu@gmail.com>
Subject: [PATCH] git-gui: add small screen compatibility
Date: Mon, 28 Sep 2009 10:38:52 +0800
Message-ID: <1254105532-5342-1-git-send-email-vietor.liu@gmail.com>
Cc: git@vger.kernel.org, Vietor Liu <vietor.liu@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Sep 28 04:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ms664-0004Mp-KO
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 04:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZI1CgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 22:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbZI1CgF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 22:36:05 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:64662 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbZI1CgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 22:36:03 -0400
Received: by yxe37 with SMTP id 37so4824861yxe.33
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 19:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=i1o29Dtwi1FYUOJvPgAx0YxuShMo8cy/lat8z1yLDOE=;
        b=jG/d8mePMAdq6asjQgxRdGlRIdxyBnveNrYFWiOslDs4xH2HP8NO0h8Ur9ScGiBZ3S
         TAi9C/mlePCvJQENVto3HdzBUqmOGTw/6AnXku0itJVtrNDnI66EdKoQYEGCfNhl7Iqz
         2GIbtRJEJYxIrcBiB3igUz/RxZ2O1gFACyCE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=UXhphvNnwhtJnDL9bsi9pVg/vjLd+lBVfWQ2CK11aJpwGA4dfFuanSceUciEVCuPtF
         ebnBAXKGld7qdSP0mf9R4eGdsw5mVl7VwxKhog/Fdw1LRLLoS0n7zgx1t68E7H2d0jZb
         iTl+F2kGQ9Xqm8ABm3c/j9Old8F0ecokk06M0=
Received: by 10.91.46.7 with SMTP id y7mr2607487agj.58.1254105367760;
        Sun, 27 Sep 2009 19:36:07 -0700 (PDT)
Received: from localhost.localdomain ([221.218.175.89])
        by mx.google.com with ESMTPS id 20sm5700816agd.24.2009.09.27.19.36.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 27 Sep 2009 19:36:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129224>

The Netbook screen likes 800*480 1024*600. The git-gui's display
should be hide some buttons(ie 'Commit','Push') and 'Status bar'.

Signed-off-by: Vietor Liu <vietor.liu@gmail.com>
---
 git-gui/git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 14b92ba..6af9db2 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3054,7 +3054,7 @@ frame .vpane.lower.diff.body
 set ui_diff .vpane.lower.diff.body.t
 text $ui_diff -background white -foreground black \
 	-borderwidth 0 \
-	-width 80 -height 15 -wrap none \
+	-width 80 -height 0 -wrap none \
 	-font font_diff \
 	-xscrollcommand {.vpane.lower.diff.body.sbx set} \
 	-yscrollcommand {.vpane.lower.diff.body.sby set} \
-- 
1.6.5.rc2.dirty
