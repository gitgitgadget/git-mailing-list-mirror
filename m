From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 02/11] Documentation/config: don't list date formats
Date: Thu,  3 Sep 2015 22:48:52 +0100
Message-ID: <c3c43d509e5e8497499d4804e083739cbade6e84.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:49:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcO3-000077-9s
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbbICVtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:49:36 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:52403 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbbICVtf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:49:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 31148CDA618;
	Thu,  3 Sep 2015 22:49:35 +0100 (BST)
X-Quarantine-ID: <CzlQ8Ey9K1e6>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CzlQ8Ey9K1e6; Thu,  3 Sep 2015 22:49:34 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id F358B866007;
	Thu,  3 Sep 2015 22:49:20 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277263>

This list is already incomplete (missing "raw") and we're about to add
new formats.  Since this option sets a default for git-log's --date
option, just refer to git-log(1).

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/config.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5d15ff..49f9fa8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1829,9 +1829,7 @@ log.abbrevCommit::
 log.date::
 	Set the default date-time mode for the 'log' command.
 	Setting a value for log.date is similar to using 'git log''s
-	`--date` option.  Possible values are `relative`, `local`,
-	`default`, `iso`, `rfc`, and `short`; see linkgit:git-log[1]
-	for details.
+	`--date` option.  See linkgit:git-log[1] for details.
 
 log.decorate::
 	Print out the ref names of any commits that are shown by the log
-- 
2.5.0.466.g9af26fa
