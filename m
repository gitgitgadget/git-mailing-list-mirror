Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C2D1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 19:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeIIAR2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 20:17:28 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:40738 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeIIAR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 20:17:27 -0400
Received: by mail-pl1-f170.google.com with SMTP id s17-v6so7989036plp.7
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRKXomC74TzLuDQVfnUyu79pkWEkTFHFihcsfUExG2s=;
        b=IzYy6yRVXFGnBM5Sb14IYt40iRheDSHYGA++xr/fMJnbJIii5IDTon4QxSOr99anhP
         +7od49h2cg3OuRWYIciQXbOGQADaDkcOyGcKmmo7Hceu1bIQ/XbsweJQlWc9gK91iRxV
         PZmJejQ3Q9zkoBKUEbsHqUUMFcZRdZUKHnCox88e8ZWRSPZfDWuStWlDNmmL76Z0m/vc
         xXT8S41OP+sPfsWMkdvwWL5wYRNdvjCOLHrIdi6RZW6GLkCNcTdscUTJe82B3v3LMenq
         ZShzEmkds1NolMvrn63dqIEO/tyWTX8EnI679cpe+Hglo15morv3scYyOGeWL2AQgOdK
         at2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRKXomC74TzLuDQVfnUyu79pkWEkTFHFihcsfUExG2s=;
        b=sLmJRSFPNWQZ+kZUjHXmlIIxrOdMz6n8GJ2MxQ1EsAnwZETRUUrVSQddtYMVWpRuaS
         lL/b8D9xqPWd4H3ew2yluOyW5hKzIj5NswQa/WQbuKcQHtzb6o8xj1o6dqkKSt0l3dSQ
         AKIfWIz/GIRW+FYajHRoeP5WGMJ8XLe1oUdN1Rbwmya8UL9PwzzVTLaMR/TL1/xT9Gcf
         n7kGZZSRmK3HH5rmTMZ3Nm7bf4Bi3ZGfC32R9UclHc2wKphDH3I4dImJNohv5TD8Zj1I
         /rOEHoO2PcMa5ImZT8oi3RLtZ7Vgr74x9vZbNZw9nmqZdh8VzVALgOBTzr8aSWPkid68
         QDMQ==
X-Gm-Message-State: APzg51DDdVXPk0u2c8TwQKoJZbVhBhFs2U9JfOG7l9h2Q/IeIF4YB18i
        yODn9Y5IOaTmH9KkE+QKVQlf/nEzrJ4koB48oKw=
X-Google-Smtp-Source: ANB0VdbVkycJEwcRduSdPrpuIfVAATp3ZtM9rasJiLz+ixV+aboW5jGiUmWu8tcTeMiTveBU/iI3VMR/RufFlrMdqiU=
X-Received: by 2002:a17:902:e109:: with SMTP id cc9-v6mr14175533plb.96.1536435039179;
 Sat, 08 Sep 2018 12:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
In-Reply-To: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 8 Sep 2018 21:30:24 +0200
Message-ID: <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
Subject: Re: git silently ignores include directive with single quotes
To:     stas@stason.org
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stas

On Sat, 8 Sep 2018 at 21:00, Stas Bekman <stas@stason.org> wrote:
> [include]
>         path = '../.gitconfig'
>
> Notice the single quotes around the filename. When this is the case git
> silently (!) ignores the custom configuration, which is clearly a bug.

Thanks for reporting and describing out your expectations and what you
observed.

Actually, there is a test explicitly testing that 'missing include files
are ignored'. I couldn't find a motivation for this in 9b25a0b52e
(config: add include directive, 2012-02-06).

> The original problem cropped up due to using:
>
>  git config --local include.path '../.gitconfig'
>
> which on linux stripped the single quotes, but on some windows git bash
> emulation it kept them.

Huh, I wouldn't have expected them to be kept. You learn something
new every day...

> What am I suggesting is that git:
>
> (1) should complain if it encounters an invalid configuration and not
> silently ignore it. It took quite some effort and time to figure the
> culprit.

Sounds reasonable to me, but I might be missing something. I'm cc-ing
the original author. Maybe he can recall why he made sure it silently
ignores missing files.

> (2) probably allow the quoted location of the file, but it's much less
> important, as it's easy to rectify once git gives user #1

I don't think this will work. Allowing quoting for just this one item,
or for all? Any and all quoting or just at the first and last character?
What about those config items where quotes might legitimately occur,
i.e., we'd need some escaping? Actually, something like '.gitconfig'
*with* *those* *quotes* is a valid filename on my machine.

Thank you for reporting.

Martin
