From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH resend] gitk: Adjust two equal strings which differed in whitespace
Date: Sat,  9 Jan 2010 23:11:12 +0100
Message-ID: <1263075072-25904-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Paul Mackerras <paulus@samba.org>,
	Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jan 09 23:11:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTjWi-00072s-1l
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 23:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab0AIWLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 17:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079Ab0AIWLP
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 17:11:15 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:48736 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0AIWLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 17:11:14 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4ECD7144B29B7;
	Sat,  9 Jan 2010 23:11:13 +0100 (CET)
Received: from [91.19.2.81] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1NTjWb-0004rq-00; Sat, 09 Jan 2010 23:11:13 +0100
X-Mailer: git-send-email 1.6.6.109.g052a6a
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19Z7XibX0kpnMKFOMZWzb7zH7CfmCMWDd/G9Nhr
	hwmKjwo/oBQ/cMVviObTBHu1+hDk2xKo+NdkPxRscy5NIg9jHL
	XVqzSpq0+WwrpMVx0+BQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136540>

There were the two strings "SHA1 ID: " and "SHA1 ID:" as description for
the SHA1 search textbox. Change it to two equal strings, the space is
now outside of the translated string.

Furthermore the German translation wasn't unique, but "SHA1:" resp.
"SHA1-Hashwert:". The former was displayed after initialisation, the
latter after changes to the textbox, for example when clearing the text.
But it was too long to be displayed fully, so use a shorter translation.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 gitk     |    2 +-
 po/de.po |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 86dff0f..d8364c4 100755
--- a/gitk
+++ b/gitk
@@ -2088,7 +2088,7 @@ proc makewindow {} {
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
1.6.6.109.g052a6a
