Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CDCB1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeJYAYx (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:24:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35589 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeJYAYw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:24:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so2529122pgu.2
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B5mBnvXmrgVey+KpCxSs1oFXRBXiE8pGOW0EJ6olgJw=;
        b=dk/pYm3u3OdngHAkoH2Twhfhn7yA4Hz9wkFiuju1NxuO3HIWygaRxI0jI4qSCL3bZv
         6zw4brBtlUBYvBHMCy4OSjH6+p3EgaKit0zZUup54VmkFKJHFG+RLQ7u9xU5eLz/ZxmK
         5bhs9q64KXnzLBt39iXSm4D+jJpx+WL3465rCHZj3+bXsbwdaK9pdWuJwInF4kUYj8xB
         8BboBlYoCX92nnX5kfjGeIvQPB6mUQHIffmQhevnvv10KU75Gvh3HtDePMi5M0nQSh4d
         Ui88aX7XKNZZXZ7KRx/L30oLd0cnrmAJ2UZBXGHXtzn1zBdVGo7RF4jK/ngqVyi7VA38
         2LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B5mBnvXmrgVey+KpCxSs1oFXRBXiE8pGOW0EJ6olgJw=;
        b=Gksw1lQ6JiKThli1C92jz5dF1du/3skgQZVi9UJz9SMimLuNXI4ayHSD858Od/B2Kl
         sQQNDH51qoNtjf2eQQRmizfUzRqRBv68Elrp4pXNe3XA/67PmIdcNx60uP6b54jjySrJ
         rLgCeWQ8mzuDjwvnwZDRv8QgfRoFMcwuupXBQrhPH1UECatPaNMe5PWZyAd4eMymLoTs
         RShtmMl6Ablv7FNETlVFJhGKlo0oaUj6fY5VmbZoFbllpmqW9TB9j0E+mIqM1Uih5BAM
         /kLEMI0QGSXXW/fMsUWMLbDanSroE2pwJmkkpRyQJyGinp3SNVA1ItP47XXFl8QTN7vF
         mqzg==
X-Gm-Message-State: AGRZ1gK8gnx2HDz9fviGlFUc7Vf6jJpKQfLEmxKORy6DQgVzYArrllFe
        rQGQWK5X3wimsYXhKw6vPpCaSr5x
X-Google-Smtp-Source: AJdET5dPFHP2dLYKIcBgxVFHktD9PUobQc1eoo1TV/bbKUo5GEihaBRU5J0+XoIL0DLdy6hoFXA4oQ==
X-Received: by 2002:a63:c84c:: with SMTP id l12-v6mr3002116pgi.77.1540396574585;
        Wed, 24 Oct 2018 08:56:14 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id a1-v6sm8945376pfj.38.2018.10.24.08.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 08:56:13 -0700 (PDT)
Date:   Wed, 24 Oct 2018 08:56:13 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Oct 2018 15:56:07 GMT
Message-Id: <2858bc886ce2c687092f4b93b211ebcdf6281a22.1540396567.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.v4.git.gitgitgadget@gmail.com>
References: <pull.9.v3.git.gitgitgadget@gmail.com>
        <pull.9.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 3/3] repack -ad: prune the list of shallow commits
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
index c6a7943d5..acd43c75d 100644
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
+			prune_shallow(PRUNE_QUICK);
 	}
 
 	if (!no_update_server_info)
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 686fdc928..6faf17e17 100755
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
