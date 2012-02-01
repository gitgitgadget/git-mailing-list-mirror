From: Jiang Xin <worldhello.net@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20i18n=3A=20po=20for=20zh=5Fcn?=
Date: Wed,  1 Feb 2012 23:50:36 +0800
Message-ID: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 16:51:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RscSt-0000q2-De
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 16:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab2BAPvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 10:51:13 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57427 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab2BAPvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 10:51:10 -0500
Received: by ghrr11 with SMTP id r11so615367ghr.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 07:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=VK77iajjoaEn/7SZBVG/qq2YYs/VZKCZEkVW4myy7DY=;
        b=pvjI1h02lDYdsem/+NIPjhl6quE6YurwRgLhyAhslcmlQWtFLoeTyhzWwbv1cPlK4x
         tMsglbuhRTuhV2XoufymPWE/scAt9H4kH+XGVJOXYD616JDqcqyeLANadtdy9NyK0jqY
         Q0BSVUSopK49trpy1qUnj5mp+wW0O7EvaQhss=
Received: by 10.50.6.194 with SMTP id d2mr27213670iga.24.1328111468562;
        Wed, 01 Feb 2012 07:51:08 -0800 (PST)
Received: from localhost.foo.bar ([123.116.240.29])
        by mx.google.com with ESMTPS id uy10sm4510142igc.1.2012.02.01.07.50.46
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 07:51:07 -0800 (PST)
X-Mailer: git-send-email 1.7.9.3.g1fbd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189518>

Git can speak Chinese now.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/zh_cn.po | 3568 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9, 3568 =E5=A4=84=
=E6=B7=BB=E5=8A=A0(+), 0 =E5=A4=84=E5=88=A0=E9=99=A4(-)
 create mode 100644 po/zh_cn.po

diff --git a/po/zh_cn.po b/po/zh_cn.po
new file mode 100644
index 00000..61a5b
--- /dev/null
+++ b/po/zh_cn.po
@@ -0,0 +1,3568 @@
+# Chinese translations for Git package
+# Git =E8=BD=AF=E4=BB=B6=E5=8C=85=E7=9A=84=E7=AE=80=E4=BD=93=E4=B8=AD=E6=
=96=87=E7=BF=BB=E8=AF=91.
+# Copyright (C) 2012 Jiang Xin <worldhello.net AT gmail.com>
+# This file is distributed under the same license as the Git package.
+# Contributers:
+#   - Jiang Xin <worldhello.net AT gmail.com>
+#   - Riku <lu.riku AT gmail.com>
+#   - Zhuang Ya <zhuangya AT me.com>
+#   - Lian Cheng <rhythm.mail AT gmail.com>
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2012-02-01 20:52+0800\n"
+"PO-Revision-Date: 2012-01-30 00:00+0800\n"
+"Last-Translator: riku <lu.riku@gmail.com>\n"
+"Language-Team: GitHub <https://github.com/gotgit/git-l10n-zh-cn/>\n"
+"Language: zh_CN\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D1; plural=3D0;\n"
+
+#: commit.c:47
+#, c-format
+msgid "could not parse %s"
+msgstr "=E4=B8=8D=E8=83=BD=E8=A7=A3=E6=9E=90 %s"
+
+#: commit.c:49
+#, c-format
+msgid "%s %s is not a commit!"
+msgstr "%s %s =E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E6=8F=90=E4=BA=A4!"
+
+#: compat/obstack.c:406 compat/obstack.c:408
+msgid "memory exhausted"
+msgstr "=E5=86=85=E5=AD=98=E8=80=97=E5=B0=BD"
+
+#: connected.c:39
+msgid "Could not run 'git rev-list'"
+msgstr "=E4=B8=8D=E8=83=BD=E6=89=A7=E8=A1=8C 'git rev-list'"
+
+#: connected.c:48
+#, c-format
+msgid "failed write to rev-list: %s"
+msgstr "=E6=97=A0=E6=B3=95=E5=86=99=E5=85=A5 rev-list=EF=BC=9A%s"
+
+#: connected.c:56
+#, c-format
+msgid "failed to close rev-list's stdin: %s"
+msgstr "=E6=97=A0=E6=B3=95=E5=85=B3=E9=97=AD rev-list =E7=9A=84=E6=A0=87=
=E5=87=86=E8=BE=93=E5=85=A5=EF=BC=9A%s"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: diff.c:104
+#, c-format
+msgid "  Failed to parse dirstat cut-off percentage '%.*s'\n"
+msgstr "  =E6=97=A0=E6=B3=95=E8=A7=A3=E6=9E=90 dirstat =E9=98=88=E5=80=
=BC '%.*s'\n"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: diff.c:109
+#, c-format
+msgid "  Unknown dirstat parameter '%.*s'\n"
+msgstr "  =E6=9C=AA=E7=9F=A5 dirstat =E5=8F=82=E6=95=B0 '%.*s'\n"
+
+#: diff.c:208
+#, c-format
+msgid ""
+"Found errors in 'diff.dirstat' config variable:\n"
+"%s"
+msgstr ""
+"=E9=85=8D=E7=BD=AE=E5=8F=98=E9=87=8F 'diff.dirstat' =E5=87=BA=E9=94=99=
=EF=BC=9A\n"
+"%s"
+
+#: diff.c:1479 diff.c:1510 builtin/apply.c:3244
+#, c-format
+msgid " %d files changed, %d insertions(+), %d deletions(-)\n"
+msgstr " %d =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9, %d=
 =E5=A4=84=E6=B7=BB=E5=8A=A0(+), %d =E5=A4=84=E5=88=A0=E9=99=A4(-)\n"
+
+#: diff.c:3308
+#, c-format
+msgid ""
+"Failed to parse --dirstat/-X option parameter:\n"
+"%s"
+msgstr ""
+"=E6=97=A0=E6=B3=95=E8=A7=A3=E6=9E=90 --dirstat/-X =E9=80=89=E9=A1=B9=E7=
=9A=84=E5=8F=82=E6=95=B0=EF=BC=9A\n"
+"%s"
+
+#: gpg-interface.c:59
+msgid "could not run gpg."
+msgstr "=E4=B8=8D=E8=83=BD=E6=89=A7=E8=A1=8C gpg=E3=80=82"
+
+#: gpg-interface.c:71
+msgid "gpg did not accept the data"
+msgstr "gpg =E6=B2=A1=E6=9C=89=E6=8E=A5=E5=8F=97=E6=95=B0=E6=8D=AE"
+
+#: gpg-interface.c:82
+msgid "gpg failed to sign the data"
+msgstr "gpg =E6=97=A0=E6=B3=95=E4=B8=BA=E6=95=B0=E6=8D=AE=E7=AD=BE=E5=90=
=8D"
+
+#: help.c:309
+#, c-format
+msgid ""
+"'%s' appears to be a git command, but we were not\n"
+"able to execute it. Maybe git-%s is broken?"
+msgstr ""
+"'%s' =E5=83=8F=E6=98=AF=E4=B8=80=E4=B8=AA git =E5=91=BD=E4=BB=A4=EF=BC=
=8C=E4=BD=86=E5=8D=B4=E6=97=A0=E6=B3=95=E8=BF=90=E8=A1=8C=E3=80=82\n"
+"=E5=8F=AF=E8=83=BD=E6=98=AF git-%s =E5=8F=97=E6=8D=9F=EF=BC=9F"
+
+#: remote.c:1575
+#, c-format
+msgid "Your branch is ahead of '%s' by %d %s.\n"
+msgstr "=E6=82=A8=E7=9A=84=E5=88=86=E6=94=AF=E9=A2=86=E5=85=88 '%s' =E5=
=85=B1 %d =E4=B8=AA%s=E3=80=82\n"
+
+#: remote.c:1577 remote.c:1582
+msgid "commit"
+msgid_plural "commits"
+msgstr[0] "=E6=8F=90=E4=BA=A4"
+
+#: remote.c:1579
+#, c-format
+msgid "Your branch is behind '%s' by %d %s, and can be fast-forwarded.=
\n"
+msgstr "=E6=82=A8=E7=9A=84=E5=88=86=E6=94=AF=E8=90=BD=E5=90=8E '%s' =E5=
=85=B1 %d =E4=B8=AA%s=EF=BC=8C=E4=B8=94=E5=8F=AF=E4=BB=A5=E5=BF=AB=E8=BF=
=9B=E5=BC=8F=E6=8E=A8=E9=80=81=E3=80=82\n"
+
+#: remote.c:1584
+#, c-format
+msgid ""
+"Your branch and '%s' have diverged,\n"
+"and have %d and %d different commit(s) each, respectively.\n"
+msgstr ""
+"=E6=82=A8=E7=9A=84=E5=88=86=E6=94=AF=E5=92=8C '%s' =E5=87=BA=E7=8E=B0=
=E4=BA=86=E5=81=8F=E7=A6=BB=EF=BC=8C\n"
+"=E5=B9=B6=E4=B8=94=E5=90=84=E8=87=AA=E5=88=86=E5=88=AB=E6=9C=89 %d =E5=
=92=8C %d =E5=A4=84=E4=B8=8D=E5=90=8C=E7=9A=84=E6=8F=90=E4=BA=A4=E3=80=82=
\n"
+
+#: wt-status.c:134
+msgid "Unmerged paths:"
+msgstr "=E6=9C=AA=E5=90=88=E5=B9=B6=E7=9A=84=E8=B7=AF=E5=BE=84=EF=BC=9A=
"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:140 wt-status.c:157
+#, c-format
+msgid "  (use \"git reset %s <file>...\" to unstage)"
+msgstr "  =EF=BC=88=E4=BD=BF=E7=94=A8 \"git reset %s <file>...\" =E6=92=
=A4=E5=87=BA=E6=9A=82=E5=AD=98=E5=8C=BA=EF=BC=89"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:142 wt-status.c:159
+msgid "  (use \"git rm --cached <file>...\" to unstage)"
+msgstr "  =EF=BC=88=E4=BD=BF=E7=94=A8 \"git rm --cached <file>...\" =E6=
=92=A4=E5=87=BA=E6=9A=82=E5=AD=98=E5=8C=BA=EF=BC=89"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:143
+msgid "  (use \"git add/rm <file>...\" as appropriate to mark resoluti=
on)"
+msgstr "  =EF=BC=88=E9=85=8C=E6=83=85=E4=BD=BF=E7=94=A8 \"git add/rm <=
file>...\" =E6=A0=87=E8=AE=B0=E8=A7=A3=E5=86=B3=E6=96=B9=E6=A1=88=EF=BC=
=89"
+
+#: wt-status.c:151
+msgid "Changes to be committed:"
+msgstr "=E8=A6=81=E6=8F=90=E4=BA=A4=E7=9A=84=E5=8F=98=E6=9B=B4=EF=BC=9A=
"
+
+#: wt-status.c:169
+msgid "Changes not staged for commit:"
+msgstr "=E6=9C=AA=E6=9A=82=E5=AD=98=E8=87=B3=E6=8F=90=E4=BA=A4=E7=9A=84=
=E5=8F=98=E6=9B=B4=EF=BC=9A"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:173
+msgid "  (use \"git add <file>...\" to update what will be committed)"
+msgstr "  =EF=BC=88=E4=BD=BF=E7=94=A8 \"git add <file>...\" =E6=9B=B4=E6=
=96=B0=E8=A6=81=E6=8F=90=E4=BA=A4=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=89"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:175
+msgid "  (use \"git add/rm <file>...\" to update what will be committe=
d)"
+msgstr "  =EF=BC=88=E4=BD=BF=E7=94=A8 \"git add/rm <file>...\" =E6=9B=B4=
=E6=96=B0=E8=A6=81=E6=8F=90=E4=BA=A4=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=89=
"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:176
+msgid ""
+"  (use \"git checkout -- <file>...\" to discard changes in working di=
rectory)"
+msgstr "  =EF=BC=88=E4=BD=BF=E7=94=A8 \"git checkout -- <file>...\" =E4=
=B8=A2=E5=BC=83=E5=B7=A5=E4=BD=9C=E5=8C=BA=E7=9A=84=E6=94=B9=E5=8A=A8=EF=
=BC=89"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:178
+msgid "  (commit or discard the untracked or modified content in submo=
dules)"
+msgstr "  =EF=BC=88=E6=8F=90=E4=BA=A4=E6=88=96=E4=B8=A2=E5=BC=83=E5=AD=
=90=E6=A8=A1=E7=BB=84=E4=B8=AD=E6=9C=AA=E8=B7=9F=E8=B8=AA=E6=88=96=E4=BF=
=AE=E6=94=B9=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=89"
+
+#: wt-status.c:187
+#, c-format
+msgid "%s files:"
+msgstr "%s=E6=96=87=E4=BB=B6=EF=BC=9A"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:190
+#, c-format
+msgid "  (use \"git %s <file>...\" to include in what will be committe=
d)"
+msgstr "  =EF=BC=88=E4=BD=BF=E7=94=A8 \"git %s <file>...\" =E5=8C=85=E5=
=90=AB=E5=88=B0=E6=8F=90=E4=BA=A4=E5=88=97=E8=A1=A8=EF=BC=89"
+
+#: wt-status.c:207
+msgid "bug"
+msgstr "bug"
+
+#: wt-status.c:212
+msgid "both deleted:"
+msgstr "=E5=8F=8C=E6=96=B9=E5=88=A0=E9=99=A4=EF=BC=9A"
+
+#: wt-status.c:213
+msgid "added by us:"
+msgstr "=E7=94=B1=E6=88=91=E4=BB=AC=E6=B7=BB=E5=8A=A0=EF=BC=9A"
+
+#: wt-status.c:214
+msgid "deleted by them:"
+msgstr "=E7=94=B1=E4=BB=96=E4=BB=AC=E5=88=A0=E9=99=A4=EF=BC=9A"
+
+#: wt-status.c:215
+msgid "added by them:"
+msgstr "=E7=94=B1=E4=BB=96=E4=BB=AC=E6=B7=BB=E5=8A=A0=EF=BC=9A"
+
+#: wt-status.c:216
+msgid "deleted by us:"
+msgstr "=E7=94=B1=E6=88=91=E4=BB=AC=E5=88=A0=E9=99=A4=EF=BC=9A"
+
+#: wt-status.c:217
+msgid "both added:"
+msgstr "=E5=8F=8C=E6=96=B9=E6=B7=BB=E5=8A=A0=EF=BC=9A"
+
+#: wt-status.c:218
+msgid "both modified:"
+msgstr "=E5=8F=8C=E6=96=B9=E4=BF=AE=E6=94=B9=EF=BC=9A"
+
+#: wt-status.c:248
+msgid "new commits, "
+msgstr "=E6=96=B0=E6=8F=90=E4=BA=A4=EF=BC=8C"
+
+#: wt-status.c:250
+msgid "modified content, "
+msgstr "=E4=BF=AE=E6=94=B9=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C"
+
+#: wt-status.c:252
+msgid "untracked content, "
+msgstr "=E6=9C=AA=E8=B7=9F=E8=B8=AA=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=
"
+
+#  =E4=B8=BA=E4=BF=9D=E8=AF=81=E5=9C=A8=E8=BE=93=E5=87=BA=E4=B8=AD=E5=AF=
=B9=E9=BD=90=EF=BC=8C=E6=B3=A8=E6=84=8F=E8=B0=83=E6=95=B4=E5=8F=A5=E4=B8=
=AD=E7=A9=BA=E6=A0=BC=EF=BC=81
+#: wt-status.c:266
+#, c-format
+msgid "new file:   %s"
+msgstr "=E6=96=B0=E6=96=87=E4=BB=B6=EF=BC=9A    %s"
+
+#  =E4=B8=BA=E4=BF=9D=E8=AF=81=E5=9C=A8=E8=BE=93=E5=87=BA=E4=B8=AD=E5=AF=
=B9=E9=BD=90=EF=BC=8C=E6=B3=A8=E6=84=8F=E8=B0=83=E6=95=B4=E5=8F=A5=E4=B8=
=AD=E7=A9=BA=E6=A0=BC=EF=BC=81
+#: wt-status.c:269
+#, c-format
+msgid "copied:     %s -> %s"
+msgstr "=E6=8B=B7=E8=B4=9D=EF=BC=9A      %s -> %s"
+
+#  =E4=B8=BA=E4=BF=9D=E8=AF=81=E5=9C=A8=E8=BE=93=E5=87=BA=E4=B8=AD=E5=AF=
=B9=E9=BD=90=EF=BC=8C=E6=B3=A8=E6=84=8F=E8=B0=83=E6=95=B4=E5=8F=A5=E4=B8=
=AD=E7=A9=BA=E6=A0=BC=EF=BC=81
+#: wt-status.c:272
+#, c-format
+msgid "deleted:    %s"
+msgstr "=E5=88=A0=E9=99=A4=EF=BC=9A      %s"
+
+#  =E4=B8=BA=E4=BF=9D=E8=AF=81=E5=9C=A8=E8=BE=93=E5=87=BA=E4=B8=AD=E5=AF=
=B9=E9=BD=90=EF=BC=8C=E6=B3=A8=E6=84=8F=E8=B0=83=E6=95=B4=E5=8F=A5=E4=B8=
=AD=E7=A9=BA=E6=A0=BC=EF=BC=81
+#: wt-status.c:275
+#, c-format
+msgid "modified:   %s"
+msgstr "=E4=BF=AE=E6=94=B9=EF=BC=9A      %s"
+
+#  =E4=B8=BA=E4=BF=9D=E8=AF=81=E5=9C=A8=E8=BE=93=E5=87=BA=E4=B8=AD=E5=AF=
=B9=E9=BD=90=EF=BC=8C=E6=B3=A8=E6=84=8F=E8=B0=83=E6=95=B4=E5=8F=A5=E4=B8=
=AD=E7=A9=BA=E6=A0=BC=EF=BC=81
+#: wt-status.c:278
+#, c-format
+msgid "renamed:    %s -> %s"
+msgstr "=E9=87=8D=E5=91=BD=E5=90=8D=EF=BC=9A    %s -> %s"
+
+#  =E4=B8=BA=E4=BF=9D=E8=AF=81=E5=9C=A8=E8=BE=93=E5=87=BA=E4=B8=AD=E5=AF=
=B9=E9=BD=90=EF=BC=8C=E6=B3=A8=E6=84=8F=E8=B0=83=E6=95=B4=E5=8F=A5=E4=B8=
=AD=E7=A9=BA=E6=A0=BC=EF=BC=81
+#: wt-status.c:281
+#, c-format
+msgid "typechange: %s"
+msgstr "=E7=B1=BB=E5=9E=8B=E5=8F=98=E6=9B=B4=EF=BC=9A  %s"
+
+#  =E4=B8=BA=E4=BF=9D=E8=AF=81=E5=9C=A8=E8=BE=93=E5=87=BA=E4=B8=AD=E5=AF=
=B9=E9=BD=90=EF=BC=8C=E6=B3=A8=E6=84=8F=E8=B0=83=E6=95=B4=E5=8F=A5=E4=B8=
=AD=E7=A9=BA=E6=A0=BC=EF=BC=81
+#: wt-status.c:284
+#, c-format
+msgid "unknown:    %s"
+msgstr "=E6=9C=AA=E7=9F=A5=EF=BC=9A      %s"
+
+#  =E4=B8=BA=E4=BF=9D=E8=AF=81=E5=9C=A8=E8=BE=93=E5=87=BA=E4=B8=AD=E5=AF=
=B9=E9=BD=90=EF=BC=8C=E6=B3=A8=E6=84=8F=E8=B0=83=E6=95=B4=E5=8F=A5=E4=B8=
=AD=E7=A9=BA=E6=A0=BC=EF=BC=81
+#: wt-status.c:287
+#, c-format
+msgid "unmerged:   %s"
+msgstr "=E6=9C=AA=E5=90=88=E5=B9=B6=EF=BC=9A    %s"
+
+#: wt-status.c:290
+#, c-format
+msgid "bug: unhandled diff status %c"
+msgstr "bug: =E6=9C=AA=E5=A4=84=E7=90=86=E7=9A=84=E5=B7=AE=E5=BC=82=E7=
=8A=B6=E6=80=81 %c"
+
+#: wt-status.c:713
+msgid "On branch "
+msgstr "=E4=BD=8D=E4=BA=8E=E5=88=86=E6=94=AF "
+
+#: wt-status.c:720
+msgid "Not currently on any branch."
+msgstr "=E5=BD=93=E5=89=8D=E4=B8=8D=E5=9C=A8=E4=BB=BB=E4=BD=95=E5=88=86=
=E6=94=AF=E4=B8=8A=E3=80=82"
+
+#: wt-status.c:731
+msgid "Initial commit"
+msgstr "=E5=88=9D=E5=A7=8B=E6=8F=90=E4=BA=A4"
+
+#: wt-status.c:745
+msgid "Untracked"
+msgstr "=E6=9C=AA=E8=B7=9F=E8=B8=AA=E7=9A=84"
+
+#: wt-status.c:747
+msgid "Ignored"
+msgstr "=E5=BF=BD=E7=95=A5=E7=9A=84"
+
+#: wt-status.c:749
+#, c-format
+msgid "Untracked files not listed%s"
+msgstr "=E6=9C=AA=E8=B7=9F=E8=B8=AA=E7=9A=84=E6=96=87=E4=BB=B6=E6=B2=A1=
=E6=9C=89=E5=88=97=E5=87=BA%s"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:751
+msgid " (use -u option to show untracked files)"
+msgstr " =EF=BC=88=E4=BD=BF=E7=94=A8 -u =E5=8F=82=E6=95=B0=E6=98=BE=E7=
=A4=BA=E6=9C=AA=E8=B7=9F=E8=B8=AA=E7=9A=84=E6=96=87=E4=BB=B6=EF=BC=89"
+
+#: wt-status.c:757
+msgid "No changes"
+msgstr "=E6=B2=A1=E6=9C=89=E4=BF=AE=E6=94=B9"
+
+#: wt-status.c:761
+#, c-format
+msgid "no changes added to commit%s\n"
+msgstr "=E4=BF=AE=E6=94=B9=E5=B0=9A=E6=9C=AA=E5=8A=A0=E5=85=A5=E6=8F=90=
=E4=BA=A4%s\n"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:763
+msgid " (use \"git add\" and/or \"git commit -a\")"
+msgstr " =EF=BC=88=E4=BD=BF=E7=94=A8 \"git add\" =E5=92=8C/=E6=88=96 \=
"git commit -a\"=EF=BC=89"
+
+#: wt-status.c:765
+#, c-format
+msgid "nothing added to commit but untracked files present%s\n"
+msgstr "=E7=A9=BA=E6=8F=90=E4=BA=A4=E4=BD=86=E5=AD=98=E5=9C=A8=E6=9C=AA=
=E8=B7=9F=E8=B8=AA=E6=96=87=E4=BB=B6%s\n"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:767
+msgid " (use \"git add\" to track)"
+msgstr " =EF=BC=88=E4=BD=BF=E7=94=A8 \"git add\" =E5=BB=BA=E7=AB=8B=E8=
=B7=9F=E8=B8=AA=EF=BC=89"
+
+#: wt-status.c:769 wt-status.c:772 wt-status.c:775
+#, c-format
+msgid "nothing to commit%s\n"
+msgstr "=E6=97=A0=E9=A1=BB=E6=8F=90=E4=BA=A4%s\n"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:770
+msgid " (create/copy files and use \"git add\" to track)"
+msgstr " =EF=BC=88=E6=96=B0=E5=BB=BA/=E6=8B=B7=E8=B4=9D=E7=9A=84=E6=96=
=87=E4=BB=B6=E4=BD=BF=E7=94=A8 \"git add\" =E5=BB=BA=E7=AB=8B=E8=B7=9F=E8=
=B8=AA=EF=BC=89"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:773
+msgid " (use -u to show untracked files)"
+msgstr " =EF=BC=88=E4=BD=BF=E7=94=A8 -u =E6=98=BE=E7=A4=BA=E6=9C=AA=E8=
=B7=9F=E8=B8=AA=E6=96=87=E4=BB=B6=EF=BC=89"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:776
+msgid " (working directory clean)"
+msgstr " =EF=BC=88=E5=B9=B2=E5=87=80=E7=9A=84=E5=B7=A5=E4=BD=9C=E5=8C=BA=
=EF=BC=89"
+
+#: wt-status.c:884
+msgid "HEAD (no branch)"
+msgstr "=E5=A4=B4=EF=BC=88=E9=9D=9E=E5=88=86=E6=94=AF=EF=BC=89"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=A5=E5=B0=BE=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:890
+msgid "Initial commit on "
+msgstr "=E5=88=9D=E5=A7=8B=E6=8F=90=E4=BA=A4=E4=BA=8E "
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=A5=E5=B0=BE=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:905
+msgid "behind "
+msgstr "=E8=90=BD=E5=90=8E "
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=A5=E5=B0=BE=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:908 wt-status.c:911
+msgid "ahead "
+msgstr "=E9=A2=86=E5=85=88 "
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=A5=E5=B0=BE=E7=A9=BA=E6=A0=
=BC
+#: wt-status.c:913
+msgid ", behind "
+msgstr "=EF=BC=8C=E8=90=BD=E5=90=8E "
+
+#: builtin/add.c:62
+#, c-format
+msgid "unexpected diff status %c"
+msgstr "=E6=84=8F=E5=A4=96=E7=9A=84=E5=B7=AE=E5=BC=82=E7=8A=B6=E6=80=81=
 %c"
+
+#: builtin/add.c:67 builtin/commit.c:298
+msgid "updating files failed"
+msgstr "=E6=9B=B4=E6=96=B0=E6=96=87=E4=BB=B6=E5=A4=B1=E8=B4=A5"
+
+#: builtin/add.c:77
+#, c-format
+msgid "remove '%s'\n"
+msgstr "=E5=88=A0=E9=99=A4 '%s'\n"
+
+#: builtin/add.c:176
+#, c-format
+msgid "Path '%s' is in submodule '%.*s'"
+msgstr "=E8=B7=AF=E5=BE=84 '%s' =E5=B1=9E=E4=BA=8E=E6=A8=A1=E7=BB=84 '=
%.*s'"
+
+#: builtin/add.c:192
+msgid "Unstaged changes after refreshing the index:"
+msgstr "=E5=88=B7=E6=96=B0=E6=9A=82=E5=AD=98=E5=8C=BA=E5=90=8E=E6=9C=AA=
=E6=9A=82=E5=AD=98=E7=9A=84=E5=8F=98=E6=9B=B4=EF=BC=9A"
+
+#: builtin/add.c:195 builtin/add.c:455 builtin/rm.c:186
+#, c-format
+msgid "pathspec '%s' did not match any files"
+msgstr "=E8=B7=AF=E5=BE=84 '%s' =E6=9C=AA=E5=8C=B9=E9=85=8D=E4=BB=BB=E4=
=BD=95=E6=96=87=E4=BB=B6"
+
+#: builtin/add.c:209
+#, c-format
+msgid "'%s' is beyond a symbolic link"
+msgstr "'%s' =E4=BD=8D=E4=BA=8E=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=A5=E4=
=B8=AD"
+
+#: builtin/add.c:276
+msgid "Could not read the index"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96=E6=9A=82=E5=AD=98=E5=8C=BA=
"
+
+#: builtin/add.c:285
+#, c-format
+msgid "Could not open '%s' for writing."
+msgstr "=E6=97=A0=E6=B3=95=E6=89=93=E5=BC=80 '%s' =E4=BB=A5=E5=86=99=E5=
=85=A5=E3=80=82"
+
+#: builtin/add.c:289
+msgid "Could not write patch"
+msgstr "=E6=97=A0=E6=B3=95=E5=86=99=E8=A1=A5=E4=B8=81"
+
+#: builtin/add.c:294
+#, c-format
+msgid "Could not stat '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E6=9F=A5=E7=9C=8B=E6=96=87=E4=BB=B6=E7=8A=B6=
=E6=80=81 '%s'"
+
+#: builtin/add.c:296
+msgid "Empty patch. Aborted."
+msgstr "=E7=A9=BA=E8=A1=A5=E4=B8=81=E3=80=82=E5=BC=82=E5=B8=B8=E7=BB=88=
=E6=AD=A2=E3=80=82"
+
+#: builtin/add.c:302
+#, c-format
+msgid "Could not apply '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E5=BA=94=E7=94=A8 '%s'"
+
+#: builtin/add.c:311
+msgid "The following paths are ignored by one of your .gitignore files=
:\n"
+msgstr "=E4=B8=8B=E5=88=97=E8=B7=AF=E5=BE=84=E8=A2=AB=E6=82=A8=E7=9A=84=
=E4=B8=80=E4=B8=AA .gitignore =E6=96=87=E4=BB=B6=E6=89=80=E5=BF=BD=E7=95=
=A5=EF=BC=9A\n"
+
+#: builtin/add.c:351
+#, c-format
+msgid "Use -f if you really want to add them.\n"
+msgstr "=E4=BD=BF=E7=94=A8 -f =E5=8F=82=E6=95=B0=E5=A6=82=E6=9E=9C=E4=BD=
=A0=E7=A1=AE=E5=AE=9E=E8=A6=81=E6=B7=BB=E5=8A=A0=E5=AE=83=E4=BB=AC=E3=80=
=82\n"
+
+#: builtin/add.c:352
+msgid "no files added"
+msgstr "=E6=B2=A1=E6=9C=89=E6=96=87=E4=BB=B6=E8=A2=AB=E6=B7=BB=E5=8A=A0=
"
+
+#: builtin/add.c:358
+msgid "adding files failed"
+msgstr "=E6=B7=BB=E5=8A=A0=E6=96=87=E4=BB=B6=E5=A4=B1=E8=B4=A5"
+
+#: builtin/add.c:390
+msgid "-A and -u are mutually incompatible"
+msgstr "-A =E5=92=8C -u =E9=80=89=E9=A1=B9=E4=BA=92=E6=96=A5"
+
+#: builtin/add.c:392
+msgid "Option --ignore-missing can only be used together with --dry-ru=
n"
+msgstr "=E9=80=89=E9=A1=B9 --ignore-missing =E5=8F=AA=E8=83=BD=E5=92=8C=
 --dry-run =E5=85=B1=E7=94=A8"
