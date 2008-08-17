From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 23/31] Allow selecting empty dir in clone wizard
Date: Sun, 17 Aug 2008 22:44:04 +0200
Message-ID: <1219005852-21496-24-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-16-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-17-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-18-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-19-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-20-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-21-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-22-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-23-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp9G-00038o-0G
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbYHQUpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbYHQUpq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:46 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbYHQUpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:42 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=a5yrXIEzdD1H89a1e1yx8uTYz+cL1RrRhmqgWOpyArs=;
        b=qHb9/HpnAGSHtQsurHSJgHJdWq8ZBfOKcdIBk4GaIOfaxg0HEVHkabL3b/8faHK+vz
         l1Pshci9hCAi2HSvSzzRI3iAC8zmn/MC7nYfNNu4m4pqgZF2kYGwWO6Rg00aOi6uu91b
         aqygEY9dtCI/rQs8VgUbqfy/xHWR5qul/ONBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BqUH/M7ml7Jbvoq3iuujBiBdsebRlamrHFHgI6kedTpQdO6QeM1619Q3ndcO1amDY9
         zOEy9VgG2+qdNTSa2H0jt9e8gisnYfmbojrDNISRd+sE7gnuBqMxVS5AwZU//pGQ1xOT
         RhYxz1s6gnrTya3a3XCGBtT7Cmh1RCriITvIU=
Received: by 10.102.218.6 with SMTP id q6mr3465539mug.127.1219005941549;
        Sun, 17 Aug 2008 13:45:41 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id y2sm679095mug.2.2008.08.17.13.45.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:40 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-23-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92646>

Previous behavior was to not allow selecting empty directory. While
it seems to be sensible to use empty dir as destination and it's just
a little bit more complex, this feature is added.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    2 +-
 .../ui/internal/clone/CloneDestinationPage.java    |   20 ++++++++++++++------
 .../egit/ui/internal/clone/GitCloneWizard.java     |    3 ++-
 .../src/org/spearce/egit/ui/uitext.properties      |    2 +-
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 9150832..189b769 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -170,7 +170,7 @@ public class UIText extends NLS {
 	public static String CloneDestinationPage_browseButton;
 
 	/** */
-	public static String CloneDestinationPage_errorExists;
+	public static String CloneDestinationPage_errorNotEmptyDir;
 
 	/** */
 	public static String Decorator_failedLazyLoading;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
index a445cf5..97f166a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
@@ -221,17 +221,17 @@ class CloneDestinationPage extends WizardPage {
 			setPageComplete(false);
 			return;
 		}
-		final File dstFile = new File(dstpath);
-		if (dstFile.exists()) {
-			setErrorMessage(NLS.bind(UIText.CloneDestinationPage_errorExists,
-					dstFile.getName()));
+		final File absoluteFile = new File(dstpath).getAbsoluteFile();
+		if (!isEmptyDir(absoluteFile)) {
+			setErrorMessage(NLS.bind(UIText.CloneDestinationPage_errorNotEmptyDir,
+					absoluteFile.getPath()));
 			setPageComplete(false);
 			return;
 		}
-		final File absoluteFile = dstFile.getAbsoluteFile();
+
 		if (!canCreateSubdir(absoluteFile.getParentFile())) {
 			setErrorMessage(NLS.bind(UIText.GitCloneWizard_errorCannotCreate,
-					dstFile.getPath()));
+					absoluteFile.getPath()));
 			setPageComplete(false);
 			return;
 		}
@@ -252,6 +252,14 @@ class CloneDestinationPage extends WizardPage {
 		setPageComplete(true);
 	}
 
+	private static boolean isEmptyDir(final File dir) {
+		if (!dir.exists())
+			return true;
+		if (!dir.isDirectory())
+			return false;
+		return dir.listFiles().length == 0;
+	}
+
 	// this is actually just an optimistic heuristic - should be named
 	// isThereHopeThatCanCreateSubdir() as probably there is no 100% reliable
 	// way to check that in Java for Windows
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
index efcf57f..10b2cd4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
@@ -66,7 +66,8 @@ public class GitCloneWizard extends Wizard implements IImportWizard {
 		final String branch = cloneDestination.getInitialBranch();
 		final String remoteName = cloneDestination.getRemote();
 
-		if (!workdir.mkdirs()) {
+		workdir.mkdirs();
+		if (!workdir.isDirectory()) {
 			final String errorMessage = NLS.bind(
 					UIText.GitCloneWizard_errorCannotCreate, workdir.getPath());
 			ErrorDialog.openError(getShell(), getWindowTitle(),
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 420b610..f46e183 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -73,7 +73,7 @@ CloneDestinationPage_promptInitialBranch=Initial branch
 CloneDestinationPage_promptRemoteName=Remote name
 CloneDestinationPage_fieldRequired={0} is required.
 CloneDestinationPage_browseButton=Browse
-CloneDestinationPage_errorExists={0} already exists.
+CloneDestinationPage_errorNotEmptyDir={0} is not an empty directory.
 
 Decorator_failedLazyLoading=Resource decorator failed to load tree contents on demand.
 QuickDiff_failedLoading=Quick diff failed to obtain file data.
-- 
1.5.6.3
