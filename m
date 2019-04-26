Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA881F453
	for <e@80x24.org>; Fri, 26 Apr 2019 19:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfDZTdD (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 15:33:03 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:46568 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZTdD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 15:33:03 -0400
Received: by mail-io1-f43.google.com with SMTP id p23so3819016iol.13
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CE6vTYp98/y7RyMQgcp4UrFOKZEfgS0elmBcmc/qOLY=;
        b=c2ksLTykAUzGOIlw7i3AazdmGCHF018aWOMkJAIx2OaeDLU7kjDFDYbe6zxo3xbzKS
         MRc3u0Oh1XrvpG3kp5ncOgtQjoxE8Jr9A1nZHxOLKZqkIBtKCb6xUtxF55kJKmsnkn3s
         +/z+AgUKxLh2sQGdhLlNuD7vG+xVJ5tPjbQ4h/GHiBf+H8s03FMQKviKuC839IhkNZqb
         XiHcS6ib+8Xc/lcamFonTwWKg6OnWZVJ8h4WWW3HWVebUv6rBVg4E/zvqrD5QZwJVnGP
         s9vTG9lv0EaZpTDIEey++k7pVZN74+76ycQ7J4mLMLwX1HZvxTvfWkePiROdBjp2XJBB
         fWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CE6vTYp98/y7RyMQgcp4UrFOKZEfgS0elmBcmc/qOLY=;
        b=HozEsrUoGrQhZ5T+sK5l625x7L4nrAFPOJpeQw3uBKiSGL+0P4rhFJFieWIyXnpYQj
         s5uflZAu99ew7DW0xgknDlG/4WzWpBcAAPB9qTUY8dO1kAV2BrJbmMQIw+6weZLR60Rw
         SvYOCooUFaIDOkCkqbQs6ipzj1mrjk5bH+dz0MnCGptfBEwm6EkJevcfezYxuoR6dT1c
         8QO2TIRoqAerjf9B8TpKudfm438OUSR3RT2CpiKaCrsvzRF8fwRKEe+LQAUwhYls2o8N
         rHdDj8+6DF7VgO+Bya1d7VZGfluZUCsUp1AQ+C6yb/5CA+blXnro+Z74Yg9+UnE4LpUV
         pkUA==
X-Gm-Message-State: APjAAAWcrC+p07gY/hfdoauFSBg3G8iOCyT/pn45Xf+DODXCZzC6gUA3
        +kDun0DNkFNz309a1bD3pUftLwySbs75kIFXmGE3IiHVBRjU5w==
X-Google-Smtp-Source: APXvYqzGD1WZhBWruRZhvymBLfdAYiqlSuxRZuh+bLlEUDiM4O/7YG6bH+dIwPD4SRQnsdmlOfxhluPUEr0CJFTsCWs=
X-Received: by 2002:a6b:9182:: with SMTP id t124mr29049751iod.182.1556307182656;
 Fri, 26 Apr 2019 12:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <560CCADB-511B-495E-B86B-F294486C088C@contoso.com>
In-Reply-To: <560CCADB-511B-495E-B86B-F294486C088C@contoso.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 26 Apr 2019 12:32:51 -0700
Message-ID: <CAGyf7-G+FEDVe=WiVVNJr1ALn-ryA4862qbjdDCNXM+LhpjORQ@mail.gmail.com>
Subject: Re: add 'ls-remote' option to limit output records
To:     David Carson <DCarson@extremenetworks.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 26, 2019 at 11:57 AM David Carson
<DCarson@extremenetworks.com> wrote:
>
> Given that 'ls-remote' can be sorted, it would be useful to be able to ask for a subset of the total number of result records.
>
> For example, if I want to retrieve only the tag with the highest version, I would do so by adding this new option (-n1 in my example):
>
>         $ git ls-remote -n1 --tags --sort=v:refname origin "v*"
>
> That would save from having to receive a large list of tags from the remote, only one of which I care about.

That sort of filtering would have to be applied client side, at least
partially, so it wouldn't necessarily save as much as you'd hope.

With the v0/v1 wire protocol, the server speaks first and sends the
entire ref advertisement, so the filtering would have to be 100%
client side.

With the v2 wire protocol, the client could provide a prefix (like
`refs/tags/`, or potentially `refs/tags/v`) to reduce what the server
included in the ref advertisement, but even the v2 protocol doesn't
have anything for telling the server "Version parse these names and
then return the first N". That means the parsing, sorting and trimming
for the advertised tags would still all have to happen locally. (I'm
sure someone can correct me if I've misstated what protocol v2 can do
for filtering, but I don't see any "ls-refs" options that look like
they enable anything other than prefix matching.)

Not trying to imply any judgments on the feature request itself; I'm
just noting that if it was added it may not be quite the win you were
hoping for. In fact, with the existing wire protocol versions (all of
them), I suspect this would end up with identical bandwidth usage to:

$ git ls-remote --tags --sort=v:refname origin "v*" | head -1

It would take modifications to the wire protocol itself for this to
happen server-side, not just the `ls-remote` command.

Bryan