+
+#: builtin/add.c:412
+#, c-format
+msgid "Nothing specified, nothing added.\n"
+msgstr "=E6=9C=AA=E6=8F=90=E4=BE=9B=E5=8F=82=E6=95=B0=EF=BC=8C=E6=B2=A1=
=E6=9C=89=E6=96=87=E4=BB=B6=E8=A2=AB=E6=B7=BB=E5=8A=A0=E3=80=82\n"
+
+#: builtin/add.c:413
+#, c-format
+msgid "Maybe you wanted to say 'git add .'?\n"
+msgstr "=E4=B9=9F=E8=AE=B8=E6=82=A8=E6=83=B3=E8=A6=81=E6=89=A7=E8=A1=8C=
 'git add .'=EF=BC=9F\n"
+
+#: builtin/add.c:419 builtin/clean.c:95 builtin/commit.c:358 builtin/m=
v.c:82
+#: builtin/rm.c:162
+msgid "index file corrupt"
+msgstr "=E6=9A=82=E5=AD=98=E5=8C=BA=E6=96=87=E4=BB=B6=E6=8D=9F=E5=9D=8F=
"
+
+#: builtin/add.c:475 builtin/mv.c:229 builtin/rm.c:260
+msgid "Unable to write new index file"
+msgstr "=E6=97=A0=E6=B3=95=E5=86=99=E5=85=A5=E6=96=B0=E6=9A=82=E5=AD=98=
=E5=8C=BA=E6=96=87=E4=BB=B6"
+
+#: builtin/archive.c:17
+#, c-format
+msgid "could not create archive file '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E5=BD=92=E6=A1=A3=E6=96=87=
=E4=BB=B6 '%s'"
+
+#: builtin/archive.c:20
+msgid "could not redirect output"
+msgstr "=E6=97=A0=E6=B3=95=E9=87=8D=E5=AE=9A=E5=90=91=E8=BE=93=E5=87=BA=
"
+
+#: builtin/archive.c:37
+msgid "git archive: Remote with no URL"
+msgstr "git archive: =E6=9C=AA=E6=8F=90=E4=BE=9B=E8=BF=9C=E7=A8=8BURL"
+
+#: builtin/archive.c:58
+msgid "git archive: expected ACK/NAK, got EOF"
+msgstr "git archive: =E6=9C=9F=E5=BE=85ACK/NACK=EF=BC=8C=E5=8D=B4=E5=BE=
=97=E5=88=B0EOF"
+
+#: builtin/archive.c:63
+#, c-format
+msgid "git archive: NACK %s"
+msgstr "git archive: NACK %s"
+
+#: builtin/archive.c:65
+#, c-format
+msgid "remote error: %s"
+msgstr "=E8=BF=9C=E7=A8=8B=E9=94=99=E8=AF=AF=EF=BC=9A%s"
+
+#: builtin/archive.c:66
+msgid "git archive: protocol error"
+msgstr "git archive: =E5=8D=8F=E8=AE=AE=E9=94=99=E8=AF=AF"
+
+#: builtin/archive.c:71
+msgid "git archive: expected a flush"
+msgstr "git archive: =E9=A2=84=E6=9C=9F=E4=B8=80=E4=B8=AA=E5=88=B7=E6=96=
=B0"
+
+#: builtin/branch.c:137
+#, c-format
+msgid ""
+"deleting branch '%s' that has been merged to\n"
+"         '%s', but not yet merged to HEAD."
+msgstr ""
+"=E8=A6=81=E5=88=A0=E9=99=A4=E7=9A=84=E5=88=86=E6=94=AF '%s' =E5=B7=B2=
=E7=BB=8F=E5=90=88=E5=B9=B6=E5=88=B0\n"
+"         '%s'=EF=BC=8C=E4=BD=86=E6=9C=AA=E5=90=88=E5=B9=B6=E5=88=B0 H=
EAD=E3=80=82"
+
+#: builtin/branch.c:141
+#, c-format
+msgid ""
+"not deleting branch '%s' that is not yet merged to\n"
+"         '%s', even though it is merged to HEAD."
+msgstr ""
+"=E4=B8=8D=E8=A6=81=E5=88=A0=E9=99=A4=E5=88=86=E6=94=AF '%s' =E5=85=B6=
=E5=B0=9A=E6=9C=AA=E5=90=88=E5=B9=B6=E5=88=B0\n"
+"         '%s'=EF=BC=8C=E8=99=BD=E7=84=B6=E5=AE=83=E5=B7=B2=E7=BB=8F=E5=
=90=88=E5=B9=B6=E5=88=B0 HEAD=E3=80=82"
+
+#  =E6=B1=89=E5=AD=97=E4=B9=8B=E9=97=B4=E6=97=A0=E7=A9=BA=E6=A0=BC=EF=BC=
=8C=E6=95=85=E5=88=A0=E9=99=A4=E5=B0=BE=E9=83=A8=E7=A9=BA=E6=A0=BC
+#. TRANSLATORS: This is "remote " in "remote branch '%s' not found"
+#: builtin/branch.c:163
+msgid "remote "
+msgstr "=E8=BF=9C=E7=A8=8B"
+
+#: builtin/branch.c:171
+msgid "cannot use -a with -d"
+msgstr "=E4=B8=8D=E8=83=BD=E5=B0=86 -a =E5=92=8C -d =E5=85=B1=E7=94=A8=
"
+
+#: builtin/branch.c:177
+msgid "Couldn't look up commit object for HEAD"
+msgstr "=E6=97=A0=E6=B3=95=E6=9F=A5=E8=AF=A2 HEAD =E6=8C=87=E5=90=91=E7=
=9A=84=E6=8F=90=E4=BA=A4=E5=AF=B9=E8=B1=A1"
+
+#: builtin/branch.c:182
+#, c-format
+msgid "Cannot delete the branch '%s' which you are currently on."
+msgstr "=E6=97=A0=E6=B3=95=E5=88=A0=E9=99=A4=E6=82=A8=E5=BD=93=E5=89=8D=
=E6=89=80=E5=9C=A8=E7=9A=84=E5=88=86=E6=94=AF '%s'=E3=80=82"
+
+#: builtin/branch.c:192
+#, c-format
+msgid "%sbranch '%s' not found."
+msgstr "%s=E5=88=86=E6=94=AF '%s' =E6=9C=AA=E5=8F=91=E7=8E=B0=E3=80=82=
"
+
+#: builtin/branch.c:200
+#, c-format
+msgid "Couldn't look up commit object for '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E6=9F=A5=E8=AF=A2 '%s' =E6=8C=87=E5=90=91=E7=
=9A=84=E6=8F=90=E4=BA=A4=E5=AF=B9=E8=B1=A1"
+
+#: builtin/branch.c:206
+#, c-format
+msgid ""
+"The branch '%s' is not fully merged.\n"
+"If you are sure you want to delete it, run 'git branch -D %s'."
+msgstr ""
+"=E5=88=86=E6=94=AF '%s' =E6=B2=A1=E6=9C=89=E5=AE=8C=E5=85=A8=E5=90=88=
=E5=B9=B6=E3=80=82\n"
+"=E5=A6=82=E6=9E=9C=E6=82=A8=E7=A1=AE=E8=AE=A4=E8=A6=81=E5=88=A0=E9=99=
=A4=E5=AE=83=EF=BC=8C=E6=89=A7=E8=A1=8C 'git branch -D %s'=E3=80=82"
+
+#: builtin/branch.c:214
+#, c-format
+msgid "Error deleting %sbranch '%s'"
+msgstr "=E9=94=99=E8=AF=AF=E5=88=A0=E9=99=A4 %s=E5=88=86=E6=94=AF '%s'=
"
+
+#: builtin/branch.c:219
+#, c-format
+msgid "Deleted %sbranch %s (was %s).\n"
+msgstr "=E5=B7=B2=E5=88=A0=E9=99=A4 %s=E5=88=86=E6=94=AF %s=EF=BC=88=E6=
=9B=BE=E4=B8=BA %s=EF=BC=89=E3=80=82\n"
+
+#: builtin/branch.c:224
+msgid "Update of config-file failed"
+msgstr "=E6=97=A0=E6=B3=95=E6=9B=B4=E6=96=B0 config =E6=96=87=E4=BB=B6=
"
+
+#: builtin/branch.c:322
+#, c-format
+msgid "branch '%s' does not point at a commit"
+msgstr "=E5=88=86=E6=94=AF '%s' =E6=9C=AA=E6=8C=87=E5=90=91=E4=B8=80=E4=
=B8=AA=E6=8F=90=E4=BA=A4"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=A5=E5=B0=BE=E7=A9=BA=E6=A0=
=BC
+#: builtin/branch.c:394
+#, c-format
+msgid "behind %d] "
+msgstr "=E8=90=BD=E5=90=8E %d] "
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=A5=E5=B0=BE=E7=A9=BA=E6=A0=
=BC
+#: builtin/branch.c:396
+#, c-format
+msgid "ahead %d] "
+msgstr "=E9=A2=86=E5=85=88 %d] "
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=A5=E5=B0=BE=E7=A9=BA=E6=A0=
=BC
+#: builtin/branch.c:398
+#, c-format
+msgid "ahead %d, behind %d] "
+msgstr "=E9=A2=86=E5=85=88 %d=EF=BC=8C=E8=90=BD=E5=90=8E %d] "
+
+#: builtin/branch.c:501
+msgid "(no branch)"
+msgstr "=EF=BC=88=E9=9D=9E=E5=88=86=E6=94=AF=EF=BC=89"
+
+#: builtin/branch.c:562
+msgid "some refs could not be read"
+msgstr "=E4=B8=80=E4=BA=9B=E5=BC=95=E7=94=A8=E6=97=A0=E6=B3=95=E8=AF=BB=
=E5=8F=96"
+
+#: builtin/branch.c:575
+msgid "cannot rename the current branch while not on any."
+msgstr "=E6=97=A0=E6=B3=95=E9=87=8D=E5=91=BD=E5=90=8D=E4=B8=8D=E5=AD=98=
=E5=9C=A8=E7=9A=84=E5=BD=93=E5=89=8D=E5=88=86=E6=94=AF=E3=80=82"
+
+#: builtin/branch.c:585
+#, c-format
+msgid "Invalid branch name: '%s'"
+msgstr "=E6=97=A0=E6=95=88=E7=9A=84=E5=88=86=E6=94=AF=E5=90=8D=EF=BC=9A=
'%s'"
+
+#: builtin/branch.c:600
+msgid "Branch rename failed"
+msgstr "=E5=88=86=E6=94=AF=E9=87=8D=E5=91=BD=E5=90=8D=E5=A4=B1=E8=B4=A5=
"
+
+#: builtin/branch.c:604
+#, c-format
+msgid "Renamed a misnamed branch '%s' away"
+msgstr "=E9=87=8D=E5=91=BD=E5=90=8D=E6=8E=89=E4=B8=80=E4=B8=AA=E9=94=99=
=E8=AF=AF=E5=91=BD=E5=90=8D=E7=9A=84=E6=97=A7=E5=88=86=E6=94=AF '%s'"
+
+#: builtin/branch.c:608
+#, c-format
+msgid "Branch renamed to %s, but HEAD is not updated!"
+msgstr "=E5=88=86=E6=94=AF=E9=87=8D=E5=91=BD=E5=90=8D=E4=B8=BA %s=EF=BC=
=8C=E4=BD=86 HEAD =E6=B2=A1=E6=9C=89=E6=9B=B4=E6=96=B0=EF=BC=81"
+
+#: builtin/branch.c:615
+msgid "Branch is renamed, but update of config-file failed"
+msgstr "=E5=88=86=E6=94=AF=E8=A2=AB=E9=87=8D=E5=91=BD=E5=90=8D=EF=BC=8C=
=E4=BD=86=E6=9B=B4=E6=96=B0 config =E6=96=87=E4=BB=B6=E5=A4=B1=E8=B4=A5=
"
+
+#: builtin/branch.c:630
+#, c-format
+msgid "malformed object name %s"
+msgstr "=E9=9D=9E=E6=B3=95=E7=9A=84=E5=AF=B9=E8=B1=A1=E5=90=8D %s"
+
+#: builtin/branch.c:654
+#, c-format
+msgid "could not write branch description template: %s\n"
+msgstr "=E4=B8=8D=E8=83=BD=E5=86=99=E5=88=86=E6=94=AF=E6=8F=8F=E8=BF=B0=
=E6=A8=A1=E7=89=88=EF=BC=9A%s\n"
+
+#: builtin/branch.c:742
+msgid "Failed to resolve HEAD as a valid ref."
+msgstr "=E6=97=A0=E6=B3=95=E5=B0=86 HEAD =E8=A7=A3=E6=9E=90=E4=B8=BA=E6=
=9C=89=E6=95=88=E5=BC=95=E7=94=A8=E3=80=82"
+
+#: builtin/branch.c:747
+msgid "HEAD not found below refs/heads!"
+msgstr "=E6=9C=AA=E5=9C=A8 /refs/heads =E4=B8=8B=E5=8F=91=E7=8E=B0 HEA=
D=EF=BC=81"
+
+#: builtin/branch.c:790
+msgid "-a and -r options to 'git branch' do not make sense with a bran=
ch name"
+msgstr "'git branch' =E7=9A=84 -a =E5=92=8C -r =E9=80=89=E9=A1=B9=E5=B8=
=A6=E4=B8=80=E4=B8=AA=E5=88=86=E6=94=AF=E5=90=8D=E5=8F=82=E6=95=B0=E6=B2=
=A1=E6=9C=89=E6=84=8F=E4=B9=89"
+
+#: builtin/bundle.c:47
+#, c-format
+msgid "%s is okay\n"
+msgstr "%s =E5=8F=AF=E4=BB=A5\n"
+
+#: builtin/bundle.c:56
+msgid "Need a repository to create a bundle."
+msgstr "=E9=9C=80=E8=A6=81=E4=B8=80=E4=B8=AA=E7=89=88=E6=9C=AC=E5=BA=93=
=E6=9D=A5=E5=88=9B=E5=BB=BA=E5=8C=85"
+
+#: builtin/bundle.c:60
+msgid "Need a repository to unbundle."
+msgstr "=E9=9C=80=E8=A6=81=E4=B8=80=E4=B8=AA=E7=89=88=E6=9C=AC=E5=BA=93=
=E6=9D=A5=E8=A7=A3=E5=8C=85"
+
+#: builtin/checkout.c:113 builtin/checkout.c:146
+#, c-format
+msgid "path '%s' does not have our version"
+msgstr "=E8=B7=AF=E5=BE=84 '%s' =E6=B2=A1=E6=9C=89=E6=88=91=E4=BB=AC=E7=
=9A=84=E7=89=88=E6=9C=AC"
+
+#: builtin/checkout.c:115 builtin/checkout.c:148
+#, c-format
+msgid "path '%s' does not have their version"
+msgstr "=E8=B7=AF=E5=BE=84 '%s' =E6=B2=A1=E6=9C=89=E4=BB=96=E4=BB=AC=E7=
=9A=84=E7=89=88=E6=9C=AC"
+
+#: builtin/checkout.c:131
+#, c-format
+msgid "path '%s' does not have all necessary versions"
+msgstr "=E8=B7=AF=E5=BE=84 '%s' =E6=B2=A1=E6=9C=89=E5=85=A8=E9=83=A8=E5=
=BF=85=E9=A1=BB=E7=9A=84=E7=89=88=E6=9C=AC"
+
+#: builtin/checkout.c:175
+#, c-format
+msgid "path '%s' does not have necessary versions"
+msgstr "=E8=B7=AF=E5=BE=84 '%s' =E6=B2=A1=E6=9C=89=E5=BF=85=E9=A1=BB=E7=
=9A=84=E7=89=88=E6=9C=AC"
+
+#: builtin/checkout.c:192
+#, c-format
+msgid "path '%s': cannot merge"
+msgstr "path '%s': =E6=97=A0=E6=B3=95=E5=90=88=E5=B9=B6"
+
+#: builtin/checkout.c:209
+#, c-format
+msgid "Unable to add merge result for '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E4=B8=BA '%s' =E6=B7=BB=E5=8A=A0=E5=90=88=E5=
=B9=B6=E7=BB=93=E6=9E=9C"
+
+#: builtin/checkout.c:212 builtin/reset.c:158
+#, c-format
+msgid "make_cache_entry failed for path '%s'"
+msgstr "=E5=AF=B9=E8=B7=AF=E5=BE=84 '%s' =E7=9A=84 make_cache_entry =E6=
=93=8D=E4=BD=9C=E5=A4=B1=E8=B4=A5"
+
+#: builtin/checkout.c:234 builtin/checkout.c:392
+msgid "corrupt index file"
+msgstr "=E5=86=B2=E7=AA=81=E7=9A=84=E6=9A=82=E5=AD=98=E5=8C=BA=E6=96=87=
=E4=BB=B6"
+
+#: builtin/checkout.c:264 builtin/checkout.c:271
+#, c-format
+msgid "path '%s' is unmerged"
+msgstr "=E8=B7=AF=E5=BE=84 '%s' =E6=9C=AA=E5=90=88=E5=B9=B6"
+
+#: builtin/checkout.c:302 builtin/checkout.c:498 builtin/clone.c:769
+#: builtin/merge.c:809
+msgid "unable to write new index file"
+msgstr "=E6=97=A0=E6=B3=95=E5=86=99=E6=96=B0=E7=9A=84=E6=9A=82=E5=AD=98=
=E5=8C=BA=E6=96=87=E4=BB=B6"
+
+#: builtin/checkout.c:319 builtin/diff.c:298 builtin/merge.c:406
+msgid "diff_setup_done failed"
+msgstr "diff_setup_done =E5=A4=B1=E8=B4=A5"
+
+#: builtin/checkout.c:414
+msgid "you need to resolve your current index first"
+msgstr "=E6=82=A8=E9=9C=80=E8=A6=81=E5=85=88=E8=A7=A3=E5=86=B3=E5=BD=93=
=E5=89=8D=E6=9A=82=E5=AD=98=E5=8C=BA=E7=9A=84=E5=86=B2=E7=AA=81"
+
+#: builtin/checkout.c:547
+#, c-format
+msgid "Can not do reflog for '%s'\n"
+msgstr "=E4=B8=8D=E8=83=BD=E5=AF=B9 '%s' =E4=BF=9D=E5=AD=98=E5=BC=95=E7=
=94=A8=E6=97=A5=E5=BF=97\n"
+
+#: builtin/checkout.c:579
+msgid "HEAD is now at"
+msgstr "HEAD =E7=9B=AE=E5=89=8D=E4=BD=8D=E4=BA=8E"
+
+#: builtin/checkout.c:586
+#, c-format
+msgid "Reset branch '%s'\n"
+msgstr "=E9=87=8D=E7=BD=AE=E5=88=86=E6=94=AF '%s'\n"
+
+#: builtin/checkout.c:589
+#, c-format
+msgid "Already on '%s'\n"
+msgstr "=E5=B7=B2=E7=BB=8F=E4=BD=8D=E4=BA=8E '%s'\n"
+
+#: builtin/checkout.c:593
+#, c-format
+msgid "Switched to and reset branch '%s'\n"
+msgstr "=E5=88=87=E6=8D=A2=E5=B9=B6=E9=87=8D=E7=BD=AE=E5=88=86=E6=94=AF=
 '%s'\n"
+
+#: builtin/checkout.c:595
+#, c-format
+msgid "Switched to a new branch '%s'\n"
+msgstr "=E5=88=87=E6=8D=A2=E5=88=B0=E4=B8=80=E4=B8=AA=E6=96=B0=E5=88=86=
=E6=94=AF '%s'\n"
+
+#: builtin/checkout.c:597
+#, c-format
+msgid "Switched to branch '%s'\n"
+msgstr "=E5=88=87=E6=8D=A2=E5=88=B0=E5=88=86=E6=94=AF '%s'\n"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: builtin/checkout.c:653
+#, c-format
+msgid " ... and %d more.\n"
+msgstr " ... =E5=8F=8A %d =E6=9B=B4=E5=A4=9A=E3=80=82\n"
+
+#. The singular version
+#: builtin/checkout.c:659
+#, c-format
+msgid ""
+"Warning: you are leaving %d commit behind, not connected to\n"
+"any of your branches:\n"
+"\n"
+"%s\n"
+msgid_plural ""
+"Warning: you are leaving %d commits behind, not connected to\n"
+"any of your branches:\n"
+"\n"
+"%s\n"
+msgstr[0] ""
+"=E8=AD=A6=E5=91=8A=EF=BC=9A=E6=82=A8=E6=AD=A3=E4=B8=A2=E4=B8=8B %d =E4=
=B8=AA=E6=8F=90=E4=BA=A4=EF=BC=8C=E6=9C=AA=E5=92=8C=E4=BB=BB=E4=BD=95=E5=
=88=86=E6=94=AF=E5=85=B3=E8=81=94=EF=BC=9A\n"
+"\n"
+"%s\n"
+
+#: builtin/checkout.c:677
+#, c-format
+msgid ""
+"If you want to keep them by creating a new branch, this may be a good=
 time\n"
