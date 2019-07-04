Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418F31F461
	for <e@80x24.org>; Thu,  4 Jul 2019 22:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGDWg7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 18:36:59 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37187 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDWg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 18:36:58 -0400
Received: by mail-ed1-f51.google.com with SMTP id w13so6597499eds.4
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 15:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SqZJ5OMEVQPSWV1we1JDB1EUnwDZ0/fbccaMbsguJuU=;
        b=jWDqIZqoGD3FjQJe+czsjvCHR/Tof/VBaPuV4HYICqDMGc5B2U4PTckl0ZgmF4uHod
         HKvWfIDD7DGSLZU1YPBzsIlUZVqaW2iL0iIN8PlNJQFB+52lNE4/X7pJjrkZPqXkRNFm
         9uFLPIB4wyotV1ygY1czRrjwJ/FCGmFWJe4jdw+Y9VaK/ZKDGJaweybWIie1gWJEL4+x
         /z9XVJPGKlrQIfDTxbXF+JjgIWbAz0o3zJ0OkZw2ll8scVW7xqL/VD6d1qEj8cclXLtN
         gQadvfHZ55sakTeI8jv8TUJemwzUExTNGkuLcnwrLH8pEJZb0a8ObZ9p7yVggBwQrCuK
         Zmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SqZJ5OMEVQPSWV1we1JDB1EUnwDZ0/fbccaMbsguJuU=;
        b=T0kf7YiQZriPd8z+ONjyMMijCLlhtzxORiTY+/KvJ6GOK9VXUJ35g5qQF22cSdHIeX
         /rMPiaqoDE0LCI8QDR6jGvUZ+/v2YUdSfxq0EX8XkbigSKY8R9KhYTJ1ItwdmUc7jSkH
         nkm568vuWXAPGk+vEohfTf4QypcrQ6p0Fx1t6zkGrLVDrSyfszj3MB1+tmpU4FN/OBur
         qo67xFXtyla3qdi0wyEpihb1uDSvNUXjc9lgUySzXwLv1bSTsyjUk1+/xbDY53WmUm6v
         UG0nNgOmyEuXni9QU9Xq6yFzCNP7bdmmly+v4WrF7bHfXXWjKAHFc7p0xW6XoFXhPHWC
         TQBw==
X-Gm-Message-State: APjAAAU6Qaf6mqwmfxfmXKUtJ530K3pef/ONRldJF+vOji+QQqgSqpq2
        DgYacCUcPkjhE8ApyYUD0vUhE8xp
X-Google-Smtp-Source: APXvYqxTgqlkOBO1e2rDeOQCGJS638hhzdiZF+dJQYIg4JkHh9IrFPuhXkACwDA63RjGz+XKqjB3vA==
X-Received: by 2002:a17:906:2101:: with SMTP id 1mr530272ejt.182.1562279817157;
        Thu, 04 Jul 2019 15:36:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q50sm2051291edd.91.2019.07.04.15.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 15:36:56 -0700 (PDT)
Date:   Thu, 04 Jul 2019 15:36:56 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jul 2019 22:36:54 GMT
Message-Id: <pull.283.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Follow-up on top of js/mingw-use-utf8
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A quick fix for a patch that is already in next.

Johannes Schindelin (1):
  mingw: fix possible buffer overrun when calling `GetUserNameW()`

 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 94238859b9809afc806919cb7022a45cdc8e6748
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-283%2Fdscho%2Fmingw-use-utf8-fixup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-283/dscho/mingw-use-utf8-fixup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/283
-- 
gitgitgadget
