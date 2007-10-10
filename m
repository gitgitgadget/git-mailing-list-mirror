From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH - amended] git-gui: update Italian translation
Date: Wed, 10 Oct 2007 22:18:23 +0200
Message-ID: <200710102218.23482.barra_cuda@katamail.com>
References: <200710101533.17290.barra_cuda@katamail.com> <200710101658.32229.barra_cuda@katamail.com> <4d8e3fd30710100816t7254786fi58933496661fc15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_POTDHWy+rvHqC80"
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 22:16:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifhyl-0001t5-5I
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 22:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbXJJUQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 16:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755515AbXJJUQQ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 16:16:16 -0400
Received: from slim-3a.inet.it ([213.92.5.124]:32811 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492AbXJJUQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 16:16:15 -0400
Received: from host132-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.132]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.132+9pwmi0eBFr0; Wed, 10 Oct 2007 22:15:31 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <4d8e3fd30710100816t7254786fi58933496661fc15@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60538>

--Boundary-00=_POTDHWy+rvHqC80
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 10 October 2007, Paolo Ciarrocchi wrote:
> On 10/10/07, Michele Ballabio <barra_cuda@katamail.com> wrote:
> > On Wednesday 10 October 2007, Paolo Ciarrocchi wrote:
> > > In short, I'm still think we should leave the word untranslated.
> > >
> > > How about posting the new file to ltp and move there the discussion?
> >
> > Uhm. What about "nuova revisione"/"creare una nuova revisione"? Otherwise,
> > I'll select some strings and post them there.
> 
> I like "nuova revisione".

So here it is. (Sent as an attachment because I fear mangling, sorry).


--Boundary-00=_POTDHWy+rvHqC80
Content-Type: text/x-diff;
  charset="utf-8";
  name="amended-0001-git-gui-update-Italian-translation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="amended-0001-git-gui-update-Italian-translation.patch"

>From 73ef7cd983ed915bd8f085510746b991ed7d65e2 Mon Sep 17 00:00:00 2001
From: Michele Ballabio <barra_cuda@katamail.com>
Date: Wed, 10 Oct 2007 15:04:16 +0200
Subject: [PATCH] git-gui: update Italian translation

An Italian glossary was also added. Some changes:
 * commit (verb): (creare una) nuova revisione
 * commit (noun): revisione
 * checkout: attivazione
 * tracking branch: duplicato locale di ramo remoto
 * repository: archivio
 * some terms are used with more consistency

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 po/glossary/it.po |  180 +++++++++++++++++++
 po/it.po          |  493 +++++++++++++++++++++++++++--------------------------
 2 files changed, 429 insertions(+), 244 deletions(-)
 create mode 100644 po/glossary/it.po

diff --git a/po/glossary/it.po b/po/glossary/it.po
new file mode 100644
index 0000000..8e3d9a2
--- /dev/null
+++ b/po/glossary/it.po
@@ -0,0 +1,180 @@
+# Translation of git-gui glossary to Italian
+# Copyright (C) 2007 Shawn Pearce, et al.
+# This file is distributed under the same license as the git package.
+# Christian Stimming <stimming@tuhh.de>, 2007
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui glossary\n"
+"POT-Creation-Date: 2007-10-05 22:30+0200\n"
+"PO-Revision-Date: 2007-10-10 15:24+0200\n"
+"Last-Translator: Michele Ballabio <barra_cuda@katamail.com>\n"
+"Language-Team: Italian \n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#. "English Definition (Dear translator: This file will never be visible to the user! It should only serve as a tool for you, the translator. Nothing more.)"
+msgid ""
+"English Term (Dear translator: This file will never be visible to the user!)"
+msgstr ""
+"Traduzione italiana.\n"
+"Altri SCM in italiano:\n"
+"  http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/Languages/Tortoise_it."
+"po (username=guest, password empty),\n"
+"  http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/po/TortoiseCVS/it_IT.po?"
+"view=markup ,\n"
+"  http://rapidsvn.tigris.org/svn/rapidsvn/trunk/src/locale/it_IT/rapidsvn.po "
+"(username=guest, password empty)"
+
+#. ""
+msgid "amend"
+msgstr "correggere, correzione"
+
+#. ""
+msgid "annotate"
+msgstr "annotare, annotazione"
+
+#. "A 'branch' is an active line of development."
+msgid "branch [noun]"
+msgstr "ramo, diramazione, ramificazione"
+
+#. ""
+msgid "branch [verb]"
+msgstr "creare ramo, ramificare, diramare"
+
+#. ""
+msgid "checkout [noun]"
+msgstr "attivazione, checkout, revisione attiva, prelievo (TortoiseCVS)?"
+
+#. "The action of updating the working tree to a revision which was stored in the object database."
+msgid "checkout [verb]"
+msgstr ""
+"attivare, effettuare un checkout, attivare revisione, prelevare (TortoiseCVS), "
+"ritirare (TSVN)?"
+
+#. ""
+msgid "clone [verb]"
+msgstr "clonare"
+
+#. "A single point in the git history."
+msgid "commit [noun]"
+msgstr "revisione, commit, deposito (TortoiseCVS), invio (TSVN)?"
+
+#. "The action of storing a new snapshot of the project's state in the git history."
+msgid "commit [verb]"
+msgstr ""
+"creare una nuova revisione, archiviare, effettuare un commit, depositare "
+"(nel server), fare un deposito (TortoiseCVS), inviare (TSVN)?"
+
+#. ""
+msgid "diff [noun]"
+msgstr "differenza, confronto, comparazione, raffronto"
+
+#. ""
+msgid "diff [verb]"
+msgstr "confronta, mostra le differenze"
+
+#. "A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
+msgid "fast forward merge"
+msgstr "fusione in 'fast-forward', fusione in avanti veloce"
+
+#. "Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
+msgid "fetch"
+msgstr "recuperare, prelevare, prendere da, recuperare (TSVN)"
+
+#. "A collection of files. The index is a stored version of your working tree."
+msgid "index (in git-gui: staging area)"
+msgstr "indice"
+
+#. "A successful merge results in the creation of a new commit representing the result of the merge."
+msgid "merge [noun]"
+msgstr "fusione, unione"
+
+#. "To bring the contents of another branch into the current branch."
+msgid "merge [verb]"
+msgstr "effettuare la fusione, unire, fondere, eseguire la fusione"
+
+#. ""
+msgid "message"
+msgstr "messaggio, commento"
+
+#. ""
+msgid "prune"
+msgstr "potatura"
+
+#. "Pulling a branch means to fetch it and merge it."
+msgid "pull"
+msgstr ""
+"prendi (recupera) e fondi (unisci)? (in pratica una traduzione di fetch + "
+"merge)"
+
+#. "Pushing a branch means to get the branch's head ref from a remote repository, and ... (well, can someone please explain it for mere mortals?)"
+msgid "push"
+msgstr "propaga"
+
+#. ""
+msgid "redo"
+msgstr "ripeti, rifai"
+
+#. "A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
+msgid "repository"
+msgstr "archivio, repository, database? deposito (rapidsvn)?"
+
+#. ""
+msgid "reset"
+msgstr "ripristinare, annullare, azzerare, ripristinare"
+
+#. ""
+msgid "revert"
+msgstr ""
+"annullare, inverti (rapidsvn), ritorna allo stato precedente, annulla le "
+"modifiche della revisione"
+
+#. "A particular state of files and directories which was stored in the object database."
+msgid "revision"
+msgstr "revisione (TortoiseSVN)"
+
+#. ""
+msgid "sign off"
+msgstr "sign off, firma"
+
+#. ""
+msgid "staging area"
+msgstr ""
+"area di preparazione, zona di preparazione, modifiche in preparazione? "
+"modifiche in allestimento?"
+
+#. ""
+msgid "status"
+msgstr "stato"
+
+#. "A ref pointing to a tag or commit object"
+msgid "tag [noun]"
+msgstr "etichetta, etichettatura (TortoiseCVS)"
+
+#. ""
+msgid "tag [verb]"
+msgstr "etichettare"
+
+#. "A regular git branch that is used to follow changes from another repository."
+msgid "tracking branch"
+msgstr ""
+"duplicato locale di ramo remoto, ramo in 'tracking', ramo inseguitore? ramo di {inseguimento,allineamento,"
+"rilevamento,puntamento}?"
+
+#. ""
+msgid "undo"
+msgstr "annulla"
+
+#. ""
+msgid "update"
+msgstr "aggiornamento, aggiornare"
+
+#. ""
+msgid "verify"
+msgstr "verifica, verificare"
+
+#. "The tree of actual checked out files."
+msgid "working copy, working tree"
+msgstr "directory di lavoro, copia di lavoro"
diff --git a/po/it.po b/po/it.po
index d959019..7668414 100644
--- a/po/it.po
+++ b/po/it.po
@@ -9,8 +9,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-10-10 04:04-0400\n"
-"PO-Revision-Date: 2007-08-09 00:27+0200\n"
+"POT-Creation-Date: 2007-10-10 14:42+0200\n"
+"PO-Revision-Date: 2007-10-10 15:27+0200\n"
 "Last-Translator: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>\n"
 "Language-Team: Italian <tp@lists.linux.it>\n"
 "MIME-Version: 1.0\n"