+"to do so with:\n"
+"\n"
+" git branch new_branch_name %s\n"
+"\n"
+msgstr ""
+"=E5=A6=82=E6=9E=9C=E6=82=A8=E6=83=B3=E8=A6=81=E9=80=9A=E8=BF=87=E5=88=
=9B=E5=BB=BA=E6=96=B0=E5=88=86=E6=94=AF=E4=BF=9D=E5=AD=98=E4=BB=96=E4=BB=
=AC=EF=BC=8C=E8=BF=99=E5=8F=AF=E8=83=BD=E6=98=AF=E4=B8=80=E4=B8=AA=E5=A5=
=BD=E6=97=B6=E5=80=99=E3=80=82\n"
+"=E5=A6=82=E4=B8=8B=E6=93=8D=E4=BD=9C=EF=BC=9A\n"
+"\n"
+" git branch new_branch_name %s\n"
+"\n"
+
+#: builtin/checkout.c:706
+msgid "internal error in revision walk"
+msgstr "=E5=9C=A8=E7=89=88=E6=9C=AC=E9=81=8D=E5=8E=86=E6=97=B6=E9=81=87=
=E5=88=B0=E5=86=85=E9=83=A8=E9=94=99=E8=AF=AF"
+
+#: builtin/checkout.c:710
+msgid "Previous HEAD position was"
+msgstr "=E4=B9=8B=E5=89=8D=E7=9A=84 HEAD =E4=BD=8D=E7=BD=AE=E6=98=AF"
+
+#: builtin/checkout.c:736
+msgid "You are on a branch yet to be born"
+msgstr "=E6=82=A8=E4=BD=8D=E4=BA=8E=E4=B8=80=E4=B8=AA=E6=9C=AA=E5=88=9D=
=E5=A7=8B=E5=8C=96=E7=9A=84=E5=88=86=E6=94=AF"
+
+#. case (1)
+#: builtin/checkout.c:867
+#, c-format
+msgid "invalid reference: %s"
+msgstr "=E6=97=A0=E6=95=88=E5=BC=95=E7=94=A8=EF=BC=9A%s"
+
+#. case (1): want a tree
+#: builtin/checkout.c:906
+#, c-format
+msgid "reference is not a tree: %s"
+msgstr "=E5=BC=95=E7=94=A8=E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E6=A0=91=
=EF=BC=9A%s"
+
+#: builtin/checkout.c:975
+msgid "-B cannot be used with -b"
+msgstr "-B =E4=B8=8D=E8=83=BD=E5=92=8C -b =E5=85=B1=E7=94=A8"
+
+#: builtin/checkout.c:984
+msgid "--patch is incompatible with all other options"
+msgstr "--patch =E9=80=89=E9=A1=B9=E5=92=8C=E5=85=B6=E4=BB=96=E9=80=89=
=E9=A1=B9=E4=B8=8D=E5=85=BC=E5=AE=B9"
+
+#: builtin/checkout.c:987
+msgid "--detach cannot be used with -b/-B/--orphan"
+msgstr "--detach =E4=B8=8D=E8=83=BD=E5=92=8C -b/-B/--orphan =E5=85=B1=E7=
=94=A8"
+
+#: builtin/checkout.c:989
+msgid "--detach cannot be used with -t"
+msgstr "--detach =E4=B8=8D=E8=83=BD=E5=92=8C -t =E5=85=B1=E7=94=A8"
+
+#: builtin/checkout.c:995
+msgid "--track needs a branch name"
+msgstr "--track =E9=9C=80=E8=A6=81=E4=B8=80=E4=B8=AA=E5=88=86=E6=94=AF=
=E5=90=8D"
+
+#: builtin/checkout.c:1002
+msgid "Missing branch name; try -b"
+msgstr "=E7=BC=BA=E5=B0=91=E5=88=86=E6=94=AF=E5=90=8D=EF=BC=9B=E5=B0=9D=
=E8=AF=95 -b"
+
+#: builtin/checkout.c:1008
+msgid "--orphan and -b|-B are mutually exclusive"
+msgstr "--orphan =E5=92=8C -b|-B =E4=BA=92=E6=96=A5"
+
+#: builtin/checkout.c:1010
+msgid "--orphan cannot be used with -t"
+msgstr "--orphan =E4=B8=8D=E8=83=BD=E5=92=8C -t =E5=85=B1=E7=94=A8"
+
+#: builtin/checkout.c:1020
+msgid "git checkout: -f and -m are incompatible"
+msgstr "git checkout: -f =E5=92=8C -m =E4=B8=8D=E5=85=BC=E5=AE=B9"
+
+#: builtin/checkout.c:1054
+msgid "invalid path specification"
+msgstr "=E6=97=A0=E6=95=88=E7=9A=84=E8=B7=AF=E5=BE=84"
+
+#: builtin/checkout.c:1062
+#, c-format
+msgid ""
+"git checkout: updating paths is incompatible with switching branches.=
\n"
+"Did you intend to checkout '%s' which can not be resolved as commit?"
+msgstr ""
+"git checkout: =E6=9B=B4=E6=96=B0=E8=B7=AF=E5=BE=84=E5=92=8C=E5=88=87=E6=
=8D=A2=E5=88=86=E6=94=AF=E4=B8=8D=E5=85=BC=E5=AE=B9=E3=80=82\n"
+"=E6=82=A8=E6=98=AF=E6=83=B3=E8=A6=81=E6=A3=80=E5=87=BA '%s' =E4=BD=86=
=E6=9C=AA=E8=83=BD=E5=B0=86=E5=85=B6=E8=A7=A3=E6=9E=90=E4=B8=BA=E6=8F=90=
=E4=BA=A4=E4=B9=88=EF=BC=9F"
+
+#: builtin/checkout.c:1064
+msgid "git checkout: updating paths is incompatible with switching bra=
nches."
+msgstr "git checkout: =E6=9B=B4=E6=96=B0=E8=B7=AF=E5=BE=84=E5=92=8C=E5=
=88=87=E6=8D=A2=E5=88=86=E6=94=AF=E4=B8=8D=E5=85=BC=E5=AE=B9=E3=80=82"
+
+#: builtin/checkout.c:1069
+msgid "git checkout: --detach does not take a path argument"
+msgstr "git checkout: --detach =E4=B8=8D=E8=B7=9F=E8=B7=AF=E5=BE=84=E5=
=8F=82=E6=95=B0"
+
+#: builtin/checkout.c:1072
+msgid ""
+"git checkout: --ours/--theirs, --force and --merge are incompatible w=
hen\n"
+"checking out of the index."
+msgstr ""
+"git checkout: --ours/--theirs, --force =E5=92=8C --merge =E4=B8=8D=E5=
=85=BC=E5=AE=B9=E5=BD=93\n"
+"=E6=A3=80=E5=87=BA=E6=9A=82=E5=AD=98=E5=8C=BA=E6=97=B6=E3=80=82"
+
+#: builtin/checkout.c:1091
+msgid "Cannot switch branch to a non-commit."
+msgstr "=E6=97=A0=E6=B3=95=E5=88=87=E6=8D=A2=E5=88=86=E6=94=AF=E5=88=B0=
=E4=B8=80=E4=B8=AA=E9=9D=9E=E6=8F=90=E4=BA=A4=E3=80=82"
+
+#: builtin/checkout.c:1094
+msgid "--ours/--theirs is incompatible with switching branches."
+msgstr "--ours/--theirs =E5=92=8C=E5=88=87=E6=8D=A2=E5=88=86=E6=94=AF=E4=
=B8=8D=E5=85=BC=E5=AE=B9=E3=80=82"
+
+#: builtin/clean.c:78
+msgid "-x and -X cannot be used together"
+msgstr "-x =E5=92=8C -X =E4=B8=8D=E8=83=BD=E5=85=B1=E7=94=A8"
+
+#: builtin/clean.c:82
+msgid ""
+"clean.requireForce set to true and neither -n nor -f given; refusing =
to clean"
+msgstr ""
+"clean.requireForce =E8=AE=BE=E7=BD=AE=E4=B8=BA true=EF=BC=8C=E8=8B=A5=
=E6=9C=AA=E6=8F=90=E4=BE=9B -n =E6=88=96 -f =E9=80=89=E9=A1=B9=EF=BC=8C=
=E6=8B=92=E7=BB=9D=E6=89=A7=E8=A1=8C=E6=B8=85=E7=90=86=E5=8A=A8=E4=BD=9C=
"
+
+#: builtin/clean.c:85
+msgid ""
+"clean.requireForce defaults to true and neither -n nor -f given; refu=
sing to "
+"clean"
+msgstr ""
+"clean.requireForce =E9=BB=98=E8=AE=A4=E4=B8=BA true=EF=BC=8C=E8=8B=A5=
=E6=9C=AA=E6=8F=90=E4=BE=9B -n =E6=88=96 -f =E9=80=89=E9=A1=B9=EF=BC=8C=
=E6=8B=92=E7=BB=9D=E6=89=A7=E8=A1=8C=E6=B8=85=E7=90=86=E5=8A=A8=E4=BD=9C=
"
+
+#: builtin/clean.c:155 builtin/clean.c:176
+#, c-format
+msgid "Would remove %s\n"
+msgstr "=E5=B0=86=E5=88=A0=E9=99=A4 %s\n"
+
+#: builtin/clean.c:159 builtin/clean.c:179
+#, c-format
+msgid "Removing %s\n"
+msgstr "=E6=AD=A3=E5=88=A0=E9=99=A4 %s\n"
+
+#: builtin/clean.c:162 builtin/clean.c:182
+#, c-format
+msgid "failed to remove %s"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=A0=E9=99=A4 %s"
+
+#: builtin/clean.c:166
+#, c-format
+msgid "Would not remove %s\n"
+msgstr "=E4=B8=8D=E4=BC=9A=E5=88=A0=E9=99=A4 %s\n"
+
+#: builtin/clean.c:168
+#, c-format
+msgid "Not removing %s\n"
+msgstr "=E6=9C=AA=E5=88=A0=E9=99=A4 %s\n"
+
+#: builtin/clone.c:244
+#, c-format
+msgid "reference repository '%s' is not a local directory."
+msgstr "=E5=BC=95=E7=94=A8=E7=89=88=E6=9C=AC=E5=BA=93 '%s' =E4=B8=8D=E6=
=98=AF=E4=B8=80=E4=B8=AA=E6=9C=AC=E5=9C=B0=E7=9B=AE=E5=BD=95=E3=80=82"
+
+#: builtin/clone.c:311
+#, c-format
+msgid "failed to open '%s'"
+msgstr "=E6=89=93=E5=BC=80 '%s' =E5=A4=B1=E8=B4=A5"
+
+#: builtin/clone.c:315
+#, c-format
+msgid "failed to create directory '%s'"
+msgstr "=E5=88=9B=E5=BB=BA=E7=9B=AE=E5=BD=95 '%s' =E5=A4=B1=E8=B4=A5"
+
+#: builtin/clone.c:317 builtin/diff.c:75
+#, c-format
+msgid "failed to stat '%s'"
+msgstr "=E6=9E=9A=E4=B8=BE '%s' =E7=8A=B6=E6=80=81=E5=A4=B1=E8=B4=A5"
+
+#: builtin/clone.c:319
+#, c-format
+msgid "%s exists and is not a directory"
+msgstr "%s =E5=AD=98=E5=9C=A8=E4=B8=94=E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=
=AA=E7=9B=AE=E5=BD=95"
+
+#: builtin/clone.c:333
+#, c-format
+msgid "failed to stat %s\n"
+msgstr "=E6=9E=9A=E4=B8=BE %s =E7=8A=B6=E6=80=81=E5=A4=B1=E8=B4=A5\n"
+
+#: builtin/clone.c:350
+#, c-format
+msgid "failed to unlink '%s'"
+msgstr "=E5=88=A0=E9=99=A4 '%s' =E5=A4=B1=E8=B4=A5"
+
+#: builtin/clone.c:355
+#, c-format
+msgid "failed to create link '%s'"
+msgstr "=E5=88=9B=E5=BB=BA=E9=93=BE=E6=8E=A5 '%s' =E5=A4=B1=E8=B4=A5"
+
+#: builtin/clone.c:359
+#, c-format
+msgid "failed to copy file to '%s'"
+msgstr "=E6=8B=B7=E8=B4=9D=E6=96=87=E4=BB=B6=E8=87=B3 '%s' =E5=A4=B1=E8=
=B4=A5"
+
+#: builtin/clone.c:391
+#, c-format
+msgid "done.\n"
+msgstr "=E5=AE=8C=E6=88=90=E3=80=82\n"
+
+#: builtin/clone.c:494
+msgid "Too many arguments."
+msgstr "=E5=A4=AA=E5=A4=9A=E5=8F=82=E6=95=B0=E3=80=82"
+
+#: builtin/clone.c:498
+msgid "You must specify a repository to clone."
+msgstr "=E4=BD=A0=E5=BF=85=E9=A1=BB=E6=8C=87=E5=AE=9A=E4=B8=80=E4=B8=AA=
=E7=89=88=E6=9C=AC=E5=BA=93=E6=9D=A5=E5=85=8B=E9=9A=86"
+
+#: builtin/clone.c:506
+#, c-format
+msgid "--bare and --origin %s options are incompatible."
+msgstr "--bare =E5=92=8C --origin %s =E9=80=89=E9=A1=B9=E4=B8=8D=E5=85=
=BC=E5=AE=B9=E3=80=82"
+
+#: builtin/clone.c:520
+#, c-format
+msgid "repository '%s' does not exist"
+msgstr "=E7=89=88=E6=9C=AC=E5=BA=93 '%s' =E4=B8=8D=E5=AD=98=E5=9C=A8"
+
+#: builtin/clone.c:525
+msgid "--depth is ignored in local clones; use file:// instead."
+msgstr "--depth =E5=9C=A8=E6=9C=AC=E5=9C=B0=E5=85=8B=E9=9A=86=E8=A2=AB=
=E5=BF=BD=E7=95=A5=EF=BC=8C=E6=94=B9=E4=B8=BA file:// =E5=8D=8F=E8=AE=AE=
=E8=AF=95=E8=AF=95=E3=80=82"
+
+#: builtin/clone.c:535
+#, c-format
+msgid "destination path '%s' already exists and is not an empty direct=
ory."
+msgstr "=E7=9B=AE=E6=A0=87=E8=B7=AF=E5=BE=84 '%s' =E5=B7=B2=E7=BB=8F=E5=
=AD=98=E5=9C=A8=E4=B8=94=E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E7=A9=BA=E7=
=9B=AE=E5=BD=95=E3=80=82"
+
+#: builtin/clone.c:545
+#, c-format
+msgid "working tree '%s' already exists."
+msgstr "=E5=B7=A5=E4=BD=9C=E5=8C=BA '%s' =E5=B7=B2=E7=BB=8F=E5=AD=98=E5=
=9C=A8=E3=80=82"
+
+#: builtin/clone.c:558 builtin/clone.c:572
+#, c-format
+msgid "could not create leading directories of '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E4=B8=BA '%s' =E5=88=9B=E5=BB=BA=E7=9B=AE=E5=
=BD=95"
+
+#: builtin/clone.c:561
+#, c-format
+msgid "could not create work tree dir '%s'."
+msgstr "=E6=97=A0=E6=B3=95=E4=B8=BA '%s' =E5=88=9B=E5=BB=BA=E5=B7=A5=E4=
=BD=9C=E5=8C=BA=E7=9B=AE=E5=BD=95=E3=80=82"
+
+#: builtin/clone.c:580
+#, c-format
+msgid "Cloning into bare repository '%s'...\n"
+msgstr "=E5=85=8B=E9=9A=86=E5=88=B0=E8=A3=B8=E7=89=88=E6=9C=AC=E5=BA=93=
 '%s'...\n"
+
+#: builtin/clone.c:582
+#, c-format
+msgid "Cloning into '%s'...\n"
+msgstr "=E6=AD=A3=E5=85=8B=E9=9A=86=E5=88=B0 '%s'...\n"
+
+#: builtin/clone.c:641
+#, c-format
+msgid "Don't know how to clone %s"
+msgstr "=E4=B8=8D=E7=9F=A5=E9=81=93=E5=A6=82=E4=BD=95=E5=85=8B=E9=9A=86=
 %s"
+
+#: builtin/clone.c:680
+#, c-format
+msgid "Remote branch %s not found in upstream %s, using HEAD instead"
+msgstr "=E8=BF=9C=E7=A8=8B=E5=88=86=E6=94=AF %s =E5=9C=A8=E4=B8=8A=E6=B8=
=B8 %s =E6=9C=AA=E5=8F=91=E7=8E=B0=EF=BC=8C=E6=94=B9=E4=B8=BA=E4=BD=BF=E7=
=94=A8 HEAD"
+
+#: builtin/clone.c:690
+msgid "You appear to have cloned an empty repository."
+msgstr "=E6=82=A8=E4=BC=BC=E4=B9=8E=E5=85=8B=E9=9A=86=E4=BA=86=E4=B8=80=
=E4=B8=AA=E7=A9=BA=E7=89=88=E6=9C=AC=E5=BA=93=E3=80=82"
+
+#: builtin/clone.c:732
+msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
+msgstr "=E8=BF=9C=E7=A8=8B HEAD =E6=8C=87=E5=90=91=E4=B8=80=E4=B8=AA=E4=
=B8=8D=E5=AD=98=E5=9C=A8=E7=9A=84=E5=BC=95=E7=94=A8=EF=BC=8C=E6=97=A0=E6=
=B3=95=E6=A3=80=E5=87=BA=E3=80=82\n"
+
+#: builtin/commit.c:42
+msgid ""
+"Your name and email address were configured automatically based\n"
+"on your username and hostname. Please check that they are accurate.\n=
"
+"You can suppress this message by setting them explicitly:\n"
+"\n"
+"    git config --global user.name \"Your Name\"\n"
+"    git config --global user.email you@example.com\n"
+"\n"
+"After doing this, you may fix the identity used for this commit with:=
\n"
+"\n"
+"    git commit --amend --reset-author\n"
+msgstr ""
+"=E6=82=A8=E7=9A=84=E5=A7=93=E5=90=8D=E5=92=8C=E9=82=AE=E4=BB=B6=E5=9C=
=B0=E5=9D=80=E4=BC=9A=E5=9F=BA=E4=BA=8E=E6=82=A8=E7=9A=84=E7=94=A8=E6=88=
=B7=E5=90=8D=E5=92=8C=E4=B8=BB=E6=9C=BA=E5=9C=B0=E5=9D=80=E8=87=AA=E5=8A=
=A8=E9=85=8D=E7=BD=AE=E3=80=82=E8=AF=B7=E6=A3=80=E6=9F=A5=E5=AE=83=E4=BB=
=AC\n"
+"=E6=AD=A3=E7=A1=AE=E4=B8=8E=E5=90=A6=E3=80=82=E6=82=A8=E5=8F=AF=E9=80=
=9A=E8=BF=87=E4=B8=8B=E9=9D=A2=E5=91=BD=E4=BB=A4=E5=AF=B9=E5=85=B6=E6=98=
=BE=E5=BC=8F=E5=A3=B0=E6=98=8E=E4=BB=A5=E9=81=BF=E5=85=8D=E9=87=8D=E5=A4=
=8D=E5=87=BA=E7=8E=B0=E7=B1=BB=E4=BC=BC=E6=8F=90=E7=A4=BA=EF=BC=9A\n"
+"\n"
+"    git config --global user.name \"Your Name\"\n"
+"    git config --global user.email you@example.com\n"
+"\n"
+"=E8=AE=BE=E7=BD=AE=E5=AE=8C=E6=AF=95=E5=90=8E=EF=BC=8C=E6=82=A8=E5=8F=
=AF=E7=94=A8=E4=B8=8B=E9=9D=A2=E5=91=BD=E4=BB=A4=E6=9D=A5=E6=9B=B4=E6=94=
=B9=E6=AD=A4=E6=AC=A1=E6=8F=90=E4=BA=A4=E6=89=80=E4=BD=BF=E7=94=A8=E7=9A=
=84=E7=94=A8=E6=88=B7ID=EF=BC=9A\n"
+"\n"
+"    git commit --amend --reset-author\n"
+
+#: builtin/commit.c:54
+msgid ""
+"You asked to amend the most recent commit, but doing so would make\n"
+"it empty. You can repeat your command with --allow-empty, or you can\=
n"
+"remove the commit entirely with \"git reset HEAD^\".\n"
+msgstr ""
+"=E6=82=A8=E8=A6=81=E6=B1=82=E4=BF=AE=E8=A1=A5=E6=9C=80=E8=BF=91=E7=9A=
=84=E6=8F=90=E4=BA=A4=EF=BC=8C=E4=BD=86=E8=BF=99=E4=B9=88=E5=81=9A=E4=BC=
=9A=E9=80=A0=E6=88=90=E7=A9=BA=E6=8F=90=E4=BA=A4=E3=80=82=E6=82=A8=E5=8F=
=AF=E9=87=8D=E5=A4=8D=E6=82=A8=E7=9A=84=E5=91=BD=E4=BB=A4=E5=B9=B6=E5=B8=
=A6=E4=B8=8A\n"
+"--allow-empty =E9=80=89=E9=A1=B9=EF=BC=8C=E6=88=96=E8=80=85=E6=82=A8=E5=
=8F=AF=E4=BB=A5=E6=95=B4=E4=B8=AA=E5=88=A0=E9=99=A4=E8=AF=A5=E6=8F=90=E4=
=BA=A4=E7=94=A8 \"git reset HEAD^\"=E3=80=82\n"
+
+#: builtin/commit.c:59
+msgid ""
+"The previous cherry-pick is now empty, possibly due to conflict resol=
ution.\n"
+"If you wish to commit it anyway, use:\n"
+"\n"
+"    git commit --allow-empty\n"
+"\n"
+"Otherwise, please use 'git reset'\n"
+msgstr ""
+"=E4=B9=8B=E5=89=8D=E7=9A=84=E6=8B=A3=E9=80=89=E6=93=8D=E4=BD=9C=E7=8E=
=B0=E5=9C=A8=E4=B8=BA=E7=A9=BA=EF=BC=8C=E5=8F=AF=E8=83=BD=E6=98=AF=E7=94=
=B1=E5=86=B2=E7=AA=81=E8=A7=A3=E5=86=B3=E5=AF=BC=E8=87=B4=E7=9A=84=E3=80=
=82=E5=A6=82=E6=9E=9C=E6=82=A8=E6=83=B3=E7=BB=A7=E7=BB=AD=E6=8F=90=E4=BA=
=A4=EF=BC=8C=E7=94=A8=EF=BC=9A\n"
+"\n"
+"    git commit --allow-empty\n"
+"\n"
+"=E5=90=A6=E5=88=99=EF=BC=8C=E8=AF=B7=E7=94=A8 'git reset'\n"
+
+#: builtin/commit.c:205 builtin/reset.c:33
+msgid "merge"
+msgstr "=E5=90=88=E5=B9=B6"
+
+#: builtin/commit.c:208
+msgid "cherry-pick"
+msgstr "=E6=8B=A3=E9=80=89"
+
+#: builtin/commit.c:325
+msgid "failed to unpack HEAD tree object"
+msgstr "=E8=A7=A3=E5=8C=85 HEAD =E6=A0=91=E5=AF=B9=E8=B1=A1=E5=A4=B1=E8=
=B4=A5"
+
+#: builtin/commit.c:367
+msgid "unable to create temporary index"
+msgstr "=E4=B8=8D=E8=83=BD=E5=88=9B=E5=BB=BA=E4=B8=B4=E6=97=B6=E6=9A=82=
=E5=AD=98=E5=8C=BA"
+
+#: builtin/commit.c:373
+msgid "interactive add failed"
+msgstr "=E4=BA=A4=E4=BA=92=E5=BC=8F=E6=B7=BB=E5=8A=A0=E5=A4=B1=E8=B4=A5=
"
+
+#: builtin/commit.c:406 builtin/commit.c:427 builtin/commit.c:473
+msgid "unable to write new_index file"
+msgstr "=E6=97=A0=E6=B3=95=E5=86=99=E5=85=A5=E6=96=B0=E6=9A=82=E5=AD=98=
=E5=8C=BA=E6=96=87=E4=BB=B6"
+
+#  %s=E8=8B=A5=E7=BF=BB=E4=B8=BA=E4=B8=AD=E6=96=87=EF=BC=8C=E5=89=8D=E5=
=90=8E=E4=B8=8D=E9=9C=80=E8=A6=81=E7=A9=BA=E6=A0=BC
+#: builtin/commit.c:457
+#, c-format
+msgid "cannot do a partial commit during a %s."
+msgstr "=E5=9C=A8%s=E8=BF=87=E7=A8=8B=E4=B8=AD=E4=B8=8D=E8=83=BD=E5=81=
=9A=E9=83=A8=E5=88=86=E6=8F=90=E4=BA=A4=E3=80=82"
+
+#: builtin/commit.c:466
+msgid "cannot read the index"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96=E6=9A=82=E5=AD=98=E5=8C=BA=
"
+
+#: builtin/commit.c:486
+msgid "unable to write temporary index file"
+msgstr "=E6=97=A0=E6=B3=95=E5=86=99=E4=B8=B4=E6=97=B6=E6=9A=82=E5=AD=98=
=E5=8C=BA=E6=96=87=E4=BB=B6"
+
+#: builtin/commit.c:549 builtin/commit.c:555
+#, c-format
+msgid "invalid commit: %s"
+msgstr "=E6=97=A0=E6=95=88=E7=9A=84=E6=8F=90=E4=BA=A4=EF=BC=9A%s"
+
+#: builtin/commit.c:573
+msgid "malformed --author parameter"
+msgstr "=E9=9D=9E=E6=B3=95=E7=9A=84 --author =E5=8F=82=E6=95=B0"
+
+#: builtin/commit.c:629
+#, c-format
+msgid "Malformed ident string: '%s'"
+msgstr "=E9=9D=9E=E6=B3=95=E7=9A=84=E8=AF=86=E5=88=AB=E5=AD=97=E4=B8=B2=
=EF=BC=9A'%s'"
+
+#: builtin/commit.c:664 builtin/commit.c:697 builtin/commit.c:994
+#, c-format
+msgid "could not lookup commit %s"
+msgstr "=E4=B8=8D=E8=83=BD=E6=9F=A5=E8=AF=A2=E6=8F=90=E4=BA=A4 %s"
+
+#: builtin/commit.c:676 builtin/shortlog.c:296
+#, c-format
+msgid "(reading log message from standard input)\n"
+msgstr "=EF=BC=88=E6=AD=A3=E4=BB=8E=E6=A0=87=E5=87=86=E8=BE=93=E5=85=A5=
=E4=B8=AD=E8=AF=BB=E5=8F=96=E8=AF=B4=E6=98=8E=E4=BF=A1=E6=81=AF=EF=BC=89=
\n"
+
+#: builtin/commit.c:678
+msgid "could not read log from standard input"
+msgstr "=E6=97=A0=E6=B3=95=E4=BB=8E=E6=A0=87=E5=87=86=E8=BE=93=E5=85=A5=
=E4=B8=AD=E8=AF=BB=E5=8F=96=E8=AF=B4=E6=98=8E=E4=BF=A1=E6=81=AF"
+
+#: builtin/commit.c:682
+#, c-format
+msgid "could not read log file '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96=E8=AF=B4=E6=98=8E=E6=96=87=
=E4=BB=B6 '%s'"
+
+#: builtin/commit.c:688
+msgid "commit has empty message"
+msgstr "=E6=8F=90=E4=BA=A4=E8=AF=B4=E6=98=8E=E4=B8=BA=E7=A9=BA"
+
+#: builtin/commit.c:704
+msgid "could not read MERGE_MSG"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96 MERGE_MSG"
+
+#: builtin/commit.c:708
+msgid "could not read SQUASH_MSG"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96 SQUASH_MSG"
+
+#: builtin/commit.c:712
+#, c-format
+msgid "could not read '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96 '%s'"
+
+#: builtin/commit.c:740
+#, c-format
+msgid "could not open '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E6=89=93=E5=BC=80 '%s'"
+
+#: builtin/commit.c:764
+msgid "could not write commit template"
+msgstr "=E6=97=A0=E6=B3=95=E5=86=99=E6=8F=90=E4=BA=A4=E6=A8=A1=E7=89=88=
"
+
+#  %s=E8=8B=A5=E7=BF=BB=E4=B8=BA=E4=B8=AD=E6=96=87=EF=BC=8C=E5=89=8D=E5=
=90=8E=E4=B8=8D=E9=9C=80=E8=A6=81=E7=A9=BA=E6=A0=BC
+#: builtin/commit.c:777
+#, c-format
+msgid ""
+"\n"
+"It looks like you may be committing a %s.\n"
+"If this is not correct, please remove the file\n"
+"\t%s\n"
+"and try again.\n"
+msgstr ""
+"\n"
+"=E7=9C=8B=E8=B5=B7=E6=9D=A5=E6=82=A8=E6=AD=A3=E5=9C=A8=E6=8F=90=E4=BA=
=A4=E4=B8=80=E4=B8=AA%s=E3=80=82\n"
+"=E5=A6=82=E6=9E=9C=E4=B8=8D=E6=98=AF=E8=BF=99=E6=A0=B7=EF=BC=8C=E8=AF=
=B7=E5=88=A0=E9=99=A4=E6=96=87=E4=BB=B6\n"
+"\t%s\n"
+"=E7=84=B6=E5=90=8E=E9=87=8D=E8=AF=95=E3=80=82\n"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: builtin/commit.c:790
+msgid "Please enter the commit message for your changes."
+msgstr "=E8=AF=B7=E4=B8=BA=E6=82=A8=E7=9A=84=E4=BF=AE=E6=94=B9=E8=BE=93=
=E5=85=A5=E6=8F=90=E4=BA=A4=E8=AF=B4=E6=98=8E=E3=80=82"
+
+#: builtin/commit.c:793
+msgid ""
+" Lines starting\n"
+"with '#' will be ignored, and an empty message aborts the commit.\n"
+msgstr ""
+" =E4=BB=A5 '#' =E5=BC=80=E5=A4=B4\n"
+"=E7=9A=84=E8=A1=8C=E5=B0=86=E8=A2=AB=E5=BF=BD=E7=95=A5=EF=BC=8C=E8=80=
=8C=E4=B8=94=E7=A9=BA=E6=8F=90=E4=BA=A4=E8=AF=B4=E6=98=8E=E5=B0=86=E4=BC=
=9A=E7=BB=88=E6=AD=A2=E6=8F=90=E4=BA=A4=E3=80=82\n"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: builtin/commit.c:798
+msgid ""
+" Lines starting\n"
+"with '#' will be kept; you may remove them yourself if you want to.\n=
"
+"An empty message aborts the commit.\n"
+msgstr ""
+" =E4=BB=A5 '#' =E5=BC=80=E5=A4=B4\n"
+"=E7=9A=84=E8=A1=8C=E5=B0=86=E8=A2=AB=E4=BF=9D=E7=95=99=EF=BC=8C=E6=82=
=A8=E5=8F=AF=E4=BB=A5=E5=88=A0=E9=99=A4=E5=AE=83=E4=BB=AC=E5=A6=82=E6=9E=
=9C=E6=82=A8=E6=83=B3=E8=BF=99=E6=A0=B7=E5=81=9A=E3=80=82=E7=A9=BA=E6=8F=
=90=E4=BA=A4=E8=AF=B4=E6=98=8E=E5=B0=86=E4=BC=9A=E7=BB=88=E6=AD=A2=E6=8F=
=90=E4=BA=A4=E3=80=82\n"
+
+#  =E4=B8=BA=E4=BF=9D=E8=AF=81=E5=9C=A8=E8=BE=93=E5=87=BA=E4=B8=AD=E5=AF=
=B9=E9=BD=90=EF=BC=8C=E6=B3=A8=E6=84=8F=E8=B0=83=E6=95=B4=E5=8F=A5=E4=B8=
=AD=E7=A9=BA=E6=A0=BC=EF=BC=81
+#: builtin/commit.c:810
+#, c-format
+msgid "%sAuthor:    %s"
+msgstr "%s=E4=BD=9C=E8=80=85=EF=BC=9A     %s"
+
+#  =E4=B8=BA=E4=BF=9D=E8=AF=81=E5=9C=A8=E8=BE=93=E5=87=BA=E4=B8=AD=E5=AF=
=B9=E9=BD=90=EF=BC=8C=E6=B3=A8=E6=84=8F=E8=B0=83=E6=95=B4=E5=8F=A5=E4=B8=
=AD=E7=A9=BA=E6=A0=BC=EF=BC=81
+#: builtin/commit.c:817
+#, c-format
+msgid "%sCommitter: %s"
+msgstr "%s=E6=8F=90=E4=BA=A4=E8=80=85=EF=BC=9A   %s"
+
+#: builtin/commit.c:837
+msgid "Cannot read index"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96=E6=9A=82=E5=AD=98=E5=8C=BA=
"
+
+#: builtin/commit.c:874
+msgid "Error building trees"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E6=A0=91=E5=AF=B9=E8=B1=A1=
"
+
+#: builtin/commit.c:889 builtin/tag.c:324
+#, c-format
+msgid "Please supply the message using either -m or -F option.\n"
+msgstr "=E8=AF=B7=E4=BD=BF=E7=94=A8 -m =E6=88=96=E8=80=85 -F =E9=80=89=
=E9=A1=B9=E6=8F=90=E4=BE=9B=E8=AF=B4=E6=98=8E=E3=80=82\n"
+
+#: builtin/commit.c:969
+#, c-format
+msgid "No existing author found with '%s'"
+msgstr "=E6=B2=A1=E6=9C=89=E6=89=BE=E5=88=B0=E5=8C=B9=E9=85=8D '%s' =E7=
=9A=84=E4=BD=9C=E8=80=85"
+
+#: builtin/commit.c:984 builtin/commit.c:1176
+#, c-format
+msgid "Invalid untracked files mode '%s'"
+msgstr "=E6=97=A0=E6=95=88=E7=9A=84=E9=9D=9E=E8=BF=BD=E8=B8=AA=E6=96=87=
=E4=BB=B6=E5=8F=82=E6=95=B0 '%s'"
+
+#: builtin/commit.c:1024
+msgid "Using both --reset-author and --author does not make sense"
+msgstr "=E5=90=8C=E6=97=B6=E4=BD=BF=E7=94=A8 --reset-author =E5=92=8C =
--author =E6=B2=A1=E6=9C=89=E6=84=8F=E4=B9=89"
+
+#: builtin/commit.c:1035
+msgid "You have nothing to amend."
+msgstr "=E6=82=A8=E6=B2=A1=E6=9C=89=E8=A6=81=E4=BF=AE=E8=A1=A5=E3=80=82=
"
+
+#  %s=E8=8B=A5=E7=BF=BB=E4=B8=BA=E4=B8=AD=E6=96=87=EF=BC=8C=E5=89=8D=E5=
=90=8E=E4=B8=8D=E9=9C=80=E8=A6=81=E7=A9=BA=E6=A0=BC
+#: builtin/commit.c:1037
+#, c-format
+msgid "You are in the middle of a %s -- cannot amend."
+msgstr "=E6=82=A8=E6=AD=A3=E5=A4=84=E4=BA=8E=E4=B8=80=E4=B8=AA%s=E8=BF=
=87=E7=A8=8B=E4=B8=AD -- =E6=97=A0=E6=B3=95=E4=BF=AE=E8=A1=A5=E6=8F=90=E4=
=BA=A4=E3=80=82"
+
+#: builtin/commit.c:1039
+msgid "Options --squash and --fixup cannot be used together"
+msgstr "=E9=80=89=E9=A1=B9 --squash =E5=92=8C --fixup =E4=B8=8D=E8=83=BD=
=E5=85=B1=E7=94=A8"
+
+#: builtin/commit.c:1049
+msgid "Only one of -c/-C/-F/--fixup can be used."
+msgstr "=E5=8F=AA=E8=83=BD=E7=94=A8=E4=B8=80=E4=B8=AA -c/-C/-F/--fixup=
 =E9=80=89=E9=A1=B9=E3=80=82"
+
+#: builtin/commit.c:1051
+msgid "Option -m cannot be combined with -c/-C/-F/--fixup."
+msgstr "=E9=80=89=E9=A1=B9 -m =E4=B8=8D=E8=83=BD=E5=92=8C -c/-C/-F/--f=
ixup =E5=85=B1=E7=94=A8=E3=80=82"
+
+#: builtin/commit.c:1057
+msgid "--reset-author can be used only with -C, -c or --amend."
+msgstr "--reset-author =E5=8F=AA=E8=83=BD=E5=92=8C -C, -c =E6=88=96 --=
amend =E5=85=B1=E7=94=A8=E3=80=82"
+
+#: builtin/commit.c:1074
+msgid "Only one of --include/--only/--all/--interactive/--patch can be=
 used."
