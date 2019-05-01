Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E095B1F453
	for <e@80x24.org>; Wed,  1 May 2019 22:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEAWz2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 18:55:28 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34355 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfEAWz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 18:55:28 -0400
Received: by mail-it1-f195.google.com with SMTP id p18so4127598itm.1
        for <git@vger.kernel.org>; Wed, 01 May 2019 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=6Wi+CdZCy7kTSjHhURjcVPGwocShru5GhJj/wUxE2Vo=;
        b=tpsJBbypfG8FgSxx59GYCo5xQgjvCrVnnzVmHroxuVkFK2SoOIqlmMXFzUBC+q2uUc
         liUjfnMsWEKGEN4ZM9nkovDjM44ZWwGveJMXDrabe4bgvwtg18k1Hp/GkFcvPcQVYknc
         S7MKOVkh4pk4eZR4L6Q9IieRWjwQbSAvsRrPLL3EzOJ9TAYhC2FjU38MlI8fr3wd1ilV
         Cyf8nnBRgvvIXbbBt8SVsL4QedIf5aKKVK6Loedbde5VaBkqHUl1psPCLiVJoCF7r8yy
         bUl3WncJ8baLoZGEi0D6JwdI1B4YIyDid7xTOKYGTdeZxXyngdBx4Q3vqz1QRr/kPCwW
         gHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=6Wi+CdZCy7kTSjHhURjcVPGwocShru5GhJj/wUxE2Vo=;
        b=pXSSzvmcjO3sh0GkUkuH0dQCqXdRPRtGdxnLRheD1h7Kp0byFwRuRDENrEHIVAYyCk
         0slifcKbh3nBVYkBCU9TaAYxWn5qGpq/orkYb669zy0XUp1t11IamXbDojFL4CdSKMC8
         f28Pmc0M3ZUUKjuHWv7gOTJc4WtFTgmdDWjxPeZ0W8zqlRaLcrMsG8iFh8NvYtmNdTN2
         grxwBd3/3xEv4BvSvuAUg3/MB82upHH1JvZteUj1j4ryRj/kN39FAUJxmPvLHc3jYHJu
         ocMuBa71tN2nKCczHvBfmy7G38LOiX5V2bY3uJUTWsieDIJLqdbGK89pqwl0lQepLwzq
         YcfQ==
X-Gm-Message-State: APjAAAWfOzkedcagi2doG/mpNG16BRbx8rAHY+gUDCcaZ8hBZ8JetOig
        5KWHdjCAZ08tsDRsSiT7+fp2w88O8ApMeFW0kcA=
X-Google-Smtp-Source: APXvYqzA18MVESAMJ0GP5PiQ+jcpLVCG3IoxeSZUf1slX91moriQM0Na5TWjbq3/u9vwBWgCYxCH88mf4hOT7GeTxYw=
X-Received: by 2002:a24:1104:: with SMTP id 4mr112329itf.10.1556751328020;
 Wed, 01 May 2019 15:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8kec2N0fkt6cWChOEGtGkrOE5S+QuZnQnDP1eM9mg_EOQ@mail.gmail.com>
 <20190501223005.GB42435@google.com>
In-Reply-To: <20190501223005.GB42435@google.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 1 May 2019 18:55:12 -0400
Message-ID: <CAH8yC8=kntpNKwEFrQ32zHbRqrQyvAgSqejFmJcAu__B9KTC7Q@mail.gmail.com>
Subject: Re: install: gitweb.cgi was not found anywhere
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 6:30 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> ...
> > install -m 755 gitweb.cgi '/usr/local/share/gitweb'
> > find: cycle detected for /lib/secure/32/
> [...]
> > install: gitweb.cgi was not found anywhere!
>
> Sounds like it's using "install" when it should be using "ginstall".
> config.mak.uname contains, under the SunOS category:
>
>         INSTALL = /usr/ucb/install
>
> But gitweb/Makefile seems to forget to include ../config.mak.uname.
> How about this patch?
> ...
>  gitweb/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index cd194d057f..333aa58be0 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -39,7 +39,7 @@ GITWEB_SITE_HEADER =
>  GITWEB_SITE_FOOTER =
>  HIGHLIGHT_BIN = highlight
>
> -# include user config
> +include ../config.mak.uname
>  -include ../config.mak.autogen
>  -include ../config.mak
>  -include config.mak

No joy; same error.

Is there an option to build and install only client tools? If so, I am
happy to use it as I don't need server tools.

Do you want an account on the box? I need an authorized_keys file.

Jeff
