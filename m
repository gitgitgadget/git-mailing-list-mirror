Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9F4C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjFLTAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 15:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFLTAd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 15:00:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62C413A
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 12:00:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-665a18f5643so681973b3a.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686596432; x=1689188432;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xb7Wht4NQGFCfDW4EpzVfb9v4HgZ6Kff0dUuDWKnjSk=;
        b=lZNexK0BNZj8ku42mTmfWw5jconX7M445oCioAvJvSUkB2hTaO8uJ3tJD2mVL1EZkx
         5XlfEMvg9JAaIF+GPKqrASuT45Ez/MbYfk58p4/eceyAwn3y9y8YVEiadhg8pKliMUkB
         VQF2aBXUaYj/2+GYMXHPWyCLq9pseFxoOQgIM3o5GxUT/fcGx69g1thTNgoPH9d8S/cU
         o3D+k2vcaClGQ8QB+EDHNKLEloUgLlpRyewn7Zrn3knNVyRKfQsywDZwpGX9y4d2FRFT
         ri1iJHH81VahzxhOv2EY40j9/Nw/+t2tuFw84nGUwmhlQGd+DoxwIsOe8BwoXtaErO8t
         7L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596432; x=1689188432;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb7Wht4NQGFCfDW4EpzVfb9v4HgZ6Kff0dUuDWKnjSk=;
        b=l6d6kCOZUMTt+IBlM8Cado35aV0Xfv/2E0vxqIzty0Vdk+NcvxmmmBfbcR+7W7I5hA
         hO9aXWueZHMHl/sCAiYR7z+GGwPMeAGFN+KYStgHO0eAIT1FQLQu6hEvKcwe4jyL8SXD
         buTjP4snRBkj/BEfOrW8x9rOAG6tFCdX8s9X+l9v+5U01SwBKSnW4ROwSj8wbbcgsnaN
         SeVfcGbBT/xShXIekNRk+82iyi3MFw/2SQuayekjRRSz/338e47JtMxErBTYJ52OyNuL
         YKwoZcbNBz/J4oRX4S0xtefLCbKUwqhDAzYDR2mJS5dLQEI/lRFEGRx2wPE7JMOa0Y9/
         dNrg==
X-Gm-Message-State: AC+VfDyi4Rxp73olONUDUkuItw7MYDfOPosYWm78oxQgV2sQonCTk1r7
        mHy/7AcCsJZ4rVDsmybduTHC89PgWhXRQg==
X-Google-Smtp-Source: ACHHUZ7wsmrPd1vzxG0HSsonytUm0Hg7UyMESz8DmJf/51tfPXV0U+hvrjzNVTxSfAPUFq/Q5uvGtw==
X-Received: by 2002:a05:6a00:2283:b0:664:ed5f:fb28 with SMTP id f3-20020a056a00228300b00664ed5ffb28mr7124075pfe.10.1686596431943;
        Mon, 12 Jun 2023 12:00:31 -0700 (PDT)
Received: from five231003 ([49.37.156.189])
        by smtp.gmail.com with ESMTPSA id h16-20020aa786d0000000b006413e6e7578sm7208272pfo.5.2023.06.12.12.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:00:31 -0700 (PDT)
Date:   Tue, 13 Jun 2023 00:30:19 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18955@gmail.com>
Subject: [GSoC] Blog
Message-ID: <ZIdrQybUsjEcxMrb@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm Kousik Sanagavarapu, this year's GSoC contributor for the project
"Unify ref-filter formats with other --pretty formats", mentored by
Christian Couder and Hariom Verma.

As part of the project, I will be blogging every week's progress. The
posts come out every Wednesday. They can be read at

	https://five-sh.github.io/blog

I'll reply to this thread with each week's post. There is already an
intro post and two weeks' posts

	Introduction: https://five-sh.github.io/2023/05/17/warming-up-for-gsoc
	Week 1: https://five-sh.github.io/2023/05/31/week1
	Week 2: https://five-sh.github.io/2023/06/07/week2

Feel free to suggest changes or comment, on or off list.

Thanks
