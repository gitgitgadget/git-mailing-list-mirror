Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083591F453
	for <e@80x24.org>; Wed, 30 Jan 2019 23:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbfA3XCl (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 18:02:41 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34792 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfA3XCk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 18:02:40 -0500
Received: by mail-ed1-f42.google.com with SMTP id b3so1094662ede.1
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 15:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5Gq0VIR7ojWhsEJ8SRfixfYEzk2BCpa7YQrEQVidjYM=;
        b=m0Ly9HjZ3zTm0pBEJHspaIoLVbAONiXyALMOmkql/ZSBDJ7fE0WWnt4dYZ+GAk5ygV
         bXVWvvaTw1BnvlKwEUJ7GPzh/49GZbRJD173EdQvMuME1Hz84VSQcu47QiTz8uIxnmht
         RXYGChV7E0KbgjWMhBco2rGPo5iui+2IY/8LwB5Tk2vtZYeWMYd78m4lIkniWkSOr4wN
         EyBaX81+KHuuOrW0AJbhUMqn5JqD+CSRUfjbjJI7VTSj3X8fyRSOx8oKfFH/Q9LhxeZu
         HxLlOAcBEO2V72YjlK+WkU3wbHr22GyQDmMvzwbaSC7DSXaL3+kqxNSeAKZTNd9gK/GY
         QwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5Gq0VIR7ojWhsEJ8SRfixfYEzk2BCpa7YQrEQVidjYM=;
        b=UTuJvPm2RVBg2Gw3FNbdNG35rO3sQKmq4JcpT7UUmSOVQ8Niz5r19pfWVGzqeRupNc
         uHaADc2UzJUcJSHTGahv9zfdlEQLkl+zmmda9CGyOr+SBPNWyw28pDvwPzs7wr7kQ8mI
         bXUZ/qUz0ElDD528SHq6NPeLxP292ckeTSNLSxqpmVxwmyRXSsvFalclejOOG+MUx/ks
         cyQdjpvvjOFW1f3DL0oq8g/smAPByDiSeT8TRxuFMYcsR3Utj/0DGWxvR6uLvFmKSRXi
         R7G2DJp8U8STDnCclrpuPvy36932BZsU2rdBlH8OuHAPbiZ7bU+WgVJnLYynw//vSkjf
         4jpQ==
X-Gm-Message-State: AHQUAuaWFxW+WAqLaMFdC76f/eTELFdkTY7y8wupx8aGKvrzHCVlkh1w
        xmFLJd7plPfkkOeDDZrQ2N+wY+uZ/VfbM1ljRYI=
X-Google-Smtp-Source: AHgI3Ibj6Y0hRFvxLkaLZ9lwIi2QIo22h/d5kRsOA+WbIjwyOWvkg55a/SWcr3x148QK8oNtLtei+ykWARDgOSn2AjA=
X-Received: by 2002:a17:906:1191:: with SMTP id n17mr7512147eja.47.1548885505269;
 Wed, 30 Jan 2019 13:58:25 -0800 (PST)
MIME-Version: 1.0
References: <1fd0fabb-a9e3-da85-0b00-e00578bd2ccd@narod.ru>
 <CA+P7+xqv0bH+TfeN8eG0b1XT7zNdvxJxsdOktywQdpA0DS5EBQ@mail.gmail.com> <5e27b012-c915-e390-9391-e42e1c9bb08b@narod.ru>
In-Reply-To: <5e27b012-c915-e390-9391-e42e1c9bb08b@narod.ru>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 30 Jan 2019 13:58:13 -0800
Message-ID: <CA+P7+xojhETwiwX-ADMoY8Ln8DJ9RSRq6NWfLrtarLv=rBh22w@mail.gmail.com>
Subject: Re: Feature suggestion: Filter branches by user
To:     Victor Porton <porton@narod.ru>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 1:51 PM Victor Porton <porton@narod.ru> wrote:
>
> On 30/01/2019 23:49, Jacob Keller wrote:
> > On Wed, Jan 30, 2019 at 7:22 AM Victor Porton <porton@narod.ru> wrote:
> >> I want Git to display all branches created by me.
> >>
> >> So we need the new feature of Git, to display all branches created by a
> >> given user ("me" by default).
> >>
> >> I think, the similar feature for tags may also be useful.
> >>
> > Branches don't contain authorship, as far as I know. Annotated tags
> > do, but lightweight tags do not.
> So it should be changed. Branches should contain authorship (to
> implement my feature suggestion).

If you wanted to implement such a feature, yes that would have to be part if it.

I do not believe that it would be easy, and it would likely require a
lot of effort to do so, because branches don't point to specific
objects (unlike annotated tags), and thus the information about "who
created a branch" would not align well with an object.

You *can* use the most recent commit in a branch as a proxy of "who
last edited this branch", possibly by using the committer.

However, because branches change over time, (as new commits are
added), you can't simply store the information of who created the
branch as an object (which is what annotated tags do).

I'm not sure this is feasible.

A simpler solution for your end, is to have an standard prefix you use
for your own branches (i.e. I use jk-, because that's my initials).
Then you can use prefix matching to find the branches that are your
own.

Thanks,
Jake

P.S. It helps if you leave the list in the reply line so that the
discussion remains public, as this is an open mailing list.
