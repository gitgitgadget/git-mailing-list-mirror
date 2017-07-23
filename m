Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BB4203F3
	for <e@80x24.org>; Sun, 23 Jul 2017 06:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750897AbdGWGlx (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 02:41:53 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37377 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdGWGlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 02:41:52 -0400
Received: by mail-wm0-f43.google.com with SMTP id c184so9457724wmd.0
        for <git@vger.kernel.org>; Sat, 22 Jul 2017 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PK5f47ykIetl1GmFT43FTxUEpsa25QgPIe4cXt9/OpE=;
        b=ZdyFnA81e5wPex5Yn1imfAXP3+y3MeAasW/A7ydaTYpLezWhd9hCORVhB70Ztngb8t
         WBrj9twxPMM1AGaY6A7vwvutegiq8m+yAE7bbGt0cYnXRwQNdPI+8FJ6R1X5umGBI6Mv
         wG8cYPhFBCGmnbN9z+rEaQu56tC1Ji4mjlxi8gdPotRI7sbQKrEivvZZ07q8NUsH3SbT
         q/RFrri4QtsqJg0xIdib67QpOCHJJ8aJ1d//ylzeMhzaFoX4+nlqVMxQuiLK3kYzUtP/
         SV8LkwDvvWKCm5UL8of9cHFwkCAfpBIYFkP9KMupMG3aTiliOdtbohopJREbfzjDvwdH
         WX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PK5f47ykIetl1GmFT43FTxUEpsa25QgPIe4cXt9/OpE=;
        b=s5G0Npdce541BBBsUkJQYzjQEaop2Tf+4l4dk/jTti2Hbw2IDjvr7IxaHMW4qyP8dK
         FmsVs2K7YJl4dv17BWfJMsw3d5W6P6xRbBLA07LebUJRNZHvKAa17pzsEhI8PWmHsxdK
         PkL5kg8H2WLa3d6PimbCZduDj0kNhcnSRnko4mcE3bFIKed9KTu/g2TWXm0GibXbbmQk
         dCkz4NxCEZ0+5TnaeAyPUFdaZ9oIc4Q9g9Q4iGq7jDWwzLFMHaUXsvktHeU3mgFsG1Ed
         /l4ptfxnHu0CQOaB+ZfDeMSEJtc8v2Yw3FqrzkX+z3ssreiNBH5XC5kH3yS+0FGtjfcF
         nQJA==
X-Gm-Message-State: AIVw113FGc8Qe32MWLjn0QX0EOSI5aBZAYgoNNIkkugj8lXLD84X6iiP
        hhNnAMQk9UrDpgYnBiVzmBid0J/mtd8e
X-Received: by 10.80.212.10 with SMTP id t10mr10715820edh.172.1500792111153;
 Sat, 22 Jul 2017 23:41:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.134.76 with HTTP; Sat, 22 Jul 2017 23:41:50 -0700 (PDT)
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Sun, 23 Jul 2017 09:41:50 +0300
Message-ID: <CAGHpTBLzN2g_ZXP4G6Eo5yZrvK_bB8KjBiSZ-Nc5JHNTRzv8qA@mail.gmail.com>
Subject: fetch-any-blob / ref-in-want proposal
To:     git <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan proposed a design and a patch series for requesting a
specific ref on fetch 4 months ago[1].

Is there any progress with this?

- Orgad

[1] https://public-inbox.org/git/ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com/
