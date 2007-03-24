From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/5] Documentation: bisect: make a comment fit better in the
 man page.
Date: Sat, 24 Mar 2007 06:32:05 +0100
Message-ID: <20070324063205.75563e13.chriscool@tuxfamily.org>
References: <20070324061811.2c7af3a7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 06:23:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUyjJ-0007mX-E3
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 06:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbXCXFXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 01:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbXCXFXt
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 01:23:49 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60761 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbXCXFXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 01:23:48 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 1748FB5A38;
	Sat, 24 Mar 2007 06:23:48 +0100 (CET)
In-Reply-To: <20070324061811.2c7af3a7.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42981>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ae0a974..713af5f 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -35,9 +35,9 @@ The way you use it is:
 
 ------------------------------------------------
 $ git bisect start
-$ git bisect bad			# Current version is bad
-$ git bisect good v2.6.13-rc2		# v2.6.13-rc2 was the last version
-					# tested that was good
+$ git bisect bad                 # Current version is bad
+$ git bisect good v2.6.13-rc2    # v2.6.13-rc2 was the last version
+                                 # tested that was good
 ------------------------------------------------
 
 When you give at least one bad and one good versions, it will bisect
-- 
1.5.1.rc1.14.ge96a-dirty
