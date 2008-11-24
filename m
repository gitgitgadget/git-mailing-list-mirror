From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] config.txt: alphabetize configuration variable groups
Date: Mon, 24 Nov 2008 02:01:49 -0500
Message-ID: <1227510109.32583.2.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 08:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4VTc-0000Wv-3e
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 08:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbYKXHCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 02:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYKXHCD
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 02:02:03 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:34206 "EHLO
	jankymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751391AbYKXHCB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 02:02:01 -0500
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a4.g.dreamhost.com (Postfix) with ESMTP id 4F029181100;
	Sun, 23 Nov 2008 23:02:00 -0800 (PST)
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101592>

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---

This is an update of the following patch I sent on October 18, which
received no comment:
http://marc.info/?l=git&m=122438056720340&w=2

 Documentation/config.txt |  122 +++++++++++++++++++++++-----------------------
 1 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d536732..c339f56 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -572,9 +572,6 @@ color.status.<slot>::
 	to red). The values of these variables may be specified as in
 	color.branch.<slot>.
 
-commit.template::
-	Specify a file to use as the template for new commit messages.
-
 color.ui::
 	When set to `always`, always use colors in all git commands which
 	are capable of colored output. When false (or `never`), never. When
@@ -582,6 +579,9 @@ color.ui::
 	terminal. When more specific variables of color.* are set, they always
 	take precedence over this setting. Defaults to false.
 
+commit.template::
+	Specify a file to use as the template for new commit messages.
+
 diff.autorefreshindex::
 	When using 'git-diff' to compare with work tree
 	files, do not consider stat-only change as changed.
@@ -714,18 +714,6 @@ gc.rerereunresolved::
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
@@ -917,6 +905,10 @@ i18n.logOutputEncoding::
 	Character encoding the commit messages are converted to when
 	running 'git-log' and friends.
 
+imap::
+	The configuration variables in the 'imap' section are described
+	in linkgit:git-imap-send[1].
+
 instaweb.browser::
 	Specify the program that will be used to browse your working
 	repository in gitweb. See linkgit:git-instaweb[1].
@@ -952,8 +944,6 @@ man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
 
-include::merge-config.txt[]
-
 man.<tool>.cmd::
 	Specify the command to invoke the specified man viewer. The
 	specified command is evaluated in shell with the man page
@@ -963,6 +953,8 @@ man.<tool>.path::
 	Override the path for the given tool that may be used to
 	display help in the 'man' format. See linkgit:git-help[1].
 
+include::merge-config.txt[]
+
 merge.conflictstyle::
 	Specify the style in which conflicted hunks are written out to
 	working tree files upon merge.  The default is "merge", which
@@ -1079,6 +1071,41 @@ pull.octopus::
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
+receive.denyDeletes::
+	If set to true, git-receive-pack will deny a ref update that deletes
+	the ref. Use this to prevent such a ref deletion via a push.
+
+receive.denyNonFastForwards::
+	If set to true, git-receive-pack will deny a ref update which is
+	not a fast forward. Use this to prevent such an update via a push,
+	even if that push is forced. This configuration variable is
+	set when initializing a shared repository.
+
+receive.denyCurrentBranch::
+	If set to true or "refuse", receive-pack will deny a ref update
+	to the currently checked out branch of a non-bare repository.
+	Such a push is potentially dangerous because it brings the HEAD
+	out of sync with the index and working tree. If set to "warn",
+	print a warning of such a push to stderr, but allow the push to
+	proceed. If set to false or "ignore", allow such pushes with no
+	message. Defaults to "warn".
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
@@ -1128,6 +1155,18 @@ repack.usedeltabaseoffset::
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
@@ -1164,6 +1203,11 @@ tar.umask::
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
@@ -1192,50 +1236,6 @@ user.signingkey::
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
-receive.denyDeletes::
-	If set to true, git-receive-pack will deny a ref update that deletes
-	the ref. Use this to prevent such a ref deletion via a push.
-
-receive.denyNonFastForwards::
-	If set to true, git-receive-pack will deny a ref update which is
-	not a fast forward. Use this to prevent such an update via a push,
-	even if that push is forced. This configuration variable is
-	set when initializing a shared repository.
-
-receive.denyCurrentBranch::
-	If set to true or "refuse", receive-pack will deny a ref update
-	to the currently checked out branch of a non-bare repository.
-	Such a push is potentially dangerous because it brings the HEAD
-	out of sync with the index and working tree. If set to "warn",
-	print a warning of such a push to stderr, but allow the push to
-	proceed. If set to false or "ignore", allow such pushes with no
-	message. Defaults to "warn".
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
1.6.0.2.593.g91df
