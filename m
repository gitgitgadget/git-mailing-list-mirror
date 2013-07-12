From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] mailmap: style fixes
Date: Fri, 12 Jul 2013 14:38:54 -0700
Message-ID: <1373665135-32484-4-git-send-email-gitster@pobox.com>
References: <1373665135-32484-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 23:39:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxl3k-0003fa-Qx
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 23:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965494Ab3GLVjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 17:39:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965467Ab3GLVjD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 17:39:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FA6D3032E
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kic0
	lws+7OwsUK7MBWCQ4h26Rfk=; b=OfFLhfPnj4IptnAAiDW3fULNO/sY/SC5Gk3N
	Z1ph/t6QeE2zXhWFSfSOaXuvgiXk4QhCIAmh4fM/lVSam/bixollj80357IgN9nW
	X8CHY1rOxSxSUrIKsWiMdgq0eTfF6uK+nxIaKAeQwlz0+cW8C48z12n2X7ktGfb2
	xAEdTdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=aS1Sgj
	58tPadfm2lNT1Vqt55q9ww5GQjqN/gDltv/XF/RV5WhFR0XI6cWnxmfMLedhKpp0
	i/VpGaXzPviwczQ1G+1+aNgzEI2WTI+brpTfC+oO5Mcpf23DoK/x+EC/lxwyyR0r
	7ETF6r999ZCBs0z90ac6p2iQG1EKLJLKzyewA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53D653032D
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:39:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEE8B30329
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:39:02 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-941-gda9c3c8
In-Reply-To: <1373665135-32484-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 783A7BA8-EB3B-11E2-A08F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230261>

Wrap overlong lines and format the multi-line comments to match our
coding style.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailmap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index a7e92db..5a3347d 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -37,7 +37,8 @@ static void free_mailmap_info(void *p, const char *s)
 static void free_mailmap_entry(void *p, const char *s)
 {
 	struct mailmap_entry *me = (struct mailmap_entry *)p;
-	debug_mm("mailmap: removing entries for <%s>, with %d sub-entries\n", s, me->namemap.nr);
+	debug_mm("mailmap: removing entries for <%s>, with %d sub-entries\n",
+		 s, me->namemap.nr);
 	debug_mm("mailmap: - simple: '%s' <%s>\n", me->name, me->email);
 	free(me->name);
 	free(me->email);
@@ -73,7 +74,8 @@ static void add_mapping(struct string_list *map,
 	}
 
 	if (old_name == NULL) {
-		debug_mm("mailmap: adding (simple) entry for %s at index %d\n", old_email, index);
+		debug_mm("mailmap: adding (simple) entry for %s at index %d\n",
+			 old_email, index);
 		/* Replace current name and new email for simple entry */
 		if (new_name) {
 			free(me->name);
@@ -85,7 +87,8 @@ static void add_mapping(struct string_list *map,
 		}
 	} else {
 		struct mailmap_info *mi = xcalloc(1, sizeof(struct mailmap_info));
-		debug_mm("mailmap: adding (complex) entry for %s at index %d\n", old_email, index);
+		debug_mm("mailmap: adding (complex) entry for %s at index %d\n",
+			 old_email, index);
 		if (new_name)
 			mi->name = xstrdup(new_name);
 		if (new_email)
@@ -315,8 +318,10 @@ int map_user(struct string_list *map,
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
-			/* The item has multiple items, so we'll look up on name too */
-			/* If the name is not found, we choose the simple entry      */
+			/*
+			 * The item has multiple items, so we'll look up on name too.
+			 * If the name is not found, we choose the simple entry.
+			 */
 			struct string_list_item *subitem;
 			subitem = lookup_prefix(&me->namemap, *name, *namelen);
 			if (subitem)
-- 
1.8.3.2-941-gda9c3c8
