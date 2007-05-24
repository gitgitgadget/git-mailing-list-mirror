From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: t9107-git-svn-migrate.sh fails
Date: Thu, 24 May 2007 23:18:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705242315550.4648@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 00:19:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrLeA-0008Fn-Ok
	for gcvg-git@gmane.org; Fri, 25 May 2007 00:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbXEXWSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 18:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbXEXWSp
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 18:18:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:54366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751440AbXEXWSo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 18:18:44 -0400
Received: (qmail invoked by alias); 24 May 2007 22:18:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 25 May 2007 00:18:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LaGgliWlLCBtlMdmZQXgPQ8mvqT+rgIIQrk4vyO
	IQdwyxXxONfj2n
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48313>

Hi,

I recently wanted to use git-svn, and installed the svn perl bindings. 
Since then, t9107 is failing:

-- snip --
[...]
Rebuilding .git/svn/git-svn/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6 
...
r1 = b9b82a419abdbb54f51a41bc8a3118b28c791ac1
Done rebuilding 
.git/svn/git-svn/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6
diff --git 
a/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6 
b/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db
index d3f1b6e..01d8afd 100644
--- 
a/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6
+++ b/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db
@@ -1,2 +1 @@
-0000000000000000000000000000000000000000
-6aa651a66730888e854a8de54199d62ffa402739
+.rev_db.f944dda1-3e31-0410-9475-8f268450faf6
\ No newline at end of file
* FAIL 7: .rev_db auto-converted to .rev_db.UUID

                git-svn fetch -i trunk &&
		[...]
-- snap --

Usually I try to fix things like this myself, but I really have to get 
some dinner now. Besides, other people than me seem to be way more clever 
with perl code.

Anybody knows how to fix this?

Ciao,
Dscho
