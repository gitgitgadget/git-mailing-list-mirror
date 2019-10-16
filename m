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
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE8E1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 12:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392883AbfJPMK2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 08:10:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44474 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389612AbfJPMK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 08:10:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so27757569wrl.11
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=5Pjj3HtSQ9gArsTZWOIUOqyin9BU58TtlO1h8WBK4FQ=;
        b=L67RZ2T1UYpMnKEr2X9j7ivrQmkHnj55Xx8GL+2LrBfCfWDxAU7R0pK+7yfBpJY9P2
         8q5AcbT+vHRmqz3ul3kjwLMnpiL+PEBkiLywwg+6b1lBFmq9o/O7AoxEaYr3QscIE7Sw
         +YkMJB7O2Wzw2yIuKB1bOkKrkxDiSRGAn8Wp+mQ6ErlMVHEgSNA1zaOtkDuO5Klt6dbs
         z7iNJYuVDcj1MDFwdwD04Dd18x3nALT00DRuhM8QTiFsnAcCYJCDgbRCmf9NymFgSwJC
         filpDcEqHOlm/d3d5npaEsOjV5UAPcEcbfxRIfSCwfRIAqRItHGrgM4TZBvoJG4BXWxs
         r6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=5Pjj3HtSQ9gArsTZWOIUOqyin9BU58TtlO1h8WBK4FQ=;
        b=tk4Sllw1I4N/FlC2/lWKG69Gwyar4paG1n1pk8YXDSw5cWzcHBH7XqzX5YYqKIr+RJ
         oYlLvnUOTgEQz1+/1Kkrj9lDngg/EdsEdgPY+dR+cEASd8d4zzjc5w4sFqXANsH0SlIl
         d/8/Kj+4diNch4AqeE8WxCeYSmkYrP0p/wI8SL4Y/gUZmQEwpA1x0jP7Mf9U2eITY7z3
         utv6m4fhyCA5HDBLwAdZOZNyamt2g/nEb3dDGvKORIcM7m7T4VG7ZuBH4aPQ7eBMoZ6r
         MFCc4vo4hlzDzvQOOv3iYh/sPYgZp9ghJiUD2oG8XmRyBM43O2TQio8oM+2HMVBNBq2A
         X2og==
X-Gm-Message-State: APjAAAUspsP1PgPUXxNs7dPq0egIKuzygXmOqb9aNw6v4EP9sthLqrmN
        qzNpTEuQcoGQzRY1O+/x/HCQ8MLH
X-Google-Smtp-Source: APXvYqwvOhRA/ycem3qsvaBNgx2uhoOASRBHSdIcsuktc9VcihAY5Sk9BsdoniWuXiAJL2SsQC5mqA==
X-Received: by 2002:adf:f40d:: with SMTP id g13mr2281227wro.368.1571227825391;
        Wed, 16 Oct 2019 05:10:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w125sm4436218wmg.32.2019.10.16.05.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 05:10:24 -0700 (PDT)
Message-Id: <pull.402.v2.git.1571227824.gitgitgadget@gmail.com>
In-Reply-To: <pull.402.git.1571227613.gitgitgadget@gmail.com>
References: <pull.402.git.1571227613.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 12:10:21 +0000
Subject: [PATCH v2 0/3] Revive 'pcre2-chartables-leakfix'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I had stated several times, I was really unhappy how the original fix
harped on nedmalloc and totally ignored runtime-configured custom
allocators.

So this is, at long last, my attempt to give this a new life. It is based
off of maint and needs trivial merge conflict resolutions relative to master
.

Changes since v1:

 * I managed to mess up the authorship of 3/3. Sorry for that. I fixed it,
   so that Carlo is shown as author again.

Carlo Marcelo Arenas Belón (3):
  grep: make PCRE1 aware of custom allocator
  grep: make PCRE2 aware of custom allocator
  grep: avoid leak of chartables in PCRE2

 builtin/grep.c |  1 +
 grep.c         | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 grep.h         |  2 ++
 3 files changed, 47 insertions(+), 3 deletions(-)


base-commit: 51cf315870bbb7254ddf06c84fe03b41bc48eebd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-402%2Fdscho%2Fpcre2-chartables-leakfix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-402/dscho/pcre2-chartables-leakfix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/402

Range-diff vs v1:

 1:  4feb8cc83a = 1:  4feb8cc83a grep: make PCRE1 aware of custom allocator
 2:  191d3a2280 = 2:  191d3a2280 grep: make PCRE2 aware of custom allocator
 3:  f21b2c9eb5 ! 3:  f8724fb267 grep: avoid leak of chartables in PCRE2
     @@ -1,4 +1,4 @@
     -Author: Johannes Schindelin <johannes.schindelin@gmx.de>
     +Author: Carlo Marcelo Arenas Belón <carenas@gmail.com>
      
          grep: avoid leak of chartables in PCRE2
      

-- 
gitgitgadget
