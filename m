Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0891F462
	for <e@80x24.org>; Wed, 12 Jun 2019 09:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408720AbfFLJZa (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 05:25:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39705 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408715AbfFLJZa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 05:25:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so24659529edv.6
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dvSXKoO/VIkjFTQKOmw4jJLxfHr9O6oL0Vlpx69WoGQ=;
        b=isPRglNOqk6C5uumL+ivo+9CuS6ZIT6NQZ/HCCOdde0k5lVjFmW4kGUmC0hYHertCc
         EsEnVTuRKS2Ty1+59BEeYAn7j6GwUEreDVE4tja/LAcPDq6xLTMio7de0kljsnIv+7TH
         PWNxjyJRhNF/V1V99FKLjmt9ebQONxv6WXDbQG/cirqSyu+5qNDVdnmzWjBsaUbogk5D
         /narB4mB2S9sUQH6R1x7ADh+f6+rGkJIii+i/4DTWOXMEXxLznSpju9iuPAI044NruAM
         LAVRjC6JItPYuI1dHLMUUy7gDHmGU795d3CVrNhF/KXT6tY/6ER1CcrIcXg1FsZIVQZY
         8dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dvSXKoO/VIkjFTQKOmw4jJLxfHr9O6oL0Vlpx69WoGQ=;
        b=C//1zYzUgim4VCgdVZG0UqM+qQGieQXvJe4x2wYjhsSjI5KmEX8bKRw7whaueyGb6P
         5LQzPxkBBs+8ge1VkuO+mElBFYPzwRTwpTxlBu7bY9WmIf3f+Q3QJ7Df51+2bC/nfYJ9
         eLjEf/6TXsOAY3qcimmr5mhdbW1NBf6irefmWheyKrk41JtuEk44Lx/nrSnZ0x3q59ay
         wqZR4u6I58osp6Mqe5oQ2tkDDnybEpgk3U0qcnqBPnlVcxzZNKouLY7esSFmwE9o0drT
         2GC7IZP3u5zB/QyBJUjr1oY6D49qy4FXSFfjOcf7SMFEjoF+Yv/Hma68Hj0WsCu/RgxP
         2Q/Q==
X-Gm-Message-State: APjAAAVWYaH1J4CxeFI5HgTRLaUBNXC+vAVkWnutPAReh4vfw/isnSAO
        I0FapMHDP7CetElrisg98DcnNNX9
X-Google-Smtp-Source: APXvYqzyWvgFzp/FduMBYHH7TP+7UxQjBdZTPIL8ioUYv7mIbGn6CDi9bvtgXBJtUzdso8rp9zsNlg==
X-Received: by 2002:a17:906:d549:: with SMTP id gk9mr53443593ejb.268.1560331528299;
        Wed, 12 Jun 2019 02:25:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm4393014edh.13.2019.06.12.02.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 02:25:27 -0700 (PDT)
Date:   Wed, 12 Jun 2019 02:25:27 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 09:25:26 GMT
Message-Id: <98d9302618aecd941eff5ea0a1e797f94769c73d.1560331526.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.262.git.gitgitgadget@gmail.com>
References: <pull.262.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] add -p: fix checkout -p with pathological context
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Commit fecc6f3a68 ("add -p: adjust offsets of subsequent hunks when one is
skipped", 2018-03-01) fixed adding hunks in the correct place when a
previous hunk has been skipped. However it did not address patches that
are applied in reverse. In that case we need to adjust the pre-image
offset so that when apply reverses the patch the post-image offset is
adjusted correctly. We subtract rather than add the delta as the patch
is reversed (the easiest way to think about it is to consider a hunk of
deletions that is skipped - in that case we want to reduce offset so we
need to subtract).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl  | 6 +++++-
 t/t3701-add-interactive.sh | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 20eb81cc92..da5b4ec4bc 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -972,7 +972,11 @@ sub coalesce_overlapping_hunks {
 			next;
 		}
 		if ($ofs_delta) {
-			$n_ofs += $ofs_delta;
+			if ($patch_mode_flavour{IS_REVERSE}) {
+				$o_ofs -= $ofs_delta;
+			} else {
+				$n_ofs += $ofs_delta;
+			}
 			$_->{TEXT}->[0] = format_hunk_header($o_ofs, $o_cnt,
 							     $n_ofs, $n_cnt);
 		}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 65dfbc033a..69991a3168 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -639,4 +639,12 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 	test_cmp expected-2 actual
 '
 
+test_expect_success 'checkout -p works with pathological context lines' '
+	test_write_lines a a a a a a >a &&
+	git add a &&
+	test_write_lines a b a b a b a b a b a > a&&
+	test_write_lines s n n y q | git checkout -p &&
+	test_write_lines a b a b a a b a b a >expect &&
+	test_cmp expect a
+'
 test_done
-- 
gitgitgadget
