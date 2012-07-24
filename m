From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 6/7] Remove unused and bad gettext block from git-am
Date: Tue, 24 Jul 2012 14:59:34 +0800
Message-ID: <dc805486adc18bf70cea73f9c6363bb3c4cf6c2b.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
 <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
 <441f0613d796c35b6865a1258f074d1ea91e605c.1343112786.git.worldhello.net@gmail.com>
 <e3481427da5efcb60053bb4cd5bcc7e4567100f0.1343112786.git.worldhello.net@gmail.com>
 <d3711733085d683d9a63cff6f615ef3114f2d3c0.1343112786.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 09:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StZ6n-0001yA-C4
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 09:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab2GXHAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 03:00:35 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:62610 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2GXHAe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 03:00:34 -0400
Received: by ghrr11 with SMTP id r11so6321659ghr.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Dj65ocUuHWcgNG+bTRcVLBoWvzNW3Z+LAZjCOWOlfO0=;
        b=xO1eaAiVD/em2jau3uxBBPMzAhNqndp1+QNE5XtA/U/Z9M3l6fobGpyT32DO7oH2II
         /+d49g1PfPO262QDb0VTk10za1wc+3oVTCTrsZhaCVNim2s2mcE8mdl+nI3qTIbbwlY+
         DBzShrBwqxZWBuXOGK6x0ATXpnyuhuLqc0NAvskb70A+6chKC24K8NpG1aZxAL4SoLSp
         OgUHNE1fXEedj/HuVYmFzuwEsqCkdy3JA8wu2Xa6+lgtYIw/OCTS6reKNS7qc7Q3wJ0t
         lqHWxBsEuYPRYYJO3COTT6EwRGic0jZRJQG2A6DHbmz8t1+igotRsgzZW26YGccFCb5q
         vdLw==
Received: by 10.66.80.34 with SMTP id o2mr2500102pax.36.1343113233857;
        Tue, 24 Jul 2012 00:00:33 -0700 (PDT)
Received: from jx.bj.ossxp.com.bj.ossxp.com ([123.116.228.123])
        by mx.google.com with ESMTPS id tj4sm11577579pbc.33.2012.07.24.00.00.28
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 00:00:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.17.gcb766d3
In-Reply-To: <d3711733085d683d9a63cff6f615ef3114f2d3c0.1343112786.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202016>

Gettext message should not start with '-' nor '--'. Since the '-d' and
'--dotest' options do not exist in OPTIONS_SPEC variable, it's safe to
remove the block.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 git-am.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b7183..a2e3d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -413,9 +413,6 @@ it will be removed. Please do not use it anymore.")
 		abort=t ;;
 	--rebasing)
 		rebasing=t threeway=t ;;
-	-d|--dotest)
-		die "$(gettext "-d option is no longer supported.  Do not use.")"
-		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace|--directory|--exclude|--include)
-- 
1.7.12.rc0.17.gcb766d3
