Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96C11F859
	for <e@80x24.org>; Fri,  2 Sep 2016 09:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbcIBJfT (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 05:35:19 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34844 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbcIBJfS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 05:35:18 -0400
Received: by mail-yw0-f178.google.com with SMTP id j12so66425551ywb.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A5YHgcPKLtCrXd0a+7YazD35lUJQpwvbVg9eLUMQxWc=;
        b=oT8PoywXnWIwLeZS83gpWEZsP4DoiTva0nIQNC1RIvxTV/NUwkHANcvDF4/7HBGz3B
         CMxZMQ3Lj897Hyes0zAHBfUHy2PjYLrN8zpd7XsyOmj3dasD80uMo1L9QSHDmQhMQq3D
         3QsS0ALpccSTlVECYFRBVsm5uxAyq+x3+prlCuy4ppCAsL1rxzuBDLhG4lwi9OxjJS5g
         lVniWCkJB7i3QCgdDuikqzxiNSpj/51BMF/5Z6GoRbAHFOCYZqu0cyNQsKg6vXb3WtP9
         AuGf8ioGghmq/VGuJtKp9adzcvW0F4FLhAVgXKUglz5RwQWDomEMQjt3SG5MFtukH5TR
         UPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A5YHgcPKLtCrXd0a+7YazD35lUJQpwvbVg9eLUMQxWc=;
        b=HiicJ8iVZ8WkZlmsFFN0QDxyuVTqV6tUzxKezmbBV5KoonNt2bONRvJqhSMfySJ3yu
         V4ZbnTDN8w7UzJG+o43I09BLEFBd8YRYmHwus6FoEG32qRbW1qUjs84ns/21vQHd+dDT
         yTV+w9Gh/iahwegY0ROHaD1UCXOvzaApU+Wo4raI0kdAD1nSNEpPa6nYoPooH/6wl8Bf
         KLssHjF3D1DEU0gz1PTdCEpiqIhhfH/P+hTJXcLGallIZHr5GWXBYTVSIKXlBcJyO25U
         rHDDHUXybq15zfY3RiFEb0AikZ9MMwp/c6FPMAk+17BlSaCCucL5vhpii9a1yDiYqgfS
         8moQ==
X-Gm-Message-State: AE9vXwPNzR68HV4QT+MJa3fnBMjKGMoEF376wA5k4sq/ts61Jz0NgTKJjyWM/8DXwd/8l9OZVg7GL9qTbA7CQw==
X-Received: by 10.129.158.71 with SMTP id v68mr240327ywg.33.1472808918031;
 Fri, 02 Sep 2016 02:35:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Fri, 2 Sep 2016 02:35:17 -0700 (PDT)
In-Reply-To: <20160902090247.b5gtui75hiwococc@sigill.intra.peff.net>
References: <20160902090247.b5gtui75hiwococc@sigill.intra.peff.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Fri, 2 Sep 2016 15:05:17 +0530
Message-ID: <CAFZEwPNDScR-+KGEWS__fAMrdKupe+ibKLFMceBMf5pqJ2kjYw@mail.gmail.com>
Subject: Re: Git in Outreachy December-March?
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Probably off-topic.

On Fri, Sep 2, 2016 at 2:32 PM, Jeff King <peff@peff.net> wrote:
> As some of you may recall, we signed up to participate in Outreachy for
> the May-August session, but did not end up selecting an intern. The
> original thread with details is here:
>
>   http://public-inbox.org/git/20160308224625.GA29922@sigill.intra.peff.net/
>
> There's another session that runs from December to March. If we want to
> participate, we need to sign up in the next few days.
>
> I'm happy to act as admin. We will need a few things:
>
>   - to arrange funding for the stipend. GitHub offered to cover this
>     last time, and if we are interested, I can see if this is still the
>     case. We can also cover it out of the Git project money.
>
>   - mentor volunteers. This is similar in scope to GSoC, but I don't
>     want to just assume that people who volunteered for GSoC would still
>     be available
>
>   - projects. We can pull from the ideas that were not selected for the
>     2016 GSoC, but we may need to update or add to it.

I have a few friends who too did GSoC along with me but in different
orgs. Their orgs have a separate channel (slack or IRC) for
GSoC/Outreachy communications. In that channel is that all potential
mentors are added and students too are pointed to it. In that channel
the very basic doubts are covered. Let's say I am online and probably
the student's mentor is currently unavailable, so he/she can post a
trivial doubt there for someone to respond quickly. It takes off a
little load from the list and the mentor as well. I am aware that
there exists a channel named #git-devel but unfortunately its not
really active. I will be wiling to help other students with their
early days!

These days a lot of my fellow students don't really use IRC for
communication and see you can see there were really less number of
people inquiring  about GSoC in #git-devel. We can prefer slack or any
other alternative.

Regards,
Pranit Bauva
