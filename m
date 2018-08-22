Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8831F954
	for <e@80x24.org>; Wed, 22 Aug 2018 07:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeHVLDv (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 07:03:51 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40614 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeHVLDv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 07:03:51 -0400
Received: by mail-qk0-f194.google.com with SMTP id c126-v6so624090qkd.7
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5wLwzYxOZsk004oCZdnbr1+lCmNn2zngQ7P5/xkIxQ=;
        b=ryo8+inAuDB+ymg40jw+tDuqLKSV4JTqr1TtFT+/Nf+W2aKF0ctdEUSCtsn+iQ+wwc
         0RK5jQsfFY4NZUycnfTH2WWMm7fT7KTFcSjQZ+KdKbrGtijglGxj8xQf9uWualbGYNui
         vK+Z/fOE19gtJ/6CTNzIPZOF3A96iI7V+0xEcnIKPx/SST4+jFB7C8ysv8Jth/ZtePnJ
         vS5Iu6z/qi8q4WWItfXpx05xr7JmaqiRpC4aCAD5VlpeRSG/rpngksznTUwD39kaCkgJ
         wMHZ8HZ7ZOIs0B2QELvHFZihqo2M+/WcGXVDy70Zqp4/E1W0BTrRvoSrY+m5nva9BXpn
         qIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5wLwzYxOZsk004oCZdnbr1+lCmNn2zngQ7P5/xkIxQ=;
        b=AWrMrkvUw4zVJTfrX9hZmSRs4Pt0bpWLw4irkH4O9XyUheDiLipXXEdiACJFpLgYk3
         DINvEMWmF9Jw3TuQgbIVKXYi4mL+AR7OWmWFVDZ50k/zzZsEA0r/ckgPVFL02iHkLB2i
         ueKSnJycJU6CJytYArFIv2KenB6FWZ462bdeUucAVNYqvU7OrpMgr6EuTyD9t17ATJcF
         YcJxbd/pXn3xyq0Vc2C549zRfaoirSjO9VPYgDI9Tru9aH20yMKvWvAerme/HBf0jDDt
         1PVZmmt5gbvqxdGcAXY6kvOgvutEDMOF1wqaH8983yQ1SZ9eO6I6t0O7ybfu8Ytul0Ee
         drPA==
X-Gm-Message-State: AOUpUlFzQ5wTwoxbbQcbvz9eP0EhuCbVKzUd/3zYrZw4dRJbEiEs/QVF
        mdBK4MtOLhuZHy8RMZKgx9vjyd1hLvAmRWvgTyw=
X-Google-Smtp-Source: AA+uWPwc0DjHAQJ49i+PmNKPiylUlapRnXKcuu0Nz+5Wu3PpcMU8EWwkfMVx6wQgSo3ZDSs1hBnFOpyWcvveGfahl8g=
X-Received: by 2002:a37:9404:: with SMTP id w4-v6mr47794608qkd.50.1534923608944;
 Wed, 22 Aug 2018 00:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com> <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net> <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net> <20180822053626.GB535143@genre.crustytoothpaste.net>
 <20180822060735.GA13195@sigill.intra.peff.net>
In-Reply-To: <20180822060735.GA13195@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 22 Aug 2018 09:39:57 +0200
Message-ID: <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 8:20 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 22, 2018 at 05:36:26AM +0000, brian m. carlson wrote:
>
> > On Tue, Aug 21, 2018 at 11:03:44PM -0400, Jeff King wrote:
> > > So I wonder if there's some other way to tell the compiler that we'll
> > > only have a few values. An enum comes to mind, though I don't think the
> > > enum rules are strict enough to make this guarantee (after all, it's OK
> > > to bitwise-OR enums, so they clearly don't specify all possible values).
> >
> > I was thinking about this:
> >
> > diff --git a/cache.h b/cache.h
> > index 1398b2a4e4..1f5c6e9319 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1033,7 +1033,14 @@ extern const struct object_id null_oid;
> >
> >  static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> >  {
> > -     return memcmp(sha1, sha2, the_hash_algo->rawsz);
> > +     switch (the_hash_algo->rawsz) {
> > +             case 20:
> > +                     return memcmp(sha1, sha2, 20);
> > +             case 32:
> > +                     return memcmp(sha1, sha2, 32);
> > +             default:
> > +                     assert(0);
> > +     }
> >  }
>
> Unfortunately this version doesn't seem to be any faster than the status
> quo. And looking at the generated asm, it still looks to be calling
> memcpy(). Removing the "case 32" branch switches it back to fast
> assembly (this is all using gcc 8.2.0, btw). So I think we're deep into
> guessing what the optimizer is going to do, and there's a good chance
> that other versions are going to optimize it differently.
>
> We might be better off just writing it out manually. Unfortunately, it's
> a bit hard because the neg/0/pos return is more expensive to compute
> than pure equality. And only the compiler knows at each inlined site
> whether we actually want equality. So now we're back to switching every
> caller to use hasheq() if that's what they want.
>
> But _if_ we're OK with that, and _if_ we don't mind some ifdefs for
> portability, then this seems as fast as the original (memcmp+constant)
> code on my machine:
>
> diff --git a/cache.h b/cache.h
> index b1fd3d58ab..c406105f3c 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1023,7 +1023,16 @@ extern const struct object_id null_oid;
>
>  static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  {
> -       return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +       switch (the_hash_algo->rawsz) {
> +       case 20:
> +               if (*(uint32_t *)sha1 == *(uint32_t *)sha2 &&
> +                   *(unsigned __int128 *)(sha1+4) == *(unsigned __int128 *)(sha2+4))
> +                       return 0;
> +       case 32:
> +               return memcmp(sha1, sha2, 32);
> +       default:
> +               assert(0);
> +       }
>  }
>
>  static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
>
> Which is really no surprise, because the generated asm looks about the
> same. There are obviously alignment questions there. It's possible it
> could even be written portably as a simple loop. Or maybe not. We used
> to do that, but modern compilers were able to optimize the memcmp
> better. Maybe that's changed. Or maybe they were simply unwilling to
> unroll a 20-length loop to find out that it could be turned into a few
> quad-word compares.
>
> > That would make it obvious that there are at most two options.
> > Unfortunately, gcc for me determines that the buffer in walker.c is 20
> > bytes in size and steadfastly refuses to compile because it doesn't know
> > that the value will never be 32 in our codebase currently.  I'd need to
> > send in more patches before it would compile.
>
> Yeah, I see that warning all over the place (everywhere that calls
> is_null_oid(), which is passing in a 20-byte buffer).
>
> > I don't know if something like this is an improvement or now, but this
> > seems to at least compile:
> >
> > diff --git a/cache.h b/cache.h
> > index 1398b2a4e4..3207f74771 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1033,7 +1033,13 @@ extern const struct object_id null_oid;
> >
> >  static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> >  {
> > -     return memcmp(sha1, sha2, the_hash_algo->rawsz);
> > +     switch (the_hash_algo->rawsz) {
> > +             case 20:
> > +             case 32:
> > +                     return memcmp(sha1, sha2, the_hash_algo->rawsz);
> > +             default:
> > +                     assert(0);
> > +     }
>
> I think that would end up with the same slow code, as gcc would rather
> call memcmp than expand out the two sets of asm.
>
> > I won't have time to sit down and test this out until tomorrow afternoon
> > at the earliest.  If you want to send in something in the mean time,
> > even if that limits things to just 20 for now, that's fine.
>
> I don't have a good option. The assert() thing works until I add in the
> "32" branch, but that's just punting the issue off until you add support
> for the new hash.
>
> Hand-rolling our own asm or C is a portability headache, and we need to
> change all of the callsites to use a new hasheq().
>
> Hiding it behind a per-hash function is conceptually cleanest, but not
> quite as fast. And it also requires hasheq().
>
> So all of the solutions seem non-trivial.  Again, I'm starting to wonder
> if it's worth chasing this few percent.

Did you try __builtin_expect? It's a GCC builtin for these sorts of
situations, and sometimes helps:
https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html

I.e. you'd tell GCC we expect to have the 20 there with:

    if (__builtin_expect(the_hash_algo->rawsz == 20, 1)) { ... }

The perl codebase has LIKELY() and UNLIKELY() macros for this which if
the feature isn't available fall back on just plain C code:
https://github.com/Perl/perl5/blob/v5.27.7/perl.h#L3335-L3344
