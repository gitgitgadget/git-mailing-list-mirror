From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 2/5] gitk: Set the font for all spinbox widgets
Date: Wed, 13 Jan 2010 20:40:19 +0000
Message-ID: <1263415222-5911-2-git-send-email-mark@pogo.org.uk>
References: <alpine.NEB.2.01.1001132030010.15349@jrf.vwaro.pbz>
 <1263415222-5911-1-git-send-email-mark@pogo.org.uk>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVA1D-0003qp-5o
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab0AMUka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755315Ab0AMUk2
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:40:28 -0500
Received: from mailout.ijneb.com ([212.13.201.26]:58977 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755308Ab0AMUkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:40:25 -0500
Received: from cpc1-acto2-0-0-cust60.4-2.cable.virginmedia.com ([82.28.218.61] helo=stax.localdomain)
	by wes.ijneb.com with esmtpa (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1NVA0t-0002Wy-7b; Wed, 13 Jan 2010 20:40:23 +0000
Received: from mark by stax.localdomain with local (Exim 4.69)
	(envelope-from <mark@stax.localdomain>)
	id 1NVA0s-0001Xt-Ir; Wed, 13 Jan 2010 20:40:22 +0000
X-Mailer: git-send-email 1.6.6.5.ge408
In-Reply-To: <1263415222-5911-1-git-send-email-mark@pogo.org.uk>
X-SA-Exim-Connect-IP: 82.28.218.61
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136883>

Use the X resources to set the font, removing the need to set the font
for specific widgets.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 gitk |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 0e430bd..e010010 100755
--- a/gitk
+++ b/gitk
@@ -1879,6 +1879,7 @@ proc setoptions {} {
     option add *Message.font uifont startupFile
     option add *Entry.font uifont startupFile
     option add *Labelframe.font uifont startupFile
+    option add *Spinbox.font textfont startupFile
 }
 
 # Make a menu and submenus.
@@ -2229,7 +2230,7 @@ proc makewindow {} {
 	-command changediffdisp -variable diffelide -value {1 0}
     ${NS}::label .bleft.mid.labeldiffcontext -text "      [mc "Lines of context"]: "
     pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
-    spinbox .bleft.mid.diffcontext -width 5 -font textfont \
+    spinbox .bleft.mid.diffcontext -width 5 \
 	-from 0 -increment 1 -to 10000000 \
 	-validate all -validatecommand "diffcontextvalidate %P" \
 	-textvariable diffcontextstring
-- 
1.6.6.5.ge408
