From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] Documentation: reorganize documentation of URLs
 understood by git
Date: Tue, 6 Apr 2010 01:06:07 -0500
Message-ID: <20100406060606.GA26629@progeny.tock>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com>
 <20100329191832.GA26842@progeny.tock>
 <f3271551003291224s7fb0d8d3sce75b7c893fabfa8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 08:05:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz1v1-0000y2-Os
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 08:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664Ab0DFGFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 02:05:43 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44651 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab0DFGFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 02:05:41 -0400
Received: by gwb19 with SMTP id 19so1623822gwb.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 23:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YYJ8oXNGQIjj9C2iMY+8w/zQPZUOlklXHf9aKs2ePLM=;
        b=IGSWHOmBx4OcX7JimQCa2EPCoF79p4QkzqctOMuoHGez3choUxDgDIx9T0hAoWCUJ6
         Bojtw66yXmxNQvY7bx0yZZfOmo3NpNYDRmUl+EM7f16ZAKw/50Y14/m8PRh1yNIEz6qf
         HMo0uUUUh9rgzTgXf18Tos+LzWyJhnDnqEsGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZNFlfTZ3uFWytEQ1phpm36Ud3uYTjjM5HpE9se3LOsoJP2JvNvhImhro+4tM5lzoDx
         K95HkRW5C/Dnzo8EHn6VixVCCaYbLXA98XfbvZ/pJLUq4vJBHgseqIYslA3RKkv/yT8Q
         Mp/KuGnomKDRi451dErFg9FfttKDlTGy7j/LY=
Received: by 10.100.245.28 with SMTP id s28mr15692565anh.190.1270533939907;
        Mon, 05 Apr 2010 23:05:39 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2147959iwn.8.2010.04.05.23.05.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 23:05:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3271551003291224s7fb0d8d3sce75b7c893fabfa8@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144102>

Currently, the git documentation includes several copies of the same
explanation of the format of git URLs and git remotes.  On one hand,
this makes some manual pages (e.g., git-fetch(1) and git-pull(1))
appear longer than they really ought to be, and on the other hand, it
makes it difficult to find a single appropriate page to link to online
to answer questions about these topics.

So add a new giturl(7) page describing the format of URLs understood
by git, move the explanation of remote nicknames to git-remote(1), and
replace urls.txt and urls-remote.txt with pointers to these pages.

While at it, add some explanation of the new mechanisms for accessing
a repository using a third-party tool.  This is meant to be more
useful for users learning to use git than for tool authors, but with
some tweaks it should be useful for the latter, too.

This documentation was improved with feedback from Ilari, Ram,
Sverre, and Daniel.  It is still very rough.

Cc: Daniel Barkalow <barkalow@iabervon.org>
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Here is the suggested page explaining URLs recognized by git I mentione=
d
before.  It was harder to find time this weekend for this then I though=
t
--- sorry.

About half of the patch is taken up by moving text from urls-remotes.tx=
t
to git-remote.txt.  If anyone has ideas for making this more convenient
to read, I=E2=80=99m all ears.

The main idea driving this for me is that the reference manual should b=
e
something that a sufficiently interested person could read from cover t=
o
cover.  As it is, there=E2=80=99s too much repetition for that.  I also=
 would
like each topic to be documented clearly and thoroughly in an easy-to-f=
ind
place; it seems unlikely this achieves those first two criteria, but at
least this way I think the information about Git URLs should be easy to
find.

Suggestions on language and organization are especially welcome.  This
is just to get the ball rolling; hopefully someone more capable of
writing clear documentation can help meld the page into something
people can use.

Patch is against master.

Thoughts?
Jonathan

 Documentation/Makefile         |    2 +-
 Documentation/git-remote.txt   |  109 ++++++++++++++++++++++++++++++++=
++++++-
 Documentation/giturl.txt       |  105 ++++++++++++++++++++++++++++++++=
++++++
 Documentation/urls-remotes.txt |   95 +-------------------------------=
