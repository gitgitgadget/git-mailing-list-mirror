From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/46] pathspec: i18n-ize error strings in pathspec parsing code
Date: Sun, 14 Jul 2013 15:35:26 +0700
Message-ID: <1373790969-13000-4-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:36:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHnQ-0001BK-AP
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab3GNIgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:36:39 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56664 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:36:38 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so10328043pab.10
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+5ZuJFTptkP7qQYO2ekv+A/sqnkdTUluwcEZN9vCf8Q=;
        b=r47sti5z+BA7o7RrSfCq2r1CRB3zVWowoYIDcM54+y9tGn/eqBwreATw3u90QwNFsY
         eUjKSGPu3dPtarMIN6FCfL2GTRVUiVXbp3sPrLFbEWQ4YcdxwbuMHrRKtRC8OUuoEeDl
         9ltuEz+e8NX2yuR/A3txZUzF8SKJkOuSPe7ipuz7vaMixxTm4XQGHRg6oeiaa2s0L31K
         DrEh7qgFMJzFH1wTJR4D/gYrKYvq8XWulh2hOQxK+wbSXb2Cxy0G+gGaUHd5vEqOmVYj
         kGlESsH7U32t3p/ct249IRh/Bd2cr67WLlouKuURSjhw8JYqM6EFzHW9PY4zqLKXKcvQ
         3b6A==
X-Received: by 10.66.155.102 with SMTP id vv6mr51016812pab.60.1373790997909;
        Sun, 14 Jul 2013 01:36:37 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id eq5sm54562528pbc.15.2013.07.14.01.36.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:36:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:36:49 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230315>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 133f8be..403095b 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -167,11 +167,11 @@ static const char *prefix_pathspec(const char *pr=
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
@@ -188,7 +188,7 @@ static const char *prefix_pathspec(const char *pref=
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
1.8.2.83.gc99314b
