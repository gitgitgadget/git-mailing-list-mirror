From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Further changes, thanks to <tp@lists.linux.it>
Date: Wed, 8 Aug 2007 17:27:39 +0200
Message-ID: <20070808172739.5647a81b@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 17:26:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IInQ5-00089n-PA
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 17:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762521AbXHHPZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 11:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935871AbXHHPZX
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 11:25:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:59339 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935819AbXHHPZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 11:25:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so215847ugf
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 08:25:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=p/aSzKsbX9OYw+LXEJewMH4uZof83zWwS7xt9My/9FatHTuTr8xqmupx6RFPUc/BbFpshjGOvEN0LCW6QwAUGmU7mhMZzGPeVaAzNULx421SBX+65FYOWumgW6q2R9JxfmN0tBO5D4tT7esZdieOPaqltyv6HJz9Uyz/dR4Hf/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=YBOatIr4rDRsQYTWlCT5nxs9n86ml7LYzhQg4OFDZlYu8woMFdFfAIu/w0+kjQ/IieodbETpQVRESCnIY9B+TxhcCMmex2Mmkwek0peanpM/6Lz+v+JsEhlIsmxCFFVgRsbVpGZohMcwMAAIcf2D2kmNuRsSuPMo1Mh5Lsb7vXE=
Received: by 10.66.242.20 with SMTP id p20mr1604215ugh.1186586713090;
        Wed, 08 Aug 2007 08:25:13 -0700 (PDT)
Received: from paolo-desktop ( [82.50.5.8])
        by mx.google.com with ESMTPS id a1sm1745689ugf.2007.08.08.08.25.10
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Aug 2007 08:25:11 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55325>

=46urther changes, thanks to <tp@lists.linux.it>

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 po/it.po |  130
++++++++++++++++++++++++++++++++------------------------------ 1 files
changed, 67 insertions(+), 63 deletions(-)

diff --git a/po/it.po b/po/it.po
index e87263e..1950b56 100644
--- a/po/it.po
+++ b/po/it.po
@@ -2,18 +2,21 @@
 # Copyright (C) 2007 Shawn Pearce
 # This file is distributed under the same license as the git-gui
package. # Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, 2007
-#, fuzzy
+# , fuzzy
+# Michele Ballabio <barra_cuda@katamail.com>, 2007.
+#=20
+#=20
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2007-07-31 19:24+0200\n"
-"PO-Revision-Date: 2007-08-01 19:10+0200\n"
-"Last-Translator: Michele Ballabio <barra_cuda@katamail.com>\n"
-"Language-Team: Italian\n"
+"PO-Revision-Date: 2007-08-08 17:21+0200\n"
+"Last-Translator: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>\n"
+"Language-Team: Italian <tp@lists.linux.it>\n"
 "MIME-Version: 1.0\n"
-"Content-Type: text/plain; charset=3DUTF-8\n"
-"Content-Transfer-Encoding: 8bit\n"
+"Content-Type: text/plain; charset=3Diso-8859-1\n"
+"Content-Transfer-Encoding: 8bit"
=20
 #: git-gui.sh:531
 msgid "Cannot find git in PATH."
@@ -34,9 +37,9 @@ msgid ""
 "\n"
 "Assume '%s' is version 1.5.0?\n"
 msgstr ""
-"La versione di GIT non pu=C3=B2 essere determinata.\n"
 "\n"
-"%s sostiene che la versione =C3=A8 '%s'.\n"
 "\n"
 "%s richiede almeno Git 1.5.0 o superiore.\n"
 "\n"
@@ -136,7 +139,7 @@ msgstr "Carattere principale"
=20
 #: git-gui.sh:1635
 msgid "Diff/Console Font"
-msgstr "Carattere per confronti e terminale"
+msgstr "Caratteri per confronti e terminale"
=20
 #: git-gui.sh:1649
 msgid "Repository"
@@ -156,11 +159,11 @@ msgstr "Commit"
=20
 #: git-gui.sh:1658 lib/merge.tcl:121 lib/merge.tcl:150
