Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C556020248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfCDPuC (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:50:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39686 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfCDPuC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:50:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id o6so5596700qtk.6
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YmgKm7PT0zjmntabRegRGKtxU0Il8IgXXV3jx6z1XF4=;
        b=gIrgg3z+LrGcddnNSfXMyxclhPKMn3OaVjSyQrnBnS5fX9eEPtckBXHld4ZWmnMlUz
         HJLYL2OM+xGdEwnk1CjccbqNtce7ot0rb3Tg7RMXH9PZuwnW77uscZoZyZL5EHNECG9s
         Y/KMnom4XucAEsgruVFCePViQgkIZaHBsf8oerqQJhheh0XwOVtfUqtnaGr/Ng08AK22
         Xett60BEBIfJ0BN20LiZiOfOEHsAc2ctp3cr6fuRJspjfFdxiLgvmInymAhTAzepYCAU
         EkhVI+zn3PQzaG+iKaRKsTlEyEnuCGGSiVBp9z3cHVE1mzUQBeuBo74YQc2UX8wodPJl
         I/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YmgKm7PT0zjmntabRegRGKtxU0Il8IgXXV3jx6z1XF4=;
        b=NDdam2c3qF+LtYABcfFuwOw/4qYvApxA/tUsCgE3VmvRTzjqzhoqH6RPDw8/UwblKl
         Hr4QImZOkvFGNH8npZcmA1+0KJBa21Y/3u19tbyReNkOY3ClwPz7Cz4+FpxmUnE9mUQt
         J8K1rG1tDV/fXG2XWVQszQvDA5424Ld1sFsZfG2xOzavWr9WdTDJePrsGvpi0lXSpWz4
         dVBzezAMwlSrYSpNJIVXuWE/AC914oGjgeWhffAfopqVNgcRt62yH7uENR+kxnVRHlzm
         HUS/uwgEZZwaCUgES+TUWerauqLpQIgnHW5V3GIv77kpdE1ByQN8xQ8VnY06vs7vdbhz
         +OVA==
X-Gm-Message-State: APjAAAXu+zzYcIPKwU/papKEBLrdOLfhOXrgc2DS7mUHBTHzrkUs+vXW
        pkQTzFsBVm+dfgD+qa5YqDk83GluMcg=
X-Google-Smtp-Source: APXvYqwVUR93eLrhsM1c28G4YOSZoV72gFDZ/gmH7F6hrGAshZ65SC2RvVKC4UpixF1IlHRaOOD75A==
X-Received: by 2002:ac8:2798:: with SMTP id w24mr14808286qtw.280.1551714600722;
        Mon, 04 Mar 2019 07:50:00 -0800 (PST)
Received: from [10.124.100.9] ([66.210.32.226])
        by smtp.gmail.com with ESMTPSA id r47sm4560494qtc.48.2019.03.04.07.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:50:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [RFC PATCH 3/4] Add alias option to git branch
From:   Kenneth Cochran <kenneth.cochran101@gmail.com>
In-Reply-To: <D9CFD250-26D4-4D1F-B0CD-01E24E8606D9@gmail.com>
Date:   Mon, 4 Mar 2019 09:49:12 -0600
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4829D84-9192-4C7A-8487-0374DAFC324A@gmail.com>
References: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
 <7D21A788-5E38-466F-B3CC-F6A5CBEB2E2E@gmail.com>
 <D9CFD250-26D4-4D1F-B0CD-01E24E8606D9@gmail.com>
To:     Kenneth Cochran <kenneth.cochran101@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom 9f9b9010cb0b8c2874428d2f4bd21f06f747bfee Mon Sep 17 00:00:00 2001
From: Kenneth Cochran <kenneth.cochran101@gmail.com>
Date: Sun, 3 Mar 2019 15:34:20 -0600
Subject: [RFC PATCH 3/4] worktree: symref should be found anywhere in =
chain
Cc: Sahil Dua <sahildua2305@gmail.com>,
    Duy Nguyen <pclouds@gmail.com>,
    Jeff King <peff@peff.net>

Currently, when searching for a shared symref, a symref chain is
fully dereferenced before checking the name. This poses problems for
`git branch -d` which will happily delete a checked out symref.

The existing behaviour (recognizing a non-symbolic ref by the same name)
still exists, but it will now also find any symref that is in between =
the
starting symref and the first non-symbolic ref.

Concretely, for the following chain
HEAD -> symref1 -> symref2 -> master
previously the function was only able to find master.
With these changes applied, it will be able to find any of the above =
references.

Signed-off-by: Kenneth Cochran <kenneth.cochran101@gmail.com>
---
 t/t3207-branch-alias.sh | 13 +++++++++++++
 worktree.c              | 18 ++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/t/t3207-branch-alias.sh b/t/t3207-branch-alias.sh
index 9d4c8c2914..c1edeed4eb 100755
--- a/t/t3207-branch-alias.sh
+++ b/t/t3207-branch-alias.sh
@@ -55,4 +55,17 @@ test_expect_success 'git branch --alias refuses to =
overwrite existing symref' '
 	test_must_fail git branch --alias syme
 '
=20
+test_expect_success 'git branch -d refuses to delete a checked out =
symref' '
+	git branch --alias symd &&
+	git checkout symd &&
+	test_must_fail git branch -d symd
+'
+
+test_expect_success 'git branch -d refuses to delete an indirectly =
checked out symref' '
+	git symbolic-ref refs/heads/symd2 refs/heads/symd &&
+	git checkout symd2 &&
+	test_must_fail git branch -d symd2 &&
+	test_must_fail git branch -d symd
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index d6a0ee7f73..b58325c6c1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -387,6 +387,17 @@ int is_worktree_being_bisected(const struct =
worktree *wt,
 	return found_rebase;
 }
=20
+static int find_symref_by_name(const char *ref_name, const struct =
object_id *oid,
+			       int flags, void *cb_data)
+{
+	const char *target =3D (const char *)cb_data;
+
+	if ((flags & REF_ISSYMREF) && !strcmp(target, ref_name))
+		return 1;
+	else
+		return 0;
+}
+
 /*
  * note: this function should be able to detect shared symref even if
  * HEAD is temporarily detached (e.g. in the middle of rebase or
@@ -406,9 +417,7 @@ const struct worktree *find_shared_symref(const char =
*symref,
=20
 	for (i =3D 0; worktrees[i]; i++) {
 		struct worktree *wt =3D worktrees[i];
-		const char *symref_target;
 		struct ref_store *refs;
-		int flags;
=20
 		if (wt->is_bare)
 			continue;
@@ -425,10 +434,7 @@ const struct worktree *find_shared_symref(const =
char *symref,
 		}
=20
 		refs =3D get_worktree_ref_store(wt);
-		symref_target =3D refs_resolve_ref_unsafe(refs, symref, =
0,
-							NULL, &flags);
-		if ((flags & REF_ISSYMREF) &&
-		    symref_target && !strcmp(symref_target, target)) {
+		if(refs_for_each_ref_in_chain(refs, find_symref_by_name, =
(void *)target, symref)) {
 			existing =3D wt;
 			break;
 		}
--=20
2.17.1


