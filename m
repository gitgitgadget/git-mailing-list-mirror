From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-gui: Get rid of the last remnants of GIT_CONFIG_LOCAL
Date: Sun, 14 Dec 2008 23:12:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812142311360.25197@racer>
References: <alpine.DEB.1.00.0812142310210.25197@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Dec 14 23:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBzEq-0004bS-F1
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 23:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYLNWNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 17:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbYLNWNm
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 17:13:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:47648 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751933AbYLNWNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 17:13:42 -0500
Received: (qmail invoked by alias); 14 Dec 2008 22:13:39 -0000
Received: from pD9EB4001.dip0.t-ipconnect.de (EHLO noname) [217.235.64.1]
  by mail.gmx.net (mp009) with SMTP; 14 Dec 2008 23:13:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18szX0NTjIs/fOdsGHVOVXBMZ9y8mDvo3kLKEdd0R
	pch6yBpIGUWlNt
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0812142310210.25197@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103101>


In dc871831(Only use GIT_CONFIG in "git config", not other programs),
GIT_CONFIG_LOCAL was rested in peace, in favor of not reading
/etc/gitconfig and $HOME/.gitconfig at all when GIT_CONFIG is set.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	You might want to hold off on that, as git-gui is supposed to be 
	less tightly coupled to git.git than, say, git-svn.

	The commit removing support for GIT_CONFIG_LOCAL is from Mon Jun 
	30 03:37:47 2008 -0400...

 git-gui.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8a4b42d..bab66bd 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3315,7 +3315,6 @@ by %s:
 		{^GIT_PAGER$} -
 		{^GIT_TRACE$} -
 		{^GIT_CONFIG$} -
-		{^GIT_CONFIG_LOCAL$} -
 		{^GIT_(AUTHOR|COMMITTER)_DATE$} {
 			append msg " - $name\n"
 			incr ignored_env
-- 
1.6.0.4.1189.g8876f
