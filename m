Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085581F576
	for <e@80x24.org>; Mon, 29 Jan 2018 07:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeA2Hgd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 02:36:33 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33569 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeA2Hgc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 02:36:32 -0500
Received: by mail-qk0-f170.google.com with SMTP id i141so4367497qke.0
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 23:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xkTI57sSxVtqh+31/XnvrxyyZVm6z3Bj9YbfG8Pfs+c=;
        b=Kf2urDjkfUAEqcDciSoGaKHs23O9DiJcK/0johT15F0G56SYq3Loe+hR5dUF0ieoaf
         6cklq0WjEGjdfxE4ZkkwnbcBc8MxIq5vxv1Sd9b65LcMmhBqjpORRDhOH5R+4P+IEVre
         50TC2zsKtSW7XECtblzZ927PrVGhQYFjelxHCjTl5BX4hba1IQojQcqRN7l8pcyGfAPE
         g6KgePIqD3KdRL3KcM1Mdgn6xSBbiVyzIChKUx3h7fcWvyIwQTD8KRoaySu10tZH5cZZ
         eTcw+e6hgNrErpbershz3evbvn3qrn2sGgjwrW3wbei19oUEjVSh7DqMmWj6SBwAsKeX
         Ef1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xkTI57sSxVtqh+31/XnvrxyyZVm6z3Bj9YbfG8Pfs+c=;
        b=Q+6VAG2l7RwVQSZh/+/nG37h4EB1WswTvmAnlxWXqEeANQGjm6asNtb5mQ7MBDZBzf
         YraYsaDxVMBEmR5/z4VgAr1020YINnVj6J2eA1B7FszYMgnI3/6NFiBpTruV2t/RLMqZ
         riIAndN+fBMiINmfPQ/uUdoCsa2NuGVYmWBUpFmRajhVXjoMN7aSWFcF3jqs9Ge/rc/O
         Zdhrwbj//lbDcR0foWoPPpG8ueivYHPZnIvVCPs2IgTkrA13+zWlB6cFwktjDymzZKhv
         OXTIHBUjbFoLrnEAPcxUktG0GtXE8eTe7xUb5gASLIduWKtaJnTzK5LvjIsmqKkm6X3y
         KAFA==
X-Gm-Message-State: AKwxytejiGdEKRWUSiO0+OdD5bv1bRddRo6VrUH4VhhBOTI/8lezAa1M
        2m0AoExs5ShP6QUP6VTuCs8R03dV67lOpD4an1o=
X-Google-Smtp-Source: AH8x226IjvwHXFI0Dlkl0UDZCWKNUw4MJrmQXJnJsubfMBcD7yjU7RaO9k/UQShVSUCg+2UDiiuqJMJIyvGCVrB38TQ=
X-Received: by 10.55.6.19 with SMTP id 19mr32061079qkg.132.1517211391717; Sun,
 28 Jan 2018 23:36:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.54 with HTTP; Sun, 28 Jan 2018 23:36:31 -0800 (PST)
In-Reply-To: <xmqq1sic72ku.fsf@gitster.mtv.corp.google.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
 <0102016133ff3ad8-abf99952-4df0-42a4-9ae9-06f602e84f3b-000000@eu-west-1.amazonses.com>
 <xmqq1sic72ku.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 29 Jan 2018 10:36:31 +0300
Message-ID: <CAL21BmmWvrUjH3WESeMq45=ByhQ1cZhmZetUM6C2H7mGuFp84Q@mail.gmail.com>
Subject: Re: [PATCH RFC 02/24] ref-filter: add return value to some functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-27 0:05 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
>
>> Add return flag to format_ref_array_item, show_ref_array_item,
>> get_ref_array_info and populate_value for further using.
>> Need it to handle situations when item is broken but we can not invoke
>> die() because we are in batch mode and all items need to be processed.
>>
>> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored by: Jeff King <peff@peff.net>
>> ---
>>  ref-filter.c | 21 +++++++++++++--------
>>  ref-filter.h |  4 ++--
>>  2 files changed, 15 insertions(+), 10 deletions(-)
>
> Makes sense as a preparatory step to pass the return status
> throughout the call chain.  The functions that actually will detect
> issues should probably gain
>
>         /*
>          * a comment before the function
>          * that documents what it does and what values it returns
>          * to signal the failure.
>          */
>
> before them; those that only pass the errorcode through to the
> caller do not necessarily have to, though.

I will add comments, agree, thank you.

>
>> -void show_ref_array_item(struct ref_array_item *info,
>> +int show_ref_array_item(struct ref_array_item *info,
>>                        const struct ref_format *format)
>>  {
>>       struct strbuf final_buf = STRBUF_INIT;
>> +     int retval = format_ref_array_item(info, format, &final_buf);
>>
>> -     format_ref_array_item(info, format, &final_buf);
>>       fwrite(final_buf.buf, 1, final_buf.len, stdout);
>>       strbuf_release(&final_buf);
>> -     putchar('\n');
>> +     if (!retval)
>> +             putchar('\n');
>> +     return retval;
>
> This is questionable.  Why does it write final_buf out regardless of
> the return value, even though it refrains from writing terminating LF
> upon non-zero return from the same function that prepared final_buf?
>
> "Because final_buf is left unmodified when formatter returns an
> error, and calling fwrite on an empty buffer ends up being a no-op"
> is a wrong answer---it relies on having too intimate knowledge on
> how the callee happens to work currently.

I will change that piece of code by putting fwrite into if statement
also, thank you. We really do not put anything to buffer if retval is
not equal to zero (checked that).

Thank you for all your comments, waiting for further review.
Olga
