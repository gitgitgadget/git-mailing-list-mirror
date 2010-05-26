From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 092/104] Documentation/gitdiffcore: fix order in pickaxe description
Date: Wed, 26 May 2010 18:01:02 +1200
Message-ID: <1274853674-18521-92-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9m4-00051a-Qv
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933990Ab0EZGGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:32 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49306 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab0EZGGX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:23 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 02:06:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 489BC33909;
	Wed, 26 May 2010 18:02:03 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EPTZq8PsALmp; Wed, 26 May 2010 18:02:01 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 4DC8033774;
	Wed, 26 May 2010 18:01:37 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147764>

From: Michael J Gruber <git@drmicha.warpmail.net>

Reverse the order of "origin" and "result" so that the sentence
really describes an addition rather than a removal.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitdiffcore.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 9de8caf..5d91a7e 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -227,8 +227,8 @@ changes that touch a specified string, and is controlled by the
 commands.
 
 When diffcore-pickaxe is in use, it checks if there are
-filepairs whose "original" side has the specified string and
-whose "result" side does not.  Such a filepair represents "the
+filepairs whose "result" side has the specified string and
+whose "origin" side does not.  Such a filepair represents "the
 string appeared in this changeset".  It also checks for the
 opposite case that loses the specified string.
 
-- 
1.7.1.rc2.333.gb2668
