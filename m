From: mhagger@alum.mit.edu
Subject: [PATCH v2 03/17] Fix formatting.
Date: Sat, 25 Aug 2012 08:44:13 +0200
Message-ID: <1345877067-11841-4-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:52:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5AEB-0001ZC-HF
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab2HYGwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:52:10 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:44813 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753586Ab2HYGwH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:52:07 -0400
X-AuditID: 1207440f-b7fde6d00000095c-e2-5038746fd256
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id AB.C4.02396.F6478305; Sat, 25 Aug 2012 02:45:03 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSe011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:01 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqJtfYhFg8GS6uUXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M34ufclUsJ67Ys+7VrYGxqMcXYycHBICJhI3lj1jgbDFJC7cW8/WxcjFISRwmVGi5fk0
	KOcsk8TNJ+uYQKrYBKQkXjb2sIPYIgJqEhPbDrGAFDELdDFKLF/3iw0kISygKdHx9AAriM0i
	oCpxqXMa2ApeAReJ99dXQ61TlPjxfQ0ziM0p4Cox4ddFsKFCQDVNx66wTGDkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJKj4dzB2rZc5xCjAwajEw3vjjHmAEGti
	WXFl7iFGSQ4mJVFesUKLACG+pPyUyozE4oz4otKc1OJDjBIczEoivN8ZgHK8KYmVValF+TAp
	aQ4WJXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4OJQne78VAjYJFqempFWmZOSUIaSYOThDBBbKB
	B2jDXZBC3uKCxNzizHSIolOMilLivKdAEgIgiYzSPLgBsPh/xSgO9I8w78wioCoeYOqA634F
	NJgJaHC5qznI4JJEhJRUA+OCI7cjCiq9+lcam82ZF98Y5BDM7hOqzW35ZJmX8JSWc028azbV
	35Uov3zbONSvnOMmS+0O0VWeR6x/aq9OPf+fyYrx87PsJ3rLuAVimwUrDO47zBKK8rY1S/m4
	wuw58zZWoTlOV2pXlRVFpky74da/Ntppd8ePmOi4HVVLT1qtvaupPD1TSomlOCPR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204262>

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
