From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] git-gui: french translation update
Date: Sun, 23 Nov 2008 20:52:20 +0100
Message-ID: <20081123205220.8469422f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 20:52:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4L0H-0006MD-Tr
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 20:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbYKWTun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Nov 2008 14:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbYKWTun
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 14:50:43 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:44420 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbYKWTuj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Nov 2008 14:50:39 -0500
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 3AEF6B01A8;
	Sun, 23 Nov 2008 20:50:34 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp7-g19.free.fr (Postfix) with SMTP id B489BB0186;
	Sun, 23 Nov 2008 20:50:32 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101574>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-gui/po/fr.po | 1124 +++++++++++++++++++++++++++++++++++++++-------=
-------
 1 files changed, 827 insertions(+), 297 deletions(-)

	As usual, I hope there will be no encoding problems.

diff --git a/git-gui/po/fr.po b/git-gui/po/fr.po
index 26b866f..45773ab 100644
--- a/git-gui/po/fr.po
+++ b/git-gui/po/fr.po
@@ -1,4 +1,4 @@
-# translation of fr.po to Fran=C3=A7ais
+# translation of fr.po to French
 # Translation of git-gui to French.
 # Copyright (C) 2008 Shawn Pearce, et al.
 # This file is distributed under the same license as the git package.
@@ -9,43 +9,43 @@ msgid ""
 msgstr ""
 "Project-Id-Version: fr\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-08-02 14:45-0700\n"
-"PO-Revision-Date: 2008-08-11 17:12-0400\n"
-"Last-Translator: Alexandre Bourget <alexandre.bourget@savoirfairelinu=
x.com>\n"
-"Language-Team: Fran=C3=A7ais <fr@li.org>\n"
+"POT-Creation-Date: 2008-11-16 13:56-0800\n"
+"PO-Revision-Date: 2008-11-20 10:20+0100\n"
+"Last-Translator: Christian Couder <chriscool@tuxfamily.org>\n"
+"Language-Team: French\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 "X-Generator: KBabel 1.11.4\n"
 "Plural-Forms:  nplurals=3D2; plural=3D(n > 1);\n"
=20
-#: git-gui.sh:41 git-gui.sh:688 git-gui.sh:702 git-gui.sh:715 git-gui.=
sh:798
-#: git-gui.sh:817
+#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.=
sh:847
+#: git-gui.sh:866
 msgid "git-gui: fatal error"
 msgstr "git-gui: erreur fatale"
=20
-#: git-gui.sh:644
+#: git-gui.sh:689
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Police invalide sp=C3=A9cifi=C3=A9e dans %s :"
=20
-#: git-gui.sh:674
+#: git-gui.sh:723
 msgid "Main Font"
 msgstr "Police principale"
=20
-#: git-gui.sh:675
+#: git-gui.sh:724
 msgid "Diff/Console Font"
 msgstr "Police diff/console"
=20
-#: git-gui.sh:689
+#: git-gui.sh:738
 msgid "Cannot find git in PATH."
 msgstr "Impossible de trouver git dans PATH."
=20
-#: git-gui.sh:716
+#: git-gui.sh:765
 msgid "Cannot parse Git version string:"
 msgstr "Impossible de parser la version de Git :"
=20
-#: git-gui.sh:734
+#: git-gui.sh:783
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -64,381 +64,446 @@ msgstr ""
 "\n"
 "Peut'on consid=C3=A9rer que '%s' est en version 1.5.0 ?\n"
=20
-#: git-gui.sh:972
+#: git-gui.sh:1062
 msgid "Git directory not found:"
 msgstr "Impossible de trouver le r=C3=A9pertoire git :"
=20
-#: git-gui.sh:979
+#: git-gui.sh:1069
 msgid "Cannot move to top of working directory:"
 msgstr "Impossible d'aller =C3=A0 la racine du r=C3=A9pertoire de trav=
ail :"
=20
-#: git-gui.sh:986
+#: git-gui.sh:1076
 msgid "Cannot use funny .git directory:"
 msgstr "Impossible d'utiliser le r=C3=A9pertoire .git:"
=20
-#: git-gui.sh:991
+#: git-gui.sh:1081
 msgid "No working directory"
 msgstr "Aucun r=C3=A9pertoire de travail"
=20
-#: git-gui.sh:1138 lib/checkout_op.tcl:305
+#: git-gui.sh:1247 lib/checkout_op.tcl:305
 msgid "Refreshing file status..."
 msgstr "Rafraichissement du status des fichiers..."
=20
-#: git-gui.sh:1194
+#: git-gui.sh:1303
 msgid "Scanning for modified files ..."
 msgstr "Recherche de fichiers modifi=C3=A9s..."
=20
-#: git-gui.sh:1369 lib/browser.tcl:246
+#: git-gui.sh:1367
+msgid "Calling prepare-commit-msg hook..."
+msgstr "Lancement de l'action de pr=C3=A9paration du message de commit=
=2E.."
+
+#: git-gui.sh:1384
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr "Commit refus=C3=A9 par l'action de pr=C3=A9paration du message=
 de commit."
+
+#: git-gui.sh:1542 lib/browser.tcl:246
 msgid "Ready."
 msgstr "Pr=C3=AAt."
=20
-#: git-gui.sh:1635
+#: git-gui.sh:1819
 msgid "Unmodified"
 msgstr "Non modifi=C3=A9"
=20
-#: git-gui.sh:1637
+#: git-gui.sh:1821
 msgid "Modified, not staged"
 msgstr "Modifi=C3=A9, pas index=C3=A9"
=20
-#: git-gui.sh:1638 git-gui.sh:1643
+#: git-gui.sh:1822 git-gui.sh:1830
 msgid "Staged for commit"
 msgstr "Index=C3=A9"
=20
-#: git-gui.sh:1639 git-gui.sh:1644
+#: git-gui.sh:1823 git-gui.sh:1831
 msgid "Portions staged for commit"
 msgstr "Portions index=C3=A9es"
=20
-#: git-gui.sh:1640 git-gui.sh:1645
+#: git-gui.sh:1824 git-gui.sh:1832
 msgid "Staged for commit, missing"
 msgstr "Index=C3=A9s, manquant"
=20
-#: git-gui.sh:1642
+#: git-gui.sh:1826
+msgid "File type changed, not staged"
+msgstr "Le type de fichier a chang=C3=A9, non index=C3=A9"
+
+#: git-gui.sh:1827
+msgid "File type changed, staged"
+msgstr "Le type de fichier a chang=C3=A9, index=C3=A9"
+
+#: git-gui.sh:1829
 msgid "Untracked, not staged"
 msgstr "Non versionn=C3=A9, non index=C3=A9"
=20
-#: git-gui.sh:1647
+#: git-gui.sh:1834
 msgid "Missing"
 msgstr "Manquant"
=20
-#: git-gui.sh:1648
+#: git-gui.sh:1835
 msgid "Staged for removal"
 msgstr "Index=C3=A9 pour suppression"
=20
-#: git-gui.sh:1649
+#: git-gui.sh:1836
 msgid "Staged for removal, still present"
 msgstr "Index=C3=A9 pour suppression, toujours pr=C3=A9sent"
=20
-#: git-gui.sh:1651 git-gui.sh:1652 git-gui.sh:1653 git-gui.sh:1654
+#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
+#: git-gui.sh:1842 git-gui.sh:1843
 msgid "Requires merge resolution"
 msgstr "N=C3=A9cessite la r=C3=A9solution d'une fusion"
=20
-#: git-gui.sh:1689
+#: git-gui.sh:1878
 msgid "Starting gitk... please wait..."
 msgstr "Lancement de gitk... un instant..."
=20
-#: git-gui.sh:1698
+#: git-gui.sh:1887
 msgid "Couldn't find gitk in PATH"
 msgstr "Impossible de trouver gitk dans PATH."
=20
-#: git-gui.sh:1948 lib/choose_repository.tcl:36
+#: git-gui.sh:2280 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "D=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:1949
+#: git-gui.sh:2281
 msgid "Edit"
 msgstr "Edition"
=20
-#: git-gui.sh:1951 lib/choose_rev.tcl:561
+#: git-gui.sh:2283 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "Branche"
=20
-#: git-gui.sh:1954 lib/choose_rev.tcl:548
+#: git-gui.sh:2286 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "Commit"
=20
-#: git-gui.sh:1957 lib/merge.tcl:120 lib/merge.tcl:149 lib/merge.tcl:1=
67
+#: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "Fusionner"
=20
-#: git-gui.sh:1958 lib/choose_rev.tcl:557
+#: git-gui.sh:2290 lib/choose_rev.tcl:557
 msgid "Remote"
 msgstr "D=C3=A9p=C3=B4t distant"
