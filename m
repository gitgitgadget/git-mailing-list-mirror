From: Justin Lebar <jlebar@google.com>
Subject: [PATCH 3/6] l10n: Fix misuses of "nor"
Date: Sat, 15 Mar 2014 01:41:59 -0700
Message-ID: <1394872922-2000-4-git-send-email-jlebar@google.com>
References: <1394872922-2000-1-git-send-email-jlebar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Justin Lebar <jlebar@google.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 09:43:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOkBn-0006Vl-4P
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 09:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbaCOInJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Mar 2014 04:43:09 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:62640 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbaCOImx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 04:42:53 -0400
Received: by mail-vc0-f202.google.com with SMTP id lh14so438981vcb.5
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OPouqUpFDMofCxSFAZ8TkogCqUW5qXHBUA12Duc+mEI=;
        b=hAG2l3JcT9lowpjwbl6DEwa3MJS/nyVo4VKyOEJ6SZB5BDiZx3X3a/bQSPdyEfAiwq
         Fc9ppaY6r3g9xkCbouPWXcVjQ/jDFki1iHVfMh2sbZPqsi3THi4Qy0gLRhbneSn8wW/E
         /JXFwEeJWkNykk68ok4r/eAYPWwqjeRPT6hg2MD5CZjEKkZm2z2MZm43C+3RW1Nj/Vpt
         pJyICIJwkOntGjqHw09WG1qhwwonFUNXi3gBUblJGe9UnY0GVuaSyb5N2/xtKQKeEbw6
         xFaGo0qQ04zFV+Y63yweNaChcayZ94c4mPiCiXJT6tYD2cjzYQOzznxJ4LDDMBX1++8x
         gMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=OPouqUpFDMofCxSFAZ8TkogCqUW5qXHBUA12Duc+mEI=;
        b=FOQDwC+IKi3/5V1dutumqfde02lAMpeDqwC0AWLd1vG4A6oVrJxRDYAEgyin9YN0k7
         G9mt3K5PvxWUMtGsspk6Nc7BAdhSGr3NCLjgpxSFG7k6k76XIL2V5gDNONP2qWaKr2Ax
         mb9qrRNf3DDKkX6nfP4QcKVUXZZGiqr7XML7DWg+z8Wa9M871zf4AjXXC6WKP05Xc9T2
         DOsGlfnRUBUocf20NQtF/+nAx0HEBhaR1PtOVR+rg2T9AqW72ScH5fwdKfG5Ht/yE4Yc
         boFGQn+J5+8hvDTt6fLH8P7p2nPNScRaNXvWX0xIkDxy0Ma17ZsGpZfWO0EQXlPUkMjt
         HPww==
X-Gm-Message-State: ALoCoQn881SsYkDG+anfPcUaiTKIcF2x/+DCNB6C+5+eaL5pdUPb7hQ2mRRGgaFgmxucAtMjx+U8P7Era/tDaElaOET6Po+QAcn7W9PVQVqmraox9SeDQAxg+YVc9sC01Qjw9KCDt46Vd6DOAhITPu0WvPs2cKwjatn+2y07gojwwWUuwxe9GmHfAgLR1uFqZcGzD7PPGvHe
X-Received: by 10.224.20.133 with SMTP id f5mr4928654qab.8.1394872972827;
        Sat, 15 Mar 2014 01:42:52 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id u4si1296274yhb.5.2014.03.15.01.42.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Mar 2014 01:42:52 -0700 (PDT)
Received: from jlebar0.mtv.corp.google.com (jlebar0.mtv.corp.google.com [172.17.132.58])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 745745A4241;
	Sat, 15 Mar 2014 01:42:52 -0700 (PDT)
Received: by jlebar0.mtv.corp.google.com (Postfix, from userid 214119)
	id 38D6F1A0889; Sat, 15 Mar 2014 01:42:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.279.gdc9e3eb
In-Reply-To: <1394872922-2000-1-git-send-email-jlebar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244146>

Signed-off-by: Justin Lebar <jlebar@google.com>
---
 po/bg.po    | 6 +++---
 po/de.po    | 6 +++---
 po/fr.po    | 6 +++---
 po/git.pot  | 6 +++---
 po/it.po    | 2 +-
 po/pt_PT.po | 2 +-
 po/sv.po    | 6 +++---
 po/vi.po    | 6 +++---
 po/zh_CN.po | 6 +++---
 9 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index fb450b2..983e575 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -3699,13 +3699,13 @@ msgstr ""
