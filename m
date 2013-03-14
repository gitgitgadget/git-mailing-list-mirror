From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 1/3] git-difftool(1): fix formatting of --symlink description
Date: Thu, 14 Mar 2013 20:19:39 +0000
Message-ID: <3a64f7557df368e986c2a151f04010c76532d4f9.1363291949.git.john@keeping.me.uk>
References: <cover.1363206651.git.john@keeping.me.uk>
 <cover.1363291949.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 21:20:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGEdp-0006q5-Dw
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 21:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286Ab3CNUUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 16:20:15 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:48893 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab3CNUUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 16:20:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3CCBD161E4DB;
	Thu, 14 Mar 2013 20:20:14 +0000 (GMT)
X-Quarantine-ID: <Plce6OO8EVGr>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Plce6OO8EVGr; Thu, 14 Mar 2013 20:20:13 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id EF14A161E41A;
	Thu, 14 Mar 2013 20:20:02 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.396.g36b63d6
In-Reply-To: <cover.1363291949.git.john@keeping.me.uk>
In-Reply-To: <cover.1363291949.git.john@keeping.me.uk>
References: <cover.1363291949.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218165>

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
1.8.2.396.g36b63d6
