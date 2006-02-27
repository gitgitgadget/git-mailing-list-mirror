From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: correct commit example in manpage
Date: Mon, 27 Feb 2006 12:55:45 -0800
Message-ID: <20060227205545.GA17373@localdomain>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <20060227184641.GA21684@hand.yhbt.net> <62354.84.163.87.135.1141068867.squirrel@mail.geht-ab-wie-schnitzel.de> <20060227202713.GB21684@hand.yhbt.net> <62402.84.163.87.135.1141073234.squirrel@mail.geht-ab-wie-schnitzel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 27 21:56:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDpPL-0001o5-7N
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 21:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWB0Uzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 15:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWB0Uzs
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 15:55:48 -0500
Received: from hand.yhbt.net ([66.150.188.102]:20146 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751096AbWB0Uzr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 15:55:47 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 51C492DC01A;
	Mon, 27 Feb 2006 12:55:45 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 27 Feb 2006 12:55:45 -0800
To: Nicolas Vilz 'niv' <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <62402.84.163.87.135.1141073234.squirrel@mail.geht-ab-wie-schnitzel.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16884>

Thanks to Nicolas Vilz <niv@iaglans.de> for noticing this.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

125c2e90f26d8980f415f8066dcc84d02d95f03a
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index b588a2a..b290739 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -159,7 +159,7 @@ Tracking and contributing to an Subversi
 # Commit only the git commits you want to SVN::
 	git-svn commit <tree-ish> [<tree-ish_2> ...]
 # Commit all the git commits from my-branch that don't exist in SVN::
-	git commit git-svn-HEAD..my-branch
+	git-svn commit git-svn-HEAD..my-branch
 # Something is committed to SVN, pull the latest into your branch::
 	git-svn fetch && git pull . git-svn-HEAD
 # Append svn:ignore settings to the default git exclude file:
-- 
1.2.3.g4676