lib/merge.tcl:168 msgid "Merge"
-msgstr "Fondi (Merge)"
+msgstr "Fusione (Merge)"
=20
 #: git-gui.sh:1659
 msgid "Fetch"
-msgstr "Recupera (Fetch)"
+msgstr "Preleva (Fetch)"
=20
 #: git-gui.sh:1660 git-gui.sh:2158 lib/transport.tcl:88
lib/transport.tcl:172 msgid "Push"
@@ -293,7 +296,7 @@ msgstr "Annulla modifiche"
=20
 #: git-gui.sh:1838 git-gui.sh:2148 git-gui.sh:2246
 msgid "Sign Off"
-msgstr "Sign Off"
+msgstr "Approva"
=20
 #: git-gui.sh:1853
 msgid "Local Merge..."
@@ -326,7 +329,7 @@ msgstr "Aiuto"
=20
 #: git-gui.sh:1938
 msgid "Online Documentation"
-msgstr "Documentazione online"
+msgstr "Documentazione sul web"
=20
 #: git-gui.sh:2054
 msgid "Current Branch:"
@@ -334,11 +337,11 @@ msgstr "Ramo attuale:"
=20
 #: git-gui.sh:2075
 msgid "Staged Changes (Will Be Committed)"
-msgstr "Modifiche preparate (ne verr=C3=A0 effettuato il commit)"
=20
 #: git-gui.sh:2095
 msgid "Unstaged Changes (Will Not Be Committed)"
-msgstr "Modifiche non preparate (non ne verr=C3=A0 effettuato il commi=
t)"
=20
 #: git-gui.sh:2142
 msgid "Stage Changed"
@@ -358,7 +361,7 @@ msgstr "Messaggio iniziale di commit corretto:"
=20
 #: git-gui.sh:2191
 msgid "Amended Merge Commit Message:"
-msgstr "Messaggio di fusione corretto:"
+msgstr "Messaggio di commit per la fusione:"
=20
 #: git-gui.sh:2192
 msgid "Merge Commit Message:"
@@ -386,11 +389,11 @@ msgstr "Applica/Inverti sezione"
=20
 #: git-gui.sh:2391
 msgid "Decrease Font Size"
-msgstr "Diminuisci dimensione carattere"
+msgstr "Diminuisci dimensione caratteri "
=20
 #: git-gui.sh:2395
 msgid "Increase Font Size"
-msgstr "Aumenta dimensione carattere"
+msgstr "Aumenta dimensione caratteri"
=20
 #: git-gui.sh:2400
 msgid "Show Less Context"
@@ -398,7 +401,7 @@ msgstr "Mostra meno contesto"
=20
 #: git-gui.sh:2407
 msgid "Show More Context"
-msgstr "Mostra pi=C3=B9 contesto"
=20
 #: git-gui.sh:2422
 msgid "Unstage Hunk From Commit"
@@ -455,7 +458,7 @@ msgstr "Opzioni"
=20
 #: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
-msgstr "Recupera ramo in 'tracking'"
+msgstr "Preleva ramo in 'tracking'"
=20
 #: lib/branch_checkout.tcl:44
 msgid "Detach From Local Branch"
@@ -516,7 +519,7 @@ msgstr "Scegli un ramo in 'tracking'"
 #: lib/branch_create.tcl:140
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "Il ramo in 'tracking' %s non =C3=A8 un ramo nell'archivio remo=
to."
=20
 #: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
 msgid "Please supply a branch name."
@@ -525,7 +528,7 @@ msgstr "Devi dare un nome al ramo."
 #: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
 #, tcl-format
 msgid "'%s' is not an acceptable branch name."
-msgstr "'%s' non =C3=A8 utilizzabile come nome di ramo."
=20
 #: lib/branch_delete.tcl:15
 msgid "Delete Branch"
@@ -558,7 +561,7 @@ msgid ""
 "\n"
 " Delete the selected branches?"
 msgstr ""
-"Recuperare rami cancellati pu=C3=B2 essere complicato. \n"
 "\n"
 " Eliminare i rami selezionati?"