@@ -20,12 +20,12 @@ msgstr ""
 #: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.sh:744
 #: git-gui.sh:763
 msgid "git-gui: fatal error"
-msgstr ""
+msgstr "git-gui: errore grave"
 
 #: git-gui.sh:595
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Invalid font specified in %s:"
-msgstr "Caratteri non validi specificati nella gui.%s:"
+msgstr "Caratteri non validi specificati in %s:"
 
 #: git-gui.sh:620
 msgid "Main Font"
@@ -56,7 +56,7 @@ msgid ""
 msgstr ""
 "La versione di GIT non può essere determinata.\n"
 "\n"
-"%s sostiene che la versione è '%s'.\n"
+"%s riporta che la versione è '%s'.\n"
 "\n"
 "%s richiede almeno Git 1.5.0 o superiore.\n"
 "\n"
@@ -67,9 +67,8 @@ msgid "Git directory not found:"
 msgstr "Non trovo la directory di git: "
 
 #: git-gui.sh:860
-#, fuzzy
 msgid "Cannot move to top of working directory:"
-msgstr "Impossibile usare una .git directory strana:"
+msgstr "Impossibile spostarsi sulla directory principale del progetto:"
 
 #: git-gui.sh:867
 msgid "Cannot use funny .git directory:"
@@ -97,23 +96,23 @@ msgstr "Non modificato"
 
 #: git-gui.sh:1527
 msgid "Modified, not staged"
-msgstr "Modificato, non pronto per il commit"
+msgstr "Modificato, non preparato per una nuova revisione"
 
 #: git-gui.sh:1528 git-gui.sh:1533
 msgid "Staged for commit"
-msgstr "Pronto per il commit"
+msgstr "Preparato per una nuova revisione"
 
 #: git-gui.sh:1529 git-gui.sh:1534
 msgid "Portions staged for commit"
-msgstr "Parti pronte per il commit"
+msgstr "Parti preparate per una nuova revisione"
 
 #: git-gui.sh:1530 git-gui.sh:1535
 msgid "Staged for commit, missing"
-msgstr "Pronto per il commit, mancante"
+msgstr "Preparato per una nuova revisione, mancante"
 
 #: git-gui.sh:1532
 msgid "Untracked, not staged"
-msgstr "Non tracciato, non pronto per il commit"
+msgstr "Non tracciato, non preparato per una nuova revisione"
 
 #: git-gui.sh:1537
 msgid "Missing"
@@ -121,11 +120,11 @@ msgstr "Mancante"
 
 #: git-gui.sh:1538
 msgid "Staged for removal"
-msgstr "Pronto per la rimozione"
+msgstr "Preparato per la rimozione"
 
 #: git-gui.sh:1539
 msgid "Staged for removal, still present"
-msgstr "Pronto alla rimozione, ancora presente"
+msgstr "Preparato alla rimozione, ancora presente"
 
 #: git-gui.sh:1541 git-gui.sh:1542 git-gui.sh:1543 git-gui.sh:1544
 msgid "Requires merge resolution"
@@ -159,18 +158,16 @@ msgid "Branch"
 msgstr "Ramo"
 
 #: git-gui.sh:1794 lib/choose_rev.tcl:547
-#, fuzzy
 msgid "Commit@@noun"
-msgstr "Commit"
+msgstr "Revisione"
 
 #: git-gui.sh:1797 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
 msgid "Merge"
 msgstr "Fusione (Merge)"
 
 #: git-gui.sh:1798 lib/choose_rev.tcl:556
-#, fuzzy
 msgid "Remote"
-msgstr "Remoto:"
+msgstr "Remoto"
 
 #: git-gui.sh:1807
 msgid "Browse Current Branch's Files"
@@ -200,15 +197,15 @@ msgstr "Visualizza la cronologia di %s"
 
 #: git-gui.sh:1834 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
-msgstr "Statistiche del database"
+msgstr "Statistiche dell'archivio"
 
 #: git-gui.sh:1837 lib/database.tcl:34
 msgid "Compress Database"
-msgstr "Comprimi il database"
+msgstr "Comprimi l'archivio"
 
 #: git-gui.sh:1840
 msgid "Verify Database"
-msgstr "Verifica il database"
+msgstr "Verifica l'archivio"
 
 #: git-gui.sh:1847 git-gui.sh:1851 git-gui.sh:1855 lib/shortcut.tcl:9
 #: lib/shortcut.tcl:45 lib/shortcut.tcl:84
@@ -255,7 +252,7 @@ msgstr "Crea..."
 
 #: git-gui.sh:1902
 msgid "Checkout..."
-msgstr "Checkout..."
+msgstr "Attiva..."
 
 #: git-gui.sh:1908
 msgid "Rename..."
@@ -271,11 +268,11 @@ msgstr "Ripristina..."
 
 #: git-gui.sh:1930 git-gui.sh:2313
 msgid "New Commit"
-msgstr "Nuovo commit"
+msgstr "Nuova revisione"
 
 #: git-gui.sh:1938 git-gui.sh:2320
 msgid "Amend Last Commit"
-msgstr "Correggi l'ultimo commit"
+msgstr "Correggi l'ultima revisione"
 
 #: git-gui.sh:1947 git-gui.sh:2280 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
