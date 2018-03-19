Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E44F1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 18:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966796AbeCSSpj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 14:45:39 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:40516 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935778AbeCSSpf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 14:45:35 -0400
Received: by mail-ot0-f177.google.com with SMTP id l12-v6so18456772otj.7
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kSoceGvXYEyFpWkqGEFH53tfioGlagTsJ3mXyEAjMlc=;
        b=lS0NeToKg3FyyTUqCeY+6qE6XPCWiOPj3heXHWZ99ndALfWWHruiIE8fdc3CcPQvn9
         QLmfxM0n4jPTe1smVvXKEnCaNEbp3pWWjY8t6m2eHGQT2c0cIvpuhrQsyZvtR7ZP2SbR
         3Tz+Qn5B3xqVw0Gd5JQCnjMvRphUpy22tK1ORE/r0RszKkfNnUGQoiWyqgQgyUTt5+ZA
         ZWnttAcUGBQMikHqqxrUpcvQJ+ITJ2+Eyj+T3fhhKKsIgESL3HP0Noa79ksshynjT5r2
         ahDA+TSCDsCEIYSRtJmBuRi+2MAEMlpA7Hv0NPP4B2LckcJ7h8kJshop8hrz05DxID+A
         K2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kSoceGvXYEyFpWkqGEFH53tfioGlagTsJ3mXyEAjMlc=;
        b=DKVzOOmTrEbyo9Hh2R+4U9/lE/rmps1PrSqF9Bpkq+wOTgN8eFtUEdOoZyjVmeJKhh
         o03R9ci05iNeh0DnqFvX564/pCs+ODVgD5I9LXHhnk0NHhGgB8GAVcKB2/EDrQwJ9T/d
         zM2iAp9s61716O61ZjE03JU0ePlx+3dYR2x0EqKO+rZnLmWecoUrU6WfXXw38A/9DdZm
         JeWIvOND+nERchj0b4/Sjg4RAM7rPD68ocUUWYjfcUAX2LCJXlu7VHVHI+iYxzeuv9A6
         KU0ihpFYCSVaOTdc/PHcHXD6RMi79VTDzYwUHlu6dudH/FPHytBq8rqDnj22sJ0hWIbx
         3WkA==
X-Gm-Message-State: AElRT7HoQ6fJrQNd02fqp3TmPaIhxw3kJTGBBGxUhrqA0NCOyBfoJpXs
        JdxysC/UQ1a1OZB/alZloeGWXYY6lAqIsiykt0k=
X-Google-Smtp-Source: AG47ELtdsABH555G+be1thqRGneifB+327aiMt36YJXB75HYCM4+9Kvm5F3CUEGZqLgu7ce7zdvFKm4oHj1KjUceEys=
X-Received: by 2002:a9d:3698:: with SMTP id h24-v6mr8919357otc.173.1521485134813;
 Mon, 19 Mar 2018 11:45:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Mon, 19 Mar 2018 11:45:04 -0700 (PDT)
In-Reply-To: <xmqqlgenvs07.fsf@gitster-ct.c.googlers.com>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180318142526.9378-10-pclouds@gmail.com> <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AkJJQ4XNszxBsESN_WGOSZ+ExWdcCtn6NA+gW9+-mAqQ@mail.gmail.com> <xmqqlgenvs07.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Mar 2018 19:45:04 +0100
Message-ID: <CACsJy8AbkaSLBYqtFiCwFoqRXguy1hTs=XriefZ3WQJjo_sy8Q@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 7:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> +     if (!e->size_valid) {
>>>> +             unsigned long real_size;
>>>> +
>>>> +             if (sha1_object_info(e->idx.oid.hash, &real_size) < 0 ||
>>>> +                 size != real_size)
>>>> +                     die("BUG: 'size' is supposed to be the object size!");
>>>> +     }
>>>
>>> If an object that is smaller than 4GB is fed to this function with
>>> an incorrect size, we happily record it in e->size_ and declare it
>>> is valid.  Wouldn't that be equally grave error as we are catching
>>> in this block?
>>
>> That adds an extra sha1_object_info() to all objects and it's
>> expensive (I think it's one of the reasons we cache values in
>> object_entry in the first place). I think there are also a few
>> occasions we reuse even bad in-pack objects (there are even tests for
>> that) so it's not always safe to die() here.
>
> So what?  My point is that I do not see the point in checking if the
> size is correct on only one side (i.e. size is too big to fit in
> e->size_) and not the other.  If it is worth checking (perhaps under
> "#ifndef NDEBUG" or some other debug option?) then I'd think we
> should spend cycles for all objects and check.

There is a difference. For sizes smaller than 2^32, whatever you pass
to oe_set_size() will be returned by oe_size(), consistently. It does
not matter if this size is "good" or not. With sizes > 2^32, we make
the assumption that this size must be the same as one found in the
object database. If it's different, oe_size() will return something
else other than oe_set_size() is given. This check here is to make
sure we do not accidentally let the caller fall into this trap.

Yes, it may be a good thing to check anyway even for sizes < 2^32. I'm
a bit uncomfortable doing that though. I was trying to exercise this
code the other day by reducing size_ field down to 4 bits, and a
couple tests broke but I still don't understand how. It's probably
just me pushing the limits too hard, not a bug in these changes. But
it does tell me that I don't understand pack-objects enough to assert
that "all calls to oe_set_size() give good size".
-- 
Duy
