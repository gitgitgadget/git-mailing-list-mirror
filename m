Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D861F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeDJV2O (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:28:14 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:42583 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeDJV2N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:28:13 -0400
Received: by mail-yb0-f178.google.com with SMTP id t8-v6so1314743ybo.9
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e1nj26zp79i7/UfK/wP8x+w8rDl9ryBQuLVp/uLkAOc=;
        b=AOFmtNEbty4B+6Aa0AdTBPCSgkgFamyq/ObfRZqDItPtlYbMiWfVDbupL1l09THei6
         n0m/sgh4DUau7xC3Z8V5m6VLgp5IwNjbZsdwVowL4MBKtzM9swB2EljI4CjdXzxDaEgK
         +niLqXKodLajIrImLDIsq1hocHxPX089pG89zmEP+JN2wErW3TDO3fT6rgLgZhIHiodL
         8fEdOs9Ti+kBjjvFmqEwjK/+Fq/gC6tHXTwX2eQlIEytM+MEINHOHc+WXwc6AOhtzvth
         osdd/LbItH/mmcuQ+fRCmVeeNzVv+Ap7xhiIVd5DAoogvBUSl9ivzpK/UxcgWq2r5P+6
         A6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e1nj26zp79i7/UfK/wP8x+w8rDl9ryBQuLVp/uLkAOc=;
        b=B63PWn96wJn8Pk/rYnI/KgGgF09FHTe0L69VWycxmipDOYkzRs6ESPbmh054ssEwLn
         tc0uuZfberLM7veAaazdANQ6ZEFyBEXqdNnmuUjAKRaexKBMUhLwHOHnIqXXn5JaA4mr
         gJJJPaKPQQscD7AVbqcuqm3dg6MRaZfvKl08fo20zdg7PtIz0miEhmHjyHVCcFaSEKbn
         GLnGajgN/kOdgpTcGuU+APRfBe0jMpOPz8fEOdw3I1rq0jr6LriqhC7Y7AnW+ivvSxDE
         jtKDQiazUx0eo3THuCnt+NroBJwkbstzgS07RswgcZgs02n0gIhZcMoHjMGvJKKWF8dy
         13eQ==
X-Gm-Message-State: ALQs6tAP7pnuk4JtUKYGFyB1YNZ2ihvUgG7CywOa2HHdYnKFiStNBZI2
        revTWHYnhJDoJf8nrTnqAMjJhXRk6wRw8HYB7g7NMw==
X-Google-Smtp-Source: AIpwx4/fOh4/iml5e7wOXX9MN6uXDf4smWlzC4dsoG+ls+4kDzHCTBGxs2D6Nx0oxso+BUEhcvZMFLJXrbejvXYsn+A=
X-Received: by 2002:a25:8e0e:: with SMTP id p14-v6mr881427ybl.352.1523395692453;
 Tue, 10 Apr 2018 14:28:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 10 Apr 2018 14:28:11
 -0700 (PDT)
In-Reply-To: <20180410212621.259409-1-sbeller@google.com>
References: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com> <20180410212621.259409-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Apr 2018 14:28:11 -0700
Message-ID: <CAGZ79kaSSR3V1MJNZbfnZuLRM06Ba4B1OTgzDDsqFFBpgSSdQA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Rename files to use dashes instead of underscores
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 2:26 PM, Stefan Beller <sbeller@google.com> wrote:
> This is the followup for
> https://public-inbox.org/git/xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com/
>
> We have no files left with underscores in their names.
>

It applies on master, and also contains that patch for replace_objects,
which I would intend to drop from that other series.
