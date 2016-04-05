From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] completion: complete --cherry-mark for git log
Date: Tue,  5 Apr 2016 12:45:35 +0200
Message-ID: <e9543514ee09f7299fe61ea8a4ca73d29c3c5143.1459853119.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 12:45:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anOUS-0005rx-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 12:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757672AbcDEKpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 06:45:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56752 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756883AbcDEKpj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 06:45:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5DBE320B9A
	for <git@vger.kernel.org>; Tue,  5 Apr 2016 06:45:37 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 05 Apr 2016 06:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=jIoWnkIhdW26mY8wC4rHFr/qcwo=; b=J4CUQMBfyMqXZcgPNYxe3unDjOEH
	kgBSBESzMW89uXtUTFZvP1bH6UD/8D600pDcJF2xXV5vP6LCsXVkVzxGvsb/LlOT
	HziK2xWNvNIUK/DtACs/HfNSngc9Dy9fUCq56UzQiTkpcNh8llFp2o9HvjhVP0Yh
	wP5ZjynyNY/CteA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=jIoWnkIhdW26mY8wC4rHFr/qcw
	o=; b=mnHjakxYC2hV6vi4pkOtN+rjmYKo1xIcQ9U330eIJGm5vKgRzBUFsXU1zw
	i7SIxbAvah47JaRcn8B7c+YcrVJAvFZ6OdvWlq2LeQQDys78GqqJ4PY9GmBqADd3
	eLhudNR3HMrgfE+Q7RoxvCDNR5nd9mytNo2nR8FKiic1soMTo=
X-Sasl-enc: krhXf4sjCZFoI6uc19hMUO/K2COWfmnvdNcIBY6EDfAh 1459853137
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 00D1F680135;
	Tue,  5 Apr 2016 06:45:36 -0400 (EDT)
X-Mailer: git-send-email 2.8.1.120.g4a400c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290773>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3918c8..d87cf4d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1458,6 +1458,7 @@ _git_log ()
 			--relative-date --date=
 			--pretty= --format= --oneline
 			--show-signature
+			--cherry-mark
 			--cherry-pick
 			--graph
 			--decorate --decorate=
-- 
2.8.1.120.g4a400c2
