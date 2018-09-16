Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A441F404
	for <e@80x24.org>; Sun, 16 Sep 2018 07:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbeIPMoB (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 08:44:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34694 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeIPMoB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 08:44:01 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so12629718qth.1
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 00:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgKVuYFU7qyvm0Sf7Y3thL6ddZ4kShxq+T984HCl26s=;
        b=lXZTxOkCtW0D1h+YWFrXnGTrPEJeX1k92AHTcLL30uZzd38VLB0RzFMh0gUHfQX+qi
         +KH5lalkWB7iJybHef7nuXjMib1Q2q4sNlKSe7T/+FWxxGv5WgCu8jZhnA4WId6MpvLh
         TPiUu77RMpd8f6TXATpLehq7+5AAbvdlFRiw6oqbjR4Mj33GHNuvW1OHhsurjMj1hKZ3
         nSd7QujJBjV9WaxsTXi44YNL5vo0uI+zP49UxiGiNZaynnGEeUhB269dRN6E0UlruTHz
         dJuy7iLvGvqb0uai0vSjOCVpLW+oZDZMMftvBkvT1dTE7J0iuj7sBc7VPxc9zVUBP9i1
         xmlg==
X-Gm-Message-State: APzg51DBeD795uh1LfZQUAm8jDpt+o1wv9g8KQgP59unhnbVdzSAKUsQ
        ggZjseaX3bNQaX+fFMcJO+sXhrFIapabu3rSJbywMg==
X-Google-Smtp-Source: ANB0VdYdH6+3PeE98cNOlioRs7gbJt8Xq2nO3HiTjBzCmAekA98UTEC+/AwxfFBisvK13VNW3RuVWmnnces97+T8gqU=
X-Received: by 2002:aed:304b:: with SMTP id 69-v6mr13489148qte.220.1537082521972;
 Sun, 16 Sep 2018 00:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180905085427.4099-1-timschumi@gmx.de> <20180907224430.23859-1-timschumi@gmx.de>
 <20180907224430.23859-3-timschumi@gmx.de> <CAPig+cR1JpZqxBAsR+6_WjLwofnU8siB9VXYdUkXY2P-xQnsuQ@mail.gmail.com>
 <bd63006e-18a7-1c41-252c-cf47a65ba7cb@gmx.de>
In-Reply-To: <bd63006e-18a7-1c41-252c-cf47a65ba7cb@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 16 Sep 2018 03:21:50 -0400
Message-ID: <CAPig+cT7+Rcv-xVxUCYy7LV6+bNEWJgN4qONLaYsikfZN40YMA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/3] t0014: Introduce alias testing suite
To:     timschumi@gmx.de
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 7:12 PM Tim Schumacher <timschumi@gmx.de> wrote:
> This is the first multi-patch series that I submitted, so I'm unsure if I
> should send the updated patch only or if I should send the complete series
> again as v5. Any pointers to what the correct procedure for this case is would
> be appreciated.

Re-send the entire series as v5. That makes it easier on reviewers
(who don't need to go searching through the mailing list archive to
get a full picture) and reduces Junio's workload since it's usually
easier for him to re-queue a series wholesale than having to
slice-and-dice some replacement patches into what was already queued.