@@ -283,15 +280,15 @@ msgstr "Analizza nuovamente"
 
 #: git-gui.sh:1953
 msgid "Stage To Commit"
-msgstr "Prepara per il commit"
+msgstr "Prepara per una nuova revisione"
 
 #: git-gui.sh:1958
 msgid "Stage Changed Files To Commit"
-msgstr "Prepara per il commit i file modificati"
+msgstr "Prepara i file modificati per una nuova revisione"
 
 #: git-gui.sh:1964
 msgid "Unstage From Commit"
-msgstr "Non pronto per il commit"
+msgstr "Annulla preparazione"
 
 #: git-gui.sh:1969 lib/index.tcl:352
 msgid "Revert Changes"
@@ -302,17 +299,16 @@ msgid "Sign Off"
 msgstr "Sign Off"
 
 #: git-gui.sh:1980 git-gui.sh:2296
-#, fuzzy
 msgid "Commit@@verb"
-msgstr "Commit"
+msgstr "Nuova revisione"
 
 #: git-gui.sh:1991
 msgid "Local Merge..."
-msgstr "Fusione locale"
+msgstr "Fusione locale..."
 
 #: git-gui.sh:1996
 msgid "Abort Merge..."
-msgstr "Interrompi fusione"
+msgstr "Interrompi fusione..."
 
 #: git-gui.sh:2008
 msgid "Push..."
@@ -330,7 +326,7 @@ msgstr "Informazioni su %s"
 
 #: git-gui.sh:2026
 msgid "Preferences..."
-msgstr ""
+msgstr "Preferenze..."
 
 #: git-gui.sh:2034 git-gui.sh:2558
 msgid "Options..."
@@ -348,20 +344,20 @@ msgstr "Documentazione sul web"
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
+"errore grave: impossibile effettuare lo stat del path %s: file o directory "
+"non trovata"
 
 #: git-gui.sh:2198
 msgid "Current Branch:"
 msgstr "Ramo attuale:"
 
 #: git-gui.sh:2219
-#, fuzzy
 msgid "Staged Changes (Will Commit)"
-msgstr "Modifiche preparate (ne verrà effettuato il commit)"
+msgstr "Modifiche preparate (saranno nella nuova revisione)"
 
 #: git-gui.sh:2239
-#, fuzzy
 msgid "Unstaged Changes"
-msgstr "Prepara modificati"
+msgstr "Modifiche non preparate"
 
 #: git-gui.sh:2286
 msgid "Stage Changed"
@@ -373,15 +369,15 @@ msgstr "Propaga (Push)"
 
 #: git-gui.sh:2332
 msgid "Initial Commit Message:"
-msgstr "Messaggio di commit iniziale:"
+msgstr "Messaggio di revisione iniziale:"
 
 #: git-gui.sh:2333
 msgid "Amended Commit Message:"
-msgstr "Messaggio di commit corretto:"
+msgstr "Messaggio di revisione corretto:"
 
 #: git-gui.sh:2334
 msgid "Amended Initial Commit Message:"
-msgstr "Messaggio iniziale di commit corretto:"
+msgstr "Messaggio iniziale di revisione corretto:"
 
 #: git-gui.sh:2335
 msgid "Amended Merge Commit Message:"
@@ -393,7 +389,7 @@ msgstr "Messaggio di fusione:"
 
 #: git-gui.sh:2337
 msgid "Commit Message:"
-msgstr "Messaggio di commit:"
+msgstr "Messaggio di revisione:"
 
 #: git-gui.sh:2382 git-gui.sh:2520 lib/console.tcl:71
 msgid "Copy All"
@@ -429,11 +425,11 @@ msgstr "Mostra più contesto"
 
 #: git-gui.sh:2565
 msgid "Unstage Hunk From Commit"
-msgstr "Sezione non pronta per il commit"
+msgstr "Sezione non preparata per una nuova revisione"
 
 #: git-gui.sh:2567
 msgid "Stage Hunk For Commit"
-msgstr "Prepara sezione per il commit"
+msgstr "Prepara sezione per una nuova revisione"
 
 #: git-gui.sh:2586
 msgid "Initializing..."
@@ -449,6 +445,12 @@ msgid ""
 "by %s:\n"
 "\n"
 msgstr ""
+"Possibili problemi con le variabili d'ambiente.\n"
+"\n"
+"Le seguenti variabili d'ambiente saranno probabilmente\n"
+"ignorate da tutti i sottoprocessi di Git avviati\n"
+"da %s:\n"
+"\n"
 
 #: git-gui.sh:2707
 msgid ""
@@ -456,6 +458,9 @@ msgid ""
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr ""
+"\n"
+"Ciò è dovuto a un problema conosciuto\n"
+"causato dall'eseguibile Tcl distribuito da Cygwin."
 
 #: git-gui.sh:2712
 #, tcl-format
@@ -467,6 +472,11 @@ msgid ""
 "user.email settings into your personal\n"
 "~/.gitconfig file.\n"
 msgstr ""
+"\n"
+"\n"
+"Una buona alternativa a %s\n"
+"consiste nell'assegnare valori alle variabili di configurazione\n"
+"user.name e user.email nel tuo file ~/.gitconfig personale.\n"
 
 #: lib/about.tcl:25
 msgid "git-gui - a graphical user interface for Git."
@@ -478,11 +488,11 @@ msgstr "Mostra file"
 
 #: lib/blame.tcl:81
 msgid "Commit:"
-msgstr "Commit:"
+msgstr "Revisione:"
 
 #: lib/blame.tcl:249
 msgid "Copy Commit"
-msgstr "Copia commit"
+msgstr "Copia revisione"
 
 #: lib/blame.tcl:369
 #, tcl-format
@@ -491,58 +501,55 @@ msgstr "Lettura di %s..."
 
 #: lib/blame.tcl:473
 msgid "Loading copy/move tracking annotations..."
-msgstr ""
+msgstr "Caricamento annotazioni per copie/spostamenti..."
 
 #: lib/blame.tcl:493
 msgid "lines annotated"
-msgstr ""
+msgstr "linee annotate"
 
 #: lib/blame.tcl:674
 msgid "Loading original location annotations..."
-msgstr ""
+msgstr "Caricamento annotazioni per posizione originaria..."
 
 #: lib/blame.tcl:677
 msgid "Annotation complete."
-msgstr ""
+msgstr "Annotazione completata."
 
 #: lib/blame.tcl:731
-#, fuzzy
 msgid "Loading annotation..."
-msgstr "Caricamento %s..."
+msgstr "Caricamento annotazioni..."
 
 #: lib/blame.tcl:787
 msgid "Author:"
-msgstr ""
+msgstr "Autore:"
 
 #: lib/blame.tcl:791
-#, fuzzy
 msgid "Committer:"
-msgstr "Commit:"
+msgstr "Revisione creata da:"
 
 #: lib/blame.tcl:796
 msgid "Original File:"
-msgstr ""
+msgstr "File originario:"
 
 #: lib/blame.tcl:910
 msgid "Originally By:"
-msgstr ""
+msgstr "In origine da:"
 
 #: lib/blame.tcl:916
-#, fuzzy
 msgid "In File:"
-msgstr "File:"
+msgstr "Nel file:"
 
 #: lib/blame.tcl:921
 msgid "Copied Or Moved Here By:"