=20
 #: builtin/clean.c:906
 msgid ""
-"clean.requireForce set to true and neither -i, -n nor -f given; refus=
ing to "
+"clean.requireForce set to true and neither -i, -n, nor -f given; refu=
sing to "
 "clean"
 msgstr ""
=20
 #: builtin/clean.c:909
 msgid ""
-"clean.requireForce defaults to true and neither -i, -n nor -f given; =
"
+"clean.requireForce defaults to true and neither -i, -n, nor -f given;=
 "
 "refusing to clean"
 msgstr ""
=20
@@ -4253,7 +4253,7 @@ msgid "Clever... amending the last one with dirty=
 index."
 msgstr ""
=20
 #: builtin/commit.c:1126
-msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
 msgstr ""
=20
 #: builtin/commit.c:1136 builtin/tag.c:572
diff --git a/po/de.po b/po/de.po
index b777ef4..f539bf5 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3876,7 +3876,7 @@ msgstr "Die Optionen -x und -X k=C3=B6nnen nicht =
gemeinsam verwendet werden."
=20
 #: builtin/clean.c:906
 msgid ""
-"clean.requireForce set to true and neither -i, -n nor -f given; refus=
ing to "
+"clean.requireForce set to true and neither -i, -n, or -f given; refus=
ing to "
 "clean"
 msgstr ""
 "clean.requireForce auf \"true\" gesetzt und weder -i, -n noch -f gege=
ben; "
@@ -3884,7 +3884,7 @@ msgstr ""
=20
 #: builtin/clean.c:909
 msgid ""
-"clean.requireForce defaults to true and neither -i, -n nor -f given; =
"
+"clean.requireForce defaults to true and neither -i, -n, or -f given; =
"
 "refusing to clean"
 msgstr ""
 "clean.requireForce standardm=C3=A4=C3=9Fig auf \"true\" gesetzt und w=
eder -i, -n noch -"
@@ -4496,7 +4496,7 @@ msgstr ""
 "Klug... den letzten Commit mit einer ge=C3=A4nderten Staging-Area nac=
hbessern."
=20
 #: builtin/commit.c:1126
-msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
 msgstr ""
 "Explizite Pfade ohne -i oder -o angegeben; unter der Annahme von --on=
ly "
 "Pfaden..."
diff --git a/po/fr.po b/po/fr.po
index 0b9d59e..9683264 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -3917,7 +3917,7 @@ msgstr "-x et -X ne peuvent pas =C3=AAtre utilis=C3=
=A9s ensemble"
=20
 #: builtin/clean.c:906
 msgid ""
-"clean.requireForce set to true and neither -i, -n nor -f given; refus=
ing to "
+"clean.requireForce set to true and neither -i, -n, or -f given; refus=
ing to "
 "clean"
 msgstr ""
 "clean.requireForce positionn=C3=A9 =C3=A0 true et ni -i, -n ou -f fou=
rni ; refus de "
@@ -3925,7 +3925,7 @@ msgstr ""
=20
 #: builtin/clean.c:909
 msgid ""
-"clean.requireForce defaults to true and neither -i, -n nor -f given; =
"
+"clean.requireForce defaults to true and neither -i, -n, or -f given; =
"
 "refusing to clean"
 msgstr ""
 "clean.requireForce =C3=A0 true par d=C3=A9faut et ni -i, -n ou -f fou=
rni ; refus de "
@@ -4526,7 +4526,7 @@ msgid "Clever... amending the last one with dirty=
 index."
 msgstr "Malin... correction du dernier avec un index sale."
=20
 #: builtin/commit.c:1126
-msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
 msgstr "Chemins explicites sp=C3=A9cifi=C3=A9s sans -i ni -o ; --only =
suppos=C3=A9..."
=20
 #: builtin/commit.c:1136 builtin/tag.c:572
diff --git a/po/git.pot b/po/git.pot
index 33cc31d..3553bfc 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -3598,13 +3598,13 @@ msgstr ""
=20
 #: builtin/clean.c:906
 msgid ""
