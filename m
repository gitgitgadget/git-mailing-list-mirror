From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 09/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Sat, 23 Oct 2010 18:31:20 +0200
Message-ID: <1287851481-27952-10-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 23 18:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9h0t-0005b4-Bc
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 18:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692Ab0JWQcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 12:32:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51598 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757199Ab0JWQcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 12:32:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9NGPDkf027302
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 18:25:13 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P9h0C-0006cZ-DZ; Sat, 23 Oct 2010 18:31:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P9h0C-0007I1-B6; Sat, 23 Oct 2010 18:31:28 +0200
X-Mailer: git-send-email 1.7.3.2.537.g7e355
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 23 Oct 2010 18:25:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9NGPDkf027302
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288455919.16983@VEFK/qt1WXTC4mQO08jUtw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159792>

Now that the documentation is mostly consistant in the use of "remote
branch" Vs "remote-tracking branch", let's make this distinction explicit
early in the user-manual.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/user-manual.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d70f3e0..02126f1 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -359,6 +359,11 @@ $ git branch -r
   origin/todo
 ------------------------------------------------
 
+In this case, "origin" is called a remote repository, or "remote" for
+short. The branches of this repository are called "remote branches"
+from our point of view, and Git will maintain a copy of these
+branches, called "remote-tracking branches" in the local repository.
+
 You cannot check out these remote-tracking branches, but you can
 examine them on a branch of your own, just as you would a tag:
 
@@ -1716,6 +1721,10 @@ one step:
 $ git pull origin master
 -------------------------------------------------
 
+This command will fetch the changes from the remote branch to your
+remote-tracking branch `origin/master`, and merge the result in the
+current branch.
+
 In fact, if you have "master" checked out, then by default "git pull"
 merges from the HEAD branch of the origin repository.  So often you can
 accomplish the above with just a simple
-- 
1.7.3.2.537.g7e355
