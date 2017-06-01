Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E7920D13
	for <e@80x24.org>; Thu,  1 Jun 2017 22:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbdFAWCY (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 18:02:24 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38136 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAWCX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 18:02:23 -0400
Received: by mail-it0-f45.google.com with SMTP id r63so2470529itc.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DbkjHZ3W3/jHNOp1R2TFoZrs0YG6BcdKopbmV4MZV08=;
        b=GOgwX4RxJvgwVIZhrOaB/9b0V4bUbg+FCxAUZzwKKtH2YbeTlSbtDOa6tXkhq1uiMd
         220j/vXck6CjvSzbVA8uKt9eEfn4YF3GsXFB5rP/mHXyhL9h6nPwHSrcBWU9i/2mbMfW
         iXBRsqv0TSu4xBJOVZaNqpAE+hLfguqba/zm6D8/LGN4Fo5jTrL90ElhgjNbECEwdSjk
         xLKbcmLmUT+WpKgG5rZhBpaGuDdvzzLCYH8BCwz93snIwIuw7eUsnLJ28I69r4EVUZ6A
         8HFYIagV1UOxTC0L86qErB3VdFF5f657xgyCsn+zwBqJfKOGEutrF7AI6Ct3ZMs3WBBz
         n9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DbkjHZ3W3/jHNOp1R2TFoZrs0YG6BcdKopbmV4MZV08=;
        b=LtoatD6WGPpeziFaiRWL9UUAw1iQDvBm5F5vnE5QAzn3bj179J/FR34ATt+rjSENCa
         vi8vo0IAzv/0YDNe/WJXBAxAePWVNFqmU9kBdZ1qsGoxD7Dy4xSQkULbKGvbE0e52aqa
         Bpb0kYXPOtR3TI+CatD/lYGYjuJN2e6z0Pf0Of3kH0+ypITlBN4qeopA7+u/bAZl7j2H
         y0pWCkiOJGYFwshyJ/zXrKksum5kWw9fmWlHp/MowgbuSDY1rcpvV1UPTypSxGQjj6w/
         CRfYSs4mD6LwRefZqFkycFXtj10oJ0WW4XLR6VsXNP94xyWXhBgiO8BbAg+FrYqLN40F
         tA+w==
X-Gm-Message-State: AODbwcBhvbcJZZ7XBI1WwEFnH9dbpG0e2A7x6/XhQNEVoHs+KMZv9P59
        MRqNHWSGRIzpu1XClhAgV5ERXB8Uaw==
X-Received: by 10.36.138.131 with SMTP id v125mr1622728itd.66.1496354542452;
 Thu, 01 Jun 2017 15:02:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 15:02:01 -0700 (PDT)
In-Reply-To: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
References: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Jun 2017 00:02:01 +0200
Message-ID: <CACBZZX6aGkBaQtjKNx09-XEbhXNubOnhJdVXYkNq419wetDvqg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Some more git config completions
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2017 at 8:25 AM, Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
> Some more completions (from what I could tell, there are probably more
> missing). Please let me know if you prefer them in smaller (or larger)
> batches (or if the patches aren't wanted at all).

This all looks good to me, and I think it would be fine to have
changes like these in bigger batches, they're easy to review.

As an aside from this series, has anyone ever proposed some method of
semi-automatically keeping this up-to-date? Seems we're in a continual
cycle of adding flags/config, forgetting to update this, then updating
it. At least the command-line flags should be easy to parse out in
some test, ditto config variables from config.txt maybe...
