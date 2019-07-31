Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12EA1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfGaPSm (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36753 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbfGaPSl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so70201335wrs.3
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wkM+iQk9qt45nO5GdFfBj8vlZYMZkTEN31kG/b8MC/E=;
        b=h3MmqxLrWgRBPu5ghpzL11eNli92eYrEABpRpDJqDkg7je1brMhGA4nYEtKWJqPld+
         JhHid/uFWV0Ipy+WHYMDUGhanj4h0rhtT/nGlEFL/CEDrNfBG7elxZG3k+iVVhIFqPiv
         R50Low9/bcxUOCmmdK5hVGvSEIV68TigCF/r+8kVPyhw3VhtEk/R/W5TI2F1rAR6cULB
         tklzttWteOM+3Yz6xPI5/AOVl5D2VAKlSVg+0OCx9Y3Tk37JuXL0sxWgMx0vFiLvthrW
         rnO/5Gmj1SrGtTitPaVxDnzVyGEk5kBvjIYYenY/skmctaVqlnWBY7h15BfWVcjuQSW4
         IIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wkM+iQk9qt45nO5GdFfBj8vlZYMZkTEN31kG/b8MC/E=;
        b=bwJGQNOEq/sOjqjMoUGE6N33HjA3sGitKuAAZnXRmCF16PNfZo4kWf8Qkz6CTGWg5N
         Kdwd7VsDvFrI2A+ZfQVIK2ursfuq47A9LAVnJwksSdWfD7gjuiru1qhObBfzI341m+1q
         GbLkd5Ltpw+p7kVwndP+S9rrsc78wKqjOflu5xvjRjJLH8U+hxSzyhaq66CHWb+QeLUi
         J7Dw2u6UOt1ZoZteTqtfj0YmebO8iqAf2iyuBpKDOBM3AH/YJT3sWIclYTetHEvX+Gv9
         oilZh5ynXm4C/2xUGfrmDe/jMFjVzoC9o1nOnhb1f+JCFH0WFy7oOTYVi6Qeo5OfKNBh
         52wA==
X-Gm-Message-State: APjAAAXxEy4af+vSYSWSORcacdsXwFxtMNQl4//0ye50AR05hmyLYdd/
        baz8cB2B26oKFG7rTWTh4ONPXJVl
X-Google-Smtp-Source: APXvYqyupGkZm1WxX0E5UqFqlvl6szAV3c+XMPQ79hrmITHrb4JSPh/mJS9Cu/83tW/Vzu2+vilqMg==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr127893651wrw.73.1564586319820;
        Wed, 31 Jul 2019 08:18:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm77664394wrn.81.2019.07.31.08.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:39 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:39 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:22 GMT
Message-Id: <6e8be7d87352cdd01d92cf4d608b4e32097db27d.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 02/16] t3400: stop referring to the scripted rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

One test case's title mentioned the then-current implementation detail
that the `--am` backend was implemented in `git-rebase--am.sh`.

This is no longer the case, so let's update the title to reflect the
current reality.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3400-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 42f147858d..80b23fd326 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -285,7 +285,7 @@ EOF
 	test_cmp From_.msg out
 '
 
-test_expect_success 'rebase--am.sh and --show-current-patch' '
+test_expect_success 'rebase --am and --show-current-patch' '
 	test_create_repo conflict-apply &&
 	(
 		cd conflict-apply &&
-- 
gitgitgadget