=20
@@ -594,7 +597,7 @@ msgstr "Scegli un ramo da rinominare."
 #: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
 #, tcl-format
 msgid "Branch '%s' already exists."
-msgstr "Il ramo '%s' esiste gi=C3=A0"
=20
 #: lib/branch_rename.tcl:117
 #, tcl-format
@@ -625,7 +628,7 @@ msgstr "Sfoglia"
 #: lib/checkout_op.tcl:79
 #, tcl-format
 msgid "Fetching %s from %s"
-msgstr "Recupero %s da %s"
+msgstr "Prelevo %s da %s"
=20
 #: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
 msgid "Close"
@@ -643,15 +646,15 @@ msgid ""
 "\n"
 "It cannot fast-forward to %s.\n"
 "A merge is required."
-msgstr "Il ramo '%s' esiste gi=C3=A0.\n"
 "\n"
-"Non pu=C3=B2 effettuare un 'fast-forward' a %s.\n"
 "E' richiesta una fusione."
=20
 #: lib/checkout_op.tcl:220
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
-msgstr "La strategia di fusione '%s' non =C3=A8 supportata."
=20
 #: lib/checkout_op.tcl:239
 #, tcl-format
@@ -660,7 +663,7 @@ msgstr "Aggiornamento di '%s' fallito."
=20
 #: lib/checkout_op.tcl:251
 msgid "Staging area (index) is already locked."
-msgstr "L'area di preparazione al commit (indice) =C3=A8 gi=C3=A0 bloc=
cata."
=20
 #: lib/checkout_op.tcl:266
 msgid ""
@@ -677,7 +680,7 @@ msgstr ""
 "Bisogna effettuare una nuova analisi prima di poter cambiare il ramo =
"
 "corrente.\n"
 "\n"
-"La nuova analisi comincer=C3=A0 ora.\n"
=20
 #: lib/checkout_op.tcl:353
 #, tcl-format
@@ -700,7 +703,7 @@ msgid ""
 "If you wanted to be on a branch, create one now starting from 'This
Detached " "Checkout'."
 msgstr ""
-"Non sei pi=C3=B9 su un ramo locale.\n"
 "\n"
 "Se volevi rimanere su un ramo, creane uno ora a partire da 'Questo
checkout " "staccato'."
@@ -708,7 +711,7 @@ msgstr ""
 #: lib/checkout_op.tcl:478
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
-msgstr "Ripristinare '%s' a '%s' comporter=C3=A0 la perdita dei seguen=
ti
commit:"=20
 #: lib/checkout_op.tcl:500
 msgid "Recovering lost commits may not be easy."
@@ -735,11 +738,11 @@ msgid ""
 msgstr ""
 "Preparazione ramo corrente fallita.\n"
 "\n"
-"Questa directory di lavoro =C3=A8 stata convertita solo parzialmente.=
 I
tuoi file " "sono stati aggiornati correttamente, ma l'aggiornamento di
un file di Git ha " "prodotto degli errori.\n"
 "\n"
-"Questo non sarebbe dovuto succedere.  %s ora terminer=C3=A0 senza alt=
re
azioni."=20
 #: lib/choose_rev.tcl:53
 msgid "This Detached Checkout"
@@ -772,7 +775,7 @@ msgstr "Nessuna revisione selezionata."
=20
 #: lib/choose_rev.tcl:346
 msgid "Revision expression is empty."
-msgstr "L'espressione di revisione =C3=A8 vuota."
=20
 #: lib/commit.tcl:9
 msgid ""
@@ -781,7 +784,7 @@ msgid ""
 "You are about to create the initial commit.  There is no commit befor=
e
this " "to amend.\n"
 msgstr ""
-"Non c'=C3=A8 niente da correggere.\n"
 "\n"
 "Stai per creare il commit iniziale. Non esiste un commit precedente d=
a
" "correggere.\n"
@@ -794,9 +797,9 @@ msgid ""
 "completed.  You cannot amend the prior commit unless you first abort