=20
-#: git-gui.sh:1967
+#: git-gui.sh:2293
+msgid "Tools"
+msgstr "Outils"
+
+#: git-gui.sh:2302
+msgid "Explore Working Copy"
+msgstr "Explorer la copie de travail"
+
+#: git-gui.sh:2307
 msgid "Browse Current Branch's Files"
 msgstr "Naviguer dans la branche courante"
=20
-#: git-gui.sh:1971
+#: git-gui.sh:2311
 msgid "Browse Branch Files..."
 msgstr "Naviguer dans la branche..."
=20
-#: git-gui.sh:1976
+#: git-gui.sh:2316
 msgid "Visualize Current Branch's History"
 msgstr "Visualiser historique branche courante"
=20
-#: git-gui.sh:1980
+#: git-gui.sh:2320
 msgid "Visualize All Branch History"
 msgstr "Voir l'historique de toutes les branches"
=20
-#: git-gui.sh:1987
+#: git-gui.sh:2327
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Naviguer l'arborescence de %s"
=20
-#: git-gui.sh:1989
+#: git-gui.sh:2329
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Voir l'historique de la branche: %s"
=20
-#: git-gui.sh:1994 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Statistiques du d=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:1997 lib/database.tcl:34
+#: git-gui.sh:2337 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "Comprimer le d=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:2000
+#: git-gui.sh:2340
 msgid "Verify Database"
 msgstr "V=C3=A9rifier le d=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:2007 git-gui.sh:2011 git-gui.sh:2015 lib/shortcut.tcl:7
+#: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "Cr=C3=A9er ic=C3=B4ne sur bureau"
=20
-#: git-gui.sh:2023 lib/choose_repository.tcl:177 lib/choose_repository=
=2Etcl:185
+#: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
 msgid "Quit"
 msgstr "Quitter"
=20
-#: git-gui.sh:2031
+#: git-gui.sh:2371
 msgid "Undo"
 msgstr "D=C3=A9faire"
=20
-#: git-gui.sh:2034
+#: git-gui.sh:2374
 msgid "Redo"
 msgstr "Refaire"
=20
-#: git-gui.sh:2038 git-gui.sh:2545
+#: git-gui.sh:2378 git-gui.sh:2923
 msgid "Cut"
 msgstr "Couper"
=20
-#: git-gui.sh:2041 git-gui.sh:2548 git-gui.sh:2622 git-gui.sh:2715
+#: git-gui.sh:2381 git-gui.sh:2926 git-gui.sh:3000 git-gui.sh:3082
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Copier"
=20
-#: git-gui.sh:2044 git-gui.sh:2551
+#: git-gui.sh:2384 git-gui.sh:2929
 msgid "Paste"
 msgstr "Coller"
=20
-#: git-gui.sh:2047 git-gui.sh:2554 lib/branch_delete.tcl:26
+#: git-gui.sh:2387 git-gui.sh:2932 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "Supprimer"
=20
-#: git-gui.sh:2051 git-gui.sh:2558 git-gui.sh:2719 lib/console.tcl:71
+#: git-gui.sh:2391 git-gui.sh:2936 git-gui.sh:3086 lib/console.tcl:71
 msgid "Select All"
 msgstr "Tout s=C3=A9lectionner"
=20
-#: git-gui.sh:2060
+#: git-gui.sh:2400
 msgid "Create..."
 msgstr "Cr=C3=A9er..."
=20
-#: git-gui.sh:2066
+#: git-gui.sh:2406
 msgid "Checkout..."
 msgstr "Charger (checkout)..."
=20
-#: git-gui.sh:2072
+#: git-gui.sh:2412
 msgid "Rename..."
 msgstr "Renommer..."
=20
-#: git-gui.sh:2077 git-gui.sh:2187
+#: git-gui.sh:2417
 msgid "Delete..."
 msgstr "Supprimer..."
=20
-#: git-gui.sh:2082
+#: git-gui.sh:2422
 msgid "Reset..."
 msgstr "R=C3=A9initialiser..."
=20
-#: git-gui.sh:2094 git-gui.sh:2491
+#: git-gui.sh:2432
+msgid "Done"
+msgstr "Effectu=C3=A9"
+
+#: git-gui.sh:2434
+msgid "Commit@@verb"
+msgstr "Commiter@@verb"
+
+#: git-gui.sh:2443 git-gui.sh:2864
 msgid "New Commit"
 msgstr "Nouveau commit"
=20
-#: git-gui.sh:2102 git-gui.sh:2498
+#: git-gui.sh:2451 git-gui.sh:2871
 msgid "Amend Last Commit"
 msgstr "Corriger dernier commit"
=20
-#: git-gui.sh:2111 git-gui.sh:2458 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2461 git-gui.sh:2825 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "Recharger modifs."
=20
-#: git-gui.sh:2117
+#: git-gui.sh:2467
 msgid "Stage To Commit"
 msgstr "Indexer"
=20
-#: git-gui.sh:2123
+#: git-gui.sh:2473
 msgid "Stage Changed Files To Commit"
 msgstr "Indexer toutes modifications"
=20
-#: git-gui.sh:2129
+#: git-gui.sh:2479
 msgid "Unstage From Commit"
 msgstr "D=C3=A9sindexer"
=20
-#: git-gui.sh:2134 lib/index.tcl:395
+#: git-gui.sh:2484 lib/index.tcl:410
 msgid "Revert Changes"
 msgstr "Annuler les modifications (revert)"
=20
-#: git-gui.sh:2141 git-gui.sh:2702
+#: git-gui.sh:2491 git-gui.sh:3069
 msgid "Show Less Context"
 msgstr "Montrer moins de contexte"
=20
-#: git-gui.sh:2145 git-gui.sh:2706
+#: git-gui.sh:2495 git-gui.sh:3073
 msgid "Show More Context"
 msgstr "Montrer plus de contexte"
=20
-#: git-gui.sh:2151 git-gui.sh:2470 git-gui.sh:2569
+#: git-gui.sh:2502 git-gui.sh:2838 git-gui.sh:2947
 msgid "Sign Off"
 msgstr "Signer"
=20
-#: git-gui.sh:2155 git-gui.sh:2474
-msgid "Commit@@verb"
-msgstr "Commiter"
-
-#: git-gui.sh:2166
+#: git-gui.sh:2518
 msgid "Local Merge..."
 msgstr "Fusion locale..."
=20
-#: git-gui.sh:2171
+#: git-gui.sh:2523
 msgid "Abort Merge..."
 msgstr "Abandonner fusion..."
=20
-#: git-gui.sh:2183
+#: git-gui.sh:2535 git-gui.sh:2575
+msgid "Add..."
+msgstr "Ajouter..."
+
+#: git-gui.sh:2539
 msgid "Push..."
 msgstr "Pousser..."
=20
-#: git-gui.sh:2197 git-gui.sh:2219 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
+#: git-gui.sh:2543
+msgid "Delete Branch..."
+msgstr "Supprimer branche..."
+
+#: git-gui.sh:2553 git-gui.sh:2589 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
 #, tcl-format
 msgid "About %s"
 msgstr "=C3=80 propos de %s"
=20
-#: git-gui.sh:2201
+#: git-gui.sh:2557
 msgid "Preferences..."
 msgstr "Pr=C3=A9f=C3=A9rences..."
=20
-#: git-gui.sh:2209 git-gui.sh:2740
+#: git-gui.sh:2565 git-gui.sh:3115
 msgid "Options..."
 msgstr "Options..."
=20
-#: git-gui.sh:2215 lib/choose_repository.tcl:47
+#: git-gui.sh:2576
+msgid "Remove..."
+msgstr "Supprimer..."
+
+#: git-gui.sh:2585 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "Aide"
=20
-#: git-gui.sh:2256
+#: git-gui.sh:2611
 msgid "Online Documentation"
 msgstr "Documentation en ligne"
=20
-#: git-gui.sh:2340
+#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+msgid "Show SSH Key"
+msgstr "Montrer cl=C3=A9 SSH"
+
+#: git-gui.sh:2707
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "erreur fatale : pas d'infos sur le chemin %s : Fichier ou r=C3=A9pert=
oire "
 "inexistant"
=20
-#: git-gui.sh:2373
+#: git-gui.sh:2740
 msgid "Current Branch:"
 msgstr "Branche courante :"
