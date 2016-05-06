From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/33] read_raw_ref(): move docstring to header file
Date: Fri,  6 May 2016 18:13:57 +0200
Message-ID: <1443ddf162783043699ba2bc5c9cb0995b9b08cd.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiP5-0008Bp-7M
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758680AbcEFQOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:54 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56556 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758559AbcEFQOv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:51 -0400
X-AuditID: 12074412-51bff700000009f7-03-572cc2f9c279
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 94.62.02551.9F2CC275; Fri,  6 May 2016 12:14:49 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUw031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:48 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPvrkE64wbKVjBbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oye59cZC7apVPz7fZy1gfGDTBcjJ4eEgInE47Z/
	rF2MXBxCAlsZJZ62LmCBcI4zSTz4/JYZpIpNQFdiUU8zE4gtIhAh0fCqhbGLkYODWeAzo8RK
	bpCwsIC7xNkvO1lBbBYBVYnTyz6BlfAKREnc/yQNsUtO4vL0B2wgNqeAhcSh3uNgE4UEzCU6
	1t5gn8DIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrplebmaJXmpK6SZGSHgJ7WBcf1Lu
	EKMAB6MSD2/GSe1wIdbEsuLK3EOMkhxMSqK83wt0woX4kvJTKjMSizPii0pzUosPMUpwMCuJ
	8F7ZB5TjTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLgPXQQqFGwKDU9
	tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFP7xxcAIAEnxAO2VB2nnLS5IzAWKQrSeYtTl
	OLL/3lomIZa8/LxUKXHeuSBFAiBFGaV5cCtgyeQVozjQx8K8k0CqeICJCG7SK6AlTEBL3s/V
	BFlSkoiQkmpgrGtMvcmVY1mudeds8gu1/xkJzF8utRe+9HjRpPDM4e+TvY8+2IjJ5Tyd/vyc
	bhHz/ncT7h1/el2uZtGNxNchVZuOzZjo1DX7uIW9dezvfFETl5W9DEsjHLS3uZpM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293804>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 38 --------------------------------------
 refs/refs-internal.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 73717dd..fc0c7c1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1388,44 +1388,6 @@ static int resolve_missing_loose_ref(const char *refname,
 	return -1;
 }
 
-/*
- * Read the specified reference from the filesystem or packed refs
- * file, non-recursively. Set type to describe the reference, and:
- *
- * - If refname is the name of a normal reference, fill in sha1
- *   (leaving referent unchanged).
- *
- * - If refname is the name of a symbolic reference, write the full
- *   name of the reference to which it refers (e.g.
- *   "refs/heads/master") to referent and set the REF_ISSYMREF bit in
- *   type (leaving sha1 unchanged). The caller is responsible for
- *   validating that referent is a valid reference name.
- *
- * WARNING: refname might be used as part of a filename, so it is
- * important from a security standpoint that it be safe in the sense
- * of refname_is_safe(). Moreover, for symrefs this function sets
- * referent to whatever the repository says, which might not be a
- * properly-formatted or even safe reference name. NEITHER INPUT NOR
- * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
- *
- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
- * and return -1. If the ref exists but is neither a symbolic ref nor
- * a sha1, it is broken; set REF_ISBROKEN in type, set errno to
- * EINVAL, and return -1. If there is another error reading the ref,
- * set errno appropriately and return -1.
- *
- * Backend-specific flags might be set in type as well, regardless of
- * outcome.
- *
- * It is OK for refname to point into referent. If so:
- *
- * - if the function succeeds with REF_ISSYMREF, referent will be
- *   overwritten and the memory formerly pointed to by it might be
- *   changed or even freed.
- *
- * - in all other cases, referent will be untouched, and therefore
- *   refname will still be valid and unchanged.
- */
 int read_raw_ref(const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 37a1a37..de7722e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -209,6 +209,44 @@ int rename_ref_available(const char *oldname, const char *newname);
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
 
+/*
+ * Read the specified reference from the filesystem or packed refs
+ * file, non-recursively. Set type to describe the reference, and:
+ *
+ * - If refname is the name of a normal reference, fill in sha1
+ *   (leaving referent unchanged).
+ *
+ * - If refname is the name of a symbolic reference, write the full
+ *   name of the reference to which it refers (e.g.
+ *   "refs/heads/master") to referent and set the REF_ISSYMREF bit in
+ *   type (leaving sha1 unchanged). The caller is responsible for
+ *   validating that referent is a valid reference name.
+ *
+ * WARNING: refname might be used as part of a filename, so it is
+ * important from a security standpoint that it be safe in the sense
+ * of refname_is_safe(). Moreover, for symrefs this function sets
+ * referent to whatever the repository says, which might not be a
+ * properly-formatted or even safe reference name. NEITHER INPUT NOR
+ * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
+ *
+ * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
+ * and return -1. If the ref exists but is neither a symbolic ref nor
+ * a sha1, it is broken; set REF_ISBROKEN in type, set errno to
+ * EINVAL, and return -1. If there is another error reading the ref,
+ * set errno appropriately and return -1.
+ *
+ * Backend-specific flags might be set in type as well, regardless of
+ * outcome.
+ *
+ * It is OK for refname to point into referent. If so:
+ *
+ * - if the function succeeds with REF_ISSYMREF, referent will be
+ *   overwritten and the memory formerly pointed to by it might be
+ *   changed or even freed.
+ *
+ * - in all other cases, referent will be untouched, and therefore
+ *   refname will still be valid and unchanged.
+ */
 int read_raw_ref(const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type);
 
-- 
2.8.1