+msgstr "=E5=8F=AA=E8=83=BD=E7=94=A8=E4=B8=80=E4=B8=AA --include/--only=
/--all/--interactive/--patch =E9=80=89=E9=A1=B9=E3=80=82"
+
+#: builtin/commit.c:1076
+msgid "No paths with --include/--only does not make sense."
+msgstr "=E5=8F=82=E6=95=B0 --include/--only =E4=B8=8D=E8=B7=9F=E8=B7=AF=
=E5=BE=84=E6=B2=A1=E6=9C=89=E6=84=8F=E4=B9=89=E3=80=82"
+
+#: builtin/commit.c:1078
+msgid "Clever... amending the last one with dirty index."
+msgstr "=E8=81=AA=E6=98=8E... =E5=9C=A8=E6=9A=82=E5=AD=98=E5=8C=BA=E4=B8=
=8D=E5=B9=B2=E5=87=80=E4=B8=8B=E4=BF=AE=E8=A1=A5=E6=9C=80=E5=90=8E=E7=9A=
=84=E6=8F=90=E4=BA=A4=E3=80=82"
+
+#: builtin/commit.c:1080
+msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgstr "=E6=B2=A1=E6=9C=89=E7=94=A8 -i =E6=88=96 -o =E9=80=89=E9=A1=B9=
=E8=80=8C=E6=98=BE=E5=BC=8F=E5=9C=B0=E6=8F=90=E4=BE=9B=E8=B7=AF=E5=BE=84=
=EF=BC=8C=E8=AE=A4=E4=B8=BA=E6=98=AF --only paths..."
+
+#: builtin/commit.c:1090 builtin/tag.c:500
+#, c-format
+msgid "Invalid cleanup mode %s"
+msgstr "=E6=97=A0=E6=95=88=E7=9A=84=E6=B8=85=E7=90=86=E6=A8=A1=E5=BC=8F=
 %s"
+
+#: builtin/commit.c:1095
+msgid "Paths with -a does not make sense."
+msgstr "=E8=B7=AF=E5=BE=84=E5=92=8C -a =E9=80=89=E9=A1=B9=E5=85=B1=E7=94=
=A8=E6=B2=A1=E6=9C=89=E6=84=8F=E4=B9=89=E3=80=82"
+
+#: builtin/commit.c:1274
+msgid "couldn't look up newly created commit"
+msgstr "=E6=97=A0=E6=B3=95=E6=89=BE=E5=88=B0=E6=96=B0=E5=88=9B=E5=BB=BA=
=E7=9A=84=E6=8F=90=E4=BA=A4"
+
+#: builtin/commit.c:1276
+msgid "could not parse newly created commit"
+msgstr "=E6=97=A0=E6=B3=95=E8=A7=A3=E6=9E=90=E6=96=B0=E5=88=9B=E5=BB=BA=
=E7=9A=84=E6=8F=90=E4=BA=A4"
+
+#: builtin/commit.c:1317
+msgid "detached HEAD"
+msgstr "=E5=88=86=E7=A6=BB=E5=A4=B4=E6=8C=87=E9=92=88"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: builtin/commit.c:1319
+msgid " (root-commit)"
+msgstr " =EF=BC=88=E6=A0=B9=E6=8F=90=E4=BA=A4=EF=BC=89"
+
+#: builtin/commit.c:1409
+msgid "could not parse HEAD commit"
+msgstr "=E6=97=A0=E6=B3=95=E8=A7=A3=E6=9E=90 HEAD =E6=8F=90=E4=BA=A4"
+
+#: builtin/commit.c:1446 builtin/merge.c:507
+#, c-format
+msgid "could not open '%s' for reading"
+msgstr "=E6=97=A0=E6=B3=95=E6=89=93=E5=BC=80 '%s' =E8=AF=BB=E5=8F=96"
+
+#: builtin/commit.c:1453
+#, c-format
+msgid "Corrupt MERGE_HEAD file (%s)"
+msgstr "=E6=8D=9F=E5=9D=8F=E7=9A=84 MERGE_HEAD =E6=96=87=E4=BB=B6 (%s)=
"
+
+#: builtin/commit.c:1460
+msgid "could not read MERGE_MODE"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96 MERGE_MODE"
+
+#: builtin/commit.c:1479
+#, c-format
+msgid "could not read commit message: %s"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96=E6=8F=90=E4=BA=A4=E8=AF=B4=
=E6=98=8E=EF=BC=9A%s"
+
+#: builtin/commit.c:1493
+#, c-format
+msgid "Aborting commit due to empty commit message.\n"
+msgstr "=E7=BB=88=E6=AD=A2=E6=8F=90=E4=BA=A4=E5=9B=A0=E4=B8=BA=E6=8F=90=
=E4=BA=A4=E8=AF=B4=E6=98=8E=E4=B8=BA=E7=A9=BA=E3=80=82\n"
+
+#: builtin/commit.c:1508 builtin/merge.c:923 builtin/merge.c:956
+msgid "failed to write commit object"
+msgstr "=E5=86=99=E6=8F=90=E4=BA=A4=E5=AF=B9=E8=B1=A1=E5=A4=B1=E8=B4=A5=
"
+
+#: builtin/commit.c:1529
+msgid "cannot lock HEAD ref"
+msgstr "=E6=97=A0=E6=B3=95=E9=94=81=E5=AE=9A HEAD =E5=BC=95=E7=94=A8"
+
+#: builtin/commit.c:1533
+msgid "cannot update HEAD ref"
+msgstr "=E6=97=A0=E6=B3=95=E6=9B=B4=E6=96=B0 HEAD =E5=BC=95=E7=94=A8"
+
+#: builtin/commit.c:1544
+msgid ""
+"Repository has been updated, but unable to write\n"
+"new_index file. Check that disk is not full or quota is\n"
+"not exceeded, and then \"git reset HEAD\" to recover."
+msgstr ""
+"=E7=89=88=E6=9C=AC=E5=BA=93=E5=B7=B2=E8=A2=AB=E6=9B=B4=E6=96=B0=EF=BC=
=8C=E4=BD=86=E6=97=A0=E6=B3=95=E5=86=99=E5=85=A5=E6=96=B0=E6=9A=82=E5=AD=
=98=E5=8C=BA=E6=96=87=E4=BB=B6=E3=80=82=E6=A3=80=E6=9F=A5=E6=98=AF=E5=90=
=A6=E7=A3=81=E7=9B=98\n"
+"=E5=B7=B2=E6=BB=A1=E6=88=96=E7=A3=81=E7=9B=98=E9=85=8D=E9=A2=9D=E8=80=
=97=E5=B0=BD=EF=BC=8C=E7=84=B6=E5=90=8E=E6=89=A7=E8=A1=8C \"git reset H=
EAD\" =E6=81=A2=E5=A4=8D=E3=80=82"
+
+#: builtin/describe.c:234
+#, c-format
+msgid "annotated tag %s not available"
+msgstr "=E6=B3=A8=E9=87=8A tag %s =E6=97=A0=E6=95=88"
+
+#: builtin/describe.c:238
+#, c-format
+msgid "annotated tag %s has no embedded name"
+msgstr "=E6=B3=A8=E9=87=8A tag %s =E6=B2=A1=E6=9C=89=E5=B5=8C=E5=85=A5=
=E5=90=8D=E7=A7=B0"
+
+#: builtin/describe.c:240
+#, c-format
+msgid "tag '%s' is really '%s' here"
+msgstr "tag '%s' =E7=A1=AE=E6=98=AF=E5=9C=A8 '%s'"
+
+#: builtin/describe.c:267
+#, c-format
+msgid "Not a valid object name %s"
+msgstr "=E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E6=9C=89=E6=95=88=E7=9A=84=
=E5=AF=B9=E8=B1=A1=E5=90=8D %s"
+
+#: builtin/describe.c:270
+#, c-format
+msgid "%s is not a valid '%s' object"
+msgstr "%s =E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E6=9C=89=E6=95=88=E7=9A=
=84 '%s' =E5=AF=B9=E8=B1=A1"
+
+#: builtin/describe.c:287
+#, c-format
+msgid "no tag exactly matches '%s'"
+msgstr "=E6=B2=A1=E6=9C=89 tag =E5=87=86=E7=A1=AE=E5=8C=B9=E9=85=8D '%=
s'"
+
+#: builtin/describe.c:289
+#, c-format
+msgid "searching to describe %s\n"
+msgstr "=E6=90=9C=E7=B4=A2=E6=8F=8F=E8=BF=B0 %s\n"
+
+#: builtin/describe.c:329
+#, c-format
+msgid "finished search at %s\n"
+msgstr "=E5=AE=8C=E6=88=90=E6=90=9C=E7=B4=A2 %s\n"
+
+#: builtin/describe.c:353
+#, c-format
+msgid ""
+"No annotated tags can describe '%s'.\n"
+"However, there were unannotated tags: try --tags."
+msgstr ""
+"=E6=B2=A1=E6=9C=89=E6=B3=A8=E9=87=8A tag =E8=83=BD=E6=8F=8F=E8=BF=B0 =
'%s'=E3=80=82\n"
+"=E7=84=B6=E8=80=8C=EF=BC=8C=E6=9C=89=E9=9D=9E=E6=B3=A8=E9=87=8A tag=EF=
=BC=9A=E5=B0=9D=E8=AF=95 --tags=E3=80=82"
+
+#: builtin/describe.c:357
+#, c-format
+msgid ""
+"No tags can describe '%s'.\n"
+"Try --always, or create some tags."
+msgstr ""
+"=E6=B2=A1=E6=9C=89=E6=B3=A8=E9=87=8A tag =E8=83=BD=E6=8F=8F=E8=BF=B0 =
'%s'=E3=80=82\n"
+"=E5=B0=9D=E8=AF=95 --always=EF=BC=8C=E6=88=96=E5=88=9B=E5=BB=BA=E4=B8=
=80=E4=BA=9B tag=E3=80=82"
+
+#: builtin/describe.c:378
+#, c-format
+msgid "traversed %lu commits\n"
+msgstr "=E5=B7=B2=E9=81=8D=E5=8E=86 %lu =E4=B8=AA=E6=8F=90=E4=BA=A4\n"
+
+#: builtin/describe.c:381
+#, c-format
+msgid ""
+"more than %i tags found; listed %i most recent\n"
+"gave up search at %s\n"
+msgstr ""
+"=E5=8F=91=E7=8E=B0=E5=A4=9A=E4=BA=8E %i =E4=B8=AA tag=EF=BC=9B=E5=88=97=
=E5=87=BA=E6=9C=80=E8=BF=91=E7=9A=84 %i =E4=B8=AA\n"
+"=E6=94=BE=E5=BC=83=E6=90=9C=E7=B4=A2 %s\n"
+
+#: builtin/describe.c:436
+msgid "--long is incompatible with --abbrev=3D0"
+msgstr "--long =E4=B8=8E --abbrev=3D0 =E4=B8=8D=E5=85=BC=E5=AE=B9"
+
+#: builtin/describe.c:462
+msgid "No names found, cannot describe anything."
+msgstr "=E6=B2=A1=E6=9C=89=E5=8F=91=E7=8E=B0=E5=90=8D=E7=A7=B0=EF=BC=8C=
=E6=97=A0=E6=B3=95=E6=8F=8F=E8=BF=B0=E4=BB=BB=E4=BD=95=E4=B8=9C=E8=A5=BF=
"
+
+#: builtin/describe.c:482
+msgid "--dirty is incompatible with committishes"
+msgstr "--dirty =E4=B8=8D=E8=83=BD=E4=B8=8E=E6=8F=90=E4=BA=A4=E5=85=B1=
=E7=94=A8"
+
+#: builtin/diff.c:77
+#, c-format
+msgid "'%s': not a regular file or symlink"
+msgstr "'%s'=EF=BC=9A=E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E6=AD=A3=E8=A7=
=84=E6=96=87=E4=BB=B6=E6=88=96=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=A5"
+
+#: builtin/diff.c:220
+#, c-format
+msgid "invalid option: %s"
+msgstr "=E6=97=A0=E6=95=88=E9=80=89=E9=A1=B9=EF=BC=9A%s"
+
+#: builtin/diff.c:293
+msgid "Not a git repository"
+msgstr "=E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA git =E7=89=88=E6=9C=AC=E5=
=BA=93"
+
+#: builtin/diff.c:343
+#, c-format
+msgid "invalid object '%s' given."
+msgstr "=E6=8F=90=E4=BE=9B=E4=BA=86=E6=97=A0=E6=95=88=E5=AF=B9=E8=B1=A1=
 '%s'=E3=80=82"
+
+#: builtin/diff.c:348
+#, c-format
+msgid "more than %d trees given: '%s'"
+msgstr "=E6=8F=90=E4=BE=9B=E4=BA=86=E8=B6=85=E8=BF=87 %d =E4=B8=AA=E6=A0=
=91=E5=AF=B9=E8=B1=A1=EF=BC=9A'%s'"
+
+#: builtin/diff.c:358
+#, c-format
+msgid "more than two blobs given: '%s'"
+msgstr "=E6=8F=90=E4=BE=9B=E4=BA=86=E8=B6=85=E8=BF=87=E4=B8=A4=E4=B8=AA=
 blob =E5=AF=B9=E8=B1=A1=EF=BC=9A'%s'"
+
+#: builtin/diff.c:366
+#, c-format
+msgid "unhandled object '%s' given."
+msgstr "=E6=8F=90=E4=BE=9B=E4=BA=86=E6=97=A0=E6=B3=95=E5=A4=84=E7=90=86=
=E7=9A=84=E5=AF=B9=E8=B1=A1 '%s'=E3=80=82"
+
+#: builtin/fetch.c:200
+msgid "Couldn't find remote ref HEAD"
+msgstr "=E6=97=A0=E6=B3=95=E5=8F=91=E7=8E=B0=E8=BF=9C=E7=A8=8B HEAD =E5=
=BC=95=E7=94=A8"
+
+#: builtin/fetch.c:252
+#, c-format
+msgid "object %s not found"
+msgstr "=E5=AF=B9=E8=B1=A1 %s =E6=9C=AA=E5=8F=91=E7=8E=B0"
+
+#: builtin/fetch.c:258
+msgid "[up to date]"
+msgstr "[=E6=9C=80=E6=96=B0]"
+
+#: builtin/fetch.c:272
+#, c-format
+msgid "! %-*s %-*s -> %s  (can't fetch in current branch)"
+msgstr "! %-*s %-*s -> %s  =EF=BC=88=E5=9C=A8=E5=BD=93=E5=89=8D=E5=88=86=
=E6=94=AF=E4=B8=8B=E4=B8=8D=E8=83=BD=E8=8E=B7=E5=8F=96=EF=BC=89"
+
+#: builtin/fetch.c:273 builtin/fetch.c:351
+msgid "[rejected]"
+msgstr "[=E5=B7=B2=E6=8B=92=E7=BB=9D]"
+
+#: builtin/fetch.c:284
+msgid "[tag update]"
+msgstr "[tag=E6=9B=B4=E6=96=B0]"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: builtin/fetch.c:286 builtin/fetch.c:313 builtin/fetch.c:331
+msgid "  (unable to update local ref)"
+msgstr "  =EF=BC=88=E4=B8=8D=E8=83=BD=E6=9B=B4=E6=96=B0=E6=9C=AC=E5=9C=
=B0=E5=BC=95=E7=94=A8=EF=BC=89"
+
+#: builtin/fetch.c:298
+msgid "[new tag]"
+msgstr "[=E6=96=B0tag]"
+
+#: builtin/fetch.c:302
+msgid "[new branch]"
+msgstr "[=E6=96=B0=E5=88=86=E6=94=AF]"
+
+#: builtin/fetch.c:347
+msgid "unable to update local ref"
+msgstr "=E4=B8=8D=E8=83=BD=E6=9B=B4=E6=96=B0=E6=9C=AC=E5=9C=B0=E5=BC=95=
=E7=94=A8"
+
+#: builtin/fetch.c:347
+msgid "forced update"
+msgstr "=E5=BC=BA=E5=88=B6=E6=9B=B4=E6=96=B0"
+
+#: builtin/fetch.c:353
+msgid "(non-fast-forward)"
+msgstr "=EF=BC=88=E9=9D=9E=E5=BF=AB=E8=BF=9B=E5=BC=8F=E6=8E=A8=E9=80=81=
=EF=BC=89"
+
+#: builtin/fetch.c:384 builtin/fetch.c:676
+#, c-format
+msgid "cannot open %s: %s\n"
+msgstr "=E6=97=A0=E6=B3=95=E6=89=93=E5=BC=80 %s=EF=BC=9A%s\n"
+
+#: builtin/fetch.c:393
+#, c-format
+msgid "%s did not send all necessary objects\n"
+msgstr "%s =E6=9C=AA=E5=8F=91=E9=80=81=E6=89=80=E6=9C=89=E5=BF=85=E9=A1=
=BB=E7=9A=84=E5=AF=B9=E8=B1=A1\n"
+
+#: builtin/fetch.c:479
+#, c-format
+msgid "From %.*s\n"
+msgstr "=E6=9D=A5=E8=87=AA %.*s\n"
+
+#: builtin/fetch.c:490
+#, c-format
+msgid ""
+"some local refs could not be updated; try running\n"
+" 'git remote prune %s' to remove any old, conflicting branches"
+msgstr ""
+"=E4=B8=80=E4=BA=9B=E6=9C=AC=E5=9C=B0=E5=BC=95=E7=94=A8=E4=B8=8D=E8=83=
=BD=E8=A2=AB=E6=9B=B4=E6=96=B0=EF=BC=9B=E5=B0=9D=E8=AF=95=E8=BF=90=E8=A1=
=8C\n"
+" 'git remote prune %s' =E6=9D=A5=E5=88=A0=E9=99=A4=E6=97=A7=E7=9A=84=E3=
=80=81=E6=9C=89=E5=86=B2=E7=AA=81=E7=9A=84=E5=88=86=E6=94=AF"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: builtin/fetch.c:540
+#, c-format
+msgid "   (%s will become dangling)\n"
+msgstr "   =EF=BC=88%s =E5=B0=86=E6=88=90=E4=B8=BA=E6=82=AC=E7=A9=BA=E7=
=8A=B6=E6=80=81=EF=BC=89\n"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: builtin/fetch.c:541
+#, c-format
+msgid "   (%s has become dangling)\n"
+msgstr "   =EF=BC=88%s =E5=B7=B2=E6=88=90=E4=B8=BA=E6=82=AC=E7=A9=BA=E7=
=8A=B6=E6=80=81=EF=BC=89\n"
+
+#: builtin/fetch.c:548
+msgid "[deleted]"
+msgstr "[=E5=B7=B2=E5=88=A0=E9=99=A4]"
+
+#: builtin/fetch.c:549
+msgid "(none)"
+msgstr "=EF=BC=88=E6=97=A0=EF=BC=89"
+
+#: builtin/fetch.c:666
+#, c-format
+msgid "Refusing to fetch into current branch %s of non-bare repository=
"
+msgstr "=E6=8B=92=E7=BB=9D=E8=8E=B7=E5=8F=96=E5=88=B0=E9=9D=9E=E8=A3=B8=
=E7=89=88=E6=9C=AC=E5=BA=93=E7=9A=84=E5=BD=93=E5=89=8D=E5=88=86=E6=94=AF=
 %s"
+
+#: builtin/fetch.c:700
+#, c-format
+msgid "Don't know how to fetch from %s"
+msgstr "=E4=B8=8D=E7=9F=A5=E9=81=93=E5=A6=82=E4=BD=95=E4=BB=8E %s =E8=8E=
=B7=E5=8F=96"
+
+#: builtin/fetch.c:777
+#, c-format
+msgid "Option \"%s\" value \"%s\" is not valid for %s"
+msgstr "=E9=80=89=E9=A1=B9 \"%s\" =E7=9A=84=E5=80=BC \"%s\" =E5=AF=B9=E4=
=BA=8E %s =E6=98=AF=E6=97=A0=E6=95=88=E7=9A=84"
+
+#: builtin/fetch.c:780
+#, c-format
+msgid "Option \"%s\" is ignored for %s\n"
+msgstr "=E9=80=89=E9=A1=B9 \"%s\" =E5=AF=B9=E4=BA=8E %s =E8=A2=AB=E5=BF=
=BD=E7=95=A5\n"
+
+#: builtin/fetch.c:879
+#, c-format
+msgid "Fetching %s\n"
+msgstr "=E6=AD=A3=E8=8E=B7=E5=8F=96 %s\n"
+
+#: builtin/fetch.c:881
+#, c-format
+msgid "Could not fetch %s"
+msgstr "=E4=B8=8D=E8=83=BD=E8=8E=B7=E5=8F=96 %s"
+
+#: builtin/fetch.c:898
+msgid ""
+"No remote repository specified.  Please, specify either a URL or a\n"
+"remote name from which new revisions should be fetched."
+msgstr "=E6=9C=AA=E6=8F=90=E4=BE=9B=E8=BF=9C=E7=A8=8B=E7=89=88=E6=9C=AC=
=E5=BA=93=E3=80=82=E8=AF=B7=E6=8F=90=E4=BE=9B=E4=B8=80=E4=B8=AAURL=E6=88=
=96=E8=BF=9C=E7=A8=8B=E7=89=88=E6=9C=AC=E5=BA=93=E5=90=8D=EF=BC=8C=E7=94=
=A8=E4=BA=8E=E8=8E=B7=E5=8F=96=E6=96=B0=E7=89=88=E6=9C=AC=E3=80=82"
+
+#: builtin/fetch.c:918
+msgid "You need to specify a tag name."
+msgstr "=E4=BD=A0=E9=9C=80=E8=A6=81=E6=8F=90=E4=BE=9B=E4=B8=80=E4=B8=AA=
 tag =E5=90=8D=E7=A7=B0"
+
+#: builtin/fetch.c:970
+msgid "fetch --all does not take a repository argument"
+msgstr "fetch --all =E4=B8=8D=E8=83=BD=E5=B8=A6=E4=B8=80=E4=B8=AA=E7=89=
=88=E6=9C=AC=E5=BA=93=E5=8F=82=E6=95=B0"
+
+#: builtin/fetch.c:972
+msgid "fetch --all does not make sense with refspecs"
+msgstr "fetch --all =E5=B8=A6=E5=BC=95=E7=94=A8=E8=A1=A8=E8=BE=BE=E5=BC=
=8F=E6=B2=A1=E6=9C=89=E4=BB=BB=E4=BD=95=E6=84=8F=E4=B9=89"
+
+#: builtin/fetch.c:983
+#, c-format
+msgid "No such remote or remote group: %s"
+msgstr "=E6=B2=A1=E6=9C=89=E8=BF=99=E6=A0=B7=E7=9A=84=E8=BF=9C=E7=A8=8B=
=E6=88=96=E8=BF=9C=E7=A8=8B=E7=BB=84=EF=BC=9A%s"
+
+#: builtin/fetch.c:991
+msgid "Fetching a group and specifying refspecs does not make sense"
+msgstr "=E8=8E=B7=E5=8F=96=E7=BB=84=E5=B9=B6=E6=8F=90=E4=BE=9B=E5=BC=95=
=E7=94=A8=E8=A1=A8=E8=BE=BE=E5=BC=8F=E6=B2=A1=E6=9C=89=E6=84=8F=E4=B9=89=
"
+
+#: builtin/gc.c:63
+#, c-format
+msgid "Invalid %s: '%s'"
+msgstr "=E6=97=A0=E6=95=88=E7=9A=84 %s=EF=BC=9A'%s'"
+
+#: builtin/gc.c:78
+msgid "Too many options specified"
+msgstr "=E6=8F=90=E4=BE=9B=E4=BA=86=E5=A4=AA=E5=A4=9A=E7=9A=84=E9=80=89=
=E9=A1=B9"
+
+#: builtin/gc.c:103
+#, c-format
+msgid "insanely long object directory %.*s"
+msgstr "=E4=B8=8D=E6=AD=A3=E5=B8=B8=E7=9A=84=E9=95=BF=E5=AF=B9=E8=B1=A1=
=E7=9B=AE=E5=BD=95 %.*s"
+
+#: builtin/gc.c:223
+#, c-format
+msgid "Auto packing the repository for optimum performance.\n"
+msgstr "=E8=87=AA=E5=8A=A8=E6=89=93=E5=8C=85=E7=89=88=E6=9C=AC=E5=BA=93=
=E4=BB=A5=E6=B1=82=E6=9C=80=E4=BD=B3=E6=80=A7=E8=83=BD=E3=80=82\n"
+
+#: builtin/gc.c:226
+#, c-format
+msgid ""
+"Auto packing the repository for optimum performance. You may also\n"
+"run \"git gc\" manually. See \"git help gc\" for more information.\n"
+msgstr ""
+"=E8=87=AA=E5=8A=A8=E6=89=93=E5=8C=85=E7=89=88=E6=9C=AC=E5=BA=93=E4=BB=
=A5=E6=B1=82=E6=9C=80=E4=BD=B3=E6=80=A7=E8=83=BD=E3=80=82=E4=BD=A0=E8=BF=
=98=E5=8F=AF=E4=BB=A5\n"
+"=E6=89=8B=E5=8A=A8=E8=BF=90=E8=A1=8C \"git gc\"=E3=80=82 =E5=8F=82=E8=
=A7=81 \"git help gc\" =E8=8E=B7=E5=8F=96=E6=9B=B4=E5=A4=9A=E4=BF=A1=E6=
=81=AF=E3=80=82\n"
+
+#: builtin/gc.c:256
+msgid ""
+"There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
+msgstr "=E6=9C=89=E5=A4=AA=E5=A4=9A=E6=97=A0=E6=8C=87=E5=90=91=E7=9A=84=
=E6=9D=BE=E6=95=A3=E5=AF=B9=E8=B1=A1=EF=BC=8C=E8=BF=90=E8=A1=8C 'git pr=
une' =E5=88=A0=E9=99=A4=E5=AE=83=E4=BB=AC=E3=80=82"
+
+#: builtin/grep.c:275
+#, c-format
+msgid "grep: failed to create thread: %s"
+msgstr "grep: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=BA=BF=E7=A8=8B=EF=
=BC=9A%s"
+
+#: builtin/grep.c:390
+#, c-format
+msgid "'%s': unable to read %s"
+msgstr "'%s'=EF=BC=9A=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96 %s"
+
+#: builtin/grep.c:441
+#, c-format
+msgid "'%s': %s"
+msgstr "'%s'=EF=BC=9A%s"
+
+#: builtin/grep.c:452
+#, c-format
+msgid "'%s': short read %s"
+msgstr "'%s'=EF=BC=9A=E8=AF=BB=E5=8F=96=E4=B8=8D=E5=AE=8C=E6=95=B4 %s"
+
+#: builtin/grep.c:514
+#, c-format
+msgid "Failed to chdir: %s"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=87=E6=8D=A2=E7=9B=AE=E5=BD=95=EF=BC=9A=
%s"
+
+#: builtin/grep.c:590 builtin/grep.c:624
+#, c-format
+msgid "unable to read tree (%s)"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96=E4=BB=A3=E7=A0=81=E6=A0=91=
=EF=BC=88%s=EF=BC=89"
+
+#: builtin/grep.c:638
+#, c-format
+msgid "unable to grep from object of type %s"
+msgstr "=E6=97=A0=E6=B3=95=E6=8A=93=E5=8F=96=E6=9D=A5=E8=87=AA=E4=BA=8E=
 %s =E7=B1=BB=E5=9E=8B=E7=9A=84=E5=AF=B9=E8=B1=A1"
