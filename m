Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8C820A36
	for <e@80x24.org>; Tue,  7 Nov 2017 20:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbdKGUqy (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 15:46:54 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:50419 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbdKGUqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 15:46:53 -0500
Received: by mail-pf0-f174.google.com with SMTP id b6so364283pfh.7
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 12:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mbPLr4Vt3DdZIbZ4r1pYMAycCnFBox23zXBd1PJklbQ=;
        b=hJAC5JoB91XNC1/sqsCjcb2eoP3t4QkrQT3FrtS7+KJ8XTlDqn+g2nRG7uGWhLB1FA
         kL5umFHVMIcCEomCaStJjoPN77T+XMnaQt8bouTyl1l/cvRaClyvW9Q+pkwe8UvZGIII
         iE3jZQZ1iI9k0U1YyQtu6r/XysilL1YP5CR6N2ocpkvmoycnQldq4pX7NAfwLVHl8vBa
         rILvVhy6t3AMmqIt6ASrqXPyuBZYn97sJsQwyv9wMSGVeK6ZdxN/dnOqWfpEvU76AtrV
         pL5Teq1v4N9gORXFg9M79pIxX612J1fJJcgqGbP+0CxbsnLll2Ge3ruurDCZQegpkfcW
         PTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mbPLr4Vt3DdZIbZ4r1pYMAycCnFBox23zXBd1PJklbQ=;
        b=ACJV6y8rHjt3lWQhPAG4rvkvvBPiAl+tuWkLc3usKc1/C/jx3n4GBOl3nRpqpRX5vU
         o0MrFnkFGOgCHc8qERN8awOsEtsVtJpQXpAUjshm1LUfu+BydfOppambcPV6GSd/IqT+
         uBm2gtvNyvrBbXosHq5WhQl4WqqKA2XgRyezP7UlEV2TSrWSQ7thzY6HQA/KH7dmu2ww
         f4UmxwhRe9eiKcPii7mCWMtR0Gt79Q56EYxsP1uepJhPNU48vX1xV6FSAbBiKardAKQN
         eF2oJKjRHR7jwUlLmX9dGDnuwbvmiIBaqRnU0owefTV9XPI8wRXK3VKOoJIacYJnL+9k
         RhLw==
X-Gm-Message-State: AJaThX5YbD3MVy7clCcv4tq/KjY3hN8qysd03UDiFK0AvNt0cWw4DIQa
        FplZRal1PUwOZiC/0VZvnzO+vresLhLDKmNFHkI=
X-Google-Smtp-Source: ABhQp+Q6LWoXzv4VS8C7gzqc/3vlr+EJpFBrFGfWJ+CDuGZropnyj6Nt4d6aJOK1U9tS/Do14yGUS2z1HX31uoF8UdE=
X-Received: by 10.98.220.220 with SMTP id c89mr6466pfl.167.1510087612521; Tue,
 07 Nov 2017 12:46:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.177.141 with HTTP; Tue, 7 Nov 2017 12:46:52 -0800 (PST)
In-Reply-To: <20171106104801.73n27fgmn43y6m3v@sigill.intra.peff.net>
References: <20171104092850.5fthdgvnihd3y4fm@sigill.intra.peff.net>
 <cover.1509879269.git.martin.agren@gmail.com> <20171106104801.73n27fgmn43y6m3v@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 7 Nov 2017 21:46:52 +0100
Message-ID: <CAN0heSrgkjpt5MfMbc15L0z3M6ch3F3qBgCqEf7i6VOe73fWtg@mail.gmail.com>
Subject: Re: [PATCH/DONOTAPPLY 0/4] first steps towards pager.foo.{command,enable}
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>, hkleynhans@bloomberg.net,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 November 2017 at 11:48, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 05, 2017 at 12:58:18PM +0100, Martin =C3=85gren wrote:
>> In particular, they do not teach `--paginate` to use the pager
>> configured by `pager.foo.command`. It is already now possible to use
>> `pager.foo` to say "I don't want you to page, but if I later give you
>> `pager.foo=3Dtrue`, this is the pager I want you to use". That does not
>> work with `--paginate`, but this can all be explained -- indeed, we
>> document that `--paginate` overrules `pager.foo`.
>
> Hmm. I think the current behavior is actually buggy. I assume the
> documentation you mean is from git.txt:
>
>   --paginate::
>           Pipe all output into 'less' (or if set, $PAGER) if standard
>           output is a terminal.  This overrides the `pager.<cmd>`
>           configuration options (see the "Configuration Mechanism" sectio=
n
>           below).

Yes, that's what I meant.

> That comes from 06300d9753 (git.1: Clarify the behavior of the
> --paginate option, 2010-02-14). But I think that commit was just trying
> to clarify that "--paginate" overrides the defaults and config, but not
> does say "always paginate".

Thanks for digging.

You're probably right that this was not intended. I think I put way too
much weight on the "s" in "options". I understood it as "both ways
pager.foo can be used". From the commit message you point to, it seems
that only the boolean-ness was intended. (The "s" probably refers to
pager.foo, pager.bar, ...)

>> If we teach `--paginate` to respect `pager.foo.command`, it seems that
>> we would either 1) introduce a small (and possibly hard to understand
>> and explain) difference between the old-style and the new-style
>> pager-configuration or 2) knowingly change the behavior of
>> `--paginate`
>> with `pager.foo` or 3) knowingly change the behavior of
>> `pager.foo=3Dfalse` as documented in the first patch.

> I think I'm suggesting (2), then.

I think you're right. If this topic doesn't get picked up in the near
future (in London or elsewhere), I'll get back to this.

A final thought for whoever tackles this: Playing with something like
`git -c pager.log=3D$foo --paginate log` vs `git -c core.pager=3D$foo
--paginate log` might be helpful. Possibly $foo=3Dcat could be
particularly interesting, I haven't thought hard about it.

Martin
