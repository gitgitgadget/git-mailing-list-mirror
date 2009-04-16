From: Jeff King <peff@peff.net>
Subject: [PATCH] doc/gitattributes: clarify location of config text
Date: Thu, 16 Apr 2009 03:17:12 -0400
Message-ID: <20090416071712.GA26567@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 09:20:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuLs5-0000MH-Lj
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 09:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbZDPHRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 03:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbZDPHRT
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 03:17:19 -0400
Received: from peff.net ([208.65.91.99]:49810 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbZDPHRS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 03:17:18 -0400
Received: (qmail 714 invoked by uid 107); 16 Apr 2009 07:17:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 03:17:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 03:17:12 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116678>

The gitattributes documentation has a section on the "diff"
attribute, with subsections for each of the things you might
want to configure in your diff config section (external
diff, hunk headers, etc). The first such subsection
specifically notes that the definition of the diff driver
should go into $GIT_DIR/config, but subsequent sections do
not.

This location is implied if you are reading the
documentation sequentially, but it is not uncommon for a new
user to jump to (or be referred to) a specific section. For
a new user who does not know git well enough to recognize
the config syntax, it is not clear that those directives
don't also go into the gitattributes file.

This patch just mentions the config file in each subsection,
similar to the way it is mentioned in the first.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a re-send of

  http://article.gmane.org/gmane.comp.version-control.git/115866

which seems to have just been missed.

 Documentation/gitattributes.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b762bba..aaa073e 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -297,7 +297,8 @@ for paths.
 
 Then, you would define a "diff.tex.xfuncname" configuration to
 specify a regular expression that matches a line that you would
-want to appear as the hunk header "TEXT", like this:
+want to appear as the hunk header "TEXT". Add a section to your
+`$GIT_DIR/config` file (or `$HOME/.gitconfig` file) like this:
 
 ------------------------
 [diff "tex"]
@@ -345,7 +346,8 @@ split words in a line, by specifying an appropriate regular expression
 in the "diff.*.wordRegex" configuration variable.  For example, in TeX
 a backslash followed by a sequence of letters forms a command, but
 several such commands can be run together without intervening
-whitespace.  To separate them, use a regular expression such as
+whitespace.  To separate them, use a regular expression in your
+`$GIT_DIR/config` file (or `$HOME/.gitconfig` file) like this:
 
 ------------------------
 [diff "tex"]
@@ -373,7 +375,8 @@ resulting text on stdout.
 
 For example, to show the diff of the exif information of a
 file instead of the binary information (assuming you have the
-exif tool installed):
+exif tool installed), add the following section to your
+`$GIT_DIR/config` file (or `$HOME/.gitconfig` file):
 
 ------------------------
 [diff "jpg"]
-- 
1.6.3.rc0.204.g6bb2
