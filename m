From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Fix typos in technical documentation.
Date: Sun, 31 Jan 2010 14:24:39 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20100131132438.GD23605@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 14:27:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbZqH-0004zo-8w
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 14:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab0AaNYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 08:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425Ab0AaNYs
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 08:24:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:57697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752446Ab0AaNYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 08:24:46 -0500
Received: (qmail invoked by alias); 31 Jan 2010 13:24:42 -0000
Received: from xdsl-89-0-173-135.netcologne.de (EHLO localhost.localdomain) [89.0.173.135]
  by mail.gmx.net (mp006) with SMTP; 31 Jan 2010 14:24:42 +0100
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX19e4s4bwQBeQvRCs2qnQrgV0DsfM9G2w8BHzlHpIG
	m0A5zKup8oObyZ
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1NbZn5-0006uk-BE
	for git@vger.kernel.org; Sun, 31 Jan 2010 14:24:39 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
X-GMX-UID: nIZbc4FTYW0/Eq/WsWZp725xamthcxsN
X-Flags: 1000
User-Agent: Mutt/1.5.20 (2009-10-28)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138543>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

Hi there,

stumbled upon a couple of these, then grepped for the rest
in Documentation/.

Cheers, and thanks for git,
Ralf

 Documentation/diff-format.txt                     |    2 +-
 Documentation/git-bisect-lk2009.txt               |    2 +-
 Documentation/git-fast-export.txt                 |    2 +-
 Documentation/git-fast-import.txt                 |    8 ++++----
 Documentation/git-http-backend.txt                |    2 +-
 Documentation/git-remote-helpers.txt              |    2 +-
 Documentation/git-rev-parse.txt                   |    2 +-
 Documentation/git-submodule.txt                   |    2 +-
 Documentation/rev-list-options.txt                |    8 ++++----
 Documentation/technical/api-run-command.txt       |    2 +-
 Documentation/technical/pack-protocol.txt         |   10 +++++-----
 Documentation/technical/protocol-capabilities.txt |    4 ++--
 Documentation/user-manual.txt                     |    2 +-
 13 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index b717124..15c7e79 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -19,7 +19,7 @@ git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
 git-diff-files [<pattern>...]::
         compares the index and the files on the filesystem.
 
-The "git-diff-tree" command begins its ouput by printing the hash of
+The "git-diff-tree" command begins its output by printing the hash of
 what is being compared. After that, all the commands print one output
 line per changed file.
 
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 6b7b2e5..86b3015 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -799,7 +799,7 @@ fixed in the "main" branch by commit "F"?
 The result of such a bisection would be that we would find that H is
 the first bad commit, when in fact it's B. So that would be wrong!
 
-And yes it's can happen in practice that people working on one branch
+And yes it can happen in practice that people working on one branch
 are not aware that people working on another branch fixed a bug! It
 could also happen that F fixed more than one bug or that it is a
 revert of some big development effort that was not ready to be
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index c24e14b..98ec6b5 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -37,7 +37,7 @@ unsigned, with 'verbatim', they will be silently exported
 and with 'warn', they will be exported, but you will see a warning.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
-	Specify how to handle tags whose tagged objectis filtered out.
+	Specify how to handle tags whose tagged object is filtered out.
 	Since revisions and files to export can be limited by path,
 	tagged objects may be filtered completely.
 +
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index ff4022c..fa7d2fe 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -152,7 +152,7 @@ fast-forward update, fast-import will skip updating that ref and instead
 prints a warning message.  fast-import will always attempt to update all
 branch refs, and does not stop on the first failure.
 
-Branch updates can be forced with \--force, but its recommended that
+Branch updates can be forced with \--force, but it's recommended that
 this only be used on an otherwise quiet repository.  Using \--force
 is not necessary for an initial import into an empty repository.
 
@@ -267,7 +267,7 @@ is always copied into the identity string at the time it is being
 created by fast-import.  There is no way to specify a different time or
 timezone.
 +