+
+#: builtin/grep.c:696
+#, c-format
+msgid "switch `%c' expects a numerical value"
+msgstr "=E5=BC=80=E5=85=B3 `%c' =E6=9C=9F=E6=9C=9B=E4=B8=80=E4=B8=AA=E6=
=95=B0=E5=AD=97=E5=80=BC"
+
+#: builtin/grep.c:713
+#, c-format
+msgid "cannot open '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E6=89=93=E5=BC=80 '%s'"
+
+#: builtin/grep.c:1001
+msgid "no pattern given."
+msgstr "=E6=9C=AA=E6=8F=90=E4=BE=9B=E6=A8=A1=E5=BC=8F=E5=8C=B9=E9=85=8D=
=E3=80=82"
+
+#: builtin/grep.c:1015
+#, c-format
+msgid "bad object %s"
+msgstr "=E5=9D=8F=E5=AF=B9=E8=B1=A1 %s"
+
+#: builtin/grep.c:1057
+msgid "--open-files-in-pager only works on the worktree"
+msgstr "--open-files-in-pager =E4=BB=85=E7=94=A8=E4=BA=8E=E5=B7=A5=E4=BD=
=9C=E5=8C=BA"
+
+#: builtin/grep.c:1080
+msgid "--cached or --untracked cannot be used with --no-index."
+msgstr "--cached =E6=88=96 --untracked =E4=B8=8D=E8=83=BD=E4=B8=8E --n=
o-index =E5=85=B1=E7=94=A8"
+
+#: builtin/grep.c:1085
+msgid "--no-index or --untracked cannot be used with revs."
+msgstr "--no-index =E6=88=96 --untracked =E4=B8=8D=E8=83=BD=E5=92=8C=E7=
=89=88=E6=9C=AC=E5=85=B1=E7=94=A8=E3=80=82"
+
+#: builtin/grep.c:1088
+msgid "--[no-]exclude-standard cannot be used for tracked contents."
+msgstr "--[no-]exclude-standard =E4=B8=8D=E8=83=BD=E7=94=A8=E4=BA=8E=E8=
=B7=9F=E8=B8=AA=E5=86=85=E5=AE=B9=E3=80=82"
+
+#: builtin/grep.c:1096
+msgid "both --cached and trees are given."
+msgstr "=E5=90=8C=E6=97=B6=E7=BB=99=E5=87=BA=E4=BA=86 --cached =E5=92=8C=
=E6=A0=91=E5=AF=B9=E8=B1=A1=E3=80=82"
+
+#: builtin/init-db.c:35
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr "=E4=B8=8D=E8=83=BD=E8=AE=BE=E7=BD=AE %s =E4=B8=BA=E7=BB=84=E5=8F=
=AF=E5=86=99"
+
+#: builtin/init-db.c:62
+#, c-format
+msgid "insanely long template name %s"
+msgstr "=E5=A4=AA=E9=95=BF=E7=9A=84=E6=A8=A1=E7=89=88=E5=90=8D %s"
+
+#: builtin/init-db.c:67
+#, c-format
+msgid "cannot stat '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E6=9E=9A=E4=B8=BE '%s' =E7=8A=B6=E6=80=81"
+
+#: builtin/init-db.c:73
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E6=9E=9A=E4=B8=BE=E6=A8=A1=E7=89=88 '%s' =E7=
=8A=B6=E6=80=81"
+
+#: builtin/init-db.c:80
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E6=89=93=E5=BC=80=E7=9B=AE=E5=BD=95 '%s'"
+
+#: builtin/init-db.c:97
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E8=AF=BB=E5=8F=96=E9=93=BE=E6=8E=A5 '%s'"
+
+#: builtin/init-db.c:99
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "=E5=A4=AA=E9=95=BF=E7=9A=84=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=A5=
 %s"
+
+#: builtin/init-db.c:102
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=
=E6=8E=A5 '%s' =E5=88=B0 '%s'"
+
+#: builtin/init-db.c:106
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E6=8B=B7=E8=B4=9D '%s' =E8=87=B3 '%s'"
+
+#: builtin/init-db.c:110
+#, c-format
+msgid "ignoring template %s"
+msgstr "=E5=BF=BD=E7=95=A5=E6=A8=A1=E7=89=88 %s"
+
+#: builtin/init-db.c:133
+#, c-format
+msgid "insanely long template path %s"
+msgstr "=E5=A4=AA=E9=95=BF=E7=9A=84=E6=A8=A1=E7=89=88=E8=B7=AF=E5=BE=84=
 %s"
+
+#: builtin/init-db.c:141
+#, c-format
+msgid "templates not found %s"
+msgstr "=E6=A8=A1=E7=89=88=E6=9C=AA=E6=89=BE=E5=88=B0 %s"
+
+#: builtin/init-db.c:154
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "=E6=9C=AA=E5=A4=8D=E5=88=B6=E9=94=99=E8=AF=AF=E7=89=88=E6=9C=AC=
 %d =E7=9A=84=E6=A8=A1=E7=89=88=E8=87=AA '%s'"
+
+#: builtin/init-db.c:192
+#, c-format
+msgid "insane git directory %s"
+msgstr "=E4=B8=8D=E6=AD=A3=E5=B8=B8=E7=9A=84 git =E7=9B=AE=E5=BD=95 %s=
"
+
+#: builtin/init-db.c:322 builtin/init-db.c:325
+#, c-format
+msgid "%s already exists"
+msgstr "%s =E5=B7=B2=E7=BB=8F=E5=AD=98=E5=9C=A8"
+
+#: builtin/init-db.c:354
+#, c-format
+msgid "unable to handle file type %d"
+msgstr "=E4=B8=8D=E8=83=BD=E5=A4=84=E7=90=86 %d =E7=B1=BB=E5=9E=8B=E7=9A=
=84=E6=96=87=E4=BB=B6"
+
+#: builtin/init-db.c:357
+#, c-format
+msgid "unable to move %s to %s"
+msgstr "=E4=B8=8D=E8=83=BD=E7=A7=BB=E5=8A=A8 %s =E8=87=B3 %s"
+
+#: builtin/init-db.c:362
+#, c-format
+msgid "Could not create git link %s"
+msgstr "=E4=B8=8D=E8=83=BD=E5=88=9B=E5=BB=BA git link %s"
+
+#.
+#. * TRANSLATORS: The first '%s' is either "Reinitialized
+#. * existing" or "Initialized empty", the second " shared" or
+#. * "", and the last '%s%s' is the verbatim directory name.
+#.
+#: builtin/init-db.c:419
+#, c-format
+msgid "%s%s Git repository in %s%s\n"
+msgstr "%s%s Git =E7=89=88=E6=9C=AC=E5=BA=93=E4=BA=8E %s%s\n"
+
+#: builtin/init-db.c:420
+msgid "Reinitialized existing"
+msgstr "=E9=87=8D=E6=96=B0=E5=88=9D=E5=A7=8B=E5=8C=96=E7=8E=B0=E5=AD=98=
=E7=9A=84"
+
+#: builtin/init-db.c:420
+msgid "Initialized empty"
+msgstr "=E5=88=9D=E5=A7=8B=E5=8C=96=E7=A9=BA=E7=9A=84"
+
+#  =E6=B1=89=E5=AD=97=E5=AD=97=E4=B8=B2=E5=90=88=E5=B9=B6=EF=BC=8C=E4=B9=
=8B=E9=97=B4=E6=97=A0=E7=A9=BA=E6=A0=BC=EF=BC=8C=E6=95=85=E5=88=A0=E9=99=
=A4=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=BC
+#: builtin/init-db.c:421
+msgid " shared"
+msgstr "=E5=85=B1=E4=BA=AB=E7=9A=84"
+
+#: builtin/init-db.c:440
+msgid "cannot tell cwd"
+msgstr "=E6=97=A0=E6=B3=95=E8=8E=B7=E7=9F=A5=E5=BD=93=E5=89=8D=E8=B7=AF=
=E5=BE=84"
+
+#: builtin/init-db.c:521 builtin/init-db.c:528
+#, c-format
+msgid "cannot mkdir %s"
+msgstr "=E4=B8=8D=E8=83=BD=E5=88=9B=E5=BB=BA=E7=9B=AE=E5=BD=95 %s"
+
+#: builtin/init-db.c:532
+#, c-format
+msgid "cannot chdir to %s"
+msgstr "=E4=B8=8D=E8=83=BD=E5=88=87=E6=8D=A2=E7=9B=AE=E5=BD=95=E5=88=B0=
 %s"
+
+#: builtin/init-db.c:554
+#, c-format
+msgid ""
+"%s (or --work-tree=3D<directory>) not allowed without specifying %s (=
or --git-"
+"dir=3D<directory>)"
+msgstr ""
+"=E4=B8=8D=E5=85=81=E8=AE=B8 %s=EF=BC=88=E6=88=96 --work-tree=3D<direc=
tory>=EF=BC=89=E8=80=8C=E6=B2=A1=E6=9C=89 %s=EF=BC=88=E6=88=96 --git-di=
r=3D<directory>=EF=BC=89"
+
+#: builtin/init-db.c:578
+msgid "Cannot access current working directory"
+msgstr "=E4=B8=8D=E8=83=BD=E8=AE=BF=E9=97=AE=E5=BD=93=E5=89=8D=E5=B7=A5=
=E4=BD=9C=E7=9B=AE=E5=BD=95"
+
+#: builtin/init-db.c:585
+#, c-format
+msgid "Cannot access work tree '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E8=AE=BF=E9=97=AE=E5=B7=A5=E4=BD=9C=E5=8C=BA=
 '%s'"
+
+#: builtin/log.c:185
+#, c-format
+msgid "Final output: %d %s\n"
+msgstr "=E6=9C=80=E7=BB=88=E8=BE=93=E5=87=BA=EF=BC=9A%d %s\n"
+
+#: builtin/log.c:286 builtin/log.c:709 builtin/log.c:1325 builtin/log.=
c:1544
+#: builtin/merge.c:348 builtin/revert.c:651 builtin/revert.c:1110
+#: builtin/shortlog.c:181
+msgid "revision walk setup failed"
+msgstr "=E7=89=88=E6=9C=AC=E9=81=8D=E5=8E=86=E8=AE=BE=E7=BD=AE=E5=A4=B1=
=E8=B4=A5"
+
+#: builtin/log.c:393 builtin/log.c:479
+#, c-format
+msgid "Could not read object %s"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96=E5=AF=B9=E8=B1=A1 %s"
+
+#: builtin/log.c:503
+#, c-format
+msgid "Unknown type: %d"
+msgstr "=E6=9C=AA=E7=9F=A5=E7=B1=BB=E5=9E=8B=EF=BC=9A%d"
+
+#: builtin/log.c:592
+msgid "format.headers without value"
+msgstr "format.headers =E6=B2=A1=E6=9C=89=E5=80=BC"
+
+#: builtin/log.c:665
+msgid "name of output directory is too long"
+msgstr "=E8=BE=93=E5=87=BA=E7=9B=AE=E5=BD=95=E5=90=8D=E5=A4=AA=E9=95=BF=
"
+
+#: builtin/log.c:676
+#, c-format
+msgid "Cannot open patch file %s"
+msgstr "=E6=97=A0=E6=B3=95=E6=89=93=E5=BC=80=E8=A1=A5=E4=B8=81=E6=96=87=
=E4=BB=B6 %s"
+
+#: builtin/log.c:690
+msgid "Need exactly one range."
+msgstr "=E5=8F=AA=E9=9C=80=E8=A6=81=E4=B8=80=E4=B8=AA=E8=8C=83=E5=9B=B4=
=E3=80=82"
+
+#: builtin/log.c:698
+msgid "Not a range."
+msgstr "=E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E8=8C=83=E5=9B=B4=E3=80=82=
"
+
+#: builtin/log.c:735
+msgid "Could not extract email from committer identity."
+msgstr "=E6=97=A0=E6=B3=95=E4=BB=8E=E6=8F=90=E4=BA=A4=E8=80=85=E8=BA=AB=
=E4=BB=BD=E4=B8=AD=E6=8F=90=E5=8F=96=E9=82=AE=E4=BB=B6=E5=9C=B0=E5=9D=80=
=E3=80=82"
+
+#: builtin/log.c:781
+msgid "Cover letter needs email format"
+msgstr "=E4=BF=A1=E5=B0=81=E9=9C=80=E8=A6=81=E9=82=AE=E4=BB=B6=E5=9C=B0=
=E5=9D=80=E6=A0=BC=E5=BC=8F"
+
+#: builtin/log.c:875
+#, c-format
+msgid "insane in-reply-to: %s"
+msgstr "=E4=B8=8D=E6=AD=A3=E5=B8=B8=E7=9A=84 in-reply-to=EF=BC=9A%s"
+
+#: builtin/log.c:948
+msgid "Two output directories?"
+msgstr "=E4=B8=A4=E4=B8=AA=E8=BE=93=E5=87=BA=E7=9B=AE=E5=BD=95=EF=BC=9F=
"
+
+#: builtin/log.c:1169
+#, c-format
+msgid "bogus committer info %s"
+msgstr "=E8=99=9A=E5=81=87=E7=9A=84=E6=8F=90=E4=BA=A4=E8=80=85=E4=BF=A1=
=E6=81=AF %s"
+
+#: builtin/log.c:1214
+msgid "-n and -k are mutually exclusive."
+msgstr "-n =E5=92=8C -k =E4=BA=92=E6=96=A5=E3=80=82"
+
+#: builtin/log.c:1216
+msgid "--subject-prefix and -k are mutually exclusive."
+msgstr "--subject-prefix =E5=92=8C -k =E4=BA=92=E6=96=A5=E3=80=82"
+
+#: builtin/log.c:1221 builtin/shortlog.c:284
+#, c-format
+msgid "unrecognized argument: %s"
+msgstr "=E6=9C=AA=E8=AF=86=E5=88=AB=E7=9A=84=E5=8F=82=E6=95=B0=EF=BC=9A=
%s"
+
+#: builtin/log.c:1224
+msgid "--name-only does not make sense"
+msgstr "--name-only =E6=97=A0=E6=84=8F=E4=B9=89"
+
+#: builtin/log.c:1226
+msgid "--name-status does not make sense"
+msgstr "--name-status =E6=97=A0=E6=84=8F=E4=B9=89"
+
+#: builtin/log.c:1228
+msgid "--check does not make sense"
+msgstr "--check =E6=97=A0=E6=84=8F=E4=B9=89"
+
+#: builtin/log.c:1251
+msgid "standard output, or directory, which one?"
+msgstr "=E6=A0=87=E5=87=86=E8=BE=93=E5=87=BA=E6=88=96=E7=9B=AE=E5=BD=95=
=EF=BC=8C=E5=93=AA=E4=B8=80=E4=B8=AA=EF=BC=9F"
+
+#: builtin/log.c:1253
+#, c-format
+msgid "Could not create directory '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=9B=AE=E5=BD=95 '%s'"
+
+#: builtin/log.c:1406
+msgid "Failed to create output files"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E8=BE=93=E5=87=BA=E6=96=87=
=E4=BB=B6"
+
+#: builtin/log.c:1510
+#, c-format
+msgid ""
+"Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
+msgstr "=E6=97=A0=E6=B3=95=E6=89=BE=E5=88=B0=E8=B7=9F=E8=B8=AA=E7=9A=84=
=E8=BF=9C=E7=A8=8B=E5=88=86=E6=94=AF=EF=BC=8C=E8=AF=B7=E6=89=8B=E5=B7=A5=
=E6=8F=90=E4=BE=9B <upstream>=E3=80=82\n"
+
+#: builtin/log.c:1526 builtin/log.c:1528 builtin/log.c:1540
+#, c-format
+msgid "Unknown commit %s"
+msgstr "=E6=9C=AA=E7=9F=A5=E6=8F=90=E4=BA=A4 %s"
+
+#: builtin/merge.c:91
+msgid "switch `m' requires a value"
+msgstr "=E5=BC=80=E5=85=B3 `m' =E9=9C=80=E8=A6=81=E4=B8=80=E4=B8=AA=E5=
=80=BC"
+
+#: builtin/merge.c:128
+#, c-format
+msgid "Could not find merge strategy '%s'.\n"
+msgstr "=E6=97=A0=E6=B3=95=E6=89=BE=E5=88=B0=E5=90=88=E5=B9=B6=E7=AD=96=
=E7=95=A5 '%s'=E3=80=82\n"
+
+#: builtin/merge.c:129
+#, c-format
+msgid "Available strategies are:"
+msgstr "=E5=8F=AF=E7=94=A8=E7=9A=84=E7=AD=96=E7=95=A5=E6=9C=89=EF=BC=9A=
"
+
+#: builtin/merge.c:134
+#, c-format
+msgid "Available custom strategies are:"
+msgstr "=E5=8F=AF=E7=94=A8=E7=9A=84=E8=87=AA=E5=AE=9A=E4=B9=89=E7=AD=96=
=E7=95=A5=E6=9C=89=EF=BC=9A"
+
+#: builtin/merge.c:241
+msgid "could not run stash."
+msgstr "=E4=B8=8D=E8=83=BD=E8=BF=9B=E8=A1=8C=E8=BF=9B=E5=BA=A6=E4=BF=9D=
=E5=AD=98=E3=80=82"
+
+#: builtin/merge.c:246
+msgid "stash failed"
+msgstr "=E8=BF=9B=E5=BA=A6=E4=BF=9D=E5=AD=98=E5=A4=B1=E8=B4=A5"
+
+#: builtin/merge.c:251
+#, c-format
+msgid "not a valid object: %s"
+msgstr "=E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E6=9C=89=E6=95=88=E5=AF=B9=
=E8=B1=A1=EF=BC=9A%s"
+
+#: builtin/merge.c:270 builtin/merge.c:287
+msgid "read-tree failed"
+msgstr "=E8=AF=BB=E5=8F=96=E6=A0=91=E5=A4=B1=E8=B4=A5"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: builtin/merge.c:317
+msgid " (nothing to squash)"
+msgstr " =EF=BC=88=E6=97=A0=E5=8F=AF=E5=8E=8B=E7=BC=A9=EF=BC=89"
+
+#: builtin/merge.c:330
+#, c-format
+msgid "Squash commit -- not updating HEAD\n"
+msgstr "=E5=8E=8B=E7=BC=A9=E6=8F=90=E4=BA=A4 -- =E6=9C=AA=E6=9B=B4=E6=96=
=B0 HEAD\n"
+
+#: builtin/merge.c:334 builtin/merge.c:865 builtin/merge.c:1085
+#: builtin/merge.c:1098 builtin/revert.c:327
+#, c-format
+msgid "Could not write to '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E5=86=99=E5=85=A5 '%s'"
+
+#: builtin/merge.c:362
+msgid "Writing SQUASH_MSG"
+msgstr "=E5=86=99=E5=85=A5 SQUASH_MSG"
+
+#: builtin/merge.c:364
+msgid "Finishing SQUASH_MSG"
+msgstr "=E5=AE=8C=E6=88=90 SQUASH_MSG"
+
+#: builtin/merge.c:386
+#, c-format
+msgid "No merge message -- not updating HEAD\n"
+msgstr "=E6=97=A0=E5=90=88=E5=B9=B6=E4=BF=A1=E6=81=AF -- =E6=9C=AA=E6=9B=
=B4=E6=96=B0 HEAD\n"
+
+#: builtin/merge.c:435
+#, c-format
+msgid "'%s' does not point to a commit"
+msgstr "'%s' =E6=B2=A1=E6=9C=89=E6=8C=87=E5=90=91=E4=B8=80=E4=B8=AA=E6=
=8F=90=E4=BA=A4"
+
+#: builtin/merge.c:534
+#, c-format
+msgid "Bad branch.%s.mergeoptions string: %s"
+msgstr "=E9=94=99=E7=9A=84 branch.%s.mergeoptions =E5=AD=97=E4=B8=B2=EF=
=BC=9A%s"
+
+#: builtin/merge.c:627
+msgid "git write-tree failed to write a tree"
+msgstr "git write-tree =E6=97=A0=E6=B3=95=E5=86=99=E5=85=A5=E4=B8=80=E6=
=A0=91=E5=AF=B9=E8=B1=A1"
+
+#: builtin/merge.c:677
+msgid "failed to read the cache"
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96=E7=BC=93=E5=AD=98"
+
+#: builtin/merge.c:694
+msgid "Unable to write index."
+msgstr "=E4=B8=8D=E8=83=BD=E5=86=99=E6=9A=82=E5=AD=98=E5=8C=BA=E3=80=82=
"
+
+#: builtin/merge.c:707
+msgid "Not handling anything other than two heads merge."
+msgstr "=E4=B8=8D=E8=83=BD=E5=A4=84=E7=90=86=E4=B8=A4=E4=B8=AA=E5=A4=B4=
=E5=90=88=E5=B9=B6=E4=B9=8B=E5=A4=96=E7=9A=84=E4=BB=BB=E4=BD=95=E6=93=8D=
=E4=BD=9C=E3=80=82"
+
+#: builtin/merge.c:721
+#, c-format
+msgid "Unknown option for merge-recursive: -X%s"
+msgstr "merge-recursive =E7=9A=84=E6=9C=AA=E7=9F=A5=E9=80=89=E9=A1=B9=EF=
=BC=9A-X%s"
+
+#: builtin/merge.c:735
+#, c-format
+msgid "unable to write %s"
+msgstr "=E4=B8=8D=E8=83=BD=E5=86=99 %s"
+
+#: builtin/merge.c:862 builtin/merge.c:973 builtin/merge.c:1083
+#: builtin/merge.c:1093 builtin/revert.c:325
+#, c-format
+msgid "Could not open '%s' for writing"
+msgstr "=E6=97=A0=E6=B3=95=E4=B8=BA=E5=86=99=E5=85=A5=E6=89=93=E5=BC=80=
 '%s'"
+
+#: builtin/merge.c:874
+#, c-format
+msgid "Could not read from '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E4=BB=8E '%s' =E8=AF=BB=E5=8F=96"
+
+#: builtin/merge.c:883
+#, c-format
+msgid "Not committing merge; use 'git commit' to complete the merge.\n=
"
+msgstr "=E6=9C=AA=E6=8F=90=E4=BA=A4=E5=90=88=E5=B9=B6=EF=BC=8C=E4=BD=BF=
=E7=94=A8 'git commit' =E5=AE=8C=E6=88=90=E6=AD=A4=E6=AC=A1=E5=90=88=E5=
=B9=B6=E3=80=82\n"
+
+#: builtin/merge.c:903
+msgid "Empty commit message."
+msgstr "=E7=A9=BA=E6=8F=90=E4=BA=A4=E4=BF=A1=E6=81=AF=E3=80=82"
+
+#: builtin/merge.c:915
+#, c-format
+msgid "Wonderful.\n"
+msgstr "=E5=A4=AA=E6=A3=92=E4=BA=86=E3=80=82\n"
+
+#: builtin/merge.c:988
+#, c-format
+msgid "Automatic merge failed; fix conflicts and then commit the resul=
t.\n"
+msgstr "=E8=87=AA=E5=8A=A8=E5=90=88=E5=B9=B6=E5=A4=B1=E8=B4=A5=EF=BC=8C=
=E4=BF=AE=E6=AD=A3=E5=86=B2=E7=AA=81=E7=84=B6=E5=90=8E=E6=8F=90=E4=BA=A4=
=E4=BF=AE=E6=AD=A3=E7=9A=84=E7=BB=93=E6=9E=9C=E3=80=82\n"
+
+#: builtin/merge.c:1004
+#, c-format
+msgid "'%s' is not a commit"
+msgstr "'%s' =E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E6=8F=90=E4=BA=A4"
+
+#: builtin/merge.c:1045
+msgid "No current branch."
+msgstr "=E5=BD=93=E5=89=8D=E4=B8=8D=E5=9C=A8=E5=88=86=E6=94=AF=E4=B8=8A=
=E3=80=82"
+
+#: builtin/merge.c:1047
+msgid "No remote for the current branch."
+msgstr "=E5=BD=93=E5=89=8D=E5=88=86=E6=94=AF=E6=B2=A1=E6=9C=89=E8=BF=9C=
=E7=A8=8B=E7=89=88=E6=9C=AC=E5=BA=93=E3=80=82"
+
+#: builtin/merge.c:1049
+msgid "No default upstream defined for the current branch."
+msgstr "=E5=BD=93=E5=89=8D=E5=88=86=E6=94=AF=E6=9C=AA=E5=AE=9A=E4=B9=89=
=E9=BB=98=E8=AE=A4=E4=B8=8A=E6=B8=B8=E5=88=86=E6=94=AF=E3=80=82"
+
+#: builtin/merge.c:1054
+#, c-format
+msgid "No remote tracking branch for %s from %s"
+msgstr "%s =E6=B2=A1=E6=9C=89=E6=9D=A5=E8=87=AA %s =E7=9A=84=E8=BF=9C=E7=
=A8=8B=E8=B7=9F=E8=B8=AA=E5=88=86=E6=94=AF"
+
+#: builtin/merge.c:1149
+msgid "There is no merge to abort (MERGE_HEAD missing)."
+msgstr "=E6=B2=A1=E6=9C=89=E8=A6=81=E7=BB=88=E6=AD=A2=E7=9A=84=E5=90=88=
=E5=B9=B6=EF=BC=88MERGE_HEAD =E4=B8=A2=E5=A4=B1=EF=BC=89"
+
+#: builtin/merge.c:1165 git-pull.sh:31
+msgid ""
+"You have not concluded your merge (MERGE_HEAD exists).\n"
+"Please, commit your changes before you can merge."
+msgstr ""
+"=E6=82=A8=E5=B0=9A=E6=9C=AA=E7=BB=93=E6=9D=9F=E6=82=A8=E7=9A=84=E5=90=
=88=E5=B9=B6=EF=BC=88=E5=AD=98=E5=9C=A8 MERGE_HEAD=EF=BC=89=E3=80=82\n"
+"=E8=AF=B7=E5=85=88=E6=8F=90=E4=BA=A4=E6=82=A8=E7=9A=84=E4=BF=AE=E6=94=
=B9=EF=BC=8C=E6=82=A8=E6=89=8D=E8=83=BD=E5=90=88=E5=B9=B6=E3=80=82"
+
+#: builtin/merge.c:1168 git-pull.sh:34
+msgid "You have not concluded your merge (MERGE_HEAD exists)."
+msgstr "=E6=82=A8=E5=B0=9A=E6=9C=AA=E7=BB=93=E6=9D=9F=E6=82=A8=E7=9A=84=
=E5=90=88=E5=B9=B6=EF=BC=88=E5=AD=98=E5=9C=A8 MERGE_HEAD=EF=BC=89=E3=80=
=82"
+
+#: builtin/merge.c:1172
+msgid ""
+"You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
+"Please, commit your changes before you can merge."
+msgstr ""
+"=E6=82=A8=E5=B0=9A=E6=9C=AA=E7=BB=93=E6=9D=9F=E6=82=A8=E7=9A=84=E6=8B=
=A3=E9=80=89=EF=BC=88=E5=AD=98=E5=9C=A8 CHERRY_PICK_HEAD=EF=BC=89=E3=80=
=82\n"
+"=E8=AF=B7=E5=85=88=E6=8F=90=E4=BA=A4=E6=82=A8=E7=9A=84=E4=BF=AE=E6=94=
=B9=EF=BC=8C=E6=82=A8=E6=89=8D=E8=83=BD=E5=90=88=E5=B9=B6=E3=80=82"
+
+#: builtin/merge.c:1175
+msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
+msgstr "=E6=82=A8=E5=B0=9A=E6=9C=AA=E7=BB=93=E6=9D=9F=E6=82=A8=E7=9A=84=
=E6=8B=A3=E9=80=89=EF=BC=88=E5=AD=98=E5=9C=A8 CHERRY_PICK_HEAD=EF=BC=89=
=E3=80=82"
+
+#: builtin/merge.c:1184
+msgid "You cannot combine --squash with --no-ff."
+msgstr "=E6=82=A8=E4=B8=8D=E8=83=BD=E5=B0=86 --squash =E4=B8=8E --no-f=
f =E5=85=B1=E7=94=A8=E3=80=82"
+
+#: builtin/merge.c:1189
+msgid "You cannot combine --no-ff with --ff-only."
+msgstr "=E6=82=A8=E4=B8=8D=E8=83=BD=E5=B0=86 --no-ff =E4=B8=8E --ff-on=
ly =E5=85=B1=E7=94=A8=E3=80=82"
+
+#: builtin/merge.c:1196
+msgid "No commit specified and merge.defaultToUpstream not set."
+msgstr "=E6=9C=AA=E6=8C=87=E5=87=BA=E6=8F=90=E4=BA=A4=E5=B9=B6=E4=B8=94=
 merge.defaultToUpstream =E6=9C=AA=E8=AE=BE=E7=BD=AE=E3=80=82"
