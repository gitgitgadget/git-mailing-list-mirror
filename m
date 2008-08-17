From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 24/31] Clone wizard: force dir to suggested path only if repo selection change
Date: Sun, 17 Aug 2008 22:44:05 +0200
Message-ID: <1219005852-21496-25-git-send-email-marek.zawirski@gmail.com>
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
 <1219005852-21496-24-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:48:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUpAH-0003WL-Sy
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbYHQUpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbYHQUpt
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:49 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbYHQUpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:45 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tEH4G4nJzkEcciYNzsLJp8DTn2ueC/VeBWdALEsa1WM=;
        b=bzDvFvegIuedmn/a2ClBPT2X4SGEs+lWIQDK6jKEUZ8nScSLRMpH0Nf9RQyYDh2J9M
         uE4kT9Y2eChgdzrxXcM+wr71K0C3XaE0hJGfYjM14pZNHzMzINtJEbk/HAVOGp7NNbgE
         HEdwqPhVcNZL/fpzzdhqPUWIMfyGHJggEqX38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W1S6ylHDvkYIUmi7FoGtHqO6yf19ljjyiDSCVUp5Umy6k9GyW1ouOHl1wMn+lPxpz0
         7YCPWdyHb5Tz8FWIL+TnC6n7QDkvMBsSsJu1VCmei0ev+NQUSPHEWymyD0a9o0jYKHgP
         NE0nlS5TnjTgCCWA3aZrkjKffbgY+3wG63GKg=
Received: by 10.103.213.19 with SMTP id p19mr3463928muq.70.1219005944753;
        Sun, 17 Aug 2008 13:45:44 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id t10sm468156muh.16.2008.08.17.13.45.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:43 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-24-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92658>

When user moves backward in wizard from destination page to source
branch selection, then moves forward, we shouldn't overwrite his/her
directory selection in destination page.
Let's do it only when repository selection changes.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../ui/internal/clone/CloneDestinationPage.java    |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
index 97f166a..508781d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
@@ -278,15 +278,19 @@ class CloneDestinationPage extends WizardPage {
 			checkPage();
 			return;
 		}
-		validatedRepoSelection = sourcePage.getSelection();
+		
+		if (!sourcePage.selectionEquals(validatedRepoSelection)) {
+			validatedRepoSelection = sourcePage.getSelection();
+			// update repo-related selection only if it changed
+			final String n = getSuggestedName();
+			setDescription(NLS.bind(UIText.CloneDestinationPage_description, n));
+			directoryText.setText(new File(ResourcesPlugin.getWorkspace()
+					.getRoot().getRawLocation().toFile(), n).getAbsolutePath());
+		}
+		
 		validatedSelectedBranches = branchPage.getSelectedBranches();
 		validatedHEAD = branchPage.getHEAD();
 
-		final String n = getSuggestedName();
-		setDescription(NLS.bind(UIText.CloneDestinationPage_description, n));
-		directoryText.setText(new File(ResourcesPlugin.getWorkspace().getRoot()
-				.getRawLocation().toFile(), n).getAbsolutePath());
-
 		initialBranch.removeAll();
 		final Ref head = branchPage.getHEAD();
 		int newix = 0;
-- 
1.5.6.3
