From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 5/6] Rename ResultDialog to PushResultDialog
Date: Wed, 27 Aug 2008 20:41:45 +0200
Message-ID: <1219862506-11075-6-git-send-email-marek.zawirski@gmail.com>
References: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-2-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-3-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-4-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-5-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 27 20:43:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPzL-0005iW-S3
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbYH0SmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbYH0SmK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:42:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:64959 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbYH0SmH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:42:07 -0400
Received: by yw-out-2324.google.com with SMTP id 9so199790ywe.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gzKPULhipvw4RUkrpqw0m0oXaFSuacyIznO3iHMUrlU=;
        b=Z39N2ZstB5DSSu2D7od7RihAKWj9+1aTBUyejunEFYluIHxJqi6fmB+qE7dV3NNOHO
         MBnIHb9sXtoRp67MxMCA+zA52zqS9xNOa5Qr/t3TT10TgBwRjeHLbZ7ooS5ddBPb+jR2
         EwISPwhDiA/DzHckuwXqxdMNnIxSEXOaZz318=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZyiQIWCjPtHBMVIFuMCMjTkewTC4PYaLAs5ZGaLiHpjd+wbnb1tz38YgSHt+YAV3jG
         VlyI6FoxdNifAUsDtRJhLLnjKUbP9FAPGATVwIi1OW8fBnFtWCi0vLUBgHMOlSU4OmNv
         JYXBT7ATgE2DOc3HqvSLSKCzUIsKWjWWLU6kI=
Received: by 10.103.168.5 with SMTP id v5mr206617muo.35.1219862525824;
        Wed, 27 Aug 2008 11:42:05 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id u9sm42319218muf.9.2008.08.27.11.42.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 11:42:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219862506-11075-5-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93920>

Let's avoid ambiguity in UIText and other places when we also use
FetchResultDialog.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../{ResultDialog.java => PushResultDialog.java}   |    4 ++--
 .../spearce/egit/ui/internal/push/PushWizard.java  |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)
 rename org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/{ResultDialog.java => PushResultDialog.java} (95%)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ResultDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultDialog.java
similarity index 95%
rename from org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ResultDialog.java
rename to org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultDialog.java
index 920494f..bace9ad 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/ResultDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultDialog.java
@@ -20,14 +20,14 @@
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.Repository;
 
-class ResultDialog extends Dialog {
+class PushResultDialog extends Dialog {
 	private final Repository localDb;
 
 	private final PushOperationResult result;
 
 	private final String destinationString;
 
-	ResultDialog(final Shell parentShell, final Repository localDb,
+	PushResultDialog(final Shell parentShell, final Repository localDb,
 			final PushOperationResult result, final String destinationString) {
 		super(parentShell);
 		setShellStyle(getShellStyle() | SWT.RESIZE);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushWizard.java
index a5c6339..b2ef5ae 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushWizard.java
@@ -238,8 +238,9 @@ protected IStatus run(final IProgressMonitor monitor) {
 							public void run() {
 								final Shell shell = PlatformUI.getWorkbench()
 										.getActiveWorkbenchWindow().getShell();
-								final Dialog dialog = new ResultDialog(shell,
-										localDb, result, destinationString);
+								final Dialog dialog = new PushResultDialog(
+										shell, localDb, result,
+										destinationString);
 								dialog.open();
 							}
 						});
-- 
1.5.6.3
