From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/23] builtin/fetch.c: reorder function definitions
Date: Wed, 30 Oct 2013 06:32:55 +0100
Message-ID: <1383111192-23780-7-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:41:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOWo-0007IK-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab3J3FlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:10 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49286 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750757Ab3J3FlI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:08 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 01:41:08 EDT
X-AuditID: 12074411-b7f426d000005455-1a-52709a4d22c8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id CC.CA.21589.D4A90725; Wed, 30 Oct 2013 01:34:05 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIH014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:03 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqOs7qyDIYNpMAYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE748Hl80wF300qeuf9YG1g3KbZxcjJISFgIvH53UYWCFtM4sK99WxdjFwcQgKXGSVuLtkP
	lhASuMIk8f2DBYjNJqArsainmQnEFhFQk5jYdogFpIFZYCKzxPHpi4AcDg5hAXeJgwcqQEwW
	AVWJpXvBWnkFXCTmfdnKDrFLQeJG81RWEJtTwFXi066b7BCrXCSa2j+zT2DkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI11QvN7NELzWldBMjJGQFdzDOOCl3iFGAg1GJh9fgQX6QEGti
	WXFl7iFGSQ4mJVHetCkFQUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeKcfByrnTUmsrEotyodJ
	SXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJynBwKEnwKs8EGipYlJqeWpGWmVOCkGbi4AQRXCAb
	eIA28IAU8hYXJOYWZ6ZDFJ1iVJQS51UASQiAJDJK8+AGwJLLK0ZxoH+EIdp5gIkJrvsV0GAm
	oMF7WPJABpckIqSkGhj9dv/ZrdqzhHvW1Md7bS0v+U9YnbTlWPq3/LWWFiLanokMHotKkrv9
	Zgjph2Wufb/V3p/tbJJCjUNsX+vZhp4D79hbbCUuyRybxXTBuFSkbafIYf7Z1mo3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236967>

Reorder function definitions to avoid the need for a forward
declaration of function find_non_local_tags().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 198 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 97 insertions(+), 101 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2248abf..61e8117 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -160,9 +160,105 @@ static void add_merge_config(struct ref **head,
 	}
 }
 
+static int add_existing(const char *refname, const unsigned char *sha1,
+			int flag, void *cbdata)
+{
+	struct string_list *list = (struct string_list *)cbdata;
+	struct string_list_item *item = string_list_insert(list, refname);
+	item->util = xmalloc(20);
+	hashcpy(item->util, sha1);
+	return 0;
+}
+
+static int will_fetch(struct ref **head, const unsigned char *sha1)
+{
+	struct ref *rm = *head;
+	while (rm) {
+		if (!hashcmp(rm->old_sha1, sha1))
+			return 1;
+		rm = rm->next;
+	}
+	return 0;
+}
+
 static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
-			struct ref ***tail);
+			struct ref ***tail)
+{
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
+	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
+	const struct ref *ref;
+	struct string_list_item *item = NULL;
+
+	for_each_ref(add_existing, &existing_refs);
+	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
+		if (prefixcmp(ref->name, "refs/tags/"))
+			continue;
+
+		/*
+		 * The peeled ref always follows the matching base
+		 * ref, so if we see a peeled ref that we don't want
+		 * to fetch then we can mark the ref entry in the list
+		 * as one to ignore by setting util to NULL.
+		 */
+		if (!suffixcmp(ref->name, "^{}")) {
+			if (item && !has_sha1_file(ref->old_sha1) &&
+			    !will_fetch(head, ref->old_sha1) &&
+			    !has_sha1_file(item->util) &&
+			    !will_fetch(head, item->util))
+				item->util = NULL;
+			item = NULL;
+			continue;
+		}
+
+		/*
+		 * If item is non-NULL here, then we previously saw a
+		 * ref not followed by a peeled reference, so we need
+		 * to check if it is a lightweight tag that we want to
+		 * fetch.
+		 */
+		if (item && !has_sha1_file(item->util) &&
+		    !will_fetch(head, item->util))
+			item->util = NULL;
+
+		item = NULL;
+
+		/* skip duplicates and refs that we already have */
+		if (string_list_has_string(&remote_refs, ref->name) ||
+		    string_list_has_string(&existing_refs, ref->name))
+			continue;
+
+		item = string_list_insert(&remote_refs, ref->name);
+		item->util = (void *)ref->old_sha1;
+	}
+	string_list_clear(&existing_refs, 1);
+
+	/*
+	 * We may have a final lightweight tag that needs to be
+	 * checked to see if it needs fetching.
+	 */
+	if (item && !has_sha1_file(item->util) &&
+	    !will_fetch(head, item->util))
+		item->util = NULL;
+
+	/*
+	 * For all the tags in the remote_refs string list,
+	 * add them to the list of refs to be fetched
+	 */
+	for_each_string_list_item(item, &remote_refs) {
+		/* Unless we have already decided to ignore this item... */
+		if (item->util)
+		{
+			struct ref *rm = alloc_ref(item->string);
+			rm->peer_ref = alloc_ref(item->string);
+			hashcpy(rm->old_sha1, item->util);
+			**tail = rm;
+			*tail = &rm->next;
+		}
+	}
+
+	string_list_clear(&remote_refs, 0);
+}
 
 static struct ref *get_ref_map(struct transport *transport,
 			       struct refspec *refspecs, int refspec_count,
@@ -612,106 +708,6 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
 	return result;
 }
 
