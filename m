From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v4 7/7] gettext: Add a skeleton po/is.po
Date: Wed,  2 Jun 2010 01:06:04 +0000
Message-ID: <1275440764-26153-8-git-send-email-avarab@gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 03:06:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJcPr-0004k8-Cx
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 03:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519Ab0FBBGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 21:06:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756443Ab0FBBG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 21:06:27 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so1482447fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HJiGWxxEcHZeqHVm7lPxv20LVlTiYEd329U471oecR4=;
        b=oR64OJzS4s8B4Ir+OJgggO/JU4G6WxVLl2g9nsqQ6vI/oslY3HWcWBhDg4P+Tn2+uD
         a2DAd+m+kOoIgebQbZx0pCL1euXNJXjIRcmVT08v7BSzWwZFh4oLD5U10IFdBUVhTbRj
         F3ZUGmPAe/M5BXDrJwBIUvWQPS7P+kiuZ/SMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LuNRrxHvPfLVzw/CrwO2CBJpNqkSYbsYjNrHTwyAi61MR1x79cd+O/BlRRBXFWF0b8
         IHAWuc+wIxte6qeQt9Z9BK8ZbCj9b9llQU7Iz6dfTOlOwoDg77XTRMRAvQCZEoYZ9C39
         5/TMyNuU8t/wRxYZhqC6uYL7n5lxoDKvlsKhY=
Received: by 10.223.127.212 with SMTP id h20mr7842589fas.89.1275440787162;
        Tue, 01 Jun 2010 18:06:27 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 13sm49688716fad.7.2010.06.01.18.06.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 18:06:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.gec7f5.dirty
In-Reply-To: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148188>

This example is.po file translates a little bit of C, Shell and Perl
as an example.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po |  282 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 282 insertions(+), 0 deletions(-)
 create mode 100644 po/is.po

