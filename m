From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 01/12] Format PackFile class
Date: Mon,  2 Jun 2008 23:24:32 +0200
Message-ID: <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXF-0006RV-PW
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbYFBVYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbYFBVYw
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:24:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:38434 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbYFBVYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:24:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so844322fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EFcXwWJm2ZPVBYMOlIXhIq4T8//J6f7upvN3aSsduDw=;
        b=H0SRQplMacoKBM6DNDBSXV5Hp5k5LDbw+sGlWbgf8YI5cQHSlY7iXYqdccB+mPw4EuHZNRinkLnnq+VDf0npVTNYKgurY/AgxPgTu9MFFi1t9+WAOyz6c/zkTZi2SxBItt1s/oY/N/myZFAYqkQFJcp6m4N+kTEJ6wAWjdyyYbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y++OOkOaLumQefK/Fk2hexyd1gUrvHDgKzljWfqbel0IRYAVLL+A5gl4mAPGDRO6cmrbXhbTboKOceSB6dGkcil8vpZO4uOzrDDmP6BHHcLtkAjvEt2BLkJ2oQqftZ5di47JzkYlKXTluLYoHZDgl1LDX5hGI2BBnLit7WszCsU=
Received: by 10.86.79.19 with SMTP id c19mr6283970fgb.52.1212441888701;
        Mon, 02 Jun 2008 14:24:48 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 12sm5513329fgg.0.2008.06.02.14.24.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:24:48 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83564>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 23a175c..ccff47d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -45,9 +45,9 @@ import java.util.zip.DataFormatException;
 import org.spearce.jgit.util.NB;
 
 /**
- * A Git version 2 pack file representation. A pack file contains
- * Git objects in delta packed format yielding high compression of
- * lots of object where some objects are similar.
+ * A Git version 2 pack file representation. A pack file contains Git objects in
+ * delta packed format yielding high compression of lots of object where some
+ * objects are similar.
  */
 public class PackFile {
 	private static final byte[] SIGNATURE = { 'P', 'A', 'C', 'K' };
@@ -58,7 +58,7 @@ public class PackFile {
 
 	/**
 	 * Construct a reader for an existing, pre-indexed packfile.
-	 *
+	 * 
 	 * @param parentRepo
 	 *            Git repository holding this pack file
 	 * @param idxFile
@@ -188,13 +188,11 @@ public class PackFile {
 		if (idx.getObjectCount() != objectCnt)
 			throw new IOException("Pack index"
 					+ " object count mismatch; expected " + objectCnt
-					+ " found " + idx.getObjectCount() + ": "
-					+ pack.getName());
+					+ " found " + idx.getObjectCount() + ": " + pack.getName());
 	}
 
 	private PackedObjectLoader reader(final WindowCursor curs,
-			final long objOffset)
-			throws IOException {
+			final long objOffset) throws IOException {
 		long pos = objOffset;
 		int p = 0;
 		final byte[] ib = curs.tempId;
-- 
1.5.5.1
