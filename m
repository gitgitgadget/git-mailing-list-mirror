From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 1/2] git-gui: Add more terms to glossary.
Date: Sat, 20 Oct 2007 15:30:53 +0200
Message-ID: <200710201530.53483.stimming@tuhh.de>
References: <200710052239.02492.stimming@tuhh.de> <200710082143.13750.stimming@tuhh.de> <20071010060328.GO2137@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 15:33:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjERv-0000A1-2V
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 15:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbXJTNc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 09:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbXJTNc5
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 09:32:57 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:54118 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbXJTNc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 09:32:56 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9KDWogG001184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 20 Oct 2007 15:32:50 +0200
Received: from [192.168.2.102] (p549007A6.dip0.t-ipconnect.de [84.144.7.166])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9KDWmD4004142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 20 Oct 2007 15:32:49 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20071010060328.GO2137@spearce.org>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61830>

---
Based on git-gui.git's master.

 po/glossary/git-gui-glossary.pot |    8 ++++++--
 po/glossary/git-gui-glossary.txt |    3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/po/glossary/git-gui-glossary.pot b/po/glossary/git-gui-glossary.pot
index a2e5c73..48af803 100644
--- a/po/glossary/git-gui-glossary.pot
+++ b/po/glossary/git-gui-glossary.pot
@@ -6,7 +6,7 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
-"POT-Creation-Date: 2007-10-05 22:30+0200\n"
+"POT-Creation-Date: 2007-10-19 21:43+0200\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -86,7 +86,7 @@ msgstr ""
 msgid "message"
 msgstr ""
 
-#. ""
+#. "Deletes all stale tracking branches under <name>. These stale branches have already been removed from the remote repository referenced by <name>, but are still locally available in 'remotes/<name>'."
 msgid "prune"
 msgstr ""
 
@@ -102,6 +102,10 @@ msgstr ""
 msgid "redo"
 msgstr ""
 
+#. "An other repository ('remote'). One might have a set of remotes whose branches one tracks."
+msgid "remote"
+msgstr ""
+
 #. "A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
 msgid "repository"
 msgstr ""
diff --git a/po/glossary/git-gui-glossary.txt b/po/glossary/git-gui-glossary.txt
index b53740d..500d0a0 100644
--- a/po/glossary/git-gui-glossary.txt
+++ b/po/glossary/git-gui-glossary.txt
@@ -16,10 +16,11 @@
 "merge [noun]"	"A successful merge results in the creation of a new commit representing the result of the merge."
 "merge [verb]"	"To bring the contents of another branch into the current branch."
 "message"	""
-"prune"	""
+"prune"	"Deletes all stale tracking branches under <name>. These stale branches have already been removed from the remote repository referenced by <name>, but are still locally available in 'remotes/<name>'."
 "pull"	"Pulling a branch means to fetch it and merge it."
 "push"	"Pushing a branch means to get the branch's head ref from a remote repository, and ... (well, can someone please explain it for mere mortals?)"
 "redo"	""
+"remote"	"An other repository ('remote'). One might have a set of remotes whose branches one tracks."
 "repository"	"A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
 "reset"	""
 "revert"	""
-- 
1.5.3.4.206.g58ba4
