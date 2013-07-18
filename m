From: =?ISO-2022-JP?B?GyRCMC1LYkxuNkxDY0w1GyhC?= 
	<devil.tamachan@gmail.com>
Subject: [PATCH 3/4] Add Git-gui Translate ("yes", "no", "ask")
Date: Fri, 19 Jul 2013 02:15:17 +0900
Message-ID: <CAPM==H+sxpvpJdvnP0vbPQmx=oM+vaQDpJOKc8Ksd+Pp=9jbjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 19:15:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzrnX-0004OM-DI
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932956Ab3GRRPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:15:19 -0400
Received: from mail-vb0-f68.google.com ([209.85.212.68]:45783 "EHLO
	mail-vb0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3GRRPS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:15:18 -0400
Received: by mail-vb0-f68.google.com with SMTP id w16so406107vbb.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Q+wLdOZ3xAHiVpaVZ1sfYsqkL/boA84RVQQYSsbyGDM=;
        b=HlsuoitZ4D9paDklISaSuH59V6eOy8SRNXEIxJjK/qSuzHb6FX+1cB7tm99w5tPjDH
         puil0i64wA+wbuqBpxBlgGGwjJqewApphIGxWHSEpmgLSSE2aaehn6pYzcrtcMV6HpsG
         mOMUe1BJqQf9fghO36AtTtCSCfE1aX/wxEhfEq8sCs7i4958jSJ0F6WiZ9DVyCrvyTib
         XUz2UdWthZsBc/w5C1Q+yCxOtuSVlNbePKL7uRyJ3gTKSSL95US6mfMbbS7WPQJs57Nx
         e0aoaX+yLumEsNUstLRqyWxWXi4SUjazkWbp0Zukm3jxiqaP5RNsLpv8nGrt+qaR5hgv
         H2QQ==
X-Received: by 10.52.171.80 with SMTP id as16mr3679374vdc.81.1374167717449;
 Thu, 18 Jul 2013 10:15:17 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Thu, 18 Jul 2013 10:15:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230705>

Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>
---
 git-gui/lib/option.tcl |  2 +-
 git-gui/po/git-gui.pot | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
index 0cf1da1..7af858c 100644
--- a/git-gui/lib/option.tcl
+++ b/git-gui/lib/option.tcl
@@ -158,7 +158,7 @@ proc do_options {} {
         {t gui.newbranchtemplate {mc "New Branch Name Template"}}
         {c gui.encoding {mc "Default File Contents Encoding"}}
         {b gui.warndetachedcommit {mc "Warn before committing to a
detached head"}}
-        {s gui.stageuntracked {mc "Staging of untracked files"} {list
"yes" "no" "ask"}}
+        {s gui.stageuntracked {mc "Staging of untracked files"} {list
[mc "yes"] [mc "no"] [mc "ask"]}}
         } {
         set type [lindex $option 0]
         set name [lindex $option 1]
diff --git a/git-gui/po/git-gui.pot b/git-gui/po/git-gui.pot
index 6ebfc94..35783ca 100644
--- a/git-gui/po/git-gui.pot
+++ b/git-gui/po/git-gui.pot
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2013-07-10 02:45+0900\n"
+"POT-Creation-Date: 2013-07-10 03:27+0900\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -1982,6 +1982,18 @@ msgstr ""
 msgid "Staging of untracked files"
 msgstr ""

+#: lib/option.tcl:161
+msgid "yes"
+msgstr ""
+
+#: lib/option.tcl:161
+msgid "no"
+msgstr ""
+
+#: lib/option.tcl:161
+msgid "ask"
+msgstr ""
+
 #: lib/option.tcl:207
 msgid "Change"
 msgstr ""
--
1.8.1.msysgit.1
