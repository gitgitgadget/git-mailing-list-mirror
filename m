From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/5] Initialize sort_uniq_list using named constant
Date: Sun,  4 Nov 2012 08:07:07 +0100
Message-ID: <1352012830-13591-3-git-send-email-mhagger@alum.mit.edu>
References: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:08:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUuJJ-0001EE-QO
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 08:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab2KDHHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 02:07:33 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:43219 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750951Ab2KDHHc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 02:07:32 -0500
X-AuditID: 1207440e-b7f036d0000008b5-08-509614334e30
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 06.60.02229.33416905; Sun,  4 Nov 2012 02:07:31 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA477Hw5028486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 02:07:30 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqGssMi3AYPsmBYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xsK27YwF
	N1gqtmy/wtzA+Iq5i5GTQ0LAROJO8wsoW0ziwr31bF2MXBxCApcZJW50n2aFcM4wSayY2cYO
	UsUmoCuxqKeZCcQWEZCV+H54IyOIzSyQK7H43W2wGmEBZ4ndH9rZQGwWAVWJ/kPHgOIcHLwC
	LhJ9K60glslJfNjzCKycU8BVYsOVNhaQEiGgks639RMYeRcwMqxilEvMKc3VzU3MzClOTdYt
	Tk7My0st0jXWy80s0UtNKd3ECAkevh2M7etlDjEKcDAq8fAuXTY1QIg1say4MvcQoyQHk5Io
	r6fAtAAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxbPgOV86YkVlalFuXDpKQ5WJTEedWWqPsJ
	CaQnlqRmp6YWpBbBZGU4OJQkeL8JAQ0VLEpNT61Iy8wpQUgzcXCCCC6QDTxAGxiEgQp5iwsS
	c4sz0yGKTjEqSonzvgSZIACSyCjNgxsAi/NXjOJA/wjz/gep4gGmCLjuV0CDmYAGb780BWRw
	SSJCSqqB0ea75cGos6eY4lT4lihlNnhN8vqxkHFu0aryP2zJE3jW+ZyRF74cuPGcrOXyVeuN
	/ZjLHUp2O//MLuz+uk05mF/HwXmmUMi/JclbzWrs+z4e0a+ZP0Xj+MyOk5P3Pd2jlqdaszxe
	eHJs15FQHvNba37rX7485an33O2Nzvcz2VKm8x2svHy9SYmlOCPRUIu5qDgRAPcf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209016>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index bc454e1..8652f8f 100644
--- a/notes.c
+++ b/notes.c
@@ -901,7 +901,7 @@ static int string_list_join_lines_helper(struct string_list_item *item,
 int combine_notes_cat_sort_uniq(unsigned char *cur_sha1,
 		const unsigned char *new_sha1)
 {
-	struct string_list sort_uniq_list = { NULL, 0, 0, 1 };
+	struct string_list sort_uniq_list = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 1;
 
-- 
1.8.0
