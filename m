Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668161F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393211AbfAPNgS (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34912 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390514AbfAPNgR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so5448284edx.2
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yjmVd1mMTh5O9pgiFT5EpWKGV+TAK5GJK5Kpo9RboIc=;
        b=UmpDX8ffZBxCxFnUrvObPE7CUSM8cbBiCDexCfNn20eUqONdyEJeQarDC41NuMChRa
         DTJxtlZQTjEySWtUQMHobuuRZ+KMnw/3Hz8hxLOyuG4EZQPopFwD5mF2ZLb/+PqvAx1N
         QErfOTRc5QYe24Za9HZBogKCcdk4Z5XDyJSQI5y4YYzsQkIJcPlu+Q/ja7HYjNCQBzpx
         d6zuTxT0xtKk+tlXV8Y9M15xF8tFj7QasnflOm8eXbfQTg0mugV1woeVORws2R5cpWzM
         x38vhvOiSCccVsIdn6M8QbNj68JjGe/9HSfAWeQu/VXzHuj7Kx55cDt09Gq9FLrviD4I
         f8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yjmVd1mMTh5O9pgiFT5EpWKGV+TAK5GJK5Kpo9RboIc=;
        b=aR4MLnlpPpjQg/mDSukkG227N4tNKcSmWcPmbu9nn29WIpXfNtZS+HyVLr1+BmaQ5Q
         RJ+4xuwbSMyhoTRgu+apJhYs+gKLUcAYLDYBWXe3mMCIQcwaQ1xOwuWn0yEtRVZfx5qb
         dHZ9ecoyVftEBssne+dASMkBCAPup+mmGt/W1Cn4pkNQ38kHHNZxDqkg84+1QofX+4qX
         zBnqRf6/ctsrvRToxcJcWn+Mdd73RMBZr7rb/PHb8i0AWr+7CTN0NeveN59SMK8cFNaQ
         3szGtgmmn/edJigQ5sZi/qohlD5uUKjCe+we1nD8I32wNH75RbdII8Xl59DLQpzM9NPg
         qAVA==
X-Gm-Message-State: AJcUukchR6R09hKH9U8wynuzol5PFSv1YcXqnlBHyhfMKpqqBgW+RuOB
        jVXHgC5Z5Pc5ZDpm4oXorAOp5Ayp
X-Google-Smtp-Source: ALg8bN6q52ReVkltzlA8UTTPWtGeLY4qwXIRPbkHXS3y9BkoyEoWjA/hUB9CkQHD/0IJGegBHkBk2A==
X-Received: by 2002:a17:906:1859:: with SMTP id w25-v6mr6894146eje.3.1547645775127;
        Wed, 16 Jan 2019 05:36:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e14sm5541257edb.79.2019.01.16.05.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:14 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:14 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:35:52 GMT
Message-Id: <52fb8e72fb09a5b02e19de172ee28684d35af0a6.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 04/21] ci: inherit --jobs via MAKEFLAGS in
 run-build-and-tests
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

Let's not decide in the generic ci/ script how many jobs to run in
parallel; it is easy enough to hand that information down via the
`MAKEFLAGS`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index db342bb6a8..80d72d120f 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -7,7 +7,7 @@
 
 ln -s "$cache_dir/.prove" t/.prove
 
-make --jobs=2
+make
 make --quiet test
 if test "$jobname" = "linux-gcc"
 then
-- 
gitgitgadget

