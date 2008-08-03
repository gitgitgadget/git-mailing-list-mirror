From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Update to it.po
Date: Sun, 3 Aug 2008 12:11:31 +0200
Message-ID: <20080803121131.589e672b@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: spearce@spearce.org, git@vger.kernel.org, barra_cuda@katamail.com
X-From: git-owner@vger.kernel.org Sun Aug 03 12:12:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPaZs-0000q0-O2
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 12:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbYHCKLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 06:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbYHCKLj
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 06:11:39 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:55073 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbYHCKLi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 06:11:38 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1444910fkq.5
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=B0Vzd6c7eCTEiJsZuBbIn+4KpaDduSu7Fr4SApRr9EE=;
        b=JZGwCP2ucVG4OIwhocj7tynL18eTLGQQ2lWphvT58qZbJUQzortILkN04U2fvhYnxq
         W0/hgic+vBUbTVnRFW75ENTcsDkcoDTSOnm1/pIk5rr3pYhHMP9HCfRDiIHTE72Ibgg9
         aU/by2y1KGhTKR+GGnCByRhzFMB+T+8R+3wHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=WJdCYbCniHSG7hSFDts6XwZd0rtS2VLPjpejBEeiTWfT5E1KG7UdLkRS5N/5mHJ9xl
         eaJ/TvBFCFL6JAh0uJ2BXlX3fDs9iwVkbs0ly4QjGWLWuQUb924k/tNLLulwxgFawJkP
         NeJ13f9F+srE+XKAm5MK3PY0WgWWHhNB7OvX4=
Received: by 10.181.21.2 with SMTP id y2mr4677599bki.44.1217758296629;
        Sun, 03 Aug 2008 03:11:36 -0700 (PDT)
Received: from paolo-desktop ( [79.7.68.125])
        by mx.google.com with ESMTPS id g28sm3210408fkg.8.2008.08.03.03.11.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 03:11:35 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91223>

Some fairly simply changes to it.po


Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---

Shawn,
a simple make in the git-gui-i18n repository fails with the following msg:
paolo@paolo-desktop:~/git-gui-i18n$ make
GITGUI_VERSION = 0.9.GITGUI-dirty
    * new locations or Tcl/Tk interpreter
    GEN git-gui
    INDEX lib/
    MSGFMT    po/bg.msg 391 translated.
    MSGFMT    po/de.msg 383 translated, 5 fuzzy, 3 untranslated.
    MSGFMT    po/es.msg 122 translated, 269 untranslated.
    MSGFMT    po/fr.msg 391 translated.
    MSGFMT    po/hu.msg 391 translated.
    MSGFMT    po/it.msg make: *** [po/it.msg] Error 1

Before and after the following patch :-)

 po/it.po |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/po/it.po b/po/it.po
index 197e6fa..aa3ed13 100644
--- a/po/it.po
+++ b/po/it.po
@@ -10,12 +10,12 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2008-03-14 07:18+0100\n"
-"PO-Revision-Date: 2008-03-17 14:12+0100\n"
-"Last-Translator: Michele Ballabio <barra_cuda@katamail.com>\n"
+"PO-Revision-Date: 2008-08-03 11:59+0200\n"
+"Last-Translator: Paolo Ciarrocchi <Paolo.Ciarrocchi@gmail.com>\n"
 "Language-Team: Italian <tp@lists.linux.it>\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
-"Content-Transfer-Encoding: 8bit\n"
+"Content-Transfer-Encoding: 8bit"
 
 #: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.sh:744
 #: git-gui.sh:763
@@ -1022,7 +1022,7 @@ msgstr "Calcolo oggetti"
 
 #: lib/choose_repository.tcl:628
 msgid "buckets"
-msgstr ""
+msgstr "buckets"
 
 #: lib/choose_repository.tcl:652
 #, tcl-format
@@ -1910,16 +1910,14 @@ msgid "Spell checker silently failed on startup"
 msgstr "Il correttore ortografico ha riportato un errore all'avvio"
 
 #: lib/spellcheck.tcl:80
-#, fuzzy
 msgid "Unrecognized spell checker"
-msgstr "Correttore ortografico sconosciuto"
+msgstr "Correttore ortografico non riconosciuto"
 
 #: lib/spellcheck.tcl:180
 msgid "No Suggestions"
 msgstr "Nessun suggerimento"
 
 #: lib/spellcheck.tcl:381
-#, fuzzy
 msgid "Unexpected EOF from spell checker"
 msgstr "Il correttore ortografico ha mandato un EOF inaspettato"
 
@@ -1994,3 +1992,4 @@ msgstr "Utilizza 'thin pack' (per connessioni lente)"
 #: lib/transport.tcl:168
 msgid "Include tags"
 msgstr "Includi etichette"
+
-- 
1.5.6.rc1.21.g03300
