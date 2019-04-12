Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49AB20248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfDLJh0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:37:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44300 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfDLJhY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id d11so7732578edp.11
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a1s78ePGcYIGjMfbIq9Y0wgOYdjX++nDCmviqjK1Pa8=;
        b=gU/HsqUPBa2q3qO9XXiXCPFOdNHKXf+cXNeoDBjG67aZgo+80DeiPvxI4yVo7NOj4f
         cjqvpPH98gxDCfxSbyanFmf+QY9EjSISCF5x7R4RhRZoD43B74U3XyirfITombX9P+RJ
         w8H7dinaK4/ByTI6EanbiD81NPvxFcofLsQ95dnUhW3UX0AjXveYbd7cJhu32HrgDQTX
         FTeRVPwpp/KRW3uD5wVTqv7cKdlMslGcXfTE77BlNUZ5Dkea4Dt9XHvQaS/xRauagzYi
         a2KxPslKcpE5mfv4OnaDBan3O108VQ1eI7/Hvm/n+ALyYlCvuhA4KV/eu12q9dVZQ6vV
         kHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a1s78ePGcYIGjMfbIq9Y0wgOYdjX++nDCmviqjK1Pa8=;
        b=ckzasEC6vcU4Oe0vQrrncStjrtFv1RS5Ou+C17yp1wofc4agg8YxthUvCJ1yDBfzXh
         Rq/R9864dIqKeuisG0bpgQu1N7wux21Dn9RLqzF/RAwhVhQaPhDkiRA31P43hVu5CGMN
         zJCu0SoQhdM3NaNUJEyAFqFLmlaQel1evAliePifGboccnMyHYgVsr7PFCJ/Yu5adlY5
         TaS5cgYDCpwqdmfxNzRHiv/qyM523ogYEJFxTWIKBFecN/XVYBp5fuYu/UlNhXLvkKq5
         8SRce+6uflDIJu3LR2aZG930neEumHJgQzSIUWmbf6mGQ9NbeUHeNtR1RJzCOXroJbcp
         B/EQ==
X-Gm-Message-State: APjAAAVHB9Z5n13sJ8pX5riFujdfF+wnzxOB/w6V6duJWmDznD03e9RG
        uDoDQrWyv/DGULWjw7Sxwk4nm9jQ
X-Google-Smtp-Source: APXvYqxMdT0lgGzgXaK5uQXdDF4hc/Up3/kvj51c7+JjwCLv36wN++vOmqggjr5B2052vM3EKjtDjQ==
X-Received: by 2002:a17:906:a841:: with SMTP id dx1mr28777189ejb.99.1555061842867;
        Fri, 12 Apr 2019 02:37:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm5072234edq.33.2019.04.12.02.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 02:37:22 -0700 (PDT)
Date:   Fri, 12 Apr 2019 02:37:22 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 09:37:14 GMT
Message-Id: <7372059922710f392201cb32c5a7ac9cbdbe0616.1555061837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.v2.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/8] tests (push): do not abbreviate the `--follow-tags`
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We really want to spell out the option in the full form, to avoid any
ambiguity that might be introduced by future patches.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5516-fetch-push.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 37e8e80893..db0b1db458 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1370,7 +1370,7 @@ test_expect_success 'push does not follow tags by default' '
 	test_cmp expect actual
 '
 
-test_expect_success 'push --follow-tag only pushes relevant tags' '
+test_expect_success 'push --follow-tags only pushes relevant tags' '
 	mk_test testrepo heads/master &&
 	rm -fr src dst &&
 	git init src &&
@@ -1384,7 +1384,7 @@ test_expect_success 'push --follow-tag only pushes relevant tags' '
 		git tag -m "future" future &&
 		git checkout master &&
 		git for-each-ref refs/heads/master refs/tags/tag >../expect &&
-		git push --follow-tag ../dst master
+		git push --follow-tags ../dst master
 	) &&
 	(
 		cd dst &&
-- 
gitgitgadget

