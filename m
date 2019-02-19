Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D02E1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 11:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfBSLAH (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 06:00:07 -0500
Received: from mail-vs1-f52.google.com ([209.85.217.52]:36785 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSLAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 06:00:07 -0500
Received: by mail-vs1-f52.google.com with SMTP id t13so11433119vsk.3
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 03:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bbr2ZS4dXvu6vcGNXw93TLHmuHatijHg4pSvc+W7E/E=;
        b=Sf4pJ2eYboa+KBi46mlGTNYgJoIeyvt5i14PNOMTPZSAp8+FzDnM8k08z1zsjybM1Y
         gfyfLH6k1200/QCK6FYZUdFjHSf1yTbXFRXzYlJHskoFB+QSC+TqmP7ID5Fjvt9102JU
         vIww6Ajj8KAcvBBcbcUOpuA42Ez0kcP8mNWtGu5QpDmSYz26e9Hhfaxv/UJ0NA3rm0s0
         lyIuMQAjdFJkfQ5Qa1ee53PfvEgPoJRjspCwH2pb9pQoHcvW+9oBlqx5MKoQaaHrScwR
         urKDFAUI0OyplnqMAo4d7gqa1uAtkbkLezrjzDialXq9McxaCsvdUFtOv7v4GOtwq2O7
         6tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bbr2ZS4dXvu6vcGNXw93TLHmuHatijHg4pSvc+W7E/E=;
        b=G7nitNrSD3bd6MaFCwsSMx7N9mirN3/McXsQ1QzdxYSgHJRDTkeoBJmtKll0b4RzA+
         +TpeafvRzRsosLNmgv8RmQv5W/eDaZ8EBP3vrZyPIg15saBBTO2LVjWc5T31vgTRCat7
         zk4F107sPEaBcxrHVq5H+QX5Ur/qIjzZgQLTz6vRtes9xW1IftFmcwSSsJHLw7a+H6ga
         O30Nty6TvJtudZHr1rBTsunqMhIxr+XuQy0OgLUaXE7TG8tPW2WCWAcZAC7SCLHG/Fyf
         nS+TJT4ym8+TCprJ5n8fKOHVS3aJZZWIbmUsRxiO7zjX/8CzjcduvPcG9Bw0n+axU85p
         77vA==
X-Gm-Message-State: AHQUAubSaNiRsROz/1yMNnWOYfTEhCGcx9AsC9Od3fa4SGUyqaPMgl1H
        yGV2oJYYJ2DMbpZtvij2JUWP+NFIKY9vb5h6fSk=
X-Google-Smtp-Source: AHgI3IboTJ7g/sKa8Kz8NcsPSnHUrf9k+X09qFu/7KxN096FQh9uzuaW/Ic+NOFUG6Tfpcg/iXk6aF4qyibUwrwuoqA=
X-Received: by 2002:a67:6815:: with SMTP id d21mr13811891vsc.142.1550574006198;
 Tue, 19 Feb 2019 03:00:06 -0800 (PST)
MIME-Version: 1.0
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
 <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com> <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
 <20190219100136.GO1622@szeder.dev>
In-Reply-To: <20190219100136.GO1622@szeder.dev>
From:   Senol Yazici <sypsilon@googlemail.com>
Date:   Tue, 19 Feb 2019 12:00:31 +0100
Message-ID: <CAFacdQ-Pcvz3vfP31uwuK7pap7t5oyDVTHGnwvGasWMf9zrgYA@mail.gmail.com>
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        msuchanek@suse.de, Johannes.Schindelin@gmx.de, jpyeron@pdinc.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gabor,

thanks for the constructive feedback.

Hi Michal,

- I might be an enthusiast but i am definitively not offended. :D

- I am wondering for whom dictator has a positive weight... no matter
who calls them dictator! ;)

- Which negative connotation do you have with "principal" or
"integrator" or "approved"? :)

- Does a documentation sounds sexier if its "rebellion" than "_not_
vague politically correct"?

- I did not "understand" "dictator" "lieutenant" nor "blessed".

- I think that words form the world we live in, deliberate choice of
"bad" connotation and exclusive expressions form an adequate world.

Thanks for the insight. :)

Cheers,
Senol

On Tue, 19 Feb 2019 at 11:01, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrot=
e:
>
> On Tue, Feb 19, 2019 at 09:02:43AM +0100, Senol Yazici wrote:
> > 1. Dictator
> > Concern: "Bad" connotation.
>
> "Benevolent dictator" is a well-established term in open source
> projects, and it has an inherently good connotation.
>
> > Further, "googling" dictator does not give Linus as a result in (at
> > least my) search (bubble).
>
> https://en.wikipedia.org/wiki/Benevolent_dictator_for_life
>
> > Suggestion for substitution: Principal or principal integrator.
>
> These are poor substitutions.
>
