From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Fix typos in the documentation
Date: Mon, 3 Jan 2011 20:03:34 +0100
Organization: Institute for Numerical Simulation, University of Bonn
Message-ID: <20110103190334.GA3767@gmx.de>
References: <20110102055653.GI19818@gmx.de>
 <1294077450.12519.15.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Jan 03 20:03:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZph6-0006bh-GB
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 20:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab1ACTDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 14:03:39 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:42183 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751353Ab1ACTDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 14:03:39 -0500
Received: (qmail invoked by alias); 03 Jan 2011 19:03:37 -0000
Received: from xdsl-78-35-62-198.netcologne.de (EHLO localhost.localdomain) [78.35.62.198]
  by mail.gmx.net (mp051) with SMTP; 03 Jan 2011 20:03:37 +0100
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX1+4Qc1XvKW4KY1rO7GlZlT1aZtOmPaaBAnPc/UT2r
	liRZXzE46J576T
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1PZpgs-00012a-K5; Mon, 03 Jan 2011 20:03:34 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1294077450.12519.15.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.20 (2010-08-04)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164456>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

Hello Drew,

* Drew Northup wrote on Mon, Jan 03, 2011 at 06:57:30PM CET:
> On Sun, 2011-01-02 at 06:56 +0100, Ralf Wildenhues wrote:
> > --- a/Documentation/RelNotes/1.7.4.txt
> > +++ b/Documentation/RelNotes/1.7.4.txt

