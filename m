Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E5E1F576
	for <e@80x24.org>; Mon, 29 Jan 2018 07:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeA2HNr (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 02:13:47 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:32924 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeA2HNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 02:13:46 -0500
Received: by mail-qt0-f171.google.com with SMTP id d8so11495647qtm.0
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 23:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rulLVNN8bNYQNdVrmhwMpCgju2+goAsKwSisGne5PVk=;
        b=c0Oj28Lzd5GP0j0JLP+GJhcGRyCi/RSIU/NMxdkvigL8nHjbR7jHVe0RFpA7rWcVua
         pkhEgLZK5T8jAUsNkpdXS8CCvj7FVRXTRZOkO2pm4h4uS2aa3C4JhTNF9HXRYkG7QSzl
         AdlCzLbyk7Dzh3r75UD/7OkzR2fs3Lpu4b57EptTga+szfiwRUBLEomIZKoK2pITXVtc
         LX8b54O5cr0zbq63Fsv+TGJvVxcyPvNHf34qfou3EjIoRjCT+X02CtI8CWYSqKAU9Npe
         yEIRp8V9qcjel0ECe7vn/zJrvb4PKsCNaxwXCduSMnp1HWSDyCKSX1CR8/jaq7zu2GVf
         b34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rulLVNN8bNYQNdVrmhwMpCgju2+goAsKwSisGne5PVk=;
        b=rEgJei3MkImaA2TvlSWKgWPvli8u25EpH7Kumy18KVBGyxafECjLibAgkklivbGy2I
         TpyQ6tGtaaDkGegf9JJNb/yqu8LgGhBo/idfUMREbM3+JMebuUTzpBN2EIQoSAcy++rM
         el1Vi7+VCvZSXO1WCwWx65i5S+QA+/P6wGnvXE+V8bT2NkEqxpZNdlEfS0XKJ+GThcyz
         jlGLYXVJSqYzTyGhz8HAlLRsTS9R5yxDxqX/Lwa28KZbaLkQqjJuAjM289q77picRhmo
         6SpGQrkz0/pUoZt2n8sTlsX57QPZVfWPqQVlCcmU34llYlP11P4QDbt8xjIe0EAO7VsN
         KaNg==
X-Gm-Message-State: AKwxytdTXKR2XnDXlxeqz9Vq1IBgUlv/aaeEMUfVmco1zh0n7MqAaqgJ
        YfD/UZ9a2niAifgyezKCv43VXAzxsqFy5iCmsf8=
X-Google-Smtp-Source: AH8x224laMvH0wWPHBOkL3S7sQiShuxnj4RmZhR9q9cAvk7R0yHKwjs39fBGfwA1zma+m1dKEPryFgIJJpy+FXjnXxE=
X-Received: by 10.200.64.90 with SMTP id j26mr38872659qtl.29.1517210025617;
 Sun, 28 Jan 2018 23:13:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.54 with HTTP; Sun, 28 Jan 2018 23:13:45 -0800 (PST)
In-Reply-To: <xmqqfu6s74pf.fsf@gitster.mtv.corp.google.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
 <xmqqfu6s74pf.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 29 Jan 2018 10:13:45 +0300
Message-ID: <CAL21BmkOGE6UZQJTFQjq3qnmywwBJQOUXE7jSwP1_Vn6PZ8ezA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/24] ref-filter: get rid of goto
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-26 23:19 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
>
>> Get rid of goto command in ref-filter for better readability.
>>
>> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored by: Jeff King <peff@peff.net>
>> ---
>
> How was this patch "mentored by" these two folks?  Have they already
> reviewed and gave you OK, or are you asking them to also help reviewing
> with this message?  Mostly just being curious.

Christian and Jeff help me when I have different sort of difficulties.
Not sure that they were helping me with that commit separately.
Both of them reviewed my code and said that it's ready for a final
review (actually, Christian said, but it's usual situation when I ask
for help/review and one of them helps me. The other one could add
something, but, as I understand, if he totally agree, he will keep
silence, and I find that behavior logical).
Do I need to delete these lines from some of commits where I do not
remember help from them?

>
> It is not convincning that this splitting the last part of a single
> function into a separate helper function that is called from only
> one place improves readability.  If better readability is the
> purpose, I would even say
>
>          for (i = 0; i < used_atom_cnt; i++) {
>                 if (...)
> -                       goto need_obj;
> +                       break;
>         }
> -       return;
> +       if (used_atom_cnt <= i)
>                 return;
>
> -need_obj:
>
> would make the result easier to follow with a much less impact.

It's hard for me to read the code with goto, and as I know, it's not
only my problem, it's usual situation to try to get rid of gotos. I
always need to re-check whether we use that piece of code somewhere
else or not, and how we do that. I also think that it's good that most
of variables in the beginning of the function populate_value go to new
function.

>
> If we later in the series will use this new helper function from
> other places, it certainly makes sense to create a new helper like
> this patch does, but then "get rid of goto for readability" is not
> the justification for such a change.

We don't use that new function anywhere else further. So, I can delete
this commit or I can change commit message (if so, please give me some
ideas what I need to mention there).

>
>>  ref-filter.c | 103 ++++++++++++++++++++++++++++++-----------------------------
>>  1 file changed, 53 insertions(+), 50 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index f9e25aea7a97e..37337b57aacf4 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1354,16 +1354,60 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
>>       return show_ref(&atom->u.refname, ref->refname);
>>  }
>>
>> +static void need_object(struct ref_array_item *ref) {
>
> Style.  The opening brace at the beginning of the function sits on
> its own line alone.

Thanks, I will fix that when we decide how to finally improve that commit.

Olga