-static int add_existing(const char *refname, const unsigned char *sha1,
-			int flag, void *cbdata)
-{
-	struct string_list *list = (struct string_list *)cbdata;
-	struct string_list_item *item = string_list_insert(list, refname);
-	item->util = xmalloc(20);
-	hashcpy(item->util, sha1);
-	return 0;
-}
-
-static int will_fetch(struct ref **head, const unsigned char *sha1)
-{
-	struct ref *rm = *head;
-	while (rm) {
-		if (!hashcmp(rm->old_sha1, sha1))
-			return 1;
-		rm = rm->next;
-	}
-	return 0;
-}
-
-static void find_non_local_tags(struct transport *transport,
-			struct ref **head,
-			struct ref ***tail)
-{
-	struct string_list existing_refs = STRING_LIST_INIT_DUP;
-	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
-	const struct ref *ref;
-	struct string_list_item *item = NULL;
-
-	for_each_ref(add_existing, &existing_refs);
-	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
-		if (prefixcmp(ref->name, "refs/tags/"))
-			continue;
-
-		/*
-		 * The peeled ref always follows the matching base
-		 * ref, so if we see a peeled ref that we don't want
-		 * to fetch then we can mark the ref entry in the list
-		 * as one to ignore by setting util to NULL.
-		 */
-		if (!suffixcmp(ref->name, "^{}")) {
-			if (item && !has_sha1_file(ref->old_sha1) &&
-			    !will_fetch(head, ref->old_sha1) &&
-			    !has_sha1_file(item->util) &&
-			    !will_fetch(head, item->util))
-				item->util = NULL;
-			item = NULL;
-			continue;
-		}
-
-		/*
-		 * If item is non-NULL here, then we previously saw a
-		 * ref not followed by a peeled reference, so we need
-		 * to check if it is a lightweight tag that we want to
-		 * fetch.
-		 */
-		if (item && !has_sha1_file(item->util) &&
-		    !will_fetch(head, item->util))
-			item->util = NULL;
-
-		item = NULL;
-
-		/* skip duplicates and refs that we already have */
-		if (string_list_has_string(&remote_refs, ref->name) ||
-		    string_list_has_string(&existing_refs, ref->name))
-			continue;
-
-		item = string_list_insert(&remote_refs, ref->name);
-		item->util = (void *)ref->old_sha1;
-	}
-	string_list_clear(&existing_refs, 1);
-
-	/*
-	 * We may have a final lightweight tag that needs to be
-	 * checked to see if it needs fetching.
-	 */
-	if (item && !has_sha1_file(item->util) &&
-	    !will_fetch(head, item->util))
-		item->util = NULL;
-
-	/*
-	 * For all the tags in the remote_refs string list,
-	 * add them to the list of refs to be fetched
-	 */
-	for_each_string_list_item(item, &remote_refs) {
-		/* Unless we have already decided to ignore this item... */
-		if (item->util)
-		{
-			struct ref *rm = alloc_ref(item->string);
-			rm->peer_ref = alloc_ref(item->string);
-			hashcpy(rm->old_sha1, item->util);
-			**tail = rm;
-			*tail = &rm->next;
-		}
-	}
-
-	string_list_clear(&remote_refs, 0);
-}
-
 static void check_not_current_branch(struct ref *ref_map)
 {
 	struct branch *current_branch = branch_get(NULL);
-- 
1.8.4.1
