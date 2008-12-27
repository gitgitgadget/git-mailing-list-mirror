From: jidanni@jidanni.org
Subject: [PATCH] Documentation/git-format-patch.txt: fix weird backslash at --root
Date: Sun, 28 Dec 2008 03:57:04 +0800
Message-ID: <E1LGfLz-0001nM-AO@jidanni.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 22:16:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGgW0-0000n4-8h
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 22:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbYL0VOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 16:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYL0VOt
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 16:14:49 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:51610 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752575AbYL0VOt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 16:14:49 -0500
Received: from jidanni.org (122-127-33-180.dynamic.hinet.net [122.127.33.180])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id EFBA34150B
	for <git@vger.kernel.org>; Sat, 27 Dec 2008 13:14:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104016>

However note --root is not mentioned in SYNOPSIS nor on its own line.
Also fixed grammar.

Signed-off-by: jidanni <jidanni@jidanni.org>

diff --git a/git-format-patch.txt b/git-format-patch.txt
index ee27eff..51c25cd 100644
--- a/git-format-patch.txt
+++ b/git-format-patch.txt
@@ -48 +48 @@ everything since project inception to one commit, say "git
-format-patch \--root <commit>" to make it clear that it is the
+format-patch --root <commit>" to make it clear that it is the
@@ -166 +166 @@ not add any suffix.
-	that they differ.  Note that this disable the patch to be properly
+	that they differ.  Note that this disables the patch from being properly
@@ -209 +209 @@ project:
-$ git format-patch \--root origin
+$ git format-patch --root origin
-- 
1.5.6.5
