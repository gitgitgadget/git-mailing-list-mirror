From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Remove the non-builtin git-check-ref-format
Date: Thu, 18 May 2006 14:17:22 +0200
Organization: Chalmers
Message-ID: <446C65D2.7080107@etek.chalmers.se>
References: <446C657B.7020100@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 18 14:17:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FghRd-0005tt-2Y
	for gcvg-git@gmane.org; Thu, 18 May 2006 14:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWERMRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 May 2006 08:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWERMRa
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 08:17:30 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:57268 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751211AbWERMR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 08:17:29 -0400
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.072.1)
        id 446C456E00012F63; Thu, 18 May 2006 14:17:25 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.2) Gecko/20060501 Thunderbird/1.5.0.2 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <446C657B.7020100@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20284>


Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>

---

 Makefile           |    2 +-
 check-ref-format.c |   17 -----------------
 2 files changed, 1 insertions(+), 18 deletions(-)
 delete mode 100644 check-ref-format.c

d459dd88b8b541bbfa03bb3bebfac152d3d1b9e5
diff --git a/Makefile b/Makefile
index b737cb8..ee62ca2 100644
--- a/Makefile
+++ b/Makefile
@@ -164,7 +164,7 @@ PROGRAMS =3D \
 	git-ssh-upload$X git-tar-tree$X git-unpack-file$X \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
-	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
+	git-update-ref$X git-symbolic-ref$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
 	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
=20
diff --git a/check-ref-format.c b/check-ref-format.c
deleted file mode 100644
index a0adb3d..0000000
--- a/check-ref-format.c
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * GIT - The information manager from hell
- */
-
-#include "cache.h"
-#include "refs.h"
-
-#include <stdio.h>
-
-int main(int ac, char **av)
-{
-	if (ac !=3D 2)
-		usage("git-check-ref-format refname");
-	if (check_ref_format(av[1]))
-		exit(1);
-	return 0;
-}
--=20
1.3.2.g3c45-dirty
