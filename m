From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t5503: fix typo
Date: Fri,  8 Oct 2010 23:03:15 +0200
Message-ID: <a4b0ff35d302b50fc403a7445134b72931894148.1286571734.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 23:03:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4K5t-0007c7-K5
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 23:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824Ab0JHVDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 17:03:03 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:44675 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759583Ab0JHVDB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 17:03:01 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4B74F30B;
	Fri,  8 Oct 2010 17:03:01 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 08 Oct 2010 17:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=vyvtJ6YAu28XCN9smBl1RVfdITM=; b=bZDRDMrmCNYIOBkHG3VKlQuusBByCVCS3pxhNUo5N1rCwn0pHsA5uCyd1R8yOG+O3h3zPg5inRDGHpTRlI/6RZWd84klKcdN59p3RJLtKKSLJeEJNFyxxMNhot/7ZihzrYW8aOeAuqn4AgDYNfqmLwOsx8fxsrOq+bMxsq0ksZE=
X-Sasl-enc: KretDYKWVMNEcGz310x3FppWtWx7qbupEzp/3CBCZix8 1286571780
Received: from localhost (p54858B44.dip0.t-ipconnect.de [84.133.139.68])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A04CC40BC53;
	Fri,  8 Oct 2010 17:03:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.1.184.g5b1fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158540>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I don't think I have a special bash, do I?

 t/t5503-tagfollow.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index b6b1fc3..aa0ada0 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -4,7 +4,7 @@ test_description='test automatic tag following'
 
 . ./test-lib.sh
 
-if !test_have_prereq NOT_MINGW; then
+if ! test_have_prereq NOT_MINGW; then
 	say "GIT_DEBUG_SEND_PACK not supported - skipping tests"
 fi
 
-- 
1.7.3.1.184.g5b1fd
