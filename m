From: Johan Sageryd <j@1616.se>
Subject: [PATCH] Documentation/revisions: Document shorthand
Date: Tue, 28 Jun 2011 23:45:10 +0200
Message-ID: <1309297510-53962-1-git-send-email-j416@1616.se>
Cc: Johan Sageryd <j416@1616.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 23:46:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbg6Y-0006yP-Qm
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 23:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab1F1Vpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 17:45:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33877 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab1F1Vpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 17:45:52 -0400
Received: by bwd5 with SMTP id 5so533979bwd.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 14:45:51 -0700 (PDT)
Received: by 10.204.77.104 with SMTP id f40mr55508bkk.30.1309297550989;
        Tue, 28 Jun 2011 14:45:50 -0700 (PDT)
Received: from localhost.localdomain (c213-89-102-157.bredband.comhem.se [213.89.102.157])
        by mx.google.com with ESMTPS id k16sm553864bks.13.2011.06.28.14.45.49
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 14:45:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176421>

Signed-off-by: Johan Sageryd <j416@1616.se>
---
 Documentation/revisions.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index b290b61..180ef5a 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -105,7 +105,7 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
   commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
   equivalent to '<rev>{caret}{caret}{caret}' which is equivalent to
   '<rev>{caret}1{caret}1{caret}1'.  See below for an illustration of
-  the usage of this form.
+  the usage of this form. '<rev>{tilde}' is a shorthand for '<rev>{tilde}1'.
 
 '<rev>{caret}\{<type>\}', e.g. 'v0.99.8{caret}\{commit\}'::
   A suffix '{caret}' followed by an object type name enclosed in
-- 
1.7.6
