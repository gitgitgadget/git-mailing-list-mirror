From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Update l10n guide
Date: Wed, 29 Feb 2012 00:23:39 -0800
Message-ID: <7vfwduujxw.fsf_-_@alter.siamese.dyndns.org>
References: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com>
 <7v1upew6d0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 29 09:23:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2epC-0006BV-4E
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 09:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab2B2IXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 03:23:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299Ab2B2IXn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 03:23:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80B45463F;
	Wed, 29 Feb 2012 03:23:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+HoTEACC/2OF
	BLt+5LpXqMDVPHI=; b=p8i1aHW1JG3w6kVufmEWvF31Mw4NwRYoqdWANXsZDnL2
	rneD8RddCxIgsiicoaD3YX3+nRhqcoXMasoIpXh5/05kA5Mm1uBDOcWGtkFijPEo
	4upBCAPjZhD9sYhkkg3Q1Dy8RLQkqlOhrwVkFjsYHIytL3NfUSoqqXmUgiB/YLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pQ1ZOr
	jT49tCslFIk8PbfJlOAXiRI5GvyMkMK3PeXQM7onFpP+AGkKYxVmIaQw/DrsRmjM
	2tdRY4cqBM+nqXQ4Urxl55n115SzJoPbImOEeudHgd0+GcpT8DL4+lOp2pMrmoug
	Od4QNXmkt2QOqpqtUMWoVg20WmpBJLRQ2WpMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78ADA463E;
	Wed, 29 Feb 2012 03:23:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 740F6463D; Wed, 29 Feb 2012
 03:23:41 -0500 (EST)
In-Reply-To: <7v1upew6d0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 28 Feb 2012 21:34:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B00659BA-62AE-11E1-A8E0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191817>

Describe the high-level overview of the localization workflow, and upda=
te
the description on po/git.pot file, which no longer is an untracked fil=
e.

