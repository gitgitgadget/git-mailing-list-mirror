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
	by dcvr.yhbt.net (Postfix) with ESMTP id 414731F464
	for <e@80x24.org>; Mon, 23 Sep 2019 10:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407493AbfIWKEX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 06:04:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51281 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406082AbfIWKEW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 06:04:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so9176573wme.1
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=boyh9ijQPDdiyl4NROjLD5lu7B8Emd4KQBACazYUUAM=;
        b=iWcLUzuEHSmP9IADlrGegrEanygrffbaUfX761UZpXJc0t4tGi2PYMjISdbbV7MgpR
         anhJhrpjQkUiWvISx3B8hFaV1bgDhOM+7PiFaqFHJWzfOXV/1Gk/qRPtlwcUt5X2CinE
         b9zl+QzThCDteYcB++cLIdvln370o3MvVGvgMIC/iKbHaSpFcKkVdZ5xoUKaq0+ZZySD
         oBt8WkT8qGzD7c4QQ96KYMrH84Ah5h5vuYqVw++W90E2Ia4aK1XBjQECRxIdilR9EI1m
         mpqXpw1Epf/jF3oYqLwgNPP1Wdyz9zV6+oItkvrpPjUbX5ZG0Qf3Anre8bVWhbx8SMq+
         04dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=boyh9ijQPDdiyl4NROjLD5lu7B8Emd4KQBACazYUUAM=;
        b=Oj1Mz2fmqe4LCD3z8FvbK+KQgX99fPbaItnL7hQjU39/A5hi282N+xdkNn6LMfmz2+
         xXo6i2dDWQW4dKbAW+sbStxw7We+I3sIVckrSXotWtoUipAI9aJUfx33a3dYTtrPgz0S
         0rxfz/ZQKJh6z0V3UBX+RN7bwq14e/Qvpl2/OeZnOs+B3cktsCDtGzTc5BqRA5V5NuKb
         BPymN5/jNFqFU0eN0yGtfh0vc+gkcM5mrkSBqzGJhBIvT5l91Aft6fPJWv0KgUwpBuKk
         NZnIIc5xSay85quO17lW0tK3C6z/wDaTnTirddvb0HNZdP0Xuao+Kif8pU8y0pVUZvzG
         0nmA==
X-Gm-Message-State: APjAAAVGjfEb01lXuJTpJBnoup6245XovQx6QC/GcliJozNcAT5XWjlq
        sco62+ayh/CYPhvEN75fkQpoLnMt
X-Google-Smtp-Source: APXvYqxWBAloVjZ9UbaLy8CpVXyFS3IdAaSyZVe1+frjxkfErIIfNdhspdQXY2/4mDeO3ck4Jk4NEg==
X-Received: by 2002:a05:600c:351:: with SMTP id u17mr13951023wmd.130.1569233058821;
        Mon, 23 Sep 2019 03:04:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm21873269wmg.2.2019.09.23.03.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 03:04:18 -0700 (PDT)
Date:   Mon, 23 Sep 2019 03:04:18 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Sep 2019 10:04:15 GMT
Message-Id: <pull.347.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.347.git.gitgitgadget@gmail.com>
References: <pull.347.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Update: fixed typos in commit message
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

Commit 1/2: t0028: fix test for UTF-16-LE-BOM Commit 2/2: t0028: add more
tests Please refer to individual commit messages for more information.

Alexandr Miloslavskiy (2):
  t0028: fix test for UTF-16-LE-BOM
  t0028: add more tests

 t/t0028-working-tree-encoding.sh | 41 +++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-347%2FSyntevoAlex%2F%230189_t0028_fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-347/SyntevoAlex/#0189_t0028_fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/347

Range-diff vs v1:

 1:  fe850a8cd5 ! 1:  d717a60932 t0028: fix test for UTF-16-LE-BOM
     @@ -2,12 +2,12 @@
      
          t0028: fix test for UTF-16-LE-BOM
      
     -    According to its name, the test its designed for UTF-16-LE-BOM.
     +    According to its name, the test is designed for UTF-16-LE-BOM.
          However, possibly due to copy&paste oversight, it was using UTF-32 file.
      
          While the test succeeds (probably interprets extra \x00\x00 as embedded
          zero), I myself had an unrelated problem which caused the test to fail.
     -    When analyzing the      failure I was quite puzzled by the fact that the
     +    When analyzing the failure I was quite puzzled by the fact that the
          test is obviously bugged. And it seems that I'm not alone:
          https://public-inbox.org/git/CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=jePxhw-o9Dg@mail.gmail.com/T/#u
      
 2:  d5f6f00a51 = 2:  40e54cf5ce t0028: add more tests

-- 
gitgitgadget
