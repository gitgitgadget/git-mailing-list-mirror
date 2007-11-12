From: Jing Xue <jingxue@digizenstudio.com>
Subject: [PATCH] replace reference to git-rm with git-reset in git-commit
	doc
Date: Sun, 11 Nov 2007 19:38:45 -0500
Message-ID: <20071112003845.GA7595@fawkes>
References: <20071102021711.GA28703@fawkes.hq.digizenstudio.com> <20071111140518.GA3847@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 01:39:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrNKY-0000Nd-9K
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 01:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbXKLAiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 19:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756136AbXKLAiy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 19:38:54 -0500
Received: from k2smtpout03-02.prod.mesa1.secureserver.net ([64.202.189.172]:49041
	"HELO k2smtpout03-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756047AbXKLAix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 19:38:53 -0500
Received: (qmail 18808 invoked from network); 12 Nov 2007 00:38:52 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-02.prod.mesa1.secureserver.net (64.202.189.172) with ESMTP; 12 Nov 2007 00:38:52 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 62906100A45
	for <git@vger.kernel.org>; Mon, 12 Nov 2007 00:38:52 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HOSI-SYVDg6P for <git@vger.kernel.org>;
	Sun, 11 Nov 2007 19:38:46 -0500 (EST)
Received: from fawkes.hq.digizenstudio.com (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id F1DAF10007A
	for <git@vger.kernel.org>; Sun, 11 Nov 2007 19:38:45 -0500 (EST)
Received: by fawkes.hq.digizenstudio.com (Postfix, from userid 1000)
	id 451599ACEC; Sun, 11 Nov 2007 19:38:45 -0500 (EST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071111140518.GA3847@efreet.light.src>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64542>

On Sun, Nov 11, 2007 at 03:05:18PM +0100, Jan Hudec wrote:
> 
> The message in git-commit suggesting to use 'git rm --cached' to unstage is
> just plain wrong. It really should mention 'git reset'.

Hopefully this makes it clearer. I have also updated the faq in wiki to
clarify.

Signed-off-by: Jing Xue <jingxue@digizenstudio.com>
---
 Documentation/git-add.txt    |    1 +
 Documentation/git-commit.txt |   12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 963e1ab..63829d9 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -224,6 +224,7 @@ See Also
 --------
 gitlink:git-status[1]
 gitlink:git-rm[1]
+gitlink:git-reset[1]
 gitlink:git-mv[1]
 gitlink:git-commit[1]
 gitlink:git-update-index[1]
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e54fb12..7c63dd8 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -154,12 +154,12 @@ EXAMPLES
 --------
 When recording your own work, the contents of modified files in
 your working tree are temporarily stored to a staging area
-called the "index" with gitlink:git-add[1].  Removal
-of a file is staged with gitlink:git-rm[1].  After building the
-state to be committed incrementally with these commands, `git
-commit` (without any pathname parameter) is used to record what
-has been staged so far.  This is the most basic form of the
-command.  An example:
+called the "index" with gitlink:git-add[1].  File changes
+previously staged can be removed with `git-reset
+HEAD -- <file>`.  After building the state to be committed
+incrementally with these commands, `git commit` (without any
+pathname parameter) is used to record what has been staged so
+far.  This is the most basic form of the command.  An example:
 
 ------------
 $ edit hello.c
