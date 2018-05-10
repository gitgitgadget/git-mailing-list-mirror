Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5428D1F406
	for <e@80x24.org>; Thu, 10 May 2018 17:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966551AbeEJRGj (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:06:39 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:38004 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966402AbeEJRGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:06:39 -0400
Received: by mail-yw0-f169.google.com with SMTP id y123-v6so758916ywa.5
        for <git@vger.kernel.org>; Thu, 10 May 2018 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VUaLbo2YrX7NwYjr7cPnjH6Kqbz/nbzdEFvLquw93aU=;
        b=AKzSf6QT1a4Vg0Hdo/xS1REIXR+XHydefv07GL+mdlb5qBGxk7W9cTy7m85VB4rkX/
         Cs+B4k2NXTMtwSm1H2Ftr68+kLcWcvjKKcroTooeq6AZqTH5qdsjfSSvdnveIRef17wr
         dNjtR3yUhw/pWeEVc+/OJnEe7O9G28hBp3GP3RmpecH/NkgE9Op9vnbZHM8FnuAVPi4R
         QK1HNYEobPDTWJ3GRDcN2oi15JNXTRjC9qMbMBNi4PIFHfjReM+OU6hciioVqxTDx49B
         6kk863kMSSAT1fLzvFhsbcHwDI6V5UvE6zuRQ7BrPxGj24IzBib2QrrqP+x1vt1pwucd
         jxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VUaLbo2YrX7NwYjr7cPnjH6Kqbz/nbzdEFvLquw93aU=;
        b=UzqZV61TmKzNRNbI5uV7U8xqb6E9xFmCGFIpIBWbGJX6pRaV0joCC0SA1FNsHLABuY
         dN0n1ueI/NlnLbM4D0i3+rUVWW3hPfb/uvpoGiU1YZH5YWuLSSph1iBvr0APTlI69iC1
         VL5vVM1eVPI2sKKLJw9e4VK9XEMQNYZncvz9dw3NMmbfy3iy1GpSF3WRZKvTQHYLfxqw
         zGtXxaUQl4oN8lk79IvntKCKrrqEa+GKamb34YHEb/FND8M3STFrbtdREryH5FcH5pXp
         /CiJ05CL0y3UiMWs6WKaYNDb5lybvvEY60LR0cDP/UYT9WBbZnqnczVvBI0amXWAhxMM
         /0fQ==
X-Gm-Message-State: ALKqPwcaC96fM0dRwLJ7DY9CR05vxzuyrEzE4PLckOS4ktBNcfW+z9T+
        cM+ObQoYVfn0cXRXakrkc4U2D8sUmiP5a4O9Pnk5kg==
X-Google-Smtp-Source: AB8JxZqJ1nyCim7bil0VlPTDMQl85WRzTq2yp9Z872g2ejreQzTgd6R3r4BrYw7DYupBH+YOl9aaiSyGGUpBNO9as04=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr1042286ywg.345.1525971997733;
 Thu, 10 May 2018 10:06:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 10:06:37
 -0700 (PDT)
In-Reply-To: <20180510150939.25399-1-pclouds@gmail.com>
References: <20180508155627.19245-1-pclouds@gmail.com> <20180510150939.25399-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 10:06:37 -0700
Message-ID: <CAGZ79kYYFBE+39aeHX22w3ARmujFcgE8YDUQpp6Hps264r0wfQ@mail.gmail.com>
Subject: Re: [PATCH v2] pack-format.txt: more details on pack file format
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 8:09 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The current document mentions OBJ_* constants without their actual
> values. A git developer would know these are from cache.h but that's
> not very friendly to a person who wants to read this file to implement
> a pack file parser.
>
> Similarly, the deltified representation is not documented at all (the
> "document" is basically patch-delta.c). Translate that C code to
> English with a bit more about what ofs-delta and ref-delta mean.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  This is a much better description than v1. I hope.
>
>  Documentation/technical/pack-format.txt | 78 +++++++++++++++++++++++++
>  cache.h                                 |  5 ++
>  2 files changed, 83 insertions(+)
>
> diff --git a/Documentation/technical/pack-format.txt b/Documentation/tech=
nical/pack-format.txt
> index 8e5bf60be3..d20bf592aa 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -36,6 +36,84 @@ Git pack format
>
>    - The trailer records 20-byte SHA-1 checksum of all of the above.
>
> +=3D=3D=3D Object types
> +
> +Valid object types are:
> +
> +- OBJ_COMMIT (1)
> +- OBJ_TREE (2)
> +- OBJ_BLOB (3)
> +- OBJ_TAG (4)
> +- OBJ_OFS_DELTA (6)
> +- OBJ_REF_DELTA (7)
> +
> +Type 5 is reserved for future expansion. Type 0 is invalid.
> +
> +=3D=3D=3D Deltified representation
> +
> +Conceptually there are only four object types: commit, tree, tag and
> +blob. However to save space, an object could be stored as a "delta" of
> +another "base" object. These representations are assigned new types
> +ofs-delta and ref-delta, which is only valid in a pack file.

...only valid...

as opposed to loose objects or as opposed to referencing cross-packs?
I would think the former, not the latter.

> +Both ofs-delta and ref-delta store the "delta" against another
> +object. The difference between them is, ref-delta directly encodes
> +20-byte base object name. If the base object is in the same pack,
> +ofs-delta encodes the offset of the base object in the pack instead.

Reading this paragraph clears up the question from before.
The ref delta is a delta to another "reference by hash id (sha1)".
What abbreviation is OFS? OFfSet ?

> +The delta data is a sequence of instructions to reconstruct an object
> +from the base object.

As said before the base object is of type 1..4, we do not "delta-on-delta"
yet, but to construct the object we have to create the base object first,
which itself can be represented as a deltified object leading to a delta
chain.

>     Each instruction appends more and more data to
> +the target object until it's complete. There are two supported
> +instructions so far: one for copy a byte range from the source object
> +and one for inserting new data embedded in the instruction itself.

ok. So there are 2 types of instructions, "copy from (offset, size)" and
"new data follows".

The next paragraphs seem to describe the copy instruction, maybe
add a sub-headline here?

> +Each instruction has variable length. Instruction type is determined
> +by the seventh bit of the first octet. The following diagrams follow
> +the convention in RFC 1951 (Deflate compressed data format).
> +
> +  +----------+---------+---------+---------+---------+-------+-------+--=
-----+
> +  | 1xxxxxxx | offset1 | offset2 | offset3 | offset4 | size1 | size2 | s=
ize3 |
> +  +----------+---------+---------+---------+---------+-------+-------+--=
-----+
> +
> +This is the instruction format to copy a byte range from the source
> +object. It encodes the offset to copy from any the number of bytes to
> +copy. Offset and size are in little-endian order.
> +
> +All offset and size bytes are optional. This is to reduce the
> +instruction size when encoding small offsets or sizes. The first seven
> +bits in the first octet determines which of the next seven octets is
> +present. If bit zero is set, offset1 is present. If bit one is set
> +offset2 is present and so on.
> +
> +Note that a more compact instruction does not change offset and size
> +encoding. For example, if only offset2 is omitted like below, offset3
> +still contains bits 16-23. It does not become offset2 and contains
> +bits 8-15 even if it's right next to offset1.
> +
> +  +----------+---------+---------+
> +  | 10000101 | offset1 | offset3 |
> +  +----------+---------+---------+

It reads very fluently to here.

> +In its most compact form, this instruction only takes up one byte
> +(0x80) with both offset and size omitted, which will have default
> +values zero. There is another exception: size zero is automatically
> +converted to 0x10000.

This "another exception" sounds a bit tacked on, but is still understandabl=
e.
I would imagine that the size of 0 is used frequently to copy large blocks
and coincidentally it is represented using the lowest number of bytes
for size. Cute!

Before the next diagram we could have a sub-headline, indicating
that the other instruction "new data follows" will now be described.

> +  +----------+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +  | 0xxxxxxx |    data    |
> +  +----------+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +
> +This is the instruction to construct target object without the base
> +object. The following data is appended to the target object. The first
> +seven bits of the first octet determines the size of data in
> +bytes. The size must be non-zero.

This command sounds very easy.
However we can have at most 127 bytes of new data, so if someone
adds a larger part of new code, we'd have many "insert new data"
instructions, all at the max of 127, such that the overhead for instruction
bytes is 1/127 =3D 0.7 %. Sounds efficient.

> +  +----------+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  | 00000000 |
> +  +----------+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This is the instruction reserved for future expansion.

Thanks for pointing this out.


>
> +/*
> + * Values in this enum (except those outside the 3 bit range) are part
> + * of pack file format. See Documentation/technical/pack-format.txt
> + * for more information.
> + */

Makes sense.

I really like this patch very much. Thanks for writing it.
My annotations are just to add the cherry onto the cake,
the current form is
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!
