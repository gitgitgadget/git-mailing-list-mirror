From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 5/7] i18n: am: mark more strings for translation
Date: Sun, 22 Jul 2012 09:26:09 +0800
Message-ID: <247c407ce218c77a603eb6cf93228d94adc48f04.1342920089.git.worldhello.net@gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
 <e488b5e8f40859a842f80855a3dd4861a4ced6d0.1342920089.git.worldhello.net@gmail.com>
 <724ca3989123159c9970b3276b4764dcbd5fd56e.1342920089.git.worldhello.net@gmail.com>
 <b3d82ce0b35597c90bf8280f38a5b336066cea18.1342920089.git.worldhello.net@gmail.com>
 <16d740e2d6e38e1ce8f3770f506623068b1cf309.1342920089.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 03:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SskxM-0000tS-A1
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 03:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab2GVB10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 21:27:26 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52289 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab2GVB1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 21:27:20 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8575153pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 18:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=7kumfwgDU9M4kGbjd2aOWzeHiBahcta1dJHg4eTAVR4=;
        b=jLsPZrHhsl2WGXBwY/0qQvmDqhBtsNetYlaPfaiKyYOv9/wOWQJOCaegtIhWG2CJDL
         WUFqTjAg5nRoYEvFEnxvwzZDDoWjVMuH3AtShtWiMalo6B2gNAvC/FfIsOFiBCZUrtnc
         etzJqg3TxYdAmjJ/Lt8icvzq/IQPkGaly/j5qY/X76CBLpL5OpatO7T1duA61chLDRon
         9/tHlnsKaFeuBEUiDzuUZuKunHllG+LLO8pYAIE4WeqOCy7uLsnq+iOmkdufst5PFDmW
         Q8WMJmzu20fTWHFOphhPbXiZwhFNIcUIqwC/S1y81gT450r0KuRuqVP+G9zX61rNwimQ
         ONJQ==
Received: by 10.68.239.103 with SMTP id vr7mr25484921pbc.0.1342920440207;
        Sat, 21 Jul 2012 18:27:20 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id rg10sm6946850pbc.54.2012.07.21.18.27.15
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 18:27:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
In-Reply-To: <16d740e2d6e38e1ce8f3770f506623068b1cf309.1342920089.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1342920089.git.worldhello.net@gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201836>

Mark additional 3 strings for translation, and reduce one indentation
level for one gettextln clause introduced in commit de88c1c.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
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
