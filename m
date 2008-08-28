From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Document gitk --argscmd flag.
Date: Fri, 29 Aug 2008 00:00:28 +0200
Message-ID: <20080828220027.17395.91997.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 00:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYpYa-0004Km-Gw
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 00:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbYH1WA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 18:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYH1WA1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 18:00:27 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:33941 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913AbYH1WA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 18:00:26 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 31016B0176
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 00:00:23 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 1659AB0101
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 00:00:23 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 64B621F0C1
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 00:00:28 +0200 (CEST)
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94190>

This was part of my original patch, but appears to have been lost.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/gitk.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 6e827cd..ae29a00 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -49,6 +49,13 @@ frequently used options.
 	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
 	that modify the conflicted files.
 
+--argscmd=<command>::
+	Command to be run each time gitk has to determine the list of
+	<revs> to show.  The command is expected to print on its standard
+	output a list of additional revs to be shown, one per line.
+	Use this instead of explicitly specifying <revs> if the set of
+	commits to show may vary between refreshes.
+
 <revs>::
 
 	Limit the revisions to show. This can be either a single revision
