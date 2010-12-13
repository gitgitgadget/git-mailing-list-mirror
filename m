From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC] t800?-blame.sh: retitle uniquely
Date: Mon, 13 Dec 2010 17:12:29 +0100
Message-ID: <52f777e518583955f78b71e96b3c8ff53d25b608.1292256498.git.git@drmicha.warpmail.net>
References: <4D05F1EA.9000403@viscovery.net>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 17:15:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSB3I-0001r7-19
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 17:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757743Ab0LMQO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 11:14:58 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33539 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757595Ab0LMQO5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 11:14:57 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 399B49E8;
	Mon, 13 Dec 2010 11:14:57 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 13 Dec 2010 11:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=riv9psh0WmlDgGl5cezNuE14rIo=; b=nPc3lu+59+J5RRelObUuX2gepyWen8A54Za+4EUKlxkGYCEpqeJ3oB8F1aQhnnq3ecmg6oOAU4R4vlcy/OOzFTMc0unnjdqPrKZrwxbu9I/hkjtNNE9Ui9Vqedtzy1tt4OgV+7pcuJ07VZ93lDF0jVKFzqxpfFxMFg8lQRrCmWI=
X-Sasl-enc: axuL6nxPkFD/YmQUGigZ5u3F90vZ2LqzzfTMklbr7V9l 1292256896
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 986734409A9;
	Mon, 13 Dec 2010 11:14:56 -0500 (EST)
X-Mailer: git-send-email 1.7.3.3.738.g018bc
In-Reply-To: <4D05F1EA.9000403@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163560>

Currently we have three test files matching t800?-blame.sh.

Rename the latter two to make it easier to spot where additions would
go.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
On a related note to J6t's patch, how's the stance on unique titles?
Unique numbers are important for partial test runs, of course,
but unique titles help finding you way through the test.
There are more than the blame.sh ones.

 t/{t8003-blame.sh => t8003-blame-corner-cases.sh}  |    0
 ...8004-blame.sh => t8004-blame-with-conflicts.sh} |    0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t8003-blame.sh => t8003-blame-corner-cases.sh} (100%)
 rename t/{t8004-blame.sh => t8004-blame-with-conflicts.sh} (100%)

diff --git a/t/t8003-blame.sh b/t/t8003-blame-corner-cases.sh
similarity index 100%
rename from t/t8003-blame.sh
rename to t/t8003-blame-corner-cases.sh
diff --git a/t/t8004-blame.sh b/t/t8004-blame-with-conflicts.sh
similarity index 100%
rename from t/t8004-blame.sh
rename to t/t8004-blame-with-conflicts.sh
-- 
1.7.3.3.738.g018bc