=20
-#: git-gui.sh:2394
+#: git-gui.sh:2761
 msgid "Staged Changes (Will Commit)"
 msgstr "Modifs. index=C3=A9es (pour commit)"
=20
-#: git-gui.sh:2414
+#: git-gui.sh:2781
 msgid "Unstaged Changes"
 msgstr "Modifs. non index=C3=A9es"
=20
-#: git-gui.sh:2464
+#: git-gui.sh:2831
 msgid "Stage Changed"
 msgstr "Indexer modifs."
=20
-#: git-gui.sh:2480 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2850 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "Pousser"
=20
-#: git-gui.sh:2510
+#: git-gui.sh:2885
 msgid "Initial Commit Message:"
 msgstr "Message de commit initial :"
=20
-#: git-gui.sh:2511
+#: git-gui.sh:2886
 msgid "Amended Commit Message:"
 msgstr "Message de commit corrig=C3=A9 :"
=20
-#: git-gui.sh:2512
+#: git-gui.sh:2887
 msgid "Amended Initial Commit Message:"
 msgstr "Message de commit initial corrig=C3=A9 :"
=20
-#: git-gui.sh:2513
+#: git-gui.sh:2888
 msgid "Amended Merge Commit Message:"
 msgstr "Message de commit de fusion corrig=C3=A9 :"
=20
-#: git-gui.sh:2514
+#: git-gui.sh:2889
 msgid "Merge Commit Message:"
 msgstr "Message de commit de fusion :"
=20
-#: git-gui.sh:2515
+#: git-gui.sh:2890
 msgid "Commit Message:"
 msgstr "Message de commit :"
=20
-#: git-gui.sh:2561 git-gui.sh:2723 lib/console.tcl:73
+#: git-gui.sh:2939 git-gui.sh:3090 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Copier tout"
=20
-#: git-gui.sh:2585 lib/blame.tcl:100
+#: git-gui.sh:2963 lib/blame.tcl:104
 msgid "File:"
 msgstr "Fichier :"
=20
-#: git-gui.sh:2691
-msgid "Apply/Reverse Hunk"
-msgstr "Appliquer/Inverser section"
-
-#: git-gui.sh:2696
-msgid "Apply/Reverse Line"
-msgstr "Appliquer/Inverser la ligne"
-
-#: git-gui.sh:2711
+#: git-gui.sh:3078
 msgid "Refresh"
 msgstr "Rafraichir"
=20
-#: git-gui.sh:2732
+#: git-gui.sh:3099
 msgid "Decrease Font Size"
 msgstr "Diminuer la police"
=20
-#: git-gui.sh:2736
+#: git-gui.sh:3103
 msgid "Increase Font Size"
 msgstr "Agrandir la police"
=20
-#: git-gui.sh:2747
+#: git-gui.sh:3111 lib/blame.tcl:281
+msgid "Encoding"
+msgstr "Encodage"
+
+#: git-gui.sh:3122
+msgid "Apply/Reverse Hunk"
+msgstr "Appliquer/Inverser section"
+
+#: git-gui.sh:3127
+msgid "Apply/Reverse Line"
+msgstr "Appliquer/Inverser la ligne"
+
+#: git-gui.sh:3137
+msgid "Run Merge Tool"
+msgstr "Lancer outil de merge"
+
+#: git-gui.sh:3142
+msgid "Use Remote Version"
+msgstr "Utiliser la version distante"
+
+#: git-gui.sh:3146
+msgid "Use Local Version"
+msgstr "Utiliser la version locale"
+
+#: git-gui.sh:3150
+msgid "Revert To Base"
+msgstr "Revenir =C3=A0 la version de base"
+
+#: git-gui.sh:3169
 msgid "Unstage Hunk From Commit"
 msgstr "D=C3=A9sindexer la section"
=20
-#: git-gui.sh:2748
+#: git-gui.sh:3170
 msgid "Unstage Line From Commit"
 msgstr "D=C3=A9sindexer la ligne"
=20
-#: git-gui.sh:2750
+#: git-gui.sh:3172
 msgid "Stage Hunk For Commit"
 msgstr "Indexer la section"
=20
-#: git-gui.sh:2751
+#: git-gui.sh:3173
 msgid "Stage Line For Commit"
 msgstr "Indexer la ligne"
=20
-#: git-gui.sh:2771
+#: git-gui.sh:3196
 msgid "Initializing..."
 msgstr "Initialisation..."
=20
-#: git-gui.sh:2876
+#: git-gui.sh:3301
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -455,7 +520,7 @@ msgstr ""
 "sous-processus de Git lanc=C3=A9s par %s\n"
 "\n"
=20
-#: git-gui.sh:2906
+#: git-gui.sh:3331
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -465,7 +530,7 @@ msgstr ""
 "Ceci est du =C3=A0 un probl=C3=A8me connu avec\n"
 "le binaire Tcl distribu=C3=A9 par Cygwin."
=20
-#: git-gui.sh:2911
+#: git-gui.sh:3336
 #, tcl-format
 msgid ""
 "\n"
@@ -486,80 +551,108 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr "git-gui - une interface graphique utilisateur pour Git"
=20
-#: lib/blame.tcl:70
+#: lib/blame.tcl:72
 msgid "File Viewer"
 msgstr "Visionneur de fichier"
=20
-#: lib/blame.tcl:74
+#: lib/blame.tcl:78
 msgid "Commit:"
 msgstr "Commit :"
=20
-#: lib/blame.tcl:257
+#: lib/blame.tcl:271
 msgid "Copy Commit"
 msgstr "Copier commit"
=20
-#: lib/blame.tcl:260
+#: lib/blame.tcl:275
+msgid "Find Text..."
+msgstr "Chercher texte..."
+
+#: lib/blame.tcl:284
 msgid "Do Full Copy Detection"
 msgstr "Lancer la d=C3=A9tection approfondie des copies"
=20
-#: lib/blame.tcl:388
+#: lib/blame.tcl:288
+msgid "Show History Context"
+msgstr "Montrer l'historique"
+
+#: lib/blame.tcl:291
+msgid "Blame Parent Commit"
+msgstr "Bl=C3=A2mer le commit parent"
+
+#: lib/blame.tcl:450
 #, tcl-format
 msgid "Reading %s..."
 msgstr "Lecture de %s..."
=20
-#: lib/blame.tcl:492
+#: lib/blame.tcl:557
 msgid "Loading copy/move tracking annotations..."
 msgstr "Chargement des annotations de suivi des copies/d=C3=A9placemen=
ts..."
=20
-#: lib/blame.tcl:512
+#: lib/blame.tcl:577
 msgid "lines annotated"
 msgstr "lignes annot=C3=A9es"
=20
-#: lib/blame.tcl:704
+#: lib/blame.tcl:769
 msgid "Loading original location annotations..."
 msgstr "Chargement des annotations d'emplacement original"
=20
-#: lib/blame.tcl:707
+#: lib/blame.tcl:772
 msgid "Annotation complete."
 msgstr "Annotation termin=C3=A9e."
=20
-#: lib/blame.tcl:737
+#: lib/blame.tcl:802
 msgid "Busy"
 msgstr "Occup=C3=A9"
=20
-#: lib/blame.tcl:738
+#: lib/blame.tcl:803
 msgid "Annotation process is already running."
 msgstr "Annotation en cours d'ex=C3=A9cution."
=20
-#: lib/blame.tcl:777
+#: lib/blame.tcl:842
 msgid "Running thorough copy detection..."
 msgstr "Recherche de copie approfondie en cours..."
=20
-#: lib/blame.tcl:827
+#: lib/blame.tcl:910
 msgid "Loading annotation..."
 msgstr "Chargement des annotations..."
=20
-#: lib/blame.tcl:883
+#: lib/blame.tcl:964
 msgid "Author:"
 msgstr "Auteur :"
=20
-#: lib/blame.tcl:887
+#: lib/blame.tcl:968
 msgid "Committer:"
 msgstr "Commiteur :"
=20
-#: lib/blame.tcl:892
+#: lib/blame.tcl:973
 msgid "Original File:"
 msgstr "Fichier original :"
=20
-#: lib/blame.tcl:1006
+#: lib/blame.tcl:1021
+msgid "Cannot find HEAD commit:"
+msgstr "Impossible de trouver le commit HEAD:"
+
+#: lib/blame.tcl:1076
+msgid "Cannot find parent commit:"
+msgstr "Impossible de trouver le commit parent:"
+
+#: lib/blame.tcl:1091
+msgid "Unable to display parent"
+msgstr "Impossible d'afficher le parent"
+
+#: lib/blame.tcl:1092 lib/diff.tcl:297
+msgid "Error loading diff:"
+msgstr "Erreur lors du chargement des diff=C3=A9rences :"
+
+#: lib/blame.tcl:1232
 msgid "Originally By:"
 msgstr "A l'origine par :"
