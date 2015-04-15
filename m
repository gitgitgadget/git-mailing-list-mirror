From: Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] gitk: Allow to quickly go to a specific commit
Date: Wed, 15 Apr 2015 13:18:17 -0300
Message-ID: <1429114697-15926-1-git-send-email-ismael@iodev.co.uk>
Cc: Paul Mackerras <paulus@samba.org>,
	Ismael Luceno <ismael@iodev.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 18:27:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQ9h-0006Id-0c
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 18:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbbDOQ0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 12:26:33 -0400
Received: from iodev.co.uk ([82.211.30.53]:54231 "EHLO iodev.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619AbbDOQ0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 12:26:24 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2015 12:26:24 EDT
Received: from localhost (host111.190-31-198.telecom.net.ar [190.31.198.111])
	by iodev.co.uk (Postfix) with ESMTPSA id 2A2FA1F657;
	Wed, 15 Apr 2015 12:17:32 -0400 (EDT)
X-Mailer: git-send-email 2.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267212>

Binds "g" to focus the sha1 entry box.

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 gitk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitk b/gitk
index 9a2daf3..0e9d884 100755
--- a/gitk
+++ b/gitk
@@ -2568,6 +2568,7 @@ proc makewindow {} {
     bindkey b prevfile
     bindkey d "$ctext yview scroll 18 units"
     bindkey u "$ctext yview scroll -18 units"
+    bindkey g {$sha1entry delete 0 end; focus $sha1entry}
     bindkey / {focus $fstring}
     bindkey <Key-KP_Divide> {focus $fstring}
     bindkey <Key-Return> {dofind 1 1}
@@ -3069,6 +3070,7 @@ proc keys {} {
 [mc "<%s-F>		Find" $M1T]
 [mc "<%s-G>		Move to next find hit" $M1T]
 [mc "<Return>	Move to next find hit"]
+[mc "g		Go to commit"]
 [mc "/		Focus the search box"]
 [mc "?		Move to previous find hit"]
 [mc "f		Scroll diff view to next file"]
-- 
2.3.4
