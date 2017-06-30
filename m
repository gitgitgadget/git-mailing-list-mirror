Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C700201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 17:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdF3R3i (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 13:29:38 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:32786 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbdF3R3i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 13:29:38 -0400
Received: by mail-oi0-f52.google.com with SMTP id p188so41403138oia.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BsR9DUZJv7+yjvjI1flKwJJukwaEdUMvFnEFMQX26CU=;
        b=C7XZFv4jc2CTS9puNVMLLY4uTZuaA3mczuKFjpvcKeI7dw7V6wORhCEZ4arF+EMWba
         gDv1R8sItNkBVy0xEyBjV9NBI9teVRtB06JoQ1T6WrOGiAuUTkuDeMl2cHfJHSMm9hRN
         DA44MVrmN+tPKXukuJy3laOBCYMH14wCem3fIoKOcQT17xDh8sdwFcRcjo/gfNsB5eet
         sRtP7D7JrmilySJEm5JG7Ze8Q+SLsNmmR7zClFpxHMIh5yZdvD1mopxUKk7s5NgHROWi
         cy0HMuTp9VfG0RPePP0M+PzIxIuCij/4ZfJ6FR8UtDVURzxQd5A3K/2qXYilcu+FIKU5
         QNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BsR9DUZJv7+yjvjI1flKwJJukwaEdUMvFnEFMQX26CU=;
        b=YvcIBjBSbhI9WPga9zGD7Jpw35jYG+RWUh/ioY5jPKgA9cwY+kEiGggv5Mcc6Ys2iH
         5s3iuaD1KAiQr/lLJHuN1AQFx/Y0ytjeWGBeOGOIIwy0C8fbbvjX0Drf4gGwCBgwHcbh
         F86nUzUF7oXJfQjNfL0uxq4PzvyqcYlQ2cFv3hibtvMLHsgDRxkDZb0kyGDtMcDPD7uN
         vypPDDYLRJfrKZIpeenZwf3MC4BRuPg52Wk9ROpUS9bmtGXOUx2QI3MH9TcxWVxC8jiL
         R4s5xnqyFxf0sTzHwqwDN3paiZXWtbIL+o972PLx3ER7OS9zT9A6OEWIqftzouPZPfDm
         ua1g==
X-Gm-Message-State: AKS2vOyMvBTuNPSRVo+sUCTDZyQZoGusoJtJwN2xZYphCvbKu1Y4TiRU
        GX95FKaxKSG2eX7fdiZXHR4m2tuDKg==
X-Received: by 10.202.186.3 with SMTP id k3mr5663493oif.59.1498843777259; Fri,
 30 Jun 2017 10:29:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.104.26 with HTTP; Fri, 30 Jun 2017 10:29:36 -0700 (PDT)
In-Reply-To: <CAGZ79kZxde9j+O4JDofYLbC2CRk_X0tiwOftEgKQcJLyN409xQ@mail.gmail.com>
References: <CADHEqX_fiUhnpn6WAFrbDaNJTb1Vbom7Ndn-n6WmQ0gkQ69ZeA@mail.gmail.com>
 <CAGZ79kZxde9j+O4JDofYLbC2CRk_X0tiwOftEgKQcJLyN409xQ@mail.gmail.com>
From:   Shaun Uldrikis <stuldrikis@gmail.com>
Date:   Fri, 30 Jun 2017 13:29:36 -0400
Message-ID: <CADHEqX9-w5uZpS1RiP9EjCpWB0V1SVYZ5Ddsv3etCvBteOv4qg@mail.gmail.com>
Subject: Re: git log use of date format differs between Command Line and
 script usage.
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes. That is the case. Just confirmed it. I'll remove the old version.
Sorry to have bothered the mailing list.

Thank you.

-Shaun

On Fri, Jun 30, 2017 at 12:43 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Jun 30, 2017 at 9:06 AM, Shaun Uldrikis <stuldrikis@gmail.com> wrote:
>> If you supply a non-standard format to the date configuration for git
>> log, something like:
>> [log]
>>         date = format:%Y-%m-%d %H:%M
>
> So I ran
>
>     $ git config log.date  "format:%Y-%m-%d %H:%M"
>     $ git config --list |grep log.date
>     log.date=format:%Y-%m-%d %H:%M
>
> Then I have a script as
>   $ cat script.sh
>   #!/bin/sh
>
>   git log >out
>
> after executing I get:
>
>   $ head out
>   commit 7930db48ca31b41ac335ae8cd25cb29094d1de5e
>   Author: Stefan Beller <sbeller@google.com>
>   Date:   2017-06-30 09:26
>
> Also gitk seems to work here.
>
> Rene's answer sounds reasonable,
> check the version(s) of Git on your system?
