From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 091/104] Documentation: fix minor inconsistency
Date: Wed, 26 May 2010 18:01:01 +1200
Message-ID: <1274853674-18521-91-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lj-0004ff-RK
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934068Ab0EZGGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:51 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49312 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933953Ab0EZGG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id C13E23391A;
	Wed, 26 May 2010 18:02:10 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IaShdPg-XYAq; Wed, 26 May 2010 18:02:01 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 386B3338D8;
	Wed, 26 May 2010 18:01:37 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147756>

From: Michael J Gruber <git@drmicha.warpmail.net>

While we don't always write out commands in full (`git command`) we
should do it consistently in adjacent paragraphs.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8f86050..c3ebd4d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1516,7 +1516,7 @@ receive.denyDeletes::
 	the ref. Use this to prevent such a ref deletion via a push.
 
 receive.denyCurrentBranch::
-	If set to true or "refuse", receive-pack will deny a ref update
+	If set to true or "refuse", git-receive-pack will deny a ref update
 	to the currently checked out branch of a non-bare repository.
 	Such a push is potentially dangerous because it brings the HEAD
 	out of sync with the index and working tree. If set to "warn",
-- 
1.7.1.rc2.333.gb2668
