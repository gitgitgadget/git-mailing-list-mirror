Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42631F954
	for <e@80x24.org>; Fri, 17 Aug 2018 22:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeHRBO4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 21:14:56 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39440 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeHRBO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 21:14:56 -0400
Received: by mail-yb0-f194.google.com with SMTP id c4-v6so2524419ybl.6
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEAZscI4OAyvOpqiPXq/PBRGqxVWUmmisVLSyvczoyc=;
        b=s2qKkOE5mWmf8et725OjHsh9Zm3SkCtQODlx8e20VYHKD7p02icX1ma54f37rFTueP
         HKY6kli0D3h+ONeYBnrYCciBBG5g5+naSOoiyRxOXRFNTadhUjpcc0urcPtFPNgVF8O/
         0Y14tTgPQ5h2D3jtsB63wBjToj7A/EirTwwMA8eZ2vv3h0vwu3Hwzcwey9EfE0D+myh5
         vdQxW/CiHbyBMCWGscyM1pT/jgNY3A49mIadKUZJqlmjaxAknzEJtbQhtSi6UEmaHE1+
         r5mAGISw4FRfBVpS19PgH9ry/lmgzl061S2Cx72w0M1ezOuGK1HDc6lU0GtYMlA7Hm0k
         1Heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEAZscI4OAyvOpqiPXq/PBRGqxVWUmmisVLSyvczoyc=;
        b=mC+LVaeYCk2KYqe6EvhmOXgf4DZuULZ6OxiI5Q4ne0AqhSZCXsu1n2KJWCoZHNWvkx
         SJcdta2FdrGioz5+MyZg5HbuMDc7NhSoHuLXCjkdhBpZ5AeGdj6F+26c9GFJro1OUcGn
         UdCsWVJfnDp2/ep9Ysb9nBG3/gVue/KGpEB3fLDQ9deV5s/9xTYyts1UGY4ijTK4YTLb
         TkR0nZ0tq5pvZ7wVw00OFnsUu7UHCbt0zb/TPJzLcPoJfNmitTdL/yeeYOEM7UsvhBHQ
         zhEFOLPNGX0O8Ig30e6E+gdnL3IXGXd+k/qyyogI1+tlkRxPHmQUd1KuM0SihS23nYNK
         kzUQ==
X-Gm-Message-State: AOUpUlHZHBfAccv9VxlCd52gSjr4VFNWf+miWG/yTS/T+M0o5akoqn4p
        30e++uWVsmafu7fGZ7LDJn8kZQ7sCyrpFdOoONlv+A==
X-Google-Smtp-Source: AA+uWPxQujvKPua6PPi6kxdatfD5lILYZ8joZAqWYwNmLYrRSk4P1CwsYvoihvwBu6ggBHFxpo6hL7n6iXpY2p5+whc=
X-Received: by 2002:a5b:a87:: with SMTP id h7-v6mr19879889ybq.521.1534543788186;
 Fri, 17 Aug 2018 15:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet>
 <20180817204354.108625-1-sbeller@google.com> <xmqqzhxkabv3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhxkabv3.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Aug 2018 15:09:37 -0700
Message-ID: <CAGZ79kZdW4=Tp7ci2CbJKevxHaG4wDMzZQB2KfPQPkg1AWBkRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Better colors in range-diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 3:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > This improves colors of the range-diff, see last patch for details.
>
> How does this relate to your other "color with range-diff" topic
> that is still in flight?  This supersedes it?  Builds on it?
> Something else?

It builds on top.

Sorry about missing the obvious,
Stefan
