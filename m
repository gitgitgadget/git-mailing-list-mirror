From: =?UTF-8?q?Micka=C3=ABl=20Thomas?= <mickael9@gmail.com>
Subject: [PATCH] Add main menu accelerators to po files
Date: Tue, 27 Oct 2015 01:29:15 +0100
Message-ID: <1445905755-19770-1-git-send-email-mickael9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micka=C3=ABl=20Thomas?= <mickael9@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 01:29:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqs9D-0003I5-HY
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 01:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbbJ0A3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2015 20:29:51 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34035 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbbJ0A3t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 20:29:49 -0400
Received: by wikq8 with SMTP id q8so188507207wik.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 17:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=aTaN/LQPQ41Y7/eeOjnBB8tbiIkPijFXKIhfwQyd6Sw=;
        b=MXdlO2dDtBEqgmTVHG2ycik9oPINd7FdUcWDp2FZzqw7W6GO914oo/S0tSfHUk6zQG
         G7aNRtbUOLkJKbFfAf41Zom8R1Ek3+Vvwf/rnBqa2KWoLFql9pNz8lFhKF7Ju3A1aY+p
         JohDwX42eQXLRrgull7fYfpDZoePkoSWvGLlOCXQztCB06bMjc4+55ZcEK5IhF/T7OXv
         r12xKuIkfSS6nOhjZRwnrSFtJ8//BgcX5UI54RoJB26sxm4GqjI02yVOJ1YexFLnE60c
         wjvOdYaXlk2MF0R08noxq2xcXWwilAhOlOdg/HO1U8qe5FwFziZaWtJTdMU1SvLRV5RB
         wZng==
X-Received: by 10.180.216.105 with SMTP id op9mr25370201wic.13.1445905788168;
        Mon, 26 Oct 2015 17:29:48 -0700 (PDT)
Received: from mickael-laptop.localdomain (home.mickael9.tk. [82.226.104.223])
        by smtp.gmail.com with ESMTPSA id ly4sm41749035wjb.4.2015.10.26.17.29.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2015 17:29:46 -0700 (PDT)
Received: by mickael-laptop.localdomain (Postfix, from userid 1000)
	id 436F2360985; Tue, 27 Oct 2015 01:29:45 +0100 (CET)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280236>

This adds accelerators introduced in previous commit to the po files so
that the old translations without accelerators are used instead of the
untranslated strings with accelerators.

Translations will have to be updated manually to add the new
accelerators in the right place.

Signed-off-by: Micka=C3=ABl Thomas <mickael9@gmail.com>
---
 po/bg.po    | 30 +++++++++++++++---------------
 po/ca.po    | 30 +++++++++++++++---------------
 po/de.po    | 30 +++++++++++++++---------------
 po/es.po    | 30 +++++++++++++++---------------
 po/fr.po    | 30 +++++++++++++++---------------
 po/hu.po    | 30 +++++++++++++++---------------
 po/it.po    | 30 +++++++++++++++---------------
 po/ja.po    | 30 +++++++++++++++---------------
 po/pt_br.po | 30 +++++++++++++++---------------
 po/ru.po    | 30 +++++++++++++++---------------
 po/sv.po    | 30 +++++++++++++++---------------
 po/vi.po    | 30 +++++++++++++++---------------
 12 files changed, 180 insertions(+), 180 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index 61073eb..1822d56 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -89,39 +89,39 @@ msgid "Cancel"
 msgstr "=D0=9E=D1=82=D0=BA=D0=B0=D0=B7"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "=D0=9F=D1=80=D0=B5=D0=B7=D0=B0=D1=80=D0=B5=D0=B6=D0=B4=D0=B0=D0=
=BD=D0=B5"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "=D0=9D=D0=B0=D0=BD=D0=BE=D0=B2=D0=BE =D0=BF=D1=80=D0=BE=D1=87=D0=
=B8=D1=82=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BD=D0=B0=D1=81=D1=82=D1=80=
=D0=BE=D0=B9=D0=BA=D0=B8=D1=82=D0=B5"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "=D0=98=D0=B7=D0=B1=D1=80=D0=BE=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8=D1=82=D0=
=B5"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "=D0=A1=D1=82=D0=B0=D1=80=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=
=BD=D0=B0 =E2=80=9Egit gui=E2=80=9C"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "=D0=A1=D0=BF=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BF=
=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "=D0=A4=D0=B0=D0=B9=D0=BB"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=
=B5"
=20
 #: gitk:2084
