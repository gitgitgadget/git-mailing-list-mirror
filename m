From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] qgit: increase the space between the lanes.
Date: Tue, 3 Jan 2006 14:15:18 +0300
Organization: digital Solutions
Message-ID: <200601031415.19309.matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 03 12:16:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Etk9b-0003pw-5f
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 12:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWACLPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 06:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWACLPx
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 06:15:53 -0500
Received: from mail1.imul.com ([217.113.72.31]:3161 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S1751366AbWACLPw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 06:15:52 -0500
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Tue, 03 Jan 2006 14:15:31 +0300
  id 000F5B49.43BA5CD3.00002AF7
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 3D39A5252
	for <git@vger.kernel.org>; Tue,  3 Jan 2006 14:17:22 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.60)
	(envelope-from <matlads@dsmagic.com>)
	id 1Etk8N-0007fT-Fx
	for git@vger.kernel.org; Tue, 03 Jan 2006 14:15:19 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.8.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14146>

There are probably better ways of doing this.

Signed-off-by: Martin Atukunda <matlads@dsmagic.com>

---

 src/mainimpl.cpp |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

28ddfe1297a5e1e212fc35c3419cf8364415847e
diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index d7c4e39..1b1f0f0 100644
--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -1409,7 +1409,7 @@ void MainImpl::setupPixmaps() {
 	// little hack to read items height
 	new QListViewItem(listViewLog);
 	ph = listViewLog->firstChild()->height();
-	pw = ph / 2;
+	pw = ph / 2 + 4;
 	listViewLog->clear(); // remove and deletes items
 	QPixmap cm(pw, ph);
 	cm.fill();
@@ -1443,17 +1443,17 @@ void MainImpl::setupPixmaps() {
 		case MERGE_FORK:
 			p.drawLine(P_90, P_270);
 			p.drawLine(P_180, P_0);
-			p.drawRect(pw/4, ph/4, pw/2, ph/2);
+			p.drawRect(pw/4+1, ph/4, pw/2, ph/2);
 			break;
 		case MERGE_FORK_R:
 			p.drawLine(P_90, P_270);
 			p.drawLine(P_180, P_OR);
-			p.drawRect(pw/4, ph/4, pw/2, ph/2);
+			p.drawRect(pw/4+1, ph/4, pw/2, ph/2);
 			break;
 		case MERGE_FORK_L:
 			p.drawLine(P_90, P_270);
 			p.drawLine(P_OR, P_0);
-			p.drawRect(pw/4, ph/4, pw/2, ph/2);
+			p.drawRect(pw/4+1, ph/4, pw/2, ph/2);
 			break;
 		case JOIN:
 			p.drawLine(P_90, P_270);
-- 
1.0.GIT
