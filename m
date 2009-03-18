From: Sam Hocevar <sam@zoy.org>
Subject: [PATCH] git-gui: minor spelling fix and string factorisation.
Date: Wed, 18 Mar 2009 22:22:30 +0100
Message-ID: <20090318212230.GA2511@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 22:31:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3MK-0005kJ-Ju
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbZCRVaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbZCRVaA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:30:00 -0400
Received: from poulet.zoy.org ([80.65.228.129]:48290 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbZCRV37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:29:59 -0400
Received: from poukram (localhost [127.0.0.1])
	by poulet.zoy.org (Postfix) with ESMTP id B765012042F
	for <git@vger.kernel.org>; Wed, 18 Mar 2009 22:29:57 +0100 (CET)
Received: by poukram (Postfix, from userid 1000)
	id 7ABE37FA2B; Wed, 18 Mar 2009 22:22:30 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113683>

Properly spell "successful" and slightly rewrite a couple of strings
that actually say the same thing in order to reduce translation work.

Signed-off-by: Sam Hocevar <sam@zoy.org>
---
 lib/branch_delete.tcl        |    4 ++--
 lib/remote_branch_delete.tcl |    4 +---
 lib/tools.tcl                |    2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/branch_delete.tcl b/lib/branch_delete.tcl
index ef1930b..20d5e42 100644
--- a/lib/branch_delete.tcl
+++ b/lib/branch_delete.tcl
@@ -51,7 +51,7 @@ constructor dialog {} {
 		$w.check \
 		[mc "Delete Only If Merged Into"] \
 		]
-	$w_check none [mc "Always (Do not perform merge test.)"]
+	$w_check none [mc "Always (Do not perform merge checks)"]
 	pack $w.check -anchor nw -fill x -pady 5 -padx 5
 
 	foreach h [load_all_heads] {
@@ -112,7 +112,7 @@ method _delete {} {
 	}
 	if {$to_delete eq {}} return
 	if {$check_cmt eq {}} {
-		set msg [mc "Recovering deleted branches is difficult. \n\n Delete the selected branches?"]
+		set msg [mc "Recovering deleted branches is difficult.\n\nDelete the selected branches?"]
 		if {[tk_messageBox \
 			-icon warning \
 			-type yesno \
diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tcl
index 89eb0f7..4e02fc0 100644
--- a/lib/remote_branch_delete.tcl
+++ b/lib/remote_branch_delete.tcl
@@ -213,9 +213,7 @@ method _delete {} {
 		-type yesno \
 		-title [wm title $w] \
 		-parent $w \
-		-message [mc "Recovering deleted branches is difficult.
-
-Delete the selected branches?"]] ne yes} {
+		-message [mc "Recovering deleted branches is difficult.\n\nDelete the selected branches?"]] ne yes} {
 		return
 	}
 
diff --git a/lib/tools.tcl b/lib/tools.tcl
index 6ae63b6..95e6e55 100644
--- a/lib/tools.tcl
+++ b/lib/tools.tcl
@@ -146,7 +146,7 @@ proc tools_complete {fullname w {ok 1}} {
 	}
 
 	if {$ok} {
-		set msg [mc "Tool completed succesfully: %s" $fullname]
+		set msg [mc "Tool completed successfully: %s" $fullname]
 	} else {
 		set msg [mc "Tool failed: %s" $fullname]
 	}
-- 
1.6.2
