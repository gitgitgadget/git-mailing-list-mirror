From: Martin Atukunda <matlads@dsmagic.com>
Subject: Re: [PATCH] qgit: increase the space between the lanes.
Date: Tue, 3 Jan 2006 19:49:58 +0300
Organization: digital Solutions
Message-ID: <200601031949.59822.matlads@dsmagic.com>
References: <200601031415.19309.matlads@dsmagic.com> <43BA9CFA.8050208@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 03 17:52:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtpNo-0005tq-Qw
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 17:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWACQuy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 11:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWACQux
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 11:50:53 -0500
Received: from mail1.imul.com ([217.113.72.31]:14425 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S932444AbWACQuK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 11:50:10 -0500
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Tue, 03 Jan 2006 19:50:04 +0300
  id 000F5B7B.43BAAB3C.000043E8
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 48BA65252
	for <git@vger.kernel.org>; Tue,  3 Jan 2006 19:51:58 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.60)
	(envelope-from <matlads@dsmagic.com>)
	id 1EtpMG-00030c-3i
	for git@vger.kernel.org; Tue, 03 Jan 2006 19:50:00 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.8.3
In-Reply-To: <43BA9CFA.8050208@yahoo.it>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14152>

On Tuesday 03 January 2006 18:49, Marco Costalba wrote:
>
> If it _could_ be possible to fill with color the merge symbols it would be
> great.
>
> Do you mind to do it yourself? if not I will do that.

Something like this?
---

[PATCH] qgit: increase the space between the lanes.

This commit increases the space between the lanes. It also cators/adjusts for
the look of the merge/fork symbols.

Signed-off-by: Martin Atukunda <matlads@dsmagic.com>

---

 src/mainimpl.cpp |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

eb82c3b5bda7970bf743a3b1fa9df8a943f3b9ed
diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index d7c4e39..9430e1b 100644
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
+			p.drawRect(pw/4+1, ph/4, pw/2-1, ph/2);
 			break;
 		case MERGE_FORK_R:
 			p.drawLine(P_90, P_270);
 			p.drawLine(P_180, P_OR);
-			p.drawRect(pw/4, ph/4, pw/2, ph/2);
+			p.drawRect(pw/4+1, ph/4, pw/2-1, ph/2);
 			break;
 		case MERGE_FORK_L:
 			p.drawLine(P_90, P_270);
 			p.drawLine(P_OR, P_0);
-			p.drawRect(pw/4, ph/4, pw/2, ph/2);
+			p.drawRect(pw/4+1, ph/4, pw/2-1, ph/2);
 			break;
 		case JOIN:
 			p.drawLine(P_90, P_270);
-- 
1.0.6-g58e3
