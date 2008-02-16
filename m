From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: (i18n) Add newly added translation strings to template.
Date: Sat, 16 Feb 2008 21:56:22 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200802162156.23436.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 21:59:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQU8B-0003DT-HE
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 21:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499AbYBPU6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 15:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756539AbYBPU6x
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 15:58:53 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:58699 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756431AbYBPU6w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 15:58:52 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m1GKwZ1h023694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 16 Feb 2008 21:58:36 +0100
Received: from [192.168.2.102] (p549030FB.dip0.t-ipconnect.de [84.144.48.251])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m1GKwYIc001194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 16 Feb 2008 21:58:35 +0100
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74076>

And markup one missing string for translation.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---

 lib/spellcheck.tcl |    4 ++--
 po/git-gui.pot     |   32 ++++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/lib/spellcheck.tcl b/lib/spellcheck.tcl
index 7f018e4..a67a5f7 100644
--- a/lib/spellcheck.tcl
+++ b/lib/spellcheck.tcl
@@ -333,11 +333,11 @@ method _read {} {
 	fconfigure $s_fd -block 1
 	if {[eof $s_fd]} {
 		if {![catch {close $s_fd} err]} {
-			set err [mc "unexpected eof from aspell"]
+			set err [mc "Unexpected EOF from aspell"]
 		}
 		catch {after cancel $s_i}
 		$w_text tag remove misspelled 1.0 end
-		error_popup [strcat "Spell Checker Failed" "\n\n" $err]
+		error_popup [strcat [mc "Spell Checker Failed"] "\n\n" $err]
 		return
 	}
 	fconfigure $s_fd -block 0
diff --git a/po/git-gui.pot b/po/git-gui.pot
index 3f139da..2e33284 100644
--- a/po/git-gui.pot
+++ b/po/git-gui.pot
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-02-02 10:14+0100\n"
+"POT-Creation-Date: 2008-02-16 21:24+0100\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -1474,10 +1474,10 @@ msgstr ""
 
 #: lib/merge.tcl:119
 #, tcl-format
-msgid "Merging %s and %s"
+msgid "Merging %s and %s..."
 msgstr ""
 
-#: lib/merge.tcl:131
+#: lib/merge.tcl:130
 msgid "Merge completed successfully."
 msgstr ""
 
@@ -1592,7 +1592,11 @@ msgstr ""
 msgid "New Branch Name Template"
 msgstr ""
 
-#: lib/option.tcl:176
+#: lib/option.tcl:191
+msgid "Spelling Dictionary:"
+msgstr ""
+
+#: lib/option.tcl:215
 msgid "Change Font"
 msgstr ""
 
@@ -1709,6 +1713,26 @@ msgstr ""
 msgid "Cannot write icon:"
 msgstr ""
 
+#: lib/spellcheck.tcl:37
+msgid "Not connected to aspell"
+msgstr ""
+
+#: lib/spellcheck.tcl:41
+msgid "Unrecognized aspell version"
+msgstr ""
+
+#: lib/spellcheck.tcl:135
+msgid "No Suggestions"
+msgstr ""
+
+#: lib/spellcheck.tcl:336
+msgid "Unexpected EOF from aspell"
+msgstr ""
+
+#: lib/spellcheck.tcl:340
+msgid "Spell Checker Failed"
+msgstr ""
+
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
-- 
1.5.4.2.g41ac4