Clarify the roles and responsibilities among:

 - the core developers (responsible for marking the translatable string=
s
   and restructuring the code to avoid message-lego);

 - the l10n coordinator (maintaining po/git.pot, interfacing with langu=
age
   teams and feeding updated translations back to the core); and

 - the language teams (updating po/*.po for their language and feeding
   their work back to the l10n coordinator).

This is largely based on an earlier message $gmane/189584 from me.

  Date: Wed, 01 Feb 2012 20:56:18 -0800
  Message-ID: <7vmx91ygst.fsf@alter.siamese.dyndns.org>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I would like to see something like this before we start getting the
   second language team.  Comments are very much appreciated.

   I am not sure if the existing instruction to update the new XX.po
   file copied from git.pot is correct, but I left it as-is.

    @@ -1,6 +1,6 @@
    -# Icelandic translations for PACKAGE package.
    -# Copyright (C) 2010 THE PACKAGE'S COPYRIGHT HOLDER
    -# This file is distributed under the same license as the PACKAGE p=
ackage.
    +# Icelandic translations for Git.
    +# Copyright (C) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com>
    +# This file is distributed under the same license as the Git packa=
ge.
     # =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>, 2010.

   The second line of the template tells us to name the copyright holde=
r
   of the package, not of the translation, but the above example makes =
it
   appear as if we are assigning the copyright to the translator.

 po/README |  106 ++++++++++++++++++++++++++++++++++++++++++++++++-----=
--------
 po/TEAMS  |   10 ++++++
 2 files changed, 94 insertions(+), 22 deletions(-)
 create mode 100644 po/TEAMS

diff --git a/po/README b/po/README
index 10b0ad2..6480882 100644
--- a/po/README
+++ b/po/README
@@ -1,33 +1,78 @@
 Core GIT Translations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-This directory holds the translations for the core of Git. This
-document describes how to add to and maintain these translations, and
-how to mark source strings for translation.
-
+This directory holds the translations for the core of Git. This docume=
nt
+describes how you can contribute to the effort of enhancing the langua=
ge
+coverage and maintaining the translation.
+
+The localization (l10n) coordinator, Jiang Xin <worldhello.net@gmail.c=
om>,
+coordinates our localization effort in his repository:
+
+        https://github.com/gotgit/git-po/
+
+As a contributor for a language XX, you would fork this repository,
+prepare and/or update the translated message file po/XX.po (described
+later), and ask the l10n coordinator to pull your work.
+
+If there are multiple contributors for the same language, please first
+coordinate among yourselves and nominate the team leader for your
+language, so that the l10n coordinator only needs to interact with one
+person per language.
+
+For the list of exiting translations and language teams, see TEAMS fil=
e in
+this directory.
+
+The overall data-flow looks like this:
+
+    +-------------------+            +------------------+
+    | Git source code   | ---(1)---> | L10n coordinator |
+    | repository        | <---(4)--- | repository       |
+    +-------------------+            +------------------+
+                                          |      ^
+                                         (2)    (3)
+                                          V      |
+                                     +------------------+
+                                     | Language Team XX |
+                                     +------------------+
+
+ * Translatable strings are marked in the source file.
+ * L10n coordinator pulls from the source (1)
+ * L10n coordinator updates the message template po/git.pot
+ * Language team pulls from L10n coordinator (2)
+ * Language team updates the message file po/XX.po
+ * L10n coordinator pulls from Language team (3)
+ * L10n coordinator asks the result to be pulled (4).
+
+
+Maintaining the po/git.pot file
+-------------------------------
=20
-Generating a .pot file
-----------------------
+(This is done by the l10n coordinator).
=20
 The po/git.pot file contains a message catalog extracted from Git's
-sources. You need to generate it to add new translations with
-msginit(1), or update existing ones with msgmerge(1).
+sources. The l10n coordinator maintains it by adding new translations =
with
+msginit(1), or update existing ones with msgmerge(1).  In order to upd=
ate
+the Git sources to extract the messages from, the l10n coordinator is
+expected to pull from the main git repository at strategic point in
+history (e.g. when a major release and release candidates are tagged),
+and then run "make pot" at the top-level directory.
=20
-Since the file can be automatically generated it's not checked into
-git.git. To generate it do, at the top-level:
+Language contributors use this file to prepare translations for their
+language, but they are not expected to modify it.
=20
-    make pot
=20
+Initializing a XX.po file
+-------------------------
=20
-Initializing a .po file
------------------------
+(This is done by the language teams).
=20
-To add a new translation first generate git.pot (see above) and then
-in the po/ directory do:
+If your language XX does not have translated message file po/XX.po yet=
,
+you add a translation for the first time by running:
=20
     msginit --locale=3DXX
=20
-Where XX is your locale, e.g. "is", "de" or "pt_BR".
+in the po/ directory, where XX is the locale, e.g. "de", "is", "pt_BR"=
,
+"zh_CN", etc.
=20
 Then edit the automatically generated copyright info in your new XX.po
 to be correct, e.g. for Icelandic:
@@ -46,21 +91,36 @@ just "Git":
=20
     perl -pi -e 's/(?<=3D"Project-Id-Version: )PACKAGE VERSION/Git/' X=
X.po
=20
+Once you are done testing the translation (see below), commit the resu=
lt
+and ask the l10n coordinator to pull from you.
+
+
+Updating a XX.po file
+---------------------
=20
-Updating a .po file
--------------------
+(This is done by the language teams).
=20
-If there's an existing *.po file for your language but you need to
-update the translation you first need to generate git.pot (see above)
-and then in the po/ directory do:
+If you are replacing translation strings in an existing XX.po file to
+improve the translation, just edit the file.
+
+If there's an existing XX.po file for your language, but the repositor=
y
+of the l10n coordinator has newer po/git.pot file, you would need to f=
irst
+pull from the l10n coordinator (see the beginning of this document for=
 its
+URL), and then update the existing translation by running:
=20
     msgmerge --add-location --backup=3Doff -U XX.po git.pot
=20
-Where XX.po is the file you want to update.
+in the po/ directory, where XX.po is the file you want to update.
+
+Once you are done testing the translation (see below), commit the resu=
lt
+and ask the l10n coordinator to pull from you.
+
=20
 Testing your changes
 --------------------
=20
+(This is done by the language teams, after creating or updating XX.po =
file).
+
 Before you submit your changes go back to the top-level and do:
=20
     make
@@ -75,6 +135,8 @@ with a newline or not.
 Marking strings for translation
 -------------------------------
=20
+(This is done by the core developers).
+
 Before strings can be translated they first have to be marked for
 translation.
=20
diff --git a/po/TEAMS b/po/TEAMS
new file mode 100644
index 0000000..8ee6199
--- /dev/null
+++ b/po/TEAMS
@@ -0,0 +1,10 @@
+Core Git translation language teams
+(please keep the list sorted alphabetically on language field)
+
+Language:	is (Icelandic)
+Leader:		=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
+
+Language:	zh_CN (Simplified Chinese)
+Leader:		Jiang Xin <worldhello.net@gmail.com>
+Members:	Yichao Yu <yyc1992@gmail.com>
+		Riku <lu.riku@gmail.com>
--=20
1.7.9.2.344.g3e8c86
