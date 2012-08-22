From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] l10n: preserve trailing spaces in Vietnamese translation
Date: Wed, 22 Aug 2012 19:57:33 +0700
Message-ID: <1345640253-31705-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 15:03:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Ab7-0006GD-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 15:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506Ab2HVNDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 09:03:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56975 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932426Ab2HVNDi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 09:03:38 -0400
Received: by pbbrr13 with SMTP id rr13so1455658pbb.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=TKuW2VJ+JOJWVjvZOoosDefjajMsxuzFVquoQaELA0c=;
        b=UdV6QrWmSIUOCXyAwdVWTmWo8em1Yk+JdLX2268KIYu1i2KAC1Bv2oEDOWm8Kh0m88
         AlzCCq1+e3OeZ+b0dA1vkBVBiDNxHOtkFShhkMGOTgBUAj92SzsmCNjtIJPjoDG0IUMp
         xZR4FVVInbj8otUkyKXOAdlRgBMS9h6dwMpXL9xKTRDCP+c3esI/zVvK78RO3wfPINNu
         bemR8oMRMUd2YMaDmuQNQk+uJrmlkdivsPhOCVlnsOXSbI4t4QXKk5zZJni/5IWTMWA2
         tIgRN6iTBkOMFwnf7sYHcgY4C437wQgw/CvmVviRfW3RhRpLejhmY4GriYAexXHv3UKg
         103g==
Received: by 10.66.87.138 with SMTP id ay10mr45869427pab.38.1345640618087;
        Wed, 22 Aug 2012 06:03:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.35.79])
        by mx.google.com with ESMTPS id ty1sm3668075pbc.76.2012.08.22.06.03.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 06:03:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 22 Aug 2012 19:57:34 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204015>

The trailing spaces in msgid can be used to separate the next
word. Accidentally removing it means we may see "On branchmaster"
instead of "On branch master".

While at it, remove trailing space in translation if the original one
does not have it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 po/vi.po | 22 +++++++++++-----------
 1 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 11 =C4=
=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 11 b=E1=BB=8B x=C3=B3a(-)

diff --git a/po/vi.po b/po/vi.po
index f2c77ec..bd0f953 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -1047,11 +1047,11 @@ msgstr " l=E1=BA=A7n chuy=E1=BB=83n giao (commi=
t) m=E1=BB=9Bi, "
=20
 #: wt-status.c:287
 msgid "modified content, "
-msgstr "n=E1=BB=99i dung =C4=91=C6=B0=E1=BB=A3c s=E1=BB=ADa =C4=91=E1=BB=
=95i,"
+msgstr "n=E1=BB=99i dung =C4=91=C6=B0=E1=BB=A3c s=E1=BB=ADa =C4=91=E1=BB=
=95i, "
=20
 #: wt-status.c:289
 msgid "untracked content, "
-msgstr "n=E1=BB=99i dung ch=C6=B0a =C4=91=C6=B0=E1=BB=A3c theo d=C3=B5=
i"
+msgstr "n=E1=BB=99i dung ch=C6=B0a =C4=91=C6=B0=E1=BB=A3c theo d=C3=B5=
i "
=20
 #: wt-status.c:303
 #, c-format
@@ -1194,7 +1194,7 @@ msgstr "  (s=E1=BB=AD d=E1=BB=A5ng \"git bisect r=
eset\" =C4=91=E1=BB=83 quay tr=E1=BB=9F l=E1=BA=A1i nh=C3=A1nh nguy=C3=AA
=20
 #: wt-status.c:978
 msgid "On branch "
-msgstr "Tr=C3=AAn nh=C3=A1nh"
+msgstr "Tr=C3=AAn nh=C3=A1nh "
=20
 #: wt-status.c:985
 msgid "Not currently on any branch."
@@ -1268,20 +1268,20 @@ msgstr "HEAD (ch=C6=B0a c=C3=B3 nh=C3=A1nh n=C3=
=A0o)"
=20
 #: wt-status.c:1156
 msgid "Initial commit on "
-msgstr "L=E1=BA=A7n chuy=E1=BB=83n giao (commit)  kh=E1=BB=9Fi t=E1=BA=
=A1o tr=C3=AAn"
+msgstr "L=E1=BA=A7n chuy=E1=BB=83n giao (commit)  kh=E1=BB=9Fi t=E1=BA=
=A1o tr=C3=AAn "
=20
 #: wt-status.c:1171
 msgid "behind "
