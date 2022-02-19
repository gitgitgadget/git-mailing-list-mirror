Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AA3C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 06:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbiBSGpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 01:45:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiBSGpf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 01:45:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399161EB422
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:45:16 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p9so19936202ejd.6
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DUFLRLIrVzBJmPqStc6qOBy8ZbDT4NxQ2uT7Uu9/tE=;
        b=cX5dLxW/gWWnkUtaWh8rVDPRlV4iATHoc6VnwIVeuTgBcuZCfpE5JILWAjGiHNSt32
         3PbDJ/1f9MsQw/RVHXRgdz1L4Hn5cR+MGrEmZ61IptB44UbPMtp6hsc2GvcGYnBiFD8e
         xBM6e4wHLsViTsV3j0wy1kQqvp9Tb0b4jgFboxe3tvtRojQ4z4upnD64fzwkTJAtU+Ev
         NqcKdDjeeXBc8yPXO47MGDCTPrGSJCcDAsiff3dlHW1MU9VS3d5xjSEHcKB7bXbi6CWg
         NxnJVAr2xcPnOSRDC3mCPZJ2a4G0zvZ137bPPBGZOC6tRqYfDPRkQSLSRSGxzj3D+QiV
         7dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DUFLRLIrVzBJmPqStc6qOBy8ZbDT4NxQ2uT7Uu9/tE=;
        b=SZsFNO3QuscCHYTX9IWKpK9vsfPqTpVYizq2TwTRG3RjN7ljp/moKbXEK7aKnSvn73
         n2GpVKC0tW9agjeAcKEq6tqc7gYaJgM3EF7RT8XS8V6Ngvrs+WZaHenlLGE0okvV9ISU
         A0DVDh2E50tbxvI4alYtPhAaniGwnDpdtZrs/OOmYBz/M7JCjIvi09V7dEEJhDnl8o5p
         B4N3XKwX/u80473Lb/YwBmS5x3yNawB1bHmyj56gdmeqdAAbKxn9AtsNW9d8bbW0NUe8
         tIkJ4tG1Qw2dHvo7I9/Oix3Td3WKsF17P0XCo6bIY/Ti6PKb1Z1YdLFZCMtAnA1VSLQd
         +Sjw==
X-Gm-Message-State: AOAM530qvWVqIu3b/ubl+povNZszZ5yKeUf2SvybVnb0yiKOkRA3EYl4
        stiUWGbhxABUha2ryT2G3qIEPBUZb/HmdjkrAyY=
X-Google-Smtp-Source: ABdhPJyuDb/ADhxKEWLGrvoFViOThmyImsj5ognGO3VaJFMBsT2+H8gOkKLiq16kSm5eN9rckGOVti45dLa2yM6xVJU=
X-Received: by 2002:a17:906:27db:b0:6cb:1f45:40fd with SMTP id
 k27-20020a17090627db00b006cb1f4540fdmr8944838ejc.605.1645253114551; Fri, 18
 Feb 2022 22:45:14 -0800 (PST)
MIME-Version: 1.0
References: <f5daef58bc0bededd46bc9686c586ba5ae9a453c.1645211253.git.me@ttaylorr.com>
In-Reply-To: <f5daef58bc0bededd46bc9686c586ba5ae9a453c.1645211253.git.me@ttaylorr.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 19 Feb 2022 07:45:02 +0100
Message-ID: <CAP8UFD39CZ4mVGWYyfw9p8Vy=-Ee1kSp_JsTTR8ki8BPjgA5WQ@mail.gmail.com>
Subject: Re: [PATCH] CODE_OF_CONDUCT.md: update PLC members list
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 18, 2022 at 8:07 PM Taylor Blau <me@ttaylorr.com> wrote:

> As of [1], Peff is no longer a member of Git's Project Leadership
> Committee. Let's update the list of active members accordingly [2].
>
> This also gives us a convenient opportunity to thank Peff for his many
> years of service on the PLC, during which he helped the Git community in
> more ways than we can easily list here.

Great! Thanks to Peff and you!
