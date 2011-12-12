From: mhagger@alum.mit.edu
Subject: [PATCH v2 06/51] parse_ref_line(): add docstring
Date: Mon, 12 Dec 2011 06:38:13 +0100
Message-ID: <1323668338-1764-7-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycY-0000Sq-05
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab1LLFjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:48 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34569 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab1LLFjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:40 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aJ015577;
	Mon, 12 Dec 2011 06:39:24 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186828>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index d7d422f..1975792 100644
--- a/refs.c
+++ b/refs.c
@@ -20,6 +20,11 @@ struct ref_array {
 	struct ref_entry **refs;
 };
 
+/*
+ * Parse one line from a packed-refs file.  Write the SHA1 to sha1.
+ * Return a pointer to the refname within the line (null-terminated),
+ * or NULL if there was a problem.
+ */
 static const char *parse_ref_line(char *line, unsigned char *sha1)
 {
 	/*
-- 
1.7.8
