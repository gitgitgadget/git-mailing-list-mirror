From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=5D=20po/hi=2Epo=3A=20Add=20Hindi=20Translation?=
Date: Thu,  9 Sep 2010 00:08:51 +0530
Message-ID: <1283971131-25106-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antriksh Pany <antriksh.pany@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 08 20:41:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtPZt-0001zP-NP
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 20:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab0IHSkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 14:40:53 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43508 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab0IHSkv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 14:40:51 -0400
Received: by pwi3 with SMTP id 3so188261pwi.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=eqrh3z+XUkeHUynxIhMpQ3KIYPHEnI+wV3PZD1Qzcw0=;
        b=LghAswPTBlbV5M7+zDT3tHCCAsjvRvBItkuRrysNayXoLuZIqhTkDEzR7pM5DXdNX6
         EQWNRA9RMBIZSiLo5G2dNiUl/8ZYUWE2CM34EvPMPBlXabxRbvaRQNPGGSoPG3YuPwXh
         01sMoqndC3HwDlc7kjthiLY1srjsqDFsz1stI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Qh/VO+lIBrhjA7uFCm4PM2sHXlJas/xf/rz9e9WdANf/NzewX+gMe1O8rX1y3t4XGV
         qtR1ZHgx1FQv0q5AP70BN/4Navj/riBqCsf3psfGI1/97VkCy2uYMWiyX5Igzlwuswt+
         CVV3Qx2iMUXZiz1+ytvAOCCm0uKSyks9Y/tUQ=
Received: by 10.142.47.5 with SMTP id u5mr111537wfu.28.1283971251049;
        Wed, 08 Sep 2010 11:40:51 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t18sm321257wfc.23.2010.09.08.11.40.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 11:40:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155808>

Translate a few Git messages to Standard Hindi. It uses a phonetic
script called Devanagari. Focus especially on transforming grammar and
tense in a sane manner to serve as a guideline for future translators.

Note that Devanagari rendering is broken on many applications by
default at this time- the latest Emacs, Vim and Chrome render it
incorrectly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: Antriksh Pany <antriksh.pany@gmail.com>
Cc: Sitaram Chamarty <sitaramc@gmail.com>
---
 Thanks to Antriksh's reviews, we have some more improvements/
 corrections. I've also squashed in a few more of my own. I haven't
 addressed the issue of using "complex or imprecise Hindi words"
 versus "transliteration" fully because I've received several
 conflicting opinions from existing Indian translators on this
 issue. The central issue is that Hindi is seldom used in the field of
 science. I think the best solution is to commit this revision and let
 hi.po evolve naturally as future translators contribute more
 translations.

 po/hi.po |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 po/hi.po

diff --git a/po/hi.po b/po/hi.po
new file mode 100644
index 0000000..46fd544
--- /dev/null
+++ b/po/hi.po
@@ -0,0 +1,67 @@
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"Last-Translator: Ramkumar Ramachandra <artagnon@gmail.com>\n"
+"POT-Creation-Date: 2010-09-05 16:05+0530\n"
+"Language: hi\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr "%s =E0=A4=95=E0=A5=8B =E0=A4=B8=E0=A4=AE=E0=A5=82=E0=A4=B9 =E0=
=A4=A6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=B0=E0=A4=BE =E0=A4=B2=E0=A4=BF=E0=
=A4=96=E0=A4=A8=E0=A5=87 =E0=A4=95=E0=A5=80 =E0=A4=87=E0=A4=9C=E0=A4=BE=
=E0=A4=9C=E0=A4=BC=E0=A4=A4 =E0=A4=A8=E0=A4=B9=E0=A5=80 =E0=A4=A6=E0=A5=
=87 =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "insanely long template name %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=95=E0=A4=BE =E0=A4=A8=E0=A4=BE=E0=A4=AE =E0=A4=85=E0=
=A4=A4=E0=A5=8D=E0=A4=AF=E0=A4=82=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=
=A4=BE"
+
+#, c-format
+msgid "cannot stat '%s'"
+msgstr "'%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=
=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F '%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=
=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "=E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=A4=E0=A5=80=E0=A4=95=E0=A4=BE=
=E0=A4=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95=
 %s =E0=A4=85=E0=A4=A4=E0=A5=8D=E0=A4=AF=E0=A4=82=E0=A4=A4 =E0=A4=B2=E0=
=A4=82=E0=A4=AC=E0=A4=BE"
+
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "'%s' =E0=A4=95=E0=A4=BE =E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=A4=E0=
=A5=80=E0=A4=95=E0=A4=BE=E0=A4=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=B2=E0=
=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=E0=A4=
=B9=E0=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=A4=95=E0=
=A5=87"
+
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "'%s' =E0=A4=95=E0=A5=80 =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=95=E0=
=A5=83=E0=A4=A4=E0=A4=BF '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=E0=A4=
=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "ignoring template %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=95=E0=A5=80 =E0=A4=89=E0=A4=AA=E0=A5=87=E0=A4=95=E0=
=A5=8D=E0=A4=B7=E0=A4=BE =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87=
 =E0=A4=B9=E0=A5=88=E0=A4=82"
+
+#, c-format
+msgid "insanely long template path %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=95=E0=A5=80 [path] =E0=A4=85=E0=A4=A4=E0=A5=8D=E0=A4=
=AF=E0=A4=82=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=BE"
+
+#, c-format
+msgid "templates not found %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AE=E0=A4=BF=E0=
=A4=B2=E0=A4=BE"
+
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "'%s' =E0=A4=B8=E0=A5=87 =E0=A4=97=E0=A4=B2=E0=A4=A4 =E0=A4=B8=E0=
=A5=8D=E0=A4=B5=E0=A4=B0=E0=A5=82=E0=A4=AA =E0=A4=B8=E0=A4=82=E0=A4=B8=E0=
=A5=8D=E0=A4=95=E0=A4=B0=E0=A4=A3 %d =E0=A4=95=E0=A5=87 =E0=A4=9F=E0=A5=
=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=E0=A4=9F=E0=A5=8D=E0=A4=
=B8 =E0=A4=95=E0=A5=80 =E0=A4=A8=E0=A4=95=E0=A4=B2 =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87 =E0=A4=B9=
=E0=A5=88=E0=A4=82"
+
+#, c-format
+msgid "insane git directory %s"
+msgstr "=E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=9F=
 =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=
=E0=A4=95=E0=A4=BE %s"
--=20
1.7.2.2.409.gdbb11.dirty
