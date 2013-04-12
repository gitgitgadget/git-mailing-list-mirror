From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/10] doc: various spelling fixes
Date: Thu, 11 Apr 2013 23:49:53 -0700
Message-ID: <20130412064953.GB5710@elie.Belkin>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
 <7v4nfch90r.fsf@alter.siamese.dyndns.org>
 <20130412064837.GA5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 08:50:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQXoH-0006iX-0D
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 08:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab3DLGuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 02:50:01 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:54459 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab3DLGt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 02:49:58 -0400
Received: by mail-pd0-f174.google.com with SMTP id p12so1251325pdj.5
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 23:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=v2Isk4bPxg2Axvhbw/X3ukqubXxTodyyqRd92hXvVp8=;
        b=Q/gYrZBUm1AiQJtvaqjK+9FKdO7oTD9rciq7yWHadcphESUv+/HiFYdsXCo2cO0Dq2
         0BEYuHIDu4cMMegjkNYaenpSPvdadwoEpJ18v24rcDJ5kRpxi8fAbtH2zsN5tzgMA6Uf
         p6ftAvTxoj9yqN/P/1RX9b3m5i3BfaXRCY3QxpAmINjJ450+NV/imC2pfVk46w4em2fE
         93Yd7we81lrpEnpp474l0G+r7Kj8CTnc5TuKm4YOFlvD9ou47t7LbvKhFhmVPQcZ9l52
         /xzvGbcDYPbFyFjYSIICKF8mQdJsZbsTgKqlxLZXM00qjaEc9TZ+zuj7iIWk+VOgvYz9
         7uQg==
X-Received: by 10.68.219.65 with SMTP id pm1mr13218139pbc.75.1365749398424;
        Thu, 11 Apr 2013 23:49:58 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id jw10sm7360711pbb.3.2013.04.11.23.49.56
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 23:49:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412064837.GA5710@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220959>

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Date: Fri, 12 Apr 2013 00:36:10 +0200

Most of these were found using Lucas De Marchi's codespell tool.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I like this one.

 Documentation/git-credential.txt              | 2 +-
 Documentation/git-remote-ext.txt              | 2 +-
 Documentation/git-svn.txt                     | 4 ++--
 Documentation/git-tools.txt                   | 2 +-
 Documentation/revisions.txt                   | 2 +-
 Documentation/technical/api-argv-array.txt    | 2 +-
 Documentation/technical/api-credentials.txt   | 2 +-
 Documentation/technical/api-ref-iteration.txt | 2 +-
 gitweb/INSTALL                                | 2 +-
 po/README                                     | 6 +++---
 10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 472f00f6..7da0f13a 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -56,7 +56,7 @@ For example, if we want a password for
 `https://example.com/foo.git`, we might generate the following
 credential description (don't forget the blank line at the end; it
 tells `git credential` that the application finished feeding all the
-infomation it has):
+information it has):
 
 	 protocol=https
 	 host=example.com
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 58b7facb..8cfc748a 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -86,7 +86,7 @@ begins with `ext::`.  Examples:
 	edit .ssh/config.
 
 "ext::socat -t3600 - ABSTRACT-CONNECT:/git-server %G/somerepo"::
-	Represents repository with path /somerepo accessable over
+	Represents repository with path /somerepo accessible over
 	git protocol at abstract namespace address /git-server.
 
 "ext::git-server-alias foo %G/repo"::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1b8b6498..7706d41c 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -245,7 +245,7 @@ first have already been pushed into SVN.
 	patch), "all" (accept all patches), or "quit".
 	+
 	'git svn dcommit' returns immediately if answer if "no" or "quit", without
-	commiting anything to SVN.
+	committing anything to SVN.
 
 'branch'::
 	Create a branch in the SVN repository.
@@ -856,7 +856,7 @@ HANDLING OF SVN BRANCHES
 ------------------------
 If 'git svn' is configured to fetch branches (and --follow-branches
 is in effect), it sometimes creates multiple Git branches for one
