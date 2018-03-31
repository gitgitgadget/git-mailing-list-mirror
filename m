Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914511F404
	for <e@80x24.org>; Sat, 31 Mar 2018 04:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeCaEWJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 00:22:09 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:36902 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeCaEWI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 00:22:08 -0400
Received: by mail-ot0-f171.google.com with SMTP id y46-v6so11140207otd.4
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 21:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IcKdNq2kdgRNS8lLH1+4xYD1wKAB8il1gg+nTvvf1mA=;
        b=NRLGt9DNKU1QsVtBwpgTGr2zJEifMlkT/h/mMXFPJpqBbksI4fBgd28jy/QABGkdX+
         sKTHkpBZhCiOdjmD4hiUX9q1RD2toB4bg0jExhBvwp8oDv7Xs6+hyT/B63K8XvxQX4XW
         SxrGo0VTT7PKJFTTMrV0TBKkfJKsQ5eaWDNBejupWTg6/Y4QFZGAltLjoLKJwHjo8C1w
         DHeGgu/WeIClhWokVQQo5Q/xXVGSxEP+fRenKzgx0DtaPONRezCrZgLsJd4DZP95aU3C
         ivynK84Hmz0L/5TlVQTVa5tLwDxd+Wgbu/6q+p0WLmBh0hM18qel7ohEma7nGElxXPxZ
         2LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IcKdNq2kdgRNS8lLH1+4xYD1wKAB8il1gg+nTvvf1mA=;
        b=Ko9YtJKnes5x6QS4sP/Ugq/Ed9ThI+FmuU9cKc19z4Au/pREJQtksj75abrg3h3mue
         hj880aJa1QWurJ2Pa4kuRBlpOULrpLPfxJmfJAMu0wvV6vevUkobHFPs5m9QBmXN7yCe
         5DhXwqwZV/NEyJWHNi9quHXWcsxBjY/o9orr4rjDXo+rTIP2ULtnpm6PV7MTwscN+L9L
         QW+2PQ/lSL10Tjvt+a57+uNwFr94dF+qCqj+sm6zsz8GcHFjxzQzrBkJi61Vjoy0a+8v
         O5T8xkld7rb4LQWmnAA4RmZrkmgMU8U7dggOm8BGTgmPakzEthdi8qR+FQxnMZY+pcMY
         mdng==
X-Gm-Message-State: ALQs6tAnfRozL+2xekFeR2DaMPNuMqHmG0yl6bKRgDzLYrxuU+IC2esg
        7mPgnNwXvQ/UAtxIhQc0O9/fBpXNSQYfzneMTrM=
X-Google-Smtp-Source: AIpwx4+NNam5yTMKPOLg9W7RB9uy9dxVws09h2GJV+vmwb8ikakg2V08qaRE1BOImgl0Rk2oVp60ubPkk7EGFkxy0g0=
X-Received: by 2002:a9d:24c7:: with SMTP id z65-v6mr940275ota.152.1522470128208;
 Fri, 30 Mar 2018 21:22:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 30 Mar 2018 21:21:37 -0700 (PDT)
In-Reply-To: <20180330212419.GJ14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com> <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-13-pclouds@gmail.com> <20180330212419.GJ14782@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 31 Mar 2018 06:21:37 +0200
Message-ID: <CACsJy8Bt6eY5vu4SRvnrY3Wq3zC3j9yALXJy2Y1eL=LVrMickw@mail.gmail.com>
Subject: Re: [PATCH v7 12/13] pack-objects: shrink delta_size field in struct object_entry
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 11:24 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 24, 2018 at 07:33:52AM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>> @@ -2004,10 +2006,12 @@ static int try_delta(struct unpacked *trg, struc=
t unpacked *src,
>>       delta_buf =3D create_delta(src->index, trg->data, trg_size, &delta=
_size, max_size);
>>       if (!delta_buf)
>>               return 0;
>> +     if (delta_size >=3D (1 << OE_DELTA_SIZE_BITS))
>> +             return 0;
>
> This is the other spot that needs to be "1U".
>
> How come this doesn't get a pdata->oe_delta_size_limit like we have
> pdata->oe_size_limit? Would we want a matching
> $GIT_TEST_OE_DELTA_SIZE_BITS to test it, too?

Probably. This change does not look as risky as the others (no
complicated fallback). But without $GIT_TEST_OE_DELTA_SIZE_BITS it's
hard to know how the new code reacts when we get over the limit. I
will add it.
--=20
Duy
