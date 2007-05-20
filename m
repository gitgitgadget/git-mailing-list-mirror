From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 5/6] Remove whitespace breakage from remaining misc files
Date: Sun, 20 May 2007 12:29:30 +0200
Message-ID: <4650230A.1060407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 12:29:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpifW-00069t-2k
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758928AbXETK3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757093AbXETK3h
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:29:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:41356 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568AbXETK3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:29:36 -0400
Received: by ug-out-1314.google.com with SMTP id 44so893462uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 03:29:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=qh4PoMdALWOgQXZKYca0TRALnTYHBgy7g9TJzrUC0Xj0J3HsU4tJYuRtDfQ1iamN2CFcUnz3uiLdleXZK8HrnzLjIFqKJO1iCE8KXa4g6SpfTRtipIyQYSEH+ajYDxeiiOmoYfCOaZTOvmzB1JuhBZsZmL4dj+BPRS2ikPHYFwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=EIpiHo+3Wz1VzLrZxzsW4mE7y4UHA5k7ToTT/RyVIaAtZYNdaLqujgz3NjekaSJPn7lVZUgJdMh41LyKUHz5BmYqYdwHaEOD6K7xuqz8ufPIB3BInOLaJtvouPffX9ITRfWnXOrM7aqGdP5H8c9dJo9m47JRzq6XLcPDyMaMI2E=
Received: by 10.66.243.4 with SMTP id q4mr2513317ugh.1179656974586;
        Sun, 20 May 2007 03:29:34 -0700 (PDT)
Received: from ?10.0.0.13? ( [151.70.107.76])
        by mx.google.com with ESMTP id 28sm3758906ugc.2007.05.20.03.29.32;
        Sun, 20 May 2007 03:29:33 -0700 (PDT)
User-Agent: Thunderbird 2.0b2 (X11/20070313)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47818>

Using 'git apply --whitespace=strip'

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
  GIT-VERSION-GEN                  |    2 --
  INSTALL                          |    3 +--
  arm/sha1_arm.S                   |    1 -
  config.mak.in                    |    1 -
  contrib/README                   |    1 -
  contrib/blameview/README         |    1 -
  contrib/hooks/post-receive-email |    2 +-
  git-gui/GIT-VERSION-GEN          |    2 --
  git.spec.in                      |    2 +-
  gitweb/README                    |    1 -
  templates/hooks--commit-msg      |    1 -
  templates/hooks--post-receive    |    1 -
  templates/hooks--pre-applypatch  |    1 -
  templates/hooks--pre-commit      |    1 -
  14 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 06c360b..289c806 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -43,5 +43,3 @@ test "$VN" = "$VC" || {
  	echo >&2 "GIT_VERSION = $VN"
  	echo "GIT_VERSION = $VN" >$GVF
  }
-
-
diff --git a/INSTALL b/INSTALL
index 361c65b..95269cc 100644
--- a/INSTALL
+++ b/INSTALL
@@ -31,7 +31,7 @@ Issues of note:
     interactive tools.  None of the core git stuff needs the wrapper,
     it's just a convenient shorthand and while it is documented in some
     places, you can always replace "git commit" with "git-commit"
-   instead.
+   instead.

     But let's face it, most of us don't have GNU interactive tools, and
     even if we had it, we wouldn't know what it does.  I don't think it
@@ -111,4 +111,3 @@ Issues of note:
     would instead give you a copy of what you see at:

  	http://www.kernel.org/pub/software/scm/git/docs/
-
diff --git a/arm/sha1_arm.S b/arm/sha1_arm.S
index a328b73..8c1cb99 100644
--- a/arm/sha1_arm.S
+++ b/arm/sha1_arm.S
@@ -181,4 +181,3 @@ sha_transform:

  .L_sha_K:
  	.word	0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6
-
diff --git a/config.mak.in b/config.mak.in
index eb9d7a5..a3032e3 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -38,4 +38,3 @@ NO_STRCASESTR=@NO_STRCASESTR@
  NO_STRLCPY=@NO_STRLCPY@
  NO_SETENV=@NO_SETENV@
  NO_ICONV=@NO_ICONV@
-
diff --git a/contrib/README b/contrib/README
index e1c0a01..05f291c 100644
--- a/contrib/README
+++ b/contrib/README
@@ -41,4 +41,3 @@ submit a patch to create a subdirectory of contrib/ and put your
  stuff there.

  -jc
-
diff --git a/contrib/blameview/README b/contrib/blameview/README
index 50a6f67..fada5ce 100644
--- a/contrib/blameview/README
+++ b/contrib/blameview/README
@@ -7,4 +7,3 @@ To: Linus Torvalds <torvalds@linux-foundation.org>
  Cc: git@vger.kernel.org
  Date: Sat, 27 Jan 2007 18:52:38 -0500
  Message-ID: <20070127235238.GA28706@coredump.intra.peff.net>
-
diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index d1bef91..c589a39 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -199,7 +199,7 @@ generate_email_footer()


  	hooks/post-receive
-	--
+	--
  	$projectdesc
  	EOF
  }
diff --git a/git-gui/GIT-VERSION-GEN b/git-gui/GIT-VERSION-GEN
index 25647c8..eee495a 100755
--- a/git-gui/GIT-VERSION-GEN
+++ b/git-gui/GIT-VERSION-GEN
@@ -78,5 +78,3 @@ test "$VN" = "$VC" || {
  	echo >&2 "GITGUI_VERSION = $VN"
  	echo "GITGUI_VERSION = $VN" >$GVF
  }
-
-
diff --git a/git.spec.in b/git.spec.in
index 3a45eb8..b9dc1d5 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -63,7 +63,7 @@ Git tools for importing Perforce repositories.
  %package email
  Summary:        Git tools for sending email
  Group:          Development/Tools
-Requires:	git-core = %{version}-%{release}
+Requires:	git-core = %{version}-%{release}
  %description email
  Git tools for sending email.

diff --git a/gitweb/README b/gitweb/README
index e02e90f..7186ced 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -79,4 +79,3 @@ Originally written by:

  Any comment/question/concern to:
    Git mailing list <git@vger.kernel.org>
-
diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg
index 9b04f2d..c5cdb9d 100644
--- a/templates/hooks--commit-msg
+++ b/templates/hooks--commit-msg
@@ -19,4 +19,3 @@ test "" = "$(grep '^Signed-off-by: ' "$1" |
  	echo >&2 Duplicate Signed-off-by lines.
  	exit 1
  }
-
diff --git a/templates/hooks--post-receive b/templates/hooks--post-receive
index 190de26..b70c8fd 100644
--- a/templates/hooks--post-receive
+++ b/templates/hooks--post-receive
@@ -14,4 +14,3 @@


  #. /usr/share/doc/git-core/contrib/hooks/post-receive-email
-
diff --git a/templates/hooks--pre-applypatch b/templates/hooks--pre-applypatch
index 5f56ce8..eeccc93 100644
--- a/templates/hooks--pre-applypatch
+++ b/templates/hooks--pre-applypatch
@@ -12,4 +12,3 @@
  test -x "$GIT_DIR/hooks/pre-commit" &&
  	exec "$GIT_DIR/hooks/pre-commit" ${1+"$@"}
  :
-
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 723a9ef..18b8730 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -68,4 +68,3 @@ perl -e '
      }
      exit($found_bad);
  '
-
-- 
1.5.2.rc3.90.gf33e-dirty