=20
-#: lib/blame.tcl:1012
+#: lib/blame.tcl:1238
 msgid "In File:"
 msgstr "Dans le fichier :"
=20
-#: lib/blame.tcl:1017
+#: lib/blame.tcl:1243
 msgid "Copied Or Moved Here By:"
 msgstr "Copi=C3=A9 ou d=C3=A9plac=C3=A9 ici par :"
=20
@@ -573,16 +666,18 @@ msgstr "Charger (checkout)"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
-#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:171
-#: lib/option.tcl:103 lib/remote_branch_delete.tcl:42 lib/transport.tc=
l:97
+#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
+#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
+#: lib/transport.tcl:97
 msgid "Cancel"
 msgstr "Annuler"
=20
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:32=
8
 msgid "Revision"
 msgstr "R=C3=A9vision"
=20
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
244
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
280
 msgid "Options"
 msgstr "Options"
=20
@@ -602,7 +697,7 @@ msgstr "Cr=C3=A9er branche"
 msgid "Create New Branch"
 msgstr "Cr=C3=A9er nouvelle branche"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:371
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
 msgid "Create"
 msgstr "Cr=C3=A9er"
=20
@@ -610,7 +705,7 @@ msgstr "Cr=C3=A9er"
 msgid "Branch Name"
 msgstr "Nom de branche"
=20
-#: lib/branch_create.tcl:43
+#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
 msgid "Name:"
 msgstr "Nom :"
=20
@@ -755,9 +850,9 @@ msgstr "[Jusqu'au parent]"
 msgid "Browse Branch Files"
 msgstr "Naviguer dans les fichiers de le branche"
=20
-#: lib/browser.tcl:278 lib/choose_repository.tcl:387
-#: lib/choose_repository.tcl:472 lib/choose_repository.tcl:482
-#: lib/choose_repository.tcl:985
+#: lib/browser.tcl:278 lib/choose_repository.tcl:394
+#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
+#: lib/choose_repository.tcl:995
 msgid "Browse"
 msgstr "Naviguer"
=20
@@ -772,6 +867,7 @@ msgid "fatal: Cannot resolve %s"
 msgstr "erreur fatale : Impossible de r=C3=A9soudre %s"
=20
 #: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
+#: lib/sshkey.tcl:53
 msgid "Close"
 msgstr "Fermer"
=20
@@ -884,7 +980,7 @@ msgstr "R=C3=A9cup=C3=A9rer les commits perdus ne s=
era peut =C3=AAtre pas facile."
 msgid "Reset '%s'?"
 msgstr "R=C3=A9initialiser '%s' ?"
=20
-#: lib/checkout_op.tcl:532 lib/merge.tcl:163
+#: lib/checkout_op.tcl:532 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
 msgstr "Visualiser"
=20
@@ -934,225 +1030,229 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git Gui"
=20
-#: lib/choose_repository.tcl:81 lib/choose_repository.tcl:376
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:382
 msgid "Create New Repository"
 msgstr "Cr=C3=A9er nouveau d=C3=A9p=C3=B4t"
=20
-#: lib/choose_repository.tcl:87
+#: lib/choose_repository.tcl:93
 msgid "New..."
 msgstr "Nouveau..."
=20
-#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:458
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
 msgid "Clone Existing Repository"
 msgstr "Cloner d=C3=A9p=C3=B4t existant"
=20
-#: lib/choose_repository.tcl:100
+#: lib/choose_repository.tcl:106
 msgid "Clone..."
 msgstr "Cloner..."
=20
-#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:974
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
 msgid "Open Existing Repository"
 msgstr "Ouvrir d=C3=A9p=C3=B4t existant"
=20
-#: lib/choose_repository.tcl:113
+#: lib/choose_repository.tcl:119
 msgid "Open..."
 msgstr "Ouvrir..."
=20
-#: lib/choose_repository.tcl:126
+#: lib/choose_repository.tcl:132
 msgid "Recent Repositories"
 msgstr "D=C3=A9p=C3=B4t r=C3=A9cemment utilis=C3=A9s"
=20
-#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:138
 msgid "Open Recent Repository:"
 msgstr "Ouvrir d=C3=A9p=C3=B4t r=C3=A9cent :"
=20
-#: lib/choose_repository.tcl:296 lib/choose_repository.tcl:303
-#: lib/choose_repository.tcl:310
+#: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:316
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "La cr=C3=A9ation du d=C3=A9p=C3=B4t %s a =C3=A9chou=C3=A9e :"
=20
-#: lib/choose_repository.tcl:381 lib/choose_repository.tcl:476
+#: lib/choose_repository.tcl:387
 msgid "Directory:"
 msgstr "R=C3=A9pertoire :"
=20
-#: lib/choose_repository.tcl:410 lib/choose_repository.tcl:535
-#: lib/choose_repository.tcl:1007
+#: lib/choose_repository.tcl:417 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1017
 msgid "Git Repository"
 msgstr "D=C3=A9p=C3=B4t Git"
=20
-#: lib/choose_repository.tcl:435
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "Le r=C3=A9pertoire %s existe d=C3=A9j=C3=A0."
=20
-#: lib/choose_repository.tcl:439
+#: lib/choose_repository.tcl:446
 #, tcl-format
 msgid "File %s already exists."
 msgstr "Le fichier %s existe d=C3=A9j=C3=A0."
=20
-#: lib/choose_repository.tcl:453
+#: lib/choose_repository.tcl:460
 msgid "Clone"
 msgstr "Cloner"
=20
-#: lib/choose_repository.tcl:466
-msgid "URL:"
-msgstr "URL :"
+#: lib/choose_repository.tcl:473
+msgid "Source Location:"
+msgstr "Emplacement source:"
=20
-#: lib/choose_repository.tcl:487
+#: lib/choose_repository.tcl:484
+msgid "Target Directory:"
+msgstr "R=C3=A9pertoire cible:"
+
+#: lib/choose_repository.tcl:496
 msgid "Clone Type:"
 msgstr "Type de clonage :"
=20
-#: lib/choose_repository.tcl:493
+#: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "Standard (rapide, semi-redondant, liens durs)"
=20
-#: lib/choose_repository.tcl:499
+#: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "Copy compl=C3=A8te (plus lent, sauvegarde redondante)"
=20
-#: lib/choose_repository.tcl:505
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "Partag=C3=A9 (le plus rapide, non recommand=C3=A9, pas de sauv=
egarde)"
=20
-#: lib/choose_repository.tcl:541 lib/choose_repository.tcl:588
-#: lib/choose_repository.tcl:734 lib/choose_repository.tcl:804
-#: lib/choose_repository.tcl:1013 lib/choose_repository.tcl:1021
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
+#: lib/choose_repository.tcl:1023 lib/choose_repository.tcl:1031
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "'%s' n'est pas un d=C3=A9p=C3=B4t Git."
=20
-#: lib/choose_repository.tcl:577
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr "Standard n'est disponible que pour un d=C3=A9p=C3=B4t local."
=20
-#: lib/choose_repository.tcl:581
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr "Partag=C3=A9 n'est disponible que pour un d=C3=A9p=C3=B4t loca=
l."
=20
-#: lib/choose_repository.tcl:602
+#: lib/choose_repository.tcl:611
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "L'emplacement %s existe d=C3=A9j=C3=A0."
=20
-#: lib/choose_repository.tcl:613
+#: lib/choose_repository.tcl:622
 msgid "Failed to configure origin"
 msgstr "La configuration de l'origine a =C3=A9chou=C3=A9e."
=20
-#: lib/choose_repository.tcl:625
+#: lib/choose_repository.tcl:634
 msgid "Counting objects"
 msgstr "D=C3=A9compte des objets"
=20
-#: lib/choose_repository.tcl:626
+#: lib/choose_repository.tcl:635
 msgid "buckets"
 msgstr "paniers"
=20
-#: lib/choose_repository.tcl:650
+#: lib/choose_repository.tcl:659
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "Impossible de copier 'objects/info/alternates' : %s"
=20
-#: lib/choose_repository.tcl:686
+#: lib/choose_repository.tcl:695
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "Il n'y a rien =C3=A0 cloner depuis %s."
=20
-#: lib/choose_repository.tcl:688 lib/choose_repository.tcl:902
-#: lib/choose_repository.tcl:914
+#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:923
 msgid "The 'master' branch has not been initialized."
 msgstr "La branche 'master' n'a pas =C3=A9t=C3=A9 initialis=C3=A9e."
