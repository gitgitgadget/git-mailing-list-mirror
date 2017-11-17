Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0A3202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 21:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762235AbdKQVPj (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 16:15:39 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34386 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbdKQVPh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 16:15:37 -0500
Received: by mail-pf0-f196.google.com with SMTP id x7so2808660pfa.1
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 13:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sC1C45OvPPvNHKxcUb14w1hPxjbdAFXP8+HhRLEerf4=;
        b=gy8oAk693VMQzTdVxcYZ+yMn7IHFJPBC2m6AQRpxKpt/nOz6PZSgW2lP35HNMjxkaX
         z5cpsuWNu4HmfI+OWQKeZfVQ3oK1Lk0c76dJXi5i4KFfvOeYYzx6A5Qf+kAZfAgxDWk+
         xf6wohtpRNicr1aFvYELCIFOOzxFY3gHCCGLOJz4cG0/zzVw/apCmuTkBastohO9zrXr
         SNjGq8u9rpYmii3qXUXwCtG3z2TTngs3S6tpak7ZrrrbVC1vm0hh2czerqpwjty/bEUv
         QvYVx9t8wVB8c6lK83e5KOyump/DYT2HLpICrj1kgFuM/VjMrgo/UbCRKedSzQfwJl4z
         trfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sC1C45OvPPvNHKxcUb14w1hPxjbdAFXP8+HhRLEerf4=;
        b=Rf15Rlt8twvogw6Zll/6zzjUujH768xOHXvROCxlvfja7aYFiMAJtW1G7N/OdIm/Gj
         /EshZimhL1uCttwkUrmY0ypIHxctqxD2cpol+O7GPvGz0mTMloLfogYWtGK6GJnw3MWO
         GZXWwweDPAxEloFhZ6tzgVvo/cWhRlyGjdCzlbermfz8fm5HWcedgHBWkl/YpgCLFqKw
         rlvhyn5ILJ97lGYj+R8HE1wcaC51A2bbB1TLEt7okbyYIn3SUJ3pom+8ucHLW+XcDrle
         E6l68bGvP2kDoOu4ijuQXlhEOjzb6q4mp19mqiGpVuNTxEoY9rDtjtiTpth9IzKBgO/V
         0SlA==
X-Gm-Message-State: AJaThX78NAwKKMU63mIdsj3IrSoGv2Jp3LkiJTOMI2vK2mJK/PWqk8vE
        u3DZb42MWnlU83sICFFL9j9ZwTmiHeT+XBaRcWg=
X-Google-Smtp-Source: AGs4zMaOeZnt28N17F6K8hbGWfCJ4tzNZItalMec/bXWuENeslxnYHm1k/NMrMZTkzRAycJys6LCBv2s3f2jlP49C5U=
X-Received: by 10.98.202.74 with SMTP id n71mr3366860pfg.202.1510953336808;
 Fri, 17 Nov 2017 13:15:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.167.42 with HTTP; Fri, 17 Nov 2017 13:15:36 -0800 (PST)
In-Reply-To: <20171117160759.6397-2-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
References: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr> <20171117160759.6397-2-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 17 Nov 2017 22:15:36 +0100
Message-ID: <CAN0heSoJissfQqO9sDi1sHut7a-tfFcQgkcUD=QLa+5F0F9PbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Triangular workflow
To:     Daniel Bensoussan <danielbensoussanbohm@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17 November 2017 at 17:07, Daniel Bensoussan
<danielbensoussanbohm@gmail.com> wrote:
> The documentation about triangular workflow was not clear enough.

I think you would be able to `git rebase -i` these two patches into a
single, perfect patch. ;-) Maybe in collaboration with Albertin?

> -===========================
> -`git config push.default current`
> -===========================
> +============================
> +`git clone <UPSTREAM_url>`
> +`git remote add **PUBLISH**`
> +`git push`
> +============================

This renders as a single line for me, including "**PUBLISH**". (I use
AsciiDoctor, does this look good with AsciiDoc, I wonder?)

I've never worked with triangular workflows. That means I can't judge
the correctness of this, but what I've read seems reasonable and
helpful. I dropped some comments along the way, I hope you'll find them
constructive.

Martin
