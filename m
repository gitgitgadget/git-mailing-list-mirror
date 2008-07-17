From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] Testsuite: Unset CVS_SERVER
Date: Thu, 17 Jul 2008 12:01:13 +0200
Message-ID: <1216288877-12140-2-git-send-email-lars@public.noschinski.de>
References: <1216288877-12140-1-git-send-email-lars@public.noschinski.de>
Cc: fabian.emmes@rwth-aachen.de,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 12:11:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJQSQ-00074m-99
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 12:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929AbYGQKKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 06:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755595AbYGQKKb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 06:10:31 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:47660 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbYGQKKa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 06:10:30 -0400
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJQIb-0007y9-OW; Thu, 17 Jul 2008 12:01:21 +0200
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216288877-12140-1-git-send-email-lars@public.noschinski.de>
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88829>

From: Fabian Emmes <fabian.emmes@rwth-aachen.de>

The CVS_SERVER environment variable cane cause some of the cvsimport tests
to fail. So unset this variable at the beginning of the test script.

Signed-off-by: Fabian Emmes <fabian.emmes@rwth-aachen.de>
Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 t/t9600-cvsimport.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 1e01e5c..0d7786a 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -5,6 +5,7 @@ test_description='git-cvsimport basic tests'
 
 CVSROOT=$(pwd)/cvsroot
 export CVSROOT
+unset CVS_SERVER
 # for clean cvsps cache
 HOME=$(pwd)
 export HOME
-- 
1.5.6.2
