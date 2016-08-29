Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 063402018E
	for <e@80x24.org>; Mon, 29 Aug 2016 06:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750828AbcH2GjY (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 02:39:24 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35359 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbcH2GjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 02:39:23 -0400
Received: by mail-yw0-f177.google.com with SMTP id j12so80795921ywb.2
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 23:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I3RhtwSPzRQcpTyfP1l3NwtmUYNJ1/vQJ0WfO5Jjabs=;
        b=CxYuuLYFj4ptJ7kjiNOPqZ35UuRGsOZeQdADdC9LRqjqaIunFiXMsu/KqVvQ3Xkm3n
         jaTkWkrrbflIyb8CW5j3HnKnd5o5XcM1WuwoQZjZZ488wW4ER0yDG1MR8EOsUJeBow63
         XNArzoIBPMKv2lu5xKVJbOGBxcixcZSWmmcTPLzy1ftr7cZNKO1KiLfswGZei5AexvcH
         QglYKJkNGGvPFOXKkwkJ3B8b2THbW4epkNqWgcu5k59waCtrDT4cePfBPvjz7qRrshb7
         MMQK4otKV3ZZK5RAh4NcbrNDh5w1eRCQLlp4bKmbRSmRy9xbv0BMTTkfsWI1JwcEUAjo
         aUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I3RhtwSPzRQcpTyfP1l3NwtmUYNJ1/vQJ0WfO5Jjabs=;
        b=bz7IdHIzULsxNYOnuFGFR1aHnpuiyp8OxTcmzfPL9DO2hnsYpbRL8E+tFcwATEPaeV
         esrm8jE6uddZiGIYMVip26pvnc3y5sFSTzebT9Xx99nxACpHsDtXkpoFarHRMnDnSl3L
         gxynInJwxczT72XF1tTqOer2a8VQ4k5raSr1Tenb04KnVrda3HLzm31jEqbd8gD9x+Lm
         x5UtXnquUar2jsgqcwb/tlW04bxGLDypVVRFiF8QN/YGZgm04/WPaOMStGSE4Xkuy44Y
         FbQdSGIvgXlknW0jh65J/iPFzGp9Gtr/IvB85Iex42uKEczkvGqoW8GDiKP6G/rVtzLz
         7bHQ==
X-Gm-Message-State: AE9vXwMm+UL4u6bWH+CnGokCbSytaGzHMmZuwEB4teAley3bliL3YYkumGaY587Uu5Y5dkH8ipmxVLzwDUIckA==
X-Received: by 10.129.95.70 with SMTP id t67mr13461924ywb.284.1472452762565;
 Sun, 28 Aug 2016 23:39:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Sun, 28 Aug 2016 23:39:02 -0700 (PDT)
In-Reply-To: <4114ccbc-6b23-b7fe-ce4a-fcd0c9e4038a@gmail.com>
References: <CAKkAvazQxhtQauSb3MTVhzoK=xWbjMzQLBPQZUpp1n7VMUMJbQ@mail.gmail.com>
 <20160828105159.GA5477@ikke.info> <4114ccbc-6b23-b7fe-ce4a-fcd0c9e4038a@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 28 Aug 2016 23:39:02 -0700
Message-ID: <CA+P7+xrGh687cYHJmYyXiWfjg_8i2-31FZOvk4bEMsO1FU22WA@mail.gmail.com>
Subject: Re: Notation for current branch?
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, ryenus <ryenus@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 28, 2016 at 6:56 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 28.08.2016 o 12:51, Kevin Daudt pisze:
>> On Sun, Aug 28, 2016 at 05:58:18PM +0800, ryenus wrote:
>
>>> I wonder if there's an easy to use notation to refer to the current bra=
nch?
>>> which is expected be friendly to scripting.
>>>
>>> For HEAD, there's @, which is short and concise.
>
> What's wrong with simply using 'HEAD' for scripting?
>

When you want to display the current branch to the user, e.g. when
scripting a shell prompt or similar use

Thanks,
Jake
