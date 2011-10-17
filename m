From: mhagger@alum.mit.edu
Subject: [PATCH v2 08/14] add_ref(): add docstring
Date: Mon, 17 Oct 2011 09:39:17 +0200
Message-ID: <1318837163-27112-9-git-send-email-mhagger@alum.mit.edu>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:40:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhnl-0007mH-R7
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab1JQHjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:39:55 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33583 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab1JQHjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:39:40 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhb-0000eM-PG; Mon, 17 Oct 2011 09:33:39 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183778>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index af34c3b..ea0f598 100644
--- a/refs.c
+++ b/refs.c
@@ -54,6 +54,7 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	return line;
 }
 
+/* Add a ref_entry to the end of the ref_array (unsorted). */
 static void add_ref(const char *refname, const unsigned char *sha1,
 		    int flag, struct ref_array *refs,
 		    struct ref_entry **new_entry)
-- 
1.7.7.rc2
