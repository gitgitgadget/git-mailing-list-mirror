From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate "revision" consistently as "Revision"
Date: Fri,  1 Feb 2013 19:42:13 +0100
Message-ID: <1359744133-5520-1-git-send-email-ralf.thielow@gmail.com>
References: <1359398014-3325-2-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jojo@schmitz-digital.de
X-From: git-owner@vger.kernel.org Fri Feb 01 19:42:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1LZY-00011L-AY
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771Ab3BASm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Feb 2013 13:42:27 -0500
Received: from mail-bk0-f51.google.com ([209.85.214.51]:37596 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871Ab3BASmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 13:42:25 -0500
Received: by mail-bk0-f51.google.com with SMTP id ik5so1957242bkc.24
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 10:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=VhUyCgr0QnFKg4OaoyiAmCCLyotZA79+1a1B2pV5HXw=;
        b=gnmedcPBu23bmN0IroTZ31ROsjSZQtnEyhD02YU9x2BKx3Pnadw9vKrKMFeQ/iQEMb
         do6VQELanJBWzrJJoqcWh+hs5ScxL7iv2HaKw2naBFt7mj4fcJxcQw5cXQhPOAJkE5wD
         olDGkVk5X46GW5WL6CoA0LJpLePCyeL7JdDaYScwfIeIuS0xCC3oD0pQ0y+lSd3KnJYc
         jrKP8+X+HZB2uORN1RDzqR3dR+j47LXLJhs9I0PpOwI/jTXQ6z7l1VRPfbQnWqPSl2p5
         QGR4I/8qD4YBv/+bAeRU8q0+HRTK59Gzc4LAyLzCd/iLkedhp6yg7wgz1LpD6xL7p5xB
         IwRQ==
X-Received: by 10.204.127.6 with SMTP id e6mr3624941bks.13.1359744143948;
        Fri, 01 Feb 2013 10:42:23 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id z5sm3188496bkv.11.2013.02.01.10.42.22
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 10:42:23 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.623.g7d3a2ef
In-Reply-To: <1359398014-3325-2-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215247>

In the current German translation, the word "revision" was
translated as both "Version" (translation of "commit") and
"Revision". Since a revision in Git is not necessarily a
commit, we should not translate it with the same word in
order to give the user an idea that it's not necessarily
the same. After this commit, "revision" is consistently
translated as "Revision".

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
This replaces a patch [1] earlier sent to the list.
I've also updated the glossary [2] of the German translation.

[1]
http://article.gmane.org/gmane.comp.version-control.git/214852
[2]
https://github.com/ralfth/git-po-de/wiki/Glossary

 po/de.po | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/po/de.po b/po/de.po
index ed8330a..0a94b4b 100644
--- a/po/de.po
+++ b/po/de.po
@@ -4438,7 +4438,7 @@ msgid ""
 msgstr ""
 "Kein externes Projektarchiv angegeben. Bitte geben Sie entweder eine =
URL\n"
 "oder den Namen des externen Archivs an, von welchem neue\n"
-"Versionen angefordert werden sollen."
+"Revisionen angefordert werden sollen."
=20
 #: builtin/fetch.c:932
 msgid "You need to specify a tag name."
@@ -4623,7 +4623,7 @@ msgstr ""
=20
 #: builtin/grep.c:22
 msgid "git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]"
-msgstr "git grep [Optionen] [-e] <Muster> [<Version>...] [[--] <Pfad>.=
=2E.]"
+msgstr "git grep [Optionen] [-e] <Muster> [<Revision>...] [[--] <Pfad>=
=2E..]"
=20
 #: builtin/grep.c:217
 #, c-format
@@ -5501,7 +5501,7 @@ msgstr "ung=C3=BCltiges in-reply-to: %s"
=20
 #: builtin/log.c:913
 msgid "git format-patch [options] [<since> | <revision range>]"
-msgstr "git format-patch [Optionen] [<seit> | <Versionsbereich>]"
+msgstr "git format-patch [Optionen] [<seit> | <Revisionsbereich>]"
=20
 #: builtin/log.c:958
 msgid "Two output directories?"
@@ -6193,7 +6193,7 @@ msgstr "findet Vorfahren f=C3=BCr eine einzelne n=
-Wege-Zusammenf=C3=BChrung"
=20
 #: builtin/merge-base.c:100
 msgid "list revs not reachable from others"
-msgstr "listet Revisionen auf, die nicht durch Andere erreichbar sind"
+msgstr "listet Versionen auf, die nicht durch Andere erreichbar sind"
=20
 #: builtin/merge-base.c:102
 msgid "is the first one ancestor of the other?"
@@ -7952,7 +7952,7 @@ msgstr "'%s' Zur=C3=BCcksetzung ist in einem blo=C3=
=9Fen Projektarchiv nicht erlaubt"
 #: builtin/reset.c:333
 #, c-format
 msgid "Could not reset index file to revision '%s'."
-msgstr "Konnte Bereitstellungsdatei nicht zu Version '%s' zur=C3=BCcks=
etzen."
+msgstr "Konnte Bereitstellungsdatei nicht zu Revision '%s' zur=C3=BCck=
setzen."
=20
 #: builtin/reset.c:339
 msgid "Unstaged changes after reset:"
@@ -9053,7 +9053,7 @@ msgstr "nicht erkannte Option: '$arg'"
 #: git-bisect.sh:99
 #, sh-format
 msgid "'$arg' does not appear to be a valid revision"
-msgstr "'$arg' scheint keine g=C3=BCltige Version zu sein"
+msgstr "'$arg' scheint keine g=C3=BCltige Revision zu sein"
=20
 #: git-bisect.sh:117
 msgid "Bad HEAD - I need a HEAD"
@@ -9116,7 +9116,7 @@ msgid ""
 "You need to give me at least one good and one bad revisions.\n"
 "(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
 msgstr ""
-"Sie m=C3=BCssen mindestens eine korrekte und eine fehlerhafte Version=
 angeben.\n"
+"Sie m=C3=BCssen mindestens eine korrekte und eine fehlerhafte Revisio=
n angeben.\n"
 "(Sie k=C3=B6nnen daf=C3=BCr \"git bisect bad\" und \"git bisect good\=
" benutzen.)"
=20
 #: git-bisect.sh:292
@@ -9126,7 +9126,7 @@ msgid ""
 "(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
 msgstr ""
 "Sie m=C3=BCssen mit \"git bisect start\" beginnen.\n"
-"Danach m=C3=BCssen Sie mindestens eine korrekte und eine fehlerhafte =
Version "
+"Danach m=C3=BCssen Sie mindestens eine korrekte und eine fehlerhafte =
Revision "
 "angeben.\n"
 "(Sie k=C3=B6nnen daf=C3=BCr \"git bisect bad\" und \"git bisect good\=
" benutzen.)"
=20
@@ -9650,7 +9650,7 @@ msgstr ""
 #: git-submodule.sh:662
 #, sh-format
 msgid "Unable to find current revision in submodule path '$sm_path'"
-msgstr "Konnte aktuelle Version in Unterprojekt-Pfad '$sm_path' nicht =
finden"
+msgstr "Konnte aktuelle Revision in Unterprojekt-Pfad '$sm_path' nicht=
 finden"
=20
 #: git-submodule.sh:671 git-submodule.sh:695
 #, sh-format
--=20
1.8.1.2.623.g7d3a2ef
