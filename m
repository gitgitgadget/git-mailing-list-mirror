From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git-gui: update it.po and glossary/it.po
Date: Thu, 22 Nov 2007 11:46:21 +0100
Message-ID: <200711221146.21724.barra_cuda@katamail.com>
References: <20071121073645.GV14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 11:41:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9Uj-0003Ua-24
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXKVKk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 05:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXKVKk6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:40:58 -0500
Received: from slim-3c.inet.it ([213.92.5.125]:52883 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbXKVKkz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 05:40:55 -0500
Received: from host219-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.219]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.219+CrXsJUYONvP; Thu, 22 Nov 2007 11:40:46 +0100
User-Agent: KMail/1.9.7
In-Reply-To: <20071121073645.GV14735@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65776>

Updates and fixes:
 * current -> attuale
 * failed -> impossibile/non riuscito
 * corrupt -> danneggiato

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 po/glossary/it.po |   16 ++-
 po/it.po          |  461 +++++++++++++++++++++++++++++----------------=
--------
 2 files changed, 261 insertions(+), 216 deletions(-)

diff --git a/po/glossary/it.po b/po/glossary/it.po
index 8e3d9a2..bb46b48 100644
--- a/po/glossary/it.po
+++ b/po/glossary/it.po
@@ -6,7 +6,7 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui glossary\n"
-"POT-Creation-Date: 2007-10-05 22:30+0200\n"
+"POT-Creation-Date: 2007-10-19 21:43+0200\n"
 "PO-Revision-Date: 2007-10-10 15:24+0200\n"
 "Last-Translator: Michele Ballabio <barra_cuda@katamail.com>\n"
 "Language-Team: Italian \n"
@@ -50,8 +50,8 @@ msgstr "attivazione, checkout, revisione attiva, prel=
ievo (TortoiseCVS)?"
 #. "The action of updating the working tree to a revision which was st=
ored in the object database."
 msgid "checkout [verb]"
 msgstr ""
-"attivare, effettuare un checkout, attivare revisione, prelevare (Tort=
oiseCVS), "
-"ritirare (TSVN)?"
+"attivare, effettuare un checkout, attivare revisione, prelevare "
+"(TortoiseCVS), ritirare (TSVN)?"
=20
 #. ""
 msgid "clone [verb]"
@@ -99,7 +99,7 @@ msgstr "effettuare la fusione, unire, fondere, esegui=
re la fusione"
 msgid "message"
 msgstr "messaggio, commento"
=20
-#. ""
+#. "Deletes all stale tracking branches under <name>. These stale bran=
ches have already been removed from the remote repository referenced by=
 <name>, but are still locally available in 'remotes/<name>'."
 msgid "prune"
 msgstr "potatura"
=20
@@ -117,6 +117,10 @@ msgstr "propaga"
 msgid "redo"
 msgstr "ripeti, rifai"
=20
+#. "An other repository ('remote'). One might have a set of remotes wh=
ose branches one tracks."
+msgid "remote"
+msgstr "remoto"
+
 #. "A collection of refs (?) together with an object database containi=
ng all objects which are reachable from the refs... (oops, you've lost =
me here. Again, please an explanation for mere mortals?)"
 msgid "repository"
 msgstr "archivio, repository, database? deposito (rapidsvn)?"
@@ -160,8 +164,8 @@ msgstr "etichettare"
 #. "A regular git branch that is used to follow changes from another r=
epository."
 msgid "tracking branch"
 msgstr ""
