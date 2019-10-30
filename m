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
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C961F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfJ3UVZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:21:25 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36626 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfJ3UVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:21:23 -0400
Received: by mail-wm1-f49.google.com with SMTP id c22so3602178wmd.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Oj0Pwgx/DbT64Ae97zx8HNcYpnAr1adyT+mFFmz5A5w=;
        b=QcySvj9XX3bOZkulgWoPEEIybVFvKU/jtnUESK6A9GdVKL2cU0DE0muIh5D5amWLvr
         SLiVyTQPNP0AM1SjdZMN8V6ZPvNiiucT0FJ8V6DwkWrmn+ODB/v5MfthSgp2Y8QhrbaV
         b5B+U+Ws4IRdNsuFpFpMm0wsPt+A/93JTFAye7DdIn4Ccy3DczGfi98zuvpfbL2iltm0
         kwbEZyT7QYqgtz+N+E2N6aarzgRaIJSwiFmE0xqJxOw+McXF1SEityfYIhxNooVg58wG
         o2ZYEMLpMtCUhh1o3Hjf/J4hiwFoas/QFWGcSL8zWDvYPXUhg9p5nIg5mgy80zBHEQRD
         m4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Oj0Pwgx/DbT64Ae97zx8HNcYpnAr1adyT+mFFmz5A5w=;
        b=lnLz8XdzEvCNkg/cOeYr6k6WaMTEuXqhY9ajMiVD3z9/BewQ3Cprx1NcW73Jit00mD
         LoJGmDE+pvOztVsAELqID3Xl7Xu3Gea2DZJc7FYiBhaUiLFEv7z7VtosaRKPNc31iy33
         QBx/YwGRCz0P2jmckHS3wjnZDhraAUjNRtKfq1qw99NvplLGMlivHgFh8YkM5OKAF/OK
         +nMte9jJKLjLnzP6rbLgebL0aUIuGDO1qMrLEggTA7MZHCjX1dEQMbBboq6dqpRaWnal
         7Zw+CNdhoFcXwZu2y39YmeQO907WTY5ZxgA+aaTmZp6i1RNdogotEJxmEGWwg4Y2BNUN
         re8A==
X-Gm-Message-State: APjAAAXNiWmSufWUoOcgweq8nBzz10J6sdLax1C9mLtkVw+J36GJWHgj
        aTqzpB4V6m0fPfI3ijtebd1XS2PT
X-Google-Smtp-Source: APXvYqyaRhAgoaal0rUeGXUxAXE4GBgWlIiCTHWpBX/XA1D3SI7O0ZXGdxPcGAHdMvkWCv1JwaNf8w==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr1268235wmb.127.1572466879752;
        Wed, 30 Oct 2019 13:21:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm1391816wmj.0.2019.10.30.13.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 13:21:19 -0700 (PDT)
Message-Id: <pull.440.git.1572466878.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 20:21:16 +0000
Subject: [PATCH 0/2] 2.24 release note fixups
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

A couple minor fixes to the 2.24 release notes. I split into two trivial
commits just in case folks don't like the second (perhaps some wording about
no current plans to remove filter-branch were intended?)

Elijah Newren (2):
  RelNotes/2.24.0: typofix
  RelNotes/2.24.0: fix self-contradictory note

 Documentation/RelNotes/2.24.0.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)


base-commit: f21f8f5d35b09ecdd1a0112f114436fd2eda7df2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-440%2Fnewren%2F2.24-release-note-fixups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-440/newren/2.24-release-note-fixups-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/440
-- 
gitgitgadget
