From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] Documentation/git-rebase: fix --no-autostash formatting
Date: Thu, 10 Sep 2015 23:30:52 +0100
Message-ID: <5c846ceeefd55e3a46ed1f3937fc74bd7720a892.1441924193.git.john@keeping.me.uk>
References: <55F1EE67.3090401@thequod.de>
 <cover.1441924193.git.john@keeping.me.uk>
Cc: Daniel Hahler <genml+git-2014@thequod.de>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 00:31:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaAN5-0000a5-EX
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 00:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbbIJWbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 18:31:06 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:41678 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbIJWbF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 18:31:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 249F3866033;
	Thu, 10 Sep 2015 23:31:05 +0100 (BST)
X-Quarantine-ID: <tA+R2S5ZTnpC>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tA+R2S5ZTnpC; Thu, 10 Sep 2015 23:31:04 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4FD97866023;
	Thu, 10 Sep 2015 23:30:55 +0100 (BST)
X-Mailer: git-send-email 2.6.0.rc0.162.gb2d3693
In-Reply-To: <cover.1441924193.git.john@keeping.me.uk>
In-Reply-To: <cover.1441924193.git.john@keeping.me.uk>
References: <cover.1441924193.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277646>

All of the other "--option" and "--no-option" pairs in this file are
formatted as separate options.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-rebase.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index ca03954..72e69fc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -432,7 +432,8 @@ If the '--autosquash' option is enabled by default using the
 configuration variable `rebase.autoSquash`, this option can be
 used to override and disable this setting.
 
---[no-]autostash::
+--autostash::
+--no-autostash::
 	Automatically create a temporary stash before the operation
 	begins, and apply it after the operation ends.  This means
 	that you can run rebase on a dirty worktree.  However, use
-- 
2.6.0.rc0.162.gb2d3693
