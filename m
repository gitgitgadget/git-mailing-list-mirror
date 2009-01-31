From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] fix typo
Date: Sat, 31 Jan 2009 15:26:07 +0100
Message-ID: <1233411967.8213.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 15:27:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTGor-00016s-T4
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 15:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbZAaO0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 09:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbZAaO0M
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 09:26:12 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:36527 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbZAaO0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 09:26:12 -0500
Received: by fxm13 with SMTP id 13so690866fxm.13
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=nOXyA1T8MbMEnsRfJ6Muh4zh/OcGUUy/PQKtALpwBeg=;
        b=dOJMrCBDR3R1B9+yrR5Nrj44k4WmGYeQGcx7rw6IMGhEg8SMndDk9R/q1cS+jXBYtT
         w0XnwQemV4hWDpbxkTtC1y64ts9/Om45mCtbL2HWeijQF59IqgfQxjkffpjtZxhKlfPz
         mb2yJR6cjITaprPOTWvtGkN26+fA14oYsyCcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=bdLxIo63dUbZoZs1bVG1gPLinPG/pyCyYkLcVSQdFn/q7Mksj2BLfOS1qPgfIwrB+9
         OYs7B1BpmA636W7N2H03Lg5ivtRBMsTP5N46kAKyy1P2VjDyylfguVXGYWE79YYzMxF6
         mfcz0KQowu07W6mSPCX1Vbl1CRJOBxBq3C4ag=
Received: by 10.103.171.6 with SMTP id y6mr1057365muo.31.1233411970230;
        Sat, 31 Jan 2009 06:26:10 -0800 (PST)
Received: from ?85.178.76.63? (e178076063.adsl.alicedsl.de [85.178.76.63])
        by mx.google.com with ESMTPS id 23sm3649749mum.52.2009.01.31.06.26.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jan 2009 06:26:09 -0800 (PST)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107927>

fix a little typo
Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 5eb8465..1ff8caa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -61,7 +61,7 @@
  * before any single byte can be accessed.
  * </p>
  * <p>
- * Using a specific MapMode will avoid the complete copy by mmaping in
the
+ * Using a specific MapMode will avoid the complete copy by mapping in
the
  * operating system's file buffers, however this may cause problems if
a large
  * number of windows are being heavily accessed as the Java garbage
collector
  * may not be able to unmap old windows fast enough to permit new
windows to be
-- 
1.6.0.6
