Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35281F404
	for <e@80x24.org>; Mon,  5 Feb 2018 18:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753739AbeBES4f (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 13:56:35 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:41980 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753573AbeBES4T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 13:56:19 -0500
Received: by mail-yw0-f174.google.com with SMTP id b129so19119043ywa.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 10:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lQAAobmJG2aZggH8JLpCidtLe5XhbT/vLEHWPBtLCCM=;
        b=bT6iVijvyu4Aio6V+FzpnyYnVr42sINoNYGzAUxKfJrSmFrpvQGfWCmIPH81jZoTut
         5D5SzO/mxbMh/e36NtRLjTPWCYYRhFq9xC2ChKbU+SEin6ELXrEjgLQByVKRHgEBSNS7
         vXko4LGy/c0CJS/jzeP0xSnVQTQ1ZlcU7YuoZRLgk4J59UF6ac8j2FB8ixj3ncGErWXv
         aXfgJhEmiQ9vua8D5vr1BRBRnhuSiOIDwjdAJJnhgLgcSl3yceezaPzAegAuIR2BEWE2
         NkPge3phgcU07/mpyFRHweZ01hHKavrmSDoJVl6J0EAENS6NsYmQDKXLvuB6CsPiICVc
         iqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lQAAobmJG2aZggH8JLpCidtLe5XhbT/vLEHWPBtLCCM=;
        b=FI+BBoR7Vv5PYIPj87QDRAng2E/oglRU6WFgQ0chfhCJ/7E2BJQ8BONZOplGaehhnC
         u7OmKCtgsVf0/MgpJgLiRlflt3EmVyuR27B2xmEDeif+M0vfNeKOn5fn9DvS9LgY4AXG
         2zxMTg5S8mXkJbk1uuBEdhZu0iSj9yYhcufTWNyYvfsMm9QXhLOnG63/vcilgEYJu8Ay
         k3fFvp+f31kLRFYJJ5ty4GLPOG9xGQg08z4QMCrPursszx9pTpClbDgOYdHldshNfFZC
         8XwctKOl0ued7wl6HAD+vYbnZRZ+XM+zH1tptl5TETxIM+nN7IPv7tB6gZJrlukULJ20
         6vxw==
X-Gm-Message-State: AKwxyteQ+FVcApl2aGyqT7cPKvBuORwUq4nxF/ftisFdSHQOAfMa8zCz
        n/iv/05/2VBP8e2uuC1ZNCIZLX5U3uOJWJ8LvT2z+NrNpSY=
X-Google-Smtp-Source: AH8x2273fht3JqmJbVx5UNnM/NrQpyvELBCAUYIeYhSY0zzJejHVmQtOceSZf6cMaXdtAVL+Q02ZwjzfslNiHn/PXr4=
X-Received: by 10.37.219.83 with SMTP id g80mr32624431ybf.201.1517856978393;
 Mon, 05 Feb 2018 10:56:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 10:56:17 -0800 (PST)
In-Reply-To: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
References: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 10:56:17 -0800
Message-ID: <CAGZ79kaSY=j23Nn+UH5DGJCptTow7ZpEko2DFzuuAgN2e1BxSQ@mail.gmail.com>
Subject: Re: Missing git options
To:     =?UTF-8?Q?Martin_H=C3=A4cker?= <mhaecker@schwarz-online.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 1:12 AM, Martin H=C3=A4cker
<mhaecker@schwarz-online.org> wrote:
> Hi there,
>
> I just recently learned that not all command line switches seem to automa=
tically correlate to options in the git configuration.
>
> This seems something that should be relatively easy to fix.
>
> What I=E2=80=99m most missing is
>
> =E2=80=94 snip =E2=80=94
> [log]
>         graph =3D true
>         patch =3D true
> =E2=80=94 snap =E2=80=94
>
> which would / should correspond to `git log =E2=80=94graph =E2=80=94patch=
`.
>
> What do you guys think?

Feel free to send patches adding these options.

I had the impression that git-log was a pseudo-plumbing,
despite it being explicitly marked porcelain
as there is no good plumbing alternative.
But as we already have things like log.date, log.decorate,
that change the output of git-log, I think a patch or graph
option would be ok.

Thanks,
Stefan
