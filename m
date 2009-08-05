From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Better usage string for reflog.
Date: Wed,  5 Aug 2009 17:36:28 +0200
Message-ID: <1249486588-12422-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 17:41:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYic8-0002Ub-Lb
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 17:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782AbZHEPlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 11:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755770AbZHEPlI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 11:41:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:36648 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755742AbZHEPlH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 11:41:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n75Faa2U014611
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 17:36:36 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MYiXc-0003lP-3z; Wed, 05 Aug 2009 17:36:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MYiXc-0003Ev-2h; Wed, 05 Aug 2009 17:36:36 +0200
X-Mailer: git-send-email 1.6.4.19.g4c7cc.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 05 Aug 2009 17:36:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124916>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin-reflog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index ddfdf5a..95198c5 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -694,7 +694,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
  */
 
 static const char reflog_usage[] =
-"git reflog (expire | ...)";
+"git reflog [ show | expire | delete ]";
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
-- 
1.6.4.19.g4c7cc.dirty
