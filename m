Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81BEB2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 15:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757232AbcKCP7Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 11:59:16 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36326 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbcKCP7P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 11:59:15 -0400
Received: by mail-lf0-f48.google.com with SMTP id t196so42901520lff.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uj530PTYofCKxwe0gUsrUXDMfDaLRmZCwMnFegeqIOs=;
        b=MkhP3hlv2uVePvq5Y8+BxoNw/hrIDsKoR9r0+f9oXH7UmNXZjv1TPelXwibRdBuFES
         7slRnU4d90jHdlnZCowwPT0LAyrZLa9qvegTUyONP3jr4aCWS0ha1TvPMhDmeLAhfbFd
         q2EBSECW/8ShAcGuT6KFu6NKa0nJrtp5zIDhi+B3Hgq97UpLaND75Gxi+Nr54wZcQ/gs
         BPZ5t/3dvNVF0yvRuDStgSCfptw6cly9BRwceYr2vg5uBL8ix4Gx9ixwr0RpNKT/xiwX
         4n18Q9uU8twi2INsc2XsrClmnUVPEt4WGf1mJK/5GlCG3XoI/KZAdOBs5KQ0pQW/JPlb
         YVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uj530PTYofCKxwe0gUsrUXDMfDaLRmZCwMnFegeqIOs=;
        b=bsOj0Vtan6k9wuCGt4IB3PGyc3i3pp5f6O5emBukUMXSr+G5SUe6IThJ+zETv1swxU
         9Aq26K67NG1WvOxa7ukDHSFjNRFoOM7w+SPvS8cAROUg2yQeL3nhPEgQJyQfiMWca/9Z
         1TJItWxtFE7iuiHvYrYmcbK2z3LvA+gvNRMCsCrfGKZEWiA60gxpDZu8jebmddefEJ6E
         Gazzbpm7bkiksh7jsh4Vr5B2i49kICuU2otWI4oAG7gPQG/VonxUKIlvvmjIi3681dIX
         ikh3pnrsVK3KIduGy7/UhHwq3MrIeEzPRYaH/+UgTjLYbP69rCPEAczHNX+Y6VUx/rjm
         UNng==
X-Gm-Message-State: ABUngvcdC6w08mVWljuTSwcaB+f693EBDzktSAhVFqqve77SLDWOkcKUn7QKSzRWL2ShjP4wkybLmUwqSSWKzw==
X-Received: by 10.25.217.82 with SMTP id q79mr4814889lfg.13.1478188753980;
 Thu, 03 Nov 2016 08:59:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.215.102 with HTTP; Thu, 3 Nov 2016 08:59:13 -0700 (PDT)
In-Reply-To: <20161103155400.jqzopj5i2rrlj6km@sigill.intra.peff.net>
References: <CAJUoZVYF=ZCBUX6jztwhJX3BZdq4JEfrSRbi4cFPwn+7yA=VjA@mail.gmail.com>
 <20161103151422.nhrgzivapy5tisr4@sigill.intra.peff.net> <CAJUoZVbnWzpjzWe_qGZTnX_6N2+OJVG39WYaBgY7OfQBNCg+rg@mail.gmail.com>
 <20161103155400.jqzopj5i2rrlj6km@sigill.intra.peff.net>
From:   Chris Purcell <chris.purcell.39@gmail.com>
Date:   Thu, 3 Nov 2016 15:59:13 +0000
Message-ID: <CAJUoZVY0-OA7Tu=cHDPH+NwmQ8MUuWc37_5aqeGQbwKpNWVzqg@mail.gmail.com>
Subject: Re: Bug in git rev-parse @{push}?
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Thanks, Jeff! If I remove the explicit configuration of remote.pushdefault
>> = "origin", I get the same error message as you, so I suspect that's _not_
>> the default.
>
> That's really bizarre, because I get the same behavior with or without
> it set. Not only that, but it shouldn't even come into play, as
> branch.foo.remote should take precedence anyway.
>
> So now I'm really puzzled.

That's because I lied. Sorry! Too many branches configured. I've actually got

[branch "foo"]
    remote = .

If I change that to 'origin' like I claimed it was, it starts erroring.
