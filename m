From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 10/10] git-branch.txt: mention --set-upstream as a way to change upstream configuration
Date: Thu, 28 Oct 2010 20:21:57 +0200
Message-ID: <1288290117-6734-11-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 28 20:27:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBXCI-0007dG-B3
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934029Ab0J1S13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:27:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:55404 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933945Ab0J1S12 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:27:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9SIN0O5002440
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 28 Oct 2010 20:23:00 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PBX7s-0003kk-4H; Thu, 28 Oct 2010 20:23:00 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PBX7s-0001m5-1p; Thu, 28 Oct 2010 20:23:00 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 28 Oct 2010 20:23:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160200>


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