---
 Documentation/urls.txt         |   86 ++-----------------------------
 5 files changed, 218 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/giturl.txt
 rewrite Documentation/urls-remotes.txt (99%)
 rewrite Documentation/urls.txt (98%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 8a8a395..97c41ed 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -4,7 +4,7 @@ MAN1_TXT=3D \
 	gitk.txt git.txt
 MAN5_TXT=3Dgitattributes.txt gitignore.txt gitmodules.txt githooks.txt=
 \
 	gitrepository-layout.txt
-MAN7_TXT=3Dgitcli.txt gittutorial.txt gittutorial-2.txt \
+MAN7_TXT=3Dgitcli.txt giturl.txt gittutorial.txt gittutorial-2.txt \
 	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
 	gitdiffcore.txt gitworkflows.txt
=20
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index 3fc599c..352e762 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -146,13 +146,115 @@ be updated.  (See linkgit:git-config[1]).
 +
 With `--prune` option, prune all the remotes that are updated.
=20
+REMOTES[[REMOTES]]
+------------------
+
+The name of one of the following can be used by the various git
+commands instead of a URL as `<repository>` argument:
+
+* a remote in the git configuration file: `$GIT_DIR/config`,
+* a file in the `$GIT_DIR/remotes` directory, or
+* a file in the `$GIT_DIR/branches` directory.
+
+All of these also allow you to omit the refspec from the command line
+because they each contain a refspec which git will use by default.
+
+Named remote in configuration file
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can choose to provide the name of a remote which you had previousl=
y
+configured using 'git remote', linkgit:git-config[1]
+or by a manual edit to the `$GIT_DIR/config` file.  The URL of
+this remote will be used to access the repository.  The refspec
+of this remote will be used by default when you do
+not provide a refspec on the command line.  The section in the
+config file would appear like this:
+
+------------
+	[remote "<name>"]
+		vcs =3D <transport>
+		url =3D <url>
+		pushurl =3D <pushurl>
+		push =3D <refspec>
+		fetch =3D <refspec>
+------------
+
+If no 'vcs' item is present, the 'url' is mandatory and identifies
+the repository.
+Any URL understood by git will work (see linkgit:giturl[7])
+except for the name of a remote.
+
+The `<pushurl>` is used for pushes only. It is optional and defaults
+to `<url>`.
+
+A 'vcs' item can be used to request that a particular
+'git remote-`<transport>`' helper (see linkgit:git-remote-helpers[7])
+be used to communicate with the remote repository.
+This facility is intended for interoperability with version control
+systems that require more configuration than a URL to identify a repos=
itory.
+The 'url' variable in such a section is optional and its interpretatio=
n
+depends on the helper.
+
+Named file in `$GIT_DIR/remotes`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can choose to provide the name of a
+file in `$GIT_DIR/remotes`.  The URL
+in this file will be used to access the repository.  The refspec
+in this file will be used as default when you do not
+provide a refspec on the command line.  This file should have the
+following format:
+
+------------
+	URL: one of the above URL format
+	Push: <refspec>
+	Pull: <refspec>
+
+------------
+
+`Push:` lines are used by 'git push' and
+`Pull:` lines are used by 'git pull' and 'git fetch'.
+Multiple `Push:` and `Pull:` lines may
+be specified for additional branch mappings.
+
+Named file in `$GIT_DIR/branches`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can choose to provide the name of a
+file in `$GIT_DIR/branches`.
+The URL in this file will be used to access the repository.
+This file should have the following format:
+
+
+------------
+	<url>#<head>
+------------
+
+`<url>` is required; `#<head>` is optional.
+
+Depending on the operation, git will use one of the following
+refspecs, if you don't provide one on the command line.
+`<branch>` is the name of this file in `$GIT_DIR/branches` and
+`<head>` defaults to `master`.
+
+git fetch uses:
+
+------------
+	refs/heads/<head>:refs/heads/<branch>
+------------
+
+git push uses:
+
+------------
+	HEAD:refs/heads/<head>
+------------
=20
 DISCUSSION
 ----------
=20
-The remote configuration is achieved using the `remote.origin.url` and
-`remote.origin.fetch` configuration variables.  (See
-linkgit:git-config[1]).
+The remote configuration managed by 'git remote' is achieved using the
+`remote.origin.url` and `remote.origin.fetch` configuration variables.
+(See linkgit:git-config[1]).
=20
 Examples
 --------
@@ -194,6 +296,7 @@ SEE ALSO
 linkgit:git-fetch[1]
 linkgit:git-branch[1]
 linkgit:git-config[1]
+linkgit:giturl[7]
=20
 Author
 ------
diff --git a/Documentation/giturl.txt b/Documentation/giturl.txt
new file mode 100644
index 0000000..dfe4551
--- /dev/null
+++ b/Documentation/giturl.txt
@@ -0,0 +1,105 @@
+giturl(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+giturl - Specifying remote repositories to Git
+
+SYNOPSIS
+--------
+<transport>://<rest-of-URL>, <host>:<path>, <transport>::<address>, <n=
ickname>
+
+DESCRIPTION
+-----------
+To specify a remote repository using Git's native protocol, one can
+use a traditional-looking URL.
+
+- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
+
+For the SSH protocol, often used with 'git push', use the traditional =
syntax
+supported by 'scp'.  You can optionally specify which user to log in a=
s.
+
+- {startsb}user@{endsb}host.xz:/path/to/repo.git/
+- {startsb}user@{endsb}host.xz:path/to/repo.git/
+
+That syntax does not allow specifying a port number. For this, a more
+verbose URL-style syntax is supported.
+
+- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo=
=2Egit/
+- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/~{startsb}ot=
heruser{endsb}/path/to/repo.git/
+
+Frequently-accessed repositories can be given a short alphanumeric
+nickname.  For example, the parent repository for a new clone is
+automatically given the nickname 'origin'.  See linkgit:git-remote[1] =
for
+details.
+
+- nickname
+
+A path on the current machine can be used directly.  If a repository i=
s
+specified in this way to the linkgit:git-clone[1] command, the clone w=
ill
+automatically use the `--local` option (which see).  The `file://` syn=
tax
+can be used to avoid this behavior.
+
+- /path/to/repo.git/
+- path/to/repo.git/
+
+Other protocols (most notably HTTP) can be specified with the
+`schema://path` syntax.  Support for the 'rsync', 'file', 'git', 'ssh'=
,
+'git+ssh', and 'ssh+git' transports is built in.
+
+If Git was installed with HTTP support, then the 'http', 'https',
+'ftp', and 'ftps' schemata will be supported through helper programs.
+Third-party helpers may support other protocols, for example for
+interaction with other version control systems.  The syntax
+`transport::schema://path` can be used, or `transport://path` if
+the helper is already named after a URL schema.  The
+'git remote-<transport>' helper will be used to service the request,
+with `schema://path` passed as the associated URL.
+See linkgit:git-remote-helpers[7] for details.
+
+- http{startsb}s{endsb}://{startsb}user@{endsb}host.xz{startsb}:port{e=
ndsb}/{startsb}~user/{endsb}path/to/repo.git/
+- ftp{startsb}s{endsb}://{startsb}user@{endsb}host.xz{startsb}:port{en=
dsb}/{startsb}~user/{endsb}path/to/repo.git/
+- file:///path/to/repo.git/
+- rsync://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/re=
po.git/
+- http::http://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/{star=
tsb}~user/{endsb}path/to/repo.git/
+
+If there are a large number of similarly-named remote repositories and
+you want to use a different format for them (such that the URLs you
+use will be rewritten into URLs that work), you can create a
+configuration section of the form:
+
+------------
+	[url "<actual url base>"]
+		insteadOf =3D <other url base>
+------------
+
+For example, with this:
+
+------------
+	[url "git://git.host.xz/"]
+		insteadOf =3D host.xz:/path/to/
+		insteadOf =3D work:
+------------
+
+a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
+rewritten in any context that takes a URL to be "git://git.host.xz/rep=
o.git".
+
+If you want to rewrite URLs for push only, you can create a
+configuration section of the form:
+
+------------
+	[url "<actual url base>"]
+		pushInsteadOf =3D <other url base>
+------------
+
+For example, with this:
+
+------------
+	[url "ssh://example.org/"]
+		pushInsteadOf =3D git://example.org/
+------------
+
+a URL like "git://example.org/path/to/repo.git" will be rewritten to
+"ssh://example.org/path/to/repo.git" for pushes, but pulls will still
+use the original URL.
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remote=
s.txt
dissimilarity index 99%
index 00f7e79..7ba74f0 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -1,94 +1 @@
-include::urls.txt[]
-
-REMOTES[[REMOTES]]
-------------------
-
-The name of one of the following can be used instead
-of a URL as `<repository>` argument:
-
-* a remote in the git configuration file: `$GIT_DIR/config`,
-* a file in the `$GIT_DIR/remotes` directory, or
-* a file in the `$GIT_DIR/branches` directory.
-
-All of these also allow you to omit the refspec from the command line
-because they each contain a refspec which git will use by default.
-
-Named remote in configuration file
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You can choose to provide the name of a remote which you had previousl=
y
-configured using linkgit:git-remote[1], linkgit:git-config[1]
-or even by a manual edit to the `$GIT_DIR/config` file.  The URL of
-this remote will be used to access the repository.  The refspec
-of this remote will be used by default when you do
-not provide a refspec on the command line.  The entry in the
-config file would appear like this:
-
-------------
-	[remote "<name>"]
-		url =3D <url>
-		pushurl =3D <pushurl>
-		push =3D <refspec>
-		fetch =3D <refspec>
-------------
-
-The `<pushurl>` is used for pushes only. It is optional and defaults
-to `<url>`.
-
-Named file in `$GIT_DIR/remotes`
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You can choose to provide the name of a
-file in `$GIT_DIR/remotes`.  The URL
-in this file will be used to access the repository.  The refspec
-in this file will be used as default when you do not
-provide a refspec on the command line.  This file should have the
-following format:
-
-------------
-	URL: one of the above URL format
-	Push: <refspec>
-	Pull: <refspec>
-
-------------
-
-`Push:` lines are used by 'git push' and
-`Pull:` lines are used by 'git pull' and 'git fetch'.
-Multiple `Push:` and `Pull:` lines may
-be specified for additional branch mappings.
-
-Named file in `$GIT_DIR/branches`
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You can choose to provide the name of a
-file in `$GIT_DIR/branches`.
-The URL in this file will be used to access the repository.
-This file should have the following format:
-
-
-------------
-	<url>#<head>
-------------
-
-`<url>` is required; `#<head>` is optional.
-
-Depending on the operation, git will use one of the following
-refspecs, if you don't provide one on the command line.
-`<branch>` is the name of this file in `$GIT_DIR/branches` and
-`<head>` defaults to `master`.
-
-git fetch uses:
-
-------------
-	refs/heads/<head>:refs/heads/<branch>
-------------
-
-git push uses:
-
-------------
-	HEAD:refs/heads/<head>
-------------
-
-
-
-
+include::urls.txt[]
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
dissimilarity index 98%
index 459a394..01ee49b 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -1,81 +1,5 @@
-GIT URLS[[URLS]]
-----------------
-
-One of the following notations can be used
-to name the remote repository:
-
-- rsync://host.xz/path/to/repo.git/
-- http://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- https://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo=
=2Egit/
-- ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/~/path/to/repo.git
-
-SSH is the default transport protocol over the network.  You can
-optionally specify which user to log-in as, and an alternate,
-scp-like syntax is also supported.  Both syntaxes support
-username expansion, as does the native git protocol, but
-only the former supports port specification. The following
-three are identical to the last three above, respectively:
-
-- {startsb}user@{endsb}host.xz:/path/to/repo.git/
-- {startsb}user@{endsb}host.xz:~user/path/to/repo.git/
-- {startsb}user@{endsb}host.xz:path/to/repo.git
-
-To sync with a local directory, you can use:
-
-- /path/to/repo.git/
-- file:///path/to/repo.git/
-
-ifndef::git-clone[]
-They are mostly equivalent, except when cloning.  See
-linkgit:git-clone[1] for details.
-endif::git-clone[]
-
-ifdef::git-clone[]
-They are equivalent, except the former implies --local option.
-endif::git-clone[]
-
-
-If there are a large number of similarly-named remote repositories and
-you want to use a different format for them (such that the URLs you
-use will be rewritten into URLs that work), you can create a
-configuration section of the form:
-
-------------
-	[url "<actual url base>"]
-		insteadOf =3D <other url base>
-------------
-
-For example, with this:
-
-------------
-	[url "git://git.host.xz/"]
-		insteadOf =3D host.xz:/path/to/
-		insteadOf =3D work:
-------------
-
-a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
-rewritten in any context that takes a URL to be "git://git.host.xz/rep=
o.git".
-
-If you want to rewrite URLs for push only, you can create a
-configuration section of the form:
-
-------------
-	[url "<actual url base>"]
-		pushInsteadOf =3D <other url base>
-------------
-
-For example, with this:
-
-------------
-	[url "ssh://example.org/"]
-		pushInsteadOf =3D git://example.org/
-------------
-
-a URL like "git://example.org/path/to/repo.git" will be rewritten to
-"ssh://example.org/path/to/repo.git" for pushes, but pulls will still
-use the original URL.
+GIT URLS[[URLS]]
+----------------
+See linkgit:giturl[7] for an explanation of the supported values for
+`<repository>` (such as `git://host.xz/path`, `http://host.xz/path`,
+and `origin`).
--=20
1.7.0.4.369.g62d9d