=20
-#: lib/choose_repository.tcl:701
+#: lib/choose_repository.tcl:710
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "Les liens durs ne sont pas support=C3=A9s. Une copie sera effe=
ctu=C3=A9e =C3=A0 la place."
=20
-#: lib/choose_repository.tcl:713
+#: lib/choose_repository.tcl:722
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "Clonage depuis %s"
=20
-#: lib/choose_repository.tcl:744
+#: lib/choose_repository.tcl:753
 msgid "Copying objects"
 msgstr "Copie des objets"
=20
-#: lib/choose_repository.tcl:745
+#: lib/choose_repository.tcl:754
 msgid "KiB"
 msgstr "KiB"
=20
-#: lib/choose_repository.tcl:769
+#: lib/choose_repository.tcl:778
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "Impossible de copier l'objet : %s"
=20
-#: lib/choose_repository.tcl:779
+#: lib/choose_repository.tcl:788
 msgid "Linking objects"
 msgstr "Liaison des objets"
=20
-#: lib/choose_repository.tcl:780
+#: lib/choose_repository.tcl:789
 msgid "objects"
 msgstr "objets"
=20
-#: lib/choose_repository.tcl:788
+#: lib/choose_repository.tcl:797
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "Impossible cr=C3=A9er un lien dur pour l'objet : %s"
=20
-#: lib/choose_repository.tcl:843
+#: lib/choose_repository.tcl:852
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr ""
 "Impossible de r=C3=A9cup=C3=A9rer les branches et objets. Voir la sor=
tie console pour "
 "plus de d=C3=A9tails."
=20
-#: lib/choose_repository.tcl:854
+#: lib/choose_repository.tcl:863
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
 "Impossible de r=C3=A9cup=C3=A9rer les marques (tags). Voir la sortie =
console pour plus "
 "de d=C3=A9tails."
=20
-#: lib/choose_repository.tcl:878
+#: lib/choose_repository.tcl:887
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "Impossible de d=C3=A9terminer HEAD. Voir la sortie console pou=
r plus de d=C3=A9tails."
=20
-#: lib/choose_repository.tcl:887
+#: lib/choose_repository.tcl:896
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "Impossible de nettoyer %s"
=20
-#: lib/choose_repository.tcl:893
+#: lib/choose_repository.tcl:902
 msgid "Clone failed."
 msgstr "Le clonage a =C3=A9chou=C3=A9."
=20
-#: lib/choose_repository.tcl:900
+#: lib/choose_repository.tcl:909
 msgid "No default branch obtained."
 msgstr "Aucune branche par d=C3=A9faut n'a =C3=A9t=C3=A9 obtenue."
=20
-#: lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:920
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "Impossible de r=C3=A9soudre %s comme commit."
=20
-#: lib/choose_repository.tcl:923
+#: lib/choose_repository.tcl:932
 msgid "Creating working directory"
 msgstr "Cr=C3=A9ation du r=C3=A9pertoire de travail"
=20
-#: lib/choose_repository.tcl:924 lib/index.tcl:65 lib/index.tcl:127
-#: lib/index.tcl:193
+#: lib/choose_repository.tcl:933 lib/index.tcl:65 lib/index.tcl:128
+#: lib/index.tcl:196
 msgid "files"
 msgstr "fichiers"
=20
-#: lib/choose_repository.tcl:953
+#: lib/choose_repository.tcl:962
 msgid "Initial file checkout failed."
 msgstr "Chargement initial du fichier =C3=A9chou=C3=A9."
=20
-#: lib/choose_repository.tcl:969
+#: lib/choose_repository.tcl:978
 msgid "Open"
 msgstr "Ouvrir"
=20
-#: lib/choose_repository.tcl:979
+#: lib/choose_repository.tcl:988
 msgid "Repository:"
 msgstr "D=C3=A9p=C3=B4t :"
=20
-#: lib/choose_repository.tcl:1027
+#: lib/choose_repository.tcl:1037
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "Impossible d'ouvrir le d=C3=A9p=C3=B4t %s :"
@@ -1254,7 +1354,7 @@ msgstr ""
 "\n"
 "Cela va =C3=AAtre fait tout de suite automatiquement.\n"
=20
-#: lib/commit.tcl:154
+#: lib/commit.tcl:156
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1267,7 +1367,7 @@ msgstr ""
 "Le fichier %s a des conflicts de fusion. Vous devez les r=C3=A9soudre=
 et pr=C3=A9-"
 "commiter le fichier avant de pouvoir commiter.\n"
=20
-#: lib/commit.tcl:162
+#: lib/commit.tcl:164
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1278,7 +1378,7 @@ msgstr ""
 "\n"
 "Le fichier %s ne peut pas =C3=AAtre commit=C3=A9 par ce programme.\n"
=20
-#: lib/commit.tcl:170
+#: lib/commit.tcl:172
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1288,7 +1388,7 @@ msgstr ""
 "\n"
 "Vous devez indexer au moins 1 fichier avant de pouvoir commiter.\n"
=20
-#: lib/commit.tcl:183
+#: lib/commit.tcl:187
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1306,45 +1406,45 @@ msgstr ""
 "- Deuxi=C3=A8me ligne : rien.\n"
 "- Lignes suivantes : D=C3=A9crire pourquoi ces modifications sont bon=
nes.\n"
=20
-#: lib/commit.tcl:207
+#: lib/commit.tcl:211
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
 msgstr "attention : Tcl ne supporte pas l'encodage '%s'."
=20
-#: lib/commit.tcl:221
+#: lib/commit.tcl:227
 msgid "Calling pre-commit hook..."
 msgstr "Lancement de l'action d'avant-commit..."
=20
-#: lib/commit.tcl:236
+#: lib/commit.tcl:242
 msgid "Commit declined by pre-commit hook."
 msgstr "Commit refus=C3=A9 par l'action d'avant-commit."
=20
-#: lib/commit.tcl:259
+#: lib/commit.tcl:265
 msgid "Calling commit-msg hook..."
 msgstr "Lancement de l'action \"message de commit\"..."
=20
-#: lib/commit.tcl:274
+#: lib/commit.tcl:280
 msgid "Commit declined by commit-msg hook."
 msgstr "Commit refus=C3=A9 par l'action \"message de commit\"."
=20
-#: lib/commit.tcl:287
+#: lib/commit.tcl:293
 msgid "Committing changes..."
 msgstr "Commit des modifications..."
=20
-#: lib/commit.tcl:303
+#: lib/commit.tcl:309
 msgid "write-tree failed:"
 msgstr "write-tree a =C3=A9chou=C3=A9 :"
=20
-#: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
+#: lib/commit.tcl:310 lib/commit.tcl:354 lib/commit.tcl:374
 msgid "Commit failed."
 msgstr "Le commit a =C3=A9chou=C3=A9."
=20
-#: lib/commit.tcl:321
+#: lib/commit.tcl:327
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "Le commit %s semble =C3=AAtre corrompu"
=20
-#: lib/commit.tcl:326
+#: lib/commit.tcl:332
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1359,19 +1459,19 @@ msgstr ""
 "\n"
 "Une resynchronisation va =C3=AAtre lanc=C3=A9e tout de suite automati=
quement.\n"
=20
-#: lib/commit.tcl:333
+#: lib/commit.tcl:339
 msgid "No changes to commit."
 msgstr "Pas de modifications =C3=A0 commiter."
=20
-#: lib/commit.tcl:347
+#: lib/commit.tcl:353
 msgid "commit-tree failed:"
 msgstr "commit-tree a =C3=A9chou=C3=A9 :"
=20
-#: lib/commit.tcl:367
+#: lib/commit.tcl:373
 msgid "update-ref failed:"
 msgstr "update-ref a =C3=A9chou=C3=A9"
=20
-#: lib/commit.tcl:454
+#: lib/commit.tcl:461
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "Commit cr=C3=A9=C3=A9 %s : %s"
@@ -1448,7 +1548,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "Date invalide de Git : %s"
=20
-#: lib/diff.tcl:44
+#: lib/diff.tcl:59
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1471,48 +1571,101 @@ msgstr ""
 "Une resynchronisation va =C3=AAtre lanc=C3=A9e automatiquement pour t=
rouver d'autres "
 "fichiers qui pourraient se trouver dans le m=C3=AAme =C3=A9tat."