-"clean.requireForce set to true and neither -i, -n nor -f given; refus=
ing to "
+"clean.requireForce set to true and neither -i, -n, or -f given; refus=
ing to "
 "clean"
 msgstr ""
=20
 #: builtin/clean.c:909
 msgid ""
-"clean.requireForce defaults to true and neither -i, -n nor -f given; =
"
+"clean.requireForce defaults to true and neither -i, -n, or -f given; =
"
 "refusing to clean"
 msgstr ""
=20
@@ -4150,7 +4150,7 @@ msgid "Clever... amending the last one with dirty=
 index."
 msgstr ""
=20
 #: builtin/commit.c:1126
-msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
 msgstr ""
=20
 #: builtin/commit.c:1136 builtin/tag.c:572
diff --git a/po/it.po b/po/it.po
index 9080219..e0ad39a 100644
--- a/po/it.po
+++ b/po/it.po
@@ -2316,7 +2316,7 @@ msgid "Clever... amending the last one with dirty=
 index."
 msgstr ""
=20
 #: builtin/commit.c:1059
-msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
 msgstr ""
=20
 #: builtin/commit.c:1069 builtin/tag.c:577
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 689ad1b..d749524 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -2153,7 +2153,7 @@ msgid "Clever... amending the last one with dirty=
 index."
 msgstr ""
=20
 #: builtin/commit.c:1116
-msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
 msgstr ""
=20
 #: builtin/commit.c:1126
diff --git a/po/sv.po b/po/sv.po
index 8c3c59a..06feb39 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -3773,7 +3773,7 @@ msgstr "-x och -X kan inte anv=C3=A4ndas samtidig=
t"
=20
 #: builtin/clean.c:906
 msgid ""
-"clean.requireForce set to true and neither -i, -n nor -f given; refus=
ing to "
+"clean.requireForce set to true and neither -i, -n, nor -f given; refu=
sing to "
 "clean"
 msgstr ""
 "clean.requireForce satt till true, men varken -i, -n eller -f angavs;=
 v=C3=A4grar "
@@ -3781,7 +3781,7 @@ msgstr ""
=20
 #: builtin/clean.c:909
 msgid ""
-"clean.requireForce defaults to true and neither -i, -n nor -f given; =
"
+"clean.requireForce defaults to true and neither -i, -n, nor -f given;=
 "
 "refusing to clean"
 msgstr ""
 "clean.requireForce har standardv=C3=A4rdet true och varken -i, -n ell=
er -f "
@@ -4375,7 +4375,7 @@ msgid "Clever... amending the last one with dirty=
 index."
 msgstr "Smart... ut=C3=B6ka den senaste med smutsigt index."
=20
 #: builtin/commit.c:1126
-msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
 msgstr "Explicita s=C3=B6kv=C3=A4gar angavs utan -i eller -o; antar --=
only s=C3=B6kv=C3=A4gar..."
=20
 #: builtin/commit.c:1136 builtin/tag.c:572
diff --git a/po/vi.po b/po/vi.po
index b9676a8..e2d8c48 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -3842,7 +3842,7 @@ msgstr "-x v=C3=A0 -X kh=C3=B4ng th=E1=BB=83 d=C3=
=B9ng c=C3=B9ng m=E1=BB=99t l=C3=BAc v=E1=BB=9Bi nhau"
=20
 #: builtin/clean.c:906
 msgid ""
-"clean.requireForce set to true and neither -i, -n nor -f given; refus=
ing to "
+"clean.requireForce set to true and neither -i, -n, nor -f given; refu=
sing to "
 "clean"
 msgstr ""
 "clean.requireForce =C4=91=C6=B0=E1=BB=A3c =C4=91=E1=BA=B7t th=C3=A0nh=
 true v=C3=A0 kh=C3=B4ng =C4=91=C6=B0a ra t=C3=B9y ch=E1=BB=8Dn -n m=C3=
=A0 c=C5=A9ng "
@@ -3850,7 +3850,7 @@ msgstr ""
=20
 #: builtin/clean.c:909
 msgid ""
-"clean.requireForce defaults to true and neither -i, -n nor -f given; =
"
+"clean.requireForce defaults to true and neither -i, -n, nor -f given;=
 "
 "refusing to clean"
 msgstr ""
 "clean.requireForce m=E1=BA=B7c =C4=91=E1=BB=8Bnh =C4=91=C6=B0=E1=BB=A3=
