From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/8] Fix typo: do not show name1 when name2 fails
Date: Sun, 25 Feb 2007 23:34:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252334200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 23:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLRwy-0002m3-RT
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbXBYWed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXBYWed
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:34:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:33912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751284AbXBYWed (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:34:33 -0500
Received: (qmail invoked by alias); 25 Feb 2007 22:34:31 -0000
X-Provags-ID: V01U2FsdGVkX19xiZM9giBx4Qr/Hf1gSMXTdbV1DEHNYS1t9rm7hm
	24fw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40583>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 1d18442..17b9a56 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -43,7 +43,7 @@ static int queue_diff(struct diff_options *o,
 	}
 	if (name2) {
 		if (stat(name2, &st))
-			return error("Could not access '%s'", name1);
+			return error("Could not access '%s'", name2);
 		mode2 = st.st_mode;
 	}
 
-- 
1.5.0.1.788.g8ca52
