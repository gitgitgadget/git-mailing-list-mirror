Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6DA31F576
	for <e@80x24.org>; Thu, 15 Feb 2018 09:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755267AbeBOJ7F (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 04:59:05 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36260 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeBOJ7C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 04:59:02 -0500
Received: by mail-wr0-f174.google.com with SMTP id u15so2724114wrg.3
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=15f077oxOAv0hkzm7ENMdMARl0KLat4TD4+Ud6TvDGE=;
        b=lW9HnI/FaYQAmR5Dm2VosbfhJo79L3X51rYfy5gfVZAxtrIVRQiMbdOk0yTTUOOQqY
         ov9NJ5T5G84gEoUI9ylKk3J8iBdmpNSsLYozNBUMcfjnU7B3WANvwET07ShMKTeDl0V2
         ZQEpvmUhf7kGdHpTPJ/CwRKEoE9D/g/sa8nN+77iEjhILzVCT/FcYLMV9zHRf0+jcS4I
         YO/NgO21al5zOOIXIWPUmkYnWC0ENbcGbchxBeG49suaAOfHH6k64FehM2idosuvnVx0
         U1cHht3r5OaXOxRsX0THoAet+fwON0fXORdfnSOn2W0r6Pn51Py+y5375QEgpqKjgvd2
         X7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=15f077oxOAv0hkzm7ENMdMARl0KLat4TD4+Ud6TvDGE=;
        b=Mdyq6MMWXnbSxyjuXy4fm7qeCeR476s9sb6gIJ2dRCeKNfGEz9cR3qU52gd8yHncC2
         vvCZBN4jXJjNHBO9QQ0ZoJVjhBjFSRT1au5HlaRr16Re+lUkXh5oqo8PhdBmKbzCMODc
         ctFPtWMtJorz5EFmklcycvL67xGoz8dFT8EzQ+Hwad/KAIG0HfPY8/oI8kpR93dxbz20
         aHnKnz/h6XmYkvQS/lnNDj2rwHfuG52rgMPYexr0sqwinjZy4mSZsbfr5zIavepstXSX
         kSLP1RlTcAG/jlhRQjaKo6fUNNvgMosBtDwVbMTltwlD+b70qOS3a1BXWcSP8aye6cZc
         3cEw==
X-Gm-Message-State: APf1xPBcmWGWxQVPeyuDogTJ76LC2O8Knmw2IQKtKq7EmYGyqwUHk7EX
        wvFLaRwlZkyw3vNGteBkenFZH4QNxYvFDqfohOA=
X-Google-Smtp-Source: AH8x224MuF/c3Mc75g2/5TBMa+XgLJlW92ILP0boT7+r7mcjiYljdQcOt1TEhscLm1FrX+i87l3w6Hk146vKhPslQGY=
X-Received: by 10.223.176.201 with SMTP id j9mr2083390wra.210.1518688740919;
 Thu, 15 Feb 2018 01:59:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Thu, 15 Feb 2018 01:59:00 -0800 (PST)
In-Reply-To: <20180215051658.GB18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4311-ab635cac-1d48-47ee-90e1-f178f134db1c-000000@eu-west-1.amazonses.com>
 <20180215051658.GB18780@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 15 Feb 2018 12:59:00 +0300
Message-ID: <CAL21BmkQJTGYwR2BywNtsDVuMSGQVO+eWDTqTJL-WoiuAjmg0w@mail.gmail.com>
Subject: Re: [PATCH v3 02/23] ref-filter: add return value to some functions
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-15 8:16 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
>
>> Add return flag to format_ref_array_item(), show_ref_array_item(),
>> get_ref_array_info() and populate_value() for further using.
>> Need it to handle situations when item is broken but we can not invoke
>> die() because we are in batch mode and all items need to be processed.
>
> OK. The source of these errors would eventually be calls in
> populate_value(), but we don't flag any errors there yet (well, we do,
> but they all end up in die() for now). So I'd expect to see later in the
> series those die() calls converted to errors (I haven't looked further
> yet; just making a note to myself).
>
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1356,8 +1356,9 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
>>
>>  /*
>>   * Parse the object referred by ref, and grab needed value.
>> + * Return 0 if everything was successful, -1 otherwise.
>>   */
>
> We discussed off-list the concept that the caller may want to know one
> of three outcomes:
>
>   - we completed the request, having accessed the object
>   - we completed the request, but it didn't require accessing any
>     objects
>   - an error occurred accessing the object
>
> Since callers like "cat-file" would need to check has_sha1_file()
> manually in the second case. Should this return value actually be an
> enum, which would make it easier to convert later to a tri-state?

I decided not to implement this particular scenario because all other
callers are waiting that everything will be printed inside ref-filter.
We just add support for cat-file there. I don't think that I need to
re-think all printing process and move printing logic to all other
callers so that cat-file will behave fine. In my opinion, in the final
version cat-file must accept all ref-filter logic parts and adapt to
them.

>
>> -static void populate_value(struct ref_array_item *ref)
>> +static int populate_value(struct ref_array_item *ref)
>>  {
>>       void *buf;
>>       struct object *obj;
>> @@ -1482,7 +1483,7 @@ static void populate_value(struct ref_array_item *ref)
>>               }
>>       }
>>       if (used_atom_cnt <= i)
>> -             return;
>> +             return 0;
>
> Most of these conversions are obviously correct, because they just turn
> a void return into one with a value. But this one is trickier:
>
>> @@ -2138,9 +2144,10 @@ void format_ref_array_item(struct ref_array_item *info,
>>               ep = strchr(sp, ')');
>>               if (cp < sp)
>>                       append_literal(cp, sp, &state);
>> -             get_ref_atom_value(info,
>> -                                parse_ref_filter_atom(format, sp + 2, ep),
>> -                                &atomv);
>> +             if (get_ref_atom_value(info,
>> +                                    parse_ref_filter_atom(format, sp + 2, ep),
>> +                                    &atomv))
>> +                     return -1;
>>               atomv->handler(atomv, &state);
>>       }
>
> since it affects the control flow. Might we be skipping any necessary
> cleanup in the function if we see an error?
>
> It looks like we may have called push_stack_element(), but we'd never
> get to the end of the function where we call pop_stack_element(),
> causing us to leak.

Agree,  I will fix this.

>
> -Peff
