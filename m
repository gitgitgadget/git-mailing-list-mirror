From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] completion: add a note that merge options are shared
Date: Thu, 22 May 2014 14:58:37 +0100
Message-ID: <e4a536d29a59d7dc89cc2f42fa8339506b4829f1.1400767118.git.john@keeping.me.uk>
References: <CANu1nikzk-rGjzKv6R-OR6Et-fB-JYnt245+P6NY-RQiihzXyA@mail.gmail.com>
Cc: Haralan Dobrev <hkdobrev@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 16:05:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnTcm-0001HH-OF
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 16:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbaEVOFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 10:05:33 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49510 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbaEVOFb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 10:05:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id B1D00606578;
	Thu, 22 May 2014 14:58:55 +0100 (BST)
X-Quarantine-ID: <kRTl7zAfR0oO>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kRTl7zAfR0oO; Thu, 22 May 2014 14:58:54 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 1FB1C606534;
	Thu, 22 May 2014 14:58:49 +0100 (BST)
X-Mailer: git-send-email 2.0.0.rc2.4.g1dc51c6
In-Reply-To: <CANu1nikzk-rGjzKv6R-OR6Et-fB-JYnt245+P6NY-RQiihzXyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249904>

This should avoid future confusion after a subsequent patch has added
some options to __git_merge_options and some directly in _git_merge().

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2c59a76..ff97c20 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1472,6 +1472,7 @@ _git_log ()
 	__git_complete_revlist
 }
 
+# Common merge options shared by git-merge(1) and git-pull(1).
 __git_merge_options="
 	--no-commit --no-stat --log --no-log --squash --strategy
 	--commit --stat --no-squash --ff --no-ff --ff-only --edit --no-edit
-- 
2.0.0.rc2.4.g1dc51c6
