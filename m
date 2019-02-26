Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F1F20248
	for <e@80x24.org>; Tue, 26 Feb 2019 05:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfBZF7q (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 00:59:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42109 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZF7q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 00:59:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id v11so265548plg.9
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 21:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F70b2UlAM0NA9XA3sCWo99aDRbCnZeiGf4XlOM+C2cw=;
        b=QjThlL1s1WN9hyTEHG/bwq4f3B6cbM6g6Cwop6tVWp/b5d0ZWHfTv4gYu0AzO3vjg4
         81Bc+Y87nN66YKgbpvX5AXNx3RP993ibb+p3M9qRZTFcKJ7GE5T1AbeYE2wxWYVdW5vH
         eSBSFFkgIVN5Lt1GH4cRxiKTTpWix4rxHa4vTsoG99xACiIFvMpJ5Fb5op5Kiv3zoi6N
         o9ntql+IYHmP+Oy4fViYGtjiQgb5u7jU6otKCagENtxYTQfHIH2U+ig01c6iGdIqgzuI
         J9iyA429q/WHhUjW5cJt0PlvXdYkPrnQJ5G2ePII0b2DCejVYpoya8KRqLpe09qJosKq
         vCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F70b2UlAM0NA9XA3sCWo99aDRbCnZeiGf4XlOM+C2cw=;
        b=HTefYmk7lvoYI+UxBGDg+Ostw0Fk0GyE0M9Cp9XpJMVZlPhGbDTqwuZi+85WrnpX3O
         C1OWqmGBKHROchFoggSiHjZrdpszg/tN/cOQ+IVV058BOGSuGXYr768MqqZtvlmlLN1j
         CoLZHGHY6llLrhJbV6G/pC8E6Oed/CjlE5F75Ak47rsnRVYI8TbRSS13bWA6xzayPM+T
         pd26OC6Yi9z8ywISBUHa6Pz6MuyuSQ3eplHlk19rvUdkAcOjPxByD66Tmkxg3Qre3UkM
         +1Ba46stUBAK9z4xRoaQ1BU3Zygbm3Zp0xQyRy0NZ2aofexgd94YilUzUHl03eYg2v6U
         3ibA==
X-Gm-Message-State: AHQUAubo5twGV/fCoFimAJfhuQ27oQZ6dkVl08fvZXgT8tBbyLauSMWU
        y7cPW/cx0YYePjeo8svGn1fJLkMHFnTZVoyEwd4jwh1u
X-Google-Smtp-Source: AHgI3IYJ58ZaKJutrpboAMncs9FibAnzNt1DwnYHvK/+RWSoQUhL8QVusxLuY+8GmQkRS8wOB84/Q/EGHtummIHLbtk=
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr24256840plo.96.1551160785578;
 Mon, 25 Feb 2019 21:59:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551123979.git.martin.agren@gmail.com> <e960fec4b492f3edf7bade35862333af5e8704d7.1551123979.git.martin.agren@gmail.com>
 <CAPig+cS7BdHhLn+XjjyVa+PC040y-E4iPD=kuDtigenzSHcFKQ@mail.gmail.com>
 <CAN0heSrogSpdSOGj0ibx0Dcjw=0o0u0VSivfjgL7r5f-Jiqs3w@mail.gmail.com> <CAPig+cRTj_jHFrqyYsn=ivuO9uNcWjB=5okX0SCGoeWU=uR8Gw@mail.gmail.com>
In-Reply-To: <CAPig+cRTj_jHFrqyYsn=ivuO9uNcWjB=5okX0SCGoeWU=uR8Gw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 26 Feb 2019 06:59:33 +0100
Message-ID: <CAN0heSoWv9xTYzFS16-fjnZuY_+6vpHSHcLmwWG8DdJEmNcTuA@mail.gmail.com>
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

On Mon, 25 Feb 2019 at 22:01, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Mon, Feb 25, 2019 at 3:29 PM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> > On Mon, 25 Feb 2019 at 21:08, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
> > >
> > > The wildcard expression also matches the manpage-base-url.xsl
> > > mentioned explicitly. Did you intentionally retain the explicit one o=
r
> > > was that an oversight?
> >
> > Hmm, I should have mentioned that, thanks for asking for clarification.
> >
> > It's intentional.

> I guess I was further confused by the fact that manpage-base-url.xsl
> is still present even after "make distclean", which is not something I
> would have expected for a generated file. (Perhaps something to
> consider "fixing" if you re-roll, or not if it's out of scope.)

Are you sure? `make distclean` in the top directory depends on the
"clean" target, which calls out to `make -C Documentation/ clean`, which
removes the file. A test-run works here:

Before:

$ ls | grep manpage-base
manpage-base-url.xsl
manpage-base-url.xsl.in
manpage-base.xsl

After:

$ ls | grep manpage-base
manpage-base-url.xsl.in
manpage-base.xsl

Were you perhaps mislead by one of the similarly-named files?

Martin
