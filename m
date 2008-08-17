From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 22/31] Set FileDialog selection appropriately in clone wizard
Date: Sun, 17 Aug 2008 22:44:03 +0200
Message-ID: <1219005852-21496-23-git-send-email-marek.zawirski@gmail.com>
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
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp9F-00038o-BL
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbYHQUpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754329AbYHQUpn
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:43 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbYHQUpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:38 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fe7ufhXgnM7ia4R3x+ZozNYiST7wpNqmsSKMjWuJQIM=;
        b=FEYnS0fty1Gef/zy+2Ey9atASjhfE2povBRAdq+/GYkjoV55WpRtxQxGTReTWFZ+fU
         pX+LZyFk2kmXQCkjX4+D0RFwSevgcRCuFC1+ULdpnuWO96g49tLgclILXdetW/ffgoPl
         jo64roD0ycVMXy+ylC2FWg6ncaE83pMIzua9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xFdKmBqqlEr6ve6J31nwRjAH+9+0TlGWncPNJwZwNXCfEi//ZkuT15NU+Mwid00ZPL
         gj46yvnOzyR82snz0Cx70vSAm/vI4xudUhb3ej7Je12xQ5EcGXuM7U09/yarKzcqsgCZ
         +iIXaJW9zdJbnHGGGR6grPCqFn14B59gqKJeE=
Received: by 10.103.243.9 with SMTP id v9mr3464027mur.44.1219005937955;
        Sun, 17 Aug 2008 13:45:37 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id e10sm1609744muf.14.2008.08.17.13.45.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:37 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-22-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92644>

Previous selection scheme was probably not correct, or at least not
portable. It hasn't worked on GTK+ SWT implementation.

New code still doesn't work on GTK+ SWT in Eclipse 3.3, but it works in
Eclipse 3.4. FileDialog for GTK+ in 3.3 was probably buggy. I've created
a bug at eclipse.org bugzilla for that (241824), but it won't be fixed
for 3.3.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../ui/internal/clone/CloneDestinationPage.java    |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
index e1e9858..a445cf5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
@@ -128,9 +128,10 @@ class CloneDestinationPage extends WizardPage {
 
 				d = new FileDialog(getShell(), SWT.APPLICATION_MODAL | SWT.SAVE);
 				if (directoryText.getText().length() > 0) {
-					final File f = new File(directoryText.getText());
-					d.setFilterPath(f.getAbsoluteFile().getAbsolutePath());
-					d.setFileName(f.getName());
+					final File file = new File(directoryText.getText())
+							.getAbsoluteFile();
+					d.setFilterPath(file.getParent());
+					d.setFileName(file.getName());
 				}
 				final String r = d.open();
 				if (r != null)
-- 
1.5.6.3
