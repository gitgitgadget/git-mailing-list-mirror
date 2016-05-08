From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 1/5] git-gui i18n: mark strings for translation
Date: Sun,  8 May 2016 10:52:54 +0000
Message-ID: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 12:54:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azMLy-0006aR-TX
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 12:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbcEHKyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 06:54:15 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:56702 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750791AbcEHKyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 06:54:13 -0400
Received: (qmail 21200 invoked from network); 8 May 2016 10:54:09 -0000
Received: (qmail 14460 invoked from network); 8 May 2016 10:54:09 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 May 2016 10:54:09 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293961>

Mark strings for translation in lib/index.tcl that were seemingly
left behind by 700e560 ("git-gui: Mark forgotten strings for
translation.", 2008-09-04) which marks string in do_revert_selection
procedure.
These strings are passed to unstage_help and add_helper procedures.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 lib/index.tcl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index 74a81a7..3a3e534 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -291,7 +291,7 @@ proc do_unstage_selection {} {
 
 	if {[array size selected_paths] > 0} {
 		unstage_helper \
-			{Unstaging selected files from commit} \
+			[mc "Unstaging selected files from commit"] \
 			[array names selected_paths]
 	} elseif {$current_diff_path ne {}} {
 		unstage_helper \
@@ -343,7 +343,7 @@ proc do_add_selection {} {
 
 	if {[array size selected_paths] > 0} {
 		add_helper \
-			{Adding selected files} \
+			[mc "Adding selected files"] \
 			[array names selected_paths]
 	} elseif {$current_diff_path ne {}} {
 		add_helper \
@@ -385,7 +385,7 @@ proc do_add_all {} {
 			set paths [concat $paths $untracked_paths]
 		}
 	}
-	add_helper {Adding all changed files} $paths
+	add_helper [mc "Adding all changed files"] $paths
 }
 
 proc revert_helper {txt paths} {
-- 
2.7.3
