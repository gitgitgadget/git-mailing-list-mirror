From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 04/11] Documentation/rev-list: don't list date formats
Date: Thu,  3 Sep 2015 22:48:54 +0100
Message-ID: <cfc780ad4f30521a4f54eba2a96ced8e0bbfc519.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:50:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcOZ-0000ah-4B
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397AbbICVuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:50:04 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34071 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757319AbbICVuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:50:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 105E8866006;
	Thu,  3 Sep 2015 22:50:03 +0100 (BST)
X-Quarantine-ID: <xv5N+e10usUS>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xv5N+e10usUS; Thu,  3 Sep 2015 22:50:02 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 34452CDA61E;
	Thu,  3 Sep 2015 22:49:48 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277265>

We are about to add several new date formats which will make this list
too long to display in a single line.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-rev-list.txt     | 2 +-
 Documentation/rev-list-options.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 7b49c85..ef22f17 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -45,7 +45,7 @@ SYNOPSIS
 	     [ --regexp-ignore-case | -i ]
 	     [ --extended-regexp | -E ]
 	     [ --fixed-strings | -F ]
-	     [ --date=(local|relative|default|iso|iso-strict|rfc|short) ]
+	     [ --date=<format>]
 	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
 	       [ --unpacked ] ]
 	     [ --pretty | --header ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a9b808f..14c4cce 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -699,7 +699,7 @@ include::pretty-options.txt[]
 --relative-date::
 	Synonym for `--date=relative`.
 
---date=(relative|local|default|iso|iso-strict|rfc|short|raw)::
+--date=<format>::
 	Only takes effect for dates shown in human-readable format, such
 	as when using `--pretty`. `log.date` config variable sets a default
 	value for the log command's `--date` option.
-- 
2.5.0.466.g9af26fa
