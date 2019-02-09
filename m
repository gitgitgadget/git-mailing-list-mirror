Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A221F453
	for <e@80x24.org>; Sat,  9 Feb 2019 05:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfBIFB0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 00:01:26 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35834 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfBIFB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 00:01:26 -0500
Received: by mail-it1-f193.google.com with SMTP id r6so14510090itk.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 21:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9oXGPwCDdTN6rQ6FnKlu8sreSr2yJ/FlkdPz6FAqmM=;
        b=Dp8vD8XIxoJ5GOIoz4/LSfH2c7s9NFJkCfaIDeHyL61wnOWEHWcL8ZUS9tO6ED0tEU
         zqOA/nTlHuR4IhTXPowo3CtI4mmqttn+w2+jcIk+oRRy83iPHIb2+e5hHa/IV7dSe3Ok
         Ry1E+vg89UIKdPXh0w5kwrnE/vYPQ9MIn6741rkxHXKKbYmvtGeKsEFV1QI35oioWR3B
         fmLiW4uiUanhJHdNIISG4k6+WnMi+GAOgOIgZfxvixsxrKPHA+A5oj1Xm8BzPrmN+XDM
         rj2VuXIAYchqjKjI5MuhUSg6hQ7w5MFnz9Seawgq9kh1xy64FyQaz6OJ09V0KSpjnTqD
         RDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9oXGPwCDdTN6rQ6FnKlu8sreSr2yJ/FlkdPz6FAqmM=;
        b=beAhTK8hiChaYjrs0yuwnDwVoREm1PcWYhp8fheTYHCCN3viyuO8NOwIQ+mf0SJ9mK
         t0BwYXRsLytW4j4N7qDDsUS3cJA18/U/4+YvTQYawlcSejN9Lumw8nwlwjQyKCEZqTRH
         xsUeefNu+an+QT2gH2vlTLZ2UkDEQsHQ53yYD13fioKoLrMwMwApfAFFxq4wVD+QLnVb
         W103UUYVyz/Fi9j6jOHnFvAlzObZSPcH2gviCQQmi4fr/O9RL+4LoX6Oj9k0gjCL9eMw
         kgr92uiqUx2ZMP9WsjNqJwU5wqluJrAUq24age4f1H+ydBJpSk5nWIMbYQQaQvtE4qmy
         q78g==
X-Gm-Message-State: AHQUAuYplN8o3y9v91nF0mzGBcw8pqYWqhI2P2E6zA0s/7yOoN1snZMH
        tuE6hdiSOiOmObEOS8xLS0NRrq1Gq3cBIOZLMoA=
X-Google-Smtp-Source: AHgI3IYQ/Zq8WTKkhHYn3ec/QklBmKfZVNrBGw94EfJZNAkpFPvgPA1fCN7sYgNkyjHTZ9i1/3jozaIL1TeJHzYJWLU=
X-Received: by 2002:a24:2fd0:: with SMTP id j199mr1010574itj.123.1549688485686;
 Fri, 08 Feb 2019 21:01:25 -0800 (PST)
MIME-Version: 1.0
References: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
 <20190208100221.GA22283@ash> <CAE5ih7_b_LXfPp5eMcrr4iSuyzaiKxvQqN73Osw+ck9CPrfdqw@mail.gmail.com>
In-Reply-To: <CAE5ih7_b_LXfPp5eMcrr4iSuyzaiKxvQqN73Osw+ck9CPrfdqw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Feb 2019 12:00:59 +0700
Message-ID: <CACsJy8CeRFyhkdohwU_KtXtgmkOzNsQPb4oKFcn+R210MpS1KA@mail.gmail.com>
Subject: Re: could not freshen shared index ..../sharedindex.0000000000000000000000000000000000000000'
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 8, 2019 at 11:39 PM Luke Diamand <luke@diamand.org> wrote:
>
> On Fri, 8 Feb 2019 at 10:02, Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Wed, Feb 06, 2019 at 10:25:25AM +0000, Luke Diamand wrote:
> > > I've recently started seeing a lot of this message when doing a rebase:
> > >
> > >    warning: could not freshen shared index
> > > '/home/ldiamand/git/dev_full/.git/worktrees/gcc8-take-2/sharedindex.0000000000000000000000000000000000000000'
> >
> > There are only two places in the code that could print this. The one
> > in read_index_from() can't happen unless is_null_oid() is broken (very
> > very unlikely).
> >
> > The other one is in write_locked_index() which could happen in theory
> > but I don't understand how it got there. If you could build git, could
> > you try this patch and see if it helps?
>
> They've gone away!

Great! Since you seem able to reproduce this (and can build git!)
could you try bisect to pin point the commit that causes this problem?
That would help a lot. I think you could start maybe from v2.19.0
-- 
Duy
