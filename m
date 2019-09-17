Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD1EF1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 19:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfIQTkZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 15:40:25 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:39875 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfIQTkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 15:40:25 -0400
Received: by mail-lf1-f49.google.com with SMTP id 72so3831554lfh.6
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ogn5qUj71vuke7Gofk+Gui7VZC+8HLDaJ2nHCdTLW4=;
        b=ZqlEhop0xpEO9rBk5jhPqW3oQZcrzdWqAEkja6tvnIZdJrWiRzT+mK/5rp5IC1g7Ss
         HYM6Kj4zdRrj1oo75FhCtiRJIsoinX5C4xWBjDJXQtr1rWE1/dBRyvj9+Ny9RsN2cUBM
         BFQ7Xg3fGX4UO1CseZqDI2F/F5TR5I4BHHiOapyKiPWHEmaTAymPaq6NxChHE6HDrpbR
         1gPmNSDfVcY24gatPTQaM6JQ0kg6OF4BQvMJ6a6wIXijnIddTicUpeHCZ6fK9vI0FV9A
         RKyFHRGv/+xM7LMj/3eaxtfn12MgDWqGUcgDcoXI4tASiEzVRGWKpYANS7TElBQAMz6A
         uuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ogn5qUj71vuke7Gofk+Gui7VZC+8HLDaJ2nHCdTLW4=;
        b=DQuEKjlECsXFH2xhlHv7tnMIqkt4C7iiplOzZUd0EkW6urO3l+eOKI3JeKw/Oh6aai
         pHjkfRElinF+dUb/rSZjBDOYKDCdIVt4lGeRIj3eqn1jHYyj5Dq64uU2CWtVVgiNRBs5
         9XdIzOZHOXOkmhhHDpLYu82IutLRt8T90uYEHWYnhZdlHD/6YM9AipbeSNLAeaLXh/VT
         ef9i40PiQ9JDGNjBltSWqhBKFxx4SDPwvEBduHyIM2/ET0iWG13UOXvcOWrfWBmhDdwC
         TruHu8OzwPMDLZa25QMl6LtfWOyxEVyRC7NZlMT8PgB9f7C+85JhDjov1slIF1MbMq++
         hTdw==
X-Gm-Message-State: APjAAAUdpDryZY7aBzXJpjgT5UiCofY6siDJ2W2/4/0LiNSF7oP65ut8
        uJwNRS4anviQ+udlLG1cCI6REzmK2bapkNiFZbSfivZA
X-Google-Smtp-Source: APXvYqxx5v4IsYl9j0yEay6UAM/eL14KNzmJwjxEltKJAxZAdcNIrA2YP5NDxAMcHIdiunpVC14wAh06gFSziPhKG1M=
X-Received: by 2002:a19:c7d3:: with SMTP id x202mr7192lff.124.1568749223404;
 Tue, 17 Sep 2019 12:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190806014935.GA26909@google.com> <20190806132052.GB18442@sigill.intra.peff.net>
 <20190806204925.GA196191@google.com> <885DEEA4-154B-4990-945D-19DABC87C627@jramsay.com.au>
 <CAPMsMoAwfp+jv9h7xAD9PbqV+cU4njyf7Tex6HUCznqjb5hi_w@mail.gmail.com>
 <45DA95BF-17D8-4238-9ECF-A4D1AC1A9634@jramsay.com.au> <20190917193233.GC17913@google.com>
In-Reply-To: <20190917193233.GC17913@google.com>
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Tue, 17 Sep 2019 20:39:47 +0100
Message-ID: <CAPMsMoDYHSD=+QiVU-+AfGnV+zJ309BRb7KRC4iDaOQ-9gMFEA@mail.gmail.com>
Subject: Re: RFC - Git Developer Blog
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     James Ramsay <james@jramsay.com.au>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the explanation James :) Just wanted to understand if there
was any strong reason. As Emily said, we can easily move/mirror if we
find the need.

Thanks for starting up this project! If you need any help let me know

Emily Shaffer <emilyshaffer@google.com> escreveu no dia ter=C3=A7a,
17/09/2019 =C3=A0(s) 20:32:
>
> On Tue, Sep 17, 2019 at 03:22:38PM -0400, James Ramsay wrote:
> > On 13 Sep 2019, at 10:05, pedro rijo wrote:
> >
> > > Just a minor question: since we have git-scm, pro-git, and git
> > > translations in github, why not keep in the same place, under the sam=
e
> > > organization? I just find it easier to find than having repos
> > > scattered across different git hosting services
> >
> > It wasn't a technical reason, but a matter of me (and my employer GitLa=
b)
> > volunteering the time needed to get the blog project off the ground. In=
 the
> > context of the Virtual Git Contributors' Summit, folks seemed happy wit=
h
> > using GitLab or any other service with a Git interface.
>
> I really appreciate you setting it up, James - the starting inertia is
> one of the trickier bits of something like this :)
>
> If we decide later down the road that we really feel the need to have
> the site, book, translations, etc all in one place I think it'll be
> pretty trivial to mirror/move/whatever. I'm just happy to have somewhere
> to start!
>
>  - Emily



--=20
Obrigado,

Pedro Rijo
