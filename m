From: Vietor Liu <vietor.liu@gmail.com>
Subject: [PATCH] git-gui: Fixed compatibility for screen height equal 600 px
Date: Fri,  9 Oct 2009 08:32:56 +0800
Message-ID: <1255048376-6009-1-git-send-email-vietor.liu@gmail.com>
Cc: git@vger.kernel.org, Vietor Liu <vietor.liu@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Oct 09 02:31:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw3On-0004BL-8K
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 02:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475AbZJIAaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 20:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757291AbZJIAaa
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 20:30:30 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:49785 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791AbZJIAa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 20:30:29 -0400
Received: by ewy4 with SMTP id 4so187597ewy.37
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 17:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=k4dcydUJwj99i8SfVBQmVu/RanpQKMO6pDP4Kk2k45Y=;
        b=NVhJHnlLzWoIUhmPzbFtdHqGLQUFMHLmJBUGyEP53sO1hFyZHfl24t7T0RxtJV33/T
         Xe67WayDEEfcCncvBQ92+z38sCi5c/AQ1WO4sMonD2cKPJ9fJ0TG1cC5eI2rLR3QSpGH
         8KoFzaW5s9+pFurtjT02kjcTaJEbqe1Pz7EXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mZKcGk6PVahk4g+GZeinI8X/U59JyCSwRfiNG8kfmvLzycHW/8f3LkTaaCZ+QRWs9e
         9VnspvDdCDf6tZLlEgQBafEmwaUEMWkpQMSPBFDihe4yxJi4ZeQsDGuxTg6qGmDZvs9D
         /rvbNDeYKxpFLzHDQDa8dClLEC9fVLdVpgi9g=
Received: by 10.216.90.14 with SMTP id d14mr716261wef.30.1255048192543;
        Thu, 08 Oct 2009 17:29:52 -0700 (PDT)
Received: from localhost.localdomain ([222.131.235.191])
        by mx.google.com with ESMTPS id 5sm1595363eyh.0.2009.10.08.17.29.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 17:29:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129726>

When the screen height equal 600 px, The Main Window should be hide
the Push button and Status bar. This patch support screen height
equal 600 (e.g. 800*600 1024*600).

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
