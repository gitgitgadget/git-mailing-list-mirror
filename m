From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 6/6] Fix RefSpecPage formatting
Date: Wed, 20 Aug 2008 04:57:40 +0200
Message-ID: <1219201060-4307-6-git-send-email-marek.zawirski@gmail.com>
References: <48AB84A2.7010905@gmail.com>
 <1219201060-4307-1-git-send-email-marek.zawirski@gmail.com>
 <1219201060-4307-2-git-send-email-marek.zawirski@gmail.com>
 <1219201060-4307-3-git-send-email-marek.zawirski@gmail.com>
 <1219201060-4307-4-git-send-email-marek.zawirski@gmail.com>
 <1219201060-4307-5-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 20 04:59:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVdup-0001sl-Ui
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbYHTC6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 22:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbYHTC6K
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:58:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:15858 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbYHTC6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 22:58:09 -0400
Received: by ug-out-1314.google.com with SMTP id c2so647198ugf.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bWfwr0Z1N3AiT0nV65vlmsbTYdJcP+z8u0reM3MoiGk=;
        b=PdVXJSEayjVKP72K9HIWbvZG/0yKTYZFJ0dGJGwSZ0zjWc+DEICCOa/DNNYD6EP9YN
         rOCpx1FOpxl2RZw4VOKfMoCtuVQbZLdWr19wkjx5h0vzudpSF6b8BMYKpnN3AGVRRXTd
         RzhlAESCVc2fIUclIJEvKGyfbCzy85HeG1TyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i0rxMNipGFeHqawuk5OrDzNcu45/g4UMpGipI38lcMJYh6D2OUtcKDzdGJn+F+5P0X
         RIDg3NbegwVPS0+yYwRm6oG0OQv4QPX8HeDOTHvcjbpc9RVn7uT0rP4GcqkOPydgNFyb
         9QHf0/quQmlHOP35amc1asBn4kol9ogmupOvM=
Received: by 10.103.223.20 with SMTP id a20mr5257589mur.86.1219201087519;
        Tue, 19 Aug 2008 19:58:07 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id j10sm1380884mue.17.2008.08.19.19.58.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 19:58:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219201060-4307-5-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92958>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../egit/ui/internal/components/RefSpecPage.java   |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
index b526cf3..70856ca 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
@@ -191,7 +191,8 @@ private void revalidateImpl(final RepositorySelection newRepoSelection) {
 		} catch (InvocationTargetException e) {
 			final Throwable cause = e.getCause();
 			transportError(cause.getMessage());
-			ErrorDialog.openError(getShell(), UIText.RefSpecPage_errorTransportDialogTitle,
+			ErrorDialog.openError(getShell(),
+					UIText.RefSpecPage_errorTransportDialogTitle,
 					UIText.RefSpecPage_errorTransportDialogMessage, new Status(
 							IStatus.ERROR, Activator.getPluginId(), 0, cause
 									.getMessage(), cause));
-- 
1.5.6.3
