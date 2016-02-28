From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/3] Documentation/git-config: fix --get-all description
Date: Sun, 28 Feb 2016 11:54:37 +0000
Message-ID: <77578beabdb50d696ad9155ef2e0e1847c22a9ad.1456660027.git.john@keeping.me.uk>
References: <cover.1456660027.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>, Guilherme <guibufolo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 12:55:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZzwd-0006VA-Ee
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 12:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351AbcB1LzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 06:55:23 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:36772 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975AbcB1LzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 06:55:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5F623CDA56C;
	Sun, 28 Feb 2016 11:55:21 +0000 (GMT)
X-Quarantine-ID: <r2ErpfIdZCkp>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id r2ErpfIdZCkp; Sun, 28 Feb 2016 11:55:20 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 69A6BCDA62D;
	Sun, 28 Feb 2016 11:55:11 +0000 (GMT)
X-Mailer: git-send-email 2.7.1.503.g3cfa3ac
In-Reply-To: <cover.1456660027.git.john@keeping.me.uk>
In-Reply-To: <cover.1456660027.git.john@keeping.me.uk>
References: <20160228104557.GT1766@serenity.lan> <cover.1456660027.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287772>

--get does not fail if a key is multi-valued, it returns the last value
as described in its documentation.  Clarify the description of --get-all
to avoid implying that --get does fail in this case.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-config.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e9c755f..6fc08e3 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -86,8 +86,7 @@ OPTIONS
 	found and the last value if multiple key values were found.
 
 --get-all::
-	Like get, but does not fail if the number of values for the key
-	is not exactly one.
+	Like get, but returns all values for a multi-valued key.
 
 --get-regexp::
 	Like --get-all, but interprets the name as a regular expression and
-- 
2.7.1.503.g3cfa3ac
