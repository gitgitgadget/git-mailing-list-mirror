Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C042E1F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 16:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJFX1G (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 19:27:06 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:32783 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeJFX1G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 19:27:06 -0400
Received: by mail-qk1-f177.google.com with SMTP id 84-v6so9830804qkf.0
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNcHr0pALxd2eF0OjFRDhVzX41eKlZaTQzNFWch6srU=;
        b=tmpIFEe8W3qv5nXxGj4NhZTOsb8EfWyWRnA5pkowh5SMSb8fFKaeXQIWc0AMSkd5f7
         B4tRLGeoWPH25unVo8KRW2xvdoMvO6B6a3aKvdaYNiZS388XmZl0m4vTdBehYj62tUej
         WL3Axp3RGo+eO79yhrQqtFyVQnSUGzmdBATpx8HioP7Ahe3ZT+E6EbrmHtOZqxw3zk/J
         9SzZZk2b5P/iV9ICKxo1jQVJDjKNeGhYYeQR6or4n49KQVx9GXcabOGax2nJTm0Lfnv/
         DYrEhxiR+4szPVVmBhoOXPC4IMlJaYp2U3pzrSbVCBdGnm3+wyZ2m4I6WeXIHPwUPpSP
         RTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNcHr0pALxd2eF0OjFRDhVzX41eKlZaTQzNFWch6srU=;
        b=Z/R3fsUpPEbx5wctbIQuYw0yTSvCjAJTPB6atOjeXS9M6Kqf2nIF0J8loRZ2Fn4Hz4
         Kb6cRqOjKebwGPwGFJQ8s1kKY+VsfuCzDNlQ3gXPG/F0PpmVpx9A+YMyY81P9NHt7htS
         XaSmSTpckKSKiEMjyZT8r6QC55TNQxcUmLSl+JZI9wTsm3x5aK6BSHHSPWJOJaO7AbdA
         eH3pF1sLyBhGTwmNdpMtUQC5X7yzs72YhKi9IUWwIxbkNCDiMUd362qNsOjFIdXnIEkr
         ApGEERNnu67mjBvAhHKwa3OMLQZrlkDAAMDmN1yl8sVc25HFt31JpU9xK+PJRKgcaph/
         GFyg==
X-Gm-Message-State: ABuFfohrkamKr0BnoMptf0i7l6ftxjBI1XycQgxY7cVuBeBmE/Qtp/9a
        TfAwnGDDd2+sJNaM4MZhkh7xh+6XAIP1n2LxTWY=
X-Google-Smtp-Source: ACcGV638Ot5UH6I9Ufv6xMu4XO+sF66JngXVar7TpVo4Q5Lw5BDlkr1fHs7lJw2yjm//NvqmH2sQ/rcTVt1A1Odl1e4=
X-Received: by 2002:a37:1067:: with SMTP id a100-v6mr12703782qkh.150.1538842988381;
 Sat, 06 Oct 2018 09:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1810061712260.2402@hadrien>
In-Reply-To: <alpine.DEB.2.21.1810061712260.2402@hadrien>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 6 Oct 2018 18:22:57 +0200
Message-ID: <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com>
Subject: Re: git log -S or -G
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 6, 2018 at 5:16 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> Git log -S or -G make it possible to find commits that have particular
> words in the changed lines.  Sometimes it would be helpful to search for
> words in the removed lines or in the added lines specifically.  From the
> implementation, I had the impression that this would be easy to implement.
> The main question would be how to allow the user to specify what is
> wanted.

As far as I know this isn't possible. The --diff-filter option is
similar in spirit, but e.g. adding "foo" and then removing it from an
existing file will both be covered under --diff-filter=M, so that
isn't what you're looking for.