@@ -133,27 +133,27 @@ msgid "Edit view..."
 msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=
=B5 =D0=BD=D0=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0=E2=80=A6"
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "=D0=98=D0=B7=D1=82=D1=80=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=
=B0 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=D0=B0"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "=D0=92=D1=81=D0=B8=D1=87=D0=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=
=BE=D0=B2=D0=B5"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "=D0=98=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE gitk"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "=D0=9A=D0=BB=D0=B0=D0=B2=D0=B8=D1=88=D0=BD=D0=B8 =D0=BA=D0=BE=D0=
=BC=D0=B1=D0=B8=D0=BD=D0=B0=D1=86=D0=B8=D0=B8"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "=D0=9F=D0=BE=D0=BC=D0=BE=D1=89"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/ca.po b/po/ca.po
index 976037a..d3ce6da 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -91,39 +91,39 @@ msgid "Cancel"
 msgstr "Cancel=C2=B7la"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "Actualitza"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "Recarrega"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "Rellegeix les refer=C3=A8ncies"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "Llista les refer=C3=A8ncies"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "Inicia el git gui"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "Surt"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "Fitxer"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Prefer=C3=A8ncies"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "Edita"
=20
 #: gitk:2084
@@ -135,27 +135,27 @@ msgid "Edit view..."
 msgstr "Edita la vista..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Suprimeix vista"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "Tots els fitxers"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "Vista"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "Quant al gitk"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Associacions de tecles"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "Ajuda"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/de.po b/po/de.po
index 1a3264b..c2cad6c 100644
--- a/po/de.po
+++ b/po/de.po
@@ -89,39 +89,39 @@ msgid "Cancel"
 msgstr "Abbrechen"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "Aktualisieren"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "Neu laden"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "Zweige neu laden"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "Zweige/Markierungen auflisten"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "=C2=BBgit gui=C2=AB starten"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "Beenden"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "Datei"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Einstellungen"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "Bearbeiten"
=20
 #: gitk:2084
@@ -133,27 +133,27 @@ msgid "Edit view..."
 msgstr "Ansicht bearbeiten ..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Ansicht entfernen"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "Alle Dateien"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "Ansicht"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "=C3=9Cber gitk"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Tastenk=C3=BCrzel"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "Hilfe"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/es.po b/po/es.po
index 6402a41..cf1c044 100644
--- a/po/es.po
+++ b/po/es.po
@@ -91,39 +91,39 @@ msgid "Cancel"
 msgstr "Cancelar"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "Actualizar"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr ""
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "Releer referencias"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "Lista de referencias"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr ""
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "Salir"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "Archivo"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Preferencias"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "Editar"
=20
 #: gitk:2084
@@ -135,27 +135,27 @@ msgid "Edit view..."
 msgstr "Modificar vista..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Eliminar vista"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "Todos los archivos"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "Vista"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "Acerca de gitk"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Combinaciones de teclas"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "Ayuda"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/fr.po b/po/fr.po
index 6b1f05c..8e44be8 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -93,39 +93,39 @@ msgid "Cancel"
 msgstr "Annuler"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "Mise =C3=A0 jour"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "Recharger"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "Relire les r=C3=A9f=C3=A9rences"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "Lister les r=C3=A9f=C3=A9rences"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "D=C3=A9marrer git gui"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "Quitter"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "Fichier"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Pr=C3=A9f=C3=A9rences"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "=C3=89diter"
=20
 #: gitk:2084
@@ -137,27 +137,27 @@ msgid "Edit view..."
 msgstr "=C3=89diter la vue..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Supprimer la vue"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "Tous les fichiers"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "Vue"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "=C3=80 propos de gitk"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Raccourcis clavier"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "Aide"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/hu.po b/po/hu.po
index 00023f1..53bf694 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -88,39 +88,39 @@ msgid "Cancel"
 msgstr "Visszavon=C3=A1s"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "Frissit=C3=A9s"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "=C3=9Ajrat=C3=B6lt=C3=A9s"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "Referenci=C3=A1k =C3=BAjraolvas=C3=A1sa"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "Referenci=C3=A1k list=C3=A1z=C3=A1sa"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "Git gui ind=C3=ADt=C3=A1sa"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "Kil=C3=A9p=C3=A9s"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "F=C3=A1jl"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Be=C3=A1ll=C3=ADt=C3=A1sok"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "Szerkeszt=C3=A9s"
