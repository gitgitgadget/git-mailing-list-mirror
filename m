Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2051F609
	for <e@80x24.org>; Wed, 28 Nov 2018 12:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeK1XE2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 18:04:28 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:38621 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeK1XE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 18:04:27 -0500
Received: by mail-pl1-f179.google.com with SMTP id e5so17282142plb.5
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zBBMzAQVChrBqbt0/PUIpUJUY8c69Q56wCYE9jk8glc=;
        b=HUwNxZoVkG0+jQw6JRVqaHH0w6pTYki+2au3VX/a162qBLT1BLuBVMI+693jfxSMxK
         GhK3N8hgj688hmD3oiB3kXk2GM/toGhYzzF8eFvs+yU73yCme1K1Pz58ZfTr/dKtZd58
         JWx3e3UNIcgM0Q2y+ZjXr3RaSuPzLLcFJnvNCeBZtF2HRTearDk6cSQAIenxFZvy3EaV
         bP6t9m/SgiRYxV2sA1wOoM/+kutJ177rBZcd78SIr+gib+0kcQu14GkqpsRBbeR9ze5p
         u1oYU+cA7vjkRZfCKGMXFJxQU//JfMsuUYeKhhzHz4vCxBniz3/KkoQB53l7y+rdS0Uh
         3smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zBBMzAQVChrBqbt0/PUIpUJUY8c69Q56wCYE9jk8glc=;
        b=ojPjC6dCA4r29tmYOKaMrh26G9eZB6wTJhd/z28RX0MIx2txZgssM/SDAm0Nb0Uqni
         SEWnEjeLKQ8vExZahO3zbfiLp8pb4QD7S900DHPaXKzN2J9uIBQl3nGWGFMiR/WXYEsX
         IRh+f5BaUD4EuWz9wKcoq8pWzXZ9LgFSkzP9DShyGlLd8jdEbFOPtOYhBZ2/PW6EtFAX
         P08TFXwPQMFPKCkzcGgcXdY5TratG2X8JnjT6CIjTEJ1qd5+bc5ClUjHuY07kzOG2Mmk
         YRimS3NqDhfRBNxw10ZYY53C+uoI2bVr0/C3k/vG7crxDSFnPPjakiCb2l0ljtNDIsvp
         6lFg==
X-Gm-Message-State: AA+aEWaKWzuRfgGn67hgOMRPJel1QqAoC/fus6RZKuZMOrOxP+RFC3bQ
        Qi1McFGbeYUwNvmXJWomEVTuvdcN7LuPzv63Orvd+Pzv
X-Google-Smtp-Source: AFSGD/XMKAT7Y2zIkUZmPhbFVPMSUVrs0OGruKMOXffBk5Hz1pJXW6/8Gxt1zi9FK19pndb0gi6FBW7LzlVHjwXWOm0=
X-Received: by 2002:a17:902:7201:: with SMTP id ba1mr17543665plb.105.1543406582031;
 Wed, 28 Nov 2018 04:03:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJjcwZ-bjCVbsXhyRtQHsH9U+yytbRvq07j4hTOnuD-g0XXL0w@mail.gmail.com>
In-Reply-To: <CAJjcwZ-bjCVbsXhyRtQHsH9U+yytbRvq07j4hTOnuD-g0XXL0w@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 28 Nov 2018 13:02:47 +0100
Message-ID: <CAN0heSph-a08AzsihqqxfC=nqmUQLsqx-rKGULXQ-gmT4+c10w@mail.gmail.com>
Subject: Re: Broken alignment in git-reset docs
To:     samoraj.pawel@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Nov 2018 at 12:42, Pawe=C5=82 Samoraj <samoraj.pawel@gmail.com> =
wrote:
>
> Hi!
> The git-reset documentation page section which is accessible via URL
> https://git-scm.com/docs/git-reset#_discussion is not looking good.
>
[snip]
>
> The web archive has got a snapshot from 2014-06-28 when it was ok
> (https://web.archive.org/web/20140628170155/http://git-scm.com/docs/git-r=
eset).

Hi Pawe=C5=82

Thanks for the report. The sources have not changed since 2010, so this
is most likely because something in the build has changed. It's probably
that git-scm.com has switched to using Asciidoctor (as opposed to
Asciidoc). The correct fix could be something like 379805051d
("Documentation: render revisions correctly under Asciidoctor",
2018-05-06).

Do you feel like attempting a patch against git.git? The hard part of
that is probably to get all the build dependencies in place, in
particular to be able to test with both Asciidoc and Asciidoctor. See
USE_ASCIIDOCTOR in Documentation/Makefile. If you're not up for it, no
problem, I should be able to get to this later today.

Thanks again for the report.
Martin