-"duplicato locale di ramo remoto, ramo in 'tracking', ramo inseguitore=
? ramo di {inseguimento,allineamento,"
-"rilevamento,puntamento}?"
+"duplicato locale di ramo remoto, ramo in 'tracking', ramo inseguitore=
? ramo "
+"di {inseguimento,allineamento,rilevamento,puntamento}?"
=20
 #. ""
 msgid "undo"
diff --git a/po/it.po b/po/it.po
index 7668414..33a8399 100644
--- a/po/it.po
+++ b/po/it.po
@@ -9,41 +9,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-10-10 14:42+0200\n"
-"PO-Revision-Date: 2007-10-10 15:27+0200\n"
-"Last-Translator: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>\n"
+"POT-Creation-Date: 2007-11-09 11:18+0100\n"
+"PO-Revision-Date: 2007-11-01 21:05+0100\n"
+"Last-Translator: Michele Ballabio <barra_cuda@katamail.com>\n"
 "Language-Team: Italian <tp@lists.linux.it>\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.=
sh:744
-#: git-gui.sh:763
+#: git-gui.sh:41 git-gui.sh:604 git-gui.sh:618 git-gui.sh:631 git-gui.=
sh:714
+#: git-gui.sh:733
 msgid "git-gui: fatal error"
 msgstr "git-gui: errore grave"
=20
-#: git-gui.sh:595
+#: git-gui.sh:565
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Caratteri non validi specificati in %s:"
=20
-#: git-gui.sh:620
+#: git-gui.sh:590
 msgid "Main Font"
 msgstr "Caratteri principali"
=20
-#: git-gui.sh:621
+#: git-gui.sh:591
 msgid "Diff/Console Font"
 msgstr "Caratteri per confronti e terminale"
=20
-#: git-gui.sh:635
+#: git-gui.sh:605
 msgid "Cannot find git in PATH."
 msgstr "Impossibile trovare git nel PATH"
=20
-#: git-gui.sh:662
+#: git-gui.sh:632
 msgid "Cannot parse Git version string:"
 msgstr "Impossibile determinare la versione di Git:"
=20
-#: git-gui.sh:680
+#: git-gui.sh:650
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -54,7 +54,7 @@ msgid ""
 "\n"
 "Assume '%s' is version 1.5.0?\n"
 msgstr ""
-"La versione di GIT non pu=C3=B2 essere determinata.\n"
+"La versione di Git non pu=C3=B2 essere determinata.\n"
 "\n"
 "%s riporta che la versione =C3=A8 '%s'.\n"
 "\n"
@@ -62,79 +62,79 @@ msgstr ""
 "\n"
 "Assumere che '%s' sia alla versione 1.5.0?\n"
=20
-#: git-gui.sh:853
+#: git-gui.sh:888
 msgid "Git directory not found:"
 msgstr "Non trovo la directory di git: "
=20
-#: git-gui.sh:860
+#: git-gui.sh:895
 msgid "Cannot move to top of working directory:"
 msgstr "Impossibile spostarsi sulla directory principale del progetto:=
"
=20
-#: git-gui.sh:867
+#: git-gui.sh:902
 msgid "Cannot use funny .git directory:"
 msgstr "Impossibile usare una .git directory strana:"
=20
-#: git-gui.sh:872
+#: git-gui.sh:907
 msgid "No working directory"
 msgstr "Nessuna directory di lavoro"
=20
-#: git-gui.sh:1019
+#: git-gui.sh:1054
 msgid "Refreshing file status..."
 msgstr "Controllo dello stato dei file in corso..."
=20
-#: git-gui.sh:1084
+#: git-gui.sh:1119
 msgid "Scanning for modified files ..."
 msgstr "Ricerca di file modificati in corso..."
=20
-#: git-gui.sh:1259 lib/browser.tcl:245
+#: git-gui.sh:1294 lib/browser.tcl:245
 msgid "Ready."
 msgstr "Pronto."
=20
-#: git-gui.sh:1525
+#: git-gui.sh:1560
 msgid "Unmodified"
 msgstr "Non modificato"
=20
-#: git-gui.sh:1527
+#: git-gui.sh:1562
 msgid "Modified, not staged"
 msgstr "Modificato, non preparato per una nuova revisione"
=20
-#: git-gui.sh:1528 git-gui.sh:1533
+#: git-gui.sh:1563 git-gui.sh:1568
 msgid "Staged for commit"
 msgstr "Preparato per una nuova revisione"
=20
-#: git-gui.sh:1529 git-gui.sh:1534
+#: git-gui.sh:1564 git-gui.sh:1569
 msgid "Portions staged for commit"
 msgstr "Parti preparate per una nuova revisione"
=20
-#: git-gui.sh:1530 git-gui.sh:1535
+#: git-gui.sh:1565 git-gui.sh:1570
 msgid "Staged for commit, missing"
 msgstr "Preparato per una nuova revisione, mancante"
=20
-#: git-gui.sh:1532
+#: git-gui.sh:1567
 msgid "Untracked, not staged"
 msgstr "Non tracciato, non preparato per una nuova revisione"
=20
-#: git-gui.sh:1537
+#: git-gui.sh:1572
 msgid "Missing"
 msgstr "Mancante"
=20
-#: git-gui.sh:1538
+#: git-gui.sh:1573
 msgid "Staged for removal"
 msgstr "Preparato per la rimozione"
=20
-#: git-gui.sh:1539
+#: git-gui.sh:1574
 msgid "Staged for removal, still present"
 msgstr "Preparato alla rimozione, ancora presente"
=20
-#: git-gui.sh:1541 git-gui.sh:1542 git-gui.sh:1543 git-gui.sh:1544
+#: git-gui.sh:1576 git-gui.sh:1577 git-gui.sh:1578 git-gui.sh:1579
 msgid "Requires merge resolution"
 msgstr "Richiede risoluzione dei conflitti"
=20
-#: git-gui.sh:1579
+#: git-gui.sh:1614
 msgid "Starting gitk... please wait..."
 msgstr "Avvio di gitk... attendere..."
=20
-#: git-gui.sh:1588
+#: git-gui.sh:1623
 #, tcl-format
 msgid ""
 "Unable to start gitk:\n"
@@ -145,297 +145,297 @@ msgstr ""
 "\n"
 "%s non esiste"
=20
-#: git-gui.sh:1788 lib/choose_repository.tcl:32
+#: git-gui.sh:1823 lib/choose_repository.tcl:35
 msgid "Repository"
 msgstr "Archivio"
=20
-#: git-gui.sh:1789
+#: git-gui.sh:1824
 msgid "Edit"
 msgstr "Modifica"
=20
-#: git-gui.sh:1791 lib/choose_rev.tcl:560
+#: git-gui.sh:1826 lib/choose_rev.tcl:560
 msgid "Branch"
 msgstr "Ramo"
=20
-#: git-gui.sh:1794 lib/choose_rev.tcl:547
+#: git-gui.sh:1829 lib/choose_rev.tcl:547
 msgid "Commit@@noun"
 msgstr "Revisione"
=20
-#: git-gui.sh:1797 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+#: git-gui.sh:1832 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "Fusione (Merge)"
=20
-#: git-gui.sh:1798 lib/choose_rev.tcl:556
+#: git-gui.sh:1833 lib/choose_rev.tcl:556
 msgid "Remote"
 msgstr "Remoto"
=20
-#: git-gui.sh:1807
+#: git-gui.sh:1842
 msgid "Browse Current Branch's Files"
-msgstr "Esplora i file del ramo corrente"
+msgstr "Esplora i file del ramo attuale"
=20
-#: git-gui.sh:1811
+#: git-gui.sh:1846
 msgid "Browse Branch Files..."
 msgstr "Esplora i file del ramo..."
=20
-#: git-gui.sh:1816
+#: git-gui.sh:1851
 msgid "Visualize Current Branch's History"
-msgstr "Visualizza la cronologia del ramo corrente"
+msgstr "Visualizza la cronologia del ramo attuale"
=20
-#: git-gui.sh:1820
+#: git-gui.sh:1855
 msgid "Visualize All Branch History"
 msgstr "Visualizza la cronologia di tutti i rami"
=20
-#: git-gui.sh:1827
+#: git-gui.sh:1862
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Esplora i file di %s"
=20
-#: git-gui.sh:1829
+#: git-gui.sh:1864
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Visualizza la cronologia di %s"
=20
-#: git-gui.sh:1834 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:1869 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Statistiche dell'archivio"
=20
-#: git-gui.sh:1837 lib/database.tcl:34
+#: git-gui.sh:1872 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "Comprimi l'archivio"
=20
-#: git-gui.sh:1840
+#: git-gui.sh:1875
 msgid "Verify Database"
 msgstr "Verifica l'archivio"
=20
-#: git-gui.sh:1847 git-gui.sh:1851 git-gui.sh:1855 lib/shortcut.tcl:9
-#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+#: git-gui.sh:1882 git-gui.sh:1886 git-gui.sh:1890 lib/shortcut.tcl:7
+#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "Crea icona desktop"
=20
-#: git-gui.sh:1860 lib/choose_repository.tcl:36 lib/choose_repository.=
tcl:95
+#: git-gui.sh:1895 lib/choose_repository.tcl:176 lib/choose_repository=
=2Etcl:184
 msgid "Quit"
 msgstr "Esci"
=20
-#: git-gui.sh:1867
+#: git-gui.sh:1902
 msgid "Undo"
 msgstr "Annulla"
=20
-#: git-gui.sh:1870
+#: git-gui.sh:1905
 msgid "Redo"
 msgstr "Ripeti"
=20
-#: git-gui.sh:1874 git-gui.sh:2366
+#: git-gui.sh:1909 git-gui.sh:2403
 msgid "Cut"
 msgstr "Taglia"
=20
-#: git-gui.sh:1877 git-gui.sh:2369 git-gui.sh:2440 git-gui.sh:2512
+#: git-gui.sh:1912 git-gui.sh:2406 git-gui.sh:2477 git-gui.sh:2549
 #: lib/console.tcl:67
 msgid "Copy"
 msgstr "Copia"
=20
-#: git-gui.sh:1880 git-gui.sh:2372
+#: git-gui.sh:1915 git-gui.sh:2409
 msgid "Paste"
 msgstr "Incolla"
=20
-#: git-gui.sh:1883 git-gui.sh:2375 lib/branch_delete.tcl:26
+#: git-gui.sh:1918 git-gui.sh:2412 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "Elimina"
=20
-#: git-gui.sh:1887 git-gui.sh:2379 git-gui.sh:2516 lib/console.tcl:69
+#: git-gui.sh:1922 git-gui.sh:2416 git-gui.sh:2553 lib/console.tcl:69
 msgid "Select All"
 msgstr "Seleziona tutto"
=20
-#: git-gui.sh:1896
+#: git-gui.sh:1931
 msgid "Create..."
 msgstr "Crea..."
=20
-#: git-gui.sh:1902
+#: git-gui.sh:1937
 msgid "Checkout..."
 msgstr "Attiva..."
=20
-#: git-gui.sh:1908
+#: git-gui.sh:1943
 msgid "Rename..."
 msgstr "Rinomina"
=20
-#: git-gui.sh:1913 git-gui.sh:2012
+#: git-gui.sh:1948 git-gui.sh:2048
 msgid "Delete..."
 msgstr "Elimina..."
=20
-#: git-gui.sh:1918
+#: git-gui.sh:1953
 msgid "Reset..."
 msgstr "Ripristina..."
=20
-#: git-gui.sh:1930 git-gui.sh:2313
+#: git-gui.sh:1965 git-gui.sh:2350
 msgid "New Commit"
 msgstr "Nuova revisione"
=20
-#: git-gui.sh:1938 git-gui.sh:2320
+#: git-gui.sh:1973 git-gui.sh:2357
 msgid "Amend Last Commit"
 msgstr "Correggi l'ultima revisione"
=20
-#: git-gui.sh:1947 git-gui.sh:2280 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:1982 git-gui.sh:2317 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "Analizza nuovamente"
=20
-#: git-gui.sh:1953
+#: git-gui.sh:1988
 msgid "Stage To Commit"
 msgstr "Prepara per una nuova revisione"
=20
-#: git-gui.sh:1958
+#: git-gui.sh:1994
 msgid "Stage Changed Files To Commit"
 msgstr "Prepara i file modificati per una nuova revisione"
=20
-#: git-gui.sh:1964
+#: git-gui.sh:2000
 msgid "Unstage From Commit"
 msgstr "Annulla preparazione"
=20
-#: git-gui.sh:1969 lib/index.tcl:352
+#: git-gui.sh:2005 lib/index.tcl:393
 msgid "Revert Changes"
 msgstr "Annulla modifiche"
=20
-#: git-gui.sh:1976 git-gui.sh:2292 git-gui.sh:2390
+#: git-gui.sh:2012 git-gui.sh:2329 git-gui.sh:2427
 msgid "Sign Off"
 msgstr "Sign Off"
=20
-#: git-gui.sh:1980 git-gui.sh:2296
+#: git-gui.sh:2016 git-gui.sh:2333
 msgid "Commit@@verb"
 msgstr "Nuova revisione"
=20
-#: git-gui.sh:1991
+#: git-gui.sh:2027
 msgid "Local Merge..."
 msgstr "Fusione locale..."
=20
-#: git-gui.sh:1996
+#: git-gui.sh:2032
 msgid "Abort Merge..."
 msgstr "Interrompi fusione..."
=20
-#: git-gui.sh:2008
+#: git-gui.sh:2044
 msgid "Push..."
 msgstr "Propaga..."
=20
-#: git-gui.sh:2019 lib/choose_repository.tcl:41
+#: git-gui.sh:2055 lib/choose_repository.tcl:40
 msgid "Apple"
 msgstr "Apple"
=20
-#: git-gui.sh:2022 git-gui.sh:2044 lib/about.tcl:13
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
+#: git-gui.sh:2058 git-gui.sh:2080 lib/about.tcl:13
+#: lib/choose_repository.tcl:43 lib/choose_repository.tcl:49
 #, tcl-format
 msgid "About %s"
 msgstr "Informazioni su %s"
=20
-#: git-gui.sh:2026
+#: git-gui.sh:2062
 msgid "Preferences..."
 msgstr "Preferenze..."
=20
-#: git-gui.sh:2034 git-gui.sh:2558
+#: git-gui.sh:2070 git-gui.sh:2595
 msgid "Options..."
 msgstr "Opzioni..."
=20
-#: git-gui.sh:2040 lib/choose_repository.tcl:47
+#: git-gui.sh:2076 lib/choose_repository.tcl:46
 msgid "Help"
 msgstr "Aiuto"
=20
-#: git-gui.sh:2081
+#: git-gui.sh:2117
 msgid "Online Documentation"
 msgstr "Documentazione sul web"
=20
-#: git-gui.sh:2165
+#: git-gui.sh:2201
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "errore grave: impossibile effettuare lo stat del path %s: file o dire=
ctory "
 "non trovata"
=20
-#: git-gui.sh:2198
+#: git-gui.sh:2234
 msgid "Current Branch:"
 msgstr "Ramo attuale:"
=20
-#: git-gui.sh:2219
+#: git-gui.sh:2255
 msgid "Staged Changes (Will Commit)"
 msgstr "Modifiche preparate (saranno nella nuova revisione)"
=20
-#: git-gui.sh:2239
+#: git-gui.sh:2274
 msgid "Unstaged Changes"
 msgstr "Modifiche non preparate"
=20
-#: git-gui.sh:2286
+#: git-gui.sh:2323
 msgid "Stage Changed"
 msgstr "Prepara modificati"
=20
-#: git-gui.sh:2302 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2339 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "Propaga (Push)"
=20
-#: git-gui.sh:2332
+#: git-gui.sh:2369
 msgid "Initial Commit Message:"
 msgstr "Messaggio di revisione iniziale:"
=20
-#: git-gui.sh:2333
+#: git-gui.sh:2370
 msgid "Amended Commit Message:"
 msgstr "Messaggio di revisione corretto:"
=20
-#: git-gui.sh:2334
+#: git-gui.sh:2371
 msgid "Amended Initial Commit Message:"
 msgstr "Messaggio iniziale di revisione corretto:"
=20
-#: git-gui.sh:2335
+#: git-gui.sh:2372
 msgid "Amended Merge Commit Message:"
 msgstr "Messaggio di fusione corretto:"
=20
-#: git-gui.sh:2336
+#: git-gui.sh:2373
 msgid "Merge Commit Message:"
 msgstr "Messaggio di fusione:"
=20
-#: git-gui.sh:2337
+#: git-gui.sh:2374
 msgid "Commit Message:"
 msgstr "Messaggio di revisione:"
=20
-#: git-gui.sh:2382 git-gui.sh:2520 lib/console.tcl:71
+#: git-gui.sh:2419 git-gui.sh:2557 lib/console.tcl:71
 msgid "Copy All"
 msgstr "Copia tutto"
=20
-#: git-gui.sh:2406 lib/blame.tcl:104
+#: git-gui.sh:2443 lib/blame.tcl:104
 msgid "File:"
 msgstr "File:"
=20
-#: git-gui.sh:2508
+#: git-gui.sh:2545
 msgid "Refresh"
 msgstr "Rinfresca"
=20
-#: git-gui.sh:2529
+#: git-gui.sh:2566
 msgid "Apply/Reverse Hunk"
 msgstr "Applica/Inverti sezione"
=20
-#: git-gui.sh:2535
+#: git-gui.sh:2572
 msgid "Decrease Font Size"
 msgstr "Diminuisci dimensione caratteri"
=20
-#: git-gui.sh:2539
+#: git-gui.sh:2576
 msgid "Increase Font Size"
 msgstr "Aumenta dimensione caratteri"
=20
-#: git-gui.sh:2544
+#: git-gui.sh:2581
 msgid "Show Less Context"
 msgstr "Mostra meno contesto"
=20
-#: git-gui.sh:2551
+#: git-gui.sh:2588
 msgid "Show More Context"
 msgstr "Mostra pi=C3=B9 contesto"
=20
-#: git-gui.sh:2565
+#: git-gui.sh:2602
 msgid "Unstage Hunk From Commit"
 msgstr "Sezione non preparata per una nuova revisione"
=20
-#: git-gui.sh:2567
+#: git-gui.sh:2604
 msgid "Stage Hunk For Commit"
 msgstr "Prepara sezione per una nuova revisione"
=20
-#: git-gui.sh:2586
+#: git-gui.sh:2623
 msgid "Initializing..."
 msgstr "Inizializzazione..."
=20
-#: git-gui.sh:2677
+#: git-gui.sh:2718
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -452,7 +452,7 @@ msgstr ""
 "da %s:\n"
 "\n"
=20
-#: git-gui.sh:2707
+#: git-gui.sh:2748
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -462,7 +462,7 @@ msgstr ""
 "Ci=C3=B2 =C3=A8 dovuto a un problema conosciuto\n"
 "causato dall'eseguibile Tcl distribuito da Cygwin."
=20
-#: git-gui.sh:2712
+#: git-gui.sh:2753
 #, tcl-format
 msgid ""
 "\n"
@@ -582,7 +582,7 @@ msgstr "Crea ramo"
 msgid "Create New Branch"
 msgstr "Crea nuovo ramo"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:199
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:375
 msgid "Create"
 msgstr "Crea"
=20
@@ -682,7 +682,7 @@ msgid ""
 "Failed to delete branches:\n"
 "%s"
 msgstr ""
-"Cancellazione rami fallita:\n"
+"Impossibile cancellare i rami:\n"
 "%s"
=20
 #: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
@@ -736,9 +736,9 @@ msgstr "[Directory superiore]"
 msgid "Browse Branch Files"
 msgstr "Esplora i file del ramo"
=20
-#: lib/browser.tcl:277 lib/choose_repository.tcl:215
-#: lib/choose_repository.tcl:305 lib/choose_repository.tcl:315
-#: lib/choose_repository.tcl:811
+#: lib/browser.tcl:277 lib/choose_repository.tcl:391
+#: lib/choose_repository.tcl:482 lib/choose_repository.tcl:492
+#: lib/choose_repository.tcl:989
 msgid "Browse"
 msgstr "Sfoglia"
=20
@@ -782,11 +782,12 @@ msgstr "La strategia di fusione '%s' non =C3=A8 s=
upportata."
 #: lib/checkout_op.tcl:239
 #, tcl-format
 msgid "Failed to update '%s'."
-msgstr "Aggiornamento di '%s' fallito."
+msgstr "Impossibile aggiornare '%s'."
=20
 #: lib/checkout_op.tcl:251
 msgid "Staging area (index) is already locked."
-msgstr "L'area di preparazione per una nuova revisione (indice) =C3=A8=
 gi=C3=A0 bloccata."
+msgstr ""
+"L'area di preparazione per una nuova revisione (indice) =C3=A8 gi=C3=A0=
 bloccata."
=20
 #: lib/checkout_op.tcl:266
 msgid ""
@@ -801,7 +802,7 @@ msgstr ""
 "\n"
 "Un altro programma Git ha modificato questo archivio dall'ultima anal=
isi. "
 "Bisogna effettuare una nuova analisi prima di poter cambiare il ramo =
"
-"corrente.\n"
+"attuale.\n"
 "\n"
 "La nuova analisi comincer=C3=A0 ora.\n"
=20
@@ -870,7 +871,7 @@ msgid ""
 "\n"
 "This should not have occurred.  %s will now close and give up."
 msgstr ""
-"Preparazione ramo corrente fallita.\n"
+"Impossibile preparare il ramo attuale.\n"
 "\n"
 "Questa directory di lavoro =C3=A8 stata convertita solo parzialmente.=
 I file sono "
 "stati aggiornati correttamente, ma l'aggiornamento di un file di Git =
ha "
@@ -902,214 +903,230 @@ msgstr ""
 "Questo =C3=A8 un testo d'esempio.\n"
 "Se ti piace questo testo, pu=C3=B2 essere il carattere giusto."
=20
-#: lib/choose_repository.tcl:25
+#: lib/choose_repository.tcl:27
 msgid "Git Gui"
 msgstr "Git Gui"
=20
-#: lib/choose_repository.tcl:69 lib/choose_repository.tcl:204
+#: lib/choose_repository.tcl:80 lib/choose_repository.tcl:380
 msgid "Create New Repository"
 msgstr "Crea nuovo archivio"
=20
-#: lib/choose_repository.tcl:74 lib/choose_repository.tcl:291
+#: lib/choose_repository.tcl:86
+msgid "New..."
+msgstr "Nuovo..."
+
+#: lib/choose_repository.tcl:93 lib/choose_repository.tcl:468
 msgid "Clone Existing Repository"
 msgstr "Clona archivio esistente"
=20
-#: lib/choose_repository.tcl:79 lib/choose_repository.tcl:800
+#: lib/choose_repository.tcl:99
+msgid "Clone..."
+msgstr "Clona..."
+
+#: lib/choose_repository.tcl:106 lib/choose_repository.tcl:978
 msgid "Open Existing Repository"
 msgstr "Apri archivio esistente"
=20
-#: lib/choose_repository.tcl:91
-msgid "Next >"
-msgstr "Successivo >"
+#: lib/choose_repository.tcl:112
+msgid "Open..."
+msgstr "Apri..."
+
+#: lib/choose_repository.tcl:125
+msgid "Recent Repositories"
+msgstr "Archivi recenti"
+
+#: lib/choose_repository.tcl:131
+msgid "Open Recent Repository:"
+msgstr "Apri archivio recente:"
=20
-#: lib/choose_repository.tcl:152
+#: lib/choose_repository.tcl:294
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "La posizione %s esiste gi=C3=A0."
=20
-#: lib/choose_repository.tcl:158 lib/choose_repository.tcl:165
-#: lib/choose_repository.tcl:172
+#: lib/choose_repository.tcl:300 lib/choose_repository.tcl:307
+#: lib/choose_repository.tcl:314
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "Impossibile creare l'archivio %s:"
=20
-#: lib/choose_repository.tcl:209 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:385 lib/choose_repository.tcl:486
 msgid "Directory:"
 msgstr "Directory:"
=20
-#: lib/choose_repository.tcl:238 lib/choose_repository.tcl:363
-#: lib/choose_repository.tcl:834
+#: lib/choose_repository.tcl:415 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1013
 msgid "Git Repository"
 msgstr "Archivio Git"
=20
-#: lib/choose_repository.tcl:253 lib/choose_repository.tcl:260
+#: lib/choose_repository.tcl:430 lib/choose_repository.tcl:437
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "La directory %s esiste gi=C3=A0."
=20
-#: lib/choose_repository.tcl:265
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "File %s already exists."
 msgstr "Il file %s esiste gi=C3=A0."
=20
-#: lib/choose_repository.tcl:286
+#: lib/choose_repository.tcl:463
 msgid "Clone"
 msgstr "Clona"
=20
-#: lib/choose_repository.tcl:299
+#: lib/choose_repository.tcl:476
 msgid "URL:"
 msgstr "URL:"
=20
-#: lib/choose_repository.tcl:319
+#: lib/choose_repository.tcl:496
 msgid "Clone Type:"
 msgstr "Tipo di clone:"
=20
-#: lib/choose_repository.tcl:325
+#: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "Standard (veloce, semi-ridondante, con hardlink)"
=20
-#: lib/choose_repository.tcl:331
+#: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "Copia completa (pi=C3=B9 lento, backup ridondante)"
=20
-#: lib/choose_repository.tcl:337
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "Shared (il pi=C3=B9 veloce, non raccomandato, nessun backup)"
=20
-#: lib/choose_repository.tcl:369 lib/choose_repository.tcl:418
-#: lib/choose_repository.tcl:560 lib/choose_repository.tcl:630
-#: lib/choose_repository.tcl:840 lib/choose_repository.tcl:848
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:738 lib/choose_repository.tcl:808
+#: lib/choose_repository.tcl:1019 lib/choose_repository.tcl:1027
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "%s non =C3=A8 un archivio Git."
=20
-#: lib/choose_repository.tcl:405
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr "Standard =C3=A8 disponibile solo per archivi locali."
=20
-#: lib/choose_repository.tcl:409
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr "Shared =C3=A8 disponibile solo per archivi locali."
=20
-#: lib/choose_repository.tcl:439
+#: lib/choose_repository.tcl:617
 msgid "Failed to configure origin"
 msgstr "Impossibile configurare origin"
=20
-#: lib/choose_repository.tcl:451
+#: lib/choose_repository.tcl:629
 msgid "Counting objects"
 msgstr "Calcolo oggetti"
=20
-#: lib/choose_repository.tcl:452
+#: lib/choose_repository.tcl:630
 msgid "buckets"
 msgstr ""
=20
-#: lib/choose_repository.tcl:476
+#: lib/choose_repository.tcl:654
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "Impossibile copiare oggetti/info/alternate: %s"
=20
-#: lib/choose_repository.tcl:512
+#: lib/choose_repository.tcl:690
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "Niente da clonare da %s."
=20
-#: lib/choose_repository.tcl:514 lib/choose_repository.tcl:728
-#: lib/choose_repository.tcl:740
+#: lib/choose_repository.tcl:692 lib/choose_repository.tcl:906
+#: lib/choose_repository.tcl:918
 msgid "The 'master' branch has not been initialized."
 msgstr "Il ramo 'master' non =C3=A8 stato inizializzato."
=20
-#: lib/choose_repository.tcl:527
+#: lib/choose_repository.tcl:705
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "Impossibile utilizzare gli hardlink. Si ricorrer=C3=A0 alla co=
pia."
=20
-#: lib/choose_repository.tcl:539
+#: lib/choose_repository.tcl:717
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "Clonazione da %s"
=20
-#: lib/choose_repository.tcl:570
+#: lib/choose_repository.tcl:748
 msgid "Copying objects"
 msgstr "Copia degli oggetti"
=20
-#: lib/choose_repository.tcl:571
+#: lib/choose_repository.tcl:749
 msgid "KiB"
 msgstr "KiB"
=20
-#: lib/choose_repository.tcl:595
+#: lib/choose_repository.tcl:773
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "Impossibile copiare oggetto: %s"
=20
-#: lib/choose_repository.tcl:605
+#: lib/choose_repository.tcl:783
 msgid "Linking objects"
 msgstr "Collegamento oggetti"
=20
-#: lib/choose_repository.tcl:606
+#: lib/choose_repository.tcl:784
 msgid "objects"
 msgstr "oggetti"
=20
-#: lib/choose_repository.tcl:614
+#: lib/choose_repository.tcl:792
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "Hardlink impossibile sull'oggetto: %s"
=20
-#: lib/choose_repository.tcl:669
+#: lib/choose_repository.tcl:847
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr ""
 "Impossibile recuperare rami e oggetti. Controllare i dettagli forniti=
 dalla "
 "console."
=20
-#: lib/choose_repository.tcl:680
+#: lib/choose_repository.tcl:858
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
 "Impossibile recuperare le etichette. Controllare i dettagli forniti d=
alla "
 "console."
=20
-#: lib/choose_repository.tcl:704
+#: lib/choose_repository.tcl:882
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr ""
 "Impossibile determinare HEAD. Controllare i dettagli forniti dalla co=
nsole."
=20
-#: lib/choose_repository.tcl:713
+#: lib/choose_repository.tcl:891
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "Impossibile ripulire %s"
=20
-#: lib/choose_repository.tcl:719
+#: lib/choose_repository.tcl:897
 msgid "Clone failed."
-msgstr "Clonazione fallita."
+msgstr "Clonazione non riuscita."
=20
-#: lib/choose_repository.tcl:726
+#: lib/choose_repository.tcl:904
 msgid "No default branch obtained."
 msgstr "Non =C3=A8 stato trovato un ramo predefinito."
=20
-#: lib/choose_repository.tcl:737
+#: lib/choose_repository.tcl:915
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "Impossibile risolvere %s come una revisione."
=20
-#: lib/choose_repository.tcl:749
+#: lib/choose_repository.tcl:927
 msgid "Creating working directory"
 msgstr "Creazione directory di lavoro"
=20
-#: lib/choose_repository.tcl:750 lib/index.tcl:15 lib/index.tcl:80
-#: lib/index.tcl:149
+#: lib/choose_repository.tcl:928 lib/index.tcl:65 lib/index.tcl:127
+#: lib/index.tcl:193
 msgid "files"
 msgstr "file"
=20
-#: lib/choose_repository.tcl:779
+#: lib/choose_repository.tcl:957
 msgid "Initial file checkout failed."
-msgstr "Attivazione iniziale impossibile."
+msgstr "Attivazione iniziale non riuscita."
=20
-#: lib/choose_repository.tcl:795
+#: lib/choose_repository.tcl:973
 msgid "Open"
 msgstr "Apri"
=20
-#: lib/choose_repository.tcl:805
+#: lib/choose_repository.tcl:983
 msgid "Repository:"
 msgstr "Archivio:"
=20
-#: lib/choose_repository.tcl:854
+#: lib/choose_repository.tcl:1033
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "Impossibile accedere all'archivio %s:"
@@ -1164,8 +1181,8 @@ msgid ""
 msgstr ""
 "Non c'=C3=A8 niente da correggere.\n"
 "\n"
-"Stai per creare la revisione iniziale. Non esiste una revisione "
-"precedente da correggere.\n"
+"Stai per creare la revisione iniziale. Non esiste una revisione prece=
dente "
+"da correggere.\n"
=20
 #: lib/commit.tcl:18
 msgid ""
@@ -1242,8 +1259,8 @@ msgid ""
 msgstr ""
 "Nessuna modifica per la nuova revisione.\n"
 "\n"
-"Devi preparare per una nuova revisione almeno 1 file prima di effettu=
are questa "
-"operazione.\n"
+"Devi preparare per una nuova revisione almeno 1 file prima di effettu=
are "
+"questa operazione.\n"
=20
 #: lib/commit.tcl:183
 msgid ""
@@ -1265,12 +1282,12 @@ msgstr ""
=20
 #: lib/commit.tcl:257
 msgid "write-tree failed:"
-msgstr "write-tree fallito:"
+msgstr "write-tree non riuscito:"
=20
 #: lib/commit.tcl:275
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
-msgstr "La revisione %s sembra essere corrotta"
+msgstr "La revisione %s sembra essere danneggiata"
=20
 #: lib/commit.tcl:279
 msgid ""
@@ -1297,11 +1314,11 @@ msgstr "attenzione: Tcl non supporta la codific=
a '%s'."
=20
 #: lib/commit.tcl:317
 msgid "commit-tree failed:"
-msgstr "commit-tree fallito:"
+msgstr "commit-tree non riuscito:"
=20
 #: lib/commit.tcl:339
 msgid "update-ref failed:"
-msgstr "update-ref fallito:"
+msgstr "update-ref non riuscito:"
=20
 #: lib/commit.tcl:430
 #, tcl-format
@@ -1318,7 +1335,7 @@ msgstr "Successo"
=20
 #: lib/console.tcl:196
 msgid "Error: Command Failed"
-msgstr "Errore: comando fallito"
+msgstr "Errore: comando non riuscito"
=20
 #: lib/database.tcl:43
 msgid "Number of loose objects"
@@ -1429,7 +1446,7 @@ msgstr "Errore nel caricamento delle differenze:"
=20
 #: lib/diff.tcl:302
 msgid "Failed to unstage selected hunk."
-msgstr "La sezione scelta =C3=A8 ancora pronta per una nuova revisione=
=2E"
+msgstr "Impossibile rimuovere la sezione scelta dalla nuova revisione.=
"
=20
 #: lib/diff.tcl:309
 msgid "Failed to stage selected hunk."
@@ -1445,35 +1462,60 @@ msgstr "attenzione"
=20
 #: lib/error.tcl:81
 msgid "You must correct the above errors before committing."
-msgstr "Bisogna correggere gli errori suddetti prima di creare una nuo=
va revisione."
+msgstr ""
+"Bisogna correggere gli errori suddetti prima di creare una nuova revi=
sione."
=20
-#: lib/index.tcl:241
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "Impossibile sbloccare l'accesso all'indice"
+
+#: lib/index.tcl:15
+msgid "Index Error"
+msgstr "Errore nell'indice"
+
+#: lib/index.tcl:21
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically starte=
d to "
+"resynchronize git-gui."
+msgstr ""
+"Impossibile aggiornare l'indice. Ora sar=C3=A0 avviata una nuova anal=
isi che "
+"aggiorner=C3=A0 git-gui."
+
+#: lib/index.tcl:27
+msgid "Continue"
+msgstr "Continua"
+
+#: lib/index.tcl:31
+msgid "Unlock Index"
+msgstr "Sblocca l'accesso all'indice"
+
+#: lib/index.tcl:282
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "%s non far=C3=A0 parte della prossima revisione"
=20
-#: lib/index.tcl:285
+#: lib/index.tcl:326
 #, tcl-format
 msgid "Adding %s"
 msgstr "Aggiunta di %s in corso"
=20
-#: lib/index.tcl:340
+#: lib/index.tcl:381
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "Annullare le modifiche nel file %s?"
=20
-#: lib/index.tcl:342
+#: lib/index.tcl:383
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "Annullare le modifiche in questi %i file?"
=20
-#: lib/index.tcl:348
+#: lib/index.tcl:389
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Tutte le modifiche non preparate per una nuova revisione saranno pers=
e per "
 "sempre."
=20
-#: lib/index.tcl:351
+#: lib/index.tcl:392
 msgid "Do Nothing"
 msgstr "Non fare niente"
=20
@@ -1519,8 +1561,8 @@ msgstr ""
 "Il file %s ha dei conflitti.\n"
 "\n"
 "Bisogna risolvere i conflitti, preparare il file per una nuova revisi=
one ed "
-"infine crearla per completare la fusione corrente. Solo a questo punt=
o "
-"potrai iniziare un'altra fusione.\n"
+"infine crearla per completare la fusione attuale. Solo a questo punto=
 potrai "
+"iniziare un'altra fusione.\n"
=20
 #: lib/merge.tcl:54
 #, tcl-format
@@ -1536,9 +1578,9 @@ msgstr ""
 "\n"
 "Il file %s =C3=A8 stato modificato.\n"
 "\n"
-"Bisogna completare la creazione della revisione corrente prima di ini=
ziare una fusione. "
-"In questo modo sar=C3=A0 pi=C3=B9 facile interrompere una fusione non=
 riuscita, nel "
-"caso ce ne fosse bisogno.\n"
+"Bisogna completare la creazione della revisione attuale prima di iniz=
iare "
+"una fusione. In questo modo sar=C3=A0 pi=C3=B9 facile interrompere un=
a fusione non "
+"riuscita, nel caso ce ne fosse bisogno.\n"
=20
 #: lib/merge.tcl:106
 #, tcl-format
@@ -1556,7 +1598,7 @@ msgstr "Fusione completata con successo."
=20
 #: lib/merge.tcl:133
 msgid "Merge failed.  Conflict resolution is required."
-msgstr "Fusione fallita. Bisogna risolvere i conflitti."
+msgstr "Fusione non riuscita. Bisogna risolvere i conflitti."
=20
 #: lib/merge.tcl:158
 #, tcl-format
@@ -1587,10 +1629,10 @@ msgid ""
 msgstr ""
 "Interrompere fusione?\n"
 "\n"
-"L'interruzione della fusione corrente causer=C3=A0 la perdita di *TUT=
TE* le "
+"L'interruzione della fusione attuale causer=C3=A0 la perdita di *TUTT=
E* le "
 "modifiche non ancora presenti nell'archivio.\n"
 "\n"
-"Continuare con l'interruzione della fusione corrente?"
+"Continuare con l'interruzione della fusione attuale?"
=20
 #: lib/merge.tcl:228
 msgid ""
@@ -1605,7 +1647,7 @@ msgstr ""
 "L'annullamento delle modifiche causer=C3=A0 la perdita di *TUTTE* le =
modifiche "
 "non ancora presenti nell'archivio.\n"
 "\n"
-"Continuare con l'annullamento delle modifiche correnti?"
+"Continuare con l'annullamento delle modifiche attuali?"
=20
 #: lib/merge.tcl:239
 msgid "Aborting"
@@ -1613,7 +1655,7 @@ msgstr "Interruzione in corso"
=20
 #: lib/merge.tcl:266
 msgid "Abort failed."
-msgstr "Interruzione fallita."
+msgstr "Interruzione non riuscita."
=20
 #: lib/merge.tcl:268
 msgid "Abort completed.  Ready."
@@ -1621,7 +1663,7 @@ msgstr "Interruzione completata. Pronto."
=20
 #: lib/option.tcl:82
 msgid "Restore Defaults"
-msgstr "Ripristina predefiniti"
+msgstr "Ripristina valori predefiniti"
=20
 #: lib/option.tcl:86
 msgid "Save"
@@ -1763,8 +1805,8 @@ msgid ""
 "One or more of the merge tests failed because you have not fetched th=
e "
 "necessary commits.  Try fetching from %s first."
 msgstr ""
-"Una o pi=C3=B9 verifiche di fusione sono fallite perch=C3=A9 mancano =
le revisioni "
-"necessarie. Prova prima a recuperarle da %s."
+"Impossibile verificare una o pi=C3=B9 fusioni: mancano le revisioni n=
ecessarie. "
+"Prova prima a recuperarle da %s."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
@@ -1794,18 +1836,18 @@ msgstr "Nessun archivio selezionato."
 msgid "Scanning %s..."
 msgstr "Analisi in corso %s..."
=20
-#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
-msgid "Cannot write script:"
-msgstr "Impossibile scrivere script:"
+#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+msgid "Cannot write shortcut:"
+msgstr "Impossibile scrivere shortcut:"
=20
-#: lib/shortcut.tcl:149
+#: lib/shortcut.tcl:136
 msgid "Cannot write icon:"
 msgstr "Impossibile scrivere icona:"
=20
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
-msgstr "%s ... %*i di %*i %s (%3i%%)"
+msgstr "%1$s ... %6$s: %2$*i di %4$*i (%7$3i%%)"
=20
 #: lib/transport.tcl:6
 #, tcl-format
@@ -1869,4 +1911,3 @@ msgstr "Utilizza 'thin pack' (per connessioni len=
te)"
 #: lib/transport.tcl:168
 msgid "Include tags"
 msgstr "Includi etichette"
-
--=20
1.5.3.5
