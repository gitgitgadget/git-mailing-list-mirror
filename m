From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] submodule: Fix documentation of update subcommand
Date: Mon,  3 Nov 2014 11:09:51 +0100
Message-ID: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 11:10:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlEaW-00005M-U8
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 11:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbaKCKKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 05:10:12 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:43309 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbaKCKKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 05:10:11 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 778CE5CCF27;
	Mon,  3 Nov 2014 11:10:08 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id Zd6QOr-EzYjp; Mon,  3 Nov 2014 11:10:03 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 37E3A5CCF1F;
	Mon,  3 Nov 2014 11:10:03 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1XlEaI-0003ua-Si; Mon, 03 Nov 2014 11:10:02 +0100
X-Mailer: git-send-email 2.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation says that submodule.$name.update can be overridden by
--checkout only if its value is `none`. This is not true, because both
implementation and documentation of --checkout specifies that the
override applies to all possible values.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 Documentation/git-submodule.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..84ab577 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -158,7 +158,7 @@ update::
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached unless `--rebase` or
 	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`. `none` can be overridden by specifying
+	`rebase`, `merge` or `none`. This can be overridden by specifying
 	`--checkout`. Setting the key `submodule.$name.update` to `!command`
 	will cause `command` to be run. `command` can be any arbitrary shell
 	command that takes a single argument, namely the sha1 to update to.
-- 
2.1.1
