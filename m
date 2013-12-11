From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 10/10] Documentation/git-replace: describe --format option
Date: Wed, 11 Dec 2013 08:46:13 +0100
Message-ID: <20131211074614.11117.46781.chriscool@tuxfamily.org>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 08:48:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqeWn-00085k-T7
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 08:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab3LKHsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 02:48:01 -0500
Received: from [194.158.98.45] ([194.158.98.45]:37601 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751300Ab3LKHrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 02:47:51 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id A692B50;
	Wed, 11 Dec 2013 08:47:30 +0100 (CET)
X-git-sha1: 42b0013d71b3499a7b2b08f02fe96c71f261bc3e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239179>

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
