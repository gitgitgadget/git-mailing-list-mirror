From: Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] gitk: Bind g to focus the sha1 entry box
Date: Wed,  7 Jan 2015 15:21:37 -0300
Message-ID: <1420654897-12592-1-git-send-email-ismael@iodev.co.uk>
Cc: Paul Mackerras <paulus@samba.org>,
	Ismael Luceno <ismael@iodev.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 19:29:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8vL6-0006dy-FB
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 19:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbbAGS2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 13:28:12 -0500
Received: from [82.211.30.53] ([82.211.30.53]:53448 "EHLO iodev.co.uk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753386AbbAGS2L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 13:28:11 -0500
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jan 2015 13:28:11 EST
Received: from localhost (host113.190-226-222.telecom.net.ar [190.226.222.113])
	by iodev.co.uk (Postfix) with ESMTPSA id 59C4C1F623;
	Wed,  7 Jan 2015 13:19:04 -0500 (EST)
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262142>

This allows switching to some commit quickly.

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 gitk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitk b/gitk
index 78358a7..9552fd4 100755
--- a/gitk
+++ b/gitk
@@ -2561,6 +2561,7 @@ proc makewindow {} {
     bindkey b prevfile
     bindkey d "$ctext yview scroll 18 units"
     bindkey u "$ctext yview scroll -18 units"
+    bindkey g {$sha1entry delete 0 end; focus $sha1entry}
     bindkey / {focus $fstring}
     bindkey <Key-KP_Divide> {focus $fstring}
     bindkey <Key-Return> {dofind 1 1}
@@ -2980,6 +2981,7 @@ proc keys {} {
 [mc "<%s-F>		Find" $M1T]
 [mc "<%s-G>		Move to next find hit" $M1T]
 [mc "<Return>	Move to next find hit"]
+[mc "g		Go to commit"]
 [mc "/		Focus the search box"]
 [mc "?		Move to previous find hit"]
 [mc "f		Scroll diff view to next file"]
-- 
2.2.1
