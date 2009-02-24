From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] README: fix path to "gitcvs-migration.txt" and be more
 consistent
Date: Tue, 24 Feb 2009 21:16:37 +0100
Message-ID: <20090224211637.07d764f5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joey Hess <joey@kitenet.net>,
	Brian Foster <brian.foster@innova-card.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 21:19:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc3k3-0004Q6-A9
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 21:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbZBXURb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 15:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbZBXURb
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 15:17:31 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:34928 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbZBXURa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 15:17:30 -0500
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id AD3C34B00A5;
	Tue, 24 Feb 2009 21:17:20 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id 1B9404B016A;
	Tue, 24 Feb 2009 21:17:17 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111337>

Before this patch the README suggested to look at
"Documentation/gittutorial.txt" for the tutorial and to use
"man git-commandname" for documentation of each command.

This was not consistent because the tutorial can also be available with
"man gittutorial" if git is installed, and the documentation for each
command can be available at "Documentation/git-commandname.txt" if git
is not installed.

So this patch tries to be more consistent and also fix the path to
the cvs-migration documentation that changed from
"Documentation/cvs-migration.txt" to "Documentation/gitcvs-migration.txt".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 README |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

	This comes from this discussion:

	http://thread.gmane.org/gmane.comp.version-control.git/104753/focus=104906

diff --git a/README b/README
index 5fa41b7..c932ab3 100644
--- a/README
+++ b/README
@@ -24,10 +24,18 @@ It was originally written by Linus Torvalds with help of a group of
 hackers around the net. It is currently maintained by Junio C Hamano.
 
 Please read the file INSTALL for installation instructions.
+
 See Documentation/gittutorial.txt to get started, then see
-Documentation/everyday.txt for a useful minimum set of commands,
-and "man git-commandname" for documentation of each command.
-CVS users may also want to read Documentation/cvs-migration.txt.
+Documentation/everyday.txt for a useful minimum set of commands, and
+Documentation/git-commandname.txt for documentation of each command.
+If git has been correctly installed, then the tutorial can also be
+read with "man gittutorial" or "git help tutorial", and the
+documentation of each command with "man git-commandname" or "git help
+commandname".
+
+CVS users may also want to read Documentation/gitcvs-migration.txt
+("man gitcvs-migration" or "git help cvs-migration" if git is
+installed).
 
 Many Git online resources are accessible from http://git.or.cz/
 including full documentation and Git related tools.
-- 
1.6.2.rc1.257.g6c75