+
+#: builtin/merge.c:1227
+msgid "Can merge only exactly one commit into empty head"
+msgstr "=E5=8F=AA=E5=8F=AF=E5=B0=86=E4=B8=80=E4=B8=AA=E6=8F=90=E4=BA=A4=
=E5=90=88=E5=B9=B6=E5=88=B0=E7=A9=BA=E5=88=86=E6=94=AF=E4=B8=8A"
+
+#: builtin/merge.c:1230
+msgid "Squash commit into empty head not supported yet"
+msgstr "=E5=B0=9A=E4=B8=8D=E6=94=AF=E6=8C=81=E5=88=B0=E7=A9=BA=E5=88=86=
=E6=94=AF=E7=9A=84=E5=8E=8B=E7=BC=A9=E6=8F=90=E4=BA=A4"
+
+#: builtin/merge.c:1232
+msgid "Non-fast-forward commit does not make sense into an empty head"
+msgstr "=E5=88=B0=E7=A9=BA=E5=88=86=E6=94=AF=E7=9A=84=E9=9D=9E=E5=BF=AB=
=E8=BF=9B=E5=BC=8F=E6=8F=90=E4=BA=A4=E6=B2=A1=E6=9C=89=E6=84=8F=E4=B9=89=
"
+
+#: builtin/merge.c:1236 builtin/merge.c:1280
+#, c-format
+msgid "%s - not something we can merge"
+msgstr "%s - =E4=B8=8D=E6=98=AF=E6=88=91=E4=BB=AC=E5=8F=AF=E4=BB=A5=E5=
=90=88=E5=B9=B6=E7=9A=84=E4=B8=9C=E8=A5=BF"
+
+#: builtin/merge.c:1341
+#, c-format
+msgid "Updating %s..%s\n"
+msgstr "=E6=9B=B4=E6=96=B0 %s..%s\n"
+
+#: builtin/merge.c:1379
+#, c-format
+msgid "Trying really trivial in-index merge...\n"
+msgstr "=E5=B0=9D=E8=AF=95=E9=9D=9E=E5=B8=B8=E5=B0=8F=E7=9A=84=E6=9A=82=
=E5=AD=98=E5=8C=BA=E5=86=85=E5=90=88=E5=B9=B6...\n"
+
+#: builtin/merge.c:1386
+#, c-format
+msgid "Nope.\n"
+msgstr "=E6=97=A0=E3=80=82\n"
+
+#: builtin/merge.c:1418
+msgid "Not possible to fast-forward, aborting."
+msgstr "=E4=B8=8D=E5=8F=AF=E8=83=BD=E5=BF=AB=E8=BF=9B=E5=BC=8F=EF=BC=8C=
=E7=BB=88=E6=AD=A2=E3=80=82"
+
+#: builtin/merge.c:1441 builtin/merge.c:1518
+#, c-format
+msgid "Rewinding the tree to pristine...\n"
+msgstr "=E5=B0=86=E6=A0=91=E5=9B=9E=E6=BB=9A=E8=87=B3=E5=8E=9F=E5=A7=8B=
=E7=8A=B6=E6=80=81...\n"
+
+#: builtin/merge.c:1445
+#, c-format
+msgid "Trying merge strategy %s...\n"
+msgstr "=E5=B0=9D=E8=AF=95=E5=90=88=E5=B9=B6=E7=AD=96=E7=95=A5 %s...\n=
"
+
+#: builtin/merge.c:1509
+#, c-format
+msgid "No merge strategy handled the merge.\n"
+msgstr "=E6=B2=A1=E6=9C=89=E5=90=88=E5=B9=B6=E7=AD=96=E7=95=A5=E5=A4=84=
=E7=90=86=E6=AD=A4=E5=90=88=E5=B9=B6=E3=80=82\n"
+
+#: builtin/merge.c:1511
+#, c-format
+msgid "Merge with strategy %s failed.\n"
+msgstr "=E4=BD=BF=E7=94=A8=E7=AD=96=E7=95=A5 %s =E5=90=88=E5=B9=B6=E5=A4=
=B1=E8=B4=A5=E3=80=82\n"
+
+#: builtin/merge.c:1520
+#, c-format
+msgid "Using the %s to prepare resolving by hand.\n"
+msgstr "=E4=BD=BF=E7=94=A8 %s =E4=BB=A5=E5=87=86=E5=A4=87=E6=89=8B=E5=B7=
=A5=E8=A7=A3=E5=86=B3=E3=80=82\n"
+
+#: builtin/merge.c:1531
+#, c-format
+msgid "Automatic merge went well; stopped before committing as request=
ed\n"
+msgstr "=E8=87=AA=E5=8A=A8=E5=90=88=E5=B9=B6=E8=BF=9B=E5=B1=95=E9=A1=BA=
=E5=88=A9=EF=BC=8C=E6=8C=89=E8=A6=81=E6=B1=82=E5=9C=A8=E6=8F=90=E4=BA=A4=
=E5=89=8D=E5=81=9C=E6=AD=A2\n"
+
+#: builtin/mv.c:108
+#, c-format
+msgid "Checking rename of '%s' to '%s'\n"
+msgstr "=E6=A3=80=E6=9F=A5 '%s' =E5=88=B0 '%s' =E7=9A=84=E9=87=8D=E5=91=
=BD=E5=90=8D\n"
+
+#: builtin/mv.c:112
+msgid "bad source"
+msgstr "=E5=9D=8F=E7=9A=84=E6=BA=90"
+
+#: builtin/mv.c:115
+msgid "can not move directory into itself"
+msgstr "=E4=B8=8D=E8=83=BD=E5=B0=86=E7=9B=AE=E5=BD=95=E7=A7=BB=E5=8A=A8=
=E5=88=B0=E8=87=AA=E8=BA=AB"
+
+#: builtin/mv.c:118
+msgid "cannot move directory over file"
+msgstr "=E4=B8=8D=E8=83=BD=E5=B0=86=E7=9B=AE=E5=BD=95=E7=A7=BB=E5=8A=A8=
=E5=88=B0=E6=96=87=E4=BB=B6"
+
+#: builtin/mv.c:128
+#, c-format
+msgid "Huh? %.*s is in index?"
+msgstr "=E5=97=AF=EF=BC=9F%.*s =E5=9C=A8=E6=9A=82=E5=AD=98=E5=8C=BA=E4=
=B8=AD=EF=BC=9F"
+
+#: builtin/mv.c:140
+msgid "source directory is empty"
+msgstr "=E6=BA=90=E7=9B=AE=E5=BD=95=E4=B8=BA=E7=A9=BA"
+
+#: builtin/mv.c:171
+msgid "not under version control"
+msgstr "=E4=B8=8D=E5=9C=A8=E7=89=88=E6=9C=AC=E6=8E=A7=E5=88=B6=E4=B9=8B=
=E4=B8=8B"
+
+#: builtin/mv.c:173
+msgid "destination exists"
+msgstr "=E7=9B=AE=E6=A0=87=E5=B7=B2=E5=AD=98=E5=9C=A8"
+
+#: builtin/mv.c:181
+#, c-format
+msgid "overwriting '%s'"
+msgstr "=E8=A6=86=E7=9B=96 '%s'"
+
+#: builtin/mv.c:184
+msgid "Cannot overwrite"
+msgstr "=E4=B8=8D=E8=83=BD=E8=A6=86=E7=9B=96"
+
+#: builtin/mv.c:187
+msgid "multiple sources for the same target"
+msgstr "=E5=90=8C=E4=B8=80=E7=9B=AE=E6=A0=87=E5=85=B7=E6=9C=89=E5=A4=9A=
=E4=B8=AA=E6=BA=90"
+
+#: builtin/mv.c:202
+#, c-format
+msgid "%s, source=3D%s, destination=3D%s"
+msgstr "%s=EF=BC=8C=E6=BA=90=3D%s=EF=BC=8C=E7=9B=AE=E6=A0=87=3D%s"
+
+#: builtin/mv.c:212
+#, c-format
+msgid "Renaming %s to %s\n"
+msgstr "=E9=87=8D=E5=91=BD=E5=90=8D %s =E8=87=B3 %s\n"
+
+#: builtin/mv.c:215
+#, c-format
+msgid "renaming '%s' failed"
+msgstr "=E9=87=8D=E5=91=BD=E5=90=8D '%s' =E5=A4=B1=E8=B4=A5"
+
+#: builtin/notes.c:139
+#, c-format
+msgid "unable to start 'show' for object '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E4=B8=BA=E5=AF=B9=E8=B1=A1 '%s' =E5=BC=80=E5=
=A7=8B 'show'"
+
+#: builtin/notes.c:145
+msgid "can't fdopen 'show' output fd"
+msgstr "=E4=B8=8D=E8=83=BD=E6=89=93=E5=BC=80 'show' =E8=BE=93=E5=87=BA=
=E6=96=87=E4=BB=B6=E5=8F=A5=E6=9F=84"
+
+#: builtin/notes.c:155
+#, c-format
+msgid "failed to close pipe to 'show' for object '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E4=B8=BA=E5=AF=B9=E8=B1=A1 '%s' =E7=9A=84 '=
show' =E5=85=B3=E9=97=AD=E7=AE=A1=E9=81=93"
+
+#: builtin/notes.c:158
+#, c-format
+msgid "failed to finish 'show' for object '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E4=B8=BA=E5=AF=B9=E8=B1=A1 '%s' =E5=AE=8C=E6=
=88=90 'show'"
+
+#: builtin/notes.c:175 builtin/tag.c:310
+#, c-format
+msgid "could not create file '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E5=88=9B=E5=BB=BA=E6=96=87=E4=BB=B6 '%s'"
+
+#: builtin/notes.c:189
+msgid "Please supply the note contents using either -m or -F option"
+msgstr "=E8=AF=B7=E9=80=9A=E8=BF=87 -m =E6=88=96 -F =E9=80=89=E9=A1=B9=
=E4=B8=BA=E6=B3=A8=E8=A7=A3=E6=8F=90=E4=BE=9B=E5=86=85=E5=AE=B9"
+
+#: builtin/notes.c:210 builtin/notes.c:973
+#, c-format
+msgid "Removing note for object %s\n"
+msgstr "=E5=88=A0=E9=99=A4=E5=AF=B9=E8=B1=A1 %s =E7=9A=84=E6=B3=A8=E8=A7=
=A3\n"
+
+#: builtin/notes.c:215
+msgid "unable to write note object"
+msgstr "=E4=B8=8D=E8=83=BD=E5=86=99=E6=B3=A8=E8=A7=A3=E5=AF=B9=E8=B1=A1=
"
+
+#: builtin/notes.c:217
+#, c-format
+msgid "The note contents has been left in %s"
+msgstr "=E6=B3=A8=E8=A7=A3=E5=86=85=E5=AE=B9=E8=A2=AB=E7=95=99=E5=9C=A8=
=E6=96=87=E4=BB=B6 %s =E4=B8=AD"
+
+#: builtin/notes.c:251 builtin/tag.c:465
+#, c-format
+msgid "cannot read '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E8=AF=BB=E5=8F=96 '%s'"
+
+#: builtin/notes.c:253 builtin/tag.c:468
+#, c-format
+msgid "could not open or read '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E6=89=93=E5=BC=80=E6=88=96=E8=AF=BB=E5=8F=96=
 '%s'"
+
+#: builtin/notes.c:272 builtin/notes.c:445 builtin/notes.c:447
+#: builtin/notes.c:507 builtin/notes.c:561 builtin/notes.c:644
+#: builtin/notes.c:649 builtin/notes.c:724 builtin/notes.c:766
+#: builtin/notes.c:968 builtin/reset.c:293 builtin/tag.c:481
+#, c-format
+msgid "Failed to resolve '%s' as a valid ref."
+msgstr "=E6=97=A0=E6=B3=95=E8=A7=A3=E6=9E=90 '%s' =E4=B8=BA=E4=B8=80=E4=
=B8=AA=E6=9C=89=E6=95=88=E5=BC=95=E7=94=A8"
+
+#: builtin/notes.c:275
+#, c-format
+msgid "Failed to read object '%s'."
+msgstr "=E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96=E5=AF=B9=E8=B1=A1 '%s'=E3=
=80=82"
+
+#: builtin/notes.c:299
+msgid "Cannot commit uninitialized/unreferenced notes tree"
+msgstr "=E4=B8=8D=E8=83=BD=E6=8F=90=E4=BA=A4=E6=9C=AA=E5=88=9D=E5=A7=8B=
=E5=8C=96/=E6=9C=AA=E5=BC=95=E7=94=A8=E7=9A=84=E6=B3=A8=E8=A7=A3=E6=A0=91=
"
+
+#: builtin/notes.c:340
+#, c-format
+msgid "Bad notes.rewriteMode value: '%s'"
+msgstr "=E9=94=99=E8=AF=AF=E7=9A=84 notes.rewriteMode =E5=80=BC=EF=BC=9A=
'%s'"
+
+#: builtin/notes.c:350
+#, c-format
+msgid "Refusing to rewrite notes in %s (outside of refs/notes/)"
+msgstr "=E6=8B=92=E7=BB=9D=E5=90=91 %s=EF=BC=88=E5=9C=A8 refs/notes/ =E4=
=B9=8B=E5=A4=96=EF=BC=89=E5=86=99=E5=85=A5=E6=B3=A8=E8=A7=A3"
+
+#. TRANSLATORS: The first %s is the name of the
+#. environment variable, the second %s is its value
+#: builtin/notes.c:377
+#, c-format
+msgid "Bad %s value: '%s'"
+msgstr "=E9=94=99=E8=AF=AF=E7=9A=84 %s =E5=80=BC=EF=BC=9A'%s'"
+
+#: builtin/notes.c:441
+#, c-format
+msgid "Malformed input line: '%s'."
+msgstr "=E9=9D=9E=E6=B3=95=E7=9A=84=E8=BE=93=E5=85=A5=E8=A1=8C=EF=BC=9A=
'%s'=E3=80=82"
+
+#: builtin/notes.c:456
+#, c-format
+msgid "Failed to copy notes from '%s' to '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E4=BB=8E '%s' =E6=8B=B7=E8=B4=9D=E6=B3=A8=E8=
=A7=A3=E5=88=B0 '%s'"
+
+#: builtin/notes.c:500 builtin/notes.c:554 builtin/notes.c:627
+#: builtin/notes.c:639 builtin/notes.c:712 builtin/notes.c:759
+#: builtin/notes.c:1033
+msgid "too many parameters"
+msgstr "=E5=8F=82=E6=95=B0=E5=A4=AA=E5=A4=9A"
+
+#: builtin/notes.c:513 builtin/notes.c:772
+#, c-format
+msgid "No note found for object %s."
+msgstr "=E6=9C=AA=E5=8F=91=E7=8E=B0=E5=AF=B9=E8=B1=A1 %s =E7=9A=84=E6=B3=
=A8=E8=A7=A3=E3=80=82"
+
+#: builtin/notes.c:580
+#, c-format
+msgid ""
+"Cannot add notes. Found existing notes for object %s. Use '-f' to ove=
rwrite "
+"existing notes"
+msgstr "=E4=B8=8D=E8=83=BD=E6=B7=BB=E5=8A=A0=E6=B3=A8=E8=A7=A3=E3=80=82=
=E5=8F=91=E7=8E=B0=E5=AF=B9=E8=B1=A1 %s =E5=B7=B2=E5=AD=98=E5=9C=A8=E6=B3=
=A8=E8=A7=A3=E3=80=82=E4=BD=BF=E7=94=A8 '-f' =E8=A6=86=E7=9B=96=E7=8E=B0=
=E5=AD=98=E6=B3=A8=E8=A7=A3"
+
+#: builtin/notes.c:585 builtin/notes.c:662
+#, c-format
+msgid "Overwriting existing notes for object %s\n"
+msgstr "=E8=A6=86=E7=9B=96=E5=AF=B9=E8=B1=A1 %s =E7=8E=B0=E5=AD=98=E6=B3=
=A8=E8=A7=A3\n"
+
+#: builtin/notes.c:635
+msgid "too few parameters"
+msgstr "=E5=8F=82=E6=95=B0=E5=A4=AA=E5=B0=91"
+
+#: builtin/notes.c:656
+#, c-format
+msgid ""
+"Cannot copy notes. Found existing notes for object %s. Use '-f' to ov=
erwrite "
+"existing notes"
+msgstr "=E4=B8=8D=E8=83=BD=E6=8B=B7=E8=B4=9D=E6=B3=A8=E8=A7=A3=E3=80=82=
=E5=8F=91=E7=8E=B0=E5=AF=B9=E8=B1=A1 %s =E5=B7=B2=E5=AD=98=E5=9C=A8=E6=B3=
=A8=E8=A7=A3=E3=80=82=E4=BD=BF=E7=94=A8 '-f' =E8=A6=86=E7=9B=96=E7=8E=B0=
=E5=AD=98=E6=B3=A8=E8=A7=A3"
+
+#: builtin/notes.c:668
+#, c-format
+msgid "Missing notes on source object %s. Cannot copy."
+msgstr "=E6=BA=90=E5=AF=B9=E8=B1=A1 %s =E7=BC=BA=E5=B0=91=E6=B3=A8=E8=A7=
=A3=E3=80=82=E4=B8=8D=E8=83=BD=E6=8B=B7=E8=B4=9D=E3=80=82"
+
+#: builtin/notes.c:717
+#, c-format
+msgid ""
+"The -m/-F/-c/-C options have been deprecated for the 'edit' subcomman=
d.\n"
+"Please use 'git notes add -f -m/-F/-c/-C' instead.\n"
+msgstr ""
+"=E9=80=89=E9=A1=B9 -m/-F/-c/-C =E5=B7=B2=E4=B8=BA 'edit' =E5=AD=90=E5=
=91=BD=E4=BB=A4=E5=BA=9F=E5=BC=83=E3=80=82\n"
+"=E8=AF=B7=E6=8D=A2=E7=94=A8 'git notes add -f -m/-F/-c/-C'=E3=80=82\n=
"
+
+#: builtin/notes.c:971
+#, c-format
+msgid "Object %s has no note\n"
+msgstr "=E5=AF=B9=E8=B1=A1 %s =E6=B2=A1=E6=9C=89=E6=B3=A8=E8=A7=A3\n"
+
+#: builtin/notes.c:1103
+#, c-format
+msgid "Unknown subcommand: %s"
+msgstr "=E6=9C=AA=E7=9F=A5=E5=AD=90=E5=91=BD=E4=BB=A4=EF=BC=9A%s"
+
+#: builtin/push.c:44
+msgid "tag shorthand without <tag>"
+msgstr "tag =E7=AE=80=E5=86=99=E6=B2=A1=E6=9C=89=E8=B7=9F <tag> =E5=8F=
=82=E6=95=B0"
+
+#: builtin/push.c:63
+msgid "--delete only accepts plain target ref names"
+msgstr "--delete =E5=8F=AA=E6=8E=A5=E5=8F=97=E7=AE=80=E5=8D=95=E7=9A=84=
=E5=BC=95=E7=94=A8=E5=90=8D=E7=A7=B0"
+
+#: builtin/push.c:73
+#, c-format
+msgid ""
+"You are not currently on a branch.\n"
+"To push the history leading to the current (detached HEAD)\n"
+"state now, use\n"
+"\n"
+"    git push %s HEAD:<name-of-remote-branch>\n"
+msgstr ""
+"=E6=82=A8=E5=BD=93=E5=89=8D=E4=B8=8D=E5=9C=A8=E4=B8=80=E4=B8=AA=E5=88=
=86=E6=94=AF=E4=B8=8A=E3=80=82\n"
+"=E7=8E=B0=E5=9C=A8=E4=B8=BA=E6=8E=A8=E9=80=81=E5=BD=93=E5=89=8D=E5=8E=
=86=E5=8F=B2=EF=BC=88=E5=88=86=E7=A6=BB=E5=A4=B4=E6=8C=87=E9=92=88=EF=BC=
=89=EF=BC=8C=E4=BD=BF=E7=94=A8\n"
+"\n"
+"    git push %s HEAD:<name-of-remote-branch>\n"
+
+#: builtin/push.c:80
+#, c-format
+msgid ""
+"The current branch %s has no upstream branch.\n"
+"To push the current branch and set the remote as upstream, use\n"
+"\n"
+"    git push --set-upstream %s %s\n"
+msgstr ""
+"=E5=BD=93=E5=89=8D=E5=88=86=E6=94=AF %s =E6=B2=A1=E6=9C=89=E5=AF=B9=E5=
=BA=94=E7=9A=84=E4=B8=8A=E6=B8=B8=E5=88=86=E6=94=AF=E3=80=82\n"
+"=E4=B8=BA=E6=8E=A8=E9=80=81=E5=BD=93=E5=89=8D=E5=88=86=E6=94=AF=E5=B9=
=B6=E5=BB=BA=E7=AB=8B=E4=B8=8E=E8=BF=9C=E7=A8=8B=E4=B8=8A=E6=B8=B8=E7=9A=
=84=E8=B7=9F=E8=B8=AA=EF=BC=8C=E4=BD=BF=E7=94=A8\n"
+"\n"
+"    git push --set-upstream %s %s\n"
+
+#: builtin/push.c:88
+#, c-format
+msgid "The current branch %s has multiple upstream branches, refusing =
to push."
+msgstr "=E5=BD=93=E5=89=8D=E5=88=86=E6=94=AF %s =E6=9C=89=E5=A4=9A=E4=B8=
=AA=E4=B8=8A=E6=B8=B8=E5=88=86=E6=94=AF=EF=BC=8C=E6=8B=92=E7=BB=9D=E6=8E=
=A8=E9=80=81=E3=80=82"
+
+#: builtin/push.c:111
+msgid ""
+"You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
+msgstr "=E6=82=A8=E6=B2=A1=E6=9C=89=E4=B8=BA=E6=8E=A8=E9=80=81=E6=8F=90=
=E4=BE=9B=E4=BB=BB=E4=BD=95=E5=BC=95=E7=94=A8=E8=A1=A8=E8=BE=BE=E5=BC=8F=
=EF=BC=8C=E5=B9=B6=E4=B8=94 push.default =E4=B8=BA \"nothing\"=E3=80=82=
"
+
+#: builtin/push.c:131
+#, c-format
+msgid "Pushing to %s\n"
+msgstr "=E6=8E=A8=E9=80=81=E5=88=B0 %s\n"
+
+#: builtin/push.c:135
+#, c-format
+msgid "failed to push some refs to '%s'"
+msgstr "=E6=97=A0=E6=B3=95=E6=8E=A8=E9=80=81=E4=B8=80=E4=BA=9B=E5=BC=95=
=E7=94=A8=E5=88=B0 '%s'"
+
+#: builtin/push.c:143
+#, c-format
+msgid ""
+"To prevent you from losing history, non-fast-forward updates were rej=
ected\n"
+"Merge the remote changes (e.g. 'git pull') before pushing again.  See=
 the\n"
+"'Note about fast-forwards' section of 'git push --help' for details.\=
n"
+msgstr ""
+"=E4=B8=BA=E9=98=B2=E6=AD=A2=E6=82=A8=E4=B8=A2=E5=A4=B1=E6=8F=90=E4=BA=
=A4=E5=8E=86=E5=8F=B2=EF=BC=8C=E7=A6=81=E6=AD=A2=E9=9D=9E=E5=BF=AB=E8=BF=
=9B=E5=BC=8F=E6=8E=A8=E9=80=81=E3=80=82\n"
+"=E5=86=8D=E6=AC=A1=E6=8E=A8=E9=80=81=E5=89=8D=E5=85=88=E4=B8=8E=E8=BF=
=9C=E7=A8=8B=E5=8F=98=E6=9B=B4=E5=90=88=E5=B9=B6=EF=BC=88=E5=A6=82 'git=
 pull'=EF=BC=89=E3=80=82=E8=AF=A6=E8=A7=81\n"
