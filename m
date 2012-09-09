From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/14] fetch_pack(): reindent function decl and defn
Date: Sun,  9 Sep 2012 08:19:39 +0200
Message-ID: <1347171589-13327-5-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAau4-0003F9-8i
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab2IIGVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:16 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:60998 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752095Ab2IIGUe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:34 -0400
X-AuditID: 1207440d-b7f236d000000943-db-504c35311b80
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.F1.02371.1353C405; Sun,  9 Sep 2012 02:20:33 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIlh029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:32 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqGto6hNgsP6rtEXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M/79es9c8IerYta+JawNjLM5uhg5OSQETCRuX/jBBmGLSVy4tx7MFhK4zCjRv8qti5EL
	yD7DJNEz8yY7SIJNQFdiUU8zE4gtIqAmMbHtEAtIEbNAF6PE8nW/gLo5OIQF3CX2TooEqWER
	UJU41/CGGcTmFXCRWHjlGyPEMkWJH9/XgMU5BVwlXs3czQix2EVi085rrBMYeRcwMqxilEvM
	Kc3VzU3MzClOTdYtTk7My0st0jXSy80s0UtNKd3ECAko3h2M/9fJHGIU4GBU4uFlvuMdIMSa
	WFZcmXuIUZKDSUmUV8PEJ0CILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO9VdqAcb0piZVVqUT5M
	SpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC1xhkqGBRanpqRVpmTglCmomDE0RwgWzg
	AdoQDFLIW1yQmFucmQ5RdIpRUUqctwwkIQCSyCjNgxsAi/1XjOJA/wjz1oJU8QDTBlz3K6DB
	TECDRZ55gAwuSURISTUwcipUTAqr1fvDfjwgnP8hWwVP+AEWe1WTpAtrmBfpf4/gjFzN4RV0
	4s47pUebmwVnbS269u3lt/w972oSXWp1k37kB8R8KVjZ+97grsJuh5ZaXxYWtVbDljc11+w2
	NUUU5Iv+tpS6t09st628c9n/q73tcyZEeZYW8td9kOLhSn8ZdPSs12QlluKMREMt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205061>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c |  8 ++++----
 fetch-pack.h         | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index fdda36f..30990c0 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1082,10 +1082,10 @@ static int compare_heads(const void *a, const void *b)
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
