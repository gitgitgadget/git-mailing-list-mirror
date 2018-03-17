Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DCE91FAE2
	for <e@80x24.org>; Sat, 17 Mar 2018 12:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeCQMH4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 08:07:56 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:32845 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbeCQMH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 08:07:56 -0400
Received: by mail-ot0-f194.google.com with SMTP id y11-v6so13008562otg.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 05:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bi4Q+Ey0+7XDwl2Ubuxcr0GeIWRaHfsAqZ9axiSMGa8=;
        b=tJjstqMBtZdVQ33IG1TE+TIcVn1I6GeGxYEnibWDj4SjqnA4kRcUozg1+rWYDB+IkK
         eqyEWAtrRX80wGzFQ1jqfLyiUEryQnpl2FKVFFwgzsMFPsrXwjnGyzuuxPbjT9cLVubr
         UwJtAG6Hj/ohivNiBuGbtJdVacDpe5dSfQdDGnR8zMsKdjlOQncLRfe59Lie2r3YMovx
         VekM/bdznitVjzqKqbxbU6Q6FIvA+UChUepqKqbLT2MNDoT8rbr7wjGrhu8k+RWqD9hH
         vQYRHH1WAOOBsVZT8xD/zligYTIKfRz3HIQJ/uPfOjsOlYek4JEmveXkCY+ywIrSkyfs
         1Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bi4Q+Ey0+7XDwl2Ubuxcr0GeIWRaHfsAqZ9axiSMGa8=;
        b=Z2QxqqlzuM+LxnLAx/Js7iyb3L4WVIXaDD1RUumjEdonwssGoT5Vr5rz8bf4wJnPYe
         RsaE/9jLVsB2gupIEzIThls8e0obWcusHPOCzVwqjVh75mlJGJy9Qvr1IJ6kozIHueZg
         4qMYlpNeqYQLTDvpajeqQPidnq9z75KfqwsdlFFiIMXTYX1XSFzk8VlQmLCHPn5sl8yG
         vXJ0HhsujGBa8EWd25Z2JTRF/677ZESHbn0jOLx4f5eGAcCJFQqezApE0tBOdaEQxHdK
         sg4NKhzZvYo+gBs+Jxy5wjXiBxJX4PO9P0T09GRAKd9igus0+MEoBeFg3JsT/AocD2P8
         E7Bg==
X-Gm-Message-State: AElRT7HCSWDx7N5FlvmUTruDokSMdzxAqWqUMyG0Li9QNFVzGX5QDIo4
        oWTTvKIxXBlPk5vLuA0ffO27JNDNfdgvfcHgTQE4Tg==
X-Google-Smtp-Source: AG47ELvNFXmzG0kZ8VTwRxoBLR8jcfyz9rZen+PdCfuI/DQjezFX3nqe7LOQbsgta/qpvBSrJhCYIK1v1dmj1eFUOcQ=
X-Received: by 2002:a9d:ec5:: with SMTP id 63-v6mr197394otj.14.1521288475479;
 Sat, 17 Mar 2018 05:07:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sat, 17 Mar 2018 05:07:25 -0700 (PDT)
In-Reply-To: <xmqq370z20p5.fsf@gitster-ct.c.googlers.com>
References: <20180308114232.10508-1-pclouds@gmail.com> <20180316183200.31014-1-pclouds@gmail.com>
 <20180316183200.31014-12-pclouds@gmail.com> <xmqq370z20p5.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 17 Mar 2018 13:07:25 +0100
Message-ID: <CACsJy8BwhE5fFOOmJo7Eb68Q52+pJQMHWeBFRNLfZGgcm1QWBg@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] pack-objects.h: reorder members to shrink struct object_entry
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 10:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> Previous patches leave lots of holes and padding in this struct. This
>> patch reorders the members and shrinks the struct down to 80 bytes
>> (from 136 bytes, before any field shrinking is done) with 16 bits to
>> spare (and a couple more in in_pack_header_size when we really run out
>> of bits).
>
> Nice.
>
> I am wondering if we need some conditional code for 32-bit platform.
> For example, you have uint32_t field and do things like this:
>
>         static inline int oe_size_less_than(const struct object_entry *e,
>                                             unsigned long limit)
>         {
>                 if (e->size_valid)
>                         return e->size_ < limit;
>                 if (limit > maximum_unsigned_value_of_type(uint32_t))
>                         return 1;
>                 return oe_size(e) < limit;
>         }
>
> Do we and compilers do the right thing when your ulong is uint32_t?

Another good point. My 32-bit build does complain

In file included from builtin/pack-objects.c:20:0:
./pack-objects.h: In function ?oe_size_less_than?:
./pack-objects.h:282:12: error: comparison is always false due to
limited range of data type [-Werror=3Dtype-limits]
  if (limit > maximum_unsigned_value_of_type(uint32_t))
            ^
--=20
Duy
