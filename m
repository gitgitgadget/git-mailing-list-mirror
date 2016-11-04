Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B19012021E
	for <e@80x24.org>; Fri,  4 Nov 2016 04:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758992AbcKDEwX (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 00:52:23 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35683 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbcKDEwW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 00:52:22 -0400
Received: by mail-yw0-f178.google.com with SMTP id h14so73464243ywa.2
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x6i8k8zoMdI3HePmGBQ2j1e/CAKWXiB2EP+sGtxZYo4=;
        b=wMVs6MaLXFI00Om8dzKRl5YxNoxcz0wkwPIRCLqlIUx6HaCNAGpLOAhk7t1rx0t9JS
         eY3s8nB3DV06Uqa5zYM8Jr1m0CE8jjTaQzHUTefN36CmHksCjcEJpx792P+/tJdeaYZy
         QCbgD4t8wyiUntL8el5/lI8042wvg/eWAKLNO5GSTZtmj8cRF3vas/Msrltlp7u/as3w
         ZYP5SQsTpW2mZbgsRciW8k//3tewYt3AQZnj28YJTqjnywPNUcHZZyH9bWJ12MsZYRhi
         30ke/QcTRoGZ2eNgck9oqUAEEOGuYGyGFffwp748lNljfLLk11cGxVsQ2lDaXntfxEIu
         +FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x6i8k8zoMdI3HePmGBQ2j1e/CAKWXiB2EP+sGtxZYo4=;
        b=IjjrlgI72hHPHUuuDyGemFZl9L2tYIWi0QqcA5HhAx04vWRhJWROYLeyvmPHY1pQpy
         V6ALKkDgt1Ntuzo+1gcryEsVjrUPjhmo2vvtn/v6tU5mcfKnij3o9Yfcd2gtcfmG6+ju
         Q6Ocr0oUNTQaSVMCkjH0H1n/hHXTxLs+qw3Xr4j2IkTQmuGU93G2/1537IRslK7asyr9
         bWtRg5aIl4xGRlzMTrYCS3shbMTj5LU7ZqeijypaqfoNhEUZPRQDtBPWQQQuBJC5tV8l
         pXAdBWAKnI+Gj9RC/3qkZgDognEGsrYvyH6rNbQPKTOBIbBOYxmq1Q/6S/Wey8kwHpAO
         98Nw==
X-Gm-Message-State: ABUngvd+UYyaqwY4OJJxfhaRghAQzgn5DIPjdhtvVzdKQ4+duiLxt3gWz5akJ2AlYoghss5AH6PUqSVJ2xL4og==
X-Received: by 10.129.130.193 with SMTP id s184mr1055341ywf.276.1478235141349;
 Thu, 03 Nov 2016 21:52:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Thu, 3 Nov 2016 21:52:00 -0700 (PDT)
In-Reply-To: <xmqq8tt2opw0.fsf@gitster.mtv.corp.google.com>
References: <BY2PR0601MB16400EAC3E9683841907F4B2A2A10@BY2PR0601MB1640.namprd06.prod.outlook.com>
 <20161101174526.e2tilsriz2fqaru3@sigill.intra.peff.net> <7CE3166CFD244DAABF554451E8B0800F@PhilipOakley>
 <20161101210310.sqrhvviry7iyyjrm@sigill.intra.peff.net> <xmqq8tt2opw0.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 3 Nov 2016 21:52:00 -0700
Message-ID: <CA+P7+xo9AAEcNGp5ugHuXivqdv+9rMuTkDdxQd0siGHyyvwU_Q@mail.gmail.com>
Subject: Re: Git issue
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
        "Halde, Faiz" <fhalde@paypal.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 2:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Tue, Nov 01, 2016 at 08:50:23PM -0000, Philip Oakley wrote:
>>
>>> > From "git help update-index":
>>> >
>>> >      --[no-]assume-unchanged
>>> >    When this flag is specified, the object names recorded for
>>> >    the paths are not updated. Instead, this option sets/unsets
>>> >    the "assume unchanged" bit for the paths. ...
>>
>> I think the "Instead" is "we are not doing the usual update-index thing
>> of reading the new data from disk; instead, we are _just_ setting the
>> bit". Perhaps that can be spelled out more clearly, but I think just
>> dropping "Instead" is a step backwards.
>
> I tend to agree; the biggest problem with this part of the
> description I think is that it starts by saying what it does not do,
> which may help people who expect the command to do its usual thing
> but otherwise is a secondary information.  How about ripping it out
> and moving it after the primary description, i.e.
>
>         Set or unset the "assume unchanged" bit for the paths,
>         without changing the object names recorded for them, in the
>         index.
>
>>> Given the number of misrepresentations (on the web) of what the bit does,
>>> and the ongoing misunderstandings of users it does feel like the man page
>>> article could be refreshed to be more assertive about the users promise, and
>>> Git's cautions.
>>
>> I dunno. I know this has long been a source of confusion, but I
>> specifically dug in the docs to see what we had, and I thought what I
>> quoted above was pretty clear. That has "only" been around for about 2
>> years, and is fighting against other mis-advice on the Internet, though.
>> So I'm not sure if it is badly worded, or if people simply do not see
>> it.
>
> I share the same reaction, and I find that the update in ccadb25f73
> ("doc: make clear --assume-unchanged's user contract", 2014-12-06)
> that introduced the "the user promises not to change and allows Git
> to assume" is sufficiently clear.
>

This is some what of a tangent, but....

One of the primary pieces of advice I've seen that encourages its use
was to set it for a submodule after a repository switched to using
submodules. The reasoning being that users were often running "git
commit -a" and accidentally including changes to their submodule
without realizing it because they were not used to keeping the
submodule up to date.

I saw advice for this and it mostly appeared to work, but I wonder if
there is a better solution. I failed to train people to simply stop
committing everything with "git add ." or "git commit -a" as this was
something they were too used to from using previous version control
systems.

Is there an alternative that would prevent "add everything" from
adding these files so that users wouldn't commit rewinds to
submodules?

Thanks,
Jake
