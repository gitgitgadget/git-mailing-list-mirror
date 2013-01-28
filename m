From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate "reset" as "neu setzen"
Date: Mon, 28 Jan 2013 19:33:34 +0100
Message-ID: <1359398014-3325-3-git-send-email-ralf.thielow@gmail.com>
References: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com>
 <1359398014-3325-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jojo@schmitz-digital.de
X-From: git-owner@vger.kernel.org Mon Jan 28 19:34:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TztX7-0004Jt-IA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab3A1Sdx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 13:33:53 -0500
Received: from mail-bk0-f51.google.com ([209.85.214.51]:44520 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab3A1Sdt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:33:49 -0500
Received: by mail-bk0-f51.google.com with SMTP id ik5so1561160bkc.38
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 10:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=GAiJ0jl5+01IIzSfgXEyNC1We7zZwnTIiUSU6uwr3t8=;
        b=iLgNZEgJoQbu8sNeUBDg0PF4k0rls2O4818gr0ZASJVeBegDcmklvlnh0XJR/mLhh2
         W9E6ib6u/eQhJDzj4OSUtGc13G53FTyQlBWQA7+bvY1YhyaPlpQE2Qg0Y6hu7NK5b/Ff
         FX5PlC0qwwQn8wesFsKFlHzqgg0Macgo+yAv/hUzLvILVpSAluSr29+WXLczM+lBc5lV
         QWnD69HCZzSxpW8CrXPTi0wWRaW1cGpWDygxyczcSYTEaFBrgzitx1wMnWgjbyy0Kmag
         I+Ni9ZTyUekTk4F6wWKX394cyVpNjvexiZn8bVi6QxN8e4lZTJeebcMTnMaKClwjjRjk
         w3cA==
X-Received: by 10.204.3.205 with SMTP id 13mr4196980bko.38.1359398028040;
        Mon, 28 Jan 2013 10:33:48 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id n1sm7137805bkv.14.2013.01.28.10.33.46
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 10:33:47 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.439.g50a6b54
In-Reply-To: <1359398014-3325-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214853>

According to the glossary, "reset" should be
translated as "neu setzen" but in a couple of
messages we've translated it as "zur=C3=BCcksetzen".
This fixes that.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

Note that the part "neu" is not used in any places because
I think sometimes it sounds better without them.

 po/de.po | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/po/de.po b/po/de.po
index 6c7384b..9b1f589 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2764,7 +2764,7 @@ msgstr "Zweigspitze (HEAD) ist jetzt bei"
 #: builtin/checkout.c:609
 #, c-format
 msgid "Reset branch '%s'\n"
-msgstr "Setze Zweig '%s' zur=C3=BCck\n"
+msgstr "Setze Zweig '%s' neu\n"
=20
 #: builtin/checkout.c:612
 #, c-format
@@ -2774,7 +2774,7 @@ msgstr "Bereits auf '%s'\n"
 #: builtin/checkout.c:616
 #, c-format
 msgid "Switched to and reset branch '%s'\n"
-msgstr "Gewechselt zu zur=C3=BCckgesetztem Zweig '%s'\n"
+msgstr "Gewechselt zu neu gesetztem Zweig '%s'\n"
=20
 #: builtin/checkout.c:618 builtin/checkout.c:955
 #, c-format
@@ -7900,19 +7900,19 @@ msgstr "weniger Ausgaben, meldet nur Fehler"
=20
 #: builtin/reset.c:250
 msgid "reset HEAD and index"
-msgstr "setzt Zweigspitze (HEAD) und Bereitstellung zur=C3=BCck"
+msgstr "setzt Zweigspitze (HEAD) und Bereitstellung neu"
=20
 #: builtin/reset.c:251
 msgid "reset only HEAD"
-msgstr "setzt nur Zweigspitze (HEAD) zur=C3=BCck"
+msgstr "setzt nur Zweigspitze (HEAD) neu"
=20
 #: builtin/reset.c:253 builtin/reset.c:255
 msgid "reset HEAD, index and working tree"
-msgstr "setzt Zweigspitze (HEAD), Bereitstellung und Arbeitsbaum zur=C3=
=BCck"
+msgstr "setzt Zweigspitze (HEAD), Bereitstellung und Arbeitsbaum neu"
=20
 #: builtin/reset.c:257
 msgid "reset HEAD but keep local changes"
-msgstr "setzt Zweigspitze (HEAD) zur=C3=BCck, beh=C3=A4lt aber lokale =
=C3=84nderungen"
+msgstr "setzt Zweigspitze (HEAD) neu, beh=C3=A4lt aber lokale =C3=84nd=
erungen"
=20
 #: builtin/reset.c:275
 #, c-format
@@ -7952,7 +7952,7 @@ msgstr "'%s' Zur=C3=BCcksetzung ist in einem blo=C3=
=9Fen Projektarchiv nicht erlaubt"
 #: builtin/reset.c:333
 #, c-format
 msgid "Could not reset index file to revision '%s'."
-msgstr "Konnte Bereitstellungsdatei nicht zu Version '%s' zur=C3=BCcks=
etzen."
+msgstr "Konnte Bereitstellungsdatei nicht zu Version '%s' setzen."
=20
 #: builtin/reset.c:339
 msgid "Unstaged changes after reset:"
@@ -8833,7 +8833,7 @@ msgstr "Baut lokale Versionen auf einem aktueller=
em externen Zweig neu auf"
 #: common-cmds.h:24
 msgid "Reset current HEAD to the specified state"
 msgstr ""
-"Setzt die aktuelle Zweigspitze (HEAD) zu einem spezifizierten Zustand=
 zur=C3=BCck"
+"Setzt die aktuelle Zweigspitze (HEAD) zu einem spezifizierten Zustand=
"
=20
 #: common-cmds.h:25
 msgid "Remove files from the working tree and from the index"
--=20
1.8.1.1.439.g50a6b54
