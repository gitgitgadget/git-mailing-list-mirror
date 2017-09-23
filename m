Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98BA22047F
	for <e@80x24.org>; Sat, 23 Sep 2017 09:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbdIWJl7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 05:41:59 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:54146 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdIWJl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 05:41:58 -0400
Received: by mail-pg0-f41.google.com with SMTP id j70so1737690pgc.10
        for <git@vger.kernel.org>; Sat, 23 Sep 2017 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CzC0AhtzTrtJHdirJdbQcY01jW/RPeumVZRIVZ+riH8=;
        b=BMzwWBWUg4m7paBlXh/ZPNvsygQ3m25x0an6BiU7nRMcMHTCCiKAKPv5DxJbYNBjnk
         Pr1OsRQA0ouU/qiM4zaZUWIXQoZ3QEddFj/Rah9dxmFMZHsCJhGkxwWsN8Va3+YKsj1b
         Lx0kpXfWfPpPyJKPPzsfVlRA+pOcRpD8R79wpnBpYhjZg5t7AZbUVV1uUu0P8j56QTGm
         XDG6yYvJq954kmG3HiGlinOkcrnlUP/246lLcz/mJhmmHS8aX0LoHNtWEMxhjzdZSs0c
         nK309U6eKX9SNxhbLWmeM7NfeinuKW58v9T6jTVofPHkq3kuWJgEF6IFCdhTzjbVQkAU
         orTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CzC0AhtzTrtJHdirJdbQcY01jW/RPeumVZRIVZ+riH8=;
        b=OFUD0Xotl3JPLuEKSiBRObNoZJgXmZem7BGcsEdsGGag3g5bqW6O3/OlUTNlYDtBqJ
         lbN2tjyHYkv5UgXTHrwV7ZHlnFdbC+H/NoR56kLO0cc2CcXUeeZ0Fwg9b/5GHSeLs0+M
         7RCM/AC/NTkGrO0o/5TReTlFtKLMz+APm+9ooDba5PWqzM601IEhOrpBoKxfa/jXHNtn
         HsaU5Q88NN0/8k5bLibJn57vpJSBYSD3hBSxdIkjP7uUY0fRADx0Rb6bCuWvPxx3Z/tt
         LghTEtfk0CzV5l2elGMNDRxGaLwEIypgFq0kJtUFRJ4/flQ4HHlAh7mWrbHwFZM0K89l
         DwxQ==
X-Gm-Message-State: AHPjjUgGjosehnbt/1Thh+2Q8nq8tQSo8MckTWQYvgILxQihLUNFywAM
        Y/SOVbvZckrxjeG2Vb3Gjw7vksLdz+U0x5r622lJlQ==
X-Google-Smtp-Source: AOwi7QA2Pla5sJSIvIgPdJ5mCwApj6RCOjjUtkZGqWKjY/cLRCzv8Tj3gQ1PWpntFCP3GOhnszL6iW7CCFNaP6vxgOs=
X-Received: by 10.101.80.140 with SMTP id r12mr1681960pgp.267.1506159717614;
 Sat, 23 Sep 2017 02:41:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.137 with HTTP; Sat, 23 Sep 2017 02:41:57 -0700 (PDT)
In-Reply-To: <20170923040406.d6sw52ov2amjzkl4@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com> <f325af4048bc14d6194da169b02de7d18fff8471.1506120292.git.martin.agren@gmail.com>
 <20170923040406.d6sw52ov2amjzkl4@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 23 Sep 2017 11:41:57 +0200
Message-ID: <CAN0heSrZjK_fYpXDKfxuGwRYputy9f4GViy1UK+eHTj9ctVa7Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] object_array: use `object_array_clear()`, not `free()`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 September 2017 at 06:04, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 23, 2017 at 01:34:52AM +0200, Martin =C3=85gren wrote:
>
>> The way we handle `study` in builting/reflog.c still looks like it might
>> leak. That will be addressed in the next commit.
>
> This confused me for a minute, since the leak is not visible in the
> context. ;) But reading the next commit, it makes sense.

Hmm, I added this so that a careful reader would /not/ get confused and
go "wait, doesn't this look a bit fishy?". But I also didn't want to get
into too many details, so of course it ended up confusing anyway. :-)
