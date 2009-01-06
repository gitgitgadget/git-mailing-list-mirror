From: jidanni@jidanni.org
Subject: [PATCH] Documentation/gittutorial.txt: clarify git branch -d
Date: Tue,  6 Jan 2009 10:40:55 +0800
Message-ID: <1231209655-13050-1-git-send-email-jidanni@jidanni.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 03:42:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK1ti-0002nS-4V
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 03:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbZAFClB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 21:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbZAFCk7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 21:40:59 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:42636 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751127AbZAFCk7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 21:40:59 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 6309EC5984;
	Mon,  5 Jan 2009 18:40:57 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104620>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/gittutorial.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 7892244..4581a5a 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -260,11 +260,11 @@ At this point you could delete the experimental branch with
 $ git branch -d experimental
 ------------------------------------------------
 
-This command ensures that the changes in the experimental branch are
-already in the current branch.
+This command makes sure that the changes in the experimental branch are
+already in the current branch before deleting.
 
 If you develop on a branch crazy-idea, then regret it, you can always
-delete the branch with
+force deletion of the branch with
 
 -------------------------------------
 $ git branch -D crazy-idea
-- 
1.6.0.6
