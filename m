From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/22] notes.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:03 +0700
Message-ID: <1456555333-5853-13-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:43:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYb4-0003TE-RZ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbcB0GnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:43:19 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34991 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbcB0GnS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:43:18 -0500
Received: by mail-pa0-f43.google.com with SMTP id ho8so64262579pac.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfQAiIrgahdYvUTe4Yobfm2cxpiTeh2hYwc6FvX4Bpg=;
        b=H8I+6pqzkPaoYAdqbM2ENDgjpwL+rabs7SSLNLMzMfwIZ685XwWhlXIjOu3NO+AlzH
         7gnrH/ZpwwhP/rY5NBttZw5Dthnour/EcHqp7Nona63zx4lDwDUl1YDcoCHDCUiWTbbW
         M0ezum6U86hfw1AKwRpA/inm1Jn4peYXuZEdUncZ9nTbxQdWOl7SL8DxW6DPrRUMm6pX
         0U2U/uxPsvdKdorpZ6WbJGAEsw5d0PwEKaDPSv4U8E7j+mDmDk3nwvb3XmpoW3u39354
         wLnSXqfbd71vz3+7c3CNCIdB/voh/D5rh9o5NFvKZMw50x1OC7dRBImGpndydqNGL6ck
         HBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfQAiIrgahdYvUTe4Yobfm2cxpiTeh2hYwc6FvX4Bpg=;
        b=Avy6Q4dapJDQfXLnxjgwSeAnpiHvUPvqmrcNewBiIls0jMjDv6N/YN7gaj/L+u5A0q
         yT+bjiQ71md/Ut1GLh5iXnjhqc3LeBR7cawz3xJSlRsj5hoJh0lVhTQnyH5CEfN6bleO
         016QxFLp5JfrOFUKdOGhnHyHMkgPbgaK7nQDSyFN9QSrApSsM+lHefwYO1Q/YWqTJWF5
         KJrCBqzV9KdWMQZilhf7ZoaS4bEdIMxpRabv1cF4O4wNU7Ktu6uFhKIDZnLl6VVl1gUj
         1C3xrqsyWAsi5XE15lMJDY2EgeXek0FFPgd0Eglli6RsvSwXG8riOzf2oNuS2z97MP2e
         h7Sw==
X-Gm-Message-State: AD7BkJJNtNQTy2UZ8sJ8vKcsWk/LdwXUa4rss7MuE+TD1naHe7vCft1eBZeKtYirKDLzUA==
X-Received: by 10.66.147.74 with SMTP id ti10mr7729328pab.128.1456555397885;
        Fri, 26 Feb 2016 22:43:17 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id t29sm23509421pfi.8.2016.02.26.22.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:43:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:43:51 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287673>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 notes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/notes.c b/notes.c
index 88cf474..0f03f77 100644
--- a/notes.c
+++ b/notes.c
@@ -422,7 +422,7 @@ static void load_subtree(struct notes_tree *t, stru=
ct leaf_node *subtree,
=20
 	buf =3D fill_tree_descriptor(&desc, subtree->val_sha1);
 	if (!buf)
-		die("Could not read %s for notes-index",
+		die(_("Could not read %s for notes-index"),
 		     sha1_to_hex(subtree->val_sha1));
=20
 	prefix_len =3D subtree->key_sha1[19];
@@ -455,8 +455,8 @@ static void load_subtree(struct notes_tree *t, stru=
ct leaf_node *subtree,
 			}
 			if (note_tree_insert(t, node, n, l, type,
 					     combine_notes_concatenate))
-				die("Failed to load %s %s into notes tree "
-				    "from %s",
+				die(_("Failed to load %s %s into notes tree "
+				      "from %s"),
 				    type =3D=3D PTR_TYPE_NOTE ? "note" : "subtree",
 				    sha1_to_hex(l->key_sha1), t->ref);
 		}
@@ -942,7 +942,7 @@ void string_list_add_refs_by_glob(struct string_lis=
t *list, const char *glob)
 	} else {
 		unsigned char sha1[20];
 		if (get_sha1(glob, sha1))
-			warning("notes ref %s is invalid", glob);
+			warning(_("notes ref %s is invalid"), glob);
 		if (!unsorted_string_list_has_string(list, glob))
 			string_list_append(list, glob);
 	}
@@ -1020,9 +1020,9 @@ void init_notes(struct notes_tree *t, const char =
*notes_ref,
 	    get_sha1_treeish(notes_ref, object_sha1))
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, object_sha1))
-		die("Cannot use notes ref %s", notes_ref);
+		die(_("Cannot use notes ref %s"), notes_ref);
 	if (get_tree_entry(object_sha1, "", sha1, &mode))
-		die("Failed to read notes tree referenced by %s (%s)",
+		die(_("Failed to read notes tree referenced by %s (%s)"),
 		    notes_ref, sha1_to_hex(object_sha1));
=20
 	hashclr(root_tree.key_sha1);
--=20
2.8.0.rc0.205.g7ec8cf1
