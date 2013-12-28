From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 10/10] Documentation/git-replace: describe --format option
Date: Sat, 28 Dec 2013 12:00:15 +0100
Message-ID: <20131228110016.2272.77703.chriscool@tuxfamily.org>
References: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 12:01:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwreP-0007zd-RP
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161Ab3L1LBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:01:18 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:34599 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755118Ab3L1LAv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:00:51 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id ADF713A;
	Sat, 28 Dec 2013 12:00:50 +0100 (CET)
X-git-sha1: 669daac1a74e39791a70a98ca2a1cd3d6d38db30 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239781>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index f373ab4..0a02f70 100644
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
+	'short', 'medium' and 'long'. When omitted, the format
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
+* 'long':
+	<replaced sha1> (<replaced type>) -> <replacement sha1> (<replacement type>)
+
 CREATING REPLACEMENT OBJECTS
 ----------------------------
 
-- 
1.8.4.1.616.g07f5c81
