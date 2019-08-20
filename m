Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90B971F461
	for <e@80x24.org>; Tue, 20 Aug 2019 04:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfHTE7J (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 00:59:09 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:34290 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHTE7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 00:59:09 -0400
Received: by mail-io1-f45.google.com with SMTP id s21so9497747ioa.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 21:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qU6u6KPagCbNWhaRKraEuOFDUOakPiJMJuURP0LPSy0=;
        b=FN7m2xsnyEaPJCiCmijP692A0mmXkXUD/h6bQv8xrPVCj0bAcE263L/MqsfiLgCyxl
         PKC2A7KFeis+jZdpR4ayu9KArUqqfIj8tgw+kxquPOhuYNsrXAdLEipH9hTdVKvO3neW
         qGQj2ydzHco0XYam4Q4jRs3qwaONG/9qPN7pQKWbgNEdFxxTa9qIctKeun8Ywqj2mS0K
         Z/67PEGkJXHaC4dtWMLnhHsTObuaYe4LIk0+Ey5JLeU/c4yOT5EvHTjoCf2+fC4X5rr0
         v5OpVjLQOYWYqyrR7rmLVbkzsuH9D+6Z9XJdtiYbQrj+ca7vNbZRlnZRpAQMRDAM4RxM
         mmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qU6u6KPagCbNWhaRKraEuOFDUOakPiJMJuURP0LPSy0=;
        b=emHSBq8kto/m43mJ4cHcfXAo6up8Ve0JhZMSXtG1H7txXJ82IvAjVXzBXCeBDfIv1t
         O/Ses1ZDvvnL/FUD7ouKpBiLcdcCnnPJS45gzd9y53+wBh1miv+V6z8yWUvu5aWeOI4b
         G1eqa6r+cyHP5PavN4cBvevsRDJtTBJKkDWSr4Lk2I3kjkqpSt4ud8AGkdTfhSmew9fL
         JRLh8dke1DxGnjoaZNcjnb3xn46iCbOGNC2CZNfl9E6xenbRAVieXn6J73rptrd9CLwr
         UWBeUcTRjNcft8Uzl59eOMOvrhYRG0qpmm68KRZBmZ2YDRXBsO1i4sO38hw0AXbeV3OJ
         /tWw==
X-Gm-Message-State: APjAAAWLWA/I9dSMnB9+rfj2nflGmhIyhXfqLobVSZMJkZ1kSYF3SZFc
        GlVpWBzIgoKF/8WVt4dmq01yj+WTKcrVMJsfrViUVV3Xa8c=
X-Google-Smtp-Source: APXvYqw9FGcqYaEU+6A5zV8yHY3hjgt+HcSrIJvNzRVvP5xj/TBqeMeWg3PQk8etjat+7J7NRSsIiOWQNtTk5BhXvOU=
X-Received: by 2002:a6b:b3c3:: with SMTP id c186mr30171035iof.76.1566277148104;
 Mon, 19 Aug 2019 21:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
In-Reply-To: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 20 Aug 2019 01:58:57 -0300
Message-ID: <CAHd-oW5xHv-gC2gQE8_5w6nv8gq5fcLcypqe2bca63HTSaVtAg@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I just posted the penultimate report on my project:
https://matheustavares.gitlab.io/posts/going-for-a-too-big-step This
week I=E2=80=99ve been working on a v2 of threaded git-grep w/ parallel
inflation, to allow threads when grepping submodules. I also tried
some more optimizations along the way.

As always, any comments/suggestions will be highly appreciated.

Thanks,
Matheus
