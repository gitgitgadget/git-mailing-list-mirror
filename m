From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Clarify doc for git-config --unset-all.
Date: Wed, 14 Mar 2007 22:08:41 +0100
Message-ID: <20070314210841.12621.59350.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 22:08:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRaiE-0000FX-Cg
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbXCNVIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbXCNVIn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:08:43 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:49833 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422657AbXCNVIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:08:43 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 0859B81B4
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 22:08:42 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id ABECA1F094
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 22:08:41 +0100 (CET)
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42230>


Previous formulation could make it appear as removing all lines
matching a regexp (at least, I was looking for such a flag, and
confused this flag for what I was looking for).

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/git-config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 68de588..c759efb 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -86,7 +86,7 @@ OPTIONS
 	Remove the line matching the key from config file.
 
 --unset-all::
-	Remove all matching lines from config file.
+	Remove all lines matching the key from config file.
 
 -l, --list::
 	List all variables set in config file.
