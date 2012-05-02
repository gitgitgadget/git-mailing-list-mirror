From: Thomas Rast <trast@student.ethz.ch>
Subject: =?UTF-8?q?=5BPATCH=20de=2Epo=203/5=5D=20de=2Epo=3A=20hopefully=20uncontroversial=20fixes?=
Date: Wed, 2 May 2012 15:49:25 +0200
Message-ID: <8a6867724483c746d31bfb041aba2a1417a3fac2.1335966202.git.trast@student.ethz.ch>
References: <cover.1335966202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 02 15:49:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZwF-0004vt-2j
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab2EBNtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:49:40 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:3500 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005Ab2EBNtb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:49:31 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Wed, 2 May
 2012 15:49:29 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 2 May
 2012 15:49:28 +0200
X-Mailer: git-send-email 1.7.10.625.g300dcf
In-Reply-To: <cover.1335966202.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196818>

These are all obviously wrong, such as typos or messages where the
current translation is based on a misunderstanding of the original
message.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 po/de.po |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/po/de.po b/po/de.po
index a7a39ed..d391632 100644
--- a/po/de.po
+++ b/po/de.po
@@ -145,7 +145,7 @@ msgstr "'%s': %s"
 #: grep.c:1308
 #, c-format
 msgid "'%s': short read %s"
-msgstr "'%s': kurz gelesen %s"
+msgstr "'%s': read() zu kurz %s"
=20
 #: help.c:287
 #, c-format
@@ -779,7 +779,7 @@ msgstr "Nichts spezifiziert, nichts hinzugef=C3=BCg=
t.\n"
 #: builtin/add.c:414
 #, c-format
 msgid "Maybe you wanted to say 'git add .'?\n"
-msgstr "Wolltest du vieleicht 'git add .' sagen?\n"
+msgstr "Wolltest du vielleicht 'git add .' sagen?\n"
=20
 #: builtin/add.c:420 builtin/clean.c:95 builtin/commit.c:358 builtin/m=
v.c:82
 #: builtin/rm.c:162
@@ -815,7 +815,7 @@ msgstr "git archive: NACK %s"
 #: builtin/archive.c:65
 #, c-format
 msgid "remote error: %s"
-msgstr "Versandfehler: %s"
+msgstr "Fehler am anderen Ende: %s"
=20
 #: builtin/archive.c:66
 msgid "git archive: protocol error"
@@ -2234,11 +2234,11 @@ msgstr "Initialisierte leeres"
=20
 #: builtin/init-db.c:421
 msgid " shared"
-msgstr " geteilt"
+msgstr " geteiltes"
=20
 #: builtin/init-db.c:440
 msgid "cannot tell cwd"
-msgstr "kann nicht \"cwd\" sagen"
+msgstr "kann aktuelles Verzeichnis nicht bestimmen"
=20
 #: builtin/init-db.c:521 builtin/init-db.c:528
 #, c-format
@@ -2978,7 +2978,7 @@ msgstr ""
 "Zweiges hinter seinem entfernten Gegenst=C3=BCck ist. Wenn du nicht b=
eabsichtigt\n"
 "hast, diesen Zweig zu versenden, kannst du auch den zu versendenden Z=
weig\n"
 "spezifizieren oder die Konfigurationsvariable 'push.default' zu 'curr=
ent'\n"
-"oder 'upstream' setze, um nur den aktuellen Zweig zu versenden."
+"oder 'upstream' setzen, um nur den aktuellen Zweig zu versenden."
=20
 #: builtin/push.c:150
 msgid ""
@@ -3057,7 +3057,7 @@ msgstr "--delete ist inkompatibel mit --all, --mi=
rror und --tags"
=20
 #: builtin/push.c:344
 msgid "--delete doesn't make sense without any refs"
-msgstr "--delete macht ohne irgendeine Referenz ohne keinen Sinn"
+msgstr "--delete macht ohne irgendeine Referenz keinen Sinn"
=20
 #: builtin/reset.c:33
 msgid "mixed"
@@ -3283,7 +3283,7 @@ msgstr "Die Markierungsbeschreibung wurde gelasse=
n in %s\n"
=20
 #: builtin/tag.c:421
 msgid "switch 'points-at' requires an object"
-msgstr "Wechseln von 'points-at' erfordert ein Objekt"
+msgstr "Option 'points-at' erfordert ein Objekt"
=20
 #: builtin/tag.c:423
 #, c-format
@@ -3437,7 +3437,7 @@ msgstr "nicht erkannte Option: '$arg'"
 #: git-bisect.sh:99
 #, sh-format
 msgid "'$arg' does not appear to be a valid revision"
-msgstr "'$arg' scheint keine g=C3=BCltige Option zu sein"
+msgstr "'$arg' scheint keine g=C3=BCltige Version zu sein"
=20
 #: git-bisect.sh:117
 msgid "Bad HEAD - I need a HEAD"
@@ -3471,7 +3471,7 @@ msgstr "Schlechte Referenz-Eingabe: $arg"
=20
 #: git-bisect.sh:232
 msgid "Please call 'bisect_state' with at least one argument."
-msgstr "Bitte rufe 'bisect_state' mit mindestens einem Argument."
+msgstr "Bitte rufe 'bisect_state' mit mindestens einem Argument auf."
=20
 #: git-bisect.sh:244
 #, sh-format
@@ -3610,7 +3610,7 @@ msgstr "$reference ist keine g=C3=BCltige Referen=
z"
 #: git-stash.sh:393
 #, sh-format
 msgid "'$args' is not a stash-like commit"
-msgstr "'$args' ist keine \"stash\"-artiger Version"
+msgstr "'$args' ist keine \"stash\"-artige Version"
=20
 #: git-stash.sh:404
 #, sh-format
@@ -3809,7 +3809,7 @@ msgstr "  Warnung: $name beinhaltet nicht Version=
 $sha1_dst"
 #: git-submodule.sh:776
 #, sh-format
 msgid "  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
-msgstr "  Warnung: $name beinhaltet nich die Versionen $sha1_src und $=
sha1_dst"
+msgstr "  Warnung: $name beinhaltet nicht die Versionen $sha1_src und =
$sha1_dst"
=20
 #: git-submodule.sh:801
 msgid "blob"
--=20
1.7.10.625.g300dcf
