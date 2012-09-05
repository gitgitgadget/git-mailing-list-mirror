From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH/RFC=5D=20l10n=3A=20de=2Epo=3A=20translate=202=20new=20messages?=
Date: Wed,  5 Sep 2012 19:11:40 +0200
Message-ID: <1346865100-10908-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Wed Sep 05 19:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9J8t-0002od-Eo
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 19:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456Ab2IERLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Sep 2012 13:11:48 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59473 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2IERLr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 13:11:47 -0400
Received: by bkwj10 with SMTP id j10so382781bkw.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=qvfwLlrF4R13a2Nt4bDISQ3ud2lP+PlC1D0iwHYflRg=;
        b=M4y3iEXRSTz6yGwTdDZrpslvFnFSwg/ijJXc39axqTO/iMk859pM4bw57soCrgwAgl
         6k2KxFYCscBb+it+0J1MPcbBE2Nim+kiBtfsAF/nfidZWjzp1m5IsuuDNs100qukK1Rb
         hf7qwXzCVBOm322rA+gD2NeEQjYO7E50KzYk4MlZ8KQ5BqOFU9im9FqIzcAOEoGg6AuV
         Z6wzTW5tCfUc9H5qNtmf7ZUqz4+iu0WE/Kes/JKbLCXSpmbIrg9haHX85A26sdx88tdm
         mEGBEucpwqaO6QwA4lbaaTOjcAUV6Ga/Ajf8oEjoFsD2+Jzxv5+IHwz7jLBjuSB6I8OM
         /BSg==
Received: by 10.204.129.16 with SMTP id m16mr10014848bks.136.1346865105983;
        Wed, 05 Sep 2012 10:11:45 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id j9sm1744882bkv.0.2012.09.05.10.11.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 10:11:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204835>

Translate 2 new messages came from git.pot update in
ccfca8d (l10n: Update git.pot (2 new, 4 removed messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

Hi German l10n team,

please review this small update on German translation.
This patch here is based on a preparation commit which
just contains the "msgmerge" change.
=46or an easier review, I'll copy the first message in english
in this email.
The second change shows that there are some newlines, came
from 'msgmerge', on places where we don't want to have them.
I'll fix that soon.

A hint on this translation:
I've translated "See 'git help config' and search for" as
"F=C3=BChre 'git help config' aus und suche nach...", not as
"Siehe 'git help config' und suche nach..." because the second
doesn't sound good to me. Perhaps someone else has a better
idea.

Thanks,
Ralf

#: builtin/push.c:151
msgid ""
"push.default is unset; its implicit value is changing in\n"
"Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
"and maintain the current behavior after the default changes, use:\n"
"\n"
"  git config --global push.default matching\n"
"\n"
"To squelch this message and adopt the new behavior now, use:\n"
"\n"
"  git config --global push.default simple\n"
"\n"
"See 'git help config' and search for 'push.default' for further "
"information.\n"
"(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\=
n"
"'current' instead of 'simple' if you sometimes use older versions of G=
it)"

 po/de.po | 20 ++++++++++++++++++--
 1 Datei ge=C3=A4ndert, 18 Zeilen hinzugef=C3=BCgt(+), 2 Zeilen entfern=
t(-)

diff --git a/po/de.po b/po/de.po
index f3d232e..df5187e 100644
--- a/po/de.po
+++ b/po/de.po
@@ -4431,6 +4431,23 @@ msgid ""
 "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode=
\n"
 "'current' instead of 'simple' if you sometimes use older versions of =
Git)"
 msgstr ""
+"'push.default' ist nicht gesetzt; der implizit gesetzte Wert wird in\=
n"
+"Git 2.0 von 'matching' nach 'simple' ge=C3=A4ndert. Um diese Meldung =
zu unter-\n"
+"dr=C3=BCcken und das aktuelle Verhalten nach =C3=84nderung des Standa=
rdwertes\n"
+"beizubehalten, benutze:"
+"\n"
+"  git config --global push.default matching\n"
+"\n"
+"Um diese Meldung zu unterdr=C3=BCcken und das neue Verhalten jetzt zu=
 =C3=BCbernehmen,\n"
+"benutze:\n"
+"\n"
+"  git config --global push.default simple\n"
+"\n"
+"F=C3=BChre 'git help config' aus und suche nach 'push.default' f=C3=BC=
r weitere "
+"Informationen.\n"
+"(Der Modus 'simple' wurde in Git 1.7.11 eingef=C3=BChrt. Benutze den =
gleichartigen"
+" Modus 'current' anstatt 'simple', falls du gelegentlich =C3=A4ltere =
Versionen von"
+" Git benutzt)"
=20
 #: builtin/push.c:199
 msgid ""
@@ -4453,7 +4470,6 @@ msgstr ""
 "f=C3=BCr weitere Details."
=20
 #: builtin/push.c:212
-#, fuzzy
 msgid ""
 "Updates were rejected because a pushed branch tip is behind its remot=
e\n"
 "counterpart. If you did not intend to push that branch, you may want =
to\n"
@@ -4465,7 +4481,7 @@ msgstr ""
 "beabsichtigt hast, diesen Zweig zu versenden, kannst du auch den zu "
 "versendenden\n"
 "Zweig spezifizieren oder die Konfigurationsvariable 'push.default' zu=
 "
-"'current'\n"
+"'simple', 'current'\n"
 "oder 'upstream' setzen, um nur den aktuellen Zweig zu versenden."
=20
 #: builtin/push.c:218
--=20
1.7.12
