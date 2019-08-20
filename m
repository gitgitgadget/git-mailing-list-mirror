Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1A11F461
	for <e@80x24.org>; Tue, 20 Aug 2019 11:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfHTL2G (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 07:28:06 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:39101 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbfHTL2F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 07:28:05 -0400
Received: by mail-wm1-f54.google.com with SMTP id i63so2314297wmg.4
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 04:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A1tuARju26Pgd1B8yO6o888IPccbeaowWEB2/Q2d0kw=;
        b=XpKu0Ugqu6ykiMovP1M8DZsuBMsyyBaLaaXrM1LkayYKmsxkgjTz9K96GfhP+9kOIN
         WKE1ItuVPiFPXwFMrZtKjeuNnaEDCIu9aoqBMr07c3yGfSY8xhWFPozYwdyv6SCLClCv
         GmkapwgxL4X9f2M4TBg2OOs7voYPsJCwWiGCKxKqjJyTbn4T3f7mG/QkLb/B1pbjAfqX
         mot1B4iGgtZUewDxUSaSfu/3Y08Ia7hzrZhMD5526Usr6XHtjsR35q6nnROKAzAJiBkE
         HMrH+pAXbVkfgMBulfzPLbG0kA2VoljizkN0KkQ8QFfEwmAFAZSzdn6SL7ab9NqfUOfS
         H+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A1tuARju26Pgd1B8yO6o888IPccbeaowWEB2/Q2d0kw=;
        b=JWspF4DPz0ElnSGQ30wH8kXixbOi8bouWzKtxUozztWlZcwlwhC67/4lFuxIkQEltj
         ZoXotzBPGtPV3D21hjbOO30mt/lultTncGV6AYUTBoaHIvwEcxQ9U8SLefrpRDKu4dGV
         4d3pKBJC6kHMxIM+A4ZQGvUK3mHv84SPaiKFvfw+9cZ/yQZVBG1MtCrJ2QyDdzFJQVn6
         bAIl+xTHNkwawvCn/Qki2uKIwnzNWgDu0kXY5bNVCVHUWP1xiy1RiuHoOJkM0wAoh6Ce
         O6VQXWW3NmDPIXIh/oRXZ/TYCj+5KQ90ZHpcH77l0KtUW9stnemRm/+x4hZth8XjOtcB
         O6rw==
X-Gm-Message-State: APjAAAV84RE8gBUmVg1rvmkBYx/l0axss/SaDK+g0AkK4lX1ag7HmthH
        jkUH8B0H9eVxEEmE0fGD5wu0Lj37JJV8SWP/2KU=
X-Google-Smtp-Source: APXvYqzMasKaduwamQt42Oi3ju3UMGfdQ0Wmj2JkAE5lR0ioIeg+Gpe5nVGice9FlwjMC0CdaAVHqy+ArMs7y7AMe0o=
X-Received: by 2002:a1c:18a:: with SMTP id 132mr25853076wmb.15.1566300483876;
 Tue, 20 Aug 2019 04:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
 <CAHd-oW5xHv-gC2gQE8_5w6nv8gq5fcLcypqe2bca63HTSaVtAg@mail.gmail.com>
In-Reply-To: <CAHd-oW5xHv-gC2gQE8_5w6nv8gq5fcLcypqe2bca63HTSaVtAg@mail.gmail.com>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Tue, 20 Aug 2019 14:27:03 +0300
Message-ID: <CAL21BmmBBBg+LboTmToem-zitg8UMLaH8eM2Q+ZmEPOMFGcggA@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=B2=D1=82, 20 =D0=B0=D0=B2=D0=B3. 2019 =D0=B3. =D0=B2 07:59, Matheus Tav=
ares Bernardino
<matheus.bernardino@usp.br>:
>
> Hi, everyone
>
> I just posted the penultimate report on my project:
> https://matheustavares.gitlab.io/posts/going-for-a-too-big-step This
> week I=E2=80=99ve been working on a v2 of threaded git-grep w/ parallel
> inflation, to allow threads when grepping submodules. I also tried
> some more optimizations along the way.

Thank you for great blog post! You have done so many things, it is impressi=
ve.

I absolutely agree with your plans to structure the job and split it
to smaller pieces, it should definitely help. Moreover, if you want,
you can make something like a documentation and delegate some parts.

I hope you enjoyed this summer :) Thank you for your readiness to
continue contributing after GSoC. It is not mandatory, you do not have
to finish the project, but if you want - all the community will be so
glad to see you as the contributor.

Thank you so much,
Olga

>
> As always, any comments/suggestions will be highly appreciated.
>
> Thanks,
> Matheus
