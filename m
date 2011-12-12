From: mhagger@alum.mit.edu
Subject: [PATCH v2 07/51] add_ref(): add docstring
Date: Mon, 12 Dec 2011 06:38:14 +0100
Message-ID: <1323668338-1764-8-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycZ-0000Sq-2W
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab1LLFjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:51 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34572 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab1LLFjl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:41 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aK015577;
	Mon, 12 Dec 2011 06:39:26 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186834>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 1975792..2252c66 100644
--- a/refs.c
+++ b/refs.c
@@ -53,6 +53,7 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	return line;
 }
 
+/* Add a ref_entry to the end of the ref_array (unsorted). */
 static void add_ref(const char *refname, const unsigned char *sha1,
 		    int flag, int check_name, struct ref_array *refs,
 		    struct ref_entry **new_entry)
-- 
1.7.8