-msgstr "=C4=91=E1=BA=B1ng sau"
+msgstr "=C4=91=E1=BA=B1ng sau "
=20
 #: wt-status.c:1174
 #: wt-status.c:1177
 msgid "ahead "
-msgstr "ph=C3=ADa tr=C6=B0=E1=BB=9Bc"
+msgstr "ph=C3=ADa tr=C6=B0=E1=BB=9Bc "
=20
 #: wt-status.c:1179
 msgid ", behind "
-msgstr ", =C4=91=E1=BA=B1ng sau"
+msgstr ", =C4=91=E1=BA=B1ng sau "
=20
 #: builtin/add.c:62
 #, c-format
@@ -3506,7 +3506,7 @@ msgstr "kh=C3=B4ng th=E1=BB=83 l=C6=B0u tr=E1=BB=AF=
 t=E1=BA=ADp tin ghi m=E1=BB=A5c l=E1=BB=A5c"
 #: builtin/index-pack.c:1398
 #, c-format
 msgid "Cannot open existing pack file '%s'"
-msgstr "Kh=C3=B4ng th=E1=BB=83 m=E1=BB=9F t=E1=BA=ADp tin pack =C4=91=C3=
=A3 s=E1=BA=B5n c=C3=B3 '%s' "
+msgstr "Kh=C3=B4ng th=E1=BB=83 m=E1=BB=9F t=E1=BA=ADp tin pack =C4=91=C3=
=A3 s=E1=BA=B5n c=C3=B3 '%s'"
=20
 #: builtin/index-pack.c:1400
 #, c-format
@@ -5385,7 +5385,7 @@ msgstr "Th=C3=A2n c=E1=BB=A7a l=E1=BA=A7n chuy=E1=
=BB=83n giao (commit) l=C3=A0:"
 #. input at this point.
 #: git-am.sh:764
 msgid "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
-msgstr "=C3=81p d=E1=BB=A5ng? =C4=91=E1=BB=93ng =C3=BD [y]/kh=C3=B4ng =
[n]/ch=E1=BB=89nh s=E1=BB=ADa [e]/hi=E1=BB=83n th=E1=BB=8B mi=E1=BA=BFn=
g [v]=C3=A1/=C4=91=E1=BB=93ng =C3=BD t=E1=BA=A5t c=E1=BA=A3 [a]"
+msgstr "=C3=81p d=E1=BB=A5ng? =C4=91=E1=BB=93ng =C3=BD [y]/kh=C3=B4ng =
[n]/ch=E1=BB=89nh s=E1=BB=ADa [e]/hi=E1=BB=83n th=E1=BB=8B mi=E1=BA=BFn=
g [v]=C3=A1/=C4=91=E1=BB=93ng =C3=BD t=E1=BA=A5t c=E1=BA=A3 [a] "
=20
 #: git-am.sh:800
 #, sh-format
@@ -5495,7 +5495,7 @@ msgstr "C=E1=BA=A3nh b=C3=A1o: ch=E1=BB=89 th=E1=BB=
=B1c hi=E1=BB=87n vi=E1=BB=87c bisect v=E1=BB=9Bi m=E1=BB=99t l=E1=BA=A7=
n chuy=E1=BB=83
 #. at this point.
 #: git-bisect.sh:279
 msgid "Are you sure [Y/n]? "
-msgstr "B=E1=BA=A1n c=C3=B3 ch=E1=BA=AFc ch=E1=BA=AFn ch=C6=B0a [Y/n]?=
"
+msgstr "B=E1=BA=A1n c=C3=B3 ch=E1=BA=AFc ch=E1=BA=AFn ch=C6=B0a [Y/n]?=
 "
=20
 #: git-bisect.sh:289
 msgid ""
@@ -5693,7 +5693,7 @@ msgstr "d=C3=B2ng ng=C6=B0=E1=BB=A3c kh=C3=B4ng h=
=E1=BB=A3p l=E1=BB=87 $upstream_name"
 #: git-rebase.sh:419
 #, sh-format
 msgid "$onto_name: there are more than one merge bases"
-msgstr "$onto_name: =E1=BB=9F =C4=91=C3=A2y c=C3=B3 nhi=E1=BB=81u h=C6=
=A1n m=E1=BB=99t "
+msgstr "$onto_name: =E1=BB=9F =C4=91=C3=A2y c=C3=B3 nhi=E1=BB=81u h=C6=
=A1n m=E1=BB=99t"
=20
 #: git-rebase.sh:422
 #: git-rebase.sh:426
--=20
1.7.12.rc2.18.g61b472e
