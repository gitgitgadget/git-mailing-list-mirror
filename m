From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] patch-id: "diff-tree" => "commit"
Date: Fri, 23 Jun 2006 17:36:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606231731280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jun 23 17:36:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftnhu-0002Xl-PH
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 17:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWFWPgX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 11:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWFWPgX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 11:36:23 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:26822 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751471AbWFWPgW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 11:36:22 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 699062470;
	Fri, 23 Jun 2006 17:36:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 5E1FA243B;
	Fri, 23 Jun 2006 17:36:21 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 43663235B;
	Fri, 23 Jun 2006 17:36:21 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22425>


Some time ago we changed git-log in a massive way, and one consequence is
that the keyword changed. Adjust patch-id for that.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 patch-id.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/patch-id.c b/patch-id.c
index edbc4aa..01845be 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -40,8 +40,8 @@ static void generate_id_list(void)
 		char *p = line;
 		int len;
 
-		if (!memcmp(line, "diff-tree ", 10))
-			p += 10;
+		if (!memcmp(line, "commit ", 7))
+			p += 7;
 
 		if (!get_sha1_hex(p, n)) {
 			flush_current_id(patchlen, sha1, &ctx);
-- 
1.4.1.rc1.g406e
