Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 000E81F89C
	for <e@80x24.org>; Fri, 20 Jan 2017 11:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbdATLCa (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 06:02:30 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34160 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdATLC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 06:02:29 -0500
Received: by mail-io0-f174.google.com with SMTP id l66so59956494ioi.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 03:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zju4B5pmPd/D5Z7DqD2nMyS/MRIuuetfeFUNjO5ZxJs=;
        b=H/N3PE0WcatfRuZq5A5smUF8CYvl4Ltk1pxuF34swlxxmOxLm+PELMoF7BO3e5yyGY
         jihSU/a5lSseOOiLmPlIeWvsrSDz7A3+LEXw+rSUx/aau0nevaBv1K1m1iNpzbv2QtWe
         0xrClBwzaVuJarYCXsi4I7pegAYj+cG3Pd2RETiGaXJcr5vct5fEBIgHhpBLyY0wlsZ8
         0v5gwY7B4HvsObw9O7KqEQ2/whGM8g1Zg342hO48As2cmUHlMaFJ4A3WpqfQ6z8Jk2mm
         kTYyph4nqz5OC+Qx4FeZ6M1/PE6jyKcn4dsdS665LAKONiRP1SpmKZ05FC4T5lSvecJd
         5ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zju4B5pmPd/D5Z7DqD2nMyS/MRIuuetfeFUNjO5ZxJs=;
        b=BIgDYG13wnyAd3DRgLPu0ntX56ZzQ1KmK6FUw4zYs8Z5wuhjoV+Np8ZEqCHo9V9SbS
         h5w3Ufa6Jo7xn2L5jJkc/FuS89AW5MikK3ywelawhCs+8CVLGrslERBLCXgU+0mC0sT5
         Z7zK7DbVe/rf+gWZVDTLzF86TAoCt7tKKv6SO1ljYlumwKY7CWyI1FcNpUVckyYsw/Ei
         XYafxmK1C2nSI9X2EkKfaJwZiwNrf+8xaQKF7q77HXdLjEYhlI0xKcFL0z1trkgePqcI
         mNQG3ufdL9tU1PeTnQuk1p3lXgLPuk9n9YDeckS9e2HHy84cO62hZYk8LSjuQ/E61nJy
         Jgnw==
X-Gm-Message-State: AIkVDXI2ZjOKzmT/VKUWLA3OgS0s/XWlxUecehHw8GBFBIrA3Z4K1XcD4qKQPa6+U94tWfgvAXM6qO3XcuOxgw==
X-Received: by 10.107.44.83 with SMTP id s80mr12070008ios.212.1484910134475;
 Fri, 20 Jan 2017 03:02:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 20 Jan 2017 03:01:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701201138520.3469@virtualbox>
References: <20170120102249.15572-1-pclouds@gmail.com> <alpine.DEB.2.20.1701201138520.3469@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 20 Jan 2017 18:01:43 +0700
Message-ID: <CACsJy8C0SFsTNTB=R8zLLvnqkPofP0VQWPUR9pguT-n2Y+Tp1w@mail.gmail.com>
Subject: Re: [PATCH/TOY] Shortcuts to quickly refer to a commit name with keyboard
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 5:46 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Why not introduce a flag to "git log" that shows a keyboard-friendly name
> similar to what `git name-rev` would have said, except that the name would
> be generated using the name(s) specified on the command-line?
>
> Example:
>
>         git log 8923d2d0 upstream/pu
>
>         commit 8923d2d00192ceb1107078484cccf537cb51c1b5 (8923d2d0)
>         ...
>         commit 9f500d6cf5eaa49391d6deca85fc864e5bd23415 (8923d2d0^)
>         ...
>         commit f79c24a291a58845b08cfec7573e22cc153693e1 (8923d2d0~2)
>         ...
>         commit c921c5bb63baaa16dc760de9549da55c8c89dc9c (upstream/pu)
>         ...
>         commit 16793ba6b6333ba0cdee1adb53d979c3fbdb17bc (upstream/pu^)
>         ...
>
> Granted, this is still a little more cumbersome to type than @h1, but
> then, you can skip those round-robin games as well as the possibly
> backwards-incompatible extension of the rev syntax.

I mentioned name-rev a few paragraphs down. No, I want the sweet and
short @h1 (or something like that). name-rev does not qualify. I don't
feel comfortable typing 8923d2d0 without looking at the keyboard, and
that's a lot of movement on the keyboard.  upstream/pu is a bit
better, but still very long (at least for me). Yes TAB-ing does help,
but not enough. Then you'll get the dreadful "^2~1^3" dance.
-- 
Duy
