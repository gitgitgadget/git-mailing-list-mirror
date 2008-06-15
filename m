From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 12/20] Format DeltaOfsPackedObjectLoader class
Date: Sun, 15 Jun 2008 23:45:41 +0200
Message-ID: <1213566349-25395-13-git-send-email-marek.zawirski@gmail.com>
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
 <1213566349-25395-12-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:48:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K805I-0001vQ-0g
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbYFOVr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbYFOVr1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:47:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:31273 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbYFOVr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:47:26 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958696ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aoj9lJ//AIyz/aJ0CHx+/3fwPW/ovjtXemLw8+NmRcQ=;
        b=RXA3u49+g8jgJOjjua5Lfx46ekXmq00eko3oO1dX+ZivJadqruRaqJtlBvph9qFICb
         41XsFO9V5R/tEa3hX+S+50Rr7SiqgFFxGCSAdLVTV81n9hzVf9sZfMV5lNTIiMWt7WoR
         4ZCeoUoIWug2HnBJKrG6J7aevKjwp8b5IDOnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Qcw48qbyK/MC5Ojo0sk2LsVWKC5RhAJTIsv0cjSQOloAjxh9kLml39ghpAACgkd2dB
         KsJ6amNdbZwTgYMfSkDfxVJvBn+HR/teEIpMj8jCGi++XYlm2a3oKu696aMToDDxDTcY
         f64VnLrEeMdXX6oH3MLz2RGrvJGrBIa7YtIRM=
Received: by 10.150.123.16 with SMTP id v16mr4237804ybc.5.1213566445356;
        Sun, 15 Jun 2008 14:47:25 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id s31sm15635674qbs.11.2008.06.15.14.47.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:47:24 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-12-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85137>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../jgit/lib/DeltaOfsPackedObjectLoader.java       |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java
index 75fda45..edbeef9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaOfsPackedObjectLoader.java
@@ -44,9 +44,8 @@ import java.io.IOException;
 class DeltaOfsPackedObjectLoader extends DeltaPackedObjectLoader {
 	private final long deltaBase;
 
-	DeltaOfsPackedObjectLoader(final WindowCursor curs,
-			final PackFile pr, final long offset,
-			final int deltaSz, final long base) {
+	DeltaOfsPackedObjectLoader(final WindowCursor curs, final PackFile pr,
+			final long offset, final int deltaSz, final long base) {
 		super(curs, pr, offset, deltaSz);
 		deltaBase = base;
 	}
-- 
1.5.5.1
