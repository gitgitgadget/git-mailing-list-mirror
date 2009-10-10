From: Vietor Liu <vietor.liu@gmail.com>
Subject: [PATCH] git-gui: Fixed _main window_ for screen height equal 600 px
Date: Sat, 10 Oct 2009 08:59:43 +0800
Message-ID: <1255136383-6623-1-git-send-email-vietor.liu@gmail.com>
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLd-0005GI-31
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934730AbZJJA5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933867AbZJJA5w
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:57:52 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:46936 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933405AbZJJA5v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:57:51 -0400
Received: by qw-out-2122.google.com with SMTP id 9so118011qwb.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 17:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=gzqzifs6tadYNMxSe5WV5iSaIZcvB1rG65h6SVFwko8=;
        b=xW0sW8PcxKrvshLbc9Ri7LnYZBBVUmkDoRrtkcVLgZFEiaFziXnft8KXTHrw1w/CiN
         xiNpzDTY6t4xv/A9hu93DlWh3dPeXuJpDvy20haVt8tPrxk512r95zhw4AIID+K3RZ6f
         LdRgRmrtTeqnJbKE/4/LpUm/tyA/6BbPmvszc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dR+A/rrPtPfpO1clj0kguWcWGdr9KLoyS3t7WIqsfi/IrPvzXySIDZX7/8AkssDsP4
         8LkjUNhNdm76sng1KmjvUmNdhL1OXeTa2zliPggonlkEaS9TDG/I/jygO1yUbqAVMVyb
         oj+v2uhIyNaE4Fsw6/eKW8IW7ZHK9GWOGGdZ0=
Received: by 10.224.96.207 with SMTP id i15mr3275907qan.179.1255136203356;
        Fri, 09 Oct 2009 17:56:43 -0700 (PDT)
Received: from localhost.localdomain ([222.131.235.191])
        by mx.google.com with ESMTPS id 5sm437852qwh.22.2009.10.09.17.56.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 17:56:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129859>

When the screen height equal 600 px(e.g. Asus EeePC 1024x600), The
_main window_ should be hide the _Push button_ and _Status bar_.

Signed-off-by: Vietor Liu <vietor.liu@gmail.com>
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
1.6.5.rc3
