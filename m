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
	by dcvr.yhbt.net (Postfix) with ESMTP id 588811F454
	for <e@80x24.org>; Wed,  6 Nov 2019 12:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfKFMsd (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 07:48:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34253 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbfKFMsd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 07:48:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id e6so23752106wrw.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 04:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=M4ub0HFJkUZUPNNfjKiqMFViVeBR2v4pb0/1vLQnHV4=;
        b=amUXH7W55xDNqxGi/6/tXynK8sxi5m+MnVbY/tNjn5B3nozX5f7tsdf3B3W0UMvs4N
         pHXfBGSXAf4/w05Uvgy1m9VzuaeZ4rKRHEs//RHXh7E3BnAheTh5GfmGFQzqUbc8oPuL
         wZBFUGESfqD7pzFabvyWZ88NyX2sNjrBbS052+KLlPSXpjk10FWVa5WBJPOR+xE8bAUd
         U9z3JF5fhBB+TrHgH9QNqUsy7kUlnmC1nHe0NGzknd5ABkdTODPZPT3aT88YNAvZv9Ma
         +WydvGuL1F1YnSSog3wsSsBtIhTKphODxg41r9s2zWotW4IPpjH8z238KlARwxbe3x8E
         Ij/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M4ub0HFJkUZUPNNfjKiqMFViVeBR2v4pb0/1vLQnHV4=;
        b=MUJLyDS5zCjwcx44Stj7MC2g7ubrXXn47t5nXG36TivzkDbX83RJeQJWgW95YUU65B
         NQ2igXhFfYN+Rf/p4C7+MulIyBgdpwu2v/hyqmPb0LVIf+vRD390JGBzASkbibinRHEg
         DS9WZgHA9XTCZTy0SE3ZYVqGrUSH1LGqDVF8X+t7btzuDVXzvr/Sjd7JsrR5+49TH8ff
         rtso4f8DNZNXZ0P0vdAkWJReqRQl1KUV9qZlb+rSIynM6OIVDO7zfDhybOdeFvaaIuOp
         LF5xbPUbPSL+CO55IFCGxm7pbSIxgQs9PNPfS69QcGR0yKTgdlne5Q0Nz2cyVgNoNIg2
         cGvw==
X-Gm-Message-State: APjAAAVqN44Zi4EN0VvMagZ9Uf+Fnr673MJPF9hj1rkflDPCnDme2SZz
        c+NgoWPaX1hQd3wKP+7YOEm2XIEI
X-Google-Smtp-Source: APXvYqxl6YWoFzwqGPSn0fW0bOcb2hOGXqrm9GL6uywHi2vMq7ucYOwoXXrOZH1hpwc4qZILiUXyGA==
X-Received: by 2002:adf:ea07:: with SMTP id q7mr2491601wrm.102.1573044510914;
        Wed, 06 Nov 2019 04:48:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y78sm3021986wmd.32.2019.11.06.04.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 04:48:30 -0800 (PST)
Message-Id: <pull.456.git.1573044509.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 12:48:28 +0000
Subject: [PATCH 0/1] [Outreachy] doc: remove api-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove both api-index.txt and api-index-skel.txt as the API documentation is
being moved to the header files, so the index is not needed anymore because
the doc files (Documentation/technical/api-*.txt) will be gone.

Make changes to Documentation/Makefile accordingly.

Signed-off-by: Heba Waly heba.waly@gmail.com [heba.waly@gmail.com]

Heba Waly (1):
  api-index: remove api doc index files

 Documentation/Makefile                     | 11 +++------
 Documentation/git.txt                      |  3 ---
 Documentation/technical/.gitignore         |  1 -
 Documentation/technical/api-index-skel.txt | 13 ----------
 Documentation/technical/api-index.sh       | 28 ----------------------
 5 files changed, 3 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/technical/.gitignore
 delete mode 100644 Documentation/technical/api-index-skel.txt
 delete mode 100755 Documentation/technical/api-index.sh


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-456%2FHebaWaly%2Fremove-api-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-456/HebaWaly/remove-api-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/456
-- 
gitgitgadget
