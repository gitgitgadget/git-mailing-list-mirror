From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/3] reword the detached head message a little again
Date: Thu, 01 Feb 2007 12:30:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702011229030.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 18:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCfld-0005h1-DW
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 18:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbXBARaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 12:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbXBARaa
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 12:30:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26539 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbXBARa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 12:30:29 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCS00FRFOMST9O0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Feb 2007 12:30:28 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38376>

Seems clearer this way, to me at least.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 git-checkout.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index deb4795..97c26ad 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -155,7 +155,7 @@ then
 	detached="$new"
 	if test -n "$oldbranch"
 	then
-		detach_warn="Note: you are not on any branch and are at commit \"$new_name\"
+		detach_warn="Note: moving to \"$new_name\" which isn't a local branch
 If you want to create a new branch from this checkout, you may do so
 (now or later) by using -b with the checkout command again. Example:
   git checkout -b <new_branch_name>"
-- 
1.5.0.rc2.131.g4b01-dirty
