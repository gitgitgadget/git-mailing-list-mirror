From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 5/7] i18n: am: mark more strings for translation
Date: Sat, 21 Jul 2012 23:50:54 +0800
Message-ID: <d5c4000b859f4b30af6fc3faec008403b82246bf.1342884459.git.worldhello.net@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
 <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com>
 <0fd901035a418562d3d9282553a96124814a298a.1342884459.git.worldhello.net@gmail.com>
 <77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com>
 <941f7bd695e8a14c940a5b8e4214d2773ae82557.1342884459.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:52:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssbyz-0005VS-8r
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 17:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab2GUPwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 11:52:33 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55391 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab2GUPwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 11:52:19 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8041000pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=4hnaOPlfp4Xb4k5ljVDGqyFq+gz/L7UndOdfuXQ1aWE=;
        b=LfPfFRGLOlzUgoGO5o3PcR/s/ZIxti6C6vTazHbGNZCL43HBrCosP7BVWdM3NML8ke
         2VvkcrXXbBaU5tq+Zyta+gV9oLCYP4wdBbETiCYOnrG10tNId88Zy3TWO4RyeZ7O2kz3
         kf//Mrosf4CZ1K1AxbzM8u721SB20G2esKUOI15oUTwwmCGDSTCK56ajj/2AAAUT4u/4
         2Hbck39BtyEkXBx+R1bsp3r4fCiT9nsYVScOYXBcLg2I/7yxBd7uMWGXWpeNNB+d/NzR
         w9fIAKcLGQt/Ft263vpsfrPhBTFc2Km5ePUmHTnjN4PLT4JXBJv37oaskieUONM6aSqa
         dMvQ==
Received: by 10.68.238.105 with SMTP id vj9mr22376198pbc.111.1342885938857;
        Sat, 21 Jul 2012 08:52:18 -0700 (PDT)
Received: from localhost.localdomain ([123.116.228.123])
        by mx.google.com with ESMTPS id nj4sm6241849pbc.5.2012.07.21.08.52.13
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 08:52:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
In-Reply-To: <941f7bd695e8a14c940a5b8e4214d2773ae82557.1342884459.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1342884458.git.worldhello.net@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201817>

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 git-am.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b6a53..20c1a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -92,7 +92,7 @@ safe_to_abort () {
 	then
 		return 0
 	fi
-		gettextln "You seem to have moved HEAD since the last 'am' failure.
+	gettextln "You seem to have moved HEAD since the last 'am' failure.
 Not rewinding to ORIG_HEAD" >&2
 	return 1
 }
@@ -136,7 +136,7 @@ fall_back_3way () {
     git write-tree >"$dotest/patch-merge-base+" ||
     cannot_fallback "$(gettext "Repository lacks necessary blobs to fall back on 3-way merge.")"
 
-    say Using index info to reconstruct a base tree...
+    say "$(gettext "Using index info to reconstruct a base tree...")"
 
     cmd='GIT_INDEX_FILE="$dotest/patch-merge-tmp-index"'
 
@@ -176,8 +176,7 @@ It does not apply to blobs recorded in its index.")"
     fi
     git-merge-recursive $orig_tree -- HEAD $his_tree || {
 	    git rerere $allow_rerere_autoupdate
-	    echo Failed to merge in the changes.
-	    exit 1
+	    die "$(gettext "Failed to merge in the changes.")"
     }
     unset GITHEAD_$his_tree
 }
@@ -387,8 +386,8 @@ do
 	-i|--interactive)
 		interactive=t ;;
 	-b|--binary)
-		echo >&2 "The $1 option has been a no-op for long time, and"
-		echo >&2 "it will be removed. Please do not use it anymore."
+		echo >&2 $(gettext "The -b option has been a no-op for long time, and
+it will be removed. Please do not use it anymore.")
 		;;
 	-3|--3way)
 		threeway=t ;;
-- 
1.7.11.2.259.g37fc0e1
