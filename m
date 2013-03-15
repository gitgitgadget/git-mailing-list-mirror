From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 04/45] pathspec: i18n-ize error strings in pathspec parsing code
Date: Fri, 15 Mar 2013 13:06:19 +0700
Message-ID: <1363327620-29017-5-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:25:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO4Z-0003t2-Fe
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab3COGYc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:24:32 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:52297 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab3COGYb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:24:31 -0400
Received: by mail-ia0-f174.google.com with SMTP id k38so2825812iah.19
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=UdlqxteWcynVpeYSagNsIsr35mt7X7CtCTmHR397Ndk=;
        b=zGPzvkORMDQtC8CsemMlHcwDGBFqqXE9+ayAOcnP/5ry8tsV4BWHLbu30LLz67V2F0
         dKi9GXLF9qfraWK0YYztcf3GpzuPDjJQPPdAfimIoX3vLpXAUFPq5ohax3x9HfMUz333
         6tMuMawZLkow82ulcE5w8vkNNQkxeE/qGPrG1fIIkOCz1N02gsmQO2CCtr4jKJQN4lek
         2dEE682BtSDDCrO3JU7ugD0lmIF0EwW6LylEsGMdBnAxrR8TgUd9KCH52oaWHJHd2N2M
         vaLXbKGtUysOu5J1+9baAD2dI6BTA7uLo9rJlS+fxG790+36YCaftfrVVF0n6yjL2h1k
         6J9g==
X-Received: by 10.50.203.3 with SMTP id km3mr475983igc.64.1363328670589;
        Thu, 14 Mar 2013 23:24:30 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id xf4sm609513igb.8.2013.03.14.23.24.27
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:24:29 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:07:33 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218191>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index aa3e4d0..94d64d2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -166,11 +166,11 @@ static const char *prefix_pathspec(const char *pr=
efix, int prefixlen, const char
 					break;
 				}
 			if (ARRAY_SIZE(pathspec_magic) <=3D i)
-				die("Invalid pathspec magic '%.*s' in '%s'",
+				die(_("Invalid pathspec magic '%.*s' in '%s'"),
 				    (int) len, copyfrom, elt);
 		}
 		if (*copyfrom !=3D ')')
-			die("Missing ')' at the end of pathspec magic in '%s'", elt);
+			die(_("Missing ')' at the end of pathspec magic in '%s'"), elt);
 		copyfrom++;
 	} else {
 		/* shorthand */
@@ -187,7 +187,7 @@ static const char *prefix_pathspec(const char *pref=
ix, int prefixlen, const char
 					break;
 				}
 			if (ARRAY_SIZE(pathspec_magic) <=3D i)
-				die("Unimplemented pathspec magic '%c' in '%s'",
+				die(_("Unimplemented pathspec magic '%c' in '%s'"),
 				    ch, elt);
 		}
 		if (*copyfrom =3D=3D ':')
--=20
1.8.0.rc0.19.g7bbb31d
