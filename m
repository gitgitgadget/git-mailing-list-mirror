From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] diff-options.txt: describe --stat-{width,name-width,count}
Date: Tue,  3 May 2011 12:46:39 +0200
Message-ID: <ee73b430a470b85e18f7577f496da4e955810eae.1304419588.git.git@drmicha.warpmail.net>
References: <7vmxj6s22r.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 12:46:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHD80-0006lp-5Z
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 12:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab1ECKqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 06:46:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45492 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751884Ab1ECKqo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 06:46:44 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2B1FD208BD;
	Tue,  3 May 2011 06:46:44 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 03 May 2011 06:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Gs9PZamhlyTkrmGBdJDQeZ76oVI=; b=TcctTUwdKObiLhijBL+s/UZtnTAFtB5F0Ceifgievib9M6vW/EpNXajMZF7GqvpFQoDNPx7HIH6/RhQTbkMrxBL+OAPr0lRkvNOswu4TbaqMUK9mC3QCk69gjD7+eXw0X2CySk7BoUKGK3YfOj/1SQ+JnWeC1LQlchmR1T79iFI=
X-Sasl-enc: WcINcb10vVakM+QAYFxacD4TLIvVeB3k2KC65s/b16DB 1304419603
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9DB9140AD18;
	Tue,  3 May 2011 06:46:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.250.g4493b
In-Reply-To: <7vmxj6s22r.fsf@alter.siamese.dyndns.org>
In-Reply-To: <102e117f7a9f7fd6e652f23d5630db973e8e52b8.1304419588.git.git@drmicha.warpmail.net>
References: <102e117f7a9f7fd6e652f23d5630db973e8e52b8.1304419588.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172656>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/diff-options.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 000eae0..f6c046a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -56,6 +56,9 @@ endif::git-format-patch[]
 	By giving a third parameter `<count>`, you can limit the
 	output to the first `<count>` lines, followed by
 	`...` if there are more.
++
+These parameters can also be set individually with `--stat-width=<width>`,
+`--stat-name-width=<name-width>` and `--stat-count=<count>`.
 
 --numstat::
 	Similar to `\--stat`, but shows number of added and
-- 
1.7.5.250.g4493b
