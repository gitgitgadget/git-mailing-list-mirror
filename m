Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB12E20323
	for <e@80x24.org>; Wed, 22 Mar 2017 15:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbdCVPTI (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 11:19:08 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34991 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760132AbdCVPS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 11:18:57 -0400
Received: by mail-wm0-f42.google.com with SMTP id u132so39849998wmg.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w/EmUeEai6BaqoWsFY/rZKTOS0GG/p55hkSH8+4TXII=;
        b=hyJA7o1r379QHGj+8yM/kZU/CJ9I1UZnEj+aRMmHiBYUNyIeizYby0+jm91csBhn60
         i7TdSb+SIKoQn4/dm4ZpISwznvCy3qBsgF08yDc9w8Hrvf9h/z2KBrt8CIwZr0qyr+vz
         BRTXJaJ9FSQ/1h1F7o69oMW8R01dLtarDcQuiLWXXugE/YVE2OIUMMUGLH9tZ1LL2Mhw
         AMUCLfsoG83G88gQVca/BCl4g0vjtlcDMudrPnRW9gpEvRhhzED2Q8bCHrlAXtaPTEDd
         U/pAnYSd/c0VQum7F2t+597PIQm9E4lrf3WJN3I+KXzaoPW5mLjybOMUZaQ2GSLWKm8w
         Ccmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w/EmUeEai6BaqoWsFY/rZKTOS0GG/p55hkSH8+4TXII=;
        b=ccHsy/iRfPTONO0Ey7lErpG3TRdS15AMm8b9wrPYD0L2QLaf7gcA9iuol6biaiaMun
         PYQUOK4x/EnICulvrLqXKWO//Vl9gWaI1iR6Kxocv92KdVz31uVLAY1diaNiy+5xiGAQ
         rzkACc27yjFjqaxD/RkYgD3vN+j4yTaVe33NyYoKm9uwdcOVhpwhBsLob5SnVKzaNlUj
         B/AG2Newnps1XMRyLxU7j3Jl9OxQSwycxfVoyrl7Es3kjSVI35Nz6zxQUmfYOanPa1Fi
         PA9fTzCESJqOXkbgObkbU2OUT4uAxwS3ccEfIOOI+UTp01GQf3q23e49n/LRGXWkRCE0
         kMxw==
X-Gm-Message-State: AFeK/H391zRpV224BW2lVK9NZgcgVdbP+twinJsxLV2ymB2wq1vRrQlp3tFoB156q906mek3+MeuXsggwLWvXA==
X-Received: by 10.28.178.84 with SMTP id b81mr9045412wmf.83.1490195934998;
 Wed, 22 Mar 2017 08:18:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.153.150 with HTTP; Wed, 22 Mar 2017 08:18:54 -0700 (PDT)
In-Reply-To: <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490194846.git.johannes.schindelin@gmx.de>
References: <cover.1490194846.git.johannes.schindelin@gmx.de> <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490194846.git.johannes.schindelin@gmx.de>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Wed, 22 Mar 2017 16:18:54 +0100
Message-ID: <CAHGBnuPL9CUincZkFR758KcZL3-Ra=n_fbsc1EQ=vio2scod5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] t7504: document regression: reword no longer calls commit-msg
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 4:01 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:

> Noticed by Sebastian Schuberth.

Thanks for working on the fix.

> +# set up fake editor to replace `pick` by `reword`
> +cat > reword-editor <<'EOF'
> +#!/bin/sh
> +mv "$1" "$1".bup &&
> +sed 's/^pick/reword/' <"$1".bup >"$1"
> +EOF

Maybe use

sed -i 's/^pick/reword/' "$1"

here to avoid renaming the input file? Not sure how portable -i for
sed is, though. Otherwise, maybe remove the file "$1".bup afterwards
to be clean?

-- 
Sebastian Schuberth
