From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Update the documentation for git-tag-script to reflect current behavior.
Date: Mon, 25 Jul 2005 02:17:16 -0400
Message-ID: <20050725061716.GE6098@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 08:20:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwwK0-0004Iv-HJ
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 08:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVGYGTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 02:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVGYGRc
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 02:17:32 -0400
Received: from mail.autoweb.net ([198.172.237.26]:43469 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261853AbVGYGRS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 02:17:18 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwwH6-0006WM-S3; Mon, 25 Jul 2005 02:17:16 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DwwPm-00038T-00; Mon, 25 Jul 2005 02:26:14 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwwH6-0006Hv-Ah; Mon, 25 Jul 2005 02:17:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 Documentation/git-tag-script.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

8f1801c948cbf1187a192df1656709689ba46d61
diff --git a/Documentation/git-tag-script.txt b/Documentation/git-tag-script.txt
--- a/Documentation/git-tag-script.txt
+++ b/Documentation/git-tag-script.txt
@@ -4,18 +4,22 @@ v0.1, May 2005
 
 NAME
 ----
-git-tag-script - An example script to create a tag object signed with GPG
+git-tag-script -  Create a tag object signed with GPG
 
 
 
 SYNOPSIS
 --------
-'git-tag-script'
+'git-tag-script' [-s] [-f] <name>
 
 DESCRIPTION
 -----------
-This is an example script that uses "git-mktag" to create a tag object
-signed with GPG.
+Adds a "tag" reference in .git/refs/tags/
+
+Unless "-f" is given, the tag must not yet exist in ".git/refs/tags"
+
+If "-s" is passed, the user will be prompted for a tag message, and a GnuPG
+signed tag object will be created as well.
 
 
 Author

-- 

Ryan Anderson
  sometimes Pug Majere
