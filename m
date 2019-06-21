Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA971F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 10:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfFUKnZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 06:43:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45838 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFUKnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 06:43:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id a14so9374384edv.12
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUQ7+S46UZZMKSebX52CGDPgdb8E9nSw3KGSFVuu5lI=;
        b=kgY6vUrfkNzBs0UHvaTA048+ke1nppdEi1eHTApCQkjOcgNJfCc1dsoE3H1ZeYdC2s
         04Gd4LCJnuxrwn45H+9joIHwotAVfCPH+kU+R6zsTBXEMlJVYI610hrFJNXItlAgxN/H
         5MF8JDbbwjs29qGC5+5tnjW0AwGAagVgnhfYrBRdV/rjUdoeVQHIm2ypsjoCla1cIdpb
         X0svsl9TSmn56YzO3H9ow83QBqL6jV9bwQOchWBcwNghgWfZleaUwKgQirLZuGd0SDW7
         ovpx9Lv7fjfYZu3bMJGvLTQXw6cuhcM3l299ZXqyv6ADFQCHU+yhpA14rZFUB+7HKAyG
         dSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUQ7+S46UZZMKSebX52CGDPgdb8E9nSw3KGSFVuu5lI=;
        b=CLod+N9yfi0RJLYaKrS3plCRvPSLB5o0sn8MLn/I1EKX/AMfEMfNroCgs0fgMXEp1f
         VAga7F5CeIkHe85BIyBCk4rxzUIXoBZTbvR0yX30xYmPfVnUJKkXid3mFFGJqpfjWnqw
         pvINPievHZES0V2M4/Y2Y76rkIqgI1mA4Wv8MlqRghpgR1Hw/p5dA9nnDPWFhKoGJJYH
         QMFH0kDxVPtYuqRBu11MhLjIuHCtpgAVIoxc5vFHaDt8af6IFwvozD1euoxZnxDxWlJ6
         nzlq7EcdgwX0B8wLxDQcHdk53mBSNy/VI91rNBwI1HNkau85dhrloIcyeLPDZfggd/P6
         9UlA==
X-Gm-Message-State: APjAAAWmyNjOEMNZQ5NoQlIQCas9GHFZSPkoLFuUZObJhwWznaGYnSjj
        hk7nwjZqwhvyCc/6NVUW/ToTsivpW+u/liEZpsI=
X-Google-Smtp-Source: APXvYqxdZycjyFhh6uviqXeusY1dh2jkpmFxOHmYEq8EB+K7/mfDh+jHEdQbKktBeY4sNkB+RqGlszvq+d/TlPxXSmw=
X-Received: by 2002:a50:fa96:: with SMTP id w22mr46721880edr.45.1561113803155;
 Fri, 21 Jun 2019 03:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190619221315.7343-1-chriscool@tuxfamily.org> <20190620212922.GB87385@google.com>
In-Reply-To: <20190620212922.GB87385@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Jun 2019 12:43:11 +0200
Message-ID: <CAP8UFD1KRq9gUJQbDP9d3xewS9F_9wHnt463Qt7UXoi7VdmOJg@mail.gmail.com>
Subject: Re: [PATCH] doc: improve usage string in MyFirstContribution
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 11:29 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Thu, Jun 20, 2019 at 12:13:15AM +0200, Christian Couder wrote:
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git-psuh'
> > +'git-psuh <arg>...'
>
> It doesn't require 1 or more args - you can run it with no args. So it
> might be better suited to state the args as optional:
>
>   'git psuh [arg]...'
>
> >  ----
> >  static const char * const psuh_usage[] = {
> > -     N_("git psuh"),
> > +     N_("git psuh <arg>..."),
>
> ...and here too.

Yeah sure, I will will resend soon with such changes.
