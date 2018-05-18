Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FA71F51C
	for <e@80x24.org>; Fri, 18 May 2018 01:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeERB72 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 21:59:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39139 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbeERB70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 21:59:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id f8-v6so12277953wmc.4
        for <git@vger.kernel.org>; Thu, 17 May 2018 18:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vMVE4Cz10mzwNSvV2HJnfFEJkxWOcXN9q5LFy8mqmMU=;
        b=ovJ4LkvbcexiZsf2UELrOet2/Nc+TwbIu3aP0QkDmzivPzUqPfYUJLtpLYUofTo9TT
         6Lxx/CCH+K1xb6waU0ReLZh02wqkqJ7ZafEsMNSQj42D2coKzkb6lBGR0iyWB9LB55lp
         61FDuFj6FUgI5DkHk76rxy1Oz8lWYzwA4YLWtYBjAV24fzhnTNFfJ4+cP5hD8RM9sWej
         T72bjX8z1DL93baG8bJR0IsD+OUNXWFcLNCMOQYIk3qVs8qhgWiOeTUJ3fb2EoUpdy2s
         4Tnx2V5aUUM5yBJ+xZc3vb+af8/GaJPkysczhLSBmKxAeGS/Xw9YMEksLR/U51fj/Ysl
         X8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vMVE4Cz10mzwNSvV2HJnfFEJkxWOcXN9q5LFy8mqmMU=;
        b=Y5QEnXmvzYZDLIB4cdz5ztxUhBctyzEHadXTbmMs3UthnOv0Me89DywiK/H+IKMviM
         v6gF7RjfwyRgxaYVERchJbJNOFBGDF7HYwbJS857qeWgV1OYof23XLSABIUWXs4VUpS4
         9F/0Qx1yJ6hXfe8DqcHnIbifYcQiSyjXWbgXY073dav68Y/rHhTAki7RyUMZuZgf2g3x
         ihT8Dziabx2jOwMF8er5+YPnLgZ3jAtZZtF+K5z47+i2uQW5NcaGYKEwsHvBQsmNayEt
         VUTO5WtkZwheq/wt72aoGcAAFB0xrUzrIsxlGKwQhUoitLWOVm2AMc5+OSR3NlcuMyx7
         WxIA==
X-Gm-Message-State: ALKqPwcoPFXfWYdZnd0qEdZZRFcIYFRe8DeLcj0saMWT85Aq2amVFhLm
        rwBr/ck4tsunRNOgKMJ+YgZauOf+VUSAW3e91I8=
X-Google-Smtp-Source: AB8JxZpICnrTw7WuvkLQhel9UwTbDuHEPqIfs/rZ4plz3TBchLrJcDmCDoR+eEBz7lI3cjf/VFmSjY+mEwaAQfBLpYs=
X-Received: by 2002:a50:ab42:: with SMTP id t2-v6mr9539769edc.133.1526608764769;
 Thu, 17 May 2018 18:59:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Thu, 17 May 2018 18:59:04 -0700 (PDT)
In-Reply-To: <xmqqmuwy54yj.fsf@gitster-ct.c.googlers.com>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
 <cover.1526488122.git.martin.agren@gmail.com> <0b7440f21e9ff7a066802fe1e7cb3078cf4ed2b8.1526488122.git.martin.agren@gmail.com>
 <xmqqmuwy54yj.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 17 May 2018 18:59:04 -0700
Message-ID: <CA+P7+xrXRGZe9AOR0+mZZTL9_nsHDMBv=1F6ea-p8aec3dhNuA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] merge: setup `opts` later in `checkout_fast_forward()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 17, 2018 at 2:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> After we initialize the various fields in `opts` but before we actually
>> use them, we might return early. Move the initialization further down,
>> to immediately before we use `opts`.
>>
>> This limits the scope of `opts` and will help a later commit fix a
>> memory leak without having to worry about those early returns.
>>
>> This patch is best viewed using something like this (note the tab!):
>> --color-moved --anchored=3D"    trees[nr_trees] =3D parse_tree_indirect"
>
> This side remark is interesting because it totally depends on how
> you look at it.  I think "initialize opts late" and "attempt to
> parse the trees first and fail early" are the sides of the same
> coin, and the diff shown without the anchor matches the latter,
> which is also perfectly acceptable interpretation of what this patch
> does.
>

Yes. I like that we have tools available to show diffs in different
hopefully meaningful ways.

I happen to like when the diff matches my mental map of the change
after reading the commit message, so having the author indicate how
best to view it is useful, but definitely cool to see that we can get
different interpretations.

Thanks,
Jake
