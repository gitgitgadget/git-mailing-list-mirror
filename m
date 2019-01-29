Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4751F453
	for <e@80x24.org>; Tue, 29 Jan 2019 00:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfA2AtM (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 19:49:12 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:38847 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfA2AtM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 19:49:12 -0500
Received: by mail-it1-f175.google.com with SMTP id z20so1540798itc.3
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 16:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZYBcmpVQeaGbSXvc/kATZu38cmX3rz372bu5Gd4Zck=;
        b=PrTnchdtVOdaDS53P8dH4G3Zf9j7P809CmkDwSvbQYTI3uah8Ksgmx562Jzm3hI64z
         f9rTZnNfq4soYl1KzYIj/mf97ifkDnG3Hhi6ML6a67UIdTHysh7UdhYyiweRVspvN6rq
         Un+AdywYKxwkVQpgvY7kVibtlMIvrjj99AMGGApmYDxgdJaMHoOnNQtMKTnJuM1dEp0z
         z0CXm49pjcmcalweVfqPTuw1atgGG9fWUt7kzwEBSTmw4Dl8dZE/bkDBZ5HlsO/mZ/RK
         FCcuQkyyzxmeJswAmztATrHfxA5PR2o1Xt5mnL8SWrqOB/pLfQ2fQKF8O5s91Hm1aEuv
         TK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZYBcmpVQeaGbSXvc/kATZu38cmX3rz372bu5Gd4Zck=;
        b=pEKT8jlP6wUb5x0jHEbKyXeUSRDDzWkbj2ya6jwCTqTwHj4cmQOzDEZqUZaStadVtY
         a98FjRJeoQIXTb8YwtcNzKeF340ypJ47N8l96tBsoHDz7pEajKJm9Sh+JqILUZyNigqS
         Uz67m9eAYZ7R3ks4aGyIiDMKiqRx/xoPR3Soths4gBqhgvO80rCj11EXvLZQpXnlPeWu
         g2KEwSpELnSgQ13rmpG95ihHg6A8L1m57o6OAjWpvsv7r17njzxZVe9Za0ukpm7aM6HX
         sB43NoGhYj2guXz1JUIYLyhjtsdYiBxU6iowwSRynnnQfg9cY3lCLQnIp1AFzKjHaajf
         PhGg==
X-Gm-Message-State: AJcUukdGp2FlVAXY8y7buHlnME/UYEhWnDI0q9h3BeH8OYdt+gDDW/i1
        gIdeiWFlWSHVUAnEzzOY8VZDni/xVpT2lXwdpSwwEw==
X-Google-Smtp-Source: ALg8bN61nvg+u44lSUd78tXg10B/m/dvBlsVo9BCSLFa+UmOFOzaADV+oZBiiMvCCTzZqP1esBn00E9dAJJ6DzVDIFU=
X-Received: by 2002:a02:183:: with SMTP id 3mr15049263jak.130.1548722951517;
 Mon, 28 Jan 2019 16:49:11 -0800 (PST)
MIME-Version: 1.0
References: <etPan.5c4e6be4.2ca84d68.4d5@zdharma.org> <CACsJy8BMc9k3Q=P=2CaJ9yyXhc4C_BgGVO=S_J0_R8zDweahLQ@mail.gmail.com>
 <etPan.5c4e9217.46ea0041.4d5@zdharma.org>
In-Reply-To: <etPan.5c4e9217.46ea0041.4d5@zdharma.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 29 Jan 2019 07:48:45 +0700
Message-ID: <CACsJy8Br9+m0pcErXDSsAMhhFd1xd8X0LfvLJvy63P45TX-zGQ@mail.gmail.com>
Subject: Re: There should be a `.gitbless; file, protecting files from git clean
To:     Sebastian Gniazdowski <psprint@zdharma.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 12:24 PM Sebastian Gniazdowski
<psprint@zdharma.org> wrote:
>
> On 28 stycznia 2019 at 06:05:31, Duy Nguyen (pclouds@gmail.com) wrote:
> > On Mon, Jan 28, 2019 at 9:54 AM Sebastian Gniazdowski
> > wrote:
> > >
> > > Hello,
> > > Could a .gitbless file be a solution? I would list in it, e.g.:
> > >
> > > TODO
> > >
> > > and this way be able to use `git -dxf' again. What do you think?
> >
> > There's a patch that adds "precious" git attribute [1]. I was going to
> > resend once the backup-log [2] got reviewed but I might just send it
> > separately to handle the "git clean" case alone.
>
> That would be nice solution. In the email, you ask for a name other than "precious". So maybe "blessed"?

There's a couple mail replies in that thread that pointed out
"precious" has been used elsewhere (I think Makefile is one) so I
think I'm going to stick with "precious". Besides it sounds "precious"
:D
-- 
Duy
