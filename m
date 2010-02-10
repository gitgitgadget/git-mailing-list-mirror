From: Francois Marier <fmarier@gmail.com>
Subject: [PATCH] git-archive documentation: .gitattributes must be committed
Date: Wed, 10 Feb 2010 15:51:24 +1300
Message-ID: <1265770284-14830-1-git-send-email-fmarier@gmail.com>
Cc: Francois Marier <fmarier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 03:59:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf2nS-0006Da-EA
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 03:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab0BJC6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 21:58:23 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:54352 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab0BJC6W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 21:58:22 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2010 21:58:22 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 936A532EF4;
	Wed, 10 Feb 2010 15:51:40 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fuD5dgbpYcB1; Wed, 10 Feb 2010 15:51:40 +1300 (NZDT)
Received: from isafjordur (leibniz.catalyst.net.nz [202.78.240.7])
	(Authenticated sender: francois)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 73CB6328E3;
	Wed, 10 Feb 2010 15:51:40 +1300 (NZDT)
Received: by isafjordur (Postfix, from userid 1000)
	id 3D2045B436E; Wed, 10 Feb 2010 15:51:40 +1300 (NZDT)
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139476>

Add a note to the documentation stating that the .gitattributes
file must be present (i.e. committed) in the named tree that is
exported.

This can be a bit confusing because it's different from .gitignore
which takes effect as soon as the file is created.

Signed-off-by: Francois Marier <fmarier@gmail.com>
---
 Documentation/git-archive.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 799c8b6..fcd681d 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -112,6 +112,9 @@ export-subst::
 	expand several placeholders when adding this file to an archive.
 	See linkgit:gitattributes[5] for details.
 
+The .gitattributes file must be present in the named tree for it to take
+effect. Uncommitted attributes will not be considered in exports.
+
 EXAMPLES
 --------
 git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)::
-- 
1.6.6.1
