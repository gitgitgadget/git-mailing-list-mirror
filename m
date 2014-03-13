From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] connect.c: SP after "}", not TAB
Date: Thu, 13 Mar 2014 18:45:31 +0700
Message-ID: <1394711131-14703-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 12:45:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO44K-0000FN-He
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 12:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbaCMLo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2014 07:44:56 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:55153 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbaCMLoz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 07:44:55 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so979162pbc.41
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 04:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=JQ8j5iv4UsIZLuH/jhdut6n42koCLUDQBdEncdlK9+Q=;
        b=Dqvlx+WL/KsDcK3YbulcN/B3wccy+m19VQQY2PhkODn036A1mH/tpsi4hxdWPoMIBS
         9umYG8w2qttjf+63QFE/RYLJAKo6JTluFF/vjYk4eRnqpvIllAPBkWylduxyNsCfrXRK
         unyirGeZEXYuLcQ7nULl6aEGnaFJ7vSTSGDLx39+EHgU1APHuAM49rBl8gVNasfGcDGL
         B1W99c+WuKM+3RNcFg4ZpKOZpEh7dbMIo3z5jj+APfqThNmv5jXIh1DB8TteV9SXGAFP
         OsAeTJYCebq/d7xxkPEF23DDbYqKA1V24QLx/DmAFzh/xi4S3iN5/mxW2FeRclQqkThn
         PFoA==
X-Received: by 10.68.190.163 with SMTP id gr3mr1642319pbc.103.1394711095322;
        Thu, 13 Mar 2014 04:44:55 -0700 (PDT)
Received: from lanh ([115.73.217.255])
        by mx.google.com with ESMTPSA id zb2sm6239088pbc.30.2014.03.13.04.44.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Mar 2014 04:44:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 13 Mar 2014 18:45:34 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244030>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I missed the "else" anchor because it's indented far to the right and
 misread the code for a second there. Might as well fix it while I'm
 at it.

 connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index 4cb1c7c..4be84e8 100644
--- a/connect.c
+++ b/connect.c
@@ -727,7 +727,7 @@ struct child_process *git_connect(int fd[2], const =
char *url,
 				*arg++ =3D port;
 			}
 			*arg++ =3D ssh_host;
-		}	else {
+		} else {
 			/* remove repo-local variables from the environment */
 			conn->env =3D local_repo_env;
 			conn->use_shell =3D 1;
--=20
1.9.0.40.gaa8c3ea
