From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 10/10] Documentation/git-replace: describe --format option
Date: Sat, 07 Dec 2013 17:21:05 +0100
Message-ID: <20131207162106.21478.34711.chriscool@tuxfamily.org>
References: <20131207160514.21478.72966.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 17:22:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpKdq-0004rk-PH
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 17:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819Ab3LGQVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 11:21:55 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:44986 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758600Ab3LGQVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 11:21:52 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 091D361;
	Sat,  7 Dec 2013 17:21:51 +0100 (CET)
X-git-sha1: a9cc7904bfaa15e6b05db1aed77a55d056e3252a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131207160514.21478.72966.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238991>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index f373ab4..7a07828 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git replace' [-f] <object> <replacement>
 'git replace' -d <object>...
-'git replace' -l [<pattern>]
+'git replace' [--format=<format>] [-l [<pattern>]]
 
 DESCRIPTION
 -----------
@@ -70,6 +70,23 @@ OPTIONS
 	Typing "git replace" without arguments, also lists all replace
 	refs.
 
+--format=<format>::
+	When listing, use the specified <format>, which can be one of
+	'short', 'medium' and 'full'. When omitted, the format
+	defaults to 'short'.
+
+FORMATS
+-------
+
+The following format are available:
+
+* 'short':
+	<replaced sha1>
+* 'medium':
+	<replaced sha1> -> <replacement sha1>
+* 'full'
+	<replaced sha1> (<replaced type>) -> <replacement sha1> (<replacement type>)
+
 CREATING REPLACEMENT OBJECTS
 ----------------------------
 
-- 
1.8.5.1.102.g090758b