c =C4=91=E1=BA=B7t l=C3=A0 true v=C3=A0 kh=C3=B4ng =C4=91=C6=B0a ra t=C3=
=B9y ch=E1=BB=8Dn -n m=C3=A0 "
@@ -4460,7 +4460,7 @@ msgid "Clever... amending the last one with dirty=
 index."
 msgstr "Gi=E1=BB=8Fi...  =E2=80=9Ctu b=E1=BB=95=E2=80=9D c=C3=A1i cu=E1=
=BB=91i v=E1=BB=9Bi b=E1=BA=A3ng m=E1=BB=A5c l=E1=BB=A5c b=E1=BA=A9n."
=20
 #: builtin/commit.c:1126
-msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
 msgstr ""
 "Nh=E1=BB=AFng =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn r=C3=B5 r=C3=A0ng =C4=
=91=C6=B0=E1=BB=A3c ch=E1=BB=89 ra kh=C3=B4ng c=C3=B3 t=C3=B9y ch=E1=BB=
=8Dn -i c=C5=A9ng kh=C3=B4ng -o; =C4=91ang "
 "gi=E1=BA=A3 =C4=91=E1=BB=8Bnh --only nh=E1=BB=AFng-=C4=91=C6=B0=E1=BB=
=9Dng-d=E1=BA=ABn..."
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 0942835..04a926d 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -3778,14 +3778,14 @@ msgstr "-x =E5=92=8C -X =E4=B8=8D=E8=83=BD=E5=90=
=8C=E6=97=B6=E4=BD=BF=E7=94=A8"
=20
 #: builtin/clean.c:906
 msgid ""
-"clean.requireForce set to true and neither -i, -n nor -f given; refus=
ing to "
+"clean.requireForce set to true and neither -i, -n, nor -f given; refu=
sing to "
 "clean"
 msgstr ""
 "clean.requireForce =E8=AE=BE=E7=BD=AE=E4=B8=BA true =E4=B8=94=E6=9C=AA=
=E6=8F=90=E4=BE=9B -i=E3=80=81-n =E6=88=96 -f =E9=80=89=E9=A1=B9=EF=BC=8C=
=E6=8B=92=E7=BB=9D=E6=89=A7=E8=A1=8C=E6=B8=85=E7=90=86=E5=8A=A8=E4=BD=9C=
"
=20
 #: builtin/clean.c:909
 msgid ""
-"clean.requireForce defaults to true and neither -i, -n nor -f given; =
"
+"clean.requireForce defaults to true and neither -i, -n, nor -f given;=
 "
 "refusing to clean"
 msgstr ""
 "clean.requireForce =E9=BB=98=E8=AE=A4=E4=B8=BA true =E4=B8=94=E6=9C=AA=
=E6=8F=90=E4=BE=9B -i=E3=80=81-n =E6=88=96 -f =E9=80=89=E9=A1=B9=EF=BC=8C=
=E6=8B=92=E7=BB=9D=E6=89=A7=E8=A1=8C=E6=B8=85=E7=90=86=E5=8A=A8=E4=BD=9C=
"
@@ -4371,7 +4371,7 @@ msgid "Clever... amending the last one with dirty=
 index."
 msgstr "=E8=81=AA=E6=98=8E... =E5=9C=A8=E7=B4=A2=E5=BC=95=E4=B8=8D=E5=B9=
=B2=E5=87=80=E4=B8=8B=E4=BF=AE=E8=A1=A5=E6=9C=80=E5=90=8E=E7=9A=84=E6=8F=
=90=E4=BA=A4=E3=80=82"
=20
 #: builtin/commit.c:1126
-msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
 msgstr "=E6=8C=87=E5=AE=9A=E4=BA=86=E6=98=8E=E7=A1=AE=E7=9A=84=E8=B7=AF=
=E5=BE=84=E8=80=8C=E6=B2=A1=E6=9C=89=E4=BD=BF=E7=94=A8 -i =E6=88=96 -o =
=E9=80=89=E9=A1=B9=EF=BC=9B=E8=AE=A4=E4=B8=BA=E6=98=AF --only paths..."
=20
 #: builtin/commit.c:1136 builtin/tag.c:572
--=20
1.9.0.279.gdc9e3eb
