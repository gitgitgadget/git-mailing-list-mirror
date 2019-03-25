Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7341C20248
	for <e@80x24.org>; Mon, 25 Mar 2019 18:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfCYSOY (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:14:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42423 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbfCYSOW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:14:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id x61so2733243edc.9
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cfj03u7cjqe525OLOvGdFTd7m0oyq4qTfT+sl2XCBrk=;
        b=oNxDpvYsE7LJuAyzxDheNmt607L1zFSz/NpycKF4GZpt5sRr2Yv19vJeeiYi3TE8ib
         JlHxFqorP+FsaJGYDk0CxlTa36wzZk8yWtB7ewq9WXnYQK66eH1TdFvUpLLg3LvFvUal
         hJ3FoXIJL/QLKRcWN5b33cr1yPGMkJC3Y2o8xL2h9023oNcMnLe5JXl48bnbL318Q48V
         S2S9sdnSoeBLFAUNGVQA0ZuN8qCLHKGRk/LN5ZLGHuUlrCuq15yFGR24+B1Qmpbr9uj3
         PqmpIepnOUpXwgLRikbHjxBYoG9ofhwt6aivSuX1MV3tA/khQaNPFcCvJwF7UwNb4cvd
         rtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cfj03u7cjqe525OLOvGdFTd7m0oyq4qTfT+sl2XCBrk=;
        b=DDozu3eG4poGsC8kWdScnN5HJxee7pKU87RtQgYJ54cwqJ0JafnA6t9WdPq2DfP/yd
         8Y3NNNWSjYj+Ffug0Qgbc+6WUh7VDZ5Rl3sWuKysFHUJa6Rpfzaa4IazvfQ+EfjaRRdJ
         ArJDtdmTg2OnZwakJ+Heq6wHp2TPJhvrPH7BVArL//sRBSF9fFjLgL0+NoID7FuexBXm
         pdSfqmrDtWVezGixY0YtmqYdtGuGJhgnzRtC0KgFbOL1Owo0j/tTibyIIr5z6CQQJ2dJ
         CM2mX0jlvRsEdD6vKnfpdQGqY5hoV7eIOgxYipAtO7STFceMJAnXjzMtTuxHZPh5ceHE
         8nBg==
X-Gm-Message-State: APjAAAU3Lx25Gz4qcTzyQxqzXIQjzrg8RvCBFNMh3tlZhqE4sQeT4Fxj
        QpjNgLU7wAII+mGAtvo0yNrAXEDU
X-Google-Smtp-Source: APXvYqzvnp+jfqbFwr+MJ0/nISdIv/7yqsPKEWPvQdeRw7fY0OYNjvL4jfry8Z/Sj9gwaC43WZOvyA==
X-Received: by 2002:a50:86c3:: with SMTP id 3mr17426012edu.143.1553537661109;
        Mon, 25 Mar 2019 11:14:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h34sm5794029edb.13.2019.03.25.11.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:14:20 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:14:20 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 18:14:12 GMT
Message-Id: <f45c435e4acb765a68b83ab2c5127388c59dc0b1.1553537656.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/8] t5531: avoid using an abbreviated option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It was probably just an oversight: the `--recurse-submodules` option
puts the term "submodules" in the plural form, not the singular one.

To avoid future problems in case that another option is introduced that
starts with the prefix `--recurse-submodule`, let's just fix this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5531-deep-submodule-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index e2c37fd978..4ad059e6be 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -363,7 +363,7 @@ test_expect_success 'push succeeds if submodule has no remote and is on the firs
 		) &&
 		git add b &&
 		git commit -m "added submodule" &&
-		git push --recurse-submodule=check origin master
+		git push --recurse-submodules=check origin master
 	)
 '
 
-- 
gitgitgadget

