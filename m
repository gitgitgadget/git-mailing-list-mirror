From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/4] completion: add some missing options to `git push`
Date: Sat, 19 Jul 2014 10:45:56 +0100
Message-ID: <b7908d70349de0c542c44b4dc0dae5e10c60a2de.1405763157.git.john@keeping.me.uk>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 11:46:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8RDr-0007zI-Hr
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 11:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757852AbaGSJqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 05:46:23 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:59221 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757595AbaGSJqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 05:46:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 72BA8CDA3A8;
	Sat, 19 Jul 2014 10:46:22 +0100 (BST)
X-Quarantine-ID: <pAx8pZ3l1bDE>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pAx8pZ3l1bDE; Sat, 19 Jul 2014 10:46:21 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 0B513CDA54D;
	Sat, 19 Jul 2014 10:46:15 +0100 (BST)
X-Mailer: git-send-email 2.0.1.472.g6f92e5f.dirty
In-Reply-To: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
In-Reply-To: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253873>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 06211a6..9dcc222 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1645,6 +1645,7 @@ _git_push ()
 	--*)
 		__gitcomp "
 			--all --mirror --tags --dry-run --force --verbose
+			--quiet --prune --delete --follow-tags
 			--receive-pack= --repo= --set-upstream
 			--recurse-submodules=
 		"
-- 
2.0.1.472.g6f92e5f.dirty
