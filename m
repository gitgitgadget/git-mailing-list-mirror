From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: [PATCH] git-gui: Call changes "Staged" and "Unstaged" in file list 
 titles.
Date: Tue, 08 May 2007 13:33:06 +0200
Organization: eudaptics software gmbh
Message-ID: <46405FF2.1B600CBE@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 08 13:33:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlNwM-0006MZ-3N
	for gcvg-git@gmane.org; Tue, 08 May 2007 13:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934824AbXEHLdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 07:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934871AbXEHLdH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 07:33:07 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:49143 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934824AbXEHLdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 07:33:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HlNwD-0006sG-CI; Tue, 08 May 2007 13:33:01 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DC2BC29AB; Tue,  8 May 2007 13:33:00 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.040
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46569>

From: Johannes Sixt <johannes.sixt@telecom.at>

All menu entries talk about "staging" and "unstaging" changes, but the
titles of the file lists use different wording, which may confuse
newcomers.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
I hope the patch went through without my MUA's "improvements".

Hannes

 git-gui/git-gui.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 60e79ca..45d251e 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -5494,7 +5494,7 @@ pack .vpane -anchor n -side top -fill both -expand 1
 # -- Index File List
 #
 frame .vpane.files.index -height 100 -width 200
-label .vpane.files.index.title -text {Changes To Be Committed} \
+label .vpane.files.index.title -text {Staged Changes (Will Be Committed)} \
 	-background green \
 	-font font_ui
 text $ui_index -background white -borderwidth 0 \
@@ -5516,7 +5516,7 @@ pack $ui_index -side left -fill both -expand 1
 # -- Working Directory File List
 #
 frame .vpane.files.workdir -height 100 -width 200
-label .vpane.files.workdir.title -text {Changed But Not Updated} \
+label .vpane.files.workdir.title -text {Unstaged Changes (Will Not Be Committed)} \
 	-background red \
 	-font font_ui
 text $ui_workdir -background white -borderwidth 0 \
-- 
1.5.1.1.27.g91776
