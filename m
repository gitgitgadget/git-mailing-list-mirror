From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] remove a superfluous git-symbolic-ref call
Date: Sat, 03 Feb 2007 15:46:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702031544240.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 03 21:46:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDRmj-0008Sq-1N
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 21:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbXBCUqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 15:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbXBCUqz
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 15:46:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64586 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbXBCUqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 15:46:54 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCW00JDHN25KZC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Feb 2007 15:46:53 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38597>

Signed-off-by Nicolas Pitre <nico@cam.org>
---

Found in 'next'.


diff --git a/git-checkout.sh b/git-checkout.sh
index 99b8779..dd0c2e9 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -265,7 +265,6 @@ if [ "$?" -eq 0 ]; then
 	if test -n "$branch"
 	then
 		GIT_DIR="$GIT_DIR" git-symbolic-ref -m "checkout: moving to $branch" HEAD "refs/heads/$branch"
-		GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD "refs/heads/$branch"
 		if test -z "$quiet"
 		then
 			echo >&2 "Switched to${newbranch:+ a new} branch \"$branch\""
