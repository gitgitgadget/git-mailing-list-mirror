From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2] Fix invalid menubar and toolbar entries in plugin.xml
Date: Fri, 15 Aug 2008 00:07:21 +0200
Message-ID: <48A4AC99.7080303@gmail.com>
References: <48A3310A.8080306@gmail.com> <200808141942.55448.robin.rosenberg.lists@dewire.com> <48A483EF.10508@gmail.com> <200808142242.20476.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 00:08:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTkzk-00064O-CH
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbYHNWHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 18:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbYHNWHd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:07:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:58907 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbYHNWHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:07:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so452682nfc.21
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=aa8/vppQOFovLcVtTg7PmNkyd5x5G5uo0MPvLCCUCV4=;
        b=IUf0pcyFiYWKmAw1cPYLq4knoxjrEvAFhnrLNDWgfDoZeCKRTPSTmtccr5w/WLcFjd
         a1g6Rb2ZHE/mthf0Zy1VE3uEAQgcLznO8bQdcKPGfwxrqbnG+7iNROOmJaeJbHyHjKii
         v1RDaFUEC00yQd5JRU+KPXLwN+Y3VMM3g5t40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kurF/NMCDetY04NJJhDYuvMYjz4koTna7Kb4WI3LCl+zoLpzydHcyocybOHqggCshd
         xyZwLpTSizE6bgGJqHdmbgotW9xSbxVpbq1lUm6OkHpDnGE2uryMEpdRpRNRgMsxkf4Q
         blGRYhIKDN5/e3HXaUFihzEBRB/rBsf7SG4Go=
Received: by 10.210.123.2 with SMTP id v2mr2035964ebc.141.1218751650935;
        Thu, 14 Aug 2008 15:07:30 -0700 (PDT)
Received: from ?192.168.1.20? ( [84.202.12.123])
        by mx.google.com with ESMTPS id c22sm2370380ika.1.2008.08.14.15.07.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 15:07:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <200808142242.20476.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92413>

The default toolbar is identified by the path 'Normal',
and we use the default group, named by 'additions'.

Also, renamed the action set label to be consistent with
what the other platform plugins do (no 'actions' postfix).

Signed-off-by: Tor Arne Vestb=F8 <torarnv@gmail.com>
---
 org.spearce.egit.ui/plugin.properties |    2 +-
 org.spearce.egit.ui/plugin.xml        |   23 +++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.u=
i/plugin.properties
index 3240ec0..ce3b058 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -41,7 +41,7 @@ ResetAction_tooltip=3DReset the current branch to the=
 same or another commit
 BranchAction_label=3D&Branch...
 BranchAction_tooltip=3DSwitch to another branch
=20
-GitActions_label=3DGit actions
+GitActions_label=3DGit
 GitMenu_label=3D&Git
=20
=20
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugi=
n.xml
index b809300..0b59a6e 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -241,13 +241,16 @@
 	    description=3D"Common things to do with Git"
 	    id=3D"org.spearce.egit.ui.gitaction"
 	    label=3D"%GitActions_label"
-	    visible=3D"true"
+	    visible=3D"false"
 	    >
 	    <menu
            id=3D"org.spearce.egit.ui.gitmenu"
            label=3D"%GitMenu_label"
-           path=3D"org.spearce.egit.ui.gitmenu"
+           path=3D"additions"
            >
+        <separator
+              name=3D"repositoryGroup">
+        </separator>
 	    </menu>
 		<action
 		       class=3D"org.spearce.egit.ui.internal.actions.BranchAction"
@@ -256,8 +259,8 @@
 		       id=3D"org.spearce.egit.ui.actionbranch"
 		       label=3D"%BranchAction_label"
 		       style=3D"push"
-		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repo"
-		       toolbarPath=3D"org.spearce.egit.ui"
+		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repositoryGroup"
+		       toolbarPath=3D"Normal/additions"
 		       tooltip=3D"%BranchAction_tooltip">
 		</action>
 		<action
@@ -267,8 +270,8 @@
 		       id=3D"org.spearce.egit.ui.actioncommit"
 		       label=3D"%CommitAction_label"
 		       style=3D"push"
-		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repo"
-		       toolbarPath=3D"org.spearce.egit.ui"
+		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repositoryGroup"
+		       toolbarPath=3D"Normal/additions"
 		       tooltip=3D"%CommitAction_tooltip">
 		</action>
 		<action
@@ -278,8 +281,8 @@
 		       id=3D"org.spearce.egit.ui.actionreset"
 		       label=3D"%ResetAction_label"
 		       style=3D"push"
-		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repo"
-		       toolbarPath=3D"org.spearce.egit.ui"
+		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repositoryGroup"
+		       toolbarPath=3D"Normal/additions"
 		       tooltip=3D"%ResetAction_tooltip">
 		</action>
 		<action
@@ -288,9 +291,9 @@
 		       icon=3D"icons/toolbar/tracke.png"
 		       id=3D"org.spearce.egit.ui.trackaction"
 		       label=3D"%TrackAction_label"
-		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repo"
 		       style=3D"push"
-		       toolbarPath=3D"org.spearce.egit.ui"
+		       menubarPath=3D"org.spearce.egit.ui.gitmenu/repositoryGroup"
+		       toolbarPath=3D"Normal/additions"
 		       tooltip=3D"Start tracking the selected resources">
 		</action>
       </actionSet>
--=20
1.5.6.5
