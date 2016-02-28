From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/3] Documentation/git-config: use bulleted list for exit codes
Date: Sun, 28 Feb 2016 11:54:36 +0000
Message-ID: <0b2892dfb713596f3b509c8d4d3f0f31bdd56cdf.1456660027.git.john@keeping.me.uk>
References: <cover.1456660027.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>, Guilherme <guibufolo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 12:55:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZzwV-0006Sh-GR
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 12:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757304AbcB1LzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 06:55:13 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:36660 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975AbcB1LzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 06:55:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 12D44CDA64A;
	Sun, 28 Feb 2016 11:55:12 +0000 (GMT)
X-Quarantine-ID: <ujJxfBIaFVQd>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ujJxfBIaFVQd; Sun, 28 Feb 2016 11:55:11 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B7D14CDA62D;
	Sun, 28 Feb 2016 11:55:02 +0000 (GMT)
X-Mailer: git-send-email 2.7.1.503.g3cfa3ac
In-Reply-To: <cover.1456660027.git.john@keeping.me.uk>
In-Reply-To: <cover.1456660027.git.john@keeping.me.uk>
References: <20160228104557.GT1766@serenity.lan> <cover.1456660027.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287770>

Using a numbered list is confusing because the exit codes are not listed
in order so the numbers at the start of each line do not match the exit
codes described by the following text.  Switch to a bulleted list so
that the only number appearing on each line is the exit code described.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-config.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 2a04e87..e9c755f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -58,13 +58,13 @@ that location (you can say '--local' but that is the default).
 This command will fail with non-zero status upon error.  Some exit
 codes are:
 
-. The config file is invalid (ret=3),
-. can not write to the config file (ret=4),
-. no section or name was provided (ret=2),
-. the section or key is invalid (ret=1),
-. you try to unset an option which does not exist (ret=5),
-. you try to unset/set an option for which multiple lines match (ret=5), or
-. you try to use an invalid regexp (ret=6).
+- The config file is invalid (ret=3),
+- can not write to the config file (ret=4),
+- no section or name was provided (ret=2),
+- the section or key is invalid (ret=1),
+- you try to unset an option which does not exist (ret=5),
+- you try to unset/set an option for which multiple lines match (ret=5), or
+- you try to use an invalid regexp (ret=6).
 
 On success, the command returns the exit code 0.
 
-- 
2.7.1.503.g3cfa3ac
