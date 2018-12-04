Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BAB6211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 09:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLDJfa convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 4 Dec 2018 04:35:30 -0500
Received: from taro.getmail.no ([84.210.184.13]:37110 "EHLO
        taro.get.c.bitbit.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725613AbeLDJf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 04:35:28 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2018 04:35:26 EST
Received: from montes.get.c.bitbit.net (unknown [10.7.88.21])
        by taro.get.c.bitbit.net (Postfix) with ESMTPS id 6BD2B149A0
        for <git@vger.kernel.org>; Tue,  4 Dec 2018 10:29:57 +0100 (CET)
Received: from ryder.getmail.no (unknown [10.7.88.25])
        by montes.get.c.bitbit.net (Postfix) with ESMTP id 7CF5030A
        for <git@vger.kernel.org>; Tue,  4 Dec 2018 10:29:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by ryder.getmail.no (Postfix) with ESMTP id 1F68F62E3B;
        Tue,  4 Dec 2018 10:29:43 +0100 (CET)
Received: from ryder.getmail.no ([127.0.0.1])
        by localhost (ryder.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 61V5xaKx1MVc; Tue,  4 Dec 2018 10:29:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by ryder.getmail.no (Postfix) with ESMTP id 720A062E4E;
        Tue,  4 Dec 2018 10:29:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at ryder.getmail.no
Received: from ryder.getmail.no ([127.0.0.1])
        by localhost (ryder.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oHtooppzIVG9; Tue,  4 Dec 2018 10:29:42 +0100 (CET)
Received: from hjemme.reinholdtsen.name (cm-84.212.222.24.getinternet.no [84.212.222.24])
        by ryder.getmail.no (Postfix) with SMTP id 43B0A62E3B;
        Tue,  4 Dec 2018 10:29:42 +0100 (CET)
Received: (nullmailer pid 11400 invoked by uid 10001);
        Tue, 04 Dec 2018 09:29:41 -0000
From:   Petter Reinholdtsen <pere@hungry.com>
To:     git@vger.kernel.org
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Fredrik Skolmli <fredrik@frsk.net>
Subject: git-gui: Norwegian =?utf-8?Q?Bokm=C3=A5l?= translation
Date:   Tue, 04 Dec 2018 10:29:41 +0100
Message-ID: <sa68t15abcq.fsf@meta.reinholdtsen.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From 9a7edd7f94b82335177917463cb334541b4d2cb0 Mon Sep 17 00:00:00 2001
From: Petter Reinholdtsen <pere@hungry.com>
Date: Mon, 3 Dec 2018 12:24:22 +0100
Subject: [PATCH] i18n: Update the nb translation of git-gui and start on
 glossary list.

Signed-off-by: Petter Reinholdtsen <pere@hungry.com>
---
 po/glossary/nb.po | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/nb.po          |  57 ++++++++++++------
 2 files changed, 210 insertions(+), 18 deletions(-)
 create mode 100644 po/glossary/nb.po

diff --git a/po/glossary/nb.po b/po/glossary/nb.po
new file mode 100644
index 0000000..1a80451
--- /dev/null
+++ b/po/glossary/nb.po
@@ -0,0 +1,171 @@
+# Copyright (C) 2018 Free Software Foundation, Inc.
+#
+# Petter Reinholdtsen <pere@hungry.com>, 2018.
+msgid ""
+msgstr ""
+"Project-Id-Version: \n"
+"POT-Creation-Date: 2008-01-07 21:20+0100\n"
+"PO-Revision-Date: 2018-12-03 12:35+0100\n"
+"Last-Translator: Petter Reinholdtsen <pere@hungry.com>\n"
+"Language-Team: NorwegianBokmal <i18n-no@lister.ping.uio.no>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: ENCODING\n"
+"Language: nb\n"
+"Plural-Forms: nplurals=2; plural=(n != 1);\n"
+"X-Generator: Lokalize 2.0\n"
+
+#. "English Definition (Dear translator: This file will never be visible to the user! It should only serve as a tool for you, the translator. Nothing more.)"
+msgid ""
+"English Term (Dear translator: This file will never be visible to the user!)"
+msgstr ""
+
+#. ""
+msgid "amend"
+msgstr "legg til"
+
+#. ""
+msgid "annotate"
+msgstr "kommenter"
+
+#. "A 'branch' is an active line of development."
+msgid "branch [noun]"
+msgstr "gren [substantiv]"
+
+#. ""
+msgid "branch [verb]"
+msgstr ""
+
+#. ""
+msgid "checkout [noun]"
+msgstr "utsjekk [substantiv]"
+
+#. "The action of updating the working tree to a revision which was stored in the object database."
+msgid "checkout [verb]"
+msgstr "sjekk ut [verb]"
+
+#. ""
+msgid "clone [verb]"
+msgstr "klone [verb]"
+
+#. "A single point in the git history."
+msgid "commit [noun]"
+msgstr "endring [substantiv]"
+
+#. "The action of storing a new snapshot of the project's state in the git history."
+msgid "commit [verb]"
+msgstr "sjekk inn [verb]"
+
+#. ""
+msgid "diff [noun]"
+msgstr "forskjell [substantiv]"
+
+#. ""
+msgid "diff [verb]"
+msgstr ""
+
+#. "A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
+msgid "fast forward merge"
+msgstr ""
+
+#. "Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
+msgid "fetch"
+msgstr "hent"
+
+#. "One context of consecutive lines in a whole patch, which consists of many such hunks"
+msgid "hunk"
+msgstr ""
+
+#. "A collection of files. The index is a stored version of your working tree."
+msgid "index (in git-gui: staging area)"
+msgstr ""
+
+#. "A successful merge results in the creation of a new commit representing the result of the merge."
+msgid "merge [noun]"
+msgstr ""
+
+#. "To bring the contents of another branch into the current branch."
+msgid "merge [verb]"
+msgstr ""
+
+#. ""
+msgid "message"
+msgstr "melding"
+
+#. "Deletes all stale tracking branches under <name>. These stale branches have already been removed from the remote repository referenced by <name>, but are still locally available in 'remotes/<name>'."
+msgid "prune"
+msgstr ""
+
+#. "Pulling a branch means to fetch it and merge it."
+msgid "pull"
+msgstr "dra inn"
+
+#. "Pushing a branch means to get the branch's head ref from a remote repository, and ... (well, can someone please explain it for mere mortals?)"
+msgid "push"
+msgstr "skyv"
+
+#. ""
+msgid "redo"
+msgstr "gjør om"
+
+#. "An other repository ('remote'). One might have a set of remotes whose branches one tracks."
+msgid "remote"
+msgstr ""
+
+#. "A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
+msgid "repository"
+msgstr "depot"
+
+#. ""
+msgid "reset"
+msgstr "nullstill"
+
+#. ""
+msgid "revert"
+msgstr ""
+
+#. "A particular state of files and directories which was stored in the object database."
+msgid "revision"
+msgstr ""
+
+#. ""
+msgid "sign off"
+msgstr ""
+
+#. ""
+msgid "staging area"
+msgstr ""
+
+#. ""
+msgid "status"
+msgstr "status"
+
+#. "A ref pointing to a tag or commit object"
+msgid "tag [noun]"
+msgstr "merkelapp [substantiv] "
+
+#. ""
+msgid "tag [verb]"
+msgstr "merk [verb]"
+
+#. "A regular git branch that is used to follow changes from another repository."
+msgid "tracking branch"
+msgstr ""
+
+#. ""
+msgid "undo"
+msgstr ""
+
+#. ""
+msgid "update"
+msgstr "oppdater"
+
+#. ""
+msgid "verify"
+msgstr ""
+
+#. "The tree of actual checked out files."
+msgid "working copy, working tree"
+msgstr ""
+
+
diff --git a/po/nb.po b/po/nb.po
index d66aa50..92a7f5d 100644
--- a/po/nb.po
+++ b/po/nb.po
@@ -2,19 +2,23 @@
 # Copyright (C) 2007-2008 Shawn Pearce, et al.
 # This file is distributed under the same license as the git-gui package.
 #
-# Fredrik Skolmli <fredrik@frsk.net>, 2008.
 #
+# Fredrik Skolmli <fredrik@frsk.net>, 2008.
+# Petter Reinholdtsen <pere@hungry.com>, 2018.
 msgid ""
 msgstr ""
 "Project-Id-Version: nb\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2008-11-16 13:56-0800\n"
-"PO-Revision-Date: 2008-12-03 16:05+0100\n"
-"Last-Translator: Fredrik Skolmli <fredrik@frsk.net>\n"
-"Language-Team: Norwegian Bokmål\n"
+"PO-Revision-Date: 2018-12-03 12:23+0100\n"
+"Last-Translator: Petter Reinholdtsen <pere@hungry.com>\n"
+"Language-Team: NorwegianBokmal <i18n-no@lister.ping.uio.no>\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
+"Language: nb\n"
+"Plural-Forms: nplurals=2; plural=(n != 1);\n"
+"X-Generator: Lokalize 2.0\n"
 
 #: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.sh:847
 #: git-gui.sh:866
@@ -71,7 +75,7 @@ msgstr "Kan ikke gå til toppen av arbeidskatalogen:"
 
 #: git-gui.sh:1076
 msgid "Cannot use funny .git directory:"
-msgstr ""
+msgstr "Kan ikke bruke merkelig .git-katalog:"
 
 #: git-gui.sh:1081
 msgid "No working directory"
@@ -87,11 +91,11 @@ msgstr "Søker etter endrede filer..."
 
 #: git-gui.sh:1367
 msgid "Calling prepare-commit-msg hook..."
-msgstr ""
+msgstr "Kjører kroken prepare-common-msg..."
 
 #: git-gui.sh:1384
 msgid "Commit declined by prepare-commit-msg hook."
-msgstr ""
+msgstr "Innsjekking avvist av kroken prepare-commit-msg."
 
 #: git-gui.sh:1542 lib/browser.tcl:246
 msgid "Ready."
@@ -516,6 +520,9 @@ msgid ""
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr ""
+"\n"
+"Dette kommer av et kjent problem med\n"
+"Tcl-binæren distribuert av Cygwin."
 
 #: git-gui.sh:3336
 #, tcl-format
@@ -527,6 +534,12 @@ msgid ""
 "user.email settings into your personal\n"
 "~/.gitconfig file.\n"
 msgstr ""
+"\n"
+"\n"
+"En god erstatning for %s\n"
+"er å legge inn verdier for innstillingene til\n"
+"user.name og user.email i din personlige\n"
+"~/.gitconfig-fil.\n"
 
 #: lib/about.tcl:26
 msgid "git-gui - a graphical user interface for Git."
@@ -558,7 +571,7 @@ msgstr "Vis historikkens innhold"
 
 #: lib/blame.tcl:291
 msgid "Blame Parent Commit"
-msgstr ""
+msgstr "Skyld på foreldreendring"
 
 #: lib/blame.tcl:450
 #, tcl-format
@@ -1516,14 +1529,16 @@ msgstr "Laster inn forskjellene av %s..."
 msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
-msgstr "LOKAL: slettet\n"
+msgstr ""
+"LOKAL: slettet\n"
 "FJERN:\n"
 
 #: lib/diff.tcl:125
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
-msgstr "FJERN: slettet\n"
+msgstr ""
+"FJERN: slettet\n"
 "LOKAL:\n"
 
 #: lib/diff.tcl:132
@@ -1662,7 +1677,8 @@ msgstr "Reverter endringene i disse %i filene?"
 
 #: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
-msgstr "Endringer som ikke ligger i innsjekkingskøen vil bli tapt av denne "
+msgstr ""
+"Endringer som ikke ligger i innsjekkingskøen vil bli tapt av denne "
 "reverteringen"
 
 #: lib/index.tcl:409
@@ -1852,16 +1868,16 @@ msgstr "Konfliktfil eksisterer ikke"
 #: lib/mergetool.tcl:264
 #, tcl-format
 msgid "Not a GUI merge tool: '%s'"
-msgstr ""
+msgstr "Ikke et grafisk sammenslåingsverktøy: '%s'"
 
 #: lib/mergetool.tcl:268
 #, tcl-format
 msgid "Unsupported merge tool '%s'"
-msgstr ""
+msgstr "Ikke-støttet sammenlåingsverktøy '%s'"
 
 #: lib/mergetool.tcl:303
 msgid "Merge tool is already running, terminate it?"
-msgstr ""
+msgstr "Sammenslåingsverktøyet kjører allerede.  Stoppe det?"
 
 #: lib/mergetool.tcl:323
 #, tcl-format
@@ -1879,24 +1895,27 @@ msgid ""
 "\n"
 "%s"
 msgstr ""
+"Klarte ikke starte sammenslåingsverktøyet:\n"
+"\n"
+"%s"
 
 #: lib/mergetool.tcl:347
 msgid "Running merge tool..."
-msgstr ""
+msgstr "Kjører sammenslåingsverktøyet..."
 
 #: lib/mergetool.tcl:375 lib/mergetool.tcl:383
 msgid "Merge tool failed."
-msgstr ""
+msgstr "Sammenslåingsverktøyet feilet."
 
 #: lib/option.tcl:11
 #, tcl-format
 msgid "Invalid global encoding '%s'"
-msgstr ""
+msgstr "Ugyldig global enkoding '%s'"
 
 #: lib/option.tcl:19
 #, tcl-format
 msgid "Invalid repo encoding '%s'"
-msgstr ""
+msgstr "Ugyldig depot-enkoding '%s'"
 
 #: lib/option.tcl:117
 msgid "Restore Defaults"
@@ -2472,3 +2491,5 @@ msgstr "Bruk tynne pakker (for tregere nettverkstilkoblinger)"
 #: lib/transport.tcl:168
 msgid "Include tags"
 msgstr "Inkluder tagger"
+
+
-- 
2.11.0
