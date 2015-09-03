From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 01/11] Documentation/blame-options: don't list date formats
Date: Thu,  3 Sep 2015 22:48:51 +0100
Message-ID: <d1b464560847135404dec0c7d125f5e84578c361.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:49:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcNq-0008MB-5c
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbbICVtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:49:22 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:35992 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbbICVtV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:49:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 40351CDA56A;
	Thu,  3 Sep 2015 22:49:21 +0100 (BST)
X-Quarantine-ID: <ixRHp20NIT2A>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ixRHp20NIT2A; Thu,  3 Sep 2015 22:49:20 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id F2BE2CDA5F6;
	Thu,  3 Sep 2015 22:49:06 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277262>

This list is already incomplete (missing "raw") and we're about to add
new formats.  Remove it and refer to the canonical documentation in
git-log(1).

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/blame-options.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index a09969b..760eab7 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -63,11 +63,10 @@ include::line-range-format.txt[]
 	`-` to make the command read from the standard input).
 
 --date <format>::
-	The value is one of the following alternatives:
-	{relative,local,default,iso,rfc,short}. If --date is not
+	Specifies the format used to output dates. If --date is not
 	provided, the value of the blame.date config variable is
 	used. If the blame.date config variable is also not set, the
-	iso format is used. For more information, See the discussion
+	iso format is used. For supported values, see the discussion
 	of the --date option at linkgit:git-log[1].
 
 -M|<num>|::
-- 
2.5.0.466.g9af26fa
