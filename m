From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 10/10] Sparse: fix a "symbol 'weak_match' shadows an
 earlier one" warning
Date: Fri, 08 Jun 2007 23:27:08 +0100
Message-ID: <4669D7BC.3060607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 05:39:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwrnW-0003Au-70
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 05:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbXFIDjZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 23:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbXFIDjZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 23:39:25 -0400
Received: from anchor-fallback-94.mail.demon.net ([194.217.242.94]:51598 "EHLO
	anchor-fallback-94.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348AbXFIDjY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 23:39:24 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1578 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-94.mail.demon.net
	with ESMTP id S2392205AbXFHWcr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 23:32:47 +0100
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1HwmyF-0005qG-1t; Fri, 08 Jun 2007 22:30:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49554>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 connect.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index da89c9c..d4051dd 100644
--- a/connect.c
+++ b/connect.c
@@ -179,7 +179,6 @@ static int count_refspec_match(const char *pattern,
 	for (weak_match = match = 0; refs; refs = refs->next) {
 		char *name = refs->name;
 		int namelen = strlen(name);
-		int weak_match;
 
 		if (namelen < patlen ||
 		    memcmp(name + namelen - patlen, pattern, patlen))
-- 
1.5.2
