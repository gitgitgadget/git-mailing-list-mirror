Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5366B200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeEHS0I (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:26:08 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:37010 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933469AbeEHS0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:26:06 -0400
Received: by mail-pg0-f44.google.com with SMTP id a13-v6so21525244pgu.4
        for <git@vger.kernel.org>; Tue, 08 May 2018 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AoL0p0WSYsXX2t2yGn+8NMlV95YY7/fVucvt2TT2if4=;
        b=rL0rXKuNfXUsbYTHLK23JKq/1hAeDCKlHV7sJ8+LZytQJuRhyILBlbl4oz3Jdme+jh
         s9amelz7MKQqINOZgz6wOdklCjX8hjyj10dWV8oBFDdCB4A6YhJ3HVpdF7SwiS6yGNMv
         T6r/CjHzT7jDT+57B0Vdsr73Rp1/qBk4OKtX8EkE6YyZcccoRyvcM1kKZuiaddcjprFp
         2w7NkV6NWhkFMfCVauhxboyfadPpjHKa5ivoix0oFcqUT5tzMTxr+Fxe0ThshAVrypG0
         hT51CtiTDgf0le0By3qrGe+o9ELIU+M/spRk5jcto5BGhTm15PGcSSncweX1fQTgPAsl
         CxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=AoL0p0WSYsXX2t2yGn+8NMlV95YY7/fVucvt2TT2if4=;
        b=Gu0KxpfYSKTfvBHWlKJG9Z6rzPvrXls2hF6Lpl1qBXP0yZ6z1XBHKmnP/NGYVkZ9DP
         MxOhEzh9xgWQtTYWPcymD5q3rlyDWqo0p3vT4iu7KHuP2qapJEfTIZjuUubU9fyy9v9T
         SEbD7Ef4LbK5SzWtYtvAyLHSSF+u9Zehfejm3VrdfCb+xKyrh6FAzz/jdO4o+b14iR4r
         DN5fiDLKSPBMSlVwX/+vuDpYSq5WnPtTzE6t2kE7agv4YpP+WtAlswU6tnRDE1W5ufJ7
         vNbIS/Gc83UfqhgimITFGBqePJDQFpoVKhuPTQev/UOE133iy1nwc4HQROK/Vo3+Tu0h
         BI7w==
X-Gm-Message-State: ALQs6tDtF2K/dYtla7CrumKCol9nsTf7+hi7nJjRwDOf2osgzRjTsyAo
        FbCGW3MbIvdNzZnFrtbh4QADEQVYn3ZQuNk7gig=
X-Google-Smtp-Source: AB8JxZrweQNkf4/2HJGy17SNgSa2FqAlCMIo3j0933rd0kPy3PwnlpPN9jhyFENYpVOyP4mLT/ApR5fhVnXw4NhFo7k=
X-Received: by 2002:a63:66c3:: with SMTP id a186-v6mr22507321pgc.408.1525803966105;
 Tue, 08 May 2018 11:26:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Tue, 8 May 2018 11:26:05 -0700 (PDT)
In-Reply-To: <20180507233000.GI953644@genre.crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
 <20180506231752.975110-2-sandals@crustytoothpaste.net> <CAN0heSqk0siv4y5BGz2+sLhAyNG=TEZmgucKoCDGyx2i8_O+tQ@mail.gmail.com>
 <20180507233000.GI953644@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 8 May 2018 20:26:05 +0200
Message-ID: <CAN0heSpzBtSBE78zmBx_5ukb4DpHEO==kGgbYAczE+UyBf3HxA@mail.gmail.com>
Subject: Re: [PATCH 01/28] t/test-lib: add an SHA1 prerequisite
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 May 2018 at 01:30, brian m. carlson <sandals@crustytoothpaste.net> wro=
te:
> On Mon, May 07, 2018 at 12:10:39PM +0200, Martin =C3=85gren wrote:
>> On 7 May 2018 at 01:17, brian m. carlson <sandals@crustytoothpaste.net> =
wrote:
>> > Add an SHA1 prerequisite to annotate both of these types of tests and
>> > disable them when we're using a different hash.  In the future, we can
>> > create versions of these tests which handle both SHA-1 and NewHash.
>>
>> Minor nit: s/can/can and should/
>
> I agree with that sentiment.  I can change that.

To be clear, this was an "if you have independent reasons for rerolling
this, then maybe consider possibly doing this".

>> So SHA1 means roughly "git hash-object uses SHA-1, so supposedly
>> everything on disk is SHA-1." I could imagine one or two different
>> meanings: "Git was compiled with support for SHA-1 [oids]."
>
> Currently it means that, yes.  It may specialize to mean, "git emits
> SHA-1 output, regardless of the format on disk."  See cases 1 and 2
> below.
>
>> Do we actually need more SHA-1-related prereqs, at least long-term, in
>> which case we would want to find a more specific name for this one now?
>> Is this SHA1_STORAGE, or some much better name than that?
>
> We may.  The transition plan anticipates several states:

"We may" as in, "we may need more SHA1-FOO prereqs later", or "we may
want this to be SHA1-BAR"?

> 1. Store data in NewHash, but input and output are SHA-1.
> 2. Store data in NewHash; output is SHA-1; input can be either.
> 3. Store data and output in NewHash; input can be either.
> 4. All NewHash.
>
> At this point, I'm working on getting the tests to handle case 4, as
> that's actually the easiest to fix (because if things are wrong, the
> code tends to segfault).  Case 1 will be next, in which case, we may
> need SHA1_STORAGE or such.

> I plan to make the SHA1 prerequisite go away or at least be far less
> used in a few releases.  Once we know what NewHash is going to be, it's
> pretty easy to write tooling and translation tables that do the
> conversion for most tests, and a test helper can simply emit the right
> output for whichever algorithm we're using in that situation, whether
> that's the on-disk algorithm, the input algorithm, or the output
> algorithm.

I do not feel entirely relaxed about a reasoning such as "this prereq
will soon go away again, so we do not need to think too much about its
name and meaning" (heavily paraphrased and possibly a bit pointed, but
hopefully not too dishonest).

I guess a counter-argument might be "sure, if only we knew which
SHA1-FOOs we will need. Only time and experience will tell." You've
certainly spent way more brain-cycles on this than I have, and most
likely more than anyone else on this list.

Maybe we want to document the transition-ness of this in the code and/or
the commit message. Not only "transition" in the sense of the big
transition, but in the sense of "this will probably go away long before
the transition is completed."

>> I am thinking for example about a repo with NewHash that gets pushed to
>> and fetched from a SHA-1 server, see hash-function-transition.txt, goal
>> 1b. We'd want to always test that SHA-1-related functionality in git.
>> (But only until the day when someone defines a prereq such as "SHA1" to
>> be able to test a git that was compiled without any traces of SHA-1
>> whatsoever.)
>
> I anticipate that by the time we get to that point, the SHA1
> prerequisite will be long gone and can be reused for that purpose,
> should we need it.
