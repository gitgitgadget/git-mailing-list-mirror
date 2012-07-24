From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 5/7] i18n: am: mark more strings for translation
Date: Tue, 24 Jul 2012 14:59:33 +0800
Message-ID: <d3711733085d683d9a63cff6f615ef3114f2d3c0.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
 <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
 <441f0613d796c35b6865a1258f074d1ea91e605c.1343112786.git.worldhello.net@gmail.com>
 <e3481427da5efcb60053bb4cd5bcc7e4567100f0.1343112786.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 09:00:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StZ6i-0001sh-77
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 09:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab2GXHAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 03:00:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59967 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2GXHA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 03:00:27 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so12207178pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=xeQV3G/qwmIIFWZvecKxg1XmNva7/mICDp2UVByj19g=;
        b=EtJKKnngVMrFTIlhG8EWEFuX88GdO0q3XSvGjv9c68XSdL09OhT/HRb6nGEhhfm0kQ
         xphEp1vf650aPRTXoafGXnWOBhoAce5i1PvFJyYUePiool/ic4AijKLp7N1xyQw1ybJB
         VPuOfyw0+fSWgPPdaY3uhyBclZ8f7eeCjCk15Mcy9nAGSDonl6IGhf8l0vy2kAB7LMRs
         POpFqn1UTKeSh0iA9Lwq3fycXB8wCunENN/Y/VW0rJP7UaNgpeLgs51LMxgUPSzG9awB
         +aEsAiRf+3rAKqhtIUfTAvj4CbuJBiVmesgs3tBD9BGI/X6mF/6eCliLaDPIekxGtgJi
         Wo3g==
Received: by 10.68.191.41 with SMTP id gv9mr42077439pbc.45.1343113227645;
        Tue, 24 Jul 2012 00:00:27 -0700 (PDT)
Received: from jx.bj.ossxp.com.bj.ossxp.com ([123.116.228.123])
        by mx.google.com with ESMTPS id tj4sm11577579pbc.33.2012.07.24.00.00.21
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 00:00:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.17.gcb766d3
In-Reply-To: <e3481427da5efcb60053bb4cd5bcc7e4567100f0.1343112786.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202015>

Mark additional 3 strings for translation, and reduce one indentation
level for one gettextln clause introduced in commit de88c1c.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 git-am.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c02e6..b7183 100755
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
1.7.12.rc0.17.gcb766d3
