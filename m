From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] Testsuite: Unset CVS_SERVER
Date: Thu, 17 Jul 2008 19:00:26 +0200
Message-ID: <1216314030-10887-2-git-send-email-lars@public.noschinski.de>
References: <1216314030-10887-1-git-send-email-lars@public.noschinski.de>
Cc: lars@public.noschinski.de, fabian.emmes@rwth-aachen.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 17 19:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWre-0000Xh-OL
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757122AbYGQRAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 13:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760439AbYGQRAi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:00:38 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:59527 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329AbYGQRAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:00:38 -0400
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJWqK-0007Q9-9O; Thu, 17 Jul 2008 19:00:36 +0200
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216314030-10887-1-git-send-email-lars@public.noschinski.de>
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88883>

From: Fabian Emmes <fabian.emmes@rwth-aachen.de>

The CVS_SERVER environment variable can cause some of the cvsimport tests
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
