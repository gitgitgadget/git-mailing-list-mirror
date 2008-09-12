From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 2/6] convert doc links for server type programmes from linkgit to gitlink
Date: Fri, 12 Sep 2008 12:55:21 +0200
Message-ID: <1221216926-20435-3-git-send-email-git@drmicha.warpmail.net>
References: <1221216926-20435-1-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-2-git-send-email-git@drmicha.warpmail.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 12:57:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6L2-0003pN-LL
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbYILKzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbYILKzx
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:55:53 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57158 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753013AbYILKzw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 06:55:52 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 66429160EAD
	for <git@vger.kernel.org>; Fri, 12 Sep 2008 06:55:51 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 12 Sep 2008 06:55:51 -0400
X-Sasl-enc: fFQwePBgWINiFTHZqUibi7kXMYjjfQG5S1fwjOrbslc1 1221216950
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 697CACFD3;
	Fri, 12 Sep 2008 06:55:50 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.308.gede4c
In-Reply-To: <1221216926-20435-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95700>

For all server type programmes, we use the macro "linkgitasis" which
preserves any dashes:

git-cvsserver
git-daemon
git-receive-pack
git-shell
git-upload-archive
git-upload-pack

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt           |   12 ++++++------
 Documentation/everyday.txt         |    4 ++--
 Documentation/git-cvsimport.txt    |    2 +-
 Documentation/git-cvsserver.txt    |    2 +-
 Documentation/git-push.txt         |    2 +-
 Documentation/gitcvs-migration.txt |    4 ++--
 Documentation/user-manual.txt      |    4 ++--
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 922ac7b..98ca1a1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -691,11 +691,11 @@ rerere.enabled::
 
 gitcvs.enabled::
 	Whether the CVS server interface is enabled for this repository.
-	See linkgit:git-cvsserver[1].
+	See linkgitasis:git-cvsserver[1].
 
 gitcvs.logfile::
 	Path to a log file where the CVS server interface well... logs
-	various stuff. See linkgit:git-cvsserver[1].
+	various stuff. See linkgitasis:git-cvsserver[1].
 
 gitcvs.usecrlfattr::
 	If true, the server will look up the `crlf` attribute for
@@ -721,7 +721,7 @@ gitcvs.dbname::
 	derived from the git repository. The exact meaning depends on the
 	used database driver, for SQLite (which is the default driver) this
 	is a filename. Supports variable substitution (see
-	linkgit:git-cvsserver[1] for details). May not contain semicolons (`;`).
+	linkgitasis:git-cvsserver[1] for details). May not contain semicolons (`;`).
 	Default: '%Ggitcvs.%m.sqlite'
 
 gitcvs.dbdriver::
@@ -730,19 +730,19 @@ gitcvs.dbdriver::
 	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
 	reported *not* to work with 'DBD::mysql'. Experimental feature.
 	May not contain double colons (`:`). Default: 'SQLite'.
-	See linkgit:git-cvsserver[1].
+	See linkgitasis:git-cvsserver[1].
 
 gitcvs.dbuser, gitcvs.dbpass::
 	Database user and password. Only useful if setting 'gitcvs.dbdriver',
 	since SQLite has no concept of database users and/or passwords.
 	'gitcvs.dbuser' supports variable substitution (see
-	linkgit:git-cvsserver[1] for details).
+	linkgitasis:git-cvsserver[1] for details).
 
 gitcvs.dbTableNamePrefix::
 	Database table name prefix.  Prepended to the names of any
 	database tables used, allowing a single database to be used
 	for several repositories.  Supports variable substitution (see
-	linkgit:git-cvsserver[1] for details).  Any non-alphabetic
+	linkgitasis:git-cvsserver[1] for details).  Any non-alphabetic
 	characters will be replaced with underscores.
 
 All gitcvs variables except for 'gitcvs.usecrlfattr' and
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index e598cdd..097760c 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -341,10 +341,10 @@ Repository Administration[[Repository Administration]]
 A repository administrator uses the following tools to set up
 and maintain access to the repository by developers.
 
-  * linkgit:git-daemon[1] to allow anonymous download from
+  * linkgitasis:git-daemon[1] to allow anonymous download from
     repository.
 
-  * linkgit:git-shell[1] can be used as a 'restricted login shell'
+  * linkgitasis:git-shell[1] can be used as a 'restricted login shell'
     for shared central repository users.
 
 link:howto/update-hook-example.txt[update hook howto] has a good
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index b7a8c10..91d51a4 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -32,7 +32,7 @@ any CVS branches, yourself.  It is advisable to specify a named remote via
 -r to separate and protect the incoming branches.
 
 If you intend to set up a shared public repository that all developers can
-read/write, or if you want to use linkgit:git-cvsserver[1], then you
+read/write, or if you want to use linkgitasis:git-cvsserver[1], then you
 probably want to make a bare clone of the imported repository,
 and use the clone as the shared repository.
 See linkgit:gitcvs-migration[7].
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 785779e..72fb93f 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -28,7 +28,7 @@ OPTIONS
 -------
 
 All these options obviously only make sense if enforced by the server side.
-They have been implemented to resemble the linkgit:git-daemon[1] options as
+They have been implemented to resemble the linkgitasis:git-daemon[1] options as
 closely as possible.
 
 --base-path <path>::
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 45c9643..213e05f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -21,7 +21,7 @@ necessary to complete the given refs.
 
 You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
-documentation for linkgit:git-receive-pack[1].
+documentation for linkgitasis:git-receive-pack[1].
 
 
 OPTIONS
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index aaa7ef7..221b5d0 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -100,7 +100,7 @@ Next, give every team member read/write access to this repository.  One
 easy way to do this is to give all the team members ssh access to the
 machine where the repository is hosted.  If you don't want to give them a
 full shell on the machine, there is a restricted shell which only allows
-users to do git pushes and pulls; see linkgit:git-shell[1].
+users to do git pushes and pulls; see linkgitasis:git-shell[1].
 
 Put all the committers in the same group, and make the repository
 writable by that group:
@@ -163,7 +163,7 @@ Providing CVS Access to a git Repository
 ----------------------------------------
 
 It is also possible to provide true CVS access to a git repository, so
-that developers can still use CVS; see linkgit:git-cvsserver[1] for
+that developers can still use CVS; see linkgitasis:git-cvsserver[1] for
 details.
 
 Alternative Development Models
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 08d1310..26525f4 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1865,14 +1865,14 @@ at.  You can then skip to the section
 "<<pushing-changes-to-a-public-repository,Pushing changes to a public
 repository>>", below.
 
-Otherwise, all you need to do is start linkgit:git-daemon[1]; it will
+Otherwise, all you need to do is start linkgitasis:git-daemon[1]; it will
 listen on port 9418.  By default, it will allow access to any directory
 that looks like a git directory and contains the magic file
 git-daemon-export-ok.  Passing some directory paths as git-daemon
 arguments will further restrict the exports to those paths.
 
 You can also run git-daemon as an inetd service; see the
-linkgit:git-daemon[1] man page for details.  (See especially the
+linkgitasis:git-daemon[1] man page for details.  (See especially the
 examples section.)
 
 [[exporting-via-http]]
-- 
1.6.0.1.308.gede4c
