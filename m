From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] git-replace.txt: Clarify list mode
Date: Fri, 26 Aug 2011 09:53:20 +0200
Message-ID: <0a88518db0b0db8f1a4a4deeebd6dffc2d603e74.1314345131.git.git@drmicha.warpmail.net>
References: <4E574D61.8050501@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 09:53:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwrEH-0001Uo-7Y
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 09:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab1HZHxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 03:53:23 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44790 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752855Ab1HZHxX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 03:53:23 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B7E3720BCE;
	Fri, 26 Aug 2011 03:53:22 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 26 Aug 2011 03:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=XfTNUC1an4TLXRUYesBPdJZF4
	sM=; b=AaIuy3g1jGpTTTqOxHo5wcBAUyf3nCB5Jv1gGLP1g+bgqoaN2KSITCU1g
	AYa2ZxTgl+nLJw2f/q4rTR3fEwKj/M194Bmgdlaau/MNt4o2lvqNpuiVvQ/cUn0v
	duzTEoVmJo6b99Zoar4U1ykjyQA0xqzjXSBK1xpufNH1VDZSpA=
X-Sasl-enc: kwi/97/S076IlEzFQkwEnael4z+QR9ErN2e3FS3x0Fed 1314345202
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 31A65A205E6;
	Fri, 26 Aug 2011 03:53:22 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <4E574D61.8050501@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180155>

Clarify that in list mode, "git replace" outputs the shortened ref
names, not their values.

Also, point to the difficult to find git show-ref $(git replace -l).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-replace.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 17df525..cd00837 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -61,6 +61,13 @@ OPTIONS
 	all if no pattern is given).
 	Typing "git replace" without arguments, also lists all replace
 	refs.
++
+Note that this lists the names of the replace refs, not their values
+(not their replacements). You can get the latter like this, e.g.:
+
+------------------------------------------------
+$ git show-ref $(git replace -l)
+------------------------------------------------
 
 BUGS
 ----
@@ -76,6 +83,7 @@ replaced by a commit).
 
 SEE ALSO
 --------
+linkgit:git-show-ref[1]
 linkgit:git-tag[1]
 linkgit:git-branch[1]
 linkgit:git[1]
-- 
1.7.6.845.gc3c05
