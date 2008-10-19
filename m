From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] config.txt: alphabetize configuration variable groups
Date: Sat, 18 Oct 2008 21:42:31 -0400
Message-ID: <1224380551.19061.22.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 19 03:50:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrNQr-00058j-2U
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 03:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbYJSBmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 21:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbYJSBmf
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 21:42:35 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:54782 "EHLO
	jankymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752024AbYJSBme (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Oct 2008 21:42:34 -0400
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a1.g.dreamhost.com (Postfix) with ESMTP id 3C287985E0;
	Sat, 18 Oct 2008 18:42:33 -0700 (PDT)
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98588>

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 Documentation/config.txt |   96 +++++++++++++++++++++++-----------------------
 1 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index da18a54..704d1bb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -570,9 +570,6 @@ color.status.<slot>::
 	to red). The values of these variables may be specified as in
 	color.branch.<slot>.
 
-commit.template::
-	Specify a file to use as the template for new commit messages.
-
 color.ui::
 	When set to `always`, always use colors in all git commands which
 	are capable of colored output. When false (or `never`), never. When
@@ -580,6 +577,9 @@ color.ui::
 	terminal. When more specific variables of color.* are set, they always
 	take precedence over this setting. Defaults to false.
 
+commit.template::
+	Specify a file to use as the template for new commit messages.
+
 diff.autorefreshindex::
 	When using 'git-diff' to compare with work tree
 	files, do not consider stat-only change as changed.
@@ -711,18 +711,6 @@ gc.rerereunresolved::
 	kept for this many days when 'git-rerere gc' is run.
 	The default is 15 days.  See linkgit:git-rerere[1].
 
-rerere.autoupdate::
-	When set to true, `git-rerere` updates the index with the
-	resulting contents after it cleanly resolves conflicts using
-	previously recorded resolution.  Defaults to false.
-
-rerere.enabled::
-	Activate recording of resolved conflicts, so that identical
-	conflict hunks can be resolved automatically, should they
-	be encountered again.  linkgit:git-rerere[1] command is by
-	default enabled if you create `rr-cache` directory under
-	`$GIT_DIR`, but can be disabled by setting this option to false.
-
 gitcvs.enabled::
 	Whether the CVS server interface is enabled for this repository.
 	See linkgit:git-cvsserver[1].
@@ -890,6 +878,10 @@ i18n.logOutputEncoding::
 	Character encoding the commit messages are converted to when
 	running 'git-log' and friends.
 
+imap::
+	The configuration variables in the 'imap' section are described
+	in linkgit:git-imap-send[1].
+
 instaweb.browser::
 	Specify the program that will be used to browse your working
 	repository in gitweb. See linkgit:git-instaweb[1].
@@ -925,8 +917,6 @@ man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
 
-include::merge-config.txt[]
-
 man.<tool>.cmd::
 	Specify the command to invoke the specified man viewer. The
 	specified command is evaluated in shell with the man page
@@ -936,6 +926,8 @@ man.<tool>.path::
 	Override the path for the given tool that may be used to
 	display help in the 'man' format. See linkgit:git-help[1].
 
+include::merge-config.txt[]
+
 merge.conflictstyle::
 	Specify the style in which conflicted hunks are written out to
 	working tree files upon merge.  The default is "merge", which
@@ -1052,6 +1044,28 @@ pull.octopus::
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
+receive.fsckObjects::
+	If it is set to true, git-receive-pack will check all received
+	objects. It will abort in the case of a malformed object or a
+	broken link. The result of an abort are only dangling objects.
+	Defaults to false.
+
+receive.unpackLimit::
+	If the number of objects received in a push is below this
+	limit then the objects will be unpacked into loose object
+	files. However if the number of received objects equals or
+	exceeds this limit then the received pack will be stored as
+	a pack, after adding any missing delta bases.  Storing the
+	pack from a push can make the push operation complete faster,
+	especially on slow filesystems.  If not set, the value of
+	`transfer.unpackLimit` is used instead.
+
+receive.denyNonFastForwards::
+	If set to true, git-receive-pack will deny a ref update which is
+	not a fast forward. Use this to prevent such an update via a push,
+	even if that push is forced. This configuration variable is
+	set when initializing a shared repository.
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
@@ -1101,6 +1115,18 @@ repack.usedeltabaseoffset::
 	"false" and repack. Access from old git versions over the
 	native protocol are unaffected by this option.
 
+rerere.autoupdate::
+	When set to true, `git-rerere` updates the index with the
+	resulting contents after it cleanly resolves conflicts using
+	previously recorded resolution.  Defaults to false.
+
+rerere.enabled::
+	Activate recording of resolved conflicts, so that identical
+	conflict hunks can be resolved automatically, should they
+	be encountered again.  linkgit:git-rerere[1] command is by
+	default enabled if you create `rr-cache` directory under
+	`$GIT_DIR`, but can be disabled by setting this option to false.
+
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
@@ -1137,6 +1163,11 @@ tar.umask::
 	archiving user's umask will be used instead.  See umask(2) and
 	linkgit:git-archive[1].
 
+transfer.unpackLimit::
+	When `fetch.unpackLimit` or `receive.unpackLimit` are
+	not set, the value of this variable is used instead.
+	The default value is 100.
+
 url.<base>.insteadOf::
 	Any URL that starts with this value will be rewritten to
 	start, instead, with <base>. In cases where some site serves a
@@ -1165,37 +1196,6 @@ user.signingkey::
 	unchanged to gpg's --local-user parameter, so you may specify a key
 	using any method that gpg supports.
 
-imap::
-	The configuration variables in the 'imap' section are described
-	in linkgit:git-imap-send[1].
-
-receive.fsckObjects::
-	If it is set to true, git-receive-pack will check all received
-	objects. It will abort in the case of a malformed object or a
-	broken link. The result of an abort are only dangling objects.
-	Defaults to false.
-
-receive.unpackLimit::
-	If the number of objects received in a push is below this
-	limit then the objects will be unpacked into loose object
-	files. However if the number of received objects equals or
-	exceeds this limit then the received pack will be stored as
-	a pack, after adding any missing delta bases.  Storing the
-	pack from a push can make the push operation complete faster,
-	especially on slow filesystems.  If not set, the value of
-	`transfer.unpackLimit` is used instead.
-
-receive.denyNonFastForwards::
-	If set to true, git-receive-pack will deny a ref update which is
-	not a fast forward. Use this to prevent such an update via a push,
-	even if that push is forced. This configuration variable is
-	set when initializing a shared repository.
-
-transfer.unpackLimit::
-	When `fetch.unpackLimit` or `receive.unpackLimit` are
-	not set, the value of this variable is used instead.
-	The default value is 100.
-
 web.browser::
 	Specify a web browser that may be used by some commands.
 	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
-- 
1.6.0.2.545.g6cb4a
