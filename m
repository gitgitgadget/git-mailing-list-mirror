Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A8F1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 16:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755437AbdCJQsX (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 11:48:23 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36168 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754107AbdCJQsW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 11:48:22 -0500
Received: by mail-pg0-f51.google.com with SMTP id g2so23403882pge.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=99kY9F40rFT709Cx0lKxD9DqMp4bP8nx2KbYarvKquw=;
        b=Wol+pn55WG2YaaOgNWLj0UXyIv494QMGIxaK3H9CwKgIILeoF4D2lHKLzwfZVsgOR5
         +vA3Pmp5lOPbBBVZIUaM1SHG1oZc2Oi8AqahQg+RM5cVtbZjCBLY1XL/+kfBiPnnQX71
         xynumbQSQEaHQeenqM7u5UIhdt/uPSXLmL/kg0Phud7t1Ha7QLXAM4w59fpoy2wKZ5N5
         vDV4mJ5T38SBhxzeEPj/1WmZQVvp9bjMBC+KDKM0RtNwdu7mGlc0zLFsR47fJJS0uwkI
         M+7w2qGZZrkmSxv6xZnZKwkq36cpausnXrEdwDsP4GfxvHTTa4YdBhXdVZNSo7zvmlcB
         L1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=99kY9F40rFT709Cx0lKxD9DqMp4bP8nx2KbYarvKquw=;
        b=auWWnAjWfLmgMMxlqXtmjGOgpdzftKYFyxWca86Vcd90ipwaceFoZCvU5tGl6SUEYN
         spOoLscrrBAxB5S0c46MiFiPI6xrRwand5hZtQy9RyTrRuma1MW7ytpJOgqFrrzDJ1Gb
         27PwKayLHm1KWvZCXS9qQBHu6Wi01lM3Il0fT688WCEgjYbi8YfhbGu5mcnzt9Zp8Vou
         wFKKppfStGPHJIrgwBkGW9gfpQqSKG6bQpqgq8WxJJ8XDYr7ERssnD+sCnhPcu+wmYlP
         OI0aKOPlZQ9ghgqsK2bh672Avul5+/wjk5Aa3JKpwp0txUcwB2FyVSTwomT3JL5oxnNY
         K8dw==
X-Gm-Message-State: AMke39knzNCbVUelEDTieO+Mhp6bY8J6BQVH5UVrimprLQdzi6ieNVLiT3/grzuYZuRLx8I9STH5Lqu85dKq+90J
X-Received: by 10.99.140.77 with SMTP id q13mr21142340pgn.179.1489164501613;
 Fri, 10 Mar 2017 08:48:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 10 Mar 2017 08:48:21 -0800 (PST)
In-Reply-To: <C81F618483B6A04381181BA5435FB9706A70191B@52ZHTX-D03-05E.area52.afnoapps.usaf.mil>
References: <C81F618483B6A04381181BA5435FB9706A70191B@52ZHTX-D03-05E.area52.afnoapps.usaf.mil>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Mar 2017 08:48:21 -0800
Message-ID: <CAGZ79kY1Z_Bj3AJU3G2A60XULSAKDEkwmC74JxiANTPHXo0Bng@mail.gmail.com>
Subject: Re: Git Vendor Support
To:     "COLLINS, ROGER W GG-12 USAF NASIC/SCPW" <roger.collins@us.af.mil>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 8:13 AM, COLLINS, ROGER W GG-12 USAF
NASIC/SCPW <roger.collins@us.af.mil> wrote:
> ALCON,
>
> Is there is a specific group or vendor backing Git?

https://sfconservancy.org/ takes care of the financial needs of the community.

> active support

I guess companies that make money primarily via Git hosting
(e.g. one of Github, GitLab, Atlassian, Bitbucket) *may* be interested
in active support.

Thanks,
Stefan
