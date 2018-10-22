Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655511F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeJWG0E (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:26:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43444 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeJWG0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:26:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id q1-v6so3265621pfh.10
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1j2SBfqac3BSRx/8Sx7Uklc+VkQbQfl/uDN4sery/Bg=;
        b=rQzIc+ULVJdmjII3C5MbdheSxAN7j7e3tn6wEJcwdzt/XBx7dsdyI1c5bl3OYTSg0e
         Wdaevr3HdZ4ipk+Lu6Ul57aqordEVeqh4CJ1R/KOWd9B9Y/lHPSmj9FHHM9oNURjabSw
         1zVcnBbFHNqpZYx+LZqQUg3O7hj5AFwdvSGGOio+vOfZs/tCJF8IbR4Pst6efX5/XQ+X
         LkLEAgFp93Kp5e2oSZrHRN4e+x4hakcJwBfcZJ65Z2eC1VvraBghE9j1l8Y1/XliM9nZ
         t8bVlNVVmR7EaI2pkBY+R0ako3fw/VFgXr6H4nNVVeeFHF/8zK4xb2voTgpSKn8fZoCG
         O26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1j2SBfqac3BSRx/8Sx7Uklc+VkQbQfl/uDN4sery/Bg=;
        b=YxO+FoQGoBFozjGbPoDvgEEINjqkSJMMvm0J92xm0BqjPpYgQ9U7JqK9RHsIR3gIZ6
         KcsDPA269VhBXaAPlOMFBMSn5ijglKtThM4m05VfzcuZ7uc4Z6sTphcOx7gySDkiEq1D
         VX3EHnrbcWj0+5QrSA4vVacqYZnZmJIe0RpBh8tjpbzpJ4iApZTxZp+WC2yWGsNLJ4Ju
         R1buxoxoghsR5nGTYRihtUwoE6ptRvnKljpNYzdzjxSmxWcX/nzMO1MU+oJ8sofW7I0g
         LL823AcuaPydpg2mxcYVMaikn0Vvt+KOQA6MyZsbx5OsHeJ9/lZ8R8YJsOZqbdoll4Hu
         1AAQ==
X-Gm-Message-State: AGRZ1gLNpazyeCo0CJ5AxXudxrdOlkedMdWtGhtL7qjOYGQDPwXCLUHI
        n6O2xhI6GfW/teGfIBlRUGLHBvVj
X-Google-Smtp-Source: AJdET5dXrW+4tLkR/wi6CnopCnpSr3Jn9R7ZCeP6PE0P/ZTidl/MUkZ8pR8sIWUrHzgy0wfH1cS1Ag==
X-Received: by 2002:a65:50c3:: with SMTP id s3-v6mr5534356pgp.355.1540245941231;
        Mon, 22 Oct 2018 15:05:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id m27-v6sm62069414pff.187.2018.10.22.15.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:05:40 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:05:40 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Oct 2018 22:05:33 GMT
Message-Id: <1f9ff57d52a72e3795ac4a924e23a64b91b1f83e.1540245934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.v3.git.gitgitgadget@gmail.com>
References: <pull.9.v2.git.gitgitgadget@gmail.com>
        <pull.9.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/3] repack -ad: prune the list of shallow commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`git repack` can drop unreachable commits without further warning,
making the corresponding entries in `.git/shallow` invalid, which causes
serious problems when deepening the branches.

One scenario where unreachable commits are dropped by `git repack` is
when a `git fetch --prune` (or even a `git fetch` when a ref was
force-pushed in the meantime) can make a commit unreachable that was
reachable before.

Therefore it is not safe to assume that a `git repack -adlf` will keep
unreachable commits alone (under the assumption that they had not been
packed in the first place, which is an assumption at least some of Git's
code seems to make).

This is particularly important to keep in mind when looking at the
`.git/shallow` file: if any commits listed in that file become
unreachable, it is not a problem, but if they go missing, it *is* a
problem. One symptom of this problem is that a deepening fetch may now
fail with

	fatal: error in object: unshallow <commit-hash>

To avoid this problem, let's prune the shallow list in `git repack` when
the `-d` option is passed, unless `-A` is passed, too (which would force
the now-unreachable objects to be turned into loose objects instead of
being deleted). Additionally, we also need to take `--keep-reachable`
and `--unpack-unreachable=<date>` into account.

Note: an alternative solution discussed during the review of this patch
was to teach `git fetch` to simply ignore entries in .git/shallow if the
corresponding commits do not exist locally. A quick test, however,
revealed that the .git/shallow file is written during a shallow *clone*,
in which case the commits do not exist, either, but the "shallow" line
*does* need to be sent. Therefore, this approach would be a lot more
finicky than the approach presented by the this patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/repack.c         | 6 ++++++
 t/t5537-fetch-shallow.sh | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c6a7943d5..9217fc832 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -549,6 +549,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (!po_args.quiet && isatty(2))
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
+
+		if (!keep_unreachable &&
+		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
+		     unpack_unreachable) &&
+		    is_repository_shallow(the_repository))
+			prune_shallow(0, 1);
 	}
 
 	if (!no_update_server_info)
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 2d0031703..777c9d1dc 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -186,7 +186,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure '.git/shallow is edited by repack' '
+test_expect_success '.git/shallow is edited by repack' '
 	git init shallow-server &&
 	test_commit -C shallow-server A &&
 	test_commit -C shallow-server B &&
-- 
gitgitgadget
