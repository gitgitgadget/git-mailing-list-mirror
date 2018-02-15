Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39EE1F576
	for <e@80x24.org>; Thu, 15 Feb 2018 10:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755304AbeBOKL1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 05:11:27 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:40539 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeBOKL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 05:11:26 -0500
Received: by mail-wr0-f171.google.com with SMTP id o76so2741600wrb.7
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 02:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4Hv+ZVrdgfnX9dnXvDWhNkTje+wCZW9b4PQfWcs6l60=;
        b=keMbaGnBvrHsPpPBlyTyaZiTmLeKPcVJN4T4CKlFqMRX/bBZ6rVDcVfbSauQrYHCY7
         IQPxtOrDVd4jANQwnYBh+ipQU9KYqItw9+5kRH5VFrXbU4B0jXXOMaK1UyNywkwy3Jtd
         boLGvIcLnd4Tc1YO8ePQrfx4TlSv5U6D4iIuh7iG+GlqZiV3W6OmiEVpDg9zykvxA5j4
         hWxPR/Z9HmT2oPneSYB5lAnZflNJ2m5rTmSP6mqcBCtj7aTfP1NXJsxclpXAyXWuKZwB
         gvdlWbvZT4sLDn3E0sra1O+ba/Ev7xmc+2vahy5a/27trxmMo3X5Ef93fqC6Wt/myeJi
         dduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4Hv+ZVrdgfnX9dnXvDWhNkTje+wCZW9b4PQfWcs6l60=;
        b=q1y/cx1Ni/nm7bAZrJo3qDaJdsT2lnxAifTx7ZL2RCycs8ayXkIpY8bv36NKUEaVgQ
         tEkCiCljFfsevMOtm3PtMFCkA8lpue8p0fqQeUf9R/rHMzBrLMy/lps8UwfEk/BwAQf7
         UzHSqbUhSrfGEjTEOwHRITAvaG0utr3eD0YxG9PC+HtVFILmIABQtMIKfSPQiTWWc8E6
         U86MK6MdHK3cj2Q28pUb2E8WuuDMSgHutTCfxcvFqMCe6DOGZEl3+K8xICSO2uC2hoQx
         S0h7g78R0wfnMI5gH7pWldvJCqSeAPqsAObT4H8ltkC/5AyJ9FS4icPA5svYc2iMyimr
         yoVQ==
X-Gm-Message-State: APf1xPBQrRnMkCLjkRSPI1ON+H1r2Io3PFOUMoiGW+z+4534JQnY9arw
        vAPntjZYgYliaxlwaT80e+PjM6AFbX/EMwbkyr8=
X-Google-Smtp-Source: AH8x224tnw7uumb0fkG98PBA9e8XWkSvadBtPhl1udYGUhyKHbgkO7rQgJt9bnN0PsSM1TPeYlTXVrtz0rS8MYol3y4=
X-Received: by 10.223.176.201 with SMTP id j9mr2128013wra.210.1518689484878;
 Thu, 15 Feb 2018 02:11:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Thu, 15 Feb 2018 02:11:24 -0800 (PST)
In-Reply-To: <20180215053714.GH18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f434b-3f93f5b7-0fad-4777-ab9b-79c48b2b41d2-000000@eu-west-1.amazonses.com>
 <20180215053714.GH18780@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 15 Feb 2018 13:11:24 +0300
Message-ID: <CAL21Bm=fJxWN9266PXni_SZn=T0t6_jT1kJMtPYo4UA41pj_ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/23] ref-filter: reuse parse_ref_filter_atom()
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-15 8:37 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
>
>> Continue migrating formatting logic from cat-file to ref-filter.
>> Reuse parse_ref_filter_atom() for unifying all processes in ref-filter
>> and further removing of mark_atom_in_object_info().
>
> OK, now it looks we're moving in a good direction.
>
> One thing that puzzles me:
>
>> @@ -401,20 +420,14 @@ static int is_atom(const char *atom, const char *s, int slen)
>>  static void mark_atom_in_object_info(const char *atom, int len,
>>                                   struct expand_data *data)
>>  {
>> -     if (is_atom("objectname", atom, len))
>> -             ; /* do nothing */
>> -     else if (is_atom("objecttype", atom, len))
>> +     if (is_atom("objecttype", atom, len))
>>               data->info.typep = &data->type;
>>       else if (is_atom("objectsize", atom, len))
>>               data->info.sizep = &data->size;
>> -     else if (is_atom("objectsize:disk", atom, len))
>> -             data->info.disk_sizep = &data->disk_size;
>>       else if (is_atom("rest", atom, len))
>>               data->split_on_whitespace = 1;
>>       else if (is_atom("deltabase", atom, len))
>>               data->info.delta_base_sha1 = data->delta_base_oid.hash;
>> -     else
>> -             die("unknown format element: %.*s", len, atom);
>>  }
>
> Why do some of these atoms go away and not others?

I deleted "objectname" because we were doing nothing there;
"objectsize:disk" because we have its own parser function;
"die" because ref-filter has its own checker whether the atom is valid or not.
I left all others because I haven't supported them at that point. This
whole function will be removed later.

> It seems like we're
> now relying on ref-filter to parse some of the common ones using its
> existing atom-parser. But wouldn't it have objecttype and objectsize
> already, then?

We haven't migrated enough to ref-filter at this point and we can't
reuse general ref-filter logic about filling the fields. So, we still
need to have our own function for doing that. Anyway, as I said
earlier, we will reach that status in the end of the patch: this
function would be deleted and we will use general ref-filter logic.

>
> -Peff
