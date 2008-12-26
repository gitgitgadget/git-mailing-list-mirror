From: jidanni@jidanni.org
Subject: [PATCH] gitrepository-layout: No longer first two letters. Also add "down".
Date: Sat, 27 Dec 2008 00:43:07 +0800
Message-ID: <E1LGFoE-0001EZ-0F@jidanni.org>
To: undisclosed-recipients:;
X-From: git-owner@vger.kernel.org Fri Dec 26 18:12:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGGEA-0003qQ-8I
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 18:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbYLZRKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 12:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbYLZRKh
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 12:10:37 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:33736 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752554AbYLZRKg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2008 12:10:36 -0500
Received: from jidanni.org (122-127-37-157.dynamic.hinet.net [122.127.37.157])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 12145D26C4
	for <git@vger.kernel.org>; Fri, 26 Dec 2008 09:10:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103947>


Signed-off-by: jidanni <jidanni@jidanni.org>

diff --git a/gitrepository-layout.txt b/gitrepository-layout.txt
index 03c52ff..81103fc 100644
--- a/gitrepository-layout.txt
+++ b/gitrepository-layout.txt
@@ -46,6 +46,4 @@ objects/[0-9a-f][0-9a-f]::
-	Traditionally, each object is stored in its own file.
-	They are split into 256 subdirectories using the first
-	two letters from its object name to keep the number of
-	directory entries `objects` directory itself needs to
-	hold.  Objects found here are often called 'unpacked'
-	(or 'loose') objects.
+	Traditionally, each object is stored in its own file. They are
+	split into 256 subdirectories to keep the number of directory
+	entries `objects` directory itself needs to hold down. Objects
+	found here are often called 'unpacked' (or 'loose') objects.
-- 
1.5.6.5
