From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix translation of 'prefix'
Date: Fri,  3 Jan 2014 18:28:30 +0100
Message-ID: <1388770110-3691-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Fri Jan 03 18:28:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz8Y7-00039B-UH
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 18:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbaACR2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jan 2014 12:28:40 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:39599 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbaACR2j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 12:28:39 -0500
Received: by mail-ee0-f48.google.com with SMTP id e49so6755634eek.35
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 09:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=De8D+TFPXBZBk0OfhG0hFafKILFdnT35DyVwNVoTKc4=;
        b=BUxuXN+XoJnu3fVAsrxDpWSw4mSFoMmVVQSWYCW/UqaKZlremBRncZwuiwnPKbQ29I
         12soaDXbJ0FmHDUb5gxFiceYeg9oKoQ3vyxUGtrJ2JDGSUWZ7Qhp5wEhP/Xn9oboA7+d
         8UgYyyD3LxbvFRk4mys4zm5LrD1RH6VgxRY7p76BgtqP3XJoBRR1I+cmIE8BECSphPIk
         Om1w/wYWM4nPhYsuw25yyiAI8ZJeBioZxRALcUObunrLMBG+JnfAIKRxjN7BkX0SUiKK
         I4rKh7tImJpH05qSTmfMeNR/XWhyW4OtiXVduNENLNlqbh0+I3lt37zZYlyxSVg4ghPH
         6Vig==
X-Received: by 10.14.199.197 with SMTP id x45mr75840442een.8.1388770118028;
        Fri, 03 Jan 2014 09:28:38 -0800 (PST)
Received: from localhost (dslb-188-103-232-122.pools.arcor-ip.net. [188.103.232.122])
        by mx.google.com with ESMTPSA id 1sm146670407eeg.4.2014.01.03.09.28.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jan 2014 09:28:37 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.314.gb83cf2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239916>

The word 'prefix' is currently translated as 'Prefix'
which is not a German word. It should be translated as
'Pr=C3=A4fix'.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/po/de.po b/po/de.po
index 5e2d709..c0bbb65 100644
--- a/po/de.po
+++ b/po/de.po
@@ -72,7 +72,7 @@ msgstr "Archivformat"
=20
 #: archive.c:328 builtin/log.c:1193
 msgid "prefix"
-msgstr "Prefix"
+msgstr "Pr=C3=A4fix"
=20
 #: archive.c:329
 msgid "prepend prefix to each pathname in the archive"
@@ -3716,7 +3716,7 @@ msgid ""
 msgstr ""
 "Eingabehilfe:\n"
 "1          - nummeriertes Element ausw=C3=A4hlen\n"
-"foo        - Element anhand eines eindeutigen Prefix ausw=C3=A4hlen\n=
"
+"foo        - Element anhand eines eindeutigen Pr=C3=A4fix ausw=C3=A4h=
len\n"
 "           - (leer) nichts ausw=C3=A4hlen"
=20
 #: builtin/clean.c:298
@@ -3734,7 +3734,7 @@ msgstr ""
 "1          - einzelnes Element ausw=C3=A4hlen\n"
 "3-5        - Bereich von Elementen ausw=C3=A4hlen\n"
 "2-3,6-9    - mehrere Bereiche ausw=C3=A4hlen\n"
-"foo        - Element anhand eines eindeutigen Prefix ausw=C3=A4hlen\n=
"
+"foo        - Element anhand eines eindeutigen Pr=C3=A4fix ausw=C3=A4h=
len\n"
 "-...       - angegebenes Element abw=C3=A4hlen\n"
 "*          - alle Elemente ausw=C3=A4hlen\n"
 "           - (leer) Auswahl beenden"
@@ -6452,7 +6452,7 @@ msgstr "kennzeichnet die Serie als n-te Fassung"
=20
 #: builtin/log.c:1194
 msgid "Use [<prefix>] instead of [PATCH]"
-msgstr "verwendet [<Prefix>] anstatt [PATCH]"
+msgstr "verwendet [<Pr=C3=A4fix>] anstatt [PATCH]"
=20
 #: builtin/log.c:1197
 msgid "store resulting files in <dir>"
@@ -8182,7 +8182,7 @@ msgid ""
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
 "index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish=
3>]])"
 msgstr ""
-"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<Prefix>] "
+"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<Pr=C3=A4fix>] "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
 "index-output=3D<Datei>] (--empty | <Commit-Referenz1> [<Commit-Refere=
nz2> "
 "[<Commit-Referenz3>]])"
@@ -9782,15 +9782,15 @@ msgstr "gibt Tag-Inhalte aus"
=20
 #: builtin/write-tree.c:13
 msgid "git write-tree [--missing-ok] [--prefix=3D<prefix>/]"
-msgstr "git write-tree [--missing-ok] [--prefix=3D<Prefix>/]"
+msgstr "git write-tree [--missing-ok] [--prefix=3D<Pr=C3=A4fix>/]"
=20
 #: builtin/write-tree.c:26
 msgid "<prefix>/"
-msgstr "<Prefix>/"
+msgstr "<Pr=C3=A4fix>/"
=20
 #: builtin/write-tree.c:27
 msgid "write tree object for a subdirectory <prefix>"
-msgstr "schreibt das \"Tree\"-Objekt f=C3=BCr ein Unterverzeichnis <Pr=
efix>"
+msgstr "schreibt das \"Tree\"-Objekt f=C3=BCr ein Unterverzeichnis <Pr=
=C3=A4fix>"
=20
 #: builtin/write-tree.c:30
 msgid "only useful for debugging"
--=20
1.8.5.2.314.gb83cf2e
