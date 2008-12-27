From: jidanni@jidanni.org
Subject: [PATCH] Documentation/gitrepository-layout.txt: enhance discussion of objects/[0-9a-f][0-9a-f]
Date: Sat, 27 Dec 2008 02:48:03 +0000
Message-ID: <E1LGPFr-0001XW-8r@jidanni.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 03:53:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGPJD-0003W8-R4
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 03:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbYL0CwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 21:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbYL0CwW
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 21:52:22 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:44329 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752278AbYL0CwV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2008 21:52:21 -0500
Received: from jidanni.org (122-127-47-84.dynamic.hinet.net [122.127.47.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 3C678414BD
	for <git@vger.kernel.org>; Fri, 26 Dec 2008 18:52:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103983>


Signed-off-by: jidanni <jidanni@jidanni.org>

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 03c52ff..bf900df 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -46,6 +46,4 @@ objects/[0-9a-f][0-9a-f]::
-	Traditionally, each object is stored in its own file.
-	They are split into 256 subdirectories using the first
-	two letters from its object name to keep the number of
-	directory entries `objects` directory itself needs to
-	hold.  Objects found here are often called 'unpacked'
-	(or 'loose') objects.
+	Each object is stored in its own file. They are split into 256
+	subdirectories to keep directory sizes down. Example: object
+	92b35d66... is stored in .git/object/92/b35d66... Objects
+	found here are often called 'unpacked' (or 'loose') objects.
-- 
1.5.6.5
