From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] gitk: Adjust two equal strings which differed in whitespace
Date: Sun, 21 Jun 2009 19:35:40 +0200
Message-ID: <1245605740-27117-1-git-send-email-markus.heidelberg@web.de>
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 19:35:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIQxR-0000H4-Vm
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 19:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbZFURfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 13:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZFURfr
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 13:35:47 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:53715 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZFURfq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 13:35:46 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 15819100BB102;
	Sun, 21 Jun 2009 19:35:47 +0200 (CEST)
Received: from [89.59.120.52] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MIQxG-0007uv-00; Sun, 21 Jun 2009 19:35:46 +0200
X-Mailer: git-send-email 1.6.3.2.369.gdf06
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+vS5lE2Rz/9FgRk8LaIUnz5dN7dZqmrAYOMPOs
	/oGp4/vwuS7iEJHSBpbahd+zwGIBrf0MbFidK9A7t5/znS/hWv
	/MwhO277PHTXuGc4pGmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121988>

This caused two entries for translation. Also change the German
translation because the now used one is too long to be fully displayed.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 gitk     |    2 +-
 po/de.po |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 46d7782..87e3b31 100755
--- a/gitk
+++ b/gitk
@@ -2014,7 +2014,7 @@ proc makewindow {} {
     set sha1entry .tf.bar.sha1
     set entries $sha1entry
     set sha1but .tf.bar.sha1label
-    button $sha1but -text [mc "SHA1 ID: "] -state disabled -relief flat \
+    button $sha1but -text "[mc "SHA1 ID:"] " -state disabled -relief flat \
 	-command gotocommit -width 8
     $sha1but conf -disabledforeground [$sha1but cget -foreground]
     pack .tf.bar.sha1label -side left
diff --git a/po/de.po b/po/de.po
index 53ef0d6..e224595 100644
--- a/po/de.po
+++ b/po/de.po
@@ -708,7 +708,7 @@ msgstr "Gehe zu:"
 
 #: gitk:7821
 msgid "SHA1 ID:"
-msgstr "SHA1-Hashwert:"
+msgstr "SHA1 ID:"
 
 #: gitk:7840
 #, tcl-format
-- 
1.6.3.2.369.gdf06
