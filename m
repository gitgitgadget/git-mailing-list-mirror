Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A1D1F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 22:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdHWWte (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 18:49:34 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37450 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdHWWte (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 18:49:34 -0400
Received: by mail-wm0-f48.google.com with SMTP id b189so8748873wmd.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nUx+aSWRVG4E4sAT8ojVn4kHpd9d4GVdNrc8ZHRCIII=;
        b=USH2WWSjtsETIvCTrYJOOz8SvCI0D5MCY4IEq+zxaLEULPDlYQz9AyV+z9mlJtnbpO
         7YOmjAMzqWo5zm1NgV9Of93r3V2tCdOJZWxe3ZHmX0l2mZZcXNxfCpQZnhZj4Dgxgj57
         31v7G6ufXoMlyDgKgo1/2RH38gXgh7hNc49oDvIVwsGc0soILsV3tsyi5Cd+KL7oOH5D
         e5rHaCwG4WywmQ8Kp18BDMmm0JEtZS3Mz1mCSfr+IBHEiXihQssmBd6n+ubxOQ5cbs+v
         UHCyayfqaxxWymid3CimXIGYhkUvv5WMclG1GMZRSbar47CNDwIcrSbOoBQoJwPOrY9Y
         rt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nUx+aSWRVG4E4sAT8ojVn4kHpd9d4GVdNrc8ZHRCIII=;
        b=Y8gT0DpoUQ7UytU/EAVxO+f36t/tHbDa+PVPon9GxPR47GNN7aOKS77mIQsBqNB3t7
         Vx/bHCtFJ2J+YUerToWD1zCuG6eOMaBG7puEKN74HUQJGSVTYPKG/hCG8jD8axMZSTWa
         PSQqBW+27AxUpfGQfxcWuLXmXpa/HdpcH4JxTwpDgvSvJ6w30/wjdVthzE+BzFGIh+FC
         iSy3Ztmg/tCBMUfoEjAWzBUswgpf/WIFVukBNeNOxrV1DuO7bV3DbpCQZIFgcSX9I5Mo
         WNMf3SDaiEHhCQUCvyyQcRpWIZS0uqWPItORrYrPjtXHO94CL9hb+PjBTgT7IwVV7IZd
         wnTA==
X-Gm-Message-State: AHYfb5h06P3RWtkjiJT/qVGqzF/rXVaQQoU/eCdoYpcsmQpZ2HUGSVhi
        Hdxg1CVeXd+vG2u6Ixig0ugXKoH18Q==
X-Received: by 10.80.219.133 with SMTP id p5mr4610934edk.104.1503528572962;
 Wed, 23 Aug 2017 15:49:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.182.5 with HTTP; Wed, 23 Aug 2017 15:49:12 -0700 (PDT)
In-Reply-To: <vpqo9r6lhzq.fsf@anie.imag.fr>
References: <CA+P7+xrtZYUjPcVMkA+x8B57w+LxjjU8YSKcE77DrWne7449rg@mail.gmail.com>
 <CAGZ79kZW_+GEKyP4+8agZ7nyjGEZ9p5d3N99W6sC3GTY_4Cm-g@mail.gmail.com>
 <CA+P7+xpCJ8jwBQp9Ze=J955CaxnbVPc69ThXht2e=6TUMBq_UQ@mail.gmail.com>
 <CAGZ79kbYWJmru_o48+8iH4_MVEtODFuicRY=23+BM+_q2ZJsaw@mail.gmail.com> <vpqo9r6lhzq.fsf@anie.imag.fr>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 23 Aug 2017 15:49:12 -0700
Message-ID: <CA+P7+xp7Gr_zvsreXpLLkn7GsR2fh-0W-20ov4QonQ7c292utA@mail.gmail.com>
Subject: Re: git send-email Cc with cruft not working as expected
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Stefan Beller <sbeller@google.com>, johan@kernel.org,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 3:02 AM, Matthieu Moy <git@matthieu-moy.fr> wrote:
>> On Tue, Aug 22, 2017 at 4:30 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> Additionally I just discovered that the behavior here changes pretty
>>> drastically if you have Email::Validate installed, now it splits the
>>> address into multiple things:
>
> (I'm assuming you mean Email::Address, there's also Email::Valid but I
> don't think it would modify the behavior)
>

No I actually definitely meant Email::Valid. I already had
Mail::Address installed, and I then installed Email::Valid, and it
changed behavior to split the cruft into multiple addresses.

I don't actually know why or how it did this, but I'm certain it was
presence of Email::Valid that did it.

However, your first patch addresses the issue since you remove the
cruft well before passing it into Email::Valid anyways.

> Hmm, I think we reached the point where we should just stop using
> Email::Address.

I do agree, I don't think we should use Mail::Address.

>
> Patch series follows and should address both points.
>
> --
> Matthieu Moy
> http://matthieu-moy.fr
