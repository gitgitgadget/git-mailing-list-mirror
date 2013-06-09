From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/45] pathspec: i18n-ize error strings in pathspec parsing code
Date: Sun,  9 Jun 2013 13:25:36 +0700
Message-ID: <1370759178-1709-4-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ44-00084k-HH
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab3FIGZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:25:14 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:54873 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3FIGZL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:25:11 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so6258807pdi.25
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+5ZuJFTptkP7qQYO2ekv+A/sqnkdTUluwcEZN9vCf8Q=;
        b=hhDN12GF1Pgb0f5SoOp4DDETkljjc+X+vvYeBxSbri7AJt1oo5bavJ6Dq+s4MaO3EG
         zu3UPo1hw1ZE244n0kW1ZUaJvZnWf1xobJobAPo5uynvx5MavfTJisOoJuFOh80zjoBg
         K9scQYKKSqibZroPxu8WBhcwV6lwIzRRYyievl9GkUI43Ow9T8QZ+jpe7WsSov2Pwdat
         B53vGDJ6QGEsFh/5KpvzEToSig7mUADuUnZp5loCR6nUFr70AW8qE2dp3gk1lyCqHm40
         v7EDbsQCsv6SlqLjY7vusSRwDeq11J7WOelYF0pYb4Cyf+3iAuXNamrsRBhCxOoo5ry/
         8cxQ==
X-Received: by 10.68.197.66 with SMTP id is2mr5043477pbc.175.1370759111336;
        Sat, 08 Jun 2013 23:25:11 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id pe9sm5487744pbc.35.2013.06.08.23.25.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:25:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:26:42 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226895>


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
