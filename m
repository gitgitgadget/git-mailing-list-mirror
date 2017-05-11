Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F54201A0
	for <e@80x24.org>; Thu, 11 May 2017 21:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754945AbdEKVXG (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 17:23:06 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36063 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdEKVXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 17:23:05 -0400
Received: by mail-vk0-f53.google.com with SMTP id g23so8618103vke.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dBQ+d7VvfE9rmPK2xImT077QCXjRjBhwsxv7e4Hd1BE=;
        b=upjHEKjfcAyZg5/5Dhb038r/urC/PDyeGYsopq3JpLrNBU0jzvO1R8/T6kdw0YW9p7
         pf2xd17hlx9MJuDK/2gRBx/zWb5ONLBHpQlZK1gluqsyqDQUdDQP8IqGn5T0W7+JTvdE
         ewiEh1FLlz9258ADwdCUtaPqXi1FEPb6J9fKgvxlqtPFMVAV4uVPfKw8OmmNAyldrkJ/
         D1KCEc4kqR0wSdaIUPm0g2nQgq4FRIiF2Lf9xsEAL5GBYmIvAUMkFgkNSwPS6karSbBO
         pd7aB6PxAcy1jUU9hw2A1PxBoi/l6bBo1xAFgJ8WtvI9HElCBWIJYKEtI7gtCZad7qSL
         +Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dBQ+d7VvfE9rmPK2xImT077QCXjRjBhwsxv7e4Hd1BE=;
        b=b02ktWU0vBy7SgOtemad/2ko0OzGoAq9q9yB/jMaxa99CsorVtYebC8ahB7Jt9LUHj
         rgFgZpRsTFFCwkX/7cXupPs+oHUiMimYa6+/Iio9l2t5fQpstd4YNXt50yCwg+JPxTUs
         Z1RpIYF6vJeyGijVLpBVThXLVwRZoshjw3IAbJBIoaf816cs3Qw5q1Rp3GXsJb26CaZI
         dK6AtzOno8YZApdMKYT8bG+CHn6l+rIEd7FXIX0zO4m75icAddULKXc9MgzDE/CP28FY
         J3TjkRrEFG5XIcD/6uFdx4cLA5Zqwo4hQrd6I4oz+AFlDkbYGD4sV1kD/DBl/R2AT3Gj
         fNIg==
X-Gm-Message-State: AODbwcBWnp3lMKx1QkLunO8lnLY7tZWeGinFoBroZxC1WG4dAE68XREB
        ElnMot3qti4xs+nDR1A8280fbk/weg==
X-Received: by 10.31.238.143 with SMTP id m137mr130236vkh.109.1494537784181;
 Thu, 11 May 2017 14:23:04 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.55.168 with HTTP; Thu, 11 May 2017 14:23:03 -0700 (PDT)
In-Reply-To: <20170511201707.aobrdiompzg6wu5k@sigill.intra.peff.net>
References: <CAHd499DjBHsWCf8h+i4EstR7qs-9hkO4En5-B-WA17DoPZQNoQ@mail.gmail.com>
 <20170511201707.aobrdiompzg6wu5k@sigill.intra.peff.net>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 11 May 2017 16:23:03 -0500
X-Google-Sender-Auth: Zmbgpb2c_na7D9588oZFH9IU06g
Message-ID: <CAHd499AvDRH-KZ7piOE=QsVXSpMt0u5jVXUC=7UPnRVLYo-U5Q@mail.gmail.com>
Subject: Re: Best "triangle" workflow setup?
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 3:17 PM, Jeff King <peff@peff.net> wrote:
> I think you want:
>
>   [push]
>   default = current
>   [remote]
>   pushDefault = myfork
>
> to make "git push" do what you want. And then generally have branches
> mark their counterparts on "origin" (which you can do either at creation
> time, or probably by using "git push -u origin my-topic" when you push
> them).

So without the `pushDefault` setting, `current` will default to a
remote named `origin` if there is no tracking branch set, correct? So
`pushDefault` is effectively overriding this built-in default? In
addition, it seems like since this overrides `branch.name.remote`,
that this effectively makes the remote tracking branch *only* for
`pull`. Is this a correct understanding?

> This is similar to what I do for my git.git workflow, though I usually
> have origin/master as the branch's upstream. I.e., I'd create them with:
>
>   git checkout -b my-topic origin

I'm looking through the `git checkout` and `git branch` documentation,
but I don't see any mention of it being valid to use a remote name as
the <start-point> parameter (you're using `origin` in the above
example). Am I misunderstanding? Did you mean origin/my-topic?

> And then rebasing always happens on top of master (because "origin"
> doesn't even have my topic branch at all). If I want to compare with
> what I've pushed to my fork, I'd use "@{push}".

Can you explain more about how your rebase chooses master instead of
your same-named remote tracking branch? Maybe provide some examples of
your rebase command and respective configuration (unless what you've
already provided is sufficient). As for @{push}, I haven't used this
before, so I'll dig in the docs and learn about it.

Thanks for your advice, so far I like this direction but seems like
there is more for me to learn!