diff --git a/po/is.po b/po/is.po
new file mode 100644
index 0000000..aa1923e
--- /dev/null
+++ b/po/is.po
@@ -0,0 +1,282 @@
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2010-05-30 19:24+0000\n"
+"PO-Revision-Date: 2010-06-01 22:15+0000\n"
+"Last-Translator: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"X-Poedit-Language: English\n"
+"X-Poedit-SourceCharset: utf-8\n"
+
+#: wt-status.c:53
+msgid "# Unmerged paths:"
+msgstr ""
+
+#: wt-status.c:59 wt-status.c:76
+#, c-format
+msgid "#   (use \"git reset %s <file>...\" to unstage)"
+msgstr ""
+
+#: wt-status.c:61 wt-status.c:78
+msgid "#   (use \"git rm --cached <file>...\" to unstage)"
+msgstr ""
+
+#: wt-status.c:62
+msgid "#   (use \"git add/rm <file>...\" as appropriate to mark resolu=
tion)"
+msgstr ""
+
+#: wt-status.c:63 wt-status.c:79 wt-status.c:98 wt-status.c:110
+#: wt-status.c:115 wt-status.c:638 wt-status.c:640
+msgid "#"
+msgstr ""
+
+#: wt-status.c:70
+msgid "# Changes to be committed:"
+msgstr ""
+
+#: wt-status.c:88
+msgid "# Changed but not updated:"
+msgstr ""
+
+#: wt-status.c:92
+msgid "#   (use \"git add <file>...\" to update what will be committed=
)"
+msgstr ""
+
+#: wt-status.c:94
+msgid "#   (use \"git add/rm <file>...\" to update what will be commit=
ted)"
+msgstr ""
+
+#: wt-status.c:95
+msgid ""
+"#   (use \"git checkout -- <file>...\" to discard changes in working =
"
+"directory)"
+msgstr ""
+
+#: wt-status.c:97
+msgid "#   (commit or discard the untracked or modified content in sub=
modules)"
+msgstr ""
+
+#: wt-status.c:106
+#, c-format
+msgid "# %s files:"
+msgstr ""
+
+#: wt-status.c:109
+#, c-format
+msgid "#   (use \"git %s <file>...\" to include in what will be commit=
ted)"
+msgstr ""
+
+#: wt-status.c:126
+msgid "bug"
+msgstr ""
+
+#: wt-status.c:129 wt-status.c:182
+msgid "#\t"
+msgstr ""
+
+#: wt-status.c:131
+msgid "both deleted:"
+msgstr ""
+
+#: wt-status.c:132
+msgid "added by us:"
+msgstr ""
+
+#: wt-status.c:133
+msgid "deleted by them:"
+msgstr ""
+
+#: wt-status.c:134
+msgid "added by them:"
+msgstr ""
+
+#: wt-status.c:135
+msgid "deleted by us:"
+msgstr ""
+
+#: wt-status.c:136
+msgid "both added:"
+msgstr ""
+
+#: wt-status.c:137
+msgid "both modified:"
+msgstr ""
+
+#: wt-status.c:139
+#, c-format
+msgid "%-20s%s\n"
+msgstr ""
+
+#: wt-status.c:165
+msgid " ("
+msgstr ""
+
+#: wt-status.c:167
+msgid "new commits, "
+msgstr ""
+
+#: wt-status.c:169
+msgid "modified content, "
+msgstr ""
+
+#: wt-status.c:171
+msgid "untracked content, "
+msgstr ""
+
+#: wt-status.c:185
+#, c-format
+msgid "new file:   %s"
+msgstr ""
+
+#: wt-status.c:188
+#, c-format
+msgid "copied:     %s -> %s"
+msgstr ""
+
+#: wt-status.c:191
+#, c-format
+msgid "deleted:    %s"
+msgstr ""
+
+#: wt-status.c:194
+#, c-format
+msgid "modified:   %s"
+msgstr ""
+
+#: wt-status.c:197
+#, c-format
+msgid "renamed:    %s -> %s"
+msgstr ""
+
+#: wt-status.c:200
+#, c-format
+msgid "typechange: %s"
+msgstr ""
+
+#: wt-status.c:203
+#, c-format
+msgid "unknown:    %s"
+msgstr ""
+
+#: wt-status.c:206
+#, c-format
+msgid "unmerged:   %s"
+msgstr ""
+
+#: wt-status.c:209
+#, c-format
+msgid "bug: unhandled diff status %c"
+msgstr ""
+
+#: wt-status.c:212
+#, c-format
+msgid "%s"
+msgstr ""
+
+#: wt-status.c:215
+#, c-format
+msgid "\n"
+msgstr ""
+
+#: wt-status.c:622
+msgid "On branch "
+msgstr "=C3=81 greininni "
+
+#: wt-status.c:629
+msgid "Not currently on any branch."
+msgstr "Ekki =C3=A1 neinni grein."
+
+#: wt-status.c:639
+msgid "# Initial commit"
+msgstr ""
+
+#: wt-status.c:651
+msgid "Untracked"
+msgstr ""
+
+#: wt-status.c:651
+msgid "add"
+msgstr ""
+
+#: wt-status.c:653
+msgid "Ignored"
+msgstr ""
+
+#: wt-status.c:653
+msgid "add -f"
+msgstr ""
+
+#: wt-status.c:655
+#, c-format
+msgid "# Untracked files not listed%s\n"
+msgstr ""
+
+#: wt-status.c:657
+msgid " (use -u option to show untracked files)"
+msgstr ""
+
+#: wt-status.c:663
+#, c-format
+msgid "# No changes\n"
+msgstr "# Engar breytingar\n"
+
+#: wt-status.c:667
+#, c-format
+msgid "no changes added to commit%s\n"
+msgstr ""
+
+#: wt-status.c:669
+msgid " (use \"git add\" and/or \"git commit -a\")"
+msgstr ""
+
+#: wt-status.c:671
+#, c-format
+msgid "nothing added to commit but untracked files present%s\n"
+msgstr ""
+
+#: wt-status.c:673
+msgid " (use \"git add\" to track)"
+msgstr ""
+
+#: wt-status.c:676
+msgid " (create/copy files and use \"git add\" to track)"
+msgstr ""
+
+#: wt-status.c:678 wt-status.c:681
+#, c-format
+msgid "nothing to commit%s\n"
+msgstr ""
+
+#: wt-status.c:679
+msgid " (use -u to show untracked files)"
+msgstr ""
+
+#: wt-status.c:682
+msgid " (working directory clean)"
+msgstr ""
+
+#: git-pull.sh:124
+msgid "Fetching tags only, you probably meant:"
+msgstr "N=C3=A6 a=C3=B0eins =C3=AD t=C3=B6gg, =C3=BE=C3=BA =C3=A1ttir =
l=C3=ADkast til vi=C3=B0:"
+
+#: git-pull.sh:125
+msgid "  git fetch --tags"
+msgstr ""
+
+#: git-pull.sh:157
+msgid ""
+"You are not currently on a branch, so I cannot use any\n"
+"'branch.<branchname>.merge' in your configuration file.\n"
+"Please specify which remote branch you want to use on the command\n"
+"line and try again (e.g. 'git pull <repository> <refspec>').\n"
+"See git-pull(1) for details."
+msgstr ""
+
+#: git-send-email.perl:678
+#, perl-format
+msgid "Emails will be sent from: %s\n"
+msgstr "P=C3=B3starnir ver=C3=B0a sendir fr=C3=A1: %s\n"
--=20
1.7.1.251.gec7f5.dirty
