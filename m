From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Deprecate git-resolve.sh
Date: Sun, 24 Sep 2006 00:25:19 +0200
Message-ID: <20060923222444.18230.94482.stgit@machine.or.cz>
References: <20060923195530.5570.23774.stgit@machine.or.cz> <7v64fensge.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 00:25:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRFw4-0000Og-UA
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 00:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWIWWZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 18:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWIWWZV
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 18:25:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60298 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750726AbWIWWZV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 18:25:21 -0400
Received: (qmail 18313 invoked by uid 2001); 24 Sep 2006 00:25:19 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64fensge.fsf@assigned-by-dhcp.cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27635>

Seriously, is anyone still using this thing? It's collecting dust and
blocking the name for something potentially useful like a tool for
user-friendly marking of resolved conflicts or resolving index conflicts.

We've loved you when Git was young, now thank you and please go away. ;-)

This makes git-resolve.sh print a big deprecation warning and sleep a bit
for extra annoyance. It should be removed completely after the next release.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

  I won't touch git-merge-recursive.py because I really have no clue how
those fancy merge drivers work.

 git-resolve.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-resolve.sh b/git-resolve.sh
index a7bc680..729ec65 100755
--- a/git-resolve.sh
+++ b/git-resolve.sh
@@ -5,6 +5,10 @@ #
 # Resolve two trees.
 #
 
+echo 'WARNING: This command is DEPRECATED and will be removed very soon.' >&2
+echo 'WARNING: Please use git-merge or git-pull instead.' >&2
+sleep 2
+
 USAGE='<head> <remote> <merge-message>'
 . git-sh-setup
 
