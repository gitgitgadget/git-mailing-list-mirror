From: Henry Gebhardt <hsggebhardt@googlemail.com>
Subject: Correction in post-update.sample hook
Date: Thu, 18 Mar 2010 14:16:08 +0100
Message-ID: <20100318141608.2a94c71e@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/Q57.3_k4_24c=OuCrl3jPNi"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 14:16:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsFaK-0005L8-EK
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 14:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab0CRNQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 09:16:19 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:59613 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab0CRNQS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 09:16:18 -0400
Received: by bwz1 with SMTP id 1so2026386bwz.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type;
        bh=YxemlMBThryAFKfCPHQJ8vnVOWO/NhK2KGXUDWN8jQM=;
        b=SMrnvzFd2BalFsYzrBxavtc8J6uaG2GqcjHVDDOAiykBepjz09GUV5gmbrSEbeqRWm
         4PQdajTBsL+YkFp+NJGE3rJOcyLsCKufQuxwTFdnqCV9vEQ5zTa+t/3mhScMxOSB28lH
         c+hkBHIRFKD04UQ7faPqd/hoxviimaBKPT7dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type;
        b=hCXPJxqjMUX1i3UeaP/W1Vnh1+KhrHiw+U8J8Xsf7jpHQzPPWXBjltWVOY/qSNQVI3
         y58gbvCpGcw5xOZ8hlR9SG7mBKyo48UfQ3RibYRyKRc+CKVUCv6Tl305/0ItdhTAgIDQ
         w7Ed8WExgW7D0p3ccKivgn1jmbU8nOBaZUMaE=
Received: by 10.204.151.216 with SMTP id d24mr2709990bkw.1.1268918176585;
        Thu, 18 Mar 2010 06:16:16 -0700 (PDT)
Received: from localhost (p5DC6A937.dip.t-dialin.net [93.198.169.55])
        by mx.google.com with ESMTPS id 14sm5358589bwz.2.2010.03.18.06.16.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Mar 2010 06:16:16 -0700 (PDT)
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.18.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142466>

--MP_/Q57.3_k4_24c=OuCrl3jPNi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I believe the post-update.sample hook has a little spelling
mistake, "git-update-server-info" is now "git update-server-info"
without the dash. The attached patch fixes it throughout the
tree.

Thanks,
Henry
--MP_/Q57.3_k4_24c=OuCrl3jPNi
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-git-update-server-info-git-update-server-info-trivia.patch

>From e0b074ac5b8227bf9d0eaef94a631a610c9d9e44 Mon Sep 17 00:00:00 2001
From: Henry Gebhardt <hsggebhardt@googlemail.com>
Date: Thu, 18 Mar 2010 13:42:49 +0100
Subject: [PATCH] git-update-server-info -> git update-server-info trivial fixes

The command git-update-server-info no longer exists as such. I noticed
this when using the post-update.sample hook for publishing via http.

Signed-off-by: Henry Gebhardt <hsggebhardt@googlemail.com>
---
 Documentation/config.txt                         |    2 +-
 Documentation/howto/rebuild-from-update-hook.txt |    2 +-
 contrib/examples/git-clone.sh                    |    2 +-
 git-repack.sh                                    |    2 +-
 templates/hooks--post-update.sample              |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 805e051..9b97242 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1462,7 +1462,7 @@ receive.denyNonFastForwards::
 	set when initializing a shared repository.
 
 receive.updateserverinfo::
-	If set to true, git-receive-pack will run git-update-server-info
+	If set to true, git-receive-pack will run git update-server-info
 	after receiving data from git-push and updating refs.
 
 remote.<name>.url::
diff --git a/Documentation/howto/rebuild-from-update-hook.txt b/Documentation/howto/rebuild-from-update-hook.txt
index 48c6756..9821526 100644
--- a/Documentation/howto/rebuild-from-update-hook.txt
+++ b/Documentation/howto/rebuild-from-update-hook.txt
@@ -59,7 +59,7 @@ like this:
             echo $HOME/doc-git/dododoc.sh | at now
             ;;
     esac
-    exec git-update-server-info
+    exec git update-server-info
     EOF
     $ chmod +x /pub/scm/git/git.git/hooks/post-update
 
diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone.sh
index 547228e..0dd704a 100755
--- a/contrib/examples/git-clone.sh
+++ b/contrib/examples/git-clone.sh
@@ -75,7 +75,7 @@ clone_dumb_http () {
 	fi
 	http_fetch "$1/info/refs" "$clone_tmp/refs" ||
 		die "Cannot get remote repository information.
-Perhaps git-update-server-info needs to be run there?"
+Perhaps git update-server-info needs to be run there?"
 	test "z$quiet" = z && v=-v || v=
 	while read sha1 refname
 	do
diff --git a/git-repack.sh b/git-repack.sh
index 1eb3bca..532ecfe 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -11,7 +11,7 @@ a               pack everything in a single pack
 A               same as -a, and turn unreachable objects loose
 d               remove redundant packs, and run git-prune-packed
 f               pass --no-reuse-object to git-pack-objects
-n               do not run git-update-server-info
+n               do not run git update-server-info
 q,quiet         be quiet
 l               pass --local to git-pack-objects
  Packing constraints
diff --git a/templates/hooks--post-update.sample b/templates/hooks--post-update.sample
index 5323b56..ec17ec1 100755
--- a/templates/hooks--post-update.sample
+++ b/templates/hooks--post-update.sample
@@ -5,4 +5,4 @@
 #
 # To enable this hook, rename this file to "post-update".
 
-exec git-update-server-info
+exec git update-server-info
-- 
1.7.0.2


--MP_/Q57.3_k4_24c=OuCrl3jPNi--
