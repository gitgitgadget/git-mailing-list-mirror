Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 161C2208E8
	for <e@80x24.org>; Tue, 24 Jul 2018 21:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbeGXXHi (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:07:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36811 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbeGXXHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:07:38 -0400
Received: by mail-it0-f68.google.com with SMTP id p81-v6so5939637itp.1
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MNnbwfWohgCLZ+fzmC12TYxdiQ5KFG/MTPT6662fjlQ=;
        b=DJ3+zabkWCHyLd9TnhcOYKqZPrx5JYkArK8qMVtne9UfL1TmyvLJqtZPN2M+6ZK+Lz
         HqxThc2sSh7usvh4cGhlB84O6hk1Kr6cAcUM3afaNT/cN027ZVy8F7fAL1lvTWcVpur+
         xjE/4rpzWBl1HF4Oh17/ywhB0SJzR8/DFdKRqwaFcDQhe2hi3wuYlLq/7zd2gOgRLGmK
         8t6MO4EwaYavhTWj4vSMNemVr7ETLVp+081I/0ioEe/D/yTvlWBm6FAjTEyWyFu2v17a
         a4Z2w/DhkNlwmLrnLt1/X9HsMVHZ0SPwiqVLXaunwT2VqRZD6tdl/40B/09tuOxdUGeZ
         4tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MNnbwfWohgCLZ+fzmC12TYxdiQ5KFG/MTPT6662fjlQ=;
        b=g1JbDS5YCFOQBHeaCkTQr6OZcfXecu0cuZhEALHS/7CmnD6nsTnCeAji32n1wAXuZA
         akyoZfGDXsnu19c5F5EVcnPpQuzn8UCkBtzZJBv7vdpDqj0+7CxZOprjJCeu9HX7KQDN
         m5dkMHYmiZZfymcsP8ul7X9WsngrOCScMml8D9C3sTnAoxtwD43cool6lBzL0vPCkbcr
         AKYLnZEbEvV4gDYD2uR6hsJpq/2V4udwf0VvGKjvzpRz3xGzTIgpjgQ67+4LK2z3cPX3
         qr52fxBbWAkh4wntqwhwGOzDKcZJtvtsx+yzBdlm2AtyoUcZHh3MPy01uQAvPOPteQf5
         h0Kw==
X-Gm-Message-State: AOUpUlG4FkYTwjqyH1Pmhee7hjATe99v3z+zbcIxbQnoP1zmU3sRt+Sd
        /HrElQuy4WVUlsZH/kiAoA5k5jwI
X-Google-Smtp-Source: AAOMgpe/U1d6LiQch521tmiFlV7NKdZs3lPnyC2wC9N8eXleCKTBoY3Spxq9ewNvVlKrhNKn5Evm+A==
X-Received: by 2002:a02:9891:: with SMTP id q17-v6mr17249387jaj.78.1532469547276;
        Tue, 24 Jul 2018 14:59:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id v141-v6sm1805604itb.26.2018.07.24.14.59.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 24 Jul 2018 14:59:06 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] diff: --color-moved: rename "dimmed_zebra" to "dimmed-zebra"
Date:   Tue, 24 Jul 2018 17:58:45 -0400
Message-Id: <20180724215845.7137-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --color-moved "dimmed_zebra" mode (with an underscore) is an
anachronism. Most options and modes are hyphenated. It is more difficult
to type and somewhat more difficult to read than those which are
hyphenated. Therefore, rename it to "dimmed-zebra", and nominally
deprecate "dimmed_zebra".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/diff-options.txt | 3 ++-
 diff.c                         | 4 +++-
 t/t4015-diff-whitespace.sh     | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 41064909ee..9195bcd398 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -282,10 +282,11 @@ zebra::
 	painted using either the 'color.diff.{old,new}Moved' color or
 	'color.diff.{old,new}MovedAlternative'. The change between
 	the two colors indicates that a new block was detected.
-dimmed_zebra::
+dimmed-zebra::
 	Similar to 'zebra', but additional dimming of uninteresting parts
 	of moved code is performed. The bordering lines of two adjacent
 	blocks are considered interesting, the rest is uninteresting.
+	`dimmed_zebra` is a deprecated synonym.
 --
 
 --word-diff[=<mode>]::
diff --git a/diff.c b/diff.c
index dc53a19bab..4ffabb4965 100644
--- a/diff.c
+++ b/diff.c
@@ -268,10 +268,12 @@ static int parse_color_moved(const char *arg)
 		return COLOR_MOVED_ZEBRA;
 	else if (!strcmp(arg, "default"))
 		return COLOR_MOVED_DEFAULT;
+	else if (!strcmp(arg, "dimmed-zebra"))
+		return COLOR_MOVED_ZEBRA_DIM;
 	else if (!strcmp(arg, "dimmed_zebra"))
 		return COLOR_MOVED_ZEBRA_DIM;
 	else
-		return error(_("color moved setting must be one of 'no', 'default', 'zebra', 'dimmed_zebra', 'plain'"));
+		return error(_("color moved setting must be one of 'no', 'default', 'zebra', 'dimmed-zebra', 'plain'"));
 }
 
 int git_diff_ui_config(const char *var, const char *value, void *cb)
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 17df491a3a..8cdfa225ef 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1223,7 +1223,7 @@ test_expect_success 'plain moved code, inside file' '
 	test_cmp expected actual
 '
 
-test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
+test_expect_success 'detect permutations inside moved code -- dimmed-zebra' '
 	git reset --hard &&
 	cat <<-\EOF >lines.txt &&
 		long line 1
@@ -1271,7 +1271,7 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 	test_config color.diff.newMovedDimmed "normal cyan" &&
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
-	git diff HEAD --no-renames --color-moved=dimmed_zebra --color |
+	git diff HEAD --no-renames --color-moved=dimmed-zebra --color |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
-- 
2.18.0.345.g5c9ce644c3

