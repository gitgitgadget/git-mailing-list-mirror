Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39BA1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 05:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbeBVFfH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 00:35:07 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55389 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeBVFfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 00:35:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id q83so1503647wme.5
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 21:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k4K14+TZA8HnNpHP1e7h7LBU4CH7GCgRsxrWPO2KBRQ=;
        b=ETfH2TlQw7TmVLZFsUX8bj4cx04J4YkjpVydSfakASvuGsE4ZWVdOBn5MsiuSzSEVZ
         xqp9DJpws5YZ4Y7HccoViL5aeC2IF1Ikpkb9pSL0HuAfOJz8DW48M6eHcjtR/0d6SNJ2
         acOg4wgkZwuodYus7S0GHM5somQKWqpDks8ECP3BTqkmWw1fiYW9y8QOOVxkyRGdXkrg
         pfX4zYNUzgQ89fqzqAZ04VHQX1f7z+/U4uagXK+qAU/PI5fDWRTIu/uq8w5NO4poggOG
         b8V5Rc9kYaDXtnMt12RIri2F5+QaX5xq6DX5dbxo351R9mTZl3LAj2C0XZ9olacCMZ4e
         QwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k4K14+TZA8HnNpHP1e7h7LBU4CH7GCgRsxrWPO2KBRQ=;
        b=XziF5ivNE00pI1hZ3yEprcUHTHkStYB233MB5IKrtHiBYMpaQ6zTwcZ+44SZaZPSiG
         DyH/zEg/jYlS7HtvXOKFPdP8X2pHeedIlNHYhARtDTxg6zGMZmpbeUFnO61zVUC3C/A3
         /Lw09hYCrV92jShAX41NXzRfwyw/V31iONEdxS0Y7ASisha6q4O6Ka7ndyzmDARKvBK9
         9V+nBxgDaTw/o7Knt6lZjxfhcw6r2wbye02L712+nsotAViVVHkvpF3+m3MLIMattDdR
         QwqLUqQH1LdIO4+25GK9tuGZVG8lyZuf9VSh+NTkzRADjLLWf813CBs3WEYkUk+63sLX
         kLug==
X-Gm-Message-State: APf1xPBjzNwpUHkhrd3kKavE/EWUdLQDevDe127MizuXCEwvh7RGVEMG
        GjaxWXkD0x3/xcPaDmrNpfvmVunGScPCD0szPglBPA==
X-Google-Smtp-Source: AH8x227mEYNPtdTYGSF0wO9mIhhtqY3vcRsJsAaWvTRdpFLIPzhfRMKq2/X3ggR468abwV5t3NIPAeD2gFBQnF7D2lk=
X-Received: by 10.28.112.15 with SMTP id l15mr3963579wmc.119.1519277704927;
 Wed, 21 Feb 2018 21:35:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.197.147 with HTTP; Wed, 21 Feb 2018 21:35:04 -0800 (PST)
In-Reply-To: <xmqqpo4yz1cw.fsf@gitster-ct.c.googlers.com>
References: <01020161b728823f-daec904e-44ff-45f9-9c89-d447b89c7802-000000@eu-west-1.amazonses.com>
 <01020161b7288324-d478f224-7a37-4341-993f-3c82a9941b7f-000000@eu-west-1.amazonses.com>
 <xmqqpo4yz1cw.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 22 Feb 2018 08:35:04 +0300
Message-ID: <CAL21Bm=FptUV3xRnYf-iiht8HQF+-uF=cOZyybh7VNCmP=Nxbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: get rid of goto
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-21 20:41 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
>
>> Get rid of goto command in ref-filter for better readability.
>>
>> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored by: Jeff King <peff@peff.net>
>> ---
>>  ref-filter.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> It looks like this is the same change as the bottom-most change on
> your "cat-file --batch" series (and is obviously correct).
>
> I am puzzled by your intention---are you re-organizing and rebooting
> the series?  Either 'Yes' or 'No' is an acceptable answer, and so is
> anything else.  I just want to know what you want to happen to the
> merge conflicts if I queued this while still keeping your "cat-file
> --batch" thing I have on 'pu').

Thanks for the question, I needed to mention that.
We (with Peff) decided that it's better and easier to remake whole
previous patch. Before that, I want to make some refactorings in
ref-filter so after that migrating should go much easier. I want to do
that by small separate patches, so this is first in the series. I hope
it would be both easier to review for you and easier to fix for me.
So, if everything is fine, you could merge it to master. I will
rewrite most parts of previous patch anyway.

Thanks!

>
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 83ffd84affe52..28df6e21fb996 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1494,11 +1494,11 @@ static void populate_value(struct ref_array_item *ref)
>>       for (i = 0; i < used_atom_cnt; i++) {
>>               struct atom_value *v = &ref->value[i];
>>               if (v->s == NULL)
>> -                     goto need_obj;
>> +                     break;
>>       }
>> -     return;
>> +     if (used_atom_cnt <= i)
>> +             return;
>>
>> - need_obj:
>>       get_object(ref, &ref->objectname, 0, &obj);
>>
>>       /*
>>
>> --
>> https://github.com/git/git/pull/460
