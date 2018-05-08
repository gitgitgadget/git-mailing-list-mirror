Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3190200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755703AbeEHSbO (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:31:14 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:39928 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755390AbeEHSbL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:31:11 -0400
Received: by mail-pg0-f46.google.com with SMTP id e1-v6so10176689pga.6
        for <git@vger.kernel.org>; Tue, 08 May 2018 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5INIa5xILFdAkQxyQBY415VAQSVRDm/8b3ioj/57thA=;
        b=tC8UiNTRLDhtAlp44SgRxfi2F/LERaIZDqcBSAlCWXGtjk80p13Sbq1YncSHd9DyJf
         3D7vNXAfH6oXKGR4tClyOqu9Q/mBwgosciag2O3xNMGNmYmZcXUA3/AJcqBVXiEM2sds
         6L3r9QVLimDVUjSzxKhSnbTNDKzCOWYv0qiBOOoalYwsBdN1TwMYr59vWMN2kRwDtrrB
         jse1lg0c8mwGQRzK71YhvFdOftdopX1eKHNn721uoqmWkX0X+MJRsa7TL2FKq0camTSs
         ZDR60PU62EVGxY+kKEHQqb5DfklMIJFXncUjxdTJGyFQgbsBbF4HEzedyVxUWmPBircV
         J9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=5INIa5xILFdAkQxyQBY415VAQSVRDm/8b3ioj/57thA=;
        b=EFpE6sGCnu3UMXgP5wSBijZcCA0k6FHUpaF0BNEr2W62m4s4CRMcNnUkhBFXbfto6w
         iDcI09k4oh2rEyTMssLHSEEKSkpejBKBQlCY1luhz3J99KHbtgX+Jtj9IoVEDUx9Unda
         Hm/JGNKIwalgFHeZWhNex6yujzTjqzsRLYl4poAkToa17u1wH7orYmmbEPj2N9fFsxl7
         a3w50cMj+Crg1C+k5vfaI/i62RPuh+yFCbpVL9N3OM0iRsM9Yah8dByhX/mqL1Xmxk6J
         1nFerpzH5W+Ksg3XxxNt56+oMKdpP66nptgEmthpI70xDFIYoNk/oe0p/4aFjyzWpm7C
         jRBg==
X-Gm-Message-State: ALQs6tDIg6mchYXFO+wX1RR/P0FIQgc9CVTX03ccAfHCQA2GkE4Lih4z
        3FAbFAHnGimtISc4PG6Ch8MJDEcxsUkYGUubG8Q=
X-Google-Smtp-Source: AB8JxZp1aI1/f+D1Vm+DK2l3lgHJu2ezBnM//94HpX17Ib1eWa1JXh1qAR6pr63dLJSbZDGqeaTUW/INiENToZo66vs=
X-Received: by 10.98.233.3 with SMTP id j3mr8952748pfh.196.1525804270891; Tue,
 08 May 2018 11:31:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Tue, 8 May 2018 11:31:10 -0700 (PDT)
In-Reply-To: <20180508011352.GM953644@genre.crustytoothpaste.net>
References: <20180504015202.GP13217@genre.crustytoothpaste.net>
 <20180506204226.955739-1-sandals@crustytoothpaste.net> <20180506204226.955739-2-sandals@crustytoothpaste.net>
 <CAN0heSrth+ZheEsHuVdyUv9fcnP07O=YvK6y+=rmaGqZf7X3_w@mail.gmail.com> <20180508011352.GM953644@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 8 May 2018 20:31:10 +0200
Message-ID: <CAN0heSpaETw_v_a_zL7Cp+cDNHP9je2ZqTHh37FfDHjAbRn18A@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: render revisions correctly under Asciidoctor
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 May 2018 at 03:13, brian m. carlson <sandals@crustytoothpaste.net> wro=
te:
> On Mon, May 07, 2018 at 06:11:43AM +0200, Martin =C3=85gren wrote:
>> Excellent. These two patches fix my original problem and seem like the
>> obviously correct approach (in hindsight ;-) ). I wonder if the diagrams
>> earlier in the file should be tackled also. Right now, one has a huge
>> number of dots instead of the four you added; the other has none. They
>> do render fine though, so that'd only be about consistency in the
>> original .txt-file.
>
> Yeah, the number of dots has to be at least four, but can be any
> matching number.
>
> Since this patch fixes the present issue, I'd like to leave it as it is
> and run through a cleanup series a bit later that catches all the
> literal indented blocks and marks them explicitly to avoid this issue in
> the future.

Sounds like a plan. :-) As noted elsewhere, I have no immediate idea how
to identify which of the 13000 tab-indented lines are really part of
diagrams and ascii-art. Counting the number of spaces? Anyway, thanks
for this mini-series.

Martin
