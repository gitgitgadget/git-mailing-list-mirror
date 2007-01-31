From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] tone down the detached head warning
Date: Wed, 31 Jan 2007 14:10:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 20:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCKr0-0006wC-Tp
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 20:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbXAaTKo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 14:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbXAaTKn
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 14:10:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:59683 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030252AbXAaTKn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 14:10:43 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCQ000O1YLPA2W0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 31 Jan 2007 14:10:38 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38285>

This is not meant to frighten people or even to suggest they might be
doing something wrong, but rather to notify them of a state change and
provide a likely option in the case this state was entered by mistake.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/git-checkout.sh b/git-checkout.sh
index 8500f51..0bae86e 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -155,9 +155,9 @@ then
 	detached="$new"
 	if test -n "$oldbranch"
 	then
-		detach_warn="warning: you are not on ANY branch anymore.
-If you meant to create a new branch from this checkout, you may still do
-so (now or later) by using -b with the checkout command again.  Example:
+		detach_warn="Note: you are not on ANY branch anymore.
+If you want to create a new branch from this checkout, you may do so
+(now or later) by using -b with the checkout command again. Example:
   git checkout -b <new_branch_name>"
 	fi
 elif test -z "$oldbranch" && test -n "$branch"
