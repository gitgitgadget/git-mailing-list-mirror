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
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1E01F463
	for <e@80x24.org>; Mon,  9 Sep 2019 23:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfIIXVF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 19:21:05 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44554 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfIIXVF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 19:21:05 -0400
Received: by mail-wr1-f41.google.com with SMTP id k6so4233848wrn.11
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=JKZ6J1eFVWT6lvSDUxLqtsCMEiwve4lUnOLLCWQd4v8=;
        b=qoaiCoSaWuqGOzSWMBHuWFZ/JGd2knmKXqDeCWSl2fGIFmDTdB6TXVMF9p5dHnd3HJ
         TcI0hmQitkGJejX1b/X7kkEuQeT+9+326ycM9f2vFBZsXzt+1jKKdRzZhA0NhCDMTxYT
         AerPTdB0RWFUmS0QXgNejC2hVikt8lTgP8BH21Ph99dvo3He39xwwaPS/8ebRkmJ8UCz
         OvFN7pvOkjavTzRcaaGNTBKml9uGsli7qrKSk5tXDe1c7jb6wHZDdoHfQL9qi4xl0kX0
         USOGMxrUMwO1MXa+K7lryjGpoEvNurIFqhTYCTAc6tv+Awka3kCFC6/jH/TT2SScC0tO
         WtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JKZ6J1eFVWT6lvSDUxLqtsCMEiwve4lUnOLLCWQd4v8=;
        b=lf5VC+GEV0GAKr4jgiCOEIn4ADL9N+QyJxpkxXWSmYzDzIlhs61PD/NIKtOj1P/Cu9
         yq/mJ/RkdW4IyuDgi8xSD8ZXiwD3YzJA7pZ2UVFioQY5zGS43gurhQELrrIQvJQkWeiV
         Qa++U2z1Zc/Aqj2EzM6OgNLTqXip65DqEGyVgWMfNKeaxtNgtHx0q1Fsaffo7OUYVKCQ
         CCZP5epofk7QPxO/OJ9uw/XRuEcFkx5Cfej7jFImpfpKPKG4tZWdkKRihmPyTGEzrb9U
         xf2pX/cRYXX8fUgLA5DzAWBu8IWW0rSimQWNE49i7Zy1fxYCDsXQ/TRmhGHpKFtyqEai
         XGzg==
X-Gm-Message-State: APjAAAWli312h2/JzyTwcvfHzMzSDRRp6S0AEx35ie58pM2VXug56XU4
        oQ1A8iRsvuWcfaSaiuJKFlVYJmGA
X-Google-Smtp-Source: APXvYqwVKgHgicxRPrHZsRYQwxHWD8E9P+8ZbsWuoEBZ3L56VapcY99wjW5ibzZOif84YXUtQGNYlA==
X-Received: by 2002:adf:fcc1:: with SMTP id f1mr21448194wrs.308.1568071263200;
        Mon, 09 Sep 2019 16:21:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm890175wmh.43.2019.09.09.16.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 16:21:02 -0700 (PDT)
Date:   Mon, 09 Sep 2019 16:21:02 -0700 (PDT)
X-Google-Original-Date: Mon, 09 Sep 2019 23:21:00 GMT
Message-Id: <pull.330.git.gitgitgadget@gmail.com>
From:   "Cameron Steffen via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] doc: small formatting fix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edit: I need permission to submit please

Cameron Steffen (1):
  doc: small formatting fix

 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 75b2f01a0f642b39b0f29b6218515df9b5eb798e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-330%2Fcamsteffen%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-330/camsteffen/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/330
-- 
gitgitgadget
