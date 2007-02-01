From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 6/3], was Re: [PATCH 5/3], was Re: [PATCH 4/3] provide a nice
 @{...} syntax to always mean the current branch reflog
Date: Fri, 2 Feb 2007 00:21:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702020021100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
 <45C25BA6.1000301@fs.ei.tum.de> <Pine.LNX.4.64.0702011710120.3021@xanadu.home>
 <20070201221758.GA15213@moooo.ath.cx> <Pine.LNX.4.64.0702011725150.3021@xanadu.home>
 <Pine.LNX.4.63.0702020006220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:21:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClFb-0004r2-SR
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbXBAXVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422837AbXBAXVw
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:21:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:57850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422775AbXBAXVw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:21:52 -0500
Received: (qmail invoked by alias); 01 Feb 2007 23:21:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 02 Feb 2007 00:21:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702020006220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38426>

Update the documentation for the new '@{...}' syntax

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/git-rev-parse.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index aeb37b6..4041a16 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -160,6 +160,10 @@ blobs contained in a commit.
   immediately following a ref name and the ref must have an existing
   log ($GIT_DIR/logs/<ref>).
 
+* You can use the '@' construct with an empty ref part to get at a
+  reflog of the current branch. For example, if you are on the
+  branch 'blabla', then '@\{1\}' means the same as 'blabla@\{1\}'.
+
 * A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
