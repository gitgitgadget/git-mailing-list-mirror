Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C6720248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfCDPuE (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:50:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36134 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDPuE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:50:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id c2so3028169qkb.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JZg0YxUWqe5ilAW5qqLi0EGpE7i7OLVnrVCF0j1eCqg=;
        b=TVpQgFS7xCqhyueM9TNKw3DnwzxqqnnTImxsDNTVevnjaUaMji1jtevvLc7Xl5YIUz
         h+HGSer2+H0Fm6xJYAfScCvJNxVxZTltkTwDoS2aTzloN6X+jswa8lICtN3xB3wPRPXQ
         3/z3roCGkREFnpOKshPrcTg5CqU1DKUIbleXT5KPsTqN5NhwlYL4zZ05VWlRJ7BkoKws
         COZXX0Oh5TfMw80VIhtpfzF8H2PhBK9tE4JulXcAf2Q9PkQTSZAEDFn883OHKa57eTTB
         kftgfh2H0Bq1EqW0Gzhcqzoj22FrG7cqaLuuYxkthBH8f6U0dUbisKyrdNXfLpjWBNrN
         aang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JZg0YxUWqe5ilAW5qqLi0EGpE7i7OLVnrVCF0j1eCqg=;
        b=rQUGlyB5HkxvFVlPrrjNg3CSbn2m7FYoqKBIpr/0WzlPzW/wWpzcxIKLG9M7OW8TnB
         eUErPAY3pESqMM1pgpgwxf0Ia2Fh8fMqIY5GHpe7p6t09wkehlPkIEWUzrb1qhv+ScdS
         6FX5esrDjh14Ezuo7WEyUiqJVc1M2+gO4Qhd2NXlFMBcmrcJdVqbZAXEiPnLiihaLEni
         /skm8pMnF1ru4lkerX7jMmIiWAC96ngALusuaTA0GLh5e8/NoWeAs+OAA11vXfgfyr/7
         EEtK1NrYvWz/CoNindE5eu8PO76GZRYyo1pzikqQzpub3yYubPvX/zIcdZSif8VdsOWK
         9kIw==
X-Gm-Message-State: APjAAAV5cvXeemIsMRWs2sJcgDhlGbE2KUdWq3Ov00Rj+eU4LBYQ5Og6
        t5QdxXgq7vT8okQamHlSSFw=
X-Google-Smtp-Source: APXvYqyANiIah+49kMQKBgBbyP2VFG7bhoXd+zahr/l5RBxTdrkNMbr7z50WSm5BN9XOGGJUnCStZQ==
X-Received: by 2002:a37:324e:: with SMTP id y75mr14091462qky.228.1551714603243;
        Mon, 04 Mar 2019 07:50:03 -0800 (PST)
Received: from [10.124.100.9] ([66.210.32.226])
        by smtp.gmail.com with ESMTPSA id r47sm4560494qtc.48.2019.03.04.07.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:50:02 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [RFC PATCH 4/4] Add alias option to git branch
From:   Kenneth Cochran <kenneth.cochran101@gmail.com>
In-Reply-To: <D4829D84-9192-4C7A-8487-0374DAFC324A@gmail.com>
Date:   Mon, 4 Mar 2019 09:49:56 -0600
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C678086A-93E9-4F0B-AAAA-FBBBC27F2BFC@gmail.com>
References: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
 <7D21A788-5E38-466F-B3CC-F6A5CBEB2E2E@gmail.com>
 <D9CFD250-26D4-4D1F-B0CD-01E24E8606D9@gmail.com>
 <D4829D84-9192-4C7A-8487-0374DAFC324A@gmail.com>
To:     Kenneth Cochran <kenneth.cochran101@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom c1bad54b29ae1c1d8548d248f6ecaa5959e55f7b Mon Sep 17 00:00:00 2001
From: Kenneth Cochran <kenneth.cochran101@gmail.com>
Date: Mon, 4 Mar 2019 01:08:46 -0600
Subject: [RFC PATCH 4/4] branch: disallow accidentally breaking symrefs
Cc: Sahil Dua <sahildua2305@gmail.com>,
    Duy Nguyen <pclouds@gmail.com>,
    Jeff King <peff@peff.net>

Currently, symrefs are ignored when deleting a branch, making
it possible to accidentally create dangling symrefs without any
warning.

These changes give an error if a branch deletion operation would
create a dangling symref, unless the user specifies to force the
delete anyways.

Signed-off-by: Kenneth Cochran <kenneth.cochran101@gmail.com>
---
 builtin/branch.c        | 20 ++++++++++++++++++++
 t/t3207-branch-alias.sh | 12 ++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4b8b8fc08f..5c05ccd5e9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -233,6 +233,11 @@ static int delete_branches(int argc, const char =
**argv, int force, int kinds,
 		if (kinds =3D=3D FILTER_REFS_BRANCHES) {
 			const struct worktree *wt =3D
 				find_shared_symref("HEAD", name);
+			char *buf;
+			size_t len;
+			FILE *memstream;
+			int cont =3D 0;
+
 			if (wt) {
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
@@ -240,6 +245,21 @@ static int delete_branches(int argc, const char =
**argv, int force, int kinds,
 				ret =3D 1;
 				continue;
 			}
+
+			memstream =3D open_memstream(&buf, &len);
+			warn_dangling_symref(memstream, "%s", name);
+			fclose(memstream);
+			buf[strcspn(buf, "\n")] =3D '\0';
+			if (len > 0 && !force) {
+				cont =3D 1;
+				error(_("Deleting branch '%s' would =
leave dangling symrefs.\n"
+					"If you're sure you want to =
delete it, run 'git branch -D %s'\n"
+					"The following symrefs would be =
left dangling:\n%s"),
+				      bname.buf, bname.buf, buf);
+			}
+			free(buf);
+			if (cont)
+				continue;
 		}
=20
 		target =3D resolve_refdup(name,
diff --git a/t/t3207-branch-alias.sh b/t/t3207-branch-alias.sh
index c1edeed4eb..2f3a7b398b 100755
--- a/t/t3207-branch-alias.sh
+++ b/t/t3207-branch-alias.sh
@@ -68,4 +68,16 @@ test_expect_success 'git branch -d refuses to delete =
an indirectly checked out s
 	test_must_fail git branch -d symd
 '
=20
+test_expect_success 'git branch -d refuses to create a dangling symref' =
'
+	git branch dangling_parent &&
+	git branch --alias dangling dangling_parent &&
+	git branch -d dangling_parent &&
+	test_path_is_file .git/refs/heads/dangling_parent
+'
+
+test_expect_success 'git branch -D forces creation of dangling symref' =
'
+	git branch -D dangling_parent &&
+	test_must_fail test_path_is_file .git/refs/heads/dangling_parent
+'
+
 test_done
--=20
2.17.1


