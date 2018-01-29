Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DF61F576
	for <e@80x24.org>; Mon, 29 Jan 2018 07:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeA2H0W (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 02:26:22 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:45884 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbeA2H0W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 02:26:22 -0500
Received: by mail-qt0-f180.google.com with SMTP id x27so11464851qtm.12
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 23:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ScW8gtzcKBfJYVxeCwQ0+w5kpF1EN+zZAgPdr3uSBxA=;
        b=SNZtgmqJd87aSyPIjmHZSLCMOr/+KPew+K1OGrU9+WH3u5ceMs3N3uWg6reiJNpkEw
         3AGO8OHJWTAuAi8UOWRSQtETau6g7G6w4YQV9Tfl1819z4Pwe3suZJclCx42c26akQ3P
         kMy9enIVXKaANNUaiFMIJzDnKqZjVw3nK9cnOoy7IGefuhKmlMWYxnqJsnUEO57XDsTi
         19lazLMFaLUr8jUj4q4bQEHh9fu+G6BNgbn5JxLEXeHbSjPqfHtmcp+VAxelhxG6sSCq
         E26SS5zilGw+5cKVmN0jupXcVCgxitlPN3bn1xyeriIgpdttLfR7on5pGnVa/bzZqKIo
         wTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ScW8gtzcKBfJYVxeCwQ0+w5kpF1EN+zZAgPdr3uSBxA=;
        b=pCscOCbqXu9YTQ8iFPDVemOJ/+LvLo3694zop1KwZ0oo+CzzYfth8mYOnu3y0pKtd/
         ZgMO2I8lsXt6hOaNDGxwXn3AC5B99MD4PuyXoH9uJolWneSHaoNqET7KV5Vi4XHr83gG
         rlQoxrVlTO1u1m5Xlvpo5hHzOuXZgmD2dFqClXq0K2A9ufDUJd6d1V8czhLtpRaC1sBW
         ncxrywkFez2jwdKooBaXugmJdM5z3OOvXpwjPgI9xpqRGfbLdRioEtwDMt7C/PWSuKrd
         /m4YVoYRwsqra3CTx+Enw2ZSh8zFk4MBv9eCqq6NwPGCfxfqereqWUMjV06LmOsE+ksP
         Oqrg==
X-Gm-Message-State: AKwxytd/Xy4yJlwx/lh0UUoSyB9NH2vnMwAp49poZC9b0SH0hscNy5st
        u7ur/YXagmhDenkj+Ds6Z8ODEYsE+jFzKChmvvI=
X-Google-Smtp-Source: AH8x226NIhYq7e4zOH/6dFsc1Isvzp0bVUlYU0uqLuN4xfdxxPekcrYBtOpy3l2JLKHXwLaemkx/C4Us7MgaV1cW8MU=
X-Received: by 10.200.64.90 with SMTP id j26mr38919280qtl.29.1517210781245;
 Sun, 28 Jan 2018 23:26:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.54 with HTTP; Sun, 28 Jan 2018 23:26:20 -0800 (PST)
In-Reply-To: <xmqqvafo5m5h.fsf@gitster.mtv.corp.google.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
 <0102016133ff3afb-6bab2c11-e0f3-4bef-9626-fbcc826bcb15-000000@eu-west-1.amazonses.com>
 <xmqqvafo5m5h.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 29 Jan 2018 10:26:20 +0300
Message-ID: <CAL21BmmAq+FRx2F8eiQj+jHhR-Y=Vdr26hC5T1F_9Ga8TyWJPQ@mail.gmail.com>
Subject: Re: [PATCH RFC 03/24] cat-file: split expand_atom into 2 functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-27 0:46 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
>
>> Split expand_atom function into 2 different functions,
>> expand_atom_into_fields prepares variable for further filling,
>> (new) expand_atom creates resulting string.
>> Need that for further reusing of formatting logic from ref-filter.
>>
>> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored by: Jeff King <peff@peff.net>
>> ---
>>  builtin/cat-file.c | 73 +++++++++++++++++++++++++++++-------------------------
>>  1 file changed, 39 insertions(+), 34 deletions(-)
>
> As expand_atom() is file-scope static and its callers are well
> isolated, it is OK to change its meaning while restructuring the
> code like this patch does (as opposed to a public function to which
> new callers may be added on other topics in flight).
>
> The split itself looks sensible, but expand_atom_into_fields() is a
> questionable name.  expand_atom() does fill the data in sb, but
> calling expand_atom_into_fields() does not fill any data into
> separated fields---it merely prepares somebody else to do so.
>
> Helped by this comment:
>
>         /*
>          * If mark_query is true, we do not expand anything, but rather
>          * just mark the object_info with items we wish to query.
>          */
>         int mark_query;
>
> we can guess that a better name would mention or hint "object_info",
> "query" and probably "prepare" (because we would do so before
> actually querying).

OK, I will rename that function. Actually, not sure that we really
need to have ideal name here because both functions will be deleted by
the end of this patch.
"mark_atom_in_object_info"?

>
> I am not sure if separating the logic into these two functions is a
> good way to organize things.  When a new %(atom) is introduced, it
> is more likely that a programmer adds it to one but forgets to make
> a matching change to the other, no?  (here, "I am not sure" is just
> that.  It is very different from "I am sure this is wrong").

In the end of the patch we don't have both of those functions, so
there would not be such problem.
But, I need that split, it helps me to go further and apply new
changes step-by-step.

>
> Thanks.