-This particular format is supplied as its short to implement and
+This particular format is supplied as it's short to implement and
 may be useful to a process that wants to create a new commit
 right now, without needing to use a working directory or
 'git update-index'.
@@ -420,7 +420,7 @@ quoting or escaping syntax is supported within `<committish>`.
 Here `<committish>` is any of the following:
 
 * The name of an existing branch already in fast-import's internal branch
-  table.  If fast-import doesn't know the name, its treated as a SHA-1
+  table.  If fast-import doesn't know the name, it's treated as a SHA-1
   expression.
 
 * A mark reference, `:<idnum>`, where `<idnum>` is the mark number.
@@ -759,7 +759,7 @@ assigned mark.
 
 The mark command is optional here as some frontends have chosen
 to generate the Git SHA-1 for the blob on their own, and feed that
-directly to `commit`.  This is typically more work than its worth
+directly to `commit`.  This is typically more work than it's worth
 however, as marks are inexpensive to store and easy to use.
 
 `data`
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 07931c6..5238820 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -14,7 +14,7 @@ DESCRIPTION
 -----------
 A simple CGI program to serve the contents of a Git repository to Git
 clients accessing the repository over http:// and https:// protocols.
-The program supports clients fetching using both the smart HTTP protcol
+The program supports clients fetching using both the smart HTTP protocol
 and the backwards-compatible dumb HTTP protocol, as well as clients
 pushing using the smart HTTP protocol.
 
diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 4685a89..1b5f61a 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -25,7 +25,7 @@ Commands are given by the caller on the helper's standard input, one per line.
 
 'capabilities'::
 	Lists the capabilities of the helper, one per line, ending
-	with a blank line. Each capability may be preceeded with '*'.
+	with a blank line. Each capability may be preceded with '*'.
 	This marks them mandatory for git version using the remote
 	helper to understand (unknown mandatory capability is fatal
 	error).
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index e7845d4..fc73152 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -33,7 +33,7 @@ OPTIONS
 --stop-at-non-option::
 	Only meaningful in `--parseopt` mode.  Lets the option parser stop at
 	the first non-option argument.  This can be used to parse sub-commands
-	that take options themself.
+	that take options themselves.
 
 --sq-quote::
 	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 63aa694..2502531 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -218,7 +218,7 @@ OPTIONS
 	This option is only valid for the update command.
 	Rebase the current branch onto the commit recorded in the
 	superproject. If this option is given, the submodule's HEAD will not
-	be detached. If a a merge failure prevents this process, you will have
+	be detached. If a merge failure prevents this process, you will have
 	to resolve these failures with linkgit:git-rebase[1].
 	If the key `submodule.$name.update` is set to `rebase`, this option is
 	implicit.
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 3ef7117..6e9baf8 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -233,27 +233,27 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `$GIT_DIR/refs/heads` are listed
 	on the command line as '<commit>'. If `pattern` is given, limit
 	branches to ones matching given shell glob. If pattern lacks '?',
-	'*', or '[', '/*' at the end is impiled.
+	'*', or '[', '/*' at the end is implied.
 
 --tags[=pattern]::
 
 	Pretend as if all the refs in `$GIT_DIR/refs/tags` are listed
 	on the command line as '<commit>'. If `pattern` is given, limit
 	tags to ones matching given shell glob. If pattern lacks '?', '*',
-	or '[', '/*' at the end is impiled.
+	or '[', '/*' at the end is implied.
 
 --remotes[=pattern]::
 
 	Pretend as if all the refs in `$GIT_DIR/refs/remotes` are listed
 	on the command line as '<commit>'. If `pattern`is given, limit
 	remote tracking branches to ones matching given shell glob.
-	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
+	If pattern lacks '?', '*', or '[', '/*' at the end is implied.
 
 --glob=glob-pattern::
 	Pretend as if all the refs matching shell glob `glob-pattern`
 	are listed on the command line as '<commit>'. Leading 'refs/',
 	is automatically prepended if missing. If pattern lacks '?', '*',
