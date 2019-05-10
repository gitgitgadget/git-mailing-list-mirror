Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16081F45F
	for <e@80x24.org>; Fri, 10 May 2019 19:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfEJTo1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 15:44:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42550 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfEJTo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 15:44:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so6571868eda.9
        for <git@vger.kernel.org>; Fri, 10 May 2019 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:to:cc;
        bh=BiYMIzh1jW2BTnESi46ognmoYd3wPI5ae7oWErHH1qo=;
        b=se+emDkFDIor8G8xEHQyQ3fS6rvRiKS4W0SCDg6Y00fZf6aKVCSYjlf3aJn4XXFBdu
         XmhnvgICBpgr46Y1jRiRI/PkDUHZRriQyokYlWWy9oom+nv+Low9XtwBgvQggPBuT+JY
         Ny3kvXj0nk0VJ1ans+mpDXyiYjZfiTtVlJQgf68laXngAfU8SZtjPSWGLJODSMVb1uPQ
         TT8qbYATE59tbFrwjSLl+rH+R6edSeyShq0wdv3L44nbyZak09o8A3XtES0ICLDaFgfg
         LT5Q74Zi0vrifNyhWlV0NmK/54JI3uSOQ12sB/JnvibLxQKEV6naJqrNsp8bSRH0NyXQ
         3+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=BiYMIzh1jW2BTnESi46ognmoYd3wPI5ae7oWErHH1qo=;
        b=bQt2mqwenKDCS6tuPipuywEyR+9ariBmKFe246n0hN7dsG+l7RHLdFdvdtqjKfC6Jm
         OnQkaAmDHVQ9bO+jk3+r/G84MpwbqnS1xBSWEh1C0SgKRSgjBI9RRQ4Fykl1FGU1tuQq
         xYD0lyxh0ApE9YfevN5zd2KV8tcuckXQTmTsU8+F3iQs5WjANViV8gwSNK8lqc9b/pIT
         ISn2D7e6uDVz8iisjol2cDZ/FT+zxwwie9s9TJprplTjgwqXzKbmNiA28fNKqdwviH+M
         If/Lkna1msX2h3UfWyg8eVeYV2fLu6MJuypYzZz993YSOroXrvgq3PS5ZmpXPJtO89Sg
         c2Og==
X-Gm-Message-State: APjAAAWX/WilmRdGYv+hWFTwwhHLjKsKXRGnx3fbAwo+O2iP/bf6rtqo
        HZlLGLvNfNlbZd5IKYdaNYDout7d
X-Google-Smtp-Source: APXvYqzoeP/me2LrGpfTt7hfGBi8BdlgJbfz91I7XhprdixmS3Hqm/deG0V+eiQb0Yef/YTJOqmYqg==
X-Received: by 2002:a50:b6cf:: with SMTP id f15mr13357675ede.192.1557517465681;
        Fri, 10 May 2019 12:44:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm867754eje.7.2019.05.10.12.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 12:44:24 -0700 (PDT)
Date:   Fri, 10 May 2019 12:44:24 -0700 (PDT)
X-Google-Original-Date: Fri, 10 May 2019 19:44:23 GMT
Message-Id: <pull.189.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] trace2: Add variable description to git.txt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff is out this week, so I picked up this request from Szeder. I'm very
open to edit suggestions.

Thanks, -Stolee

In-Reply-To: 20190510172824.GR14763@szeder.dev

Derrick Stolee (1):
  trace2: Add variable description to git.txt

 Documentation/git.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)


base-commit: c173542c84cdf5e71b393e91f9d9664a85f995b2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-189%2Fderrickstolee%2Ftrace2-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-189/derrickstolee/trace2-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/189
-- 
gitgitgadget