-msgstr ""
+msgstr "Copiato o spostato qui da:"
 
 #: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
 msgid "Checkout Branch"
-msgstr "Checkout ramo"
+msgstr "Attiva ramo"
 
 #: lib/branch_checkout.tcl:23
 msgid "Checkout"
-msgstr "Checkout"
+msgstr "Attiva"
 
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:281
@@ -561,7 +568,7 @@ msgstr "Opzioni"
 
 #: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
-msgstr "Preleva ramo in 'tracking'"
+msgstr "Recupera duplicato locale di ramo remoto"
 
 #: lib/branch_checkout.tcl:44
 msgid "Detach From Local Branch"
@@ -589,7 +596,7 @@ msgstr "Nome:"
 
 #: lib/branch_create.tcl:58
 msgid "Match Tracking Branch Name"
-msgstr "Appaia nome del ramo in 'tracking'"
+msgstr "Appaia nome del duplicato locale di ramo remoto"
 
 #: lib/branch_create.tcl:66
 msgid "Starting Revision"
@@ -613,16 +620,17 @@ msgstr "Ripristina"
 
 #: lib/branch_create.tcl:97
 msgid "Checkout After Creation"
-msgstr "Checkout dopo la creazione"
+msgstr "Attiva dopo la creazione"
 
 #: lib/branch_create.tcl:131
 msgid "Please select a tracking branch."
-msgstr "Scegliere un ramo in 'tracking'"
+msgstr "Scegliere un duplicato locale di ramo remoto"
 
 #: lib/branch_create.tcl:140
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "Il ramo in 'tracking' %s non è un ramo nell'archivio remoto."
+msgstr ""
+"Il duplicato locale del ramo remoto %s non è un ramo nell'archivio remoto."
 
 #: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
 msgid "Please supply a branch name."
@@ -651,7 +659,7 @@ msgstr "Cancella solo se fuso con un altro ramo"
 
 #: lib/branch_delete.tcl:54
 msgid "Always (Do not perform merge test.)"
-msgstr "Sempre (Non effettuare controlli durante la fusione)."
+msgstr "Sempre (Non effettuare verifiche di fusione)."
 
 #: lib/branch_delete.tcl:103
 #, tcl-format
@@ -664,7 +672,7 @@ msgid ""
 "\n"
 " Delete the selected branches?"
 msgstr ""
-"Prelevare rami cancellati può essere complicato. \n"
+"Ricomporre rami cancellati può essere complicato. \n"
 "\n"
 " Eliminare i rami selezionati?"
 
@@ -700,12 +708,12 @@ msgstr "Scegliere un ramo da rinominare."
 #: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
 #, tcl-format
 msgid "Branch '%s' already exists."
-msgstr "Il ramo '%s' esiste già"
+msgstr "Il ramo '%s' esiste già."
 
 #: lib/branch_rename.tcl:117
 #, tcl-format
 msgid "Failed to rename '%s'."
-msgstr "Cambiamento nome '%s' fallito."
+msgstr "Impossibile rinominare '%s'."
 
 #: lib/browser.tcl:17
 msgid "Starting..."
@@ -742,7 +750,7 @@ msgstr "Recupero %s da %s"
 #: lib/checkout_op.tcl:127
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
-msgstr ""
+msgstr "errore grave: impossibile risolvere %s"
 
 #: lib/checkout_op.tcl:140 lib/console.tcl:79 lib/database.tcl:31
 msgid "Close"
@@ -778,7 +786,7 @@ msgstr "Aggiornamento di '%s' fallito."
 
 #: lib/checkout_op.tcl:251
 msgid "Staging area (index) is already locked."
-msgstr "L'area di preparazione per il commit (indice) è già bloccata."
+msgstr "L'area di preparazione per una nuova revisione (indice) è già bloccata."
 
 #: lib/checkout_op.tcl:266
 msgid ""
@@ -789,23 +797,23 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"L'ultimo stato analizzato non corrisponde allo stato del repository.\n"
+"L'ultimo stato analizzato non corrisponde allo stato dell'archivio.\n"
 "\n"
-"Un altro programma Git ha modificato questo repository dall'ultima analisi. "
+"Un altro programma Git ha modificato questo archivio dall'ultima analisi. "
 "Bisogna effettuare una nuova analisi prima di poter cambiare il ramo "
 "corrente.\n"
 "\n"
 "La nuova analisi comincerà ora.\n"
 
 #: lib/checkout_op.tcl:322
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Updating working directory to '%s'..."
-msgstr "Nessuna directory di lavoro"
+msgstr "Aggiornamento della directory di lavoro a '%s' in corso..."
 
 #: lib/checkout_op.tcl:353
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
-msgstr "Checkout di '%s' fallito (richiesta una fusione a livello file)."
+msgstr "Attivazione di '%s' fallita (richiesta una fusione a livello file)."
 
 #: lib/checkout_op.tcl:354
 msgid "File level merge required."
@@ -825,22 +833,23 @@ msgid ""
 msgstr ""
 "Non si è più su un ramo locale\n"
 "\n"
-"Se si vuole rimanere su un ramo, crearne uno ora a partire da 'Questo "
-"checkout staccato'."
+"Se si vuole rimanere su un ramo, crearne uno ora a partire da 'Questa "
+"revisione attiva staccata'."
 
 #: lib/checkout_op.tcl:446
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Checked out '%s'."
-msgstr "Checkout..."
+msgstr "Attivazione di '%s' completata."
 
 #: lib/checkout_op.tcl:478
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
-msgstr "Ripristinare '%s' a '%s' comporterà la perdita dei seguenti commit:"
+msgstr ""
+"Ripristinare '%s' a '%s' comporterà la perdita delle seguenti revisioni:"
 
 #: lib/checkout_op.tcl:500
 msgid "Recovering lost commits may not be easy."
-msgstr "Prelevare i commit perduti potrebbe non essere semplice."
+msgstr "Ricomporre le revisioni perdute potrebbe non essere semplice."
 
 #: lib/checkout_op.tcl:505
 #, tcl-format
@@ -870,130 +879,125 @@ msgstr ""
 "Questo non sarebbe dovuto succedere.  %s ora terminerà senza altre azioni."
 
 #: lib/choose_font.tcl:39
-#, fuzzy
 msgid "Select"
-msgstr "Seleziona tutto"
+msgstr "Seleziona"
 
 #: lib/choose_font.tcl:53
 msgid "Font Family"
-msgstr ""
+msgstr "Famiglia di caratteri"
 
 #: lib/choose_font.tcl:73
-#, fuzzy
 msgid "Font Size"
-msgstr "Diminuisci dimensione caratteri"
+msgstr "Dimensione caratteri"
 
 #: lib/choose_font.tcl:90
 msgid "Font Example"
-msgstr ""
+msgstr "Esempio caratteri"
 
 #: lib/choose_font.tcl:101
 msgid ""
 "This is example text.\n"
 "If you like this text, it can be your font."
 msgstr ""
+"Questo è un testo d'esempio.\n"
+"Se ti piace questo testo, può essere il carattere giusto."
 
 #: lib/choose_repository.tcl:25
 msgid "Git Gui"
-msgstr ""
+msgstr "Git Gui"
 
 #: lib/choose_repository.tcl:69 lib/choose_repository.tcl:204
