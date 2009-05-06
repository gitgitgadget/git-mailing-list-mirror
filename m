From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/4] t4118: add missing '&&'
Date: Wed,  6 May 2009 13:29:14 -0500
Message-ID: <IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 20:29:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1lsQ-00049q-7A
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 20:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758348AbZEFS3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 14:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755975AbZEFS3e
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 14:29:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55575 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899AbZEFS32 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 14:29:28 -0400
Received: by mail.nrlssc.navy.mil id n46ITQJC016326; Wed, 6 May 2009 13:29:27 -0500
In-Reply-To: <IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 May 2009 18:29:26.0327 (UTC) FILETIME=[95E96C70:01C9CE78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118366>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t4118-apply-empty-context.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty-context.sh
index f92e259..314bc6e 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 		cat file1 &&
 		echo Q | tr -d "\\012"
 	} >file2 &&
-	cat file2 >file2.orig
+	cat file2 >file2.orig &&
 	git add file1 file2 &&
 	sed -e "/^B/d" <file1.orig >file1 &&
 	sed -e "/^[BQ]/d" <file2.orig >file2 &&
-- 
1.6.2.4.24.gde59d2