=20
 #: gitk:2084
@@ -132,27 +132,27 @@ msgid "Edit view..."
 msgstr "N=C3=A9zet szerkeszt=C3=A9se ..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "N=C3=A9zet t=C3=B6rl=C3=A9se"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "Minden f=C3=A1jl"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "N=C3=A9zet"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "Gitk n=C3=A9vjegy"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Billenty=C5=B1kombin=C3=A1ci=C3=B3"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "Seg=C3=ADts=C3=A9g"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/it.po b/po/it.po
index b8212b1..30a515d 100644
--- a/po/it.po
+++ b/po/it.po
@@ -89,39 +89,39 @@ msgid "Cancel"
 msgstr "Annulla"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "Aggiorna"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "Ricarica"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "Rileggi riferimenti"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "Elenca riferimenti"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "Avvia git gui"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "Esci"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "File"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Preferenze"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "Modifica"
=20
 #: gitk:2084
@@ -133,27 +133,27 @@ msgid "Edit view..."
 msgstr "Modifica vista..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Elimina vista"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "Tutti i file"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "Vista"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "Informazioni su gitk"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Scorciatoie da tastiera"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "Aiuto"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/ja.po b/po/ja.po
index 8bbc67f..79facb3 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -90,39 +90,39 @@ msgid "Cancel"
 msgstr "=E3=82=AD=E3=83=A3=E3=83=B3=E3=82=BB=E3=83=AB"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "=E6=9B=B4=E6=96=B0"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "=E3=83=AA=E3=83=AD=E3=83=BC=E3=83=89"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "=E3=83=AA=E3=83=95=E3=82=A1=E3=83=AC=E3=83=B3=E3=82=B9=E3=82=92=
=E5=86=8D=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=81=BF"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "=E3=83=AA=E3=83=95=E3=82=A1=E3=83=AC=E3=83=B3=E3=82=B9=E3=83=AA=
=E3=82=B9=E3=83=88=E3=82=92=E8=A1=A8=E7=A4=BA"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "git gui =E3=81=AE=E9=96=8B=E5=A7=8B"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "=E7=B5=82=E4=BA=86"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "=E8=A8=AD=E5=AE=9A"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "=E7=B7=A8=E9=9B=86"
=20
 #: gitk:2084
@@ -134,27 +134,27 @@ msgid "Edit view..."
 msgstr "=E3=83=93=E3=83=A5=E3=83=BC=E7=B7=A8=E9=9B=86..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "=E3=83=93=E3=83=A5=E3=83=BC=E5=89=8A=E9=99=A4"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "=E5=85=A8=E3=81=A6=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=
"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "=E3=83=93=E3=83=A5=E3=83=BC"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "gitk =E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "=E3=82=AD=E3=83=BC=E3=83=90=E3=82=A4=E3=83=B3=E3=83=87=E3=82=A3=
=E3=83=B3=E3=82=B0"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "=E3=83=98=E3=83=AB=E3=83=97"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/pt_br.po b/po/pt_br.po
index 07e5d63..47f6833 100644
--- a/po/pt_br.po
+++ b/po/pt_br.po
@@ -90,39 +90,39 @@ msgid "Cancel"
 msgstr "Cancelar"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "Atualizar"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "Recarregar"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "Ler as refer=C3=AAncias novamente"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "Listar refer=C3=AAncias"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "Iniciar Git GUI"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "Sair"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "Arquivo"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Prefer=C3=AAncias"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "Editar"
=20
 #: gitk:2084
@@ -134,27 +134,27 @@ msgid "Edit view..."
 msgstr "Editar vista..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Apagar vista"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "Todos os arquivos"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "Exibir"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "Sobre o gitk"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Atalhos de teclado"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "Ajuda"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/ru.po b/po/ru.po
index f1bac87..7c4a3d5 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -86,39 +86,39 @@ msgid "Cancel"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B0"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D1=81=D0=BF=D0=
=B8=D1=81=D0=BE=D0=BA =D1=81=D1=81=D1=8B=D0=BB=D0=BE=D0=BA"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "=D0=A1=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=81=D1=81=D1=8B=D0=BB=D0=
=BE=D0=BA"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C git gui=
"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D1=8C"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "=D0=A4=D0=B0=D0=B9=D0=BB"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C"
=20
 #: gitk:2084
