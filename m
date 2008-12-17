From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] gitk: force focus to main window
Date: Wed, 17 Dec 2008 12:50:09 +0100
Message-ID: <4948E771.4050705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 12:52:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCuwG-0005by-Nv
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 12:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbYLQLuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 06:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbYLQLuV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 06:50:21 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12126 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbYLQLuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 06:50:19 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LCuuo-0004L7-Ek; Wed, 17 Dec 2008 12:50:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 199EB54D; Wed, 17 Dec 2008 12:50:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103333>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On msysGit, the focus is first on the (Tk) console.  This console is then
hidden, but keeps the focus.  Work around that by forcing the focus onto
the gitk window.

This fixes issue 14.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1c8d98e..b3d8219 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -10898,4 +10898,5 @@ if {[info exists permviews]} {
 	addviewmenu $n
     }
 }
+focus -force .
 getcommits {}
-- 
1.6.1.rc3.980.ga0bb