=20
-#: lib/diff.tcl:83
+#: lib/diff.tcl:99
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "Chargement des diff=C3=A9rences de %s..."
=20
-#: lib/diff.tcl:116 lib/diff.tcl:190
+#: lib/diff.tcl:120
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"LOCAL: supprim=C3=A9\n"
+"DISTANT:\n"
+
+#: lib/diff.tcl:125
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"DISTANT: supprim=C3=A9\n"
+"LOCAL:\n"
+
+#: lib/diff.tcl:132
+msgid "LOCAL:\n"
+msgstr "LOCAL:\n"
+
+#: lib/diff.tcl:135
+msgid "REMOTE:\n"
+msgstr "DISTANT:\n"
+
+#: lib/diff.tcl:197 lib/diff.tcl:296
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "Impossible d'afficher %s"
=20
-#: lib/diff.tcl:117
+#: lib/diff.tcl:198
 msgid "Error loading file:"
 msgstr "Erreur lors du chargement du fichier :"
=20
-#: lib/diff.tcl:124
+#: lib/diff.tcl:205
 msgid "Git Repository (subproject)"
 msgstr "D=C3=A9p=C3=B4t Git (sous projet)"
=20
-#: lib/diff.tcl:136
+#: lib/diff.tcl:217
 msgid "* Binary file (not showing content)."
 msgstr "* Fichier binaire (pas d'apper=C3=A7u du contenu)."
=20
-#: lib/diff.tcl:191
-msgid "Error loading diff:"
-msgstr "Erreur lors du chargement des diff=C3=A9rences :"
+#: lib/diff.tcl:222
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* Le fichier non suivi fait %d octets.\n"
+"* On montre seulement les premiers %d octets.\n"
=20
-#: lib/diff.tcl:313
+#: lib/diff.tcl:228
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* Fichier suivi raccourcis ici de %s.\n"
+"* Pour voir le fichier entier, utiliser un =C3=A9diteur externe.\n"
+
+#: lib/diff.tcl:436
 msgid "Failed to unstage selected hunk."
 msgstr "=C3=89chec lors de la d=C3=A9sindexation de la section s=C3=A9=
lectionn=C3=A9e."
=20
-#: lib/diff.tcl:320
+#: lib/diff.tcl:443
 msgid "Failed to stage selected hunk."
 msgstr "=C3=89chec lors de l'indexation de la section."
=20
-#: lib/diff.tcl:386
+#: lib/diff.tcl:509
 msgid "Failed to unstage selected line."
 msgstr "=C3=89chec lors de la d=C3=A9sindexation de la ligne s=C3=A9le=
ctionn=C3=A9e."
=20
-#: lib/diff.tcl:394
+#: lib/diff.tcl:517
 msgid "Failed to stage selected line."
 msgstr "=C3=89chec lors de l'indexation de la ligne."
=20
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "D=C3=A9faut"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "Syst=C3=A8me (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "Autre"
+
 #: lib/error.tcl:20 lib/error.tcl:114
 msgid "error"
 msgstr "erreur"
@@ -1549,40 +1702,49 @@ msgstr "Continuer"
 msgid "Unlock Index"
 msgstr "D=C3=A9verouiller l'index"
=20
-#: lib/index.tcl:282
+#: lib/index.tcl:287
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "D=C3=A9sindexation de: %s"
=20
-#: lib/index.tcl:313
+#: lib/index.tcl:326
 msgid "Ready to commit."
 msgstr "Pr=C3=AAt =C3=A0 =C3=AAtre commit=C3=A9."
=20
-#: lib/index.tcl:326
+#: lib/index.tcl:339
 #, tcl-format
 msgid "Adding %s"
 msgstr "Ajout de %s"
=20
-#: lib/index.tcl:381
+#: lib/index.tcl:396
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "Annuler les modifications dans le fichier %s ? "
=20
-#: lib/index.tcl:383
+#: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "Annuler les modifications dans ces %i fichiers ?"
=20
-#: lib/index.tcl:391
+#: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Toutes les modifications non-index=C3=A9es seront d=C3=A9finitivement=
 perdues par "
 "l'annulation."
=20
-#: lib/index.tcl:394
+#: lib/index.tcl:409
 msgid "Do Nothing"
 msgstr "Ne rien faire"
=20
+#: lib/index.tcl:427
+msgid "Reverting selected files"
+msgstr "Annuler modifications dans fichiers selectionn=C3=A9s"
+
+#: lib/index.tcl:431
+#, tcl-format
+msgid "Reverting %s"
+msgstr "Annulation des modifications dans %s"
+
 #: lib/merge.tcl:13
 msgid ""
 "Cannot merge while amending.\n"
@@ -1612,7 +1774,7 @@ msgstr ""
 "\n"
 "Cela va =C3=AAtre fait tout de suite automatiquement\n"
=20
-#: lib/merge.tcl:44
+#: lib/merge.tcl:45
 #, tcl-format
 msgid ""
 "You are in the middle of a conflicted merge.\n"
@@ -1630,7 +1792,7 @@ msgstr ""
 "terminer la fusion courante. Seulement =C3=A0 ce moment l=C3=A0 sera-=
t-il possible "
 "d'effectuer une nouvelle fusion.\n"
=20
-#: lib/merge.tcl:54
+#: lib/merge.tcl:55
 #, tcl-format
 msgid ""
 "You are in the middle of a change.\n"
@@ -1648,34 +1810,34 @@ msgstr ""
 "faisait comme cela, vous =C3=A9viterez de devoir =C3=A9ventuellement =
abandonner une "
 "fusion ayant =C3=A9chou=C3=A9e.\n"
=20
-#: lib/merge.tcl:106
+#: lib/merge.tcl:107
 #, tcl-format
 msgid "%s of %s"
 msgstr "%s de %s"
=20
-#: lib/merge.tcl:119
+#: lib/merge.tcl:120
 #, tcl-format
 msgid "Merging %s and %s..."
 msgstr "Fusion de %s et %s..."
=20
-#: lib/merge.tcl:130
+#: lib/merge.tcl:131
 msgid "Merge completed successfully."
 msgstr "La fusion s'est faite avec succ=C3=A8s."
=20
-#: lib/merge.tcl:132
+#: lib/merge.tcl:133
 msgid "Merge failed.  Conflict resolution is required."
 msgstr "La fusion a echou=C3=A9e. Il est n=C3=A9cessaire de r=C3=A9sou=
dre les conflicts."
=20
-#: lib/merge.tcl:157
+#: lib/merge.tcl:158
 #, tcl-format
 msgid "Merge Into %s"
 msgstr "Fusion dans %s"
=20
-#: lib/merge.tcl:176
+#: lib/merge.tcl:177
 msgid "Revision To Merge"
 msgstr "R=C3=A9vision =C3=A0 fusionner"
=20
-#: lib/merge.tcl:211
+#: lib/merge.tcl:212
 msgid ""
 "Cannot abort while amending.\n"
 "\n"
@@ -1685,7 +1847,7 @@ msgstr ""
 "\n"
 "Vous devez finir de corriger ce commit.\n"
=20
-#: lib/merge.tcl:221
+#: lib/merge.tcl:222
 msgid ""
 "Abort merge?\n"
 "\n"
@@ -1700,7 +1862,7 @@ msgstr ""
 "\n"
 "Abandonner quand m=C3=AAme la fusion courante ?"
=20
-#: lib/merge.tcl:227
+#: lib/merge.tcl:228
 msgid ""
 "Reset changes?\n"
 "\n"
@@ -1715,131 +1877,323 @@ msgstr ""
 "\n"
 "R=C3=A9initialiser quand m=C3=AAme les modifications courantes ?"
=20
-#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "Aborting"
 msgstr "Abandon"
=20
-#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "files reset"
 msgstr "fichiers r=C3=A9initialis=C3=A9s"
=20
-#: lib/merge.tcl:266
+#: lib/merge.tcl:267
 msgid "Abort failed."
 msgstr "L'abandon a =C3=A9chou=C3=A9."
=20
-#: lib/merge.tcl:268
+#: lib/merge.tcl:269
 msgid "Abort completed.  Ready."
 msgstr "Abandon temin=C3=A9. Pr=C3=AAt."
