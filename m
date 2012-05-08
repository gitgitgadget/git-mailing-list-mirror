From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=2002/10=5D=20l10n=3A=20de=2Epo=3A=20hopefully=20uncontroversial=20fixes?=
Date: Tue,  8 May 2012 19:33:37 +0200
Message-ID: <1336498425-17890-3-git-send-email-ralf.thielow@googlemail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:34:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoJ6-00029S-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab2EHRe3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:29 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41121 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab2EHRe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:26 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn19so437464wib.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Z/GNKtykN1jboDwUZ6OIaL2GbcjQDYQmlVQMS1yH5pY=;
        b=KEo3Mppo3bJU9MFvu3MJb+EAi9oNAvbiqdXy0KYrhOk5taWhoGurxSeOtEwc/7YBzW
         ZLxedM6vx9Db0aJR0FiE9hQ2oVhTUVU7xGppyHaFh2jiGyxbrQTtw5H2q1NPuT4RfKp4
         psf8R8Ke7mNGxkURxV3OC0PqaT4GC/VzeeEtfAi+Psj7aiG+euFhxE5zf1HGGI+QqA7q
         4ha32se8/NDupqj1J6bN/XNOa6a79HGpxqYNLelwatO9e+7OhJmfB7LhIgj4W/aef7/V
         INidfrWCldUSs7O95sPgGkpjK/hvA6Z0JYUjtlLI2DU+W6DTvS+jjuJiZGNA0O5wWO+h
         jWjw==
Received: by 10.180.78.105 with SMTP id a9mr16694049wix.20.1336498466046;
        Tue, 08 May 2012 10:34:26 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
In-Reply-To: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197403>

=46rom: Thomas Rast <trast@student.ethz.ch>

These are all obviously wrong, such as typos or messages where the
current translation is based on a misunderstanding of the original
message.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |   22 +++++++++++-----------
 1 Datei ge=C3=A4ndert, 11 Zeilen hinzugef=C3=BCgt(+), 11 Zeilen entfer=
nt(-)

diff --git a/po/de.po b/po/de.po
index 09099fc..95f2b49 100644
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
@@ -758,7 +758,7 @@ msgstr "Nichts spezifiziert, nichts hinzugef=C3=BCg=
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
@@ -794,7 +794,7 @@ msgstr "git archive: NACK %s"
 #: builtin/archive.c:65
 #, c-format
 msgid "remote error: %s"
-msgstr "Versandfehler: %s"
+msgstr "Fehler am anderen Ende: %s"
=20
 #: builtin/archive.c:66
 msgid "git archive: protocol error"
@@ -2209,11 +2209,11 @@ msgstr "Initialisierte leeres"
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
@@ -3005,7 +3005,7 @@ msgstr "--delete ist inkompatibel mit --all, --mi=
rror und --tags"
=20
 #: builtin/push.c:286
 msgid "--delete doesn't make sense without any refs"
-msgstr "--delete macht ohne irgendeine Referenz ohne keinen Sinn"
+msgstr "--delete macht ohne irgendeine Referenz keinen Sinn"
=20
 #: builtin/reset.c:33
 msgid "mixed"
@@ -3231,7 +3231,7 @@ msgstr "Die Markierungsbeschreibung wurde in %s g=
elassen\n"
=20
 #: builtin/tag.c:421
 msgid "switch 'points-at' requires an object"
-msgstr "Wechseln von 'points-at' erfordert ein Objekt"
+msgstr "Option 'points-at' erfordert ein Objekt"
=20
 #: builtin/tag.c:423
 #, c-format
@@ -3385,7 +3385,7 @@ msgstr "nicht erkannte Option: '$arg'"
 #: git-bisect.sh:99
 #, sh-format
 msgid "'$arg' does not appear to be a valid revision"
-msgstr "'$arg' scheint keine g=C3=BCltige Option zu sein"
+msgstr "'$arg' scheint keine g=C3=BCltige Version zu sein"
=20
 #: git-bisect.sh:117
 msgid "Bad HEAD - I need a HEAD"
@@ -3419,7 +3419,7 @@ msgstr "Schlechte Referenz-Eingabe: $arg"
=20
 #: git-bisect.sh:232
 msgid "Please call 'bisect_state' with at least one argument."
-msgstr "Bitte rufe 'bisect_state' mit mindestens einem Argument."
+msgstr "Bitte rufe 'bisect_state' mit mindestens einem Argument auf."
=20
 #: git-bisect.sh:244
 #, sh-format
@@ -3558,7 +3558,7 @@ msgstr "$reference ist keine g=C3=BCltige Referen=
z"
 #: git-stash.sh:393
 #, sh-format
 msgid "'$args' is not a stash-like commit"
-msgstr "'$args' ist keine \"stash\"-artiger Version"
+msgstr "'$args' ist keine \"stash\"-artige Version"
=20
 #: git-stash.sh:404
 #, sh-format
@@ -3755,7 +3755,7 @@ msgstr "  Warnung: $name beinhaltet nicht Version=
 $sha1_dst"
 #: git-submodule.sh:772
 #, sh-format
 msgid "  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
-msgstr "  Warnung: $name beinhaltet nich die Versionen $sha1_src und $=
sha1_dst"
+msgstr "  Warnung: $name beinhaltet nicht die Versionen $sha1_src und =
$sha1_dst"
=20
 #: git-submodule.sh:797
 msgid "blob"
--=20
1.7.10.129.g1ec31a3
