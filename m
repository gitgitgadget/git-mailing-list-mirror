From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sun, 28 Jan 2007 01:22:46 +0100
Message-ID: <20070128002246.GA10179@moooo.ath.cx>
References: <20070127062826.GE14205@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 01:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAxou-00067X-3l
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 01:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXA1AWv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 19:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbXA1AWv
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 19:22:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:35686 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932189AbXA1AWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 19:22:50 -0500
Received: (qmail invoked by alias); 28 Jan 2007 00:22:49 -0000
Received: from pD9EB8A68.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.104]
  by mail.gmx.net (mp040) with SMTP; 28 Jan 2007 01:22:49 +0100
X-Authenticated: #5358227
Mail-Followup-To: "J. Bruce Fields" <bfields@fieldses.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070127062826.GE14205@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38007>

---
There are some other places where direct editing of .git/config is
suggested.  I'd rather tell the user to use repo-config and add a note
that repo-config saves the configuration to .git/config (or
~/.gitconfig with --global) which can be edited by hand too.
cat .git/config to show the remote configuration can be replaced by
git-repo-config -l | grep '^remote\.'
---
 Documentation/user-manual.txt |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 87c605f..7a286d4 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -153,11 +153,8 @@ Making changes
 Make sure git knows who to blame:
 
 ------------------------------------------------
-$ cat >~/.gitconfig <<\EOF
-[user]
-name = Your Name Comes Here
-email = you@yourdomain.example.com
-EOF
+$ git repo-config --global user.name "Your Name Comes Here"
+$ git repo-config --global user.email you@yourdomain.example.com
 ------------------------------------------------
 
 Select file contents to include in the next commit, then make the
-- 
1.5.0.rc2.g18af
