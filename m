From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Fix some misspellings
Date: Mon, 3 Nov 2014 21:37:07 +0100 (CET)
Message-ID: <539820010.119837.1415047027651.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 21:37:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlONI-0006ET-3l
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 21:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbaKCUhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 15:37:11 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:58044 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753283AbaKCUhJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2014 15:37:09 -0500
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id BD55E107D52;
	Mon,  3 Nov 2014 21:37:07 +0100 (CET)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net [151.189.21.56])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id C581E112049;
	Mon,  3 Nov 2014 21:37:07 +0100 (CET)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id 9C33645E27;
	Mon,  3 Nov 2014 21:37:07 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-16.arcor-online.net 9C33645E27
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1415047027; bh=lMd7RAVSO4pZO8iby/UEIz6zMiG3SUNsny92Us6xQ+I=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=i/K7G0NRF0758IeQ6HWO8niLuIn6AnSfGJYhd51YxTZteEJJj9+D9JjZmBQQNceYh
	 G+vkXj3dtQWVswhWh246HPEoyE/m1eY7+2TJQCSg4t3jEaVHHHgtosVBLyopLn9gJQ
	 mh2DuvyLr7MSsGo/yjw1N1qsmqWHZQ3f2Qiwuudc=
Received: from [188.99.44.111] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Mon, 3 Nov 2014 21:37:07 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.99.44.111
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/RelNotes/2.2.0.txt                        |  6 +++---
 Documentation/config.txt                                | 10 +++++-----
 Documentation/git-bisect-lk2009.txt                     |  4 ++--
 Documentation/git-clean.txt                             |  2 +-
 Documentation/git-cvsimport.txt                         |  2 +-
 Documentation/git-cvsserver.txt                         |  2 +-
 Documentation/git-filter-branch.txt                     |  4 ++--
 Documentation/git-interpret-trailers.txt                |  6 +++---
 Documentation/git-rev-parse.txt                         |  2 +-
 Documentation/git-svn.txt                               |  4 ++--
 Documentation/git-update-index.txt                      |  2 +-
 Documentation/gitattributes.txt                         |  4 ++--
 Documentation/githooks.txt                              |  2 +-
 Documentation/glossary-content.txt                      |  2 +-
 Documentation/howto/recover-corrupted-object-harder.txt |  4 ++--
 Documentation/rev-list-options.txt                      |  2 +-
 Documentation/technical/index-format.txt                |  2 +-
 Documentation/technical/protocol-capabilities.txt       |  2 +-
 contrib/subtree/git-subtree.txt                         |  2 +-
 19 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/RelNotes/2.2.0.txt b/Documentation/RelNotes/2.2.0.txt
index 741e14e..4ce76cc 100644
--- a/Documentation/RelNotes/2.2.0.txt
+++ b/Documentation/RelNotes/2.2.0.txt
@@ -62,7 +62,7 @@ UI, Workflows & Features
    e.g. "hello_BASE_4321.c").
 
  * The temporary files "git mergetools" uses can be placed in a newly
-   creted temporary directory, instead of the current directory, by
+   created temporary directory, instead of the current directory, by
    setting the mergetool.writeToTemp configuration variable.
 
  * "git mergetool" understands "--tool bc" now, as version 4 of
@@ -85,7 +85,7 @@ UI, Workflows & Features
    public repository really point the commits the pusher wanted to,
    without having to "trust" the server.
 
- * "git interpret-trailers" is a new filter to programatically edit
+ * "git interpret-trailers" is a new filter to programmatically edit
     the tail end of the commit log messages.
 
  * "git help everyday" shows the "Everyday Git in 20 commands or so"
@@ -292,6 +292,6 @@ notes for details).
    (merge b12d045 da/mergetool-meld later to maint).
 
  * "git pack-objects" forgot to disable the codepath to generate
