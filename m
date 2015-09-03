From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 03/11] Documentation/git-for-each-ref: don't list date formats
Date: Thu,  3 Sep 2015 22:48:53 +0100
Message-ID: <d246532e4fbcecdf7b826added2dd88f3afe8e09.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:50:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcOQ-0000Qs-Te
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126AbbICVtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:49:53 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:57231 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756964AbbICVtt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:49:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0EA57CDA623;
	Thu,  3 Sep 2015 22:49:49 +0100 (BST)
X-Quarantine-ID: <Kv0LtrlcFKNH>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Kv0LtrlcFKNH; Thu,  3 Sep 2015 22:49:48 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 19217CDA622;
	Thu,  3 Sep 2015 22:49:34 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277264>

We are about to add a new set of supported date formats and do not want
to have to maintain the same list in several different bits of
documentation.  Refer to git-rev-list(1) which contains the full list of
supported formats.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-for-each-ref.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7f8d9a5..d062639 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -134,9 +134,8 @@ the object referred by the ref does not cause an error.  It
 returns an empty string instead.
 
 As a special case for the date-type fields, you may specify a format for
-the date by adding one of `:default`, `:relative`, `:short`, `:local`,
-`:iso8601`, `:rfc2822` or `:raw` to the end of the fieldname; e.g.
-`%(taggerdate:relative)`.
+the date by adding `:` followed by date format name (see the
+values the `--date` option to linkgit::git-rev-list[1] takes).
 
 
 EXAMPLES
-- 
2.5.0.466.g9af26fa
