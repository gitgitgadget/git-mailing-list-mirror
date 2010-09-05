From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20po/hi=2Epo=3A=20Add=20Hindi=20Translation?=
Date: Sun,  5 Sep 2010 23:57:47 +0530
Message-ID: <1283711267-27679-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 05 20:30:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsJz2-00052d-VN
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 20:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab0IES37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 14:29:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38568 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab0IES36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 14:29:58 -0400
Received: by pzk9 with SMTP id 9so1179377pzk.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=UDrDsohokZL5YGcSYoL2cJYWVHGjLMn/7UU0z8hzAAk=;
        b=jseokEncJL+3thGoOfme7wkP0RdwaMexojr6oGL/7ukF3CYnr4eo2/lODkQKDxP2x8
         9Sq5Ni33KkEpyM7pQHHA6wHK+lu4yMbJoPHsmfk2duo3adgKNvaSmSmUGu1M+MVg0Fgu
         EOgABIfDeZNlkQd5AQoQSPXyJKpgfM7wXlAdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=crEV/+GpA7KqWb1kni9A9/hVY9yWhAVK1Zaiz/+JGXe8BqgohChpzvmYoqyg9sxqBg
         0ZM5xfNHsbn5+WUgNg8MJ9WzJzV1kzLzy5/yjPpK5lrdd0CB7HDY01s0dmmLKVu7gmpV
         2PNi4JC05CYGn/mroIxmhItupVXsVTZGkzQpw=
Received: by 10.142.112.19 with SMTP id k19mr289360wfc.266.1283711398229;
        Sun, 05 Sep 2010 11:29:58 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id q23sm2924915wfc.6.2010.09.05.11.29.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 11:29:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155473>

Translate a few Git messages to Standard Hindi. It uses a phonetic
script called Devanagari. Focus especially on transforming grammar and
tense in a sane manner to serve as a guideline for future translators.

Note that Devanagari rendering is broken on many applications by
default at this time- the latest Emacs, Vim and Chrome render it
incorrectly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 Note that I don't know Hindi well myself- I read the grammar rules,
 looked up some dictionaries, and used peer review to focus on few
 high-quality translations. The grammar/ tense transformation from
 English is especially non-trivial. I'd encourage an expert Hindi
 speaker to contribute to this.

 To fix rendering in Emacs, see
 http://www.emacswiki.org/emacs/SupportHindi

 po/hi.po |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 po/hi.po

diff --git a/po/hi.po b/po/hi.po
new file mode 100644
index 0000000..d31e60b
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
=A4=96=E0=A4=A8=E0=A5=87 =E0=A4=AF=E0=A5=8B=E0=A4=97=E0=A5=8D=E0=A4=AF =
=E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=
=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "insanely long template name %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F =E0=A4=95=E0=A4=BE =E0=A4=A8=E0=A4=BE=E0=A4=AE =E0=A4=AC=E0=A4=
=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=BE =E0=A4=B9=E0=
=A5=88: %s"
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
=E0=A4=BF=E0=A4=95=E0=A4=BE =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=
=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87: '%s'"
+
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 =E0=A4=A8=E0=A4=B9=E0=A5=80=
=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87: '%s'=
"
+
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "=E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=A4=E0=A5=80=E0=A4=95=E0=A4=BE=
=E0=A4=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95=
 =E0=A4=AC=E0=A4=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=
=BE =E0=A4=B9=E0=A5=88: %s"
+
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "'%s' =E0=A4=B8=E0=A5=87 '%s' =E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=
=A4=E0=A5=80=E0=A4=95=E0=A4=BE=E0=A4=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=
=B2=E0=A4=BF=E0=A4=82=E0=A4=95 =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "'%s' =E0=A4=95=E0=A4=BE =E0=A4=A8=E0=A4=95=E0=A4=B2 '%s' =E0=A4=
=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=
=A4=95=E0=A5=87"
+
+#, c-format
+msgid "ignoring template %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F =E0=A4=95=E0=A5=8B =E0=A4=89=E0=A4=AA=E0=A5=87=E0=A4=95=E0=A5=
=8D=E0=A4=B7=E0=A4=BE =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87 =E0=
=A4=B9=E0=A5=88: %s"
+
+#, c-format
+msgid "insanely long template path %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F =E0=A4=95=E0=A4=BE =E0=A4=86=E0=A4=95=E0=A4=BE=E0=A4=B0 =E0=A4=
=AC=E0=A4=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=BE =E0=
=A4=B9=E0=A5=88: %s"
+
+#, c-format
+msgid "templates not found %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AE=E0=A4=BF=E0=A4=
=B2=E0=A4=BE: %s"
+
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "'%s' =E0=A4=B8=E0=A5=87 =E0=A4=97=E0=A4=B2=E0=A4=A4 =E0=A4=B8=E0=
=A5=8D=E0=A4=B5=E0=A4=B0=E0=A5=82=E0=A4=AA =E0=A4=B8=E0=A4=82=E0=A4=B8=E0=
=A5=8D=E0=A4=95=E0=A4=B0=E0=A4=A3 %d =E0=A4=95=E0=A4=BE =E0=A4=9F=E0=A5=
=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=E0=A4=9F =E0=A4=A8=E0=A4=
=95=E0=A4=B2 =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=
=A4=B0=E0=A4=B9=E0=A5=87 =E0=A4=B9=E0=A5=88"
+
+#, c-format
+msgid "insane git directory %s"
+msgstr "=E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=9F=
 =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=
=E0=A4=95=E0=A4=BE %s"
--=20
1.7.2.2.409.gdbb11.dirty
