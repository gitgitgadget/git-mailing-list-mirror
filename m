From: mhagger@alum.mit.edu
Subject: [PATCH 03/17] Fix formatting.
Date: Thu, 23 Aug 2012 10:10:28 +0200
Message-ID: <1345709442-16046-4-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ScV-0008JC-4R
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933704Ab2HWISS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:18:18 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:43846 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933655Ab2HWISM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:18:12 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2012 04:18:12 EDT
X-AuditID: 1207440c-b7f616d00000270b-f6-5035e59cfd3d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 55.8F.09995.C95E5305; Thu, 23 Aug 2012 04:11:08 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkV3030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:06 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqDvnqWmAwfG3yhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujJ9LXzIV
	rOeu2POula2B8ShHFyMnh4SAicS9g+cZIWwxiQv31rN1MXJxCAlcZpT4u2IrK4Rzlkni/88n
	rCBVbAJSEi8be9hBbBEBNYmJbYdYQGxmgRSJjufdYJOEgeKzni1kA7FZBFQl5vecBKvnFXCR
	OHyogwVim6LEj+9rmEFsTgFXiQXfN4H1CgHVfGy8yTyBkXcBI8MqRrnEnNJc3dzEzJzi1GTd
	4uTEvLzUIl1DvdzMEr3UlNJNjJAA4tnB+G2dzCFGAQ5GJR7eF+amAUKsiWXFlbmHGCU5mJRE
	ef89AgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Q2fB5TjTUmsrEotyodJSXOwKInzqi5R9xMS
	SE8sSc1OTS1ILYLJynBwKEnwhgIjRUiwKDU9tSItM6cEIc3EwQkiuEA28ABtUAQp5C0uSMwt
	zkyHKDrFqCglzmsCkhAASWSU5sENgMX6K0ZxoH+Eec89AariAaYJuO5XQIOZgAarXTUGGVyS
	iJCSamC0aZubN3PToujMDTyZZy05Fm//u1L86Pk3xkqn+3cGTFp/Svuyql/Xj21/5LxmrO8Q
	zNRtyVlx/LX61v+HPiVP3sxqfsPyw4Q1xo0ntv3qidv7Lf+J738etuO955f3s3u0Pdnf/Ohb
	Tp9g8dT9a8Ism++sTjvu2sCy+4x0Uj9LnNyWT5v44u11lViKMxINtZiLihMBsPMW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204120>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c |  8 ++++----
 fetch-pack.h         | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 7912d2b..cc21047 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1062,10 +1062,10 @@ static int compare_heads(const void *a, const void *b)
 struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
-		const char *dest,
-		int nr_heads,
-		char **heads,
-		char **pack_lockfile)
+		       const char *dest,
+		       int nr_heads,
+		       char **heads,
+		       char **pack_lockfile)
 {
 	struct stat st;
 	struct ref *ref_cpy;
diff --git a/fetch-pack.h b/fetch-pack.h
index 7c2069c..1dbe90f 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -18,11 +18,11 @@ struct fetch_pack_args {
 };
 
 struct ref *fetch_pack(struct fetch_pack_args *args,
-		int fd[], struct child_process *conn,
-		const struct ref *ref,
-		const char *dest,
-		int nr_heads,
-		char **heads,
-		char **pack_lockfile);
+		       int fd[], struct child_process *conn,
+		       const struct ref *ref,
+		       const char *dest,
+		       int nr_heads,
+		       char **heads,
+		       char **pack_lockfile);
 
 #endif
-- 
1.7.11.3