-   object recheability bitmap when it needs to split the resulting
+   object reachability bitmap when it needs to split the resulting
    pack.
    (merge 2113471 jk/pack-objects-no-bitmap-when-splitting later to maint).
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7a3294d..e8dd76d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1210,7 +1210,7 @@ gc.autopacklimit::
 	default	value is 50.  Setting this to 0 disables it.
 
 gc.autodetach::
-	Make `git gc --auto` return immediately andrun in background
+	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
 gc.packrefs::
@@ -1357,7 +1357,7 @@ gpg.program::
 	same command-line interface as GPG, namely, to verify a detached
 	signature, "gpg --verify $file - <$signature" is run, and the
 	program is expected to signal a good signature by exiting with
-	code 0, and to generate an ascii-armored detached signature, the
+	code 0, and to generate an ASCII-armored detached signature, the
 	standard input of "gpg -bsau $key" is fed with the contents to be
 	signed, and the program is expected to send the result to its
 	standard output.
@@ -1592,7 +1592,7 @@ http.useragent::
 	Can be overridden by the 'GIT_HTTP_USER_AGENT' environment variable.
 
 http.<url>.*::
-	Any of the http.* options above can be applied selectively to some urls.
+	Any of the http.* options above can be applied selectively to some URLs.
 	For a config key to match a URL, each element of the config key is
 	compared to that of the URL, in the following order:
 +
@@ -1631,8 +1631,8 @@ if the URL is `https://user@example.com/foo/bar` a config key match of
 +
 All URLs are normalized before attempting any matching (the password part,
 if embedded in the URL, is always ignored for matching purposes) so that
-equivalent urls that are simply spelled differently will match properly.
-Environment variable settings always override any matches.  The urls that are
+equivalent URLs that are simply spelled differently will match properly.
+Environment variable settings always override any matches.  The URLs that are
 matched against are those given directly to Git commands.  This means any URLs
 visited as a result of a redirection do not participate in matching.
 
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index afeb86c..0f0c6ff 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -119,7 +119,7 @@ developed and maintained during years or even tens of years by a lot
 of people. And as there are often many people who depend (sometimes
 critically) on such software, regressions are a really big problem.
 
-One such software is the linux kernel. And if we look at the linux
+One such software is the Linux kernel. And if we look at the Linux
 kernel, we can see that a lot of time and effort is spent to fight
 regressions. The release cycle start with a 2 weeks long merge
 window. Then the first release candidate (rc) version is tagged. And
@@ -132,7 +132,7 @@ regressions. And this time is more than 80% of the release cycle
 time. But this is not the end of the fight yet, as of course it
 continues after the release.
 
