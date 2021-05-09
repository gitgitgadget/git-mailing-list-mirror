Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3941EC433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 18:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0568B60FD7
	for <git@archiver.kernel.org>; Sun,  9 May 2021 18:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhEISGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 14:06:51 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35601 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhEISGv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 14:06:51 -0400
Received: by mail-ed1-f42.google.com with SMTP id di13so16085942edb.2
        for <git@vger.kernel.org>; Sun, 09 May 2021 11:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y54CSKU7zEkmrUjcutr1z7QgrI79oeE5nHs4K2cBh5Y=;
        b=Ua8BdRuuhtNzXRqzx1E/pPs5UQgtYdR+G9PKJ/yeFljfSFF8To0OVuhhElnkCB6/LJ
         PCLScRvYYuyf/uts3Z2R+5S4PqIxt+qE/h0it+loGHkzw9ayIeKDbNXE5cyGEMJoF7Ol
         u2asnOtokG3twDguxrzuBIPUNZbTEmaI8lsObKpROpf+vsNq9I8IhK2HB2Bmz2abP35h
         T4sPrWh4TgRDsU4lmirUK3koOVAk5TbJmzfFBu4ubsGmmSXC8CsAQwBHQQSYea/mlY7A
         /7mqSPvAjAYnUHCRcGYmb4ZoPfr2bU4TwJRnF70QnX1UVpDSs5n17+Vi9/56fXp91hVT
         dfAA==
X-Gm-Message-State: AOAM533aXlXNM6fRgpBm7DCuV4vnEw+jIgYyBerHnTgpZGYTnGNgiGbo
        xXB7lvqEoVlbVYICkw0y/MPUA7ZAi1vsPjXdVmEP+LLLZEY=
X-Google-Smtp-Source: ABdhPJzy9Ve0eqpvU/6Y4pRD8PjwGP4nWmvc7D0HfOq/0/PV6VQyrbbh47j8/E2khVlQSyrSRXVZi/tkPp9BxaBlvtw=
X-Received: by 2002:a05:6402:51c9:: with SMTP id r9mr21228183edd.94.1620583547162;
 Sun, 09 May 2021 11:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnWdogqShYMmZLAYvGnKVLdxPj8fYy4a2BZ-Mhe-kSKqQhv9Q@mail.gmail.com>
 <CAOnWdog6k04pPdK1+n45x=+dXpSsqC_FUZhCBJqcAEd=n4dZpA@mail.gmail.com> <xmqqczu0ti6s.fsf@gitster.g>
In-Reply-To: <xmqqczu0ti6s.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 May 2021 14:05:36 -0400
Message-ID: <CAPig+cQxZJzgNLAbRGK_GyiudcmK_njKW=zafSKkoi6O0iYMog@mail.gmail.com>
Subject: Re: Fwd: git-cvsimport documentation improvement
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Reuben Thomas <rrt@sc3d.org>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 4:39 AM Junio C Hamano <gitster@pobox.com> wrote:
> Reuben Thomas <rrt@sc3d.org> writes:
> > The git-cvsimport docs say:
> >
> > WARNING: git cvsimport uses cvsps version 2, which is considered
> > deprecated; it does not work with cvsps version 3 and later. If you
> > are performing a one-shot import of a CVS repository consider using
> > cvs2git or cvs-fast-export.
> >
> > However, I can find no trace of cvsps version 3. The latest seems to
> > be 2.2, which is marked as a pre-release, and cvsps 2.1 seems to be
> > the most commonly packaged version.
>
> The text comes from this commit early in 2013.  Perhaps there was
> cvsps 3 back then?

There's a cvsps 3.13, but it's deprecated and was EOL'd at the end of 2013.
http://www.catb.org/~esr/cvsps/
