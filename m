Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59B7202AA
	for <e@80x24.org>; Wed, 27 Feb 2019 18:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfB0STN (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 13:19:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46346 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfB0STN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 13:19:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id 196so8328101pgf.13
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1UQognVgUnU5BJDRFh4Jw2q7YxgDdMGd+OIglf3hzIM=;
        b=ef5wb3iMETDOGSTXET7EAqtJU9dQ70EGA1sC24jqb4fKMjsW38NRdNpy8JD9vtzv4v
         L4C+G8p1FL7RXccayHsnM4lXkW5Vari0LNQHZbazdLzBYrtMIC0pfdDnDvqRaLal3FBM
         yscxIEULqs9yzplAlhvicNuH3gdl1PCca/bpJOuZs8bERd2MiLG9V68dNiRlfchUz1vj
         +Ytk+wM7BucTyzr05JLqx7c+Tpo+gdzBgv7eIZca+/tVEj/KS/I6uTjgyvFXX6vL3VM8
         iZ3PQolqyhpwcOw8RCtLvoevdRh+g9PXTOYd3l3TDqklt4ZhqCW/MCxtVDXFZKPWzkdW
         h8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1UQognVgUnU5BJDRFh4Jw2q7YxgDdMGd+OIglf3hzIM=;
        b=GwMToFo6K5FGA7VCpFaOg8VMDkdYdPEOGmu+Y9ilDJsJhpaGznnesT9nJKet87snB2
         H7xyLAIxjSQO6vU+tk8mIUccSYzmc/8/iXh5wDxAQBnAS6QsfGR9Y7woStG7iTHiUJ5V
         06IczwC77B54iC4C2H4PS91fyzwqobap0YwHJeaNYnn03c4deKEGuL2pYnIBV3cKj6dv
         L7UhH2eMrefSbqx2OA7hKPprYJlQijoQF0eIgud8g8EyinJuiByW+b+Tgu3UyZjU03nj
         sutS9BFLLeeIQQ1thZoMNAewss1VarprGyeLrc5dNiSSzt5U9oqAU6L9qeAeaKZxHD4c
         24IA==
X-Gm-Message-State: AHQUAuaMSiuVFZpcE9ve7bJs0be61ePC7XcSC+dmAIKma2uhEL9MgiAc
        Y4PM51ItWYOsIy55dSxNf1TiYDs4sGfrE0AtqtbbDg==
X-Google-Smtp-Source: AHgI3IbPUYiR9vsftwejNoU9Sz+Vo8Ig8uhEnrmYodTiPOjfH3wRc93V0cQt9WfZgohW25ksT7JbfBFq+lQsuqpb2ic=
X-Received: by 2002:a63:1616:: with SMTP id w22mr4190854pgl.200.1551291553006;
 Wed, 27 Feb 2019 10:19:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551123979.git.martin.agren@gmail.com> <e960fec4b492f3edf7bade35862333af5e8704d7.1551123979.git.martin.agren@gmail.com>
 <CAPig+cS7BdHhLn+XjjyVa+PC040y-E4iPD=kuDtigenzSHcFKQ@mail.gmail.com>
 <CAN0heSrogSpdSOGj0ibx0Dcjw=0o0u0VSivfjgL7r5f-Jiqs3w@mail.gmail.com>
 <CAPig+cRTj_jHFrqyYsn=ivuO9uNcWjB=5okX0SCGoeWU=uR8Gw@mail.gmail.com>
 <CAN0heSoWv9xTYzFS16-fjnZuY_+6vpHSHcLmwWG8DdJEmNcTuA@mail.gmail.com> <CAPig+cQ8d7_=sY5bQ8soeNAnE60o8mdE4utCiJSaJgR7p8UrwA@mail.gmail.com>
In-Reply-To: <CAPig+cQ8d7_=sY5bQ8soeNAnE60o8mdE4utCiJSaJgR7p8UrwA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 27 Feb 2019 19:19:00 +0100
Message-ID: <CAN0heSqADqqk1SaPMeQnQR3c3sabn=vD2NmfH5VinyKXk8ezkw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/Makefile: add missing xsl dependencies
 for manpages
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Feb 2019 at 13:47, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Tue, Feb 26, 2019 at 12:59 AM Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
> > Were you perhaps mislead by one of the similarly-named files?
>
> Yes, I was misled by similar names. Sorry for the noise.

Hey, no problem. And thanks for the subtle hint about "misled". ;-)
I appreciate it.

Martin