+"'git push --help' =E4=B8=AD=E7=9A=84 'Note about fast-forwards' =E5=B0=
=8F=E8=8A=82=E3=80=82\n"
+
+#: builtin/push.c:160
+#, c-format
+msgid "bad repository '%s'"
+msgstr "=E9=94=99=E8=AF=AF=E7=9A=84=E7=89=88=E6=9C=AC=E5=BA=93 '%s'"
+
+#: builtin/push.c:161
+msgid ""
+"No configured push destination.\n"
+"Either specify the URL from the command-line or configure a remote "
+"repository using\n"
+"\n"
+"    git remote add <name> <url>\n"
+"\n"
+"and then push using the remote name\n"
+"\n"
+"    git push <name>\n"
+msgstr ""
+"=E6=9C=AA=E9=85=8D=E7=BD=AE=E6=8E=A8=E9=80=81=E7=9B=AE=E6=A0=87=E3=80=
=82\n"
+"=E6=88=96=E8=80=85=E9=80=9A=E8=BF=87=E5=91=BD=E4=BB=A4=E8=A1=8C=E6=8F=
=90=E4=BE=9BURL=EF=BC=8C=E6=88=96=E8=80=85=E7=94=A8=E4=B8=8B=E9=9D=A2=E5=
=91=BD=E4=BB=A4=E9=85=8D=E7=BD=AE=E4=B8=80=E4=B8=AA=E8=BF=9C=E7=A8=8B=E7=
=89=88=E6=9C=AC=E5=BA=93\n"
+"\n"
+"    git remote add <name> <url>\n"
+"\n"
+"=E7=84=B6=E5=90=8E=E4=BD=BF=E7=94=A8=E8=AF=A5=E8=BF=9C=E7=A8=8B=E7=89=
=88=E6=9C=AC=E5=BA=93=E5=90=8D=E6=89=A7=E8=A1=8C=E6=8E=A8=E9=80=81\n"
+"\n"
+"    git push <name>\n"
+
+#: builtin/push.c:176
+msgid "--all and --tags are incompatible"
+msgstr "--all =E5=92=8C --tags =E4=B8=8D=E5=85=BC=E5=AE=B9"
+
+#: builtin/push.c:177
+msgid "--all can't be combined with refspecs"
+msgstr "--all =E4=B8=8D=E8=83=BD=E5=92=8C=E5=BC=95=E7=94=A8=E8=A1=A8=E8=
=BE=BE=E5=BC=8F=E5=85=B1=E7=94=A8"
+
+#: builtin/push.c:182
+msgid "--mirror and --tags are incompatible"
+msgstr "--mirror =E5=92=8C --tags =E4=B8=8D=E5=85=BC=E5=AE=B9"
+
+#: builtin/push.c:183
+msgid "--mirror can't be combined with refspecs"
+msgstr "--mirror =E4=B8=8D=E8=83=BD=E5=92=8C=E5=BC=95=E7=94=A8=E8=A1=A8=
=E8=BE=BE=E5=BC=8F=E5=85=B1=E7=94=A8"
+
+#: builtin/push.c:188
+msgid "--all and --mirror are incompatible"
+msgstr "--all =E5=92=8C --mirror =E4=B8=8D=E5=85=BC=E5=AE=B9"
+
+#: builtin/push.c:272
+msgid "--delete is incompatible with --all, --mirror and --tags"
+msgstr "--delete =E4=B8=8E --all=E3=80=81--mirror =E5=8F=8A --tags =E4=
=B8=8D=E5=85=BC=E5=AE=B9"
+
+#: builtin/push.c:274
+msgid "--delete doesn't make sense without any refs"
+msgstr "--delete =E6=9C=AA=E6=8E=A5=E4=BB=BB=E4=BD=95=E5=BC=95=E7=94=A8=
=E6=B2=A1=E6=9C=89=E6=84=8F=E4=B9=89"
+
+#: builtin/reset.c:33
+msgid "mixed"
+msgstr "=E6=B7=B7=E6=9D=82"
+
+#: builtin/reset.c:33
+msgid "soft"
+msgstr "=E8=BD=AF=E6=80=A7"
+
+#: builtin/reset.c:33
+msgid "hard"
+msgstr "=E7=A1=AC=E6=80=A7"
+
+#: builtin/reset.c:33
+msgid "keep"
+msgstr "=E4=BF=9D=E6=8C=81"
+
+#: builtin/reset.c:77
+msgid "You do not have a valid HEAD."
+msgstr "=E6=82=A8=E6=B2=A1=E6=9C=89=E4=B8=80=E4=B8=AA=E6=9C=89=E6=95=88=
=E7=9A=84 HEAD=E3=80=82"
+
+#: builtin/reset.c:79
+msgid "Failed to find tree of HEAD."
+msgstr "=E6=97=A0=E6=B3=95=E6=89=BE=E5=88=B0 HEAD =E6=8C=87=E5=90=91=E7=
=9A=84=E6=A0=91=E3=80=82"
+
+#: builtin/reset.c:85
+#, c-format
+msgid "Failed to find tree of %s."
+msgstr "=E6=97=A0=E6=B3=95=E6=89=BE=E5=88=B0 %s =E6=8C=87=E5=90=91=E7=9A=
=84=E6=A0=91=E3=80=82"
+
+#: builtin/reset.c:96
+msgid "Could not write new index file."
+msgstr "=E6=97=A0=E6=B3=95=E5=86=99=E5=85=A5=E6=96=B0=E7=9A=84=E6=9A=82=
=E5=AD=98=E5=8C=BA=E6=96=87=E4=BB=B6=E3=80=82"
+
+#: builtin/reset.c:106
+#, c-format
+msgid "HEAD is now at %s"
+msgstr "HEAD =E7=8E=B0=E5=9C=A8=E4=BD=8D=E4=BA=8E %s"
+
+#: builtin/reset.c:130
+msgid "Could not read index"
+msgstr "=E4=B8=8D=E8=83=BD=E8=AF=BB=E5=8F=96=E6=9A=82=E5=AD=98=E5=8C=BA=
"
+
+#: builtin/reset.c:133
+msgid "Unstaged changes after reset:"
+msgstr "=E9=87=8D=E7=BD=AE=E5=90=8E=E5=8F=98=E6=9B=B4=E6=92=A4=E5=87=BA=
=E6=9A=82=E5=AD=98=E5=8C=BA=EF=BC=9A"
+
+#  =E6=B1=89=E5=AD=97=E4=B9=8B=E9=97=B4=E6=97=A0=E7=A9=BA=E6=A0=BC=EF=BC=
=8C=E6=95=85=E5=88=A0=E9=99=A4%s=E5=89=8D=E5=90=8E=E7=A9=BA=E6=A0=BC
+#: builtin/reset.c:223
+#, c-format
+msgid "Cannot do a %s reset in the middle of a merge."
+msgstr "=E5=9C=A8=E5=90=88=E5=B9=B6=E8=BF=87=E7=A8=8B=E4=B8=AD=E4=B8=8D=
=E8=83=BD=E5=81=9A%s=E9=87=8D=E7=BD=AE=E6=93=8D=E4=BD=9C=E3=80=82"
+
+#: builtin/reset.c:297
+#, c-format
+msgid "Could not parse object '%s'."
+msgstr "=E4=B8=8D=E8=83=BD=E8=A7=A3=E6=9E=90=E5=AF=B9=E8=B1=A1 '%s'=E3=
=80=82"
+
+#: builtin/reset.c:302
+msgid "--patch is incompatible with --{hard,mixed,soft}"
+msgstr "--patch =E4=B8=8E --{hard,mixed,soft} =E4=B8=8D=E5=85=BC=E5=AE=
=B9"
+
+#: builtin/reset.c:311
+msgid "--mixed with paths is deprecated; use 'git reset -- <paths>' in=
stead."
+msgstr "--mixed =E5=B8=A6=E8=B7=AF=E5=BE=84=E5=B7=B2=E5=BC=83=E7=94=A8=
=EF=BC=8C=E4=BB=A3=E4=B9=8B=E4=BB=A5 'git reset -- <paths>'=E3=80=82"
+
+#  =E6=B1=89=E5=AD=97=E4=B9=8B=E9=97=B4=E6=97=A0=E7=A9=BA=E6=A0=BC=EF=BC=
=8C=E6=95=85=E5=88=A0=E9=99=A4%s=E5=89=8D=E5=90=8E=E7=A9=BA=E6=A0=BC
+#: builtin/reset.c:313
+#, c-format
+msgid "Cannot do %s reset with paths."
+msgstr "=E4=B8=8D=E8=83=BD=E5=B8=A6=E8=B7=AF=E5=BE=84=E8=BF=9B=E8=A1=8C=
%s=E9=87=8D=E7=BD=AE=E3=80=82"
+
+#  =E6=B1=89=E5=AD=97=E4=B9=8B=E9=97=B4=E6=97=A0=E7=A9=BA=E6=A0=BC=EF=BC=
=8C=E6=95=85=E5=88=A0=E9=99=A4%s=E5=89=8D=E5=90=8E=E7=A9=BA=E6=A0=BC
+#: builtin/reset.c:325
+#, c-format
+msgid "%s reset is not allowed in a bare repository"
+msgstr "=E4=B8=8D=E8=83=BD=E5=AF=B9=E8=A3=B8=E7=89=88=E6=9C=AC=E5=BA=93=
=E8=BF=9B=E8=A1=8C%s=E9=87=8D=E7=BD=AE"
+
+#: builtin/reset.c:341
+#, c-format
+msgid "Could not reset index file to revision '%s'."
+msgstr "=E4=B8=8D=E8=83=BD=E9=87=8D=E7=BD=AE=E6=9A=82=E5=AD=98=E5=8C=BA=
=E8=87=B3=E7=89=88=E6=9C=AC '%s'=E3=80=82"
+
+#: builtin/revert.c:114 builtin/revert.c:135
+#, c-format
+msgid "%s: %s cannot be used with %s"
+msgstr "%s: %s =E4=B8=8D=E8=83=BD=E5=92=8C %s =E5=85=B1=E7=94=A8"
+
+#: builtin/revert.c:170
+msgid "program error"
+msgstr "=E7=A8=8B=E5=BA=8F=E9=94=99=E8=AF=AF"
+
+#: builtin/revert.c:360 builtin/revert.c:886 builtin/revert.c:969
+#, c-format
+msgid "Could not write to %s"
+msgstr "=E4=B8=8D=E8=83=BD=E5=86=99=E5=85=A5 %s"
+
+#: builtin/revert.c:363
+#, c-format
+msgid "Error wrapping up %s"
+msgstr "=E9=94=99=E8=AF=AF=E6=94=B6=E5=B0=BE %s"
+
+#: builtin/revert.c:378
+msgid "Your local changes would be overwritten by cherry-pick."
+msgstr "=E6=82=A8=E7=9A=84=E6=9C=AC=E5=9C=B0=E4=BF=AE=E6=94=B9=E5=B0=86=
=E8=A2=AB=E6=8B=A3=E9=80=89=E6=93=8D=E4=BD=9C=E8=A6=86=E7=9B=96=E3=80=82=
"
+
+#: builtin/revert.c:380
+msgid "Your local changes would be overwritten by revert."
+msgstr "=E6=82=A8=E7=9A=84=E6=9C=AC=E5=9C=B0=E4=BF=AE=E6=94=B9=E5=B0=86=
=E8=A2=AB=E8=BF=98=E5=8E=9F=E6=93=8D=E4=BD=9C=E8=A6=86=E7=9B=96=E3=80=82=
"
+
+#: builtin/revert.c:383
+msgid "Commit your changes or stash them to proceed."
+msgstr "=E6=8F=90=E4=BA=A4=E6=82=A8=E7=9A=84=E4=BF=AE=E6=94=B9=E6=88=96=
=E4=BF=9D=E5=AD=98=E8=BF=9B=E5=BA=A6=E5=90=8E=E5=86=8D=E7=BB=A7=E7=BB=AD=
=E3=80=82"
+
+#. TRANSLATORS: %s will be "revert" or "cherry-pick"
+#: builtin/revert.c:433
+#, c-format
+msgid "%s: Unable to write new index file"
+msgstr "%s=EF=BC=9A=E6=97=A0=E6=B3=95=E5=86=99=E5=85=A5=E6=96=B0=E6=9A=
=82=E5=AD=98=E5=8C=BA=E6=96=87=E4=BB=B6"
+
+#: builtin/revert.c:499
+msgid "Your index file is unmerged."
+msgstr "=E6=82=A8=E7=9A=84=E6=9A=82=E5=AD=98=E5=8C=BA=E6=96=87=E4=BB=B6=
=E6=9C=AA=E5=AE=8C=E6=88=90=E5=90=88=E5=B9=B6=E3=80=82"
+
+#: builtin/revert.c:502
+msgid "You do not have a valid HEAD"
+msgstr "=E6=82=A8=E6=B2=A1=E6=9C=89=E4=B8=80=E4=B8=AA=E6=9C=89=E6=95=88=
=E7=9A=84 HEAD"
+
+#: builtin/revert.c:517
+#, c-format
+msgid "Commit %s is a merge but no -m option was given."
+msgstr "=E6=8F=90=E4=BA=A4 %s =E6=98=AF=E4=B8=80=E4=B8=AA=E5=90=88=E5=B9=
=B6=E6=8F=90=E4=BA=A4=E4=BD=86=E6=9C=AA=E6=8F=90=E4=BE=9B -m =E9=80=89=E9=
=A1=B9=E3=80=82"
+
+#: builtin/revert.c:525
+#, c-format
+msgid "Commit %s does not have parent %d"
+msgstr "=E6=8F=90=E4=BA=A4 %s =E6=B2=A1=E6=9C=89=E7=88=B6=E6=8F=90=E4=BA=
=A4 %d"
+
+#: builtin/revert.c:529
+#, c-format
+msgid "Mainline was specified but commit %s is not a merge."
+msgstr "=E6=8F=90=E4=BE=9B=E4=BA=86=E4=B8=BB=E7=BA=BF=E4=BD=86=E6=8F=90=
=E4=BA=A4 %s =E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E5=90=88=E5=B9=B6=E3=80=
=82"
+
+#. TRANSLATORS: The first %s will be "revert" or
+#. "cherry-pick", the second %s a SHA1
+#: builtin/revert.c:540
+#, c-format
+msgid "%s: cannot parse parent commit %s"
+msgstr "%s=EF=BC=9A=E4=B8=8D=E8=83=BD=E8=A7=A3=E6=9E=90=E7=88=B6=E6=8F=
=90=E4=BA=A4 %s"
+
+#: builtin/revert.c:544
+#, c-format
+msgid "Cannot get commit message for %s"
+msgstr "=E4=B8=8D=E8=83=BD=E5=BE=97=E5=88=B0 %s =E7=9A=84=E6=8F=90=E4=BA=
=A4=E8=AF=B4=E6=98=8E"
+
+#: builtin/revert.c:628
+#, c-format
+msgid "could not revert %s... %s"
+msgstr "=E4=B8=8D=E8=83=BD=E8=BF=98=E5=8E=9F %s... %s"
+
+#: builtin/revert.c:629
+#, c-format
+msgid "could not apply %s... %s"
+msgstr "=E4=B8=8D=E8=83=BD=E5=BA=94=E7=94=A8 %s... %s"
+
+#: builtin/revert.c:654
+msgid "empty commit set passed"
+msgstr "=E6=8F=90=E4=BE=9B=E4=BA=86=E7=A9=BA=E7=9A=84=E6=8F=90=E4=BA=A4=
=E9=9B=86"
+
+#: builtin/revert.c:662
+#, c-format
+msgid "git %s: failed to read the index"
+msgstr "git %s: =E6=97=A0=E6=B3=95=E8=AF=BB=E5=8F=96=E6=9A=82=E5=AD=98=
=E5=8C=BA"
+
+#: builtin/revert.c:667
+#, c-format
+msgid "git %s: failed to refresh the index"
+msgstr "git %s: =E6=97=A0=E6=B3=95=E5=88=B7=E6=96=B0=E6=9A=82=E5=AD=98=
=E5=8C=BA"
+
+#: builtin/revert.c:752
+#, c-format
+msgid "Cannot %s during a %s"
+msgstr "=E6=97=A0=E6=B3=95 %s =E5=9C=A8 %s =E8=BF=87=E7=A8=8B=E4=B8=AD=
"
+
+#: builtin/revert.c:774
+#, c-format
+msgid "Could not parse line %d."
+msgstr "=E6=97=A0=E6=B3=95=E8=A7=A3=E6=9E=90=E7=AC=AC %d =E8=A1=8C=E3=80=
=82"
+
+#: builtin/revert.c:779
+msgid "No commits parsed."
+msgstr "=E6=9C=AA=E6=9C=89=E6=8F=90=E4=BA=A4=E8=A2=AB=E8=A7=A3=E6=9E=90=
=E3=80=82"
+
+#: builtin/revert.c:792
+#, c-format
+msgid "Could not open %s"
+msgstr "=E4=B8=8D=E8=83=BD=E6=89=93=E5=BC=80 %s"
+
+#: builtin/revert.c:796
+#, c-format
+msgid "Could not read %s."
+msgstr "=E4=B8=8D=E8=83=BD=E8=AF=BB=E5=8F=96 %s=E3=80=82"
+
+#: builtin/revert.c:803
+#, c-format
+msgid "Unusable instruction sheet: %s"
+msgstr "=E6=97=A0=E7=94=A8=E7=9A=84=E6=8C=87=E4=BB=A4=E8=A1=A8=E5=8D=95=
=EF=BC=9A%s"
+
+#: builtin/revert.c:831
+#, c-format
+msgid "Invalid key: %s"
+msgstr "=E6=97=A0=E6=95=88=E9=94=AE=E5=90=8D=EF=BC=9A%s"
+
+#: builtin/revert.c:834
+#, c-format
+msgid "Invalid value for %s: %s"
+msgstr "=E6=97=A0=E6=95=88=E7=9A=84 %s =E5=80=BC=EF=BC=9A%s"
+
+#: builtin/revert.c:846
+#, c-format
+msgid "Malformed options sheet: %s"
+msgstr "=E9=9D=9E=E6=B3=95=E7=9A=84=E9=80=89=E9=A1=B9=E8=A1=A8=E5=8D=95=
=EF=BC=9A%s"
+
+#: builtin/revert.c:867
+msgid "a cherry-pick or revert is already in progress"
+msgstr "=E4=B8=80=E4=B8=AA=E6=8B=A3=E9=80=89=E6=88=96=E8=BF=98=E5=8E=9F=
=E6=93=8D=E4=BD=9C=E5=B7=B2=E5=9C=A8=E8=BF=9B=E8=A1=8C"
+
+#: builtin/revert.c:868
+msgid "try \"git cherry-pick (--continue | --quit | --abort)\""
+msgstr "=E5=B0=9D=E8=AF=95 \"git cherry-pick (--continue | --quit | --=
abort)\""
+
+#: builtin/revert.c:872
+#, c-format
+msgid "Could not create sequencer directory %s"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E5=BA=8F=E5=88=97=E7=9B=AE=
=E5=BD=95 %s"
+
+#: builtin/revert.c:888 builtin/revert.c:973
+#, c-format
+msgid "Error wrapping up %s."
+msgstr "=E9=94=99=E8=AF=AF=E6=94=B6=E5=B0=BE %s=E3=80=82"
+
+#: builtin/revert.c:907 builtin/revert.c:1041
+msgid "no cherry-pick or revert in progress"
+msgstr "=E6=B2=A1=E6=9C=89=E6=8B=A3=E9=80=89=E6=88=96=E8=BF=98=E5=8E=9F=
=E6=93=8D=E4=BD=9C=E5=9C=A8=E8=BF=9B=E8=A1=8C"
+
+#: builtin/revert.c:909
+msgid "cannot resolve HEAD"
+msgstr "=E4=B8=8D=E8=83=BD=E8=A7=A3=E6=9E=90 HEAD"
+
+#: builtin/revert.c:911
+msgid "cannot abort from a branch yet to be born"
+msgstr "=E4=B8=8D=E8=83=BD=E4=BB=8E=E6=9C=AA=E5=88=9D=E5=A7=8B=E5=88=86=
=E6=94=AF=E7=BB=88=E6=AD=A2"
+
+#: builtin/revert.c:933
+#, c-format
+msgid "cannot open %s: %s"
+msgstr "=E4=B8=8D=E8=83=BD=E6=89=93=E5=BC=80 %s=EF=BC=9A%s"
+
+#: builtin/revert.c:936
+#, c-format
+msgid "cannot read %s: %s"
+msgstr "=E4=B8=8D=E8=83=BD=E8=AF=BB=E5=8F=96 %s=EF=BC=9A%s"
+
+#: builtin/revert.c:937
+msgid "unexpected end of file"
+msgstr "=E6=9C=AA=E9=A2=84=E6=9C=9F=E7=9A=84=E6=96=87=E4=BB=B6=E7=BB=93=
=E6=9D=9F"
+
+#: builtin/revert.c:943
+#, c-format
+msgid "stored pre-cherry-pick HEAD file '%s' is corrupt"
+msgstr "=E4=BF=9D=E5=AD=98=E9=A2=84=E6=8B=A3=E9=80=89=E6=8F=90=E4=BA=A4=
=E7=9A=84 HEAD =E6=96=87=E4=BB=B6 '%s' =E6=8D=9F=E5=9D=8F"
+
+#: builtin/revert.c:966
+#, c-format
+msgid "Could not format %s."
+msgstr "=E4=B8=8D=E8=83=BD=E6=A0=BC=E5=BC=8F=E5=8C=96 %s=E3=80=82"
+
+#: builtin/revert.c:1128
+msgid "Can't revert as initial commit"
+msgstr "=E4=B8=8D=E8=83=BD=E4=BD=9C=E4=B8=BA=E5=88=9D=E5=A7=8B=E6=8F=90=
=E4=BA=A4=E8=BF=98=E5=8E=9F"
+
+#: builtin/revert.c:1129
+msgid "Can't cherry-pick into empty head"
+msgstr "=E4=B8=8D=E8=83=BD=E6=8B=A3=E9=80=89=E5=88=B0=E7=A9=BA=E5=88=86=
=E6=94=AF"
+
+#: builtin/revert.c:1149
+msgid "revert failed"
+msgstr "=E8=BF=98=E5=8E=9F=E5=A4=B1=E8=B4=A5"
+
+#: builtin/revert.c:1164
+msgid "cherry-pick failed"
+msgstr "=E6=8B=A3=E9=80=89=E5=A4=B1=E8=B4=A5"
+
+#: builtin/rm.c:109
+#, c-format
+msgid ""
+"'%s' has staged content different from both the file and the HEAD\n"
+"(use -f to force removal)"
+msgstr ""
+"'%s' =E6=9A=82=E5=AD=98=E7=9A=84=E5=86=85=E5=AE=B9=E5=92=8C=E5=B7=A5=E4=
=BD=9C=E5=8C=BA=E6=96=87=E4=BB=B6=E5=8F=8A HEAD =E4=B8=AD=E7=9A=84=E9=83=
=BD=E4=B8=8D=E4=B8=80=E6=A0=B7\n"
+"=EF=BC=88=E4=BD=BF=E7=94=A8 -f =E5=BC=BA=E5=88=B6=E5=88=A0=E9=99=A4=EF=
=BC=89"
+
+#: builtin/rm.c:115
+#, c-format
+msgid ""
+"'%s' has changes staged in the index\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+"'%s' =E6=9C=89=E5=8F=98=E6=9B=B4=E5=B7=B2=E5=8A=A0=E5=85=A5=E6=9A=82=E5=
=AD=98=E5=8C=BA=E4=B8=AD\n"
+"=EF=BC=88=E4=BD=BF=E7=94=A8 --cached =E4=BF=9D=E5=AD=98=E6=96=87=E4=BB=
=B6=EF=BC=8C=E6=88=96=E7=94=A8 -f =E5=BC=BA=E5=88=B6=E5=88=A0=E9=99=A4=EF=
=BC=89"
+
+#: builtin/rm.c:119
+#, c-format
+msgid ""
+"'%s' has local modifications\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+"'%s' =E6=9C=89=E6=9C=AC=E5=9C=B0=E4=BF=AE=E6=94=B9\n"
+"=EF=BC=88=E4=BD=BF=E7=94=A8 --cached =E4=BF=9D=E5=AD=98=E6=96=87=E4=BB=
=B6=EF=BC=8C=E6=88=96=E7=94=A8 -f =E5=BC=BA=E5=88=B6=E5=88=A0=E9=99=A4=EF=
=BC=89"
+
+#: builtin/rm.c:194
+#, c-format
+msgid "not removing '%s' recursively without -r"
+msgstr "=E6=9C=AA=E6=8F=90=E4=BE=9B -r =E9=80=89=E9=A1=B9=E4=B8=8D=E4=BC=
=9A=E9=80=92=E5=BD=92=E5=88=A0=E9=99=A4 '%s'"
+
+#: builtin/rm.c:230
+#, c-format
+msgid "git rm: unable to remove %s"
+msgstr "git rm=EF=BC=9A=E4=B8=8D=E8=83=BD=E5=88=A0=E9=99=A4 %s"
+
+#: builtin/shortlog.c:157
+#, c-format
+msgid "Missing author: %s"
+msgstr "=E7=BC=BA=E5=B0=91=E4=BD=9C=E8=80=85=EF=BC=9A%s"
+
+#: builtin/tag.c:172
+#, c-format
+msgid "tag name too long: %.*s..."
+msgstr "tag =E5=90=8D=E5=AD=97=E5=A4=AA=E9=95=BF=EF=BC=9A%.*s..."
+
+#: builtin/tag.c:177
+#, c-format
+msgid "tag '%s' not found."
+msgstr "tag '%s' =E6=9C=AA=E5=8F=91=E7=8E=B0=E3=80=82"
+
+#: builtin/tag.c:192
+#, c-format
+msgid "Deleted tag '%s' (was %s)\n"
+msgstr "=E5=B7=B2=E5=88=A0=E9=99=A4 tag '%s'=EF=BC=88=E6=9B=BE=E4=B8=BA=
 %s=EF=BC=89\n"
+
+#: builtin/tag.c:204
+#, c-format
+msgid "could not verify the tag '%s'"
+msgstr "=E4=B8=8D=E8=83=BD=E6=A0=A1=E9=AA=8C tag '%s'"
+
+#: builtin/tag.c:214
+msgid ""
+"\n"
+"#\n"
+"# Write a tag message\n"
+"# Lines starting with '#' will be ignored.\n"
+"#\n"
+msgstr ""
+"\n"
+"#\n"
+"# =E8=BE=93=E5=85=A5=E4=B8=80=E4=B8=AA tag =E8=AF=B4=E6=98=8E\n"
+"# =E4=BB=A5 '#' =E5=BC=80=E5=A4=B4=E7=9A=84=E8=A1=8C=E5=B0=86=E8=A2=AB=
=E5=BF=BD=E7=95=A5=E3=80=82\n"
+"#\n"
+
+#: builtin/tag.c:221
+msgid ""
+"\n"
+"#\n"
+"# Write a tag message\n"
+"# Lines starting with '#' will be kept; you may remove them yourself =
if you "
+"want to.\n"
+"#\n"
+msgstr ""
+"\n"
+"#\n"
+"# =E8=BE=93=E5=85=A5=E4=B8=80=E4=B8=AA tag =E8=AF=B4=E6=98=8E\n"
+"# =E4=BB=A5 '#' =E5=BC=80=E5=A4=B4=E7=9A=84=E8=A1=8C=E5=B0=86=E8=A2=AB=
=E5=BF=BD=E7=95=A5=EF=BC=8C=E6=82=A8=E5=8F=AF=E4=BB=A5=E5=88=A0=E9=99=A4=
=E5=AE=83=E4=BB=AC=E5=A6=82=E6=9E=9C=E6=82=A8=E6=83=B3=E8=BF=99=E6=A0=B7=
=E5=81=9A=E3=80=82\n"
+"#\n"
+
+#: builtin/tag.c:261
+msgid "unable to sign the tag"
+msgstr "=E6=97=A0=E6=B3=95=E7=AD=BE=E7=BD=B2 tag"
+
+#: builtin/tag.c:263
+msgid "unable to write tag file"
+msgstr "=E6=97=A0=E6=B3=95=E5=86=99 tag =E6=96=87=E4=BB=B6"
+
+#: builtin/tag.c:288
+msgid "bad object type."
+msgstr "=E6=97=A0=E6=95=88=E7=9A=84=E5=AF=B9=E8=B1=A1=E7=B1=BB=E5=9E=8B=
"
+
+#: builtin/tag.c:301
+msgid "tag header too big."
+msgstr "tag =E5=A4=B4=E4=BF=A1=E6=81=AF=E5=A4=AA=E5=A4=A7"
+
+#: builtin/tag.c:333
+msgid "no tag message?"
+msgstr "=E6=97=A0 tag =E8=AF=B4=E6=98=8E=EF=BC=9F"
+
+#: builtin/tag.c:339
+#, c-format
+msgid "The tag message has been left in %s\n"
+msgstr "tag =E8=AF=B4=E6=98=8E=E8=A2=AB=E4=BF=9D=E7=95=99=E5=9C=A8 %s\=
n"
+
+#: builtin/tag.c:448
+msgid "-n option is only allowed with -l."
+msgstr "-n =E9=80=89=E9=A1=B9=E5=8F=AA=E5=85=81=E8=AE=B8=E5=92=8C -l =E5=
=85=B1=E7=94=A8=E3=80=82"
+
+#: builtin/tag.c:450
+msgid "--contains option is only allowed with -l."
+msgstr "--contains =E9=80=89=E9=A1=B9=E5=8F=AA=E5=85=81=E8=AE=B8=E5=92=
=8C -l =E5=85=B1=E7=94=A8=E3=80=82"
+
+#: builtin/tag.c:458
+msgid "only one -F or -m option is allowed."
+msgstr "=E5=8F=AA=E5=85=81=E8=AE=B8=E4=B8=80=E4=B8=AA -F =E6=88=96 -m =
=E9=80=89=E9=A1=B9=E3=80=82"
+
+#: builtin/tag.c:478
+msgid "too many params"
+msgstr "=E5=A4=AA=E5=A4=9A=E5=8F=82=E6=95=B0"
+
+#: builtin/tag.c:484
+#, c-format
+msgid "'%s' is not a valid tag name."
+msgstr "'%s' =E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E6=9C=89=E6=95=88=E7=
=9A=84tag=E5=90=8D=E7=A7=B0"
+
+#: builtin/tag.c:489
+#, c-format
+msgid "tag '%s' already exists"
+msgstr "tag '%s' =E5=B7=B2=E5=AD=98=E5=9C=A8"
+
+#: builtin/tag.c:507
+#, c-format
+msgid "%s: cannot lock the ref"
+msgstr "%s=EF=BC=9A=E4=B8=8D=E8=83=BD=E9=94=81=E5=AE=9A=E5=BC=95=E7=94=
=A8"
+
+#: builtin/tag.c:509
+#, c-format
+msgid "%s: cannot update the ref"
+msgstr "%s=EF=BC=9A=E4=B8=8D=E8=83=BD=E6=9B=B4=E6=96=B0=E5=BC=95=E7=94=
=A8"
+
+#: builtin/tag.c:511
+#, c-format
+msgid "Updated tag '%s' (was %s)\n"
+msgstr "=E5=B7=B2=E6=9B=B4=E6=96=B0tag '%s'=EF=BC=88=E6=9B=BE=E4=B8=BA=
 %s=EF=BC=89\n"
+
+#: git-am.sh:48
+msgid "You need to set your committer info first"
+msgstr "=E6=82=A8=E9=9C=80=E8=A6=81=E5=85=88=E8=AE=BE=E7=BD=AE=E4=BD=A0=
=E7=9A=84=E6=8F=90=E4=BA=A4=E8=80=85=E4=BF=A1=E6=81=AF"
+
+#: git-am.sh:134
+msgid "Repository lacks necessary blobs to fall back on 3-way merge."
+msgstr "=E7=89=88=E6=9C=AC=E5=BA=93=E7=BC=BA=E4=B9=8F=E5=BF=85=E8=A6=81=
=E7=9A=84 blob =E6=95=B0=E6=8D=AE=E4=BB=A5=E8=BF=9B=E8=A1=8C=E4=B8=89=E8=
=B7=AF=E5=90=88=E5=B9=B6=E3=80=82"
+
+#: git-am.sh:143
+msgid ""
+"Did you hand edit your patch?\n"
+"It does not apply to blobs recorded in its index."
+msgstr ""
+"=E6=82=A8=E6=98=AF=E5=90=A6=E6=9B=BE=E6=89=8B=E5=8A=A8=E7=BC=96=E8=BE=
=91=E8=BF=87=E6=82=A8=E7=9A=84=E8=A1=A5=E4=B8=81=EF=BC=9F\n"
+"=E6=97=A0=E6=B3=95=E5=BA=94=E7=94=A8=E8=A1=A5=E4=B8=81=E5=88=B0=E6=9A=
=82=E5=AD=98=E5=8C=BA=E7=9A=84=E6=95=B0=E6=8D=AE=E4=B8=AD=E3=80=82"
+
+#: git-am.sh:152
+msgid "Falling back to patching base and 3-way merge..."
+msgstr "=E8=BD=AC=E8=80=8C=E4=BD=BF=E7=94=A8=E8=A1=A5=E4=B8=81=E5=BA=94=
=E7=94=A8=E7=9A=84=E5=9F=BA=E7=A1=80=E7=89=88=E6=9C=AC=E5=92=8C=E4=B8=89=
=E8=B7=AF=E5=90=88=E5=B9=B6..."
+
+#: git-am.sh:264
+msgid "Only one StGIT patch series can be applied at once"
+msgstr "=E4=B8=80=E6=AC=A1=E5=8F=AA=E8=83=BD=E6=9C=89=E4=B8=80=E4=B8=AA=
 StGIT =E8=A1=A5=E4=B8=81=E9=98=9F=E5=88=97=E8=A2=AB=E5=BA=94=E7=94=A8"
+
+#: git-am.sh:351
+#, sh-format
+msgid "Patch format $patch_format is not supported."
+msgstr "=E4=B8=8D=E6=94=AF=E6=8C=81 $patch_format =E8=A1=A5=E4=B8=81=E6=
=A0=BC=E5=BC=8F=E3=80=82"
+
+#: git-am.sh:353
+msgid "Patch format detection failed."
+msgstr "=E8=A1=A5=E4=B8=81=E6=A0=BC=E5=BC=8F=E6=A3=80=E6=B5=8B=E5=A4=B1=
=E8=B4=A5=E3=80=82"
+
+#: git-am.sh:403
+msgid "-d option is no longer supported.  Do not use."
+msgstr "=E4=B8=8D=E5=86=8D=E6=94=AF=E6=8C=81 -d =E9=80=89=E9=A1=B9=E3=80=
=82=E4=B8=8D=E8=A6=81=E4=BD=BF=E7=94=A8=E3=80=82"
+
+#: git-am.sh:466
+#, sh-format
+msgid "previous rebase directory $dotest still exists but mbox given."
+msgstr "=E4=B9=8B=E5=89=8D=E7=9A=84=E5=8F=98=E5=9F=BA=E7=9B=AE=E5=BD=95=
 $dotest =E4=BB=8D=E7=84=B6=E5=AD=98=E5=9C=A8=E4=BD=86=E7=BB=99=E5=87=BA=
