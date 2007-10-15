From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH 2/2] Fixing gitk indentation
Date: Mon, 15 Oct 2007 10:33:08 +0100
Message-ID: <11924407882007-git-send-email-maillist@steelskies.com>
References: <8c5c35580710141727k4bbd2bgc2292cfcc6f97c4a@mail.gmail.com>
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 11:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhMKE-0002gp-MC
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 11:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405AbXJOJdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 05:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757020AbXJOJdO
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 05:33:14 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:49465 "EHLO
	gir.office.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802AbXJOJdL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 05:33:11 -0400
Received: by gir.office.bestbefore.tv (Postfix, from userid 501)
	id BC52D270101; Mon, 15 Oct 2007 10:33:08 +0100 (BST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <8c5c35580710141727k4bbd2bgc2292cfcc6f97c4a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60970>

From: Jonathan del Strother <jon.delStrother@bestbefore.tv>

Just tweaking some minor indentation issues in gitk

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
 gitk |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index ee2a6f5..9b3e627 100755
--- a/gitk
+++ b/gitk
@@ -838,11 +838,11 @@ proc makewindow {} {
     bindall <1> {selcanvline %W %x %y}
     #bindall <B1-Motion> {selcanvline %W %x %y}
     if {[tk windowingsystem] == "win32"} {
-	bind . <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D }
-	bind $ctext <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D ; break }
+        bind . <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D }
+        bind $ctext <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D ; break }
     } else {
-	bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
-	bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
+        bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
+        bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
         if {[tk windowingsystem] eq "aqua"} {
             bindall <MouseWheel> {
                 set delta [expr {- (%D)}]
-- 
1.5.3.1