=20
-#: lib/option.tcl:95
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "Forcer la r=C3=A9solution =C3=A0 la version de base ?"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "Forcer la r=C3=A9solution =C3=A0 cette branche ?"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "Forcer la r=C3=A9solution =C3=A0 l'autre branche ?"
+
+#: lib/mergetool.tcl:14
+#, tcl-format
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
+msgstr ""
+"Noter que le diff ne montre que les modifications en conflict.\n"
+"\n"
+"%s sera =C3=A9cras=C3=A9.\n"
+"\n"
+"Cette op=C3=A9ration ne peut =C3=AAtre d=C3=A9faite qu'en relan=C3=A7=
ant la fusion."
+
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr "Le fichier %s semble avoir des conflicts non r=C3=A9solus, ind=
=C3=A9xer quand m=C3=AAme ?"
+
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "Ajouter une r=C3=A9solution pour %s"
+
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr "Impossible de r=C3=A9soudre la suppression ou de relier des co=
nflicts en utilisant un outil"
+
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "Le fichier en conflict n'existe pas."
+
+#: lib/mergetool.tcl:264
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "'%s' n'est pas un outil graphique pour fusionner des fichiers.=
"
+
+#: lib/mergetool.tcl:268
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "Outil de fusion '%s' non support=C3=A9"
+
+#: lib/mergetool.tcl:303
+msgid "Merge tool is already running, terminate it?"
+msgstr "L'outil de fusion tourne d=C3=A9j=C3=A0, faut-il le terminer ?=
"
+
+#: lib/mergetool.tcl:323
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"Erreur lors de la r=C3=A9cup=C3=A9ration des versions:\n"
+"%s"
+
+#: lib/mergetool.tcl:343
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+"Impossible de lancer l'outil de fusion:\n"
+"\n"
+"%s"
+
+#: lib/mergetool.tcl:347
+msgid "Running merge tool..."
+msgstr "Lancement de l'outil de fusion..."
+
+#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+msgid "Merge tool failed."
+msgstr "L'outil de fusion a =C3=A9chou=C3=A9."
+
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "Encodage global invalide '%s'"
+
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "Encodage de d=C3=A9p=C3=B4t invalide '%s'"
+
+#: lib/option.tcl:117
 msgid "Restore Defaults"
 msgstr "Remettre les valeurs par d=C3=A9faut"
=20
-#: lib/option.tcl:99
+#: lib/option.tcl:121
 msgid "Save"
 msgstr "Sauvegarder"
=20
-#: lib/option.tcl:109
+#: lib/option.tcl:131
 #, tcl-format
 msgid "%s Repository"
 msgstr "D=C3=A9p=C3=B4t: %s"
=20
-#: lib/option.tcl:110
+#: lib/option.tcl:132
 msgid "Global (All Repositories)"
 msgstr "Globales (tous les d=C3=A9p=C3=B4ts)"
=20
-#: lib/option.tcl:116
+#: lib/option.tcl:138
 msgid "User Name"
 msgstr "Nom d'utilisateur"
=20
-#: lib/option.tcl:117
+#: lib/option.tcl:139
 msgid "Email Address"
 msgstr "Adresse email"
=20
-#: lib/option.tcl:119
+#: lib/option.tcl:141
 msgid "Summarize Merge Commits"
 msgstr "R=C3=A9sumer les commits de fusion"
=20
-#: lib/option.tcl:120
+#: lib/option.tcl:142
 msgid "Merge Verbosity"
 msgstr "Fusion bavarde"
=20
-#: lib/option.tcl:121
+#: lib/option.tcl:143
 msgid "Show Diffstat After Merge"
 msgstr "Montrer statistiques de diff apr=C3=A8s fusion"
=20
-#: lib/option.tcl:123
+#: lib/option.tcl:144
+msgid "Use Merge Tool"
+msgstr "Utiliser outil de fusion"
+
+#: lib/option.tcl:146
 msgid "Trust File Modification Timestamps"
 msgstr "Faire confiance aux dates de modification de fichiers "
=20
-#: lib/option.tcl:124
+#: lib/option.tcl:147
 msgid "Prune Tracking Branches During Fetch"
 msgstr "Purger les branches de suivi pendant la r=C3=A9cup=C3=A9ration=
"
=20
-#: lib/option.tcl:125
+#: lib/option.tcl:148
 msgid "Match Tracking Branches"
 msgstr "Faire correspondre les branches de suivi"
=20
-#: lib/option.tcl:126
+#: lib/option.tcl:149
 msgid "Blame Copy Only On Changed Files"
 msgstr "Annoter les copies seulement sur fichiers modifi=C3=A9s"
=20
-#: lib/option.tcl:127
+#: lib/option.tcl:150
 msgid "Minimum Letters To Blame Copy On"
 msgstr "Minimum de carat=C3=A8res pour annoter une copie"
=20
-#: lib/option.tcl:128
+#: lib/option.tcl:151
+msgid "Blame History Context Radius (days)"
+msgstr "Distance de bl=C3=A2me dans l'historique (jours)"
+
+#: lib/option.tcl:152
 msgid "Number of Diff Context Lines"
 msgstr "Nombre de lignes de contexte dans les diffs"
=20
-#: lib/option.tcl:129
+#: lib/option.tcl:153
 msgid "Commit Message Text Width"
 msgstr "Largeur du texte de message de commit"
=20
-#: lib/option.tcl:130
+#: lib/option.tcl:154
 msgid "New Branch Name Template"
 msgstr "Nouveau mod=C3=A8le de nom de branche"
=20
-#: lib/option.tcl:194
+#: lib/option.tcl:155
+msgid "Default File Contents Encoding"
+msgstr "Encodage du contenu des fichiers par d=C3=A9faut"
+
+#: lib/option.tcl:203
+msgid "Change"
+msgstr "Modifier"
+
+#: lib/option.tcl:230
 msgid "Spelling Dictionary:"
 msgstr "Dictionnaire d'orthographe :"
=20
-#: lib/option.tcl:218
+#: lib/option.tcl:254
 msgid "Change Font"
 msgstr "Modifier les polices"
=20
-#: lib/option.tcl:222
+#: lib/option.tcl:258
 #, tcl-format
 msgid "Choose %s"
 msgstr "Choisir %s"
=20
-#: lib/option.tcl:228
+#: lib/option.tcl:264
 msgid "pt."
 msgstr "pt."
=20
-#: lib/option.tcl:242
+#: lib/option.tcl:278
 msgid "Preferences"
 msgstr "Pr=C3=A9f=C3=A9rences"
=20
-#: lib/option.tcl:277
+#: lib/option.tcl:314
 msgid "Failed to completely save options:"
 msgstr "La sauvegarde compl=C3=A8te des options a =C3=A9chou=C3=A9e :"
=20
-#: lib/remote.tcl:165
+#: lib/remote.tcl:163
+msgid "Remove Remote"
+msgstr "Supprimer d=C3=A9p=C3=B4t distant"
+
+#: lib/remote.tcl:168
 msgid "Prune from"
 msgstr "Purger de"
=20
-#: lib/remote.tcl:170
+#: lib/remote.tcl:173
 msgid "Fetch from"
 msgstr "R=C3=A9cup=C3=A9rer de"
=20
-#: lib/remote.tcl:213
+#: lib/remote.tcl:215
 msgid "Push to"
 msgstr "Pousser vers"
=20
+#: lib/remote_add.tcl:19
+msgid "Add Remote"
+msgstr "Ajouter d=C3=A9p=C3=B4t distant"
+
+#: lib/remote_add.tcl:24
+msgid "Add New Remote"
+msgstr "Ajouter nouveau d=C3=A9p=C3=B4t distant"
+
+#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+msgid "Add"
+msgstr "Ajouter"
+
+#: lib/remote_add.tcl:37
+msgid "Remote Details"
+msgstr "D=C3=A9tails des d=C3=A9p=C3=B4ts distants"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Emplacement:"
+
+#: lib/remote_add.tcl:62
+msgid "Further Action"
+msgstr "Action suppl=C3=A9mentaire"
+
+#: lib/remote_add.tcl:65
+msgid "Fetch Immediately"
+msgstr "R=C3=A9cup=C3=A9rer imm=C3=A9diatement"
+
+#: lib/remote_add.tcl:71
+msgid "Initialize Remote Repository and Push"
+msgstr "Initialiser d=C3=A9p=C3=B4t distant et pousser"
+
+#: lib/remote_add.tcl:77
+msgid "Do Nothing Else Now"
+msgstr "Ne rien faire d'autre maintenant"
+
+#: lib/remote_add.tcl:101
+msgid "Please supply a remote name."
+msgstr "Merci de fournir un nom de d=C3=A9p=C3=B4t distant."
+
+#: lib/remote_add.tcl:114
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "'%s' n'est pas un nom de d=C3=A9p=C3=B4t distant acceptable."
+
+#: lib/remote_add.tcl:125
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "=C3=89chec de l'ajout du d=C3=A9p=C3=B4t distant '%s' =C3=A0 l=
'emplacement '%s'."
+
+#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "r=C3=A9cup=C3=A9rer %s"
+
+#: lib/remote_add.tcl:134
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "R=C3=A9cup=C3=A9ration de %s"
+
+#: lib/remote_add.tcl:157
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "Pas de m=C3=A9thode connue pour initialiser le d=C3=A9p=C3=B4t=
 =C3=A0 l'emplacement '%s'."