@@ -130,27 +130,27 @@ msgid "Edit view..."
 msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=
=B5=D0=BD=D0=B8=D0=B5..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=BF=D1=80=D0=B5=D0=
=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "=D0=92=D1=81=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=8B"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=B8=D0=B5"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "=D0=9E gitk"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "=D0=9D=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=
=BA=D0=BB=D0=B0=D0=B2=D0=B8=D0=B0=D1=82=D1=83=D1=80=D1=8B"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "=D0=9F=D0=BE=D0=B4=D1=81=D0=BA=D0=B0=D0=B7=D0=BA=D0=B0"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/sv.po b/po/sv.po
index 0bd46d7..a444ec0 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -92,39 +92,39 @@ msgid "Cancel"
 msgstr "Avbryt"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "Uppdatera"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "Ladda om"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "L=C3=A4s om referenser"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "Visa referenser"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "Starta git gui"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "Avsluta"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "Arkiv"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Inst=C3=A4llningar"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "Redigera"
=20
 #: gitk:2084
@@ -136,27 +136,27 @@ msgid "Edit view..."
 msgstr "=C3=84ndra vy..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Ta bort vy"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "Alla filer"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "Visa"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "Om gitk"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Tangentbordsbindningar"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "Hj=C3=A4lp"
=20
 #: gitk:2185 gitk:8652
diff --git a/po/vi.po b/po/vi.po
index 7133c42..6352b34 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -88,39 +88,39 @@ msgid "Cancel"
 msgstr "Th=C3=B4i"
=20
 #: gitk:2069
-msgid "Update"
+msgid "&Update"
 msgstr "C=E1=BA=ADp nh=E1=BA=ADt"
=20
 #: gitk:2070
-msgid "Reload"
+msgid "&Reload"
 msgstr "T=E1=BA=A3i l=E1=BA=A1i"
=20
 #: gitk:2071
-msgid "Reread references"
+msgid "Reread re&ferences"
 msgstr "=C4=90=E1=BB=8Dc l=E1=BA=A1i tham chi=E1=BA=BFu"
=20
 #: gitk:2072
-msgid "List references"
+msgid "&List references"
 msgstr "Li=E1=BB=87t k=C3=AA c=C3=A1c tham chi=E1=BA=BFu"
=20
 #: gitk:2074
-msgid "Start git gui"
+msgid "Start git &gui"
 msgstr "Kh=E1=BB=9Fi ch=E1=BA=A1y git gui"
=20
 #: gitk:2076
-msgid "Quit"
+msgid "&Quit"
 msgstr "Tho=C3=A1t"
=20
 #: gitk:2068
-msgid "File"
+msgid "&File"
 msgstr "Ch=C3=ADnh"
=20
 #: gitk:2080
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "C=C3=A1 nh=C3=A2n h=C3=B3a"
=20
 #: gitk:2079
-msgid "Edit"
+msgid "&Edit"
 msgstr "Ch=E1=BB=89nh s=E1=BB=ADa"
=20
 #: gitk:2084
@@ -132,27 +132,27 @@ msgid "Edit view..."
 msgstr "S=E1=BB=ADa c=C3=A1ch tr=C3=ACnh b=C3=A0y..."
=20
 #: gitk:2086
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "X=C3=B3a c=C3=A1ch tr=C3=ACnh b=C3=A0y"
=20
 #: gitk:2088 gitk:4043
-msgid "All files"
+msgid "&All files"
 msgstr "M=E1=BB=8Di t=E1=BA=ADp tin"
=20
 #: gitk:2083 gitk:4067
-msgid "View"
+msgid "&View"
 msgstr "Tr=C3=ACnh b=C3=A0y"
=20
 #: gitk:2093 gitk:2103 gitk:3012
-msgid "About gitk"
+msgid "&About gitk"
 msgstr "Gi=E1=BB=9Bi thi=E1=BB=87u v=E1=BB=81 gitk"
=20
 #: gitk:2094 gitk:2108
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "T=E1=BB=95 h=E1=BB=A3p ph=C3=ADm"
=20
 #: gitk:2092 gitk:2107
-msgid "Help"
+msgid "&Help"
 msgstr "Tr=E1=BB=A3 gi=C3=BAp"
=20
 #: gitk:2185 gitk:8652
--=20
2.6.2
