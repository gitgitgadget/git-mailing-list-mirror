Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C371F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfAWOkW (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41343 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfAWOkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so1862126edc.8
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yjmVd1mMTh5O9pgiFT5EpWKGV+TAK5GJK5Kpo9RboIc=;
        b=jnLssD+aKSTCVyuhVYoeUmcFD5v1+zIpK3EiucJzk9KcwLArNyzga2336+/XFvbgNU
         nks4zYXQgtWmGn5bxNa1FKZi4o5ADEukmQvz/sWqp1/b7v7pJTFh9uy3GYU7oK2kJ0+o
         5JHBtc8CMiDeTH891zbQ+WyyOI5DYxcZUB4z6aJ+NECcKoiyT+/04thchqVxfmFRQy5h
         fV3UHofKSN0aPSh46eNndIMbJdaOy3Hg564nkb0Nb6mW601mVc9QvIOvNSqQKPTcBq8s
         6XUNanSfhzDsP5YlFQdc+CY53edwn8K22SGmz6QtaEmcrgUFJy64IwhgQT847PyQNGNq
         LHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yjmVd1mMTh5O9pgiFT5EpWKGV+TAK5GJK5Kpo9RboIc=;
        b=NLm2nir+j95ndhmMNrPH+k4MnSn9b1WV06JMSDXfcM2hMy68wSmBIkhDBBN0N/X2tm
         cHwHPQyKjdhNX7Gpwo51thRW4A2AJ6OpHOyzCFMIj0hPLXuolZRyXLZI4yrXzuf0Dy5K
         3gouDFaLb1sz6j4lmsn+x9+cEUC17dOww+fdwIlYWmzcaxgJei6YMhocCm4AiEr4eQTg
         IONb54VC243k86qhHTWDu9FfnZ9IO7jcwG7VQzogWoi1HDL+pFBVKkZn6+E5jf3OSHz+
         570NFP9uW/OjQc23RaC8SWF6Wob8aNg/4vA1FZRzqWjbNr5SS6QzL0EkVD1tc3OuV2r4
         /rmw==
X-Gm-Message-State: AJcUukcyJ1cB+uIAKyl4puD3nEIe08IVy7Dv3g9Wi3Ul5v6RST2ore+X
        hD4kPi65pVcfKRNTayeJCPcqCzwx
X-Google-Smtp-Source: ALg8bN7bXhy0SD+I5B42IE7jUFMbhEiDgxXdxBuvioCe2ShKkCYp5E4myQygxVooafZeyFV4WzgS9w==
X-Received: by 2002:a50:a517:: with SMTP id y23mr3017202edb.219.1548254417538;
        Wed, 23 Jan 2019 06:40:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p36sm10528133edc.78.2019.01.23.06.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:16 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:16 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:39:55 GMT
Message-Id: <83b92a87e7698cee1e2c44252b934ad436d75a90.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 04/21] ci: inherit --jobs via MAKEFLAGS in
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

