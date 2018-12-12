Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31BA20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 18:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeLLSOx (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 13:14:53 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:45956 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeLLSOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 13:14:53 -0500
Received: by mail-pl1-f169.google.com with SMTP id a14so8957687plm.12
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 10:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4awvIOXy8RU750pA3hiYT90Dysg3dlHsWtkupb6yEvc=;
        b=Ny4VcPG+peLuiXExPstDRSufqYkUn+5El9RhL1LiFKgLWcTYvBYX6ldoYfaSAECftU
         JrJRJWbT+UKryAOR1IXbuTEB+CBOtiflYDcR0nCqmKEc1zpKIinzU/swCEju6vLNpRnF
         NdEQnP/pXfA0u9T2PTNuPO0BpSd8ZALe8QPt/q84hif118LiqluDGq8D02ptYZq8AgXp
         88OM2x/qVYfruG0LGMG0z+s1lGTEJ9G3kU3AXeouRADFe+5RjRIV+zDFECQzFQSRGYKS
         vihHgE77N4+SGDtl1xIpefRoWnT8ADHbXQ0l11zf9df3c/6SugyW8hT2M7JKckrtIzsk
         vbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4awvIOXy8RU750pA3hiYT90Dysg3dlHsWtkupb6yEvc=;
        b=OKPZX/Tbl3xnmdlMLUHs9Ud90Y88tPTsIrwzHKbo8+/lbV+8TqmJPzgdBJqfgEragH
         /tOqeKFgKnsQExDoFByJpotT6Ju+/+j+SkXHx8b0AUAou8Ygn0PLRD+9fNdnYxQ3FZ+s
         TBnF7SjWsPvT13RyAuKIhW/4vPRWnKLIq4f+arFBP34mM4aTIM9kVR6mo/M62uintaUT
         cogpdRi0/ygYyI/kTD5f1R2B+rJ+cP2NNAXvkbitIdGC60dbo+fScHCRpeV4EyKQUD24
         8RDUQLt69Pi/GoYigNOqB1hW4OBGlHcNghHYx7pB59iAVZqvQAlobf2we7gicdjz/V9y
         jmQw==
X-Gm-Message-State: AA+aEWZBb/z2sEBmRduTcsUJFDb9hq33hrh0K4bpqt93YbvQhRvPRUw9
        nFBmq6boubiZ0P+CH14wAWngnq8f
X-Google-Smtp-Source: AFSGD/U45FoWIpVhJ9hT+crz0DRh2gifaHt/VGhJewJfgMrl7QXbhY0H0/3Ufxg1jN3SL+RBFGepdg==
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr20191643plc.326.1544638492414;
        Wed, 12 Dec 2018 10:14:52 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id v5sm31122124pgn.5.2018.12.12.10.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:14:51 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:14:51 -0800 (PST)
X-Google-Original-Date: Wed, 12 Dec 2018 18:14:47 GMT
Message-Id: <pull.98.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.98.git.gitgitgadget@gmail.com>
References: <pull.98.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Add more eol=lf to .gitattributes
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

I noticed that our CI builds (see [1] for an example) were returning success
much faster than they did before Git v2.20.0. Turns out that there was a
test script failure involving the new test hash logic.

error: bug in the test script: bad hash algorithm
make[1]: *** [Makefile:56: t0000-basic.sh] Error 1
make[1]: *** Waiting for unfinished jobs....

This failure was due to an LF -> CRLF conversion in some data files in
t/oid-info/. Don't munge these files, and the tests can continue.

UPDATED IN V2: Unfortunately, I didn't check the full test suite after
getting beyond this point, and found another LF -> CRLF conversion problem
in t4256-am-format-flowed.sh due to example patches in t/t4256/1/. Add these
in a second commit. Thanks, dscho, for helping with the correct placement.

Thanks, -Stolee

[1] https://gvfs.visualstudio.com/ci/_build/results?buildId=4815

Derrick Stolee (1):
  .gitattributes: ensure t/oid-info/* has eol=lf

Johannes Schindelin (1):
  t4256: mark support files as LF-only

 .gitattributes   | 1 +
 t/.gitattributes | 1 +
 2 files changed, 2 insertions(+)


base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-98%2Fderrickstolee%2Ftest-oid-fix-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-98/derrickstolee/test-oid-fix-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/98

Range-diff vs v1:

 1:  4a22502a31 = 1:  4a22502a31 .gitattributes: ensure t/oid-info/* has eol=lf
 -:  ---------- > 2:  4275b8a581 t4256: mark support files as LF-only

-- 
gitgitgadget
