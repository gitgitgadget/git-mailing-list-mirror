From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] gitk: Swap positions of 'next' and 'prev' buttons in the
 'Find' section.
Date: Wed, 17 Dec 2008 12:50:17 +0100
Message-ID: <4948E779.9080909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 12:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCuwF-0005by-Vw
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 12:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbYLQLuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 06:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbYLQLuU
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 06:50:20 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12138 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbYLQLuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 06:50:19 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LCuuv-0004LJ-KG; Wed, 17 Dec 2008 12:50:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 561ED54D; Wed, 17 Dec 2008 12:50:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103334>

From: Johannes Sixt <j6t@kdbg.org>

The button order 'prev' left of 'next' feels more natural than the other
way round, in particular, compared to the order of the forward and backward
arrows that are in the line above.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index b63109b..1c8d98e 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2052,7 +2052,7 @@ proc makewindow {} {
     button .tf.lbar.fnext -text [mc "next"] -command {dofind 1 1}
     button .tf.lbar.fprev -text [mc "prev"] -command {dofind -1 1}
     label .tf.lbar.flab2 -text " [mc "commit"] "
-    pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 \
+    pack .tf.lbar.flabel .tf.lbar.fprev .tf.lbar.fnext .tf.lbar.flab2 \
 	-side left -fill y
     set gdttype [mc "containing:"]
     set gm [tk_optionMenu .tf.lbar.gdttype gdttype \
-- 
1.6.1.rc3.980.ga0bb
