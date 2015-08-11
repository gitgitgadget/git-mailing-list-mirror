From: Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] gitk: adjust the menu line numbers to compensate for the new entry
Date: Tue, 11 Aug 2015 23:00:37 +0200
Message-ID: <1439326837-6126-1-git-send-email-dev+git@drbeat.li>
References: <1437218139-7031-1-git-send-email-dev+git@drbeat.li>
Cc: Beat Bolli <dev+git@drbeat.li>, Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 23:01:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPGfW-0005LE-GU
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 23:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbbHKVBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 17:01:05 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:45539 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579AbbHKVBE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 17:01:04 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 69917C3442;
	Tue, 11 Aug 2015 23:01:01 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 487E1C343D;
	Tue, 11 Aug 2015 23:01:01 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
	id E80CE1FE29; Tue, 11 Aug 2015 23:01:00 +0200 (CEST)
X-Mailer: git-send-email 2.5.0.492.g918e48c
In-Reply-To: <1437218139-7031-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275729>

The previous commit[1] added a new context menu entry. Therefore, the
line numbers of the folloeing entries need to be incremented when their
text or state is changed.

[1] <1437218139-7031-1-git-send-email-dev+git@drbeat.li>,
    http://article.gmane.org/gmane.comp.version-control.git/274161

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Cc: Paul Mackerras <paulus@samba.org>
---
Paul, feel free to squash this commit into my previous one.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
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
