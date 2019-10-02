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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B2631F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 21:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfJBVKu (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 17:10:50 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41814 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbfJBVKu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 17:10:50 -0400
Received: by mail-wr1-f44.google.com with SMTP id q9so552704wrm.8
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=oAN4uXBz5Q3X84qD2iLr7s4wwZMBNyCafzrCHhL2JQ0=;
        b=sVJGqKTAGFjT6ADi5rBkgu38mgb9XlWdC+Z5QBEEAiPwTgkfxKMLvNtPvPtkt2nmjr
         6mF+q79dWz1+iUzIZ/QjB6Mvp7u9KqyayRjcmUgQRgp1WA+n2bv06AirXLLntXZOa7lB
         VDPHiI5h6QYVJyrBLmCK+KEJInDvE6eZkQpozyg4tG8bBrdfDnIVTlLJmcElCCJlvc7v
         GFoI+lJoX814lhFVoNdg+FeG9/B/fhnKZsa+DG/N8+IP2v15w4oAGED5RZsayl7gDrCD
         NQrsRujxUpUptMV1XjuYYRP3yRLyIzSeZ0lChF2QKKcDbB+2BrYmXgUBJ9OU8v1xRYxR
         029Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=oAN4uXBz5Q3X84qD2iLr7s4wwZMBNyCafzrCHhL2JQ0=;
        b=VIiaRK0XLXfxtBHzpTxxqlWu7xiANTjkKsUCGB4xplXN1EU8NKEMfNZNZv2AsAHBAM
         yO7F1QJOiyi094Ryjj1x9blEnHQi8nxOjtdss2OZgwjv76cqA8Yg349gK98NZ6n5Wi32
         MyvXw65oKGmDpvfItzIq6Pu9r/KC1KOPbz9/HKZpNHsmr9eVeQVuYOa80vIp5CAA3YUR
         RbSVDPPBN944Sq5khmrFCQT1GtVaHbOMs34mHAzI3fYP+ckpCfos4mZ+TX7FAWP7UXtE
         luPMQGbcr48sxUEqRXubASPeDgta4bbRC4VlaN54vn1Tta/YLZ08f251HhJXJrhF009U
         tlBA==
X-Gm-Message-State: APjAAAXJRTTI9GQib2eVIbWdx8FGZmHkrbRHnf3JpDW1dsB8P/ap+gKg
        rguHNa9Y7ZvOW+T5wj3ihYWZv3We
X-Google-Smtp-Source: APXvYqyzMJ7OvBEFymPRCHxtqnGvO4hlZ0RoXPoSXBKHZOqNXVeJNBS7Du0CJ+mLecXNMGboMmj28w==
X-Received: by 2002:a05:6000:1c4:: with SMTP id t4mr4323732wrx.183.1570050647895;
        Wed, 02 Oct 2019 14:10:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm1046086wra.89.2019.10.02.14.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 14:10:47 -0700 (PDT)
Date:   Wed, 02 Oct 2019 14:10:47 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Oct 2019 21:10:45 GMT
Message-Id: <9993a607beaafc66f72e1be3f158074cd121b4bb.1570050645.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.373.v2.git.gitgitgadget@gmail.com>
References: <pull.373.git.gitgitgadget@gmail.com>
        <pull.373.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] range-diff: internally force `diff.noprefix=true`
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Michal =?UTF-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When parsing the diffs, `range-diff` expects to see the prefixes `a/`
and `b/` in the diff headers.

These prefixes can be forced off via the config setting
`diff.noprefix=true`. As `range-diff` is not prepared for that
situation, this will cause a segmentation fault.

Let's avoid that by passing the `--no-prefix` option to the `git log`
process that generates the diffs that `range-diff` wants to parse.
And of course expect the output to have no prefixes, then.

Reported-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c          | 3 ++-
 t/t3206-range-diff.sh | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index ba1e9a4265..f2fc1e02c2 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -52,6 +52,7 @@ static int read_patches(const char *range, struct string_list *list)
 
 	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 			"--reverse", "--date-order", "--decorate=no",
+			"--no-prefix",
 			/*
 			 * Choose indicators that are not used anywhere
 			 * else in diffs, but still look reasonable
@@ -111,7 +112,7 @@ static int read_patches(const char *range, struct string_list *list)
 			if (!util->diff_offset)
 				util->diff_offset = buf.len;
 			line[len - 1] = '\n';
-			len = parse_git_diff_header(&root, &linenr, 1, line,
+			len = parse_git_diff_header(&root, &linenr, 0, line,
 						    len, size, &patch);
 			if (len < 0)
 				die(_("could not parse git header '%.*s'"), (int)len, line);
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 0120f769f1..64b66f2094 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -461,4 +461,8 @@ test_expect_success 'format-patch --range-diff as commentary' '
 	grep "> 1: .* new message" 0001-*
 '
 
+test_expect_success 'range-diff overrides diff.noprefix internally' '
+	git -c diff.noprefix=true range-diff HEAD^...
+'
+
 test_done
-- 
gitgitgadget