-#, fuzzy
 msgid "Create New Repository"
-msgstr "Da archivio"
+msgstr "Crea nuovo archivio"
 
 #: lib/choose_repository.tcl:74 lib/choose_repository.tcl:291
-#, fuzzy
 msgid "Clone Existing Repository"
-msgstr "Archivio di destinazione"
+msgstr "Clona archivio esistente"
 
 #: lib/choose_repository.tcl:79 lib/choose_repository.tcl:800
-#, fuzzy
 msgid "Open Existing Repository"
-msgstr "Archivio di destinazione"
+msgstr "Apri archivio esistente"
 
 #: lib/choose_repository.tcl:91
 msgid "Next >"
-msgstr ""
+msgstr "Successivo >"
 
 #: lib/choose_repository.tcl:152
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Location %s already exists."
-msgstr "Il ramo '%s' esiste già"
+msgstr "La posizione %s esiste già."
 
 #: lib/choose_repository.tcl:158 lib/choose_repository.tcl:165
 #: lib/choose_repository.tcl:172
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Failed to create repository %s:"
-msgstr "Fallimento nel salvataggio completo delle opzioni:"
+msgstr "Impossibile creare l'archivio %s:"
 
 #: lib/choose_repository.tcl:209 lib/choose_repository.tcl:309
 msgid "Directory:"
-msgstr ""
+msgstr "Directory:"
 
 #: lib/choose_repository.tcl:238 lib/choose_repository.tcl:363
 #: lib/choose_repository.tcl:834
-#, fuzzy
 msgid "Git Repository"
-msgstr "Archivio"
+msgstr "Archivio Git"
 
 #: lib/choose_repository.tcl:253 lib/choose_repository.tcl:260
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Directory %s already exists."
-msgstr "Il ramo '%s' esiste già"
+msgstr "La directory %s esiste già."
 
 #: lib/choose_repository.tcl:265
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "File %s already exists."
-msgstr "Il ramo '%s' esiste già"
+msgstr "Il file %s esiste già."
 
 #: lib/choose_repository.tcl:286
-#, fuzzy
 msgid "Clone"
-msgstr "Chiudi"
+msgstr "Clona"
 
 #: lib/choose_repository.tcl:299
 msgid "URL:"
-msgstr ""
+msgstr "URL:"
 
 #: lib/choose_repository.tcl:319
 msgid "Clone Type:"
-msgstr ""
+msgstr "Tipo di clone:"
 
 #: lib/choose_repository.tcl:325
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
-msgstr ""
+msgstr "Standard (veloce, semi-ridondante, con hardlink)"
 
 #: lib/choose_repository.tcl:331
 msgid "Full Copy (Slower, Redundant Backup)"
-msgstr ""
+msgstr "Copia completa (più lento, backup ridondante)"
 
 #: lib/choose_repository.tcl:337
 msgid "Shared (Fastest, Not Recommended, No Backup)"
-msgstr ""
+msgstr "Shared (il più veloce, non raccomandato, nessun backup)"
 
 #: lib/choose_repository.tcl:369 lib/choose_repository.tcl:418
 #: lib/choose_repository.tcl:560 lib/choose_repository.tcl:630
 #: lib/choose_repository.tcl:840 lib/choose_repository.tcl:848
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Not a Git repository: %s"
-msgstr "Nessun archivio selezionato."
+msgstr "%s non è un archivio Git."
 
 #: lib/choose_repository.tcl:405
 msgid "Standard only available for local repository."
-msgstr ""
+msgstr "Standard è disponibile solo per archivi locali."
 
 #: lib/choose_repository.tcl:409
 msgid "Shared only available for local repository."
-msgstr ""
+msgstr "Shared è disponibile solo per archivi locali."
 
 #: lib/choose_repository.tcl:439
 msgid "Failed to configure origin"
-msgstr ""
+msgstr "Impossibile configurare origin"
 
 #: lib/choose_repository.tcl:451
 msgid "Counting objects"
-msgstr ""
+msgstr "Calcolo oggetti"
 
 #: lib/choose_repository.tcl:452
 msgid "buckets"
@@ -1002,116 +1006,117 @@ msgstr ""
 #: lib/choose_repository.tcl:476
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
-msgstr ""
+msgstr "Impossibile copiare oggetti/info/alternate: %s"
 
 #: lib/choose_repository.tcl:512
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Nothing to clone from %s."
-msgstr "Recupero nuove modifiche da %s"
+msgstr "Niente da clonare da %s."
 
 #: lib/choose_repository.tcl:514 lib/choose_repository.tcl:728
 #: lib/choose_repository.tcl:740
 msgid "The 'master' branch has not been initialized."
-msgstr ""
+msgstr "Il ramo 'master' non è stato inizializzato."
 
 #: lib/choose_repository.tcl:527
 msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr ""
+msgstr "Impossibile utilizzare gli hardlink. Si ricorrerà alla copia."
 
 #: lib/choose_repository.tcl:539
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Cloning from %s"
-msgstr "Recupero %s da %s"
+msgstr "Clonazione da %s"
 
 #: lib/choose_repository.tcl:570
-#, fuzzy
 msgid "Copying objects"
-msgstr "Compressione del database in corso"
+msgstr "Copia degli oggetti"
 
 #: lib/choose_repository.tcl:571
 msgid "KiB"
-msgstr ""
+msgstr "KiB"
 
 #: lib/choose_repository.tcl:595
 #, tcl-format
 msgid "Unable to copy object: %s"
-msgstr ""
+msgstr "Impossibile copiare oggetto: %s"
 
 #: lib/choose_repository.tcl:605
 msgid "Linking objects"
-msgstr ""
+msgstr "Collegamento oggetti"
 
 #: lib/choose_repository.tcl:606
 msgid "objects"
-msgstr ""
+msgstr "oggetti"
 
 #: lib/choose_repository.tcl:614
 #, tcl-format
 msgid "Unable to hardlink object: %s"
-msgstr ""
+msgstr "Hardlink impossibile sull'oggetto: %s"
 
 #: lib/choose_repository.tcl:669
 msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr ""
+"Impossibile recuperare rami e oggetti. Controllare i dettagli forniti dalla "
+"console."
 
 #: lib/choose_repository.tcl:680
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
+"Impossibile recuperare le etichette. Controllare i dettagli forniti dalla "
+"console."
 
 #: lib/choose_repository.tcl:704
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr ""
+"Impossibile determinare HEAD. Controllare i dettagli forniti dalla console."
 
 #: lib/choose_repository.tcl:713
 #, tcl-format
 msgid "Unable to cleanup %s"
-msgstr ""
+msgstr "Impossibile ripulire %s"
 
 #: lib/choose_repository.tcl:719
-#, fuzzy
 msgid "Clone failed."
-msgstr "Interruzione fallita."
+msgstr "Clonazione fallita."
 
 #: lib/choose_repository.tcl:726
 msgid "No default branch obtained."
-msgstr ""
+msgstr "Non è stato trovato un ramo predefinito."
 
 #: lib/choose_repository.tcl:737
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
-msgstr ""
+msgstr "Impossibile risolvere %s come una revisione."
 
 #: lib/choose_repository.tcl:749
-#, fuzzy
 msgid "Creating working directory"
