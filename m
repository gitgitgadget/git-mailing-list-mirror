From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation: remote tracking branch -> remote-tracking branch
Date: Tue, 23 Oct 2012 13:34:05 +0200
Message-ID: <1350992045-11141-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqk3uhr5gp.fsf@grenoble-inp.fr>
Cc: angelo.borsotti@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 23 13:34:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQckk-0000f5-Ea
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 13:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab2JWLeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 07:34:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41194 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab2JWLeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 07:34:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q9NBQkwY029660
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2012 13:26:46 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1TQckO-0006Rd-3T; Tue, 23 Oct 2012 13:34:12 +0200
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1TQckN-0002uN-Vt; Tue, 23 Oct 2012 13:34:12 +0200
X-Mailer: git-send-email 1.7.12.410.g5f38766
In-Reply-To: <vpqk3uhr5gp.fsf@grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Oct 2012 13:26:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9NBQkwY029660
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1351596410.56223@ojoXbZwLX5nH4kocLurYJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208222>

This change was already done by 0e615b252f3 (Matthieu Moy, Tue Nov 2
2010, Replace "remote tracking" with "remote-tracking"), but new
instances of remote tracking (without dash) were introduced in the
meantime.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Here's the patch.

I'm not opposed to dropping completely the remote-tracking part in the
case of merge (i.e. "remote-tracking branches that the current branch
is configured to use as its upstream" -> "upstream branch") on top of
that, but if we do this, merge-config.txt should be updated too).

 Documentation/git-clone.txt    | 4 ++--
 Documentation/git-merge.txt    | 2 +-
 Documentation/git-push.txt     | 2 +-
 Documentation/merge-config.txt | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6d98ef3..7fefdb0 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -196,9 +196,9 @@ objects from the source repository into a pack in the cloned repository.
 	`--no-single-branch` is given to fetch the histories near the
 	tips of all branches.
 	Further fetches into the resulting repository will only update the
-	remote tracking branch for the branch this option was used for the
+	remote-tracking branch for the branch this option was used for the
 	initial cloning.  If the HEAD at the remote did not point at any
-	branch when `--single-branch` clone was made, no remote tracking
+	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
 --recursive::
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 20f9228..d34ea3c 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -99,7 +99,7 @@ commit or stash your changes before running 'git merge'.
 	more than two parents (affectionately called an Octopus merge).
 +
 If no commit is given from the command line, and if `merge.defaultToUpstream`
-configuration variable is set, merge the remote tracking branches
+configuration variable is set, merge the remote-tracking branches
 that the current branch is configured to use as its upstream.
 See also the configuration section of this manual page.
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 22d2580..fe46c42 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -175,7 +175,7 @@ useful if you write an alias or script around 'git push'.
 
 --recurse-submodules=check|on-demand::
 	Make sure all submodule commits used by the revisions to be
-	pushed are available on a remote tracking branch. If 'check' is
+	pushed are available on a remote-tracking branch. If 'check' is
 	used git will verify that all submodule commits that changed in
 	the revisions to be pushed are available on at least one remote
 	of the submodule. If any commits are missing the push will be
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 861bd6f..9bb4956 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -9,11 +9,11 @@ merge.conflictstyle::
 merge.defaultToUpstream::
 	If merge is called without any commit argument, merge the upstream
 	branches configured for the current branch by using their last
-	observed values stored in their remote tracking branches.
+	observed values stored in their remote-tracking branches.
 	The values of the `branch.<current branch>.merge` that name the
 	branches at the remote named by `branch.<current branch>.remote`
 	are consulted, and then they are mapped via `remote.<remote>.fetch`
-	to their corresponding remote tracking branches, and the tips of
+	to their corresponding remote-tracking branches, and the tips of
 	these tracking branches are merged.
 
 merge.ff::
-- 
1.7.12.410.g5f38766
