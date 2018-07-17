Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193C81F597
	for <e@80x24.org>; Tue, 17 Jul 2018 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbeGQOYa (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 10:24:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35019 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeGQOY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 10:24:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so480536pgv.2
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GrvzlnC78bZQ77sIBZImgOqRW6Jnf3yU58ypb5hTwkg=;
        b=DmvPay9IulPe8jBPakRaEJ77sikfRQI1SiEggGE0VwiiCNsRgoBT6BpozhDhg0kjr/
         k7Xm9B2ZvkvfuhjDgA3FHwa4bVQOY8nmqfZgD5jW+OoPey8jKhLr3Zg5I10SpZP0XxNI
         6vlp5qB2/wCGWddRCzQXPT/9eaxd8ehApGhrHXpAlFkOavSnM3W6XU/AWY9mzq2WyS2R
         JFSW4Zgtfk/ae0L0Y2qUmuw6cCBFVfMKrR9gZhx8Spjo4Jt0jDPcTcCekN2cBZowiVKr
         4Kkxp+VJaCCmcrbvc/WA2c/az1hOXP5Jej3GRZuX4egTc8l5dG6XeI8L+QOp4uwn+LbV
         N+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GrvzlnC78bZQ77sIBZImgOqRW6Jnf3yU58ypb5hTwkg=;
        b=tf8ykgjtmus0sp0hLlrJBdwlSgQgoUzmrSZk60os1tfsg6KkpC33mrBIGhnF15xQ9D
         vpbIzJbZTcEzBftkfctpKI4H842EzS1vReBTt3SK5g6LWU5TjB6+0HM/TomUuiZNHJJu
         VFW+Bq8azG0gDsmgSfWI9LRo5UP6souOFuDIUR3l217A82wDcUBZkGUWPtPX7mc85RIY
         ArcLdMVC26D+7xjL26yvCPJoVTHni7EZ89CK+31+cEhb2h7G/GwTAefiyqoh1atQI/Tl
         m7/e/8HkC1GX/GBf1brFAh/tU3ZZayxhmohRn0MVkr72yZ467NkMNRcqtRX5ztyP9qrc
         EXWA==
X-Gm-Message-State: AOUpUlFADFJy9ms1QjtbdWcCWfIj34xPwFU+mBKbP3mzGuNKEvrn9iWY
        RMlEDQyTkX0Gz/W/YgpAeOAmOA==
X-Google-Smtp-Source: AAOMgpcdWe0zt0krRYPokmrjsjkZxQkvcOCqjhAB0FXG339i7DRa/GSLqYhRZBgTww1qX1dBJOtZyg==
X-Received: by 2002:a62:d842:: with SMTP id e63-v6mr816527pfg.88.1531835503197;
        Tue, 17 Jul 2018 06:51:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id d23-v6sm2282289pfe.2.2018.07.17.06.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 06:51:42 -0700 (PDT)
Date:   Tue, 17 Jul 2018 06:51:42 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Jul 2018 13:51:37 GMT
Message-Id: <c7ee6e00875bbfe6108dcdcc43cb389096a28188.1531835498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.v2.git.gitgitgadget@gmail.com>
References: <pull.9.git.gitgitgadget@gmail.com>
        <pull.9.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] repack -ad: prune the list of shallow commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While it is true that we never add unreachable commits into pack files
intentionally (as `git repack`'s documentation states), we must not
forget that a `git fetch --prune` (or even a `git fetch` when a ref was
force-pushed in the meantime) can make a commit unreachable that was
reachable before.

Therefore it is not safe to assume that a `git repack -adlf` will keep
unreachable commits alone (under the assumption that they had not been
packed in the first place).

This is particularly important to keep in mind when looking at the
`.git/shallow` file: if any commits listed in that file become
unreachable, it is not a problem, but if they go missing, it *is* a
problem. One symptom of this problem is that a deepening fetch may now
fail with

	fatal: error in object: unshallow <commit-hash>

To avoid this problem, let's prune the shallow list in `git repack` when
the `-d` option is passed, unless `-A` is passed, too (which would force
the now-unreachable objects to be turned into loose objects instead of
being deleted). Additionally, e also need to take `--keep-reachable` and
`--unpack-unreachable=<date>` into account.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/repack.c         | 6 ++++++
 t/t5537-fetch-shallow.sh | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159..4caf57221 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -444,6 +444,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (!quiet && isatty(2))
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
+
+		if (!keep_unreachable &&
+		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
+		     unpack_unreachable) &&
+		    is_repository_shallow())
+			prune_shallow(0);
 	}
 
 	if (!no_update_server_info)
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 561485d31..d32ba20f9 100755
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