+
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#, tcl-format
+msgid "push %s"
+msgstr "pousser %s"
+
+#: lib/remote_add.tcl:164
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "Mise en place de %s (=C3=A0 %s)"
+
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
-msgid "Delete Remote Branch"
-msgstr "Supprimer branche distante"
+msgid "Delete Branch Remotely"
+msgstr "Supprimer branche =C3=A0 distance"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -1850,8 +2204,8 @@ msgid "Remote:"
 msgstr "Branche distante :"
=20
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
-msgid "Arbitrary URL:"
-msgstr "URL arbitraire :"
+msgid "Arbitrary Location:"
+msgstr "Emplacement arbitraire :"
=20
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
@@ -1921,6 +2275,22 @@ msgstr "Aucun d=C3=A9p=C3=B4t n'est s=C3=A9lecti=
onn=C3=A9."
 msgid "Scanning %s..."
 msgstr "Synchronisation de %s..."
=20
+#: lib/search.tcl:21
+msgid "Find:"
+msgstr "Chercher :"
+
+#: lib/search.tcl:23
+msgid "Next"
+msgstr "Suivant"
+
+#: lib/search.tcl:24
+msgid "Prev"
+msgstr "Pr=C3=A9c=C3=A9dant"
+
+#: lib/search.tcl:25
+msgid "Case-Sensitive"
+msgstr "Sensible =C3=A0 la casse"
+
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
 msgstr "Impossible d'=C3=A9crire le raccourcis :"
@@ -1958,23 +2328,188 @@ msgstr "V=C3=A9rificateur d'orthographe non re=
connu"
 msgid "No Suggestions"
 msgstr "Aucune suggestion"
=20
-#: lib/spellcheck.tcl:387
+#: lib/spellcheck.tcl:388
 msgid "Unexpected EOF from spell checker"
 msgstr "EOF inattendue envoy=C3=A9e par le v=C3=A9rificateur d'orthogr=
aphe"
=20
-#: lib/spellcheck.tcl:391
+#: lib/spellcheck.tcl:392
 msgid "Spell Checker Failed"
 msgstr "Le v=C3=A9rificateur d'orthographe a =C3=A9chou=C3=A9"
=20
+#: lib/sshkey.tcl:31
+msgid "No keys found."
+msgstr "Aucune cl=C3=A9 trouv=C3=A9e."
+
+#: lib/sshkey.tcl:34
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "Cl=C3=A9 publique trouv=C3=A9e dans : %s"
+
+#: lib/sshkey.tcl:40
+msgid "Generate Key"
+msgstr "G=C3=A9n=C3=A9rer une cl=C3=A9"
+
+#: lib/sshkey.tcl:56
+msgid "Copy To Clipboard"
+msgstr "Copier dans le presse papier"
+
+#: lib/sshkey.tcl:70
+msgid "Your OpenSSH Public Key"
+msgstr "Votre cl=C3=A9 publique Open SSH"
+
+#: lib/sshkey.tcl:78
+msgid "Generating..."
+msgstr "G=C3=A9n=C3=A9ration..."
+
+#: lib/sshkey.tcl:84
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"Impossible de lancer ssh-keygen:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:111
+msgid "Generation failed."
+msgstr "La g=C3=A9n=C3=A9ration a =C3=A9chou=C3=A9."
+
+#: lib/sshkey.tcl:118
+msgid "Generation succeded, but no keys found."
+msgstr "La g=C3=A9n=C3=A9ration a r=C3=A9ussi, mais aucune cl=C3=A9 n'=
a =C3=A9t=C3=A9 trouv=C3=A9e."
+
+#: lib/sshkey.tcl:121
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "Votre cl=C3=A9 est dans : %s"
+
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%s ... %*i de %*i %s (%3i%%)"
=20
-#: lib/transport.tcl:6
+#: lib/tools.tcl:75
 #, tcl-format
-msgid "fetch %s"
-msgstr "r=C3=A9cup=C3=A9rer %s"
+msgid "Running %s requires a selected file."
+msgstr "Lancer %s n=C3=A9cessite qu'un fichier soit s=C3=A9lectionn=C3=
=A9."
+
+#: lib/tools.tcl:90
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "=C3=8Ates vous s=C3=BBr de vouloir lancer %s ?"
+
+#: lib/tools.tcl:110
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Outil : %s"
+
+#: lib/tools.tcl:111
+#, tcl-format
+msgid "Running: %s"
+msgstr "Lancement de : %s"
+
+#: lib/tools.tcl:149
+#, tcl-format
+msgid "Tool completed succesfully: %s"
+msgstr "L'outil a termin=C3=A9 avec succ=C3=A8s : %s"
+
+#: lib/tools.tcl:151
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "L'outil a =C3=A9chou=C3=A9 : %s"
+
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "Ajouter outil"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "Ajouter nouvelle commande d'outil"
+
+#: lib/tools_dlg.tcl:33
+msgid "Add globally"
+msgstr "Ajouter globalement"
+
+#: lib/tools_dlg.tcl:45
+msgid "Tool Details"
+msgstr "D=C3=A9tails sur l'outil"
+
+#: lib/tools_dlg.tcl:48
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Utiliser les s=C3=A9parateurs '/' pour cr=C3=A9er un arbre de =
sous menus :"
+
+#: lib/tools_dlg.tcl:61
+msgid "Command:"
+msgstr "Commande :"
+
+#: lib/tools_dlg.tcl:74
+msgid "Show a dialog before running"
+msgstr "Montrer une bo=C3=AEte de dialogue avant le lancement"
+
+#: lib/tools_dlg.tcl:80
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Demander =C3=A0 l'utilisateur de s=C3=A9lectionner une r=C3=A9=
vision (change $REVISION)"
+
+#: lib/tools_dlg.tcl:85
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Demander =C3=A0 l'utilisateur des arguments suppl=C3=A9mentair=
es (change $ARGS)"
+
+#: lib/tools_dlg.tcl:92
+msgid "Don't show the command output window"
+msgstr "Ne pas montrer la fen=C3=AAtre de sortie des commandes"
+
+#: lib/tools_dlg.tcl:97
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Lancer seulement si un diff est selectionn=C3=A9 ($FILENAME no=
n vide)"
+
+#: lib/tools_dlg.tcl:121
+msgid "Please supply a name for the tool."
+msgstr "Merci de fournir un nom pour l'outil."
+
+#: lib/tools_dlg.tcl:129
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "L'outil '%s' existe d=C3=A9j=C3=A0."
+
+#: lib/tools_dlg.tcl:151
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"Impossible d'ajouter l'outil:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:190
+msgid "Remove Tool"
+msgstr "Supprimer l'outil"
+
+#: lib/tools_dlg.tcl:196
+msgid "Remove Tool Commands"
+msgstr "Supprimer des commandes d'outil"
+
+#: lib/tools_dlg.tcl:200
+msgid "Remove"
+msgstr "Supprimer"
+
+#: lib/tools_dlg.tcl:236
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Le bleu indique des outils locaux au d=C3=A9p=C3=B4t)"
+
+#: lib/tools_dlg.tcl:297
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Lancer commande : %s"
+
+#: lib/tools_dlg.tcl:311
+msgid "Arguments"
+msgstr "Arguments"
+
+#: lib/tools_dlg.tcl:348
+msgid "OK"
+msgstr "OK"
=20
 #: lib/transport.tcl:7
 #, tcl-format
@@ -1991,11 +2526,6 @@ msgstr "purger =C3=A0 distance %s"
 msgid "Pruning tracking branches deleted from %s"
 msgstr "Nettoyer les branches de suivi supprim=C3=A9es de %s"
=20
-#: lib/transport.tcl:25 lib/transport.tcl:71
-#, tcl-format
-msgid "push %s"
-msgstr "pousser %s"
-
 #: lib/transport.tcl:26
 #, tcl-format
 msgid "Pushing changes to %s"
--=20
1.5.6.1.2293.gb0a4
