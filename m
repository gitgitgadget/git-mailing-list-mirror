Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3533D1F42D
	for <e@80x24.org>; Fri, 11 May 2018 06:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeEKGlk (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 02:41:40 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:39639 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeEKGlj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 02:41:39 -0400
Received: by mail-oi0-f50.google.com with SMTP id n65-v6so3876754oig.6
        for <git@vger.kernel.org>; Thu, 10 May 2018 23:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vyc4B11sbhHO3Eq4zIqeqq/pB6NCM2JFpWXxski/NYk=;
        b=X1GmwTbUluvI7y9nC4yA6+u6k1BYeJ7rZq/GqdXXyUHgRJS6F2fw/+avfIBgEaexuh
         8VNX2h37/e908nTCpBdh/R8lo/mMWbc4yMAIg0SxRg6BJIUwwU3mujGE44qNKD7ZPRaZ
         cwr0euTk4gFCyO65eurlrbOOjMBG5r4SxnYx8FkKg1JOk0Q746NgBnRLraDx3hoZkBFq
         DGiN+oEYyH+fej+fspc/UjE45RgS/O49QFs/ScZhUg/gt8ympGhOEdKjKKd6ZIWeUkQ5
         ORanGqbxrZYnZ7EwQ2Z36Rk+CP8GIRyyEXVw88SiCU+FvxWxv4rd9sXegHJmRlxngeR/
         6olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vyc4B11sbhHO3Eq4zIqeqq/pB6NCM2JFpWXxski/NYk=;
        b=dx9JQIuBliPRjphXVHOTMX4Hx4pn4fzNQ8VKA0Ur6JLxd/IZnmVuA6jIgVoaC1Vl7g
         f3epFZO16o+XQ8QF94SQclQKqxKfd7uu5ndwEBoxhBG6/8zvcpzm/wer/mdnbg8tRjaS
         yAimXufvQfJ8fgNAdiyeZ2cl8iRmlSKsDaCwavOfiG+E/eVPhwfT3f4YOyFBINCIbvOF
         dV7kYY+hag9g5X+HiOdJLA4IgwnlMHb8PABBqJB+bsG3kLIS+ouTTHCcriXbxxOQCURm
         dhz2wUyYX0bzhv+5qyFsglQwlQx6Tp0eA75EUxOsk4k6Go7lGtLK0Of8OwBFCubBizLY
         XAMg==
X-Gm-Message-State: ALKqPwcBmSrEPmvzKH3rTP22sWmw6fNdERTTWaxilcW28pwrxmQRfiun
        GNlFGNaHtKLG2tpcs6+zxGncqj1lVAgPhppgiVQ=
X-Google-Smtp-Source: AB8JxZqa5RCeI06MZuVCKqyLXTmGN2qJ58uFBiQlAkrTQEzKOFIAtDsGrl86CIZeIc1Mw8XBT6q8YMMPxCIEJSgNUes=
X-Received: by 2002:aca:110e:: with SMTP id 14-v6mr2689270oir.56.1526020898473;
 Thu, 10 May 2018 23:41:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 10 May 2018 23:41:08 -0700 (PDT)
In-Reply-To: <CAGZ79kYYFBE+39aeHX22w3ARmujFcgE8YDUQpp6Hps264r0wfQ@mail.gmail.com>
References: <20180508155627.19245-1-pclouds@gmail.com> <20180510150939.25399-1-pclouds@gmail.com>
 <CAGZ79kYYFBE+39aeHX22w3ARmujFcgE8YDUQpp6Hps264r0wfQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 11 May 2018 08:41:08 +0200
Message-ID: <CACsJy8Btz_yYzdMds5SsJ+roSHj4RgiN4eCuPOh0+fod3e2mpw@mail.gmail.com>
Subject: Re: [PATCH v2] pack-format.txt: more details on pack file format
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 7:06 PM, Stefan Beller <sbeller@google.com> wrote:
>> +=== Deltified representation
>> +
>> +Conceptually there are only four object types: commit, tree, tag and
>> +blob. However to save space, an object could be stored as a "delta" of
>> +another "base" object. These representations are assigned new types
>> +ofs-delta and ref-delta, which is only valid in a pack file.
>
> ...only valid...
>
> as opposed to loose objects or as opposed to referencing cross-packs?
> I would think the former, not the latter.

Yeah. This is pretty much an implementation detail of a pack. The
"real" type is always blob/commit/tree/tag. But you only see this when
you dig deep down in pack-related code.

>> +Both ofs-delta and ref-delta store the "delta" against another
>> +object. The difference between them is, ref-delta directly encodes
>> +20-byte base object name. If the base object is in the same pack,
>> +ofs-delta encodes the offset of the base object in the pack instead.
>
> Reading this paragraph clears up the question from before.
> The ref delta is a delta to another "reference by hash id (sha1)".
> What abbreviation is OFS? OFfSet ?

I guess so. I never bothered to track down the source for that.

>> +The delta data is a sequence of instructions to reconstruct an object
>> +from the base object.
>
> As said before the base object is of type 1..4, we do not "delta-on-delta"
> yet, but to construct the object we have to create the base object first,
> which itself can be represented as a deltified object leading to a delta
> chain.

Yeah that's the delta chain concept. I'll just make a note here about
base object potentially being a delta object as well.
-- 
Duy
