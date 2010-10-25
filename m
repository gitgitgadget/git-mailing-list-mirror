From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 04/10] Change "tracking branch" to "remote-tracking branch"
Date: Mon, 25 Oct 2010 08:08:36 +0200
Message-ID: <1287986922-16308-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 25 08:11:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAGGr-0004HG-Ii
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 08:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab0JYGKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 02:10:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53324 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772Ab0JYGKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 02:10:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9P62PHY006487
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Oct 2010 08:02:25 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PAGEf-00050Q-Cg; Mon, 25 Oct 2010 08:08:45 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PAGEf-0004Fu-9Z; Mon, 25 Oct 2010 08:08:45 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 25 Oct 2010 08:02:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9P62PHY006487
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288591346.09956@caNtAnaqjtkzopK0bXSd7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159928>

One more step towards consistancy in our documentation...

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt           |    4 ++--
 Documentation/git-fetch.txt        |    2 +-
 Documentation/git-pull.txt         |    6 +++---
 Documentation/git-remote.txt       |    2 +-
 Documentation/git-tag.txt          |    4 ++--
 Documentation/glossary-content.txt |    8 ++++----
 Documentation/user-manual.txt      |    2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e625d6a..e4f16d8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -680,7 +680,7 @@ color.branch::
 color.branch.<slot>::
 	Use customized color for branch coloration. `<slot>` is one of
 	`current` (the current branch), `local` (a local branch),
-	`remote` (a tracking branch in refs/remotes/), `plain` (other
+	`remote` (a remote-tracking branch in refs/remotes/), `plain` (other
 	refs).
 +
 The value for these configuration variables is a list of colors (at most
@@ -1102,7 +1102,7 @@ gui.newbranchtemplate::
 	linkgit:git-gui[1].
 
 gui.pruneduringfetch::
-	"true" if linkgit:git-gui[1] should prune tracking branches when
+	"true" if linkgit:git-gui[1] should prune remote-tracking branches when
 	performing a fetch. The default value is "false".
 
 gui.trustmtime::
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index d159e88..c76e313 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -26,7 +26,7 @@ The ref names and their object names of fetched refs are stored
 in `.git/FETCH_HEAD`.  This information is left for a later merge
 operation done by 'git merge'.
 
-When <refspec> stores the fetched result in tracking branches,
+When <refspec> stores the fetched result in remote-tracking branches,
 the tags that point at these branches are automatically
 followed.  This is done by first fetching from the remote using
 the given <refspec>s, and if the repository has objects that are
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 33e8438..54e7013 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -134,7 +134,7 @@ and if there is not any such variable, the value on `URL: ` line
 in `$GIT_DIR/remotes/<origin>` file is used.
 
 In order to determine what remote branches to fetch (and
-optionally store in the tracking branches) when the command is
+optionally store in the remote-tracking branches) when the command is
 run without any refspec parameters on the command line, values
 of the configuration variable `remote.<origin>.fetch` are
 consulted, and if there aren't any, `$GIT_DIR/remotes/<origin>`
@@ -147,9 +147,9 @@ refs/heads/*:refs/remotes/origin/*
 ------------
 
 A globbing refspec must have a non-empty RHS (i.e. must store
-what were fetched in tracking branches), and its LHS and RHS
+what were fetched in remote-tracking branches), and its LHS and RHS
 must end with `/*`.  The above specifies that all remote
-branches are tracked using tracking branches in
+branches are tracked using remote-tracking branches in
 `refs/remotes/origin/` hierarchy under the same name.
 
 The rule to determine which remote branch to merge after
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 5e4989d..c258ea4 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -146,7 +146,7 @@ With `-n` option, the remote heads are not queried first with
 
 'prune'::
 
-Deletes all stale tracking branches under <name>.
+Deletes all stale remote-tracking branches under <name>.
 These stale branches have already been removed from the remote repository
 referenced by <name>, but are still locally available in
 "remotes/<name>".
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31c78a8..8b169e3 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -177,7 +177,7 @@ On Automatic following
 ~~~~~~~~~~~~~~~~~~~~~~
 
 If you are following somebody else's tree, you are most likely
-using tracking branches (`refs/heads/origin` in traditional
+using remote-tracking branches (`refs/heads/origin` in traditional
 layout, or `refs/remotes/origin/master` in the separate-remote
 layout).  You usually want the tags from the other end.
 
@@ -232,7 +232,7 @@ this case.
 It may well be that among networking people, they may want to
 exchange the tags internal to their group, but in that workflow
 they are most likely tracking with each other's progress by
-having tracking branches.  Again, the heuristic to automatically
+having remote-tracking branches.  Again, the heuristic to automatically
 follow such tags is a good thing.
 
 
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 1f029f8..a76de62 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -131,7 +131,7 @@ to point at the new commit.
 	you have. In such these cases, you do not make a new <<def_merge,merge>>
 	<<def_commit,commit>> but instead just update to his
 	revision. This will happen frequently on a
-	<<def_tracking_branch,tracking branch>> of a remote
+	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
 	<<def_repository,repository>>.
 
 [[def_fetch]]fetch::
@@ -260,7 +260,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	The default upstream <<def_repository,repository>>. Most projects have
 	at least one upstream project which they track. By default
 	'origin' is used for that purpose. New upstream updates
-	will be fetched into remote <<def_tracking_branch,tracking branches>> named
+	will be fetched into remote <<def_remote_tracking_branch,remote-tracking branches>> named
 	origin/name-of-upstream-branch, which you can see using
 	`git branch -r`.
 
@@ -418,11 +418,11 @@ This commit is referred to as a "merge commit", or sometimes just a
 	that each contain very well defined concepts or small incremental yet
 	related changes.
 
-[[def_tracking_branch]]tracking branch::
+[[def_remote_tracking_branch]]remote-tracking branch::
 	A regular git <<def_branch,branch>> that is used to follow changes from
 	another <<def_repository,repository>>. A tracking
 	branch should not contain direct modifications or have local commits
-	made to it. A tracking branch can usually be
+	made to it. A remote-tracking branch can usually be
 	identified as the right-hand-side <<def_ref,ref>> in a Pull:
 	<<def_refspec,refspec>>.
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d5505e8..d7835ca 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -435,7 +435,7 @@ linux-nfs/master
 origin/master
 -------------------------------------------------
 
-If you run "git fetch <remote>" later, the tracking branches for the
+If you run "git fetch <remote>" later, the remote-tracking branches for the
 named <remote> will be updated.
 
 If you examine the file .git/config, you will see that git has added
-- 
1.7.3.2.183.g2e7b0
