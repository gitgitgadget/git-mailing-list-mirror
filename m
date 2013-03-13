From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] git-difftool(1): fix formatting of --symlink description
Date: Wed, 13 Mar 2013 20:33:08 +0000
Message-ID: <926d8f9458ffcce9c3883c2b4ec7a220e268eba2.1363206651.git.john@keeping.me.uk>
References: <7vy5dr14mc.fsf@alter.siamese.dyndns.org>
 <cover.1363206651.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 21:34:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFsNc-0005Tn-BF
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 21:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933237Ab3CMUeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 16:34:06 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:59614 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178Ab3CMUeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 16:34:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id C5FCF22FD3;
	Wed, 13 Mar 2013 20:34:03 +0000 (GMT)
X-Quarantine-ID: <0uqH1RCT33pK>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0uqH1RCT33pK; Wed, 13 Mar 2013 20:33:58 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id AD23222FE0;
	Wed, 13 Mar 2013 20:33:48 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.rc2.4.g7799588
In-Reply-To: <cover.1363206651.git.john@keeping.me.uk>
In-Reply-To: <cover.1363206651.git.john@keeping.me.uk>
References: <cover.1363206651.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218090>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-difftool.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index e0e12e9..e575fea 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -74,8 +74,8 @@ with custom merge tool commands and has the same value as `$MERGED`.
 	'git difftool''s default behavior is create symlinks to the
 	working tree when run in `--dir-diff` mode.
 +
-	Specifying `--no-symlinks` instructs 'git difftool' to create
-	copies instead.  `--no-symlinks` is the default on Windows.
+Specifying `--no-symlinks` instructs 'git difftool' to create copies
+instead.  `--no-symlinks` is the default on Windows.
 
 -x <command>::
 --extcmd=<command>::
-- 
1.8.2.rc2.4.g7799588
