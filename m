From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-fast-import.txt: --relative-marks takes no parameter
Date: Thu,  5 May 2011 11:13:38 +0200
Message-ID: <a1f7a117ba4deff49c7462f62e1be5da500540fb.1304586800.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 11:13:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHud7-00043X-KK
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 11:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab1EEJNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 05:13:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57380 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753437Ab1EEJNo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 05:13:44 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6402120BB1
	for <git@vger.kernel.org>; Thu,  5 May 2011 05:13:43 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 05 May 2011 05:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=rsD4P4kf8lFHPKxzBuODtH9QP8E=; b=YiCbqSgTTrx4l1A0qK6EDDFmwXmVp+qrNXnHotyg1Yzl11i5IsxfHHkD69JiuGTl5jlZdWh8B71Vf4NswSugX6laZNNEX210TyTPlMi+bWybqmaydZK4Lu9J5Z45kkNctB8cR0flVBx5EihliyOn2ERlWSweJ9lnAeJDnUP6jng=
X-Sasl-enc: J0Z2WRodNrlZHsvWzBHKagFCbyupcQzgVtYUuyqQ3lYZ 1304586822
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DD0D340664E;
	Thu,  5 May 2011 05:13:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.336.g3803d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172821>

Remove spurious "=" after --relative-marks.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-fast-import.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 2c2ea12..249249a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -83,7 +83,7 @@ OPTIONS
 	skips the file if it does not exist.
 
 --relative-marks::
-	After specifying --relative-marks= the paths specified
+	After specifying --relative-marks the paths specified
 	with --import-marks= and --export-marks= are relative
 	to an internal directory in the current repository.
 	In git-fast-import this means that the paths are relative
@@ -93,7 +93,7 @@ OPTIONS
 --no-relative-marks::
 	Negates a previous --relative-marks. Allows for combining
 	relative and non-relative marks by interweaving
-	--(no-)-relative-marks= with the --(import|export)-marks=
+	--(no-)-relative-marks with the --(import|export)-marks=
 	options.
 
 --cat-blob-fd=<fd>::
-- 
1.7.5.1.336.g3803d
