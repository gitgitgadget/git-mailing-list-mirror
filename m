Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B0D1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeCUQYA (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:24:00 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:37612 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752651AbeCUQXN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:23:13 -0400
Received: by mail-oi0-f50.google.com with SMTP id f186-v6so4804924oig.4
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zBWgVjjL96Crdz3GhhCntzpXN4aHxAfmGcyOG4EX/9w=;
        b=jfdemqnOE9z2U5LmFonxu903KfSLbO9RpW1D3MJPr8ts5s3R3QO4njt2c6VDPy04Ii
         eS6vRogTMBEVC7PN4oPSorFXunBcXWWahgOa+K85JJoal83sJePx4A1N/e9yYFl5WuXu
         iz3ftE1MrHJP0u57BmjCEu//ZS9KpZkO6yf0z/aUX8f6D2O2ux+m1teZHw7DwDP/S+US
         TtNSzDmQLin5hwcCoLcFaqtGw26qc8HY0RTzHswtJBhu/wgRobzlSzQFVLeOPKwr06e1
         HOiWrMuQpmcxOEkf6VE6/97AZuTPOnXzI5KGuhKtHCwXxq8f4lTtqTJcweuSMJRpIS3v
         88bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zBWgVjjL96Crdz3GhhCntzpXN4aHxAfmGcyOG4EX/9w=;
        b=lGxH0IGx6lHsR8q6ItAnvsZLVil251sAsibzSUuPnmc8c3pWCboBqyWOwVA5j5jhJE
         paZq1zsUCh026LkeCF3sF7X0sXzURfRy7NB0X/GwE5OZC/QbWSBG+hSb4cEwh1YfjNRv
         aK9/zhtfKDeG4EL5JIBic9YUwFEw8chnqndT17Au0bqZ49Cag6iSj64ltj9HlBrN7fPF
         lRgK1KuN6ISIqD4ZdRIFNxW7HxdASDVY22Xl2M24wYylKS/7QwJqVIE7Qq5wMSTdB4EP
         u2Tmz0AJrLtAbclWaP4RUXA3JvTtPMAuyZjEj7Kia6qFc2DGD3uWmUqxbU/npL8CATD8
         V/0A==
X-Gm-Message-State: AElRT7F2UHUqwfTCtlWnXukAK/B3RQeEVvBKIO6uAnuzbc/fEz1Q9zph
        ZJomIeatviHY4a6FKjbGWQnru805goGb5zKH8lk=
X-Google-Smtp-Source: AG47ELtcjY0eBwqhX5NhwVs+kOHUtAztZN1XxAeugZ3jggWPnl3BcBSUdJIllV0LsvDbydzd81rieX+liABJZj6CYRI=
X-Received: by 10.202.241.65 with SMTP id p62mr3454399oih.56.1521649393256;
 Wed, 21 Mar 2018 09:23:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Wed, 21 Mar 2018 09:22:42 -0700 (PDT)
In-Reply-To: <87vadpxv27.fsf@evledraar.gmail.com>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net> <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <87vadpxv27.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 21 Mar 2018 17:22:42 +0100
Message-ID: <CACsJy8BmCHnnTQgdQjvv2msqg3XL12oeLxy3RPTTdGJrUSarjg@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 5:17 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>>> I think ultimately to work on low-memory machines we'll need a
>>> fundamentally different approach that scales with the objects since the
>>> last pack, and not with the complete history.
>>
>> Absolutely. Which is covered in a separate "gc --auto" series. Some
>> memory reduction here may be still nice to have though. Even on beefy
>> machine, memory can still be reused somewhere other than wasted in
>> unused bits.
>
> FWIW I've been running a combination of these two at work (also keeping
> the big pack), and they've had a sizable impact on packing our monorepo,
> on one of our dev boxes on a real-world checkout with a combo of the
> "base" pack and other packs + loose objects, as measured by
> /usr/bin/time
>
>  * Reduction in user time by 37%
>  * Reduction in system time by 84%
>  * Reduction in RSS by 61%
>  * Reduction in page faults by 58% & 94% (time(1) reports two different n=
umbers)
>  * Reduction in the I of I/O by 58%
>  * Reduction in the O of I/O by 94%

The keeping big pack changes very likely contributes to most of this
reduction, so just to be clear these numbers can't be be used as an
argument in favor of this pack-objects series (but otherwise, wow! I
guess I need to finish up the gc series soon, then start the external
rev-list work to reduce even more ;-)
--=20
Duy
