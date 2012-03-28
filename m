From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] correct spelling: an URL -> a URL
Date: Wed, 28 Mar 2012 10:41:54 +0200
Message-ID: <87iphpunfx.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 10:42:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCoSI-0001tJ-8A
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 10:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001Ab2C1ImE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 04:42:04 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:44059 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab2C1ImD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 04:42:03 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id BBAD7D480CC
	for <git@vger.kernel.org>; Wed, 28 Mar 2012 10:41:55 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 2A55F60064
	for <git@vger.kernel.org>; Wed, 28 Mar 2012 10:41:54 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194111>


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
I noticed one of these while reading the submodule documentation,
so fixed all of them.

 Documentation/git-submodule.txt             |    2 +-
 Documentation/gitmodules.txt                |    4 ++--
 Documentation/howto/using-merge-subtree.txt |    2 +-
 contrib/svn-fe/svn-fe.txt                   |    2 +-
 http.c                                      |    2 +-
 http.h                                      |    2 +-
 perl/Git.pm                                 |    2 +-
 transport.c                                 |    2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b729649..c243ee5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -190,7 +190,7 @@ commit for each submodule.
 sync::
 	Synchronizes submodules' remote URL configuration setting
 	to the value specified in .gitmodules. It will only affect those
-	submodules which already have an url entry in .git/config (that is the
+	submodules which already have a URL entry in .git/config (that is the
 	case when they are initialized or freshly added). This is useful when
 	submodule URLs change upstream and you need to update your local
 	repositories accordingly.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 4040941..4e1fd52 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -28,7 +28,7 @@ submodule.<name>.path::
 	be unique within the .gitmodules file.

 submodule.<name>.url::
-	Defines an url from where the submodule repository can be cloned.
+	Defines a URL from which the submodule repository can be cloned.
 	This may be either an absolute URL ready to be passed to
 	linkgit:git-clone[1] or (if it begins with ./ or ../) a location
 	relative to the superproject's origin repository.
@@ -84,7 +84,7 @@ Consider the following .gitmodules file:

 This defines two submodules, `libfoo` and `libbar`. These are expected to
 be checked out in the paths 'include/foo' and 'include/bar', and for both
-submodules an url is specified which can be used for cloning the submodules.
+submodules a URL is specified which can be used for cloning the submodules.

 SEE ALSO
 --------
diff --git a/Documentation/howto/using-merge-subtree.txt b/Documentation/howto/using-merge-subtree.txt
index 2933056..1ae8d12 100644
--- a/Documentation/howto/using-merge-subtree.txt
+++ b/Documentation/howto/using-merge-subtree.txt
@@ -25,7 +25,7 @@ What you want is the 'subtree' merge strategy, which helps you in such a
 situation.

 In this example, let's say you have the repository at `/path/to/B` (but
-it can be an URL as well, if you want). You want to merge the 'master'
+it can be a URL as well, if you want). You want to merge the 'master'
 branch of that repository to the `dir-B` subdirectory in your current
 branch.

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 2dd27ce..1128ab2 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -51,7 +51,7 @@ as committer, where 'user' is the value of the `svn:author` property
 and 'UUID' the repository's identifier.

 To support incremental imports, 'svn-fe' puts a `git-svn-id` line at
-the end of each commit log message if passed an url on the command
+the end of each commit log message if passed a URL on the command
 line.  This line has the form `git-svn-id: URL@REVNO UUID`.

 The resulting repository will generally require further processing
diff --git a/http.c b/http.c
index 8ac8eb6..f3f83d7 100644
--- a/http.c
+++ b/http.c
@@ -829,7 +829,7 @@ int http_get_strbuf(const char *url, struct strbuf *result, int options)
 }

 /*
- * Downloads an url and stores the result in the given file.
+ * Downloads a URL and stores the result in the given file.
  *
  * If a previous interrupted download is detected (i.e. a previous temporary
  * file is still around) the download is resumed.
diff --git a/http.h b/http.h
index 0b61653..915c286 100644
--- a/http.h
+++ b/http.h
@@ -127,7 +127,7 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 #define HTTP_NOAUTH	5

 /*
- * Requests an url and stores the result in a strbuf.
+ * Requests a URL and stores the result in a strbuf.
  *
  * If the result pointer is NULL, a HTTP HEAD request is made instead of GET.
  */
diff --git a/perl/Git.pm b/perl/Git.pm
index f7ce511..497f420 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -691,7 +691,7 @@ The hash is in the format C<refname =\> hash>. For tags, the C<refname> entry
 contains the tag object while a C<refname^{}> entry gives the tagged objects.

 C<REPOSITORY> has the same meaning as the appropriate C<git-ls-remote>
-argument; either an URL or a remote name (if called on a repository instance).
+argument; either a URL or a remote name (if called on a repository instance).
 C<GROUPS> is an optional arrayref that can contain 'tags' to return all the
 tags and/or 'heads' to return all the heads. C<REFGLOB> is an optional array
 of strings containing a shell-like glob to further limit the refs returned in
diff --git a/transport.c b/transport.c
index 181f8f2..ea9dcb6 100644
--- a/transport.c
+++ b/transport.c
@@ -1154,7 +1154,7 @@ int transport_disconnect(struct transport *transport)
 }

 /*
- * Strip username (and password) from an url and return
+ * Strip username (and password) from a URL and return
  * it in a newly allocated string.
  */
 char *transport_anonymize_url(const char *url)
--
1.7.9.3