-SVN branch, where the addtional branches have names of the form
+SVN branch, where the additional branches have names of the form
 'branchname@nnn' (with nnn an SVN revision number).  These additional
 branches are created if 'git svn' cannot find a parent commit for the
 first commit in an SVN branch, to connect the branch to the history of
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index ad8b823f..78a0d955 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -109,7 +109,7 @@ Others
 
    - *git.el* (contrib/)
 
-   This is an Emacs interface for Git. The user interface is modeled on
+   This is an Emacs interface for Git. The user interface is modelled on
    pcl-cvs. It has been developed on Emacs 21 and will probably need some
    tweaking to work on XEmacs.
 
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 314e25da..b0f72206 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -55,7 +55,7 @@ when you run `git cherry-pick`.
 +
 Note that any of the 'refs/*' cases above may come either from
 the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
-While the ref name encoding is unspecified, UTF-8 is prefered as
+While the ref name encoding is unspecified, UTF-8 is preferred as
 some output processing may assume ref names in UTF-8.
 
 '<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index a959517b..a6b7d83a 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -55,7 +55,7 @@ Functions
 	initial, empty state.
 
 `argv_array_detach`::
-	Detach the argv array from the `struct argv_array`, transfering
+	Detach the argv array from the `struct argv_array`, transferring
 	ownership of the allocated array and strings.
 
 `argv_array_free_detached`::
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 516fda74..c1b42a40 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -160,7 +160,7 @@ int foo_login(struct foo_connection *f)
 		break;
 	default:
 		/*
-		 * Some other error occured. We don't know if the
+		 * Some other error occurred. We don't know if the
 		 * credential is good or bad, so report nothing to the
 		 * credential subsystem.
 		 */
diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
index dbbea95d..aa1c50f1 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -35,7 +35,7 @@ Iteration functions
 * `head_ref_submodule()`, `for_each_ref_submodule()`,
   `for_each_ref_in_submodule()`, `for_each_tag_ref_submodule()`,
   `for_each_branch_ref_submodule()`, `for_each_remote_ref_submodule()`
-  do the same as the functions descibed above but for a specified
+  do the same as the functions described above but for a specified
   submodule.
 
 * `for_each_rawref()` can be used to learn about broken ref and symref.
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 6d454067..08f3dda0 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -244,7 +244,7 @@ for gitweb (in gitweb/README), and gitweb.conf(5) manpage.
   through the GITWEB_CONFIG_SYSTEM environment variable.
 
   Note that if per-instance configuration file exists, then system-wide
-  configuration is _not used at all_.  This is quite untypical and suprising
+  configuration is _not used at all_.  This is quite untypical and surprising
   behavior.  On the other hand changing current behavior would break backwards
   compatibility and can lead to unexpected changes in gitweb behavior.
   Therefore gitweb also looks for common system-wide configuration file,
diff --git a/po/README b/po/README
index c1520e8c..d8c9111c 100644
--- a/po/README
+++ b/po/README
@@ -232,7 +232,7 @@ Shell:
 
        # To interpolate variables:
        details="oh noes"
-       eval_gettext "An error occured: \$details"; echo
+       eval_gettext "An error occurred: \$details"; echo
 
    In addition we have wrappers for messages that end with a trailing
    newline. I.e. you could write the above as:
@@ -242,7 +242,7 @@ Shell:
 
        # To interpolate variables:
        details="oh noes"
-       eval_gettextln "An error occured: \$details"
+       eval_gettextln "An error occurred: \$details"
 
    More documentation about the interface is available in the GNU info
    page: `info '(gettext)sh'`. Looking at git-am.sh (the first shell
@@ -257,7 +257,7 @@ Perl:
 
        use Git::I18N;
        print __("Welcome to Git!\n");
-       printf __("The following error occured: %s\n"), $error;
+       printf __("The following error occurred: %s\n"), $error;
 
    Run `perldoc perl/Git/I18N.pm` for more info.
 
-- 
1.8.2.1
