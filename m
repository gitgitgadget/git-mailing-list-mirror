From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 3/5] gitk: Set the font for all listbox widgets
Date: Mon, 28 Dec 2009 20:04:01 +0000
Message-ID: <1262030643-12952-3-git-send-email-mark@pogo.org.uk>
References: <1262030643-12952-1-git-send-email-mark@pogo.org.uk>
 <1262030643-12952-2-git-send-email-mark@pogo.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 21:31:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPMFd-0006h2-2x
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 21:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbZL1UbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 15:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbZL1UbK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 15:31:10 -0500
Received: from mailout.ijneb.com ([212.13.201.26]:58969 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751363AbZL1UbG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 15:31:06 -0500
Received: from host86-131-13-173.range86-131.btcentralplus.com ([86.131.13.173] helo=vega)
	by wes.ijneb.com with esmtpa (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1NPLp3-0002yj-Fi; Mon, 28 Dec 2009 20:04:09 +0000
Received: from mark by vega with local (Exim 4.69)
	(envelope-from <mark@vega>)
	id 1NPLoy-0003NZ-B5; Mon, 28 Dec 2009 20:04:04 +0000
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262030643-12952-2-git-send-email-mark@pogo.org.uk>
X-SA-Exim-Connect-IP: 86.131.13.173
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135760>

This affects the font chooser.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 gitk-git/gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 299a2ae..5cbc885 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1877,6 +1877,7 @@ proc setoptions {} {
     option add *Entry.font uifont startupFile
     option add *Labelframe.font uifont startupFile
     option add *Spinbox.font textfont startupFile
+    option add *Listbox.font mainfont startupFile
 }
 
 # Make a menu and submenus.
-- 
1.6.6