> > - * The option parsers of various commands that create new branch (or
> > + * The option parsers of various commands that create new branches (or
> >     rename existing ones to a new name) were too loose and users were
> > -   allowed to call a branch with a name that begins with a dash by
> > -   creative abuse of their command line options, which only lead to
> > -   burn themselves.  The name of a branch cannot begin with a dash
> > -   now.
> > +   allowed to give a branch a name that begins with a dash by creative
> > +   abuse of their command line options, which only led to burn themselves.
> > +   The name of a branch cannot begin with a dash now.

> Ralf,
> Perhaps that should be:
> 
> - * The option parsers of various commands that create new branch (or
> + * The option parsers of various commands that create new branches (or
>     rename existing ones to a new name) were too loose and users were
> -   allowed to call a branch with a name that begins with a dash by
> -   creative abuse of their command line options, which only lead to
> -   burn themselves.  The name of a branch cannot begin with a dash
> -   now.
> +   allowed to give a branch a name that begins with a dash by creative
> +   abuse of their command line options, which only led to burning 
> +   themselves. The name of a branch cannot begin with a dash now.
> 
> (for consistency)?

As far as I can see, the only difference between my and your change is
"burn" vs. "burning" (ignoring trailing white space).  I don't see what
your version is consistent to that mine isn't, but I think that yours
is the grammatically correct way.  I'm not a native speaker though.
Anyway, here's the updated patch.

Thanks,
Ralf

 Documentation/CodingGuidelines           |    2 +-
 Documentation/RelNotes/1.7.4.txt         |    9 ++++-----
 Documentation/config.txt                 |    4 ++--
 Documentation/git-add.txt                |    2 +-
 Documentation/git-bundle.txt             |    2 +-
 Documentation/git-fmt-merge-msg.txt      |    2 +-
 Documentation/git-remote-ext.txt         |   16 ++++++++--------
 Documentation/git-remote-fd.txt          |    8 ++++----
 Documentation/git-svn.txt                |    2 +-
 Documentation/gitmodules.txt             |    2 +-
 Documentation/merge-config.txt           |    2 +-
 Documentation/technical/api-sigchain.txt |    2 +-
 12 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1b1c45d..ba2006d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -157,7 +157,7 @@ Writing Documentation:
    --sort=<key>
    --abbrev[=<n>]
 
- Possibility of multiple occurences is indicated by three dots:
+ Possibility of multiple occurrences is indicated by three dots:
    <file>...
    (One or more of <file>.)
 
diff --git a/Documentation/RelNotes/1.7.4.txt b/Documentation/RelNotes/1.7.4.txt
index b736d39..375fea1 100644
--- a/Documentation/RelNotes/1.7.4.txt
+++ b/Documentation/RelNotes/1.7.4.txt
@@ -8,12 +8,11 @@ Updates since v1.7.3
    docbook-xsl >= 1.73. If you have older versions, you can set
    ASCIIDOC7 and ASCIIDOC_ROFF, respectively.
 
- * The option parsers of various commands that create new branch (or
+ * The option parsers of various commands that create new branches (or
    rename existing ones to a new name) were too loose and users were
-   allowed to call a branch with a name that begins with a dash by
-   creative abuse of their command line options, which only lead to
-   burn themselves.  The name of a branch cannot begin with a dash
-   now.
+   allowed to give a branch a name that begins with a dash by creative
+   abuse of their command line options, which only led to burning
+   themselves.  The name of a branch cannot begin with a dash now.
 
  * System-wide fallback default attributes can be stored in
    /etc/gitattributes; core.attributesfile configuration variable can
diff --git a/Documentation/config.txt b/Documentation/config.txt
index a8759cf..ff7c225 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -892,7 +892,7 @@ diff.wordRegex::
 
 fetch.recurseSubmodules::
 	A boolean value which changes the behavior for fetch and pull, the
-	default is to not recursively fetch populated sumodules unless
+	default is to not recursively fetch populated submodules unless
 	configured otherwise.
 
 fetch.unpackLimit::
@@ -1811,7 +1811,7 @@ submodule.<name>.update::
 
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to enable/disable recursive fetching of this
-	submodule. It can be overriden by using the --[no-]recurse-submodules
+	submodule. It can be overridden by using the --[no-]recurse-submodules
 	command line option to "git fetch" and "git pull".
 	This setting will override that from in the linkgit:gitmodules[5]
 	file.
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 54aaaeb..a03448f 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -333,7 +333,7 @@ likely to introduce confusing changes to the index.
 There are also more complex operations that can be performed. But beware
 that because the patch is applied only to the index and not the working
 tree, the working tree will appear to "undo" the change in the index.
-For example, introducing a a new line into the index that is in neither
+For example, introducing a new line into the index that is in neither
 the HEAD nor the working tree will stage the new line for commit, but
 the line will appear to be reverted in the working tree.
 
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 6266a3a..299007b 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -59,7 +59,7 @@ unbundle <file>::
 
 <git-rev-list-args>::
 	A list of arguments, acceptable to 'git rev-parse' and
-	'git rev-list' (and containg a named ref, see SPECIFYING REFERENCES
+	'git rev-list' (and containing a named ref, see SPECIFYING REFERENCES
 	below), that specifies the specific objects and references
 	to transport.  For example, `master{tilde}10..master` causes the
 	current master reference to be packaged along with all objects
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 40dba8c..75adf7a 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -57,7 +57,7 @@ merge.log::
 	In addition to branch names, populate the log message with at
 	most the specified number of one-line descriptions from the
 	actual commits that are being merged.  Defaults to false, and
-	true is a synoym for 20.
+	true is a synonym for 20.
 
 merge.summary::
 	Synonym to `merge.log`; this is deprecated and will be removed in
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index f4fbf67..2d65cfe 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -15,12 +15,12 @@ This remote helper uses the specified 'program' to connect
 to a remote git server.
 
 Data written to stdin of this specified 'program' is assumed
-to be sent to git:// server, git-upload-pack, git-receive-pack
+to be sent to a git:// server, git-upload-pack, git-receive-pack
 or git-upload-archive (depending on situation), and data read
 from stdout of this program is assumed to be received from
 the same service.
 
-Command and arguments are separated by unescaped space.
+Command and arguments are separated by an unescaped space.
 
 The following sequences have a special meaning:
 
@@ -39,19 +39,19 @@ The following sequences have a special meaning:
 	git-upload-pack, or git-upload-archive) of the service
 	git wants to invoke.
 
-'%G' (must be first characters in argument)::
+'%G' (must be the first characters in an argument)::
 	This argument will not be passed to 'program'. Instead, it
-	will cause helper to start by sending git:// service request to
-	remote side with service field set to approiate value and
-	repository field set to rest of the argument. Default is not to send
-	such request.
+	will cause the helper to start by sending git:// service requests to
+	the remote side with the service field set to an appropriate value and
+	the repository field set to rest of the argument. Default is not to send
+	such a request.
 +
 This is useful if remote side is git:// server accessed over
 some tunnel.
 
 '%V' (must be first characters in argument)::
 	This argument will not be passed to 'program'. Instead it sets
-	the vhost field in git:// service request (to rest of the argument).
+	the vhost field in the git:// service request (to rest of the argument).
 	Default is not to send vhost in such request (if sent).
 
 ENVIRONMENT VARIABLES:
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index abc4944..4aecd4d 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -11,20 +11,20 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This helper uses specified file descriptors to connect to remote git server.
+This helper uses specified file descriptors to connect to a remote git server.
 This is not meant for end users but for programs and scripts calling git
 fetch, push or archive.
 
-If only <infd> is given, it is assumed to be bidirectional socket connected
+If only <infd> is given, it is assumed to be a bidirectional socket connected
 to remote git server (git-upload-pack, git-receive-pack or
 git-upload-achive). If both <infd> and <outfd> are given, they are assumed
-to be pipes connected to remote git server (<infd> being the inbound pipe
+to be pipes connected to a remote git server (<infd> being the inbound pipe
 and <outfd> being the outbound pipe.
 
 It is assumed that any handshaking procedures have already been completed
 (such as sending service request for git://) before this helper is started.
 
-<anything> can be any string. It is ignored. It is meant for provoding
+<anything> can be any string. It is ignored. It is meant for providing
 information to user in the URL in case that URL is displayed in some
 context.
 
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 139d314..254d044 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -613,7 +613,7 @@ old references to SVN revision numbers in existing documentation, bug
 reports and archives.  If you plan to eventually migrate from SVN to git
 and are certain about dropping SVN history, consider
 linkgit:git-filter-branch[1] instead.  filter-branch also allows
-reformating of metadata for ease-of-reading and rewriting authorship
+reformatting of metadata for ease-of-reading and rewriting authorship
 info for non-"svn.authorsFile" users.
 
 svn.useSvmProps::
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 6c93202..6897794 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -49,7 +49,7 @@ submodule.<name>.fetchRecurseSubmodules::
 	submodule. If this option is also present in the submodules entry in
 	.git/config of the superproject, the setting there will override the
 	one found in .gitmodules.
-	Both settings can be overriden on the command line by using the
+	Both settings can be overridden on the command line by using the
 	"--[no-]recurse-submodules" option to "git fetch" and "git pull"..
 
 submodule.<name>.ignore::
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 92772e7..1e5c22c 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -10,7 +10,7 @@ merge.log::
 	In addition to branch names, populate the log message with at
 	most the specified number of one-line descriptions from the
 	actual commits that are being merged.  Defaults to false, and
-	true is a synoym for 20.
+	true is a synonym for 20.
 
 merge.renameLimit::
 	The number of files to consider when performing rename detection
diff --git a/Documentation/technical/api-sigchain.txt b/Documentation/technical/api-sigchain.txt
index 535cdff..9e1189e 100644
--- a/Documentation/technical/api-sigchain.txt
+++ b/Documentation/technical/api-sigchain.txt
@@ -32,7 +32,7 @@ and installation code should look something like:
   }
 ------------------------------------------
 
-Handlers are given the typdef of sigchain_fun. This is the same type
+Handlers are given the typedef of sigchain_fun. This is the same type
 that is given to signal() or sigaction(). It is perfectly reasonable to
 push SIG_DFL or SIG_IGN onto the stack.
 
-- 
1.7.4.rc0