the " "current merge activity.\n"
 msgstr ""
-"Non =C3=A8 possibile effettuare una correzione durante una fusione.\n=
"
 "\n"
-"In questo momento stai effettuando una fusione che non =C3=A8 stata d=
el
tutto " "completata. Non puoi correggere il commit precedente a meno ch=
e
prima tu non " "interrompa l'operazione di fusione in corso.\n"
=20
@@ -806,7 +809,7 @@ msgstr "Errore durante il caricamento dei dati da
correggere:"=20
 #: lib/commit.tcl:76
 msgid "Unable to obtain your identity:"
-msgstr "Impossibile ottenere la tua identit=C3=A0:"
=20
 #: lib/commit.tcl:81
 msgid "Invalid GIT_COMMITTER_IDENT:"
@@ -826,7 +829,7 @@ msgstr ""
 "Un altro programma Git ha modificato questo repository dall'ultima
analisi. " "Bisogna effettuare una nuova analisi prima di poter creare
un nuovo commit.\n" "\n"
-"La nuova analisi comincer=C3=A0 ora.\n"
=20
 #: lib/commit.tcl:154
 #, tcl-format
@@ -836,7 +839,7 @@ msgid ""
 "File %s has merge conflicts.  You must resolve them and stage the fil=
e
" "before committing.\n"
 msgstr ""
-"Non =C3=A8 possibile effettuare il commit di file non sottoposti a
fusione.\n" "\n"
 "Il file %s presenta dei conflitti. Devi risolverli e preparare il fil=
e
" "per il commit prima di effettuare questa azione.\n"
@@ -850,7 +853,7 @@ msgid ""
 msgstr ""
 "Stato di file %s sconosciuto.\n"
 "\n"
-"Non si pu=C3=B2 effettuare il commit del file %s con questo programma=
=2E\n"
=20
 #: lib/commit.tcl:170
 msgid ""
@@ -876,7 +879,7 @@ msgstr ""
 "\n"
 "Un buon messaggio di commit ha il seguente formato:\n"
 "\n"
-"- Prima linea: descrivi in una frase ci=C3=B2 che hai fatto.\n"
 "- Seconda linea: vuota.\n"
 "- Terza linea: spiga a cosa serve la tua modifica.\n"
=20
@@ -896,7 +899,7 @@ msgstr ""
 "\n"
 "Questo commit non modifica alcun file e non effettua alcuna
fusione.\n" "\n"
-"Si proceder=C3=A0 subito ad una nuova analisi.\n"
=20
 #: lib/commit.tcl:286
 msgid "No changes to commit."
@@ -980,10 +983,10 @@ msgstr ""
 "\n"
 "%s non ha modifiche.\n"
 "\n"
-"La data di modifica di questo file =C3=A8 stata cambiata da un'altra =
"
-"applicazione, ma il contenuto del file =C3=A8 rimasto invariato.\n"
 "\n"
-"Si proceder=C3=A0 automaticamente ad una nuova analisi per trovare al=
tri
file che " "potrebbero avere lo stesso stato."
=20
 #: lib/diff.tcl:97
@@ -996,11 +999,11 @@ msgstr "Errore nel caricamento delle differenze:"
=20
 #: lib/diff.tcl:278
 msgid "Failed to unstage selected hunk."
-msgstr "La sezione scelta =C3=A8 ancora pronta per il commit."
=20
 #: lib/diff.tcl:285
 msgid "Failed to stage selected hunk."
-msgstr "La sezione scelta non =C3=A8 ancora pronta per il commit."
=20
 #: lib/error.tcl:12 lib/error.tcl:102
 msgid "error"
@@ -1057,7 +1060,7 @@ msgstr ""
 "Un altro programma Git ha modificato questo repository dall'ultima
analisi." "Bisogna effettuare una nuova analisi prima di poter
effettuare una fusione.\n" "\n"
-"La nuova analisi comincer=C3=A0 ora.\n"
=20
 #: lib/merge.tcl:44
 #, tcl-format