-And then this is what Ingo Molnar (a well known linux kernel
+And then this is what Ingo Molnar (a well known Linux kernel
 developer) says about his use of git bisect:
 
 _____________
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 8997922..94b6d19 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -98,7 +98,7 @@ clean::
 filter by pattern::
 
    This shows the files and directories to be deleted and issues an
-   "Input ignore patterns>>" prompt. You can input space-seperated
+   "Input ignore patterns>>" prompt. You can input space-separated
    patterns to exclude files and directories from deletion.
    E.g. "*.c *.h" will excludes files end with ".c" and ".h" from
    deletion. When you are satisfied with the filtered result, press
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 260f39f..00a0679 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -219,7 +219,7 @@ Problems related to tags:
 * Multiple tags on the same revision are not imported.
 
 If you suspect that any of these issues may apply to the repository you
-want to imort, consider using cvs2git:
+want to import, consider using cvs2git:
 
 * cvs2git (part of cvs2svn), `http://subversion.apache.org/`
 
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 472f5cb..4961f1a 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -110,7 +110,7 @@ to allow writes to, for example:
 	authdb = /etc/cvsserver/passwd
 
 ------
-The format of these files is username followed by the crypted password,
+The format of these files is username followed by the encrypted password,
 for example:
 
 ------
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 09535f2..73fd9e8 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -451,8 +451,8 @@ characteristics:
 
 * By default The BFG takes full advantage of multi-core machines,
   cleansing commit file-trees in parallel. git-filter-branch cleans
-  commits sequentially (ie in a single-threaded manner), though it
-  _is_ possible to write filters that include their own parallellism,
+  commits sequentially (i.e. in a single-threaded manner), though it
+  _is_ possible to write filters that include their own parallelism,
   in the scripts executed against each commit.
 
 * The http://rtyley.github.io/bfg-repo-cleaner/#examples[command options]
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 81fac3d..d6d9231 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -3,7 +3,7 @@ git-interpret-trailers(1)
 
 NAME
 ----
-git-interpret-trailers - help add stuctured information into commit messages
+git-interpret-trailers - help add structured information into commit messages
 
 SYNOPSIS
 --------
@@ -43,7 +43,7 @@ This means that the trimmed <token> and <value> will be separated by
 
 By default the new trailer will appear at the end of all the existing
 trailers. If there is no existing trailer, the new trailer will appear
-after the commit message part of the ouput, and, if there is no line
+after the commit message part of the output, and, if there is no line
 with only spaces at the end of the commit message part, one blank line
 will be added before the new trailer.
 
@@ -56,7 +56,7 @@ minus signs start the patch part of the message.
 
 When reading trailers, there can be whitespaces before and after the
 token, the separator and the value. There can also be whitespaces
-indide the token and the value.
+inside the token and the value.
 
 Note that 'trailers' do not follow and are not intended to follow many
 rules for RFC 822 headers. For example they do not follow the line
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index fa4a8c3..d6de42f 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -184,7 +184,7 @@ shown.  If the pattern does not contain a globbing character (`?`,
 	consider. Repetitions of this option accumulate exclusion patterns
 	up to the next `--all`, `--branches`, `--tags`, `--remotes`, or
 	`--glob` option (other options or arguments do not clear
-	accumlated patterns).
+	accumulated patterns).
 +
 The patterns given should not begin with `refs/heads`, `refs/tags`, or
 `refs/remotes` when applied to `--branches`, `--tags`, or `--remotes`,
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index af660f9..39e9a18 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -70,8 +70,8 @@ COMMANDS
 --username=<user>;;
 	For transports that SVN handles authentication for (http,
 	https, and plain svn), specify the username.  For other
-	transports (eg svn+ssh://), you must include the username in
-	the URL, eg svn+ssh://foo@svn.bar.com/project
+	transports (e.g. svn+ssh://), you must include the username in
+	the URL, e.g. svn+ssh://foo@svn.bar.com/project
 --prefix=<prefix>;;
 	This allows one to specify a prefix which is prepended
 	to the names of remotes if trunk/branches/tags are
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 82eca6f..929869b 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -170,7 +170,7 @@ may not support it yet.
 	split-index mode is already enabled and `--split-index` is
 	given again, all changes in $GIT_DIR/index are pushed back to
 	the shared index file. This mode is designed for very large
-	indexes that take a signficant amount of time to read or write.
+	indexes that take a significant amount of time to read or write.
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 9b45bda..c892ffa 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -665,7 +665,7 @@ data by examining the beginning of the contents. However, sometimes you
 may want to override its decision, either because a blob contains binary
 data later in the file, or because the content, while technically
 composed of text characters, is opaque to a human reader. For example,
-many postscript files contain only ascii characters, but produce noisy
+many postscript files contain only ASCII characters, but produce noisy
 and meaningless diffs.
 
 The simplest way to mark a file as binary is to unset the diff
@@ -680,7 +680,7 @@ patch, if binary patches are enabled) instead of a regular diff.
 
 However, one may also want to specify other diff driver attributes. For
 example, you might want to use `textconv` to convert postscript files to
-an ascii representation for human viewing, but otherwise treat them as
+an ASCII representation for human viewing, but otherwise treat them as
 binary files. You cannot specify both `-diff` and `diff=ps` attributes.
 The solution is to use the `diff.*.binary` config option:
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d954bf6..9ef2469 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -175,7 +175,7 @@ if the merge failed due to conflicts.
 
 This hook can be used in conjunction with a corresponding pre-commit hook to
 save and restore any form of metadata associated with the working tree
-(eg: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
+(e.g.: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
 for an example of how to do this.
 
 pre-push
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 4e0b971..bf383c2 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -329,7 +329,7 @@ short form, the leading colon `:` is followed by zero or more "magic
 signature" letters (which optionally is terminated by another colon `:`),
 and the remainder is the pattern to match against the path.
 The "magic signature" consists of ASCII symbols that are neither
-alphanumeric, glob, regex special charaters nor colon.
+alphanumeric, glob, regex special characters nor colon.
 The optional colon that terminates the "magic signature" can be
 omitted if the pattern begins with a character that does not belong to
 "magic signature" symbol set and is not a colon.
diff --git a/Documentation/howto/recover-corrupted-object-harder.txt b/Documentation/howto/recover-corrupted-object-harder.txt
index 6f33dac..23e685d 100644
--- a/Documentation/howto/recover-corrupted-object-harder.txt
+++ b/Documentation/howto/recover-corrupted-object-harder.txt
@@ -38,7 +38,7 @@ zlib were failing).
 Reading the zlib source code, I found that "incorrect data check" means
 that the adler-32 checksum at the end of the zlib data did not match the
 inflated data. So stepping the data through zlib would not help, as it
-did not fail until the very end, when we realize the crc does not match.
+did not fail until the very end, when we realize the CRC does not match.
 The problematic bytes could be anywhere in the object data.
 
 The first thing I did was pull the broken data out of the packfile. I
@@ -195,7 +195,7 @@ halfway through:
 -------
 
 I let it run to completion, and got a few more hits at the end (where it
-was munging the crc to match our broken data). So there was a good
+was munging the CRC to match our broken data). So there was a good
 chance this middle hit was the source of the problem.
 
 I confirmed by tweaking the byte in a hex editor, zlib inflating the
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 3301fde..afccfdc 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -160,7 +160,7 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	consider. Repetitions of this option accumulate exclusion patterns
 	up to the next `--all`, `--branches`, `--tags`, `--remotes`, or
 	`--glob` option (other options or arguments do not clear
-	accumlated patterns).
+	accumulated patterns).
 +
 The patterns given should not begin with `refs/heads`, `refs/tags`, or
 `refs/remotes` when applied to `--branches`, `--tags`, or `--remotes`,
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index fe6f316..1250b5c 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -231,5 +231,5 @@ Git index format
     on. Replaced entries may have empty path names to save space.
 
   The remaining index entries after replaced ones will be added to the
-  final index. These added entries are also sorted by entry namme then
+  final index. These added entries are also sorted by entry name then
   stage.
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 0c92dee..6d5424c 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -168,7 +168,7 @@ agent capability). The `X` and `Y` strings may contain any printable
 ASCII characters except space (i.e., the byte range 32 < x < 127), and
 are typically of the form "package/version" (e.g., "git/1.8.3.1"). The
 agent strings are purely informative for statistics and debugging
-purposes, and MUST NOT be used to programatically assume the presence
+purposes, and MUST NOT be used to programmatically assume the presence
 or absence of particular features.
 
 shallow
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 02669b1..8272100 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -114,7 +114,7 @@ split::
 	want.
 	
 	Repeated splits of exactly the same history are
-	guaranteed to be identical (ie. to produce the same
+	guaranteed to be identical (i.e. to produce the same
 	commit ids).  Because of this, if you add new commits
 	and then re-split, the new commits will be attached as
 	commits on top of the history you generated last time,
-- 
1.9.4.msysgit.0
