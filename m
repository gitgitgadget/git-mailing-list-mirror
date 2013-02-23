From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv2] l10n: de.po: correct translation of "bisect" messages
Date: Sat, 23 Feb 2013 19:17:58 +0100
Message-ID: <1361643478-7875-1-git-send-email-ralf.thielow@gmail.com>
References: <1361639092-6564-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Sat Feb 23 19:18:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Jg5-0000hV-Lk
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 19:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab3BWSSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 13:18:05 -0500
Received: from mail-bk0-f53.google.com ([209.85.214.53]:57465 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490Ab3BWSSD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 13:18:03 -0500
Received: by mail-bk0-f53.google.com with SMTP id j10so723868bkw.40
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=EcT9HzcNY96XOmD275yVexaka4NbFgAFehWHxBK9uJE=;
        b=aaZt4Z2pZwj7cvOMfdkHrZXkR1ZQ2WzNf4la4HLZCIRCC8zBD2/bbkES2tCJScwgPF
         zMtvAIsG72TUzFlK0yLTy1zjPnMREffvhTyDeQHFuQuqB5N1ee/w6mtc8Ny4neREa7eG
         CmC7BxnBKuSUrM9tVLDhqxsEsxMKkbaGdZ9eWjF4N8W/0mMpBtLH3uM4zA6s2iMmBP90
         /EufPyMnadJrlw7ZPzg7/FpuZfGQBo1a4fbWp/6FzdeRTkUWOhUcs2LxfgbmvLTyiXmG
         PrKvBefk5JVP0OCkuc5zzS/aziCXaJSzn85AzIr4BL0YoCv3B+gt9haU879mvX+/olHK
         W+/w==
X-Received: by 10.204.127.6 with SMTP id e6mr2870318bks.13.1361643481790;
        Sat, 23 Feb 2013 10:18:01 -0800 (PST)
Received: from localhost (dslb-094-223-206-093.pools.arcor-ip.net. [94.223.206.93])
        by mx.google.com with ESMTPS id b21sm1825222bkw.12.2013.02.23.10.18.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 10:18:01 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.22.gb3600c3
In-Reply-To: <1361639092-6564-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216907>

The term "bisect" was translated as "halbieren", we should
translate it as "bin=C3=A4re Suche" (binary search). While at
there, we should leave "bisect run" untranslated since it's
a subcommand of "git bisect".

Suggested-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/po/de.po b/po/de.po
index c0e5398..4df53e4 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1349,11 +1349,11 @@ msgstr "  (alle Konflikte behoben: f=C3=BChren =
Sie \"git commit\" aus)"
 #: wt-status.c:958
 #, c-format
 msgid "You are currently bisecting branch '%s'."
-msgstr "Sie sind gerade beim Halbieren in Zweig '%s'."
+msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche in Zweig '%s'."
=20
 #: wt-status.c:962
 msgid "You are currently bisecting."
-msgstr "Sie sind gerade beim Halbieren."
+msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche."
=20
 #: wt-status.c:965
 msgid "  (use \"git bisect reset\" to get back to the original branch)=
"
@@ -9247,7 +9247,7 @@ msgstr ""
=20
 #: git-bisect.sh:140
 msgid "won't bisect on seeked tree"
-msgstr "\"bisect\" auf gesuchtem Zweig nicht m=C3=B6glich"
+msgstr "bin=C3=A4re Suche auf gesuchtem Zweig nicht m=C3=B6glich"
=20
 #: git-bisect.sh:144
 msgid "Bad HEAD - strange symbolic ref"
@@ -9280,7 +9280,7 @@ msgstr "'git bisect bad' kann nur ein Argument en=
tgegennehmen."
 #. this is less optimum.
 #: git-bisect.sh:273
 msgid "Warning: bisecting only with a bad commit."
-msgstr "Warnung: halbiere nur mit einer fehlerhaften Version"
+msgstr "Warnung: bin=C3=A4re Suche nur mit einer fehlerhaften Version"
=20
 #. TRANSLATORS: Make sure to include [Y] and [n] in your
 #. translation. The program will only accept English input
@@ -9310,7 +9310,7 @@ msgstr ""
=20
 #: git-bisect.sh:347 git-bisect.sh:474
 msgid "We are not bisecting."
-msgstr "Wir sind nicht beim Halbieren."
+msgstr "keine bin=C3=A4re Suche im Gange"
=20
 #: git-bisect.sh:354
 #, sh-format
@@ -9350,12 +9350,12 @@ msgid ""
 "bisect run failed:\n"
 "exit code $res from '$command' is < 0 or >=3D 128"
 msgstr ""
-"Ausf=C3=BChrung der Halbierung fehlgeschlagen:\n"
+"'bisect run' fehlgeschlagen:\n"
 "R=C3=BCckkehrwert $res von '$command' ist < 0 oder >=3D 128"
=20
 #: git-bisect.sh:453
 msgid "bisect run cannot continue any more"
-msgstr "Ausf=C3=BChrung der Halbierung kann nicht mehr fortgesetzt wer=
den"
+msgstr "'bisect run' kann nicht mehr fortgesetzt werden"
=20
 #: git-bisect.sh:459
 #, sh-format
@@ -9363,12 +9363,12 @@ msgid ""
 "bisect run failed:\n"
 "'bisect_state $state' exited with error code $res"
 msgstr ""
-"Ausf=C3=BChrung der Halbierung fehlgeschlagen:\n"
+"'bisect run' fehlgeschlagen:\n"
 "'bisect_state $state' wurde mit Fehlerwert $res beendet"
=20
 #: git-bisect.sh:466
 msgid "bisect run success"
-msgstr "Halbierung erfolgreich ausgef=C3=BChrt"
+msgstr "'bisect run' erfolgreich ausgef=C3=BChrt"
=20
 #: git-pull.sh:21
 msgid ""
--=20
1.8.2.rc0.22.gb3600c3