@@ -1090,10 +1093,10 @@ msgid ""
 msgstr ""
 "Sei nel mezzo di una modifica.\n"
 "\n"
-"Il file %s =C3=A8 stato modificato.\n"
 "\n"
 "Bisogna completare il commit corrente prima di iniziare una fusione.
In " -"questo modo sar=C3=A0 pi=C3=B9 facile interrompere una fusione n=
on
riuscita, nel caso " "ce ne fosse bisogno.\n"
=20
 #: lib/merge.tcl:106
@@ -1143,7 +1146,7 @@ msgid ""
 msgstr ""
 "Interrompere fusione?\n"
 "\n"
-"L'interruzione della fusione corrente causer=C3=A0 la perdita di *TUT=
TE* le
" "modifiche non ancora presenti nei commit.\n"
 "\n"
 "Continuare con l'interruzione della fusione corrente?"
@@ -1158,7 +1161,7 @@ msgid ""
 msgstr ""
 "Annullare le modifiche?\n"
 "\n"
-"L'annullamento delle modifiche causer=C3=A0 la perdita di *TUTTE* le =
"
 "modifiche non ancora presenti nei commit.\n"
 "\n"
 "Continuare con l'annullamento delle modifiche correnti?"
@@ -1210,7 +1213,7 @@ msgstr "Riepilogo nei commit di fusione"
=20
 #: lib/option.tcl:189
 msgid "Merge Verbosity"
-msgstr "Verbosit=C3=A0 della fusione"
=20
 #: lib/option.tcl:190
 msgid "Show Diffstat After Merge"
@@ -1222,7 +1225,7 @@ msgstr "Fidati delle date di modifica dei file"
=20
 #: lib/option.tcl:193
 msgid "Prune Tracking Branches During Fetch"
-msgstr "Effettua potatura dei rami in 'tracking' durante il recupero"
+msgstr "Effettua potatura dei rami in 'tracking' durante il prelievo"
=20
 #: lib/option.tcl:194
 msgid "Match Tracking Branches"
@@ -1254,7 +1257,7 @@ msgstr "Remoto:"
=20
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:133
 msgid "Arbitrary URL:"
-msgstr ""
+msgstr "URL arbitratio:"
=20
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
@@ -1282,12 +1285,12 @@ msgid ""
 "One or more of the merge tests failed because you have not fetched th=
e
" "necessary commits.  Try fetching from %s first."
 msgstr ""
-"Una o pi=C3=B9 verifiche di fusione sono fallite perch=C3=A9 mancano =
i commit "
-"necessari. Prova prima a recuperarli da %s."
+"necessari. Prova prima a prelevarli da %s."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
-msgstr "Scegli uno o pi=C3=B9 rami da cancellare."
=20
 #: lib/remote_branch_delete.tcl:216
 msgid ""
@@ -1295,7 +1298,7 @@ msgid ""
 "\n"
 "Delete the selected branches?"
 msgstr ""
-"Recuperare rami cancellati =C3=A8 difficile.\n"
 "\n"
 "Cancellare i rami selezionati?"
=20
@@ -1316,7 +1319,7 @@ msgstr "Analisi in corso %s..."
 #: lib/remote.tcl:162
 #, tcl-format
 msgid "Fetch from %s..."
-msgstr "Recupera da %s..."
+msgstr "Preleva da %s..."
=20
 #: lib/remote.tcl:172
 #, tcl-format
@@ -1344,7 +1347,7 @@ msgstr "%s ... %i di %i %s (%2i%%)"
 #: lib/transport.tcl:7
 #, tcl-format
 msgid "Fetching new changes from %s"
-msgstr "Recupero nuove modifiche da %s"
+msgstr "Prelevo nuove modifiche da %s"
=20
 #: lib/transport.tcl:19
 #, tcl-format
@@ -1384,3 +1387,4 @@ msgstr "Utilizza 'thin pack' (per connessioni
lente)" #: lib/transport.tcl:159
 msgid "Include tags"
 msgstr "Includi etichette"
+
--=20
1.5.3.rc3.24.g83b3d
