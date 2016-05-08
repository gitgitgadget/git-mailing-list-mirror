From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 3/5] git-gui i18n: mark "usage:" strings for translation
Date: Sun,  8 May 2016 10:52:56 +0000
Message-ID: <1462704778-4722-3-git-send-email-vascomalmeida@sapo.pt>
References: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 12:54:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azMLz-0006aR-Oc
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 12:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbcEHKyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 06:54:19 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:56703 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750735AbcEHKyO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 06:54:14 -0400
Received: (qmail 21210 invoked from network); 8 May 2016 10:54:11 -0000
Received: (qmail 14592 invoked from network); 8 May 2016 10:54:11 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 May 2016 10:54:10 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293962>

Mark command-line "usage:" string for translation in git-gui.sh.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-gui.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 11048c7..4ae344f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3007,7 +3007,7 @@ bind all <$M1B-Key-W> {destroy [winfo toplevel %W]}
 
 set subcommand_args {}
 proc usage {} {
-	set s "usage: $::argv0 $::subcommand $::subcommand_args"
+	set s "[mc usage:] $::argv0 $::subcommand $::subcommand_args"
 	if {[tk windowingsystem] eq "win32"} {
 		wm withdraw .
 		tk_messageBox -icon info -message $s \
@@ -3139,7 +3139,7 @@ gui {
 	# fall through to setup UI for commits
 }
 default {
-	set err "usage: $argv0 \[{blame|browser|citool}\]"
+	set err "[mc usage:] $argv0 \[{blame|browser|citool}\]"
 	if {[tk windowingsystem] eq "win32"} {
 		wm withdraw .
 		tk_messageBox -icon error -message $err \
-- 
2.7.3