-msgstr "Nessuna directory di lavoro"
+msgstr "Creazione directory di lavoro"
 
 #: lib/choose_repository.tcl:750 lib/index.tcl:15 lib/index.tcl:80
 #: lib/index.tcl:149
 msgid "files"
-msgstr ""
+msgstr "file"
 
 #: lib/choose_repository.tcl:779
 msgid "Initial file checkout failed."
-msgstr ""
+msgstr "Attivazione iniziale impossibile."
 
 #: lib/choose_repository.tcl:795
 msgid "Open"
-msgstr ""
+msgstr "Apri"
 
 #: lib/choose_repository.tcl:805
-#, fuzzy
 msgid "Repository:"
-msgstr "Archivio"
+msgstr "Archivio:"
 
 #: lib/choose_repository.tcl:854
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Failed to open repository %s:"
-msgstr "Fallimento nel salvataggio completo delle opzioni:"
+msgstr "Impossibile accedere all'archivio %s:"
 
 #: lib/choose_rev.tcl:53
 msgid "This Detached Checkout"
-msgstr "Questo checkout staccato"
+msgstr "Questa revisione attiva staccata"
 
 #: lib/choose_rev.tcl:60
 msgid "Revision Expression:"
@@ -1123,7 +1128,7 @@ msgstr "Ramo locale"
 
 #: lib/choose_rev.tcl:79
 msgid "Tracking Branch"
-msgstr "Ramo in 'tracking'"
+msgstr "Duplicato locale di ramo remoto"
 
 #: lib/choose_rev.tcl:84 lib/choose_rev.tcl:537
 msgid "Tag"
@@ -1144,11 +1149,11 @@ msgstr "L'espressione di revisione è vuota."
 
 #: lib/choose_rev.tcl:530
 msgid "Updated"
-msgstr ""
+msgstr "Aggiornato"
 
 #: lib/choose_rev.tcl:558
 msgid "URL"
-msgstr ""
+msgstr "URL"
 
 #: lib/commit.tcl:9
 msgid ""
@@ -1159,8 +1164,8 @@ msgid ""
 msgstr ""
 "Non c'è niente da correggere.\n"
 "\n"
-"Stai per creare il commit iniziale. Non esiste un commit precedente da "
-"correggere.\n"
+"Stai per creare la revisione iniziale. Non esiste una revisione "
+"precedente da correggere.\n"
 
 #: lib/commit.tcl:18
 msgid ""
@@ -1173,12 +1178,12 @@ msgstr ""
 "Non è possibile effettuare una correzione durante una fusione.\n"
 "\n"
 "In questo momento si sta effettuando una fusione che non è stata del tutto "
-"completata. Non puoi correggere il commit precedente a meno che prima tu non "
-"interrompa l'operazione di fusione in corso.\n"
+"completata. Non puoi correggere la revisione precedente a meno che prima tu "
+"non interrompa l'operazione di fusione in corso.\n"
 
 #: lib/commit.tcl:49
 msgid "Error loading commit data for amend:"
-msgstr "Errore durante il caricamento dei dati da correggere:"
+msgstr "Errore durante il caricamento dei dati della revisione da correggere:"
 
 #: lib/commit.tcl:76
 msgid "Unable to obtain your identity:"
@@ -1197,10 +1202,11 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"L'ultimo stato analizzato non corrisponde allo stato del repository.\n"
+"L'ultimo stato analizzato non corrisponde allo stato dell'archivio.\n"
 "\n"
-"Un altro programma Git ha modificato questo repository dall'ultima analisi. "
-"Bisogna effettuare una nuova analisi prima di poter creare un nuovo commit.\n"
+"Un altro programma Git ha modificato questo archivio dall'ultima analisi. "
+"Bisogna effettuare una nuova analisi prima di poter creare una nuova "
+"revisione.\n"
 "\n"
 "La nuova analisi comincerà ora.\n"
 
@@ -1212,10 +1218,10 @@ msgid ""
 "File %s has merge conflicts.  You must resolve them and stage the file "
 "before committing.\n"
 msgstr ""
-"Non è possibile effettuare il commit di file non sottoposti a fusione.\n"
+"Non è possibile creare una revisione con file non sottoposti a fusione.\n"
 "\n"
 "Il file %s presenta dei conflitti. Devi risolverli e preparare il file per "
-"il commit prima di effettuare questa azione.\n"
+"creare una nuova revisione prima di effettuare questa azione.\n"
 
 #: lib/commit.tcl:162
 #, tcl-format
@@ -1226,7 +1232,7 @@ msgid ""
 msgstr ""
 "Stato di file %s sconosciuto.\n"
 "\n"
-"Non si può effettuare il commit del file %s con questo programma.\n"
+"Questo programma non può creare una revisione contenente il file %s.\n"
 
 #: lib/commit.tcl:170
 msgid ""
@@ -1234,9 +1240,9 @@ msgid ""
 "\n"
 "You must stage at least 1 file before you can commit.\n"
 msgstr ""
-"Nessuna modifica per la quale effettuare il commit.\n"
+"Nessuna modifica per la nuova revisione.\n"
 "\n"
-"Devi preparare per il commit almeno 1 file prima di effettuare questa "
+"Devi preparare per una nuova revisione almeno 1 file prima di effettuare questa "
 "operazione.\n"
 
 #: lib/commit.tcl:183
@@ -1249,13 +1255,13 @@ msgid ""
 "- Second line: Blank\n"
 "- Remaining lines: Describe why this change is good.\n"
 msgstr ""
-"Bisogna fornire un messaggio di commit.\n"
+"Bisogna fornire un messaggio di revisione.\n"
 "\n"
-"Un buon messaggio di commit ha il seguente formato:\n"
+"Un buon messaggio di revisione ha il seguente formato:\n"
 "\n"
 "- Prima linea: descrivi in una frase ciò che hai fatto.\n"
 "- Seconda linea: vuota.\n"
-"- Terza linea: spiga a cosa serve la tua modifica.\n"
+"- Terza linea: spiega a cosa serve la tua modifica.\n"
 
 #: lib/commit.tcl:257
 msgid "write-tree failed:"
@@ -1264,7 +1270,7 @@ msgstr "write-tree fallito:"
 #: lib/commit.tcl:275
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
-msgstr ""
+msgstr "La revisione %s sembra essere corrotta"
 
 #: lib/commit.tcl:279
 msgid ""
@@ -1274,20 +1280,20 @@ msgid ""
 "\n"
 "A rescan will be automatically started now.\n"
 msgstr ""
-"Nessuna modifica pronta per il commit.\n"
+"Nessuna modifica per la nuova revisione.\n"
 "\n"
-"Questo commit non modifica alcun file e non effettua alcuna fusione.\n"
+"Questa revisione non modifica alcun file e non effettua alcuna fusione.\n"
 "\n"
 "Si procederà subito ad una nuova analisi.\n"
 
 #: lib/commit.tcl:286
 msgid "No changes to commit."
-msgstr "Nessuna modifica pronta per il commit."
+msgstr "Nessuna modifica per la nuova revisione."
 
 #: lib/commit.tcl:303
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
-msgstr ""
+msgstr "attenzione: Tcl non supporta la codifica '%s'."
 
 #: lib/commit.tcl:317
 msgid "commit-tree failed:"
