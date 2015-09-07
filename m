From: Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH, RESEND] gitk: adjust the menu line numbers to compensate for the new entry
Date: Tue,  8 Sep 2015 01:16:37 +0200
Message-ID: <1441667797-5407-1-git-send-email-dev+git@drbeat.li>
Cc: Beat Bolli <dev+git@drbeat.li>, Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 01:16:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ5eh-0001HU-KE
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 01:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbbIGXQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 19:16:45 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:46878 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbbIGXQp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 19:16:45 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 394A9C3445;
	Tue,  8 Sep 2015 01:16:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 19120C343E;
	Tue,  8 Sep 2015 01:16:42 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
	id D5CA91FFAA; Tue,  8 Sep 2015 01:16:41 +0200 (CEST)
X-Mailer: git-send-email 2.5.0.492.g918e48c
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277478>

Commit d835dbb9 ("gitk: Add a "Copy commit summary" command",
2015-08-13) in the upstream gitk repo added a new context menu entry.
Therefore, the line numbers of the entries below the new one need to be
adjusted when their text or state is changed.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Cc: Paul Mackerras <paulus@samba.org>
---
 gitk-git/gitk | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d05169a..bc0e586 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -8877,13 +8877,13 @@ proc rowmenu {x y id} {
     if {$id ne $nullid && $id ne $nullid2} {
 	set menu $rowctxmenu
 	if {$mainhead ne {}} {
-	    $menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead] -state normal
+	    $menu entryconfigure 8 -label [mc "Reset %s branch to here" $mainhead] -state normal
 	} else {
-	    $menu entryconfigure 7 -label [mc "Detached head: can't reset" $mainhead] -state disabled
+	    $menu entryconfigure 8 -label [mc "Detached head: can't reset" $mainhead] -state disabled
 	}
-	$menu entryconfigure 9 -state $mstate
 	$menu entryconfigure 10 -state $mstate
 	$menu entryconfigure 11 -state $mstate
+	$menu entryconfigure 12 -state $mstate
     } else {
 	set menu $fakerowmenu
     }
-- 
2.5.0.492.g918e48c
