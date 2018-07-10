Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37BED1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 07:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeGJHvn (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 03:51:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35357 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeGJHvm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 03:51:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so4254480wrt.2
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FEgphCmzvz9DHdeSLzTF9i/r4gravz8ADMV8607MpVI=;
        b=XALwqO/xQ5OdVA3QEGdC78dgkpidFtreqn0knfTbVIMLat8m6aHE8bZbj6UC5Wkm62
         IZbX3jTlAsUH+AQbKHenG5Jq28a1U6NlsBCDoZcSaMcdcTQxsv6GY4wruQn6Odj7OSJB
         4bQc37uBQUDE8qzQX+LOIvcI6oCbuAKA8dWiCwd38gzRNk+0Y7tFPEb5nOmUbAGkWJ6o
         ovAG0c+avxwGp2jzVVkyzQlsoBYx6eYNxHH7j/xdMpD4TlZbjmYy2goifiWNVCwki7Yr
         QkRx+ut5RpCY1CJlHFPmkrB90qrSxoSxtrQCc73dFdfe4dV5V/Lr8M3cDiVRRjOzTaor
         PLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FEgphCmzvz9DHdeSLzTF9i/r4gravz8ADMV8607MpVI=;
        b=mq5NZ73C/TrUaZlVFJbHcJXJr3y22tFQ/zWWX6CnuuqnkBSwvgzu+1WYSdj3pTxkvy
         xFpjfKbrshvNH1jymT95DWtskByA/8zmil30Mo5rCxikzkWJ4huD1zcxyurwZDGjGhSH
         Fy3stf0o5MHteZDApWNgR7LPEeBktxeyyv9kAZDuC7Qip4s1BhvOJop3KqYOLV7LU6mX
         2ZDz28vP2czxJbxbvnqkhkyIhvxEADdqjTXSWDOBpL54rdltT9D+aeMm16FWmgOsqyFB
         zssP9kFfhQu0kiBxy2iUanXZ0sk24QV3F2V/6/oSV0cBgESBQ0YCSkV9lGUBCiaonNfI
         DQ+g==
X-Gm-Message-State: APt69E2s5JfINhQTdrWaSyAF/jCXkhNLU1ryP31znCSODWAare56OP8E
        u5nFxjGtbcCPXVPICG4a7I2rRM+L74iHZPtP/ao=
X-Google-Smtp-Source: AAOMgpc6XENw0xZ3/bibuSiR/7haIqIUuZPG4H9E4RdVYEloGnGWhODBniYTrWNIL0dtydA3DvRw6lxHAPnQfUIkRdc=
X-Received: by 2002:adf:a9f0:: with SMTP id b103-v6mr16246661wrd.271.1531209100867;
 Tue, 10 Jul 2018 00:51:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e9c6:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 00:51:40
 -0700 (PDT)
In-Reply-To: <xmqqzhz09gqj.fsf@gitster-ct.c.googlers.com>
References: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com>
 <010201647e19c191-8c24e128-8822-4c77-b3bf-60fe17ecb62b-000000@eu-west-1.amazonses.com>
 <xmqqzhz09gqj.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 10 Jul 2018 10:51:40 +0300
Message-ID: <CAL21Bm=jHiwcau=KoX5cmnZ+8NwQi5ms=GqK52s6GWdaXddraA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ref-filter: add empty values to technical fields
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-07-10 1:39 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
>
>> Atoms like "align" or "end" do not have string representation.
>> Earlier we had to go and parse whole object with a hope that we
>> could fill their string representations. It's easier to fill them
>> with an empty string before we start to work with whole object.
>>
>> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
>> ---
>
> Just being curious, but is there any meaningful relationship between
> what was labelled as SOURCE_NONE in the previous step and what this
> step calls "technical fields"?  Things like "upstream" (which is not
> affected by the contents of the object, but is affected by the ref
> in question) and "if" (which merely exists to construct the language
> syntax) would fall into quite different category, so one might be
> subset/superset of the other, but I am wondering if we can take
> advantage of more table-driven approach taken by the previous step.

Sorry that it was not clear enough.
SOURCE_NONE fields are the fields that do not require object info.
By "technical fields" in this particular commit I mean fields that
will never be filled. So, it's a good idea to fill such fields with an
empty string and do not take them into account later (when we are
thinking whether we need to get and parse an object or not). I guess
we do not need to mark these "technical fields" in a special way: we
don't need this information. Moreover, some of the fields that I
filled with an empty string here, sometimes have non-empty
representation, and I changed nothing for such cases.

>
>
>>  ref-filter.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 8611c24fd57d1..27733ef013bed 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1497,6 +1497,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>>                       refname = get_symref(atom, ref);
>>               else if (starts_with(name, "upstream")) {
>>                       const char *branch_name;
>> +                     v->s = "";
>>                       /* only local branches may have an upstream */
>>                       if (!skip_prefix(ref->refname, "refs/heads/",
>>                                        &branch_name))
>> @@ -1509,6 +1510,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>>                       continue;
>>               } else if (atom->u.remote_ref.push) {
>>                       const char *branch_name;
>> +                     v->s = "";
>>                       if (!skip_prefix(ref->refname, "refs/heads/",
>>                                        &branch_name))
>>                               continue;
>> @@ -1549,22 +1551,26 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>>                       continue;
>>               } else if (starts_with(name, "align")) {
>>                       v->handler = align_atom_handler;
>> +                     v->s = "";
>>                       continue;
>>               } else if (!strcmp(name, "end")) {
>>                       v->handler = end_atom_handler;
>> +                     v->s = "";
>>                       continue;
>>               } else if (starts_with(name, "if")) {
>>                       const char *s;
>> -
>> +                     v->s = "";
>>                       if (skip_prefix(name, "if:", &s))
>>                               v->s = xstrdup(s);
>>                       v->handler = if_atom_handler;
>>                       continue;
>>               } else if (!strcmp(name, "then")) {
>>                       v->handler = then_atom_handler;
>> +                     v->s = "";
>>                       continue;
>>               } else if (!strcmp(name, "else")) {
>>                       v->handler = else_atom_handler;
>> +                     v->s = "";
>>                       continue;
>>               } else
>>                       continue;
>>
>> --
>> https://github.com/git/git/pull/520