@@ -1300,7 +1306,7 @@ msgstr "update-ref fallito:"
 #: lib/commit.tcl:430
 #, tcl-format
 msgid "Created commit %s: %s"
-msgstr "Creato commit %s: %s"
+msgstr "Creata revisione %s: %s"
 
 #: lib/console.tcl:57
 msgid "Working... please wait..."
@@ -1344,7 +1350,7 @@ msgstr "File inutili"
 
 #: lib/database.tcl:72
 msgid "Compressing the object database"
-msgstr "Compressione del database in corso"
+msgstr "Compressione dell'archivio in corso"
 
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
@@ -1360,11 +1366,17 @@ msgid ""
 "\n"
 "Compress the database now?"
 msgstr ""
+"Questo archivio attualmente ha circa %i oggetti slegati.\n"
+"\n"
+"Per mantenere buone prestazioni si raccomanda di comprimere l'archivio "
+"quando sono presenti più di %i oggetti slegati.\n"
+"\n"
+"Comprimere l'archivio ora?"
 
 #: lib/date.tcl:25
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Invalid date from Git: %s"
-msgstr "Revisione non valida: %s"
+msgstr "Git ha restituito una data non valida: %s"
 
 #: lib/diff.tcl:42
 #, tcl-format
@@ -1390,14 +1402,14 @@ msgstr ""
 "potrebbero avere lo stesso stato."
 
 #: lib/diff.tcl:81
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Loading diff of %s..."
-msgstr "Caricamento %s..."
+msgstr "Caricamento delle differenze di %s..."
 
 #: lib/diff.tcl:114 lib/diff.tcl:184
 #, tcl-format
 msgid "Unable to display %s"
-msgstr ""
+msgstr "Impossibile visualizzare %s"
 
 #: lib/diff.tcl:115
 msgid "Error loading file:"
@@ -1405,11 +1417,11 @@ msgstr "Errore nel caricamento del file:"
 
 #: lib/diff.tcl:122
 msgid "Git Repository (subproject)"
-msgstr ""
+msgstr "Archivio Git (sottoprogetto)"
 
 #: lib/diff.tcl:134
 msgid "* Binary file (not showing content)."
-msgstr ""
+msgstr "* File binario (il contenuto non sarà mostrato)."
 
 #: lib/diff.tcl:185
 msgid "Error loading diff:"
@@ -1417,11 +1429,11 @@ msgstr "Errore nel caricamento delle differenze:"
 
 #: lib/diff.tcl:302
 msgid "Failed to unstage selected hunk."
-msgstr "La sezione scelta è ancora pronta per il commit."
+msgstr "La sezione scelta è ancora pronta per una nuova revisione."
 
 #: lib/diff.tcl:309
 msgid "Failed to stage selected hunk."
-msgstr "La sezione scelta non è ancora pronta per il commit."
+msgstr "Impossibile preparare la sezione scelta per una nuova revisione."
 
 #: lib/error.tcl:12 lib/error.tcl:102
 msgid "error"
@@ -1429,21 +1441,21 @@ msgstr "errore"
 
 #: lib/error.tcl:28
 msgid "warning"
-msgstr "avviso"
+msgstr "attenzione"
 
 #: lib/error.tcl:81
 msgid "You must correct the above errors before committing."
-msgstr "Bisogna correggere gli errori suddetti prima di effettuare un commit."
+msgstr "Bisogna correggere gli errori suddetti prima di creare una nuova revisione."
 
 #: lib/index.tcl:241
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "Non pronto per il commit"
+msgstr "%s non farà parte della prossima revisione"
 
 #: lib/index.tcl:285
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Adding %s"
-msgstr "Lettura di %s..."
+msgstr "Aggiunta di %s in corso"
 
 #: lib/index.tcl:340
 #, tcl-format
@@ -1458,7 +1470,8 @@ msgstr "Annullare le modifiche in questi %i file?"
 #: lib/index.tcl:348
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
-"Tutte le modifiche non preparate per il commit saranno perse per sempre."
+"Tutte le modifiche non preparate per una nuova revisione saranno perse per "
+"sempre."
 
 #: lib/index.tcl:351
 msgid "Do Nothing"
@@ -1472,8 +1485,8 @@ msgid ""
 msgstr ""
 "Non posso effettuare fusioni durante una correzione.\n"
 "\n"
-"Bisogna finire di correggere questo commit prima di iniziare una qualunque "
-"fusione.\n"
+"Bisogna finire di correggere questa revisione prima di iniziare una "
+"qualunque fusione.\n"
 
 #: lib/merge.tcl:27
 msgid ""
@@ -1484,9 +1497,9 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"L'ultimo stato analizzato non corrisponde allo stato del repository.\n"
+"L'ultimo stato analizzato non corrisponde allo stato dell'archivio.\n"
 "\n"
-"Un altro programma Git ha modificato questo repository dall'ultima analisi."
+"Un altro programma Git ha modificato questo archivio dall'ultima analisi."
 "Bisogna effettuare una nuova analisi prima di poter effettuare una fusione.\n"
 "\n"
 "La nuova analisi comincerà ora.\n"
@@ -1505,8 +1518,8 @@ msgstr ""
 "\n"
 "Il file %s ha dei conflitti.\n"
 "\n"
-"Bisogna risolvere i conflitti, preparare il file per il commit ed infine "
-"effettuare un commit per completare la fusione corrente. Solo a questo punto "
+"Bisogna risolvere i conflitti, preparare il file per una nuova revisione ed "
+"infine crearla per completare la fusione corrente. Solo a questo punto "
 "potrai iniziare un'altra fusione.\n"
 
 #: lib/merge.tcl:54
@@ -1523,9 +1536,9 @@ msgstr ""
 "\n"
 "Il file %s è stato modificato.\n"
 "\n"
-"Bisogna completare il commit corrente prima di iniziare una fusione. In "
-"questo modo sarà più facile interrompere una fusione non riuscita, nel caso "
-"ce ne fosse bisogno.\n"
+"Bisogna completare la creazione della revisione corrente prima di iniziare una fusione. "
+"In questo modo sarà più facile interrompere una fusione non riuscita, nel "
+"caso ce ne fosse bisogno.\n"
 
 #: lib/merge.tcl:106
 #, tcl-format
@@ -1562,7 +1575,7 @@ msgid ""
 msgstr ""
 "Interruzione impossibile durante una correzione.\n"
 "\n"
-"Bisogna finire di correggere questo commit.\n"
+"Bisogna finire di correggere questa revisione.\n"
 
 #: lib/merge.tcl:222
 msgid ""
@@ -1575,7 +1588,7 @@ msgstr ""
 "Interrompere fusione?\n"
 "\n"
 "L'interruzione della fusione corrente causerà la perdita di *TUTTE* le "
-"modifiche non ancora presenti nei commit.\n"
+"modifiche non ancora presenti nell'archivio.\n"
 "\n"
 "Continuare con l'interruzione della fusione corrente?"
 
@@ -1587,10 +1600,10 @@ msgid ""
 "\n"
 "Continue with resetting the current changes?"
 msgstr ""
-"Annullare le modifiche?\n"
+"Ripristinare la revisione corrente e annullare le modifiche?\n"
 "\n"
 "L'annullamento delle modifiche causerà la perdita di *TUTTE* le modifiche "
