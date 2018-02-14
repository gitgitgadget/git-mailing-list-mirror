Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7B51F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162303AbeBNSlj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:41:39 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:40028 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162229AbeBNSlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:41:37 -0500
Received: by mail-yw0-f172.google.com with SMTP id y186so7537118ywf.7
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Su6Y6R/bqfzU72wiw1ZbKgRBv5xofAZ6qSRVOtt0EkE=;
        b=mCNC/iXijU1Aa+l0MVrAPzA5iVlykWOsTlM8WkpIs9Dq5isTHM7Y2tHoZHy4VqgIpX
         vOc0Rp7NzZZ/XzAnyNtDxCdb4CX9kf+rn/0oecBsOD1Ou+GmOlXTDvEiataek2p589VR
         95UJjlDPgp2QBGM4aohDo2xVGYWtLkjTkZtBXZtuIssVpWgz3q1OMGuEKPbdfD/8h26u
         b57ekmiEHEErUUECbS2jFOoohXRCJpVk566+HI1W8vbozZr95YJMAXhpMWuYr4YGPX4b
         h9hhp1fV+SOr/mLq54h3uzagQhbwl95WV0m8w6XEPJDhIiJnHj0Zx6KdtkIww9xku0tB
         FMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Su6Y6R/bqfzU72wiw1ZbKgRBv5xofAZ6qSRVOtt0EkE=;
        b=j9AcZbFNXi7IDJ1gjX/Q2ZhSMVYAHN8VMOO5FD+tfv2FZdG7Np5COiSe9UAoGRn7Zg
         7G1sfrBLUwkku+XecBiSBphENCCoAqc9XthDQWVX4wbuGln1svVV4AKOUPwUFEVeH3pO
         +VY6DHDtZjLIxGiGoUhlX8gOrAJIl/i4y7J53IvJ/dWUSbW3yoRg6JrZ2WL5APq6732B
         K4b9Xkl3NmLlI/DA3LZnYyR/ecEyZESdo46e8zx/HbktcTWcDkli7qaXAgCZw5m37xgt
         jChQlCa9DJLeuh4M/4l2WBj8W/SMlnlHg6oG11kDYppL4mtoX1mnxOr5V7Ci94wMr5k5
         xKew==
X-Gm-Message-State: APf1xPAbLNfjfjBd00Opiq/JIsqsv3WhHCDAoFrzKzPgcH/MY7vi891C
        DUT7rBidfWG+UcM/l6/gE9qrLIms8R65Zee8hbW+b7UH
X-Google-Smtp-Source: AH8x2272oJYOQQHuXQlXabQRsU8JAkDaV5AAiHEPHsIV559Z4G9rU5z2rHksyNpVj4plw39hhwHNn28tcjQc205VaQE=
X-Received: by 10.37.179.4 with SMTP id l4mr154688ybj.213.1518633696156; Wed,
 14 Feb 2018 10:41:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 14 Feb 2018 10:41:35
 -0800 (PST)
In-Reply-To: <20180214180322.GA9190@sigill.intra.peff.net>
References: <20180214180322.GA9190@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Feb 2018 10:41:35 -0800
Message-ID: <CAGZ79kZ5a1-znO_efwVbrRpXwboZHeiC+4PqB0SDR2Xwv5P+8g@mail.gmail.com>
Subject: Re: [PATCH 0/6] minor test-hashmap fixes
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:03 AM, Jeff King <peff@peff.net> wrote:
> This series started with me fixing the sizeof() mismatch discussed in
>
>   https://public-inbox.org/git/20180214164628.GA907@sigill.intra.peff.net/
>
> but I found a number of minor irritations. Most of them are cosmetic in
> practice, but I think it's important for test-helper code like this to
> model best practices, since people are likely to use it as a reference.
>
>   [1/6]: test-hashmap: use ALLOC_ARRAY rather than bare malloc
>   [2/6]: test-hashmap: check allocation computation for overflow
>   [3/6]: test-hashmap: use xsnprintf rather than snprintf
>   [4/6]: test-hashmap: use strbuf_getline rather than fgets
>   [5/6]: test-hashmap: simplify alloc_test_entry
>   [6/6]: test-hashmap: use "unsigned int" for hash storage
>

The whole series is
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks for improving the example code.
I have lost track of the hashmap improvements lately, but with
such a good test helper, we could reduce the amount of
commented code in hashmap.h and just link to the test helper?
(as an extra step after this series, I thought we already had that)

Thanks,
Stefan
