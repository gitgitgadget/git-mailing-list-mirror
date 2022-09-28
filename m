Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE35FC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 07:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiI1HeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiI1HeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 03:34:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375ACF276A
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 00:33:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 8-20020a17090a0b8800b00205d8564b11so947596pjr.5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MmpmmRDMD/2kHytPcHHvW+yjgmDMHiObyjZ7q01Vv88=;
        b=WE1BxyxiI6VvgYbGd85o2ROdrT2vfvooW2IvOmVbwzSTbfDiPgKEsOzjzvX0wuyevP
         q/lg2B8KkXL1y86+09irP10Ulkle7TaYhiAvm3LA6UVU4BV/Sj8fS/q43LATRg28s5A9
         s/4bNOKUb6am00Mp8u/FzosbGapsWt//9d2rJ07Tes5GwRjgvRAc830Qb5GItHn/NVu1
         GR5PFtir16GRuKu2bo6DiBWhCTpcZqB4rX3GpD6ICjegyBaTXHgqGs0Wtt95exdrCJVK
         hL6ySbU6/RUyb3yjgvTtH2cd6avvv5N3sGmeEtert921w7U6RQz7FVPWxRpNdebyHGjh
         cVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MmpmmRDMD/2kHytPcHHvW+yjgmDMHiObyjZ7q01Vv88=;
        b=SJKtBAQk43WgcPQwLmb9H7pCnLF6PZzQacSn+gI61LxPv7GwZZlMT8Z5drS8VNurFi
         TULmTeA/tHgMkQeu7TynC2GEGHhzU21vpAj5poEibrjTLCCJI3gJ5Mtg3YHycu+GevCo
         QJX8z1qsKZaYm6oW8Atls0qI2S3wMLwZhBfbea8c6oQvqeOkA9HNjahFFIy2I8Ee0JT1
         Wa4HdtXC7jUufy5yOUGoZydo4mq9kWbY8vwhuecqadfEsGlziKAV6R8K5Ww9OBKSxib4
         VuhqYBdTkZR6/3wNuOr6a8C/VHCgPqcT3eknax1dhd/0kus3nR5wtZLt93q8qZrUXLdy
         EKEQ==
X-Gm-Message-State: ACrzQf1iVLTMW9P/5wGK5pKrSNaW869sd1Bw/ar+jIi0adxYyBnUHc79
        nzg37/QFTVBw7XHgJ2di0Grz4rarYH+O08DqqxA=
X-Google-Smtp-Source: AMsMyM6rtJMcS0UEHa+aG9YZd2oW9TMn1GJViTpHoVtW5BixnVuqIuyW8X4oHE/eA5gdGJmtzxK+u5kaqWOpz+qx44k=
X-Received: by 2002:a17:902:b907:b0:178:9d11:c978 with SMTP id
 bf7-20020a170902b90700b001789d11c978mr31072076plb.90.1664350353386; Wed, 28
 Sep 2022 00:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1345.git.git.1664294909011.gitgitgadget@gmail.com> <xmqq8rm41gbp.fsf@gitster.g>
In-Reply-To: <xmqq8rm41gbp.fsf@gitster.g>
From:   Skrab Sah <skrab.sah@gmail.com>
Date:   Wed, 28 Sep 2022 13:02:22 +0530
Message-ID: <CA+J78MXbXG4M1w50EAM8t0VkYP_saCt9O90jFKad3+cB+RCZ-Q@mail.gmail.com>
Subject: Re: [PATCH] abspath.h is created.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     skrab-sah via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What is wrong here and what should i do to make it correct.

On Wed, 28 Sept 2022 at 06:11, Junio C Hamano <gitster@pobox.com> wrote:
>
> "skrab-sah via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/abspath.h b/abspath.h
> > new file mode 100644
> > index 00000000000..edebc3a53ba
> > --- /dev/null
> > +++ b/abspath.h
> > @@ -0,0 +1,9 @@
> > +/*  This file was automatically generated.  Do not edit! */
>
> No thanks.
>
> I suspect this change is taking us in a wrong direction.  People
> grep for function and struct declarations in <*.h> files and expect
> to find the associated comments.
