From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 11/20] Format UnpackedObjectLoader class
Date: Sun, 15 Jun 2008 23:45:40 +0200
Message-ID: <1213566349-25395-12-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-11-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K805H-0001vQ-DK
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbYFOVr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbYFOVr0
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:47:26 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:31454 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbYFOVrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:47:25 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958678ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HH+A+X2JknY7qXgZuILfPUmj7fB8QBjj0i1NgkPAipE=;
        b=r7TqzdfIr9x5lEZ64tg2pQoA/lPaxhe8KQotrcRCgPLM5whTKGJN0CgUbbyl009mpX
         4FksYX03ZtCGp8n0gW94OYZGKKqbOS6pAqxsrt+ExzF5X1Va4MwDcI34XmON5/QajrEp
         e9hAoktNeayVMzPf00bIcbXV+O768Qw2BRrVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QPbP1j5/+8W5SmgA5pGx5CABae9Hi3q2a/h8oZYSQHcb5LsSu9ewSU62dZSsqIjpZ/
         zKHgZcGosRsCTuqldBT/JH7DCONvlwUyuMQYZZ6onP30aVRP1FnB2zcfZcniXCCmIOi1
         hJ5H4BzfSnQclehMkc+qjg+MmO2Q4FxP4Xs+U=
Received: by 10.150.82.42 with SMTP id f42mr9418546ybb.197.1213566400179;
        Sun, 15 Jun 2008 14:46:40 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id p27sm16584892qbp.15.2008.06.15.14.46.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:46:39 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-11-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85136>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
index 4e95387..a5c484b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
@@ -49,8 +49,7 @@ import org.spearce.jgit.util.MutableInteger;
 import org.spearce.jgit.util.RawParseUtils;
 
 /**
- * Loose object loader. This class loads an object not
- * stored in a pack.
+ * Loose object loader. This class loads an object not stored in a pack.
  */
 public class UnpackedObjectLoader extends ObjectLoader {
 	private final int objectType;
@@ -61,8 +60,11 @@ public class UnpackedObjectLoader extends ObjectLoader {
 
 	/**
 	 * Construct an ObjectLoader for the specified SHA-1
-	 * @param db repository
-	 * @param id SHA-1
+	 * 
+	 * @param db
+	 *            repository
+	 * @param id
+	 *            SHA-1
 	 * @throws IOException
 	 */
 	public UnpackedObjectLoader(final Repository db, final ObjectId id)
@@ -94,11 +96,13 @@ public class UnpackedObjectLoader extends ObjectLoader {
 	 *             The compressed data supplied does not match the format for a
 	 *             valid loose object.
 	 */
-	public UnpackedObjectLoader(final byte[] compressed) throws CorruptObjectException {
+	public UnpackedObjectLoader(final byte[] compressed)
+			throws CorruptObjectException {
 		this(compressed, null);
 	}
 
-	private UnpackedObjectLoader(final byte[] compressed, final ObjectId id) throws CorruptObjectException {
+	private UnpackedObjectLoader(final byte[] compressed, final ObjectId id)
+			throws CorruptObjectException {
 		setId(id);
 
 		// Try to determine if this is a legacy format loose object or
-- 
1.5.5.1
