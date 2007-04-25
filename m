From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 4/5] core-tutorial: minor fixes
Date: Wed, 25 Apr 2007 11:18:28 -0300
Organization: Mandriva
Message-ID: <20070425111828.3e66c3f3@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Apr 25 16:19:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgiLF-0004SE-4C
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 16:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbXDYOT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 10:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbXDYOT2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 10:19:28 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:46474 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbXDYOT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 10:19:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id ED3DB17AD3;
	Wed, 25 Apr 2007 11:19:19 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id tqHa98mygIsh; Wed, 25 Apr 2007 11:19:19 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 4E66E17AE8;
	Wed, 25 Apr 2007 11:18:30 -0300 (BRT)
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45531>

- Do not break the line when it's not needed
- s/Your/You

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 Documentation/core-tutorial.txt |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 97cdb90..6b9b9ad 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -319,10 +319,9 @@ argument to `git-commit-tree`.
 `git-commit-tree` normally takes several arguments -- it wants to know
 what the 'parent' of a commit was, but since this is the first commit
 ever in this new repository, and it has no parents, we only need to pass in
-the object name of the tree. However, `git-commit-tree`
-also wants to get a commit message
-on its standard input, and it will write out the resulting object name for the
-commit to its standard output.
+the object name of the tree. However, `git-commit-tree` also wants to get a
+commit message on its standard input, and it will write out the resulting
+object name for the commit to its standard output.
 
 And this is where we create the `.git/refs/heads/master` file
 which is pointed at by `HEAD`. This file is supposed to contain
@@ -1304,7 +1303,7 @@ So, we can use somebody else's work from a remote repository, but
 how can *you* prepare a repository to let other people pull from
 it?
 
-Your do your real work in your working tree that has your
+You do your real work in your working tree that has your
 primary repository hanging under it as its `.git` subdirectory.
 You *could* make that repository accessible remotely and ask
 people to pull from it, but in practice that is not the way
-- 
1.5.1.1.320.g1cf2
