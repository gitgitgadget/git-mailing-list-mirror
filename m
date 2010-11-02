From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 10/10] git-branch.txt: mention --set-upstream as a way to change upstream configuration
Date: Tue,  2 Nov 2010 16:31:28 +0100
Message-ID: <1288711888-21528-11-git-send-email-Matthieu.Moy@imag.fr>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 02 16:36:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDIuU-0005sZ-DY
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 16:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab0KBPgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 11:36:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41690 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913Ab0KBPgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 11:36:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oA2FPPlF022944
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Nov 2010 16:25:25 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIq1-00027b-08; Tue, 02 Nov 2010 16:31:53 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIq0-0005cU-UE; Tue, 02 Nov 2010 16:31:52 +0100
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 02 Nov 2010 16:25:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA2FPPlF022944
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1289316326.11811@1VdspB6nHydv3YCSUcF6wQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160534>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-branch.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 7f23c56..9106d38 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -41,7 +41,8 @@ When a local branch is started off a remote-tracking branch, git sets up the
 branch so that 'git pull' will appropriately merge from
 the remote-tracking branch. This behavior may be changed via the global
 `branch.autosetupmerge` configuration flag. That setting can be
-overridden by using the `--track` and `--no-track` options.
+overridden by using the `--track` and `--no-track` options, and
+changed later using `git branch --set-upstream`.
 
 With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
-- 
1.7.3.2.183.g2e7b0
