Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17FAA1F42D
	for <e@80x24.org>; Mon, 28 May 2018 16:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933689AbeE1Qov (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 12:44:51 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38480 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940301AbeE1Qoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 12:44:46 -0400
Received: by mail-qk0-f196.google.com with SMTP id c23-v6so9516631qkb.5
        for <git@vger.kernel.org>; Mon, 28 May 2018 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PzvV+Z3czwidONhB3g6ziQ7a6zIzrozFZbrb2UIpt8g=;
        b=NAtLU2qCm0oSFPT5Frt2haa8OV4klEk1R92ydGo/RY0ak63AHnmH4hE7lZGHL1Rd0m
         /9OsijT7byv5fsvTB0aQN7Ry41MrXNcGjwkTy8Yn4g0Msxu9rBhXcDSZJlXDuMTvsZRY
         uIyJVBXxgoqG/ctPgztZTn+tzOQ45/y++2eYfW6upQBQnWKXbMco9COAFow/fiKqtcq2
         DO0nUkuuRhBKYTEvlCueDXMsbgXsQLUtMwmX93bTMcdXtZSxzWWUZ9XBUwAIT1kJIYFt
         ziH0DImHHx0IZWh3FD5GchtolZYesU5vswmAIHQ76gyCVo1yyt6WwcaqtERP0iNSo16O
         5dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PzvV+Z3czwidONhB3g6ziQ7a6zIzrozFZbrb2UIpt8g=;
        b=T0DgCKf5gc4sbS1fANzIiJ0jpsoxTaYIQ2LmkBdzqyKAadZ1ncOZ1Tzv81vP6gb9cF
         leRNbs2fr9RvFbZvZ7jiFP+uQYVcjb2HatZzP6R4s3UIphLs5KTToGTu0fIhKHkg9HcL
         FTxIyph6l71+VQWKbKzrnlfaA2iX8LOgSJ52UW8wwGcPDgm+WiPBdv0lBYTvjOoidgKF
         Yh7fkJKTg1qZvLzgw77M5aIq0z4WNbbR7uWxtc5hoN4oqGrugF/bUXo4/g28/4jBfb/d
         AgVYY5vL1+LMEq5+uZTokR7T3k1F2kOufr1U9K7lba7ah7kUhDDUlfSGjipCtLGcjNmg
         ckPA==
X-Gm-Message-State: ALKqPweXkmUTk71zM4GQM7OoQtHhAbtZdfJhZ3VQzcNCR0FQIXOOnVTd
        h+Jf7nNDi9OQ7Qc3qIKweQy1FQ5nKincBxDyhZw=
X-Google-Smtp-Source: ADUXVKJi6X3NxHMv3hBC4+mM+iAY8iGuQQrKw9GqMaLTl5zj70y1r0bYIUq6xSgQ6GtHt0SgVFN4YnmS33N0JtF7cMM=
X-Received: by 2002:a37:be42:: with SMTP id o63-v6mr12092129qkf.102.1527525886183;
 Mon, 28 May 2018 09:44:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:6718:0:0:0:0:0 with HTTP; Mon, 28 May 2018 09:44:25
 -0700 (PDT)
In-Reply-To: <xmqqa7skjep9.fsf@gitster-ct.c.googlers.com>
References: <20180524193516.28713-1-avarab@gmail.com> <20180525192811.25680-1-avarab@gmail.com>
 <20180525192811.25680-3-avarab@gmail.com> <CAPig+cT=i0XYOrMymNjsBJqcLfJ38Ft_=MZPZD3N-AMo8raAHQ@mail.gmail.com>
 <xmqqa7skjep9.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 28 May 2018 18:44:25 +0200
Message-ID: <CACBZZX5mSj2=JXtVPrPZ8Y1gCyu9p+EMYoSPeFZtuvm3FsdLNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] config doc: unify the description of fsck.* and receive.fsck.*
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 11:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> @@ -1554,23 +1554,42 @@ filter.<driver>.smudge::
>>> +Depending on the circumstances it might be better to use
>>> +`fsck.skipList` instead to explicitly whitelist those objects that
>>> +have issues, otherwise new occurrences of the same issue will be
>
> I had to read the "instead to ..." part three times before
> convincing myself that this is a good description, and I agree with
> the assessment.  Perhaps we would want to make the recommendation a
> bit stronger, even.
>
>         In general, it is better to enumerate existing objects with
>         problems with skipList, instead of listing the kind of
>         breakages these problematic objects share to be ignored, as
>         doing the latter will allow new instances of the same
>         breakages go unnoticed.
>
> If the project has some tool constraints and have to accept new
> "broken" objects on ongoing basis, then fsck.<msg-id> facility may
> make sense, but that is probably a very narrow special use case.

That makes sense. I'll reword this bit.

>>> +hidden going forward, although that's unlikely to happen in practice
>>> +unless someone is being deliberately malicious.
>>
>> Is it worth mentioning buggy tools and/or other buggy Git
>> implementations as sources?
>
> Or old Git implementations we ourselves shipped.  I do not think it
> is worth mentioning it, but I do agree that "unless somebody is
> being deliberatly malicious" is misleading, if that is what you are
> getting at.  One use of fsck is about noticing that you are under
> attack, so "unless someone is being malicious" there in the sentence
> does not make sense.  When somebody is attacking you, you do not
> want to use fsck.<msg-id> to ignore it.
>
> But that becomes a moot point, if we were to follow the line of
> rewrite I suggested above.

I'll try to clarify this, but I think we really should have some bit
there about historical tools. Realistically no new git tools produce
these, so the user needs to be made aware of what the trade-off of
turning these on is.

The reality of that is that these objects are exceedingly rare, and
mostly found in various old repositories. Something like that need to
be mentioned so the user can weigh the trade-off of turning this on.
