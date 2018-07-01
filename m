Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68C71F516
	for <e@80x24.org>; Sun,  1 Jul 2018 05:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeGAF2n (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 01:28:43 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34161 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeGAF2l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 01:28:41 -0400
Received: by mail-ua0-f193.google.com with SMTP id r10-v6so8202298uao.1
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 22:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kb8dD+ysvVaur3w1ZGBggWT2/6YxtwNGhTeKWKpYsn8=;
        b=IGnuTqjzZQ8W9ooECIRNnygyVwo4jFD/AJqCqnbdxsIy+lYtIJ05vbX7XUIauAxdxY
         lP0DDwxXkPRSD1yRwYyOF4BlSs1nPPG9NOVm/9Qcr+PGY2eTaWyeZT9jrEkrZ0GEN0z6
         IUo54ryZb3GWHYj7gmrR5cSSILwTDRyiNROIrA96Fq38RNj3dpdQubWOIkVWyE8fLWSx
         HDmIt/PwP/mBgWUOqefEZ1jYo7PNYGmkrNBwul0ZfYwfil+VQokmWkm8HiaGMz9QS+hS
         +dLg8KUY7emSH5RCCdbD9uIl4p0PKd2F7usnw8kcEbvhAMYktQ49txlffO8BJU2DSNTo
         fd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kb8dD+ysvVaur3w1ZGBggWT2/6YxtwNGhTeKWKpYsn8=;
        b=o7lYnkokz232/L317vMAG87oAieyLdbf7X+LevN47WNOGZTYZnUHzZ9dVOfvBneTfZ
         GXCV/pZmc1oquls3NBTtJYVSCG4d3LRi8J8MDLuiJS5m+uFiByEVSQ0+M8+mmdDvqrGH
         A3Om7B5+R0tEyd2zkr3t7Issz879aBBcBO62pnIZYyMUMe40uxw/p6YQMhKDaUmAlYi9
         x/GNAnPFYTvf2U1lMWvAwdVyUw5WP/AAWHXM28sKcjNt4NnxtjQRCMcqGYoIezTDuZsw
         jWpHvM+6S+0BNmhYi0KqZjZi/8zKPSKrDfabeGc7Ky9Ntw7Adq0F2OnG1Yj0mXvyMgfv
         Meyw==
X-Gm-Message-State: APt69E21QJuKaF3lm62d999RkhXHyodFgRm0xF4NJ9384ykQXLNvyiXy
        XxX1OO+o9uCa5w+o/jfr0djAVQ9dlnOJl/cYBTg=
X-Google-Smtp-Source: AAOMgpdx3joc0d/IOSPeQ8PCc2LaECw4Wb2I13bvhAI0BSNK7RjRywlhdZIOQ8YB1RBLw65Xzpz77CYPRCqoQQZA22k=
X-Received: by 2002:ab0:596f:: with SMTP id o44-v6mr12868172uad.29.1530422920499;
 Sat, 30 Jun 2018 22:28:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 22:28:40
 -0700 (PDT)
In-Reply-To: <20180630090818.28937-7-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com> <20180630090818.28937-7-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 Jun 2018 22:28:40 -0700
Message-ID: <CABPp-BFZhCY4HWmo0pSZWtqGSyn1siMyq2a4Wbew3E=PbSe9jA@mail.gmail.com>
Subject: Re: [PATCH 06/23] builtin/pack-objects.c: mark more strings for translation
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 30, 2018 at 2:08 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Most of these are straight forward. GETTEXT_POISON does catch the last
> string in cmd_pack_objects(), but since this is --progress output, it's
> not supposed to be machine-readable.
>

> @@ -2341,8 +2342,8 @@ static void ll_find_deltas(struct object_entry **li=
st, unsigned list_size,
>                 return;
>         }
>         if (progress > pack_to_stdout)
> -               fprintf_ln(stderr, "Delta compression using up to %d thre=
ads.",
> -                               delta_search_threads);
> +               fprintf_ln(stderr, _("Delta compression using up to %d th=
reads"),
> +                          delta_search_threads);

Full stop removal that probably belongs in patch 1 instead.

>         if (!pack_to_stdout && !pack_size_limit)
>                 pack_size_limit =3D pack_size_limit_cfg;
>         if (pack_to_stdout && pack_size_limit)
> -               die("--max-pack-size cannot be used to build a pack for t=
ransfer.");
> +               die(_("--max-pack-size cannot be used to build a pack for=
 transfer"));

same.

>         if (keep_unreachable && unpack_unreachable)
> -               die("--keep-unreachable and --unpack-unreachable are inco=
mpatible.");
> +               die(_("--keep-unreachable and --unpack-unreachable are in=
compatible"));

same.

>         if (filter_options.choice) {
>                 if (!pack_to_stdout)
> -                       die("cannot use --filter without --stdout.");
> +                       die(_("cannot use --filter without --stdout"));

same.
