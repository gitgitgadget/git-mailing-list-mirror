From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 2/3] completion: add some missing options to `git push`
Date: Tue, 22 Jul 2014 19:24:57 +0100
Message-ID: <648e0ae1853932105fb5fb7f718010d62a2d8bac.1406053442.git.john@keeping.me.uk>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
 <8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 20:30:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9epN-0008Fj-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 20:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453AbaGVSaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 14:30:10 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:33034 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbaGVSaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 14:30:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 6529422F28;
	Tue, 22 Jul 2014 19:30:07 +0100 (BST)
X-Quarantine-ID: <Pk9o7MBPj1pQ>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Pk9o7MBPj1pQ; Tue, 22 Jul 2014 19:29:57 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id E27AE21EB8;
	Tue, 22 Jul 2014 19:25:12 +0100 (BST)
X-Mailer: git-send-email 2.0.1.472.g6f92e5f.dirty
In-Reply-To: <8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
In-Reply-To: <8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
References: <8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254029>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bed3665..33a4962 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1644,6 +1644,7 @@ _git_push ()
 	--*)
 		__gitcomp "
 			--all --mirror --tags --dry-run --force --verbose
+			--quiet --prune --delete --follow-tags
 			--receive-pack= --repo= --set-upstream
 			--recurse-submodules=
 		"
-- 
2.0.1.472.g6f92e5f.dirty