=E4=BA=86mbox=E3=80=82"
+
+#: git-am.sh:471
+msgid "Please make up your mind. --skip or --abort?"
+msgstr "=E8=AF=B7=E4=B8=8B=E5=86=B3=E5=BF=83=E3=80=82--skip =E6=88=96=E6=
=98=AF --abort =EF=BC=9F"
+
+#: git-am.sh:498
+msgid "Resolve operation not in progress, we are not resuming."
+msgstr "=E8=A7=A3=E5=86=B3=E6=93=8D=E4=BD=9C=E6=9C=AA=E8=BF=9B=E8=A1=8C=
=EF=BC=8C=E6=88=91=E4=BB=AC=E4=B8=8D=E4=BC=9A=E7=BB=A7=E7=BB=AD=E3=80=82=
"
+
+#: git-am.sh:564
+#, sh-format
+msgid "Dirty index: cannot apply patches (dirty: $files)"
+msgstr "=E8=84=8F=E7=9A=84=E6=9A=82=E5=AD=98=E5=8C=BA=EF=BC=9A=E4=B8=8D=
=E8=83=BD=E5=BA=94=E7=94=A8=E8=A1=A5=E4=B8=81=EF=BC=88=E8=84=8F=E6=96=87=
=E4=BB=B6=EF=BC=9A$files=EF=BC=89"
+
+#: git-am.sh:731
+msgid "cannot be interactive without stdin connected to a terminal."
+msgstr "=E6=B2=A1=E6=9C=89=E5=92=8C=E7=BB=88=E7=AB=AF=E5=85=B3=E8=81=94=
=E7=9A=84=E6=A0=87=E5=87=86=E8=BE=93=E5=85=A5=E4=B8=8D=E8=83=BD=E8=BF=9B=
=E8=A1=8C=E4=BA=A4=E4=BA=92=E5=BC=8F=E6=93=8D=E4=BD=9C=E3=80=82"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=A5=E5=B0=BE=E7=A9=BA=E6=A0=
=BC
+#. TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+#. in your translation. The program will only accept English
+#. input at this point.
+#: git-am.sh:742
+msgid "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+msgstr "=E5=BA=94=E7=94=A8=EF=BC=9F[y]es/[n]o/[e]dit/[v]iew patch/[a]c=
cept all "
+
+#: git-am.sh:778
+#, sh-format
+msgid "Applying: $FIRSTLINE"
+msgstr "=E6=AD=A3=E5=BA=94=E7=94=A8=EF=BC=9A$FIRSTLINE"
+
+#: git-am.sh:823
+msgid "No changes -- Patch already applied."
+msgstr "=E6=B2=A1=E6=9C=89=E5=8F=98=E6=9B=B4 -- =E8=A1=A5=E4=B8=81=E5=B7=
=B2=E7=BB=8F=E5=BA=94=E7=94=A8=E8=BF=87=E3=80=82"
+
+#: git-am.sh:849
+msgid "applying to an empty history"
+msgstr "=E6=AD=A3=E5=BA=94=E7=94=A8=E5=88=B0=E4=B8=80=E4=B8=AA=E7=A9=BA=
=E5=8E=86=E5=8F=B2=E4=B8=8A"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=A5=E5=B0=BE=E7=A9=BA=E6=A0=
=BC
+#. TRANSLATORS: Make sure to include [Y] and [n] in your
+#. translation. The program will only accept English input
+#. at this point.
+#: git-bisect.sh:54
+msgid "Do you want me to do it for you [Y/n]? "
+msgstr "=E6=82=A8=E6=83=B3=E8=AE=A9=E6=88=91=E4=B8=BA=E6=82=A8=E8=BF=99=
=E6=A0=B7=E5=81=9A=E4=B9=88[Y/n]=EF=BC=9F "
+
+#: git-bisect.sh:95
+#, sh-format
+msgid "unrecognised option: '$arg'"
+msgstr "=E6=9C=AA=E8=AF=86=E5=88=AB=E7=9A=84=E9=80=89=E9=A1=B9=EF=BC=9A=
'$arg'"
+
+#: git-bisect.sh:99
+#, sh-format
+msgid "'$arg' does not appear to be a valid revision"
+msgstr "'$arg' =E7=9C=8B=E8=B5=B7=E6=9D=A5=E4=B8=8D=E5=83=8F=E6=98=AF=E4=
=B8=80=E4=B8=AA=E6=9C=89=E6=95=88=E7=9A=84=E7=89=88=E6=9C=AC"
+
+#: git-bisect.sh:117
+msgid "Bad HEAD - I need a HEAD"
+msgstr "=E5=9D=8F=E7=9A=84 HEAD - =E6=88=91=E9=9C=80=E8=A6=81=E4=B8=80=
=E4=B8=AA HEAD"
+
+#: git-bisect.sh:130
+#, sh-format
+msgid ""
+"Checking out '$start_head' failed. Try 'git bisect reset <validbranch=
>'."
+msgstr "=E6=A3=80=E5=87=BA '$start_head' =E5=A4=B1=E8=B4=A5=E3=80=82=E5=
=B0=9D=E8=AF=95 'git bisect reset <validbranch>'=E3=80=82"
+
+#: git-bisect.sh:140
+msgid "won't bisect on seeked tree"
+msgstr "=E4=B8=8D=E4=BC=9A=E5=9C=A8=E5=B7=B2=E6=9F=A5=E6=89=BE=E8=BF=87=
=E7=9A=84=E6=A0=91=E4=B8=8A=E4=BA=8C=E5=88=86=E6=9F=A5=E6=89=BE"
+
+#: git-bisect.sh:144
+msgid "Bad HEAD - strange symbolic ref"
+msgstr "=E9=94=99=E8=AF=AF=E7=9A=84 HEAD - =E5=A5=87=E6=80=AA=E7=9A=84=
=E7=AC=A6=E5=8F=B7=E5=BC=95=E7=94=A8"
+
+#: git-bisect.sh:189
+#, sh-format
+msgid "Bad bisect_write argument: $state"
+msgstr "=E9=94=99=E8=AF=AF=E7=9A=84bisect_write=E5=8F=82=E6=95=B0=EF=BC=
=9A$state"
+
+#: git-bisect.sh:218
+#, sh-format
+msgid "Bad rev input: $arg"
+msgstr "=E8=BE=93=E5=85=A5=E9=94=99=E8=AF=AF=E7=89=88=E6=9C=AC=EF=BC=9A=
$arg"
+
+#: git-bisect.sh:232
+msgid "Please call 'bisect_state' with at least one argument."
+msgstr "=E8=AF=B7=E5=9C=A8=E8=B0=83=E7=94=A8 'bisect_state' =E6=97=B6=E8=
=B7=9F=E8=87=B3=E5=B0=91=E4=B8=80=E4=B8=AA=E5=8F=82=E6=95=B0=E3=80=82"
+
+#: git-bisect.sh:244
+#, sh-format
+msgid "Bad rev input: $rev"
+msgstr "=E8=BE=93=E5=85=A5=E5=9D=8F=E7=9A=84=E7=89=88=E6=9C=AC=EF=BC=9A=
$rev"
+
+#: git-bisect.sh:250
+msgid "'git bisect bad' can take only one argument."
+msgstr "'git bisect bad' =E5=8F=AA=E8=83=BD=E5=B8=A6=E4=B8=80=E4=B8=AA=
=E5=8F=82=E6=95=B0=E3=80=82"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=8F=A5=E5=B0=BE=E7=A9=BA=E6=A0=
=BC
+#. TRANSLATORS: Make sure to include [Y] and [n] in your
+#. translation. The program will only accept English input
+#. at this point.
+#: git-bisect.sh:279
+msgid "Are you sure [Y/n]? "
+msgstr "=E6=82=A8=E7=A1=AE=E8=AE=A4=E4=B9=88[Y/n]=EF=BC=9F "
+
+#: git-bisect.sh:354
+#, sh-format
+msgid "'$invalid' is not a valid commit"
+msgstr "'$invalid' =E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AA=E6=9C=89=E6=95=
=88=E7=9A=84=E6=8F=90=E4=BA=A4"
+
+#: git-bisect.sh:363
+#, sh-format
+msgid ""
+"Could not check out original HEAD '$branch'.\n"
+"Try 'git bisect reset <commit>'."
+msgstr ""
+"=E4=B8=8D=E8=83=BD=E6=A3=80=E5=87=BA=E5=8E=9F=E5=A7=8B HEAD '$branch'=
=E3=80=82\n"
+"=E5=B0=9D=E8=AF=95 'git bisect reset <commit>'=E3=80=82"
+
+#: git-bisect.sh:390
+msgid "No logfile given"
+msgstr "=E6=9C=AA=E6=8F=90=E4=BE=9B=E6=97=A5=E5=BF=97=E6=96=87=E4=BB=B6=
"
+
+#: git-bisect.sh:391
+#, sh-format
+msgid "cannot read $file for replaying"
+msgstr "=E4=B8=8D=E8=83=BD=E8=AF=BB=E5=8F=96 $file =E6=9D=A5=E9=87=8D=E6=
=94=BE"
+
+#: git-bisect.sh:408
+msgid "?? what are you talking about?"
+msgstr "?? =E6=82=A8=E5=9C=A8=E8=AF=B4=E4=BB=80=E4=B9=88?"
+
+#: git-bisect.sh:474
+msgid "We are not bisecting."
+msgstr "=E6=88=91=E4=BB=AC=E6=B2=A1=E6=9C=89=E8=BF=9B=E8=A1=8C=E4=BA=8C=
=E5=88=86=E6=9F=A5=E6=89=BE=E3=80=82"
+
+#: git-pull.sh:21
+msgid ""
+"Pull is not possible because you have unmerged files.\n"
+"Please, fix them up in the work tree, and then use 'git add/rm <file>=
'\n"
+"as appropriate to mark resolution, or use 'git commit -a'."
+msgstr ""
+"Pull =E4=B8=8D=E5=8F=AF=E7=94=A8=EF=BC=8C=E5=9B=A0=E4=B8=BA=E4=BD=A0=E5=
=B0=9A=E6=9C=89=E6=9C=AA=E5=90=88=E5=B9=B6=E7=9A=84=E6=96=87=E4=BB=B6=E3=
=80=82=E8=AF=B7=E5=85=88=E5=9C=A8=E5=B7=A5=E4=BD=9C=E5=8C=BA=E6=94=B9=E6=
=AD=A3=E6=96=87=E4=BB=B6=EF=BC=8C\n"
+"=E7=84=B6=E5=90=8E=E9=85=8C=E6=83=85=E4=BD=BF=E7=94=A8 'git add/rm <f=
ile>' =E6=A0=87=E8=AE=B0=E8=A7=A3=E5=86=B3=E6=96=B9=E6=A1=88=EF=BC=8C\n=
"
+"=E6=88=96=E4=BD=BF=E7=94=A8 'git commit -a'=E3=80=82"
+
+#: git-pull.sh:25
+msgid "Pull is not possible because you have unmerged files."
+msgstr "Pull =E4=B8=8D=E5=8F=AF=E7=94=A8=EF=BC=8C=E5=9B=A0=E4=B8=BA=E4=
=BD=A0=E5=B0=9A=E6=9C=89=E6=9C=AA=E5=90=88=E5=B9=B6=E7=9A=84=E6=96=87=E4=
=BB=B6=E3=80=82"
+
+#: git-pull.sh:193
+msgid "updating an unborn branch with changes added to the index"
+msgstr "=E6=9B=B4=E6=96=B0=E5=B0=9A=E6=9C=AA=E8=AF=9E=E7=94=9F=E7=9A=84=
=E5=88=86=E6=94=AF=EF=BC=8C=E5=8F=98=E6=9B=B4=E6=B7=BB=E5=8A=A0=E8=87=B3=
=E6=9A=82=E5=AD=98=E5=8C=BA"
+
+#: git-pull.sh:249
+msgid "Cannot merge multiple branches into empty head"
+msgstr "=E6=97=A0=E6=B3=95=E5=B0=86=E5=A4=9A=E4=B8=AA=E5=88=86=E6=94=AF=
=E5=90=88=E5=B9=B6=E5=88=B0=E7=A9=BA=E5=88=86=E6=94=AF"
+
+#: git-pull.sh:253
+msgid "Cannot rebase onto multiple branches"
+msgstr "=E6=97=A0=E6=B3=95=E5=8F=98=E5=9F=BA=E5=88=B0=E5=A4=9A=E4=B8=AA=
=E5=88=86=E6=94=AF"
+
+#: git-stash.sh:51
+msgid "git stash clear with parameters is unimplemented"
+msgstr "git stash clear =E4=B8=8D=E6=94=AF=E6=8C=81=E5=8F=82=E6=95=B0"
+
+#: git-stash.sh:74
+msgid "You do not have the initial commit yet"
+msgstr "=E6=82=A8=E5=B0=9A=E6=9C=AA=E5=BB=BA=E7=AB=8B=E5=88=9D=E5=A7=8B=
=E6=8F=90=E4=BA=A4"
+
+#: git-stash.sh:89
+msgid "Cannot save the current index state"
+msgstr "=E6=97=A0=E6=B3=95=E4=BF=9D=E5=AD=98=E5=BD=93=E5=89=8D=E6=9A=82=
=E5=AD=98=E5=8C=BA=E7=8A=B6=E6=80=81"
+
+#: git-stash.sh:123 git-stash.sh:136
+msgid "Cannot save the current worktree state"
+msgstr "=E6=97=A0=E6=B3=95=E4=BF=9D=E5=AD=98=E5=BD=93=E5=89=8D=E5=B7=A5=
=E4=BD=9C=E5=8C=BA=E7=8A=B6=E6=80=81"
+
+#: git-stash.sh:140
+msgid "No changes selected"
+msgstr "=E6=B2=A1=E6=9C=89=E4=BF=AE=E6=94=B9=E8=A2=AB=E9=80=89=E6=8B=A9=
"
+
+#: git-stash.sh:143
+msgid "Cannot remove temporary index (can't happen)"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=A0=E9=99=A4=E4=B8=B4=E6=97=B6=E6=9A=82=
=E5=AD=98=E5=8C=BA=EF=BC=88=E4=B8=8D=E5=BA=94=E5=8F=91=E7=94=9F=EF=BC=89=
"
+
+#: git-stash.sh:156
+msgid "Cannot record working tree state"
+msgstr "=E4=B8=8D=E8=83=BD=E8=AE=B0=E5=BD=95=E5=B7=A5=E4=BD=9C=E5=8C=BA=
=E7=8A=B6=E6=80=81"
+
+#: git-stash.sh:223
+msgid "No local changes to save"
+msgstr "=E6=B2=A1=E6=9C=89=E8=A6=81=E4=BF=9D=E5=AD=98=E7=9A=84=E6=9C=AC=
=E5=9C=B0=E4=BF=AE=E6=94=B9"
+
+#: git-stash.sh:227
+msgid "Cannot initialize stash"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=9D=E5=A7=8B=E5=8C=96stash"
+
+#: git-stash.sh:235
+msgid "Cannot save the current status"
+msgstr "=E6=97=A0=E6=B3=95=E4=BF=9D=E5=AD=98=E5=BD=93=E5=89=8D=E7=8A=B6=
=E6=80=81"
+
+#: git-stash.sh:253
+msgid "Cannot remove worktree changes"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=A0=E9=99=A4=E5=B7=A5=E4=BD=9C=E5=8C=BA=
=E5=8F=98=E6=9B=B4"
+
+#: git-stash.sh:352
+msgid "No stash found."
+msgstr "=E6=9C=AA=E5=8F=91=E7=8E=B0stash=E3=80=82"
+
+#: git-stash.sh:359
+#, sh-format
+msgid "Too many revisions specified: $REV"
+msgstr "=E6=8F=90=E4=BE=9B=E5=A4=AA=E5=A4=9A=E7=9A=84=E7=89=88=E6=9C=AC=
=EF=BC=9A$REV"
+
+#: git-stash.sh:365
+#, sh-format
+msgid "$reference is not valid reference"
+msgstr "$reference =E4=B8=8D=E6=98=AF=E6=9C=89=E6=95=88=E7=9A=84=E5=BC=
=95=E7=94=A8"
+
+#: git-stash.sh:393
+#, sh-format
+msgid "'$args' is not a stash-like commit"
+msgstr "'$args' =E4=B8=8D=E6=98=AFstash=E6=A0=B7=E6=8F=90=E4=BA=A4"
+
+#: git-stash.sh:404
+#, sh-format
+msgid "'$args' is not a stash reference"
+msgstr "'$args' =E4=B8=8D=E6=98=AF=E4=B8=80=E4=B8=AAstash=E5=BC=95=E7=94=
=A8"
+
+#: git-stash.sh:412
+msgid "unable to refresh index"
+msgstr "=E6=97=A0=E6=B3=95=E5=88=B7=E6=96=B0=E6=9A=82=E5=AD=98=E5=8C=BA=
"
+
+#: git-stash.sh:416
+msgid "Cannot apply a stash in the middle of a merge"
+msgstr "=E6=97=A0=E6=B3=95=E5=9C=A8=E5=90=88=E5=B9=B6=E8=BF=87=E7=A8=8B=
=E4=B8=AD=E6=81=A2=E5=A4=8D=E8=BF=9B=E5=BA=A6"
+
+#: git-stash.sh:424
+msgid "Conflicts in index. Try without --index."
+msgstr "=E6=9A=82=E5=AD=98=E5=8C=BA=E5=86=B2=E7=AA=81=E3=80=82=E5=B0=9D=
=E8=AF=95=E4=B8=8D=E7=94=A8 --index=E3=80=82"
+
+#: git-stash.sh:426
+msgid "Could not save index tree"
+msgstr "=E6=97=A0=E6=B3=95=E4=BF=9D=E5=AD=98=E6=9A=82=E5=AD=98=E5=8C=BA=
"
+
+#: git-stash.sh:460
+msgid "Cannot unstage modified files"
+msgstr "=E6=97=A0=E6=B3=95=E8=BF=98=E5=8E=9F=E4=BF=AE=E6=94=B9=E7=9A=84=
=E6=96=87=E4=BB=B6"
+
+#: git-stash.sh:491
+#, sh-format
+msgid "Dropped ${REV} ($s)"
+msgstr "=E4=B8=A2=E5=BC=83=E4=BA=86 ${REV} ($s)"
+
+#: git-stash.sh:492
+#, sh-format
+msgid "${REV}: Could not drop stash entry"
+msgstr "${REV}: =E6=97=A0=E6=B3=95=E4=B8=A2=E5=BC=83=E8=BF=9B=E5=BA=A6=
=E6=9D=A1=E7=9B=AE"
+
+#: git-stash.sh:499
+msgid "No branch name specified"
+msgstr "=E6=9C=AA=E6=8C=87=E5=AE=9A=E5=88=86=E6=94=AF=E5=90=8D"
+
+#: git-stash.sh:570
+msgid "(To restore them type \"git stash apply\")"
+msgstr "=EF=BC=88=E4=B8=BA=E6=81=A2=E5=A4=8D=E6=95=B0=E6=8D=AE=E8=BE=93=
=E5=85=A5 \"git stash apply\"=EF=BC=89"
+
+#: git-submodule.sh:56
+#, sh-format
+msgid "cannot strip one component off url '$remoteurl'"
+msgstr "=E6=97=A0=E6=B3=95=E4=BB=8E url '$remoteurl' =E5=89=A5=E7=A6=BB=
=E4=B8=80=E4=B8=AA=E7=BB=84=E4=BB=B6"
+
+#: git-submodule.sh:108
+#, sh-format
+msgid "No submodule mapping found in .gitmodules for path '$path'"
+msgstr "=E6=9C=AA=E5=9C=A8 .gitmodules =E4=B8=AD=E5=8F=91=E7=8E=B0=E8=B7=
=AF=E5=BE=84 '$path' =E7=9A=84=E5=AD=90=E6=A8=A1=E7=BB=84=E6=98=A0=E5=B0=
=84"
+
+#: git-submodule.sh:172
+#, sh-format
+msgid "Clone of '$url' into submodule path '$path' failed"
+msgstr "=E5=85=8B=E9=9A=86 '$url' =E5=88=B0=E5=AD=90=E6=A8=A1=E7=BB=84=
=E8=B7=AF=E5=BE=84 '$path' =E5=A4=B1=E8=B4=A5"
+
+#: git-submodule.sh:246
+#, sh-format
+msgid "repo URL: '$repo' must be absolute or begin with ./|../"
+msgstr "=E7=89=88=E6=9C=AC=E5=BA=93URL=EF=BC=9A'$repo' =E5=BF=85=E9=A1=
=BB=E6=98=AF=E7=BB=9D=E5=AF=B9=E8=B7=AF=E5=BE=84=E6=88=96=E4=BB=A5 ./|.=
=2E/ =E8=B5=B7=E5=A7=8B"
+
+#: git-submodule.sh:263
+#, sh-format
+msgid "'$path' already exists in the index"
+msgstr "'$path' =E5=B7=B2=E7=BB=8F=E5=AD=98=E5=9C=A8=E4=BA=8E=E6=9A=82=
=E5=AD=98=E5=8C=BA=E4=B8=AD"
+
+#: git-submodule.sh:280
+#, sh-format
+msgid "'$path' already exists and is not a valid git repo"
+msgstr "'$path' =E5=B7=B2=E5=AD=98=E5=9C=A8=E4=B8=94=E4=B8=8D=E6=98=AF=
=E4=B8=80=E4=B8=AA=E6=9C=89=E6=95=88=E7=9A=84 git =E7=89=88=E6=9C=AC=E5=
=BA=93"
+
+#: git-submodule.sh:294
+#, sh-format
+msgid "Unable to checkout submodule '$path'"
+msgstr "=E4=B8=8D=E8=83=BD=E6=A3=80=E5=87=BA=E5=AD=90=E6=A8=A1=E7=BB=84=
 '$path'"
+
+#: git-submodule.sh:299
+#, sh-format
+msgid "Failed to add submodule '$path'"
+msgstr "=E6=97=A0=E6=B3=95=E6=B7=BB=E5=8A=A0=E5=AD=90=E6=A8=A1=E7=BB=84=
 '$path'"
+
+#: git-submodule.sh:304
+#, sh-format
+msgid "Failed to register submodule '$path'"
+msgstr "=E6=97=A0=E6=B3=95=E6=B3=A8=E5=86=8C=E5=AD=90=E6=A8=A1=E7=BB=84=
 '$path'"
+
+#: git-submodule.sh:346
+#, sh-format
+msgid "Entering '$prefix$path'"
+msgstr "=E6=AD=A3=E5=9C=A8=E8=BF=9B=E5=85=A5 '$prefix$path'"
+
+#: git-submodule.sh:358
+#, sh-format
+msgid "Stopping at '$path'; script returned non-zero status."
+msgstr "=E5=81=9C=E6=AD=A2=E4=BA=8E '$path'=EF=BC=8C=E8=84=9A=E6=9C=AC=
=E8=BF=94=E5=9B=9E=E9=9D=9E=E9=9B=B6=E5=80=BC=E3=80=82"
+
+#: git-submodule.sh:400
+#, sh-format
+msgid "No url found for submodule path '$path' in .gitmodules"
+msgstr "=E5=9C=A8 .gitmodules =E4=B8=AD=E6=9C=AA=E6=89=BE=E5=88=B0=E5=AD=
=90=E6=A8=A1=E7=BB=84=E8=B7=AF=E5=BE=84 '$path' =E7=9A=84url"
+
+#: git-submodule.sh:409
+#, sh-format
+msgid "Failed to register url for submodule path '$path'"
+msgstr "=E6=97=A0=E6=B3=95=E4=B8=BA=E5=AD=90=E6=A8=A1=E7=BB=84=E8=B7=AF=
=E5=BE=84 '$path' =E6=B3=A8=E5=86=8C url"
+
+#: git-submodule.sh:417
+#, sh-format
+msgid "Failed to register update mode for submodule path '$path'"
+msgstr "=E6=97=A0=E6=B3=95=E4=B8=BA=E5=AD=90=E6=A8=A1=E7=BB=84=E8=B7=AF=
=E5=BE=84 '$path' =E6=B3=A8=E5=86=8C=E6=9B=B4=E6=96=B0=E6=A8=A1=E5=BC=8F=
"
+
+#: git-submodule.sh:419
+#, sh-format
+msgid "Submodule '$name' ($url) registered for path '$path'"
+msgstr "=E5=AD=90=E6=A8=A1=E7=BB=84 '$name' ($url) =E5=B7=B2=E4=B8=BA=E8=
=B7=AF=E5=BE=84 '$path' =E6=B3=A8=E5=86=8C"
+
+#: git-submodule.sh:518
+#, sh-format
+msgid ""
+"Submodule path '$path' not initialized\n"
+"Maybe you want to use 'update --init'?"
+msgstr ""
+"=E5=AD=90=E6=A8=A1=E7=BB=84=E8=B7=AF=E5=BE=84 '$path' =E6=B2=A1=E6=9C=
=89=E5=88=9D=E5=A7=8B=E5=8C=96\n"
+"=E4=B9=9F=E8=AE=B8=E4=BD=A0=E6=83=B3=E7=94=A8 'update --init'=EF=BC=9F=
"
+
+#: git-submodule.sh:531
+#, sh-format
+msgid "Unable to find current revision in submodule path '$path'"
+msgstr "=E6=97=A0=E6=B3=95=E5=9C=A8=E5=AD=90=E6=A8=A1=E7=BB=84=E8=B7=AF=
=E5=BE=84 '$path' =E4=B8=AD=E6=89=BE=E5=88=B0=E5=BD=93=E5=89=8D=E7=89=88=
=E6=9C=AC"
+
+#: git-submodule.sh:550
+#, sh-format
+msgid "Unable to fetch in submodule path '$path'"
+msgstr "=E6=97=A0=E6=B3=95=E5=9C=A8=E5=AD=90=E6=A8=A1=E7=BB=84=E8=B7=AF=
=E5=BE=84 '$path' =E4=B8=AD=E8=8E=B7=E5=8F=96"
+
+#: git-submodule.sh:564
+#, sh-format
+msgid "Unable to rebase '$sha1' in submodule path '$path'"
+msgstr "=E6=97=A0=E6=B3=95=E5=9C=A8=E5=AD=90=E6=A8=A1=E7=BB=84=E8=B7=AF=
=E5=BE=84 '$path' =E4=B8=AD=E5=8F=98=E5=9F=BA '$sha1'"
+
+#: git-submodule.sh:565
+#, sh-format
+msgid "Submodule path '$path': rebased into '$sha1'"
+msgstr "=E5=AD=90=E6=A8=A1=E7=BB=84=E8=B7=AF=E5=BE=84 '$path'=EF=BC=9A=
=E5=8F=98=E5=9F=BA=E8=87=B3 '$sha1'"
+
+#: git-submodule.sh:570
+#, sh-format
+msgid "Unable to merge '$sha1' in submodule path '$path'"
+msgstr "=E6=97=A0=E6=B3=95=E5=90=88=E5=B9=B6 '$sha1' =E5=88=B0=E5=AD=90=
=E6=A8=A1=E7=BB=84=E8=B7=AF=E5=BE=84 '$path' =E4=B8=AD"
+
+#: git-submodule.sh:571
+#, sh-format
+msgid "Submodule path '$path': merged in '$sha1'"
+msgstr "=E5=AD=90=E6=A8=A1=E7=BB=84=E8=B7=AF=E5=BE=84 '$path'=EF=BC=9A=
=E5=B7=B2=E5=90=88=E5=B9=B6=E5=85=A5 '$sha1'"
+
+#: git-submodule.sh:576
+#, sh-format
+msgid "Unable to checkout '$sha1' in submodule path '$path'"
+msgstr "=E6=97=A0=E6=B3=95=E5=9C=A8=E5=AD=90=E6=A8=A1=E7=BB=84=E8=B7=AF=
=E5=BE=84 '$path' =E4=B8=AD=E6=A3=80=E5=87=BA '$sha1'"
+
+#: git-submodule.sh:577
+#, sh-format
+msgid "Submodule path '$path': checked out '$sha1'"
+msgstr "=E5=AD=90=E6=A8=A1=E7=BB=84=E8=B7=AF=E5=BE=84 '$path'=EF=BC=9A=
=E6=A3=80=E5=87=BA '$sha1'"
+
+#: git-submodule.sh:599 git-submodule.sh:922
+#, sh-format
+msgid "Failed to recurse into submodule path '$path'"
+msgstr "=E6=97=A0=E6=B3=95=E9=80=92=E5=BD=92=E8=BF=9B=E5=AD=90=E6=A8=A1=
=E7=BB=84=E8=B7=AF=E5=BE=84 '$path'"
+
+#: git-submodule.sh:707
+msgid "--"
+msgstr "--"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: git-submodule.sh:765
+#, sh-format
+msgid "  Warn: $name doesn't contain commit $sha1_src"
+msgstr "  =E8=AD=A6=E5=91=8A=EF=BC=9A$name =E6=9C=AA=E5=8C=85=E5=90=AB=
=E6=8F=90=E4=BA=A4 $sha1_src"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: git-submodule.sh:768
+#, sh-format
+msgid "  Warn: $name doesn't contain commit $sha1_dst"
+msgstr "  =E8=AD=A6=E5=91=8A=EF=BC=9A$name =E6=9C=AA=E5=8C=85=E5=90=AB=
=E6=8F=90=E4=BA=A4 $sha1_dst"
+
+#  =E6=B3=A8=E6=84=8F=E4=BF=9D=E6=8C=81=E5=89=8D=E5=AF=BC=E7=A9=BA=E6=A0=
=BC
+#: git-submodule.sh:771
+#, sh-format
+msgid "  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
+msgstr "  =E8=AD=A6=E5=91=8A=EF=BC=9A$name =E6=9C=AA=E5=8C=85=E5=90=AB=
=E6=8F=90=E4=BA=A4 $sha1_src =E5=92=8C $sha1_dst"
+
+#: git-submodule.sh:796
+msgid "blob"
+msgstr "blob"
+
+#: git-submodule.sh:797
+msgid "submodule"
+msgstr "=E5=AD=90=E6=A8=A1=E7=BB=84"
+
+#: git-submodule.sh:968
+#, sh-format
+msgid "Synchronizing submodule url for '$name'"
+msgstr "=E4=B8=BA '$name' =E5=90=8C=E6=AD=A5=E5=AD=90=E6=A8=A1=E7=BB=84=
url"
--=20
1.7.9.3.g1fbd7
