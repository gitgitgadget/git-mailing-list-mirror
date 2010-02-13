From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] builtin-for-each-ref.c: comment fixes
Date: Sat, 13 Feb 2010 12:30:30 -0800
Message-ID: <1266093033-9526-2-git-send-email-gitster@pobox.com>
References: <1266093033-9526-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 21:31:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgOdi-00079m-M7
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 21:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757973Ab0BMUao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 15:30:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757093Ab0BMUam (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 15:30:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7686799A96
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=b9MV
	uo56WXDggQQgJ5CMaEFicRo=; b=VghJlr769JPOg0Sp9yQzJFHNhlABEkB/MhJ4
	0qaUPxcWsAcNntUlAFCX1VgmBIfNJqma2HyXcSNq6vkIiHc8EA3nHjVwiuPm2QYu
	zl23xBOLG8Ja4IzPOzwEJRP/5A8X6cTzL6nLvZMiaS/0T3FReLr/xbkUeusZd6MR
	LDecapE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=N1ngcD
	u3bSEQ+XVjIfJJslXvMn0oytZL8kV02WQvOZLBtkpF4hH3f1V0EKk2I6F957qlft
	ozAZRG7wFskimiaDb4KLI7p8yAQaEikotvOwHxMVqcNFR6p5K0JKfjhjTQCWBifz
	ACWi1N2bsgJK5nx56IONEZEmCVOOgqyn46sTE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E2D299A95
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC66C99A94 for
 <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:38 -0500 (EST)
X-Mailer: git-send-email 1.7.0.169.g57c99
In-Reply-To: <1266093033-9526-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A627F0A0-18DE-11DF-8D09-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139829>

The primary purpose of this is to get rid of stale comments that lamented
the lack of callback parameter from for_each_ref(), which we have already
fixed.  While at it, adjust the multi-line comment style as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-for-each-ref.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index a5a83f1..3698e82 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -143,7 +143,8 @@ static const char *find_next(const char *cp)
 {
 	while (*cp) {
 		if (*cp == '%') {
-			/* %( is the start of an atom;
+			/*
+			 * %( is the start of an atom;
 			 * %% is a quoted per-cent.
 			 */
 			if (cp[1] == '(')
@@ -420,7 +421,8 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 			grab_date(wholine, v, name);
 	}
 
-	/* For a tag or a commit object, if "creator" or "creatordate" is
+	/*
+	 * For a tag or a commit object, if "creator" or "creatordate" is
 	 * requested, do something special.
 	 */
 	if (strcmp(who, "tagger") && strcmp(who, "committer"))
@@ -502,7 +504,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	}
 }
 
-/* We want to have empty print-string for field requests
+/*
+ * We want to have empty print-string for field requests
  * that do not apply (e.g. "authordate" for a tag object)
  */
 static void fill_missing_values(struct atom_value *val)
@@ -633,18 +636,21 @@ static void populate_value(struct refinfo *ref)
 	if (!eaten)
 		free(buf);
 
-	/* If there is no atom that wants to know about tagged
+	/*
+	 * If there is no atom that wants to know about tagged
 	 * object, we are done.
 	 */
 	if (!need_tagged || (obj->type != OBJ_TAG))
 		return;
 
-	/* If it is a tag object, see if we use a value that derefs
+	/*
+	 * If it is a tag object, see if we use a value that derefs
 	 * the object, and if we do grab the object it refers to.
 	 */
 	tagged = ((struct tag *)obj)->tagged->sha1;
 
-	/* NEEDSWORK: This derefs tag only once, which
+	/*
+	 * NEEDSWORK: This derefs tag only once, which
 	 * is good to deal with chains of trust, but
 	 * is not consistent with what deref_tag() does
 	 * which peels the onion to the core.
@@ -681,9 +687,8 @@ struct grab_ref_cbdata {
 };
 
 /*
- * A call-back given to for_each_ref().  It is unfortunate that we
- * need to use global variables to pass extra information to this
- * function.
+ * A call-back given to for_each_ref().  Filter refs and keep them for
+ * later object processing.
  */
 static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
@@ -711,7 +716,8 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 			return 0;
 	}
 
-	/* We do not open the object yet; sort may only need refname
+	/*
+	 * We do not open the object yet; sort may only need refname
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-- 
1.7.0.169.g57c99
