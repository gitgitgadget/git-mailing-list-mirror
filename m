Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64BE20248
	for <e@80x24.org>; Tue, 19 Mar 2019 07:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfCSHgc (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 03:36:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38496 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSHgc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 03:36:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id n125so13109276pfn.5
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dX+uWtJeGYYf2e4lKZqVS00VWFPe85Cgzjd4lC74+Jc=;
        b=riUp7rdzvHjuBz2MehdP+lDw2uTbazqnT+y1Vq/yXVC3+cNxLOkyNmvt19VAOqBmj4
         6o3YMzjHPfviiK0/RaPfelAsJbTjTjmktep5nrOwobliaFiWRPPIM+p2ZyYxxZWd79Rx
         S6P4QzqsbcSHauONiN/Hd9NowtHkMf/EIcz9MPByXKgHj3D2IAJXgfH34smQXdPe6eXI
         BXk03NAOYfeoXUmZ5CPyLoV1I0XdbIsWxuoxWA4ezQEfnSl+fqXfZeFqjMmJg3M+/Lta
         pCRevB/QQavfVVy43GzL9o8Y8imloaBH01ViK+qGloB3bkGPlgLSlN0zubWvXT9N76kc
         j1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dX+uWtJeGYYf2e4lKZqVS00VWFPe85Cgzjd4lC74+Jc=;
        b=c3yMpl8MrEWrvAHw1m7KRii1OJ+27sNaiSTN5ZQj7SFdh9EWBBNtxQTK7qlZmMJ+kd
         feyOrdfmUHGAf+uMqmFp/tn8z9oNm7Hncdgsl0QHRZPxu2F8ltXuF4Uk+YbpE+o1TKIH
         FokLL9j4Y98zTWmZLMlXLxFOfm5T2Mhn6YoZdvb84DRBWkfISYgevaATTrP2HFqUes1u
         RtejJjwK/EORgAJUIiDdTAePURqipNDVmTt3WKFOuup8yzzgbBbT0G3wNXfex8OxPy80
         /eoX6EUbBJyXzRD51tt+0zPOaXdFOQONrJTILjdE3+CN0rxXEWLeO/2VmFheARWHJLKv
         e9aw==
X-Gm-Message-State: APjAAAWcsHQQLYZ/sUj1aoNPsTUQDJn39UC5OFtHgfY8Teu4xSLmxq+0
        iEcWXD63BEyusGjjAPeHwyXfkaONGyhDYhbC1NE=
X-Google-Smtp-Source: APXvYqxG3PS1BjTCPrZg6gAlep6VXHOOkNNRiM9u/rw5xMkpwoxELhnn88Cz2hao6RLHga0Zat5x2DiycuprUOmYdgY=
X-Received: by 2002:a63:2403:: with SMTP id k3mr718999pgk.200.1552980992020;
 Tue, 19 Mar 2019 00:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190319024645.GA6173@sigill.intra.peff.net> <20190319025945.GB6173@sigill.intra.peff.net>
 <xmqqr2b3y0tx.fsf@gitster-ct.c.googlers.com> <CAN0heSo2hdkvwnZPipgqnOnb4fmhdY6d+iHqXPfVyiLsf8SkOQ@mail.gmail.com>
In-Reply-To: <CAN0heSo2hdkvwnZPipgqnOnb4fmhdY6d+iHqXPfVyiLsf8SkOQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 19 Mar 2019 08:36:19 +0100
Message-ID: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Tue, 19 Mar 2019 at 08:33, Martin =C3=85gren <martin.agren@gmail.com> wr=
ote:
> between asciidoc and asciidoctor considerably. Let's assume for the
> moment that these patches or something like them enter master...

To be clear. *This* patch has a sufficiently incorrect commit message
that it really needs a makeover. You can expect a v2.

Martin
