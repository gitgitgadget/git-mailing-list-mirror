From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] gitk: Update msgid's for menu items with accelerator
Date: Tue, 20 Oct 2015 14:33:02 +0200
Message-ID: <1445344384-12762-3-git-send-email-tiwai@suse.de>
References: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 14:33:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoW6q-0006b9-OH
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 14:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbbJTMdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2015 08:33:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:35272 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbbJTMdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 08:33:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C3486ACEB;
	Tue, 20 Oct 2015 12:33:16 +0000 (UTC)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279908>

The commit d99b4b0de27a ("gitk: Accelerators for the main menu")
modified the menu item strings with the accelerator, but the
translations didn't follow, thus the menus are shown without
translations.

This patch systematically update the msgid keys just to follow this
change.  The contents aren't changed, so the accelerator won't work in
these locales for now.  Each locale translator needs to add proper
acceleration keys appropriately.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 gitk-git/po/bg.po    | 34 +++++++++++++++++-----------------
 gitk-git/po/ca.po    | 34 +++++++++++++++++-----------------
 gitk-git/po/de.po    | 34 +++++++++++++++++-----------------
 gitk-git/po/es.po    | 34 +++++++++++++++++-----------------
 gitk-git/po/fr.po    | 34 +++++++++++++++++-----------------
 gitk-git/po/hu.po    | 34 +++++++++++++++++-----------------
 gitk-git/po/it.po    | 36 ++++++++++++++++++------------------
 gitk-git/po/ja.po    | 34 +++++++++++++++++-----------------
 gitk-git/po/pt_br.po | 34 +++++++++++++++++-----------------
 gitk-git/po/ru.po    | 34 +++++++++++++++++-----------------
 gitk-git/po/sv.po    | 34 +++++++++++++++++-----------------
 gitk-git/po/vi.po    | 34 +++++++++++++++++-----------------
 12 files changed, 205 insertions(+), 205 deletions(-)

diff --git a/gitk-git/po/bg.po b/gitk-git/po/bg.po
index 61073ebf6b56..909a56463fe6 100644
--- a/gitk-git/po/bg.po
+++ b/gitk-git/po/bg.po
@@ -89,71 +89,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "=D0=9D=D0=BE=D0=B2 =D0=B8=D0=B7=D0=B3=D0=BB=D0=B5=D0=B4=E2=80=A6=
"
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/ca.po b/gitk-git/po/ca.po
index 976037a64504..d17691ef8d22 100644
--- a/gitk-git/po/ca.po
+++ b/gitk-git/po/ca.po
@@ -91,71 +91,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "Vista nova..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/de.po b/gitk-git/po/de.po
index 1a3264b2b002..56c053b98428 100644
--- a/gitk-git/po/de.po
+++ b/gitk-git/po/de.po
@@ -89,71 +89,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "Neue Ansicht ..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/es.po b/gitk-git/po/es.po
index 6402a411a6e8..ddcb0a5f68dc 100644
--- a/gitk-git/po/es.po
+++ b/gitk-git/po/es.po
@@ -91,71 +91,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "Nueva vista..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/fr.po b/gitk-git/po/fr.po
index 6b1f05c6b906..80f72fb4535a 100644
--- a/gitk-git/po/fr.po
+++ b/gitk-git/po/fr.po
@@ -93,71 +93,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "Nouvelle vue..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/hu.po b/gitk-git/po/hu.po
index 00023f1cab41..66fd75ba5b16 100644
--- a/gitk-git/po/hu.po
+++ b/gitk-git/po/hu.po
@@ -88,71 +88,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "=C3=9Aj n=C3=A9zet ..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/it.po b/gitk-git/po/it.po
index b8212b17009b..b5f002db7d52 100644
--- a/gitk-git/po/it.po
+++ b/gitk-git/po/it.po
@@ -89,71 +89,71 @@ msgid "Cancel"
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
-msgstr "File"
+msgid "&File"
+msgstr "&File"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "Nuova vista..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/ja.po b/gitk-git/po/ja.po
index 8bbc67f6b58a..9bbbadd3b427 100644
--- a/gitk-git/po/ja.po
+++ b/gitk-git/po/ja.po
@@ -90,71 +90,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "=E6=96=B0=E8=A6=8F=E3=83=93=E3=83=A5=E3=83=BC..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/pt_br.po b/gitk-git/po/pt_br.po
index 07e5d63b65cc..3f78f1b74826 100644
--- a/gitk-git/po/pt_br.po
+++ b/gitk-git/po/pt_br.po
@@ -90,71 +90,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "Nova vista..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/ru.po b/gitk-git/po/ru.po
index f1bac879e3a6..acd65785be32 100644
--- a/gitk-git/po/ru.po
+++ b/gitk-git/po/ru.po
@@ -86,71 +86,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=
=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/sv.po b/gitk-git/po/sv.po
index 0bd46d788101..75317f43965b 100644
--- a/gitk-git/po/sv.po
+++ b/gitk-git/po/sv.po
@@ -92,71 +92,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "Ny vy..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
diff --git a/gitk-git/po/vi.po b/gitk-git/po/vi.po
index 7133c422b736..0d0f6f0bcffe 100644
--- a/gitk-git/po/vi.po
+++ b/gitk-git/po/vi.po
@@ -88,71 +88,71 @@ msgid "Cancel"
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
-msgid "New view..."
+msgid "&New view..."
 msgstr "Th=C3=AAm tr=C3=ACnh b=C3=A0y m=E1=BB=9Bi..."
=20
 #: gitk:2085
-msgid "Edit view..."
+msgid "&Edit view..."
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
2.6.1
