From: mhagger@alum.mit.edu
Subject: [PATCH v3 07/14] parse_ref_line(): add docstring
Date: Fri, 28 Oct 2011 13:14:34 +0200
Message-ID: <1319800481-15138-8-git-send-email-mhagger@alum.mit.edu>
References: <1319800481-15138-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:15:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkPE-0004tB-Lc
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab1J1LPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:15:08 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:54711 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab1J1LPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:15:06 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkIZ-00076m-4S; Fri, 28 Oct 2011 13:08:31 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319800481-15138-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184347>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index d3dcb3c..963291f 100644
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
1.7.7
