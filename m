From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] check-ignore: clarify treatment of tracked files
Date: Thu,  4 Dec 2014 16:23:05 +0100
Message-ID: <fbc5799c32357e8bff0c690ba7bc4cd46374684d.1417706481.git.git@drmicha.warpmail.net>
References: <5480777D.6000205@drmicha.warpmail.net>
Cc: Guilherme <guibufolo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 16:32:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwYON-0008NY-QF
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 16:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbaLDPc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 10:32:27 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59897 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753880AbaLDPc1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 10:32:27 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 04F872070F
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 10:23:06 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 04 Dec 2014 10:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=v3YsbRvlwDu3W9
	AGrPV7JnCJy1o=; b=mR1HZNheTOjSHHCO3DlZ4qxGfZS9F1C6lTH/mRQZdeTq4i
	UW7MAB84bFQD/J3IXYAGAICPF2cJsZLUCXXee6ZFoLmWjbsQXFFn2OCr9wN6EqFI
	wE32jpS2cSYKB4b3n3nkjwx6WZo2xW1VDjdnO1jI7kWzjHxNf1+gekiKRuzfE=
X-Sasl-enc: yq7t/OuVRGmvxTCjXQsHjNcteSRJyk22+xl/zNWit1Rx 1417706586
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 99307C0027E;
	Thu,  4 Dec 2014 10:23:06 -0500 (EST)
X-Mailer: git-send-email 2.2.0.rc3.286.g888a711
In-Reply-To: <5480777D.6000205@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260760>

By default, check-ignore does not list tracked files at all since
they are not subject to ignore patterns.

Make this clearer in the man page.

Reported-by: Guilherme <guibufolo@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
That really is a bit confusing. Does this help?

 Documentation/git-check-ignore.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index ee2e091..788a011 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -21,6 +21,9 @@ the exclude mechanism) that decides if the pathname is excluded or
 included.  Later patterns within a file take precedence over earlier
 ones.
 
+By default, tracked files are not shown at all since they are not
+subject to exclude rules; but see `--no-index'.
+
 OPTIONS
 -------
 -q, --quiet::
-- 
2.2.0.rc3.286.g888a711