-	or '[', '/*' at the end is impiled.
+	or '[', '/*' at the end is implied.
 
 
 ifndef::git-rev-list[]
diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index b26c281..68bf4ca 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -51,7 +51,7 @@ The functions above do the following:
   ENOENT; a diagnostic is printed only if .silent_exec_failure is 0.
 
 . Otherwise, the program is run. If it terminates regularly, its exit
-  code is returned. No diagnistic is printed, even if the exit code is
+  code is returned. No diagnostic is printed, even if the exit code is
   non-zero.
 
 . If the program terminated due to a signal, then the return value is the
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 7950eee..9a5cdaf 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -149,7 +149,7 @@ advertisement list at all, but other refs may still appear.
 The stream MUST include capability declarations behind a NUL on the
 first ref. The peeled value of a ref (that is "ref^{}") MUST be
 immediately after the ref itself, if presented. A conforming server
-MUST peel the ref if its an annotated tag.
+MUST peel the ref if it's an annotated tag.
 
 ----
   advertised-refs  =  (no-refs / list-of-refs)
@@ -261,7 +261,7 @@ Without either multi_ack or multi_ack_detailed:
 
  * upload-pack sends "NAK" on a flush-pkt if no common object
    has been found yet.  If one has been found, and thus an ACK
-   was already sent, its silent on the flush-pkt.
+   was already sent, it's silent on the flush-pkt.
 
 After the client has gotten enough ACK responses that it can determine
 that the server has enough information to send an efficient packfile
@@ -271,9 +271,9 @@ as common with the server, or the --date-order queue is empty), or the
 client determines that it wants to give up (in the canonical implementation,
 this is determined when the client sends 256 'have' lines without getting
 any of them ACKed by the server - meaning there is nothing in common and
-the server should just send all it's objects), then the client will send
+the server should just send all of its objects), then the client will send
 a 'done' command.  The 'done' command signals to the server that the client
-is ready to receive it's packfile data.
+is ready to receive its packfile data.
 
 However, the 256 limit *only* turns on in the canonical client
 implementation if we have received at least one "ACK %s continue"
@@ -286,7 +286,7 @@ ACK after 'done' if there is at least one common base and multi_ack or
 multi_ack_detailed is enabled. The server always sends NAK after 'done'
 if there is no common base found.
 
-Then the server will start sending it's packfile data.
+Then the server will start sending its packfile data.
 
 ----
   server-response = *ack_multi ack / nak
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 1892d3e..fd1a593 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -60,7 +60,7 @@ doesn't, as in the following diagram:
 If the client wants x,y and starts out by saying have F,S, the server
 doesn't know what F,S is.  Eventually the client says "have d" and
 the server sends "ACK d continue" to let the client know to stop
-walking down that line (so don't send c-b-a), but its not done yet,
+walking down that line (so don't send c-b-a), but it's not done yet,
 it needs a base for x. The client keeps going with S-R-Q, until a
 gets reached, at which point the server has a clear base and it all
 ends.
@@ -181,7 +181,7 @@ delete-refs
 -----------
 
 If the server sends back the 'delete-refs' capability, it means that
-it is capable of accepting an zero-id value as the target
+it is capable of accepting a zero-id value as the target
 value of a reference update.  It is not sent back by the client, it
 simply informs the client that it can be sent zero-id values
 to delete references.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b169836..517daca 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1196,7 +1196,7 @@ the time, you will want to commit your changes before you can merge,
 and if you don't, then linkgit:git-stash[1] can take these changes
 away while you're doing the merge, and reapply them afterwards.
 
-If the changes are independant enough, Git will automatically complete
+If the changes are independent enough, Git will automatically complete
 the merge and commit the result (or reuse an existing commit in case
 of <<fast-forwards,fast-forward>>, see below). On the other hand,
 if there are conflicts--for example, if the same file is
-- 
1.7.0.rc1.1.g28185
