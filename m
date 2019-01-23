Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5259B1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfAWOke (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46582 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfAWOkb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so1845788edt.13
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dxzqfZAxZ+TPwgPiHydUMW7hZp+IB66oCyS61ZHth2s=;
        b=FbCZTrsyI/9en0xEAZ0TorS3FlyO2ts4f1YhvpaaaMqUqjXLoYKCWLX8kXc3CPo9nD
         CX1yp0cqMUHeGpyC4PdsjjIFNCxuOE/zp9i9Xja1GPMxytqyNqx9UBL6UwtoAXT7UD8w
         2rzan2kOJNg1IDJHYuKi0fSNVJKgQTR8bNUSUIw7oLqeCpA/10jZr2OfxUZYGSH32vD8
         Jg22GYSsoHF14f7s7CbmhE8hgEzavtGsqRzJwyP7D6dWipCaXnKpEt/XldebjHLv772u
         aiah2QpqXctesl0poveO/hsYpQNj4OUVe9iJwIWBJm1JDJCi6D3DvEwd6n39pabo3N7J
         jYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dxzqfZAxZ+TPwgPiHydUMW7hZp+IB66oCyS61ZHth2s=;
        b=kGSTjOIVkVe2ASXhP39kabwNMlGUPEzi57dxtSipwx5vwN2OxE6ERy+M5pTFaEMr7y
         KYEgVrVkCiFJGS6IxxR0iBZAme+MIL9ulIvtqV3WTtlQ1OeZo4DW9432i7euJ6V193nr
         yg0oETayEV4JT1fKy2PXxoLuQNpsDkFflvpmBHHNv+haRsBv339rWvY3g//AsxloI+1/
         yO0k3SLwRIXX+fdYVWVF3ZFQsLA9rHck2s9BFLha0wrDuc4XqDbKiVBEllz2NYccSf8f
         F9rZxHML7m4iL2sLEdDnu3cw6wTFaUK1/ybjyQbDfiRhHyUR0dSVPsDY4OCChR1KbXW8
         +Dvw==
X-Gm-Message-State: AJcUukeXbq0PVm5JnlZaf0fo4xXApGGaxwcF7JC+A/725Tum2z6yVpou
        opxEGFEGCuKBw3IvRgWt66vUvgTm
X-Google-Smtp-Source: ALg8bN64YfxEQNxfhLz0uWUV0qHFfk2etMnD5Q49Ml0yT9yajYM4HdFM/SzV+sCyTnt2H9B+VEIz7w==
X-Received: by 2002:a50:ca86:: with SMTP id x6mr2876146edh.287.1548254429499;
        Wed, 23 Jan 2019 06:40:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s36sm10754165edb.43.2019.01.23.06.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:29 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:29 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:09 GMT
Message-Id: <d613c79aff9c65ab9c3723a876c99e6f35a2f133.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 18/21] t0061: fix with --with-dashes and RUNTIME_PREFIX
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

When building Git with RUNTIME_PREFIX and starting a test helper from
t/helper/, it fails to detect the system prefix correctly.

This is the reason that the warning

	RUNTIME_PREFIX requested, but prefix computation failed. [...]

to be printed.

In t0061, we did not expect that to happen, and it actually did not
happen in the normal case, because bin-wrappers/test-tool specifically
sets GIT_TEXTDOMAINDIR (and as a consequence, nothing in test-tool wants
to know about the runtime prefix).

However, with --with-dashes, bin-wrappers/test-tool is no longer called,
but t/helper/test-tool is called directly.

So let's just ignore the RUNTIME_PREFIX warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0061-run-command.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 99a614bc7c..5a2d087bf0 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -166,7 +166,8 @@ test_trace () {
 	expect="$1"
 	shift
 	GIT_TRACE=1 test-tool run-command "$@" run-command true 2>&1 >/dev/null | \
-		sed -e 's/.* run_command: //' -e '/trace: .*/d' >actual &&
+		sed -e 's/.* run_command: //' -e '/trace: .*/d' \
+			-e '/RUNTIME_PREFIX requested/d' >actual &&
 	echo "$expect true" >expect &&
 	test_cmp expect actual
 }
-- 
gitgitgadget

