From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 02/12] Format PackIndex class
Date: Mon,  2 Jun 2008 23:24:33 +0200
Message-ID: <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:25:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXG-0006RV-CX
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbYFBVYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYFBVYz
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:24:55 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:45136 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbYFBVYx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:24:53 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1247612mue.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zhIBCNkm+TgebNBgCsGCTMHLjNbDAtBScV+inBggyHQ=;
        b=VtyqYcZWMUChaZt0Rz4KKecu+WzjRzPh1OOQyBJmtUvdsStySj18O4e/Yo4Cl84rKlCO2fUaRJWvzS66msbBI+dvUx+Rl7eZotwnWkDlqWdRBAGIyHa6AcxzsqE2l3mZSBr1ItUiipclKLXQVGURNP3ZyJFe4klWvUkts5a5jyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jTS/HKn4YXPPI8Qubf1Nr1vuFettmgvw8F61FPR1gbTBdACDFwp7qW8KoHppb4qD+InUPHKKpeTSe5ok4xnmeLv9uxAbu5KEkGN2JTOPFlpux2lf7CUCQVY9t6i9dG4Lnh19XRE9uCsRXZ69jxjp/BxTqoIhpS9usjedsuU0o7g=
Received: by 10.103.228.12 with SMTP id f12mr5762104mur.28.1212441892007;
        Mon, 02 Jun 2008 14:24:52 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id w5sm21297762mue.11.2008.06.02.14.24.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:24:51 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83565>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackIndex.java        |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
index 5834ca6..104c361 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
@@ -61,7 +61,7 @@ public abstract class PackIndex {
 	 * implementation for that format will be constructed and returned to the
 	 * caller. The file may or may not be held open by the returned instance.
 	 * </p>
-	 *
+	 * 
 	 * @param idxFile
 	 *            existing pack .idx to read.
 	 * @return access implementation for the requested file.
@@ -118,7 +118,7 @@ public abstract class PackIndex {
 
 	/**
 	 * Obtain the total number of objects described by this index.
-	 *
+	 * 
 	 * @return number of objects in this index, and likewise in the associated
 	 *         pack that this index was generated from.
 	 */
@@ -126,7 +126,7 @@ public abstract class PackIndex {
 
 	/**
 	 * Locate the file offset position for the requested object.
-	 *
+	 * 
 	 * @param objId
 	 *            name of the object to locate within the pack.
 	 * @return offset of the object's header and compressed content; -1 if the
-- 
1.5.5.1
