From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] t7511: avoid use of reserved filename on Windows.
Date: Mon, 31 Oct 2011 14:07:27 +0000
Message-ID: <1320070047-22844-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 31 15:07:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKsWb-0005tp-FC
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 15:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab1JaOHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 10:07:36 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:51481 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750779Ab1JaOHg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2011 10:07:36 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111031140734.XUNV21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Mon, 31 Oct 2011 14:07:34 +0000
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RKsWU-0007n8-NZ; Mon, 31 Oct 2011 14:07:34 +0000
Received: from frog.patthoyts.tk (unknown [192.168.0.15])
	by fox.patthoyts.tk (Postfix) with ESMTP id 14E8420318;
	Mon, 31 Oct 2011 14:07:34 +0000 (GMT)
X-Mailer: git-send-email 1.7.8.rc0.200.gbcc18
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=2yG2c2T6X4kA:10 a=FP58Ms26AAAA:8 a=zQzoeaHK40RFc-Xk93wA:9 a=pKggWt3XUzjZPa_1uCIA:7 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184506>

PRN is a special filename on Windows to send data to the printer. As
this is generated during test 3 substitute an alternate prefix to avoid this.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 t/t7511-status-index.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7511-status-index.sh b/t/t7511-status-index.sh
index bca359d..b5fdc04 100755
--- a/t/t7511-status-index.sh
+++ b/t/t7511-status-index.sh
@@ -24,7 +24,7 @@ check() {
 
 check  1
 check  2 p
-check  3 pr
+check  3 px
 check  4 pre
 check  5 pref
 check  6 prefi
-- 
1.7.8.rc0.200.gbcc18