-"non ancora presenti nei commit.\n"
+"non ancora presenti nell'archivio.\n"
 "\n"
 "Continuare con l'annullamento delle modifiche correnti?"
 
@@ -1617,11 +1630,11 @@ msgstr "Salva"
 #: lib/option.tcl:96
 #, tcl-format
 msgid "%s Repository"
-msgstr "%s archivio"
+msgstr "Archivio di %s"
 
 #: lib/option.tcl:97
 msgid "Global (All Repositories)"
-msgstr "Globale (Tutti i repository)"
+msgstr "Tutti gli archivi"
 
 #: lib/option.tcl:103
 msgid "User Name"
@@ -1633,11 +1646,11 @@ msgstr "Indirizzo Email"
 
 #: lib/option.tcl:106
 msgid "Summarize Merge Commits"
-msgstr "Riepilogo nei commit di fusione"
+msgstr "Riepilogo nelle revisioni di fusione"
 
 #: lib/option.tcl:107
 msgid "Merge Verbosity"
-msgstr "Verbosità della fusione"
+msgstr "Prolissità della fusione"
 
 #: lib/option.tcl:108
 msgid "Show Diffstat After Merge"
@@ -1649,11 +1662,12 @@ msgstr "Fidati delle date di modifica dei file"
 
 #: lib/option.tcl:111
 msgid "Prune Tracking Branches During Fetch"
-msgstr "Effettua potatura dei rami in 'tracking' durante il recupero"
+msgstr ""
+"Effettua potatura dei duplicati locali di rami remoti durante il recupero"
 
 #: lib/option.tcl:112
 msgid "Match Tracking Branches"
-msgstr "Appaia rami in 'tracking'"
+msgstr "Appaia duplicati locali di rami remoti"
 
 #: lib/option.tcl:113
 msgid "Number of Diff Context Lines"
@@ -1664,41 +1678,37 @@ msgid "New Branch Name Template"
 msgstr "Modello per il nome di un nuovo ramo"
 
 #: lib/option.tcl:176
-#, fuzzy
 msgid "Change Font"
-msgstr "Caratteri principali"
+msgstr "Cambia caratteri"
 
 #: lib/option.tcl:180
 #, tcl-format
 msgid "Choose %s"
-msgstr ""
+msgstr "Scegli %s"
 
 #: lib/option.tcl:186
 msgid "pt."
-msgstr ""
+msgstr "pt."
 
 #: lib/option.tcl:200
 msgid "Preferences"
-msgstr ""
+msgstr "Preferenze"
 
 #: lib/option.tcl:235
 msgid "Failed to completely save options:"
-msgstr "Fallimento nel salvataggio completo delle opzioni:"
+msgstr "Impossibile salvare completamente le opzioni:"
 
 #: lib/remote.tcl:165
-#, fuzzy
 msgid "Prune from"
-msgstr "Effettua potatura da %s..."
+msgstr "Effettua potatura da"
 
 #: lib/remote.tcl:170
-#, fuzzy
 msgid "Fetch from"
-msgstr "Preleva da %s..."
+msgstr "Recupera da"
 
 #: lib/remote.tcl:213
-#, fuzzy
 msgid "Push to"
-msgstr "Propaga (Push)"
+msgstr "Propaga verso"
 
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Remote Branch"
@@ -1714,7 +1724,7 @@ msgstr "Remoto:"
 
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
 msgid "Arbitrary URL:"
-msgstr "URL arbitrario:"
+msgstr "URL specifico:"
 
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
@@ -1730,19 +1740,22 @@ msgstr "Fuso in:"
 
 #: lib/remote_branch_delete.tcl:119
 msgid "Always (Do not perform merge checks)"
-msgstr "Sempre (Non effettuare controlli durante la fusione)"
+msgstr "Sempre (non verificare le fusioni)"
 
 #: lib/remote_branch_delete.tcl:152
 msgid "A branch is required for 'Merged Into'."
 msgstr "Si richiede un ramo per 'Fuso in'."
 
 #: lib/remote_branch_delete.tcl:184
-#, fuzzy, tcl-format
+#, tcl-format
 msgid ""
 "The following branches are not completely merged into %s:\n"
 "\n"
 " - %s"
-msgstr "I rami seguenti non sono stati fusi completamente in %s:"
+msgstr ""
+"I rami seguenti non sono stati fusi completamente in %s:\n"
+"\n"
+" - %s"
 
 #: lib/remote_branch_delete.tcl:189
 #, tcl-format
@@ -1750,8 +1763,8 @@ msgid ""
 "One or more of the merge tests failed because you have not fetched the "
 "necessary commits.  Try fetching from %s first."
 msgstr ""
-"Una o più verifiche di fusione sono fallite perché mancano i commit "
-"necessari. Prova prima a prelevarli da %s."
+"Una o più verifiche di fusione sono fallite perché mancano le revisioni "
+"necessarie. Prova prima a recuperarle da %s."
 
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
@@ -1763,7 +1776,7 @@ msgid ""
 "\n"
 "Delete the selected branches?"
 msgstr ""
-"Prelevare rami cancellati è difficile.\n"
+"Ricomporre rami cancellati è difficile.\n"
 "\n"
 "Cancellare i rami selezionati?"
 
@@ -1795,9 +1808,9 @@ msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%s ... %*i di %*i %s (%3i%%)"
 
 #: lib/transport.tcl:6
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "fetch %s"
-msgstr "Preleva (Fetch)"
+msgstr "recupera da %s"
 
 #: lib/transport.tcl:7
 #, tcl-format
@@ -1807,17 +1820,17 @@ msgstr "Recupero nuove modifiche da %s"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
-msgstr ""
+msgstr "potatura remota di %s"
 
 #: lib/transport.tcl:19
 #, tcl-format
 msgid "Pruning tracking branches deleted from %s"
-msgstr "Effettua potatura dei rami in 'tracking' cancellati da %s"
+msgstr "Effettua potatura dei duplicati locali di rami remoti cancellati da %s"
 
 #: lib/transport.tcl:25 lib/transport.tcl:71
 #, tcl-format
 msgid "push %s"
-msgstr ""
+msgstr "propaga verso %s"
 
 #: lib/transport.tcl:26
 #, tcl-format
@@ -1847,7 +1860,7 @@ msgstr "Opzioni di trasferimento"
 
 #: lib/transport.tcl:160
 msgid "Force overwrite existing branch (may discard changes)"
-msgstr ""
+msgstr "Sovrascrivi ramo esistente (alcune modifiche potrebbero essere perse)"
 
 #: lib/transport.tcl:164
 msgid "Use thin pack (for slow network connections)"
@@ -1857,11 +1870,3 @@ msgstr "Utilizza 'thin pack' (per connessioni lente)"
 msgid "Include tags"
 msgstr "Includi etichette"
 
-#~ msgid "Cannot find the git directory:"
-#~ msgstr "Non posso trovare la directory di git:"
-
-#~ msgid "Unstaged Changes (Will Not Be Committed)"
-#~ msgstr "Modifiche non preparate (non ne verrà effettuato il commit)"
-
-#~ msgid "Push to %s..."
-#~ msgstr "Propaga verso %s..."
-- 
1.5.3.4


--Boundary-00=_POTDHWy+rvHqC80--
