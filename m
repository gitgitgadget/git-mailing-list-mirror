Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928681F404
	for <e@80x24.org>; Wed, 14 Mar 2018 13:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeCNNaH (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 09:30:07 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:45104 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeCNNaG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 09:30:06 -0400
Received: by mail-wr0-f169.google.com with SMTP id h2so4711107wre.12
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gU1xp3pVC8dA9yJqUuwoeH2+yqiW8uz8SilzHPy+9t0=;
        b=Nvjh3ZHGLkKolPG9beyTlJc/WdBEaWHNwtSD+6FZPdrimyZzc82U+8u+j/fMJ5rnCv
         jH3c98OwbG1QP1MHz6poOUAecTYaZvFbXJIKOsMZg3A4veycq2T44YYMQrp7IxxCRc2C
         //56qdvUr7QUbouhsX6mHdY4j1AJH2oepFTeiazLOXXdJG+/FmPLkjbtLnIS0xi718yJ
         Z4TabPc4rGRk8HFiIxuR49BihaSt03FDHzi8gT8f/8V+XkV61iAl90E7UJiWrD4PADy1
         cWqOANHRtLexW9YbD0shAr/9MGIrulDm5rn7UOtQLL4qnAmJ1i6Goct+oYLcIQY9L+kz
         2hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gU1xp3pVC8dA9yJqUuwoeH2+yqiW8uz8SilzHPy+9t0=;
        b=cmfNFsmf+93vQvccCO0lESZw2tfNHiZHXMCLErT+yENMalBcTaBriJ/B7kmZuQoKCV
         C/sZmBogkXT+AivqTTz/s8nugpYuG2R3BUmmRMB/FkyQ6rNXePCdS5r47QTIoGqlyieN
         hD8poggF7xbcAsbkbPLuZ/ynVMDVaqA2asKFO5gvQI93mn7ny9pt/AQ8uLwPnQGUiDbE
         mwL+kAfSuMsjv/09rbc4gSFArTJp/YBPkSrBjJM0F7fIh5bH5w5q/TTJbNBwiwyP3w0G
         1kOD0OpmTvdAkY2KqhbgkGCYOuS8+4NTKIGElnrD0i7lfN+z+v6ZdbKoQbf+b2NjG+IM
         WH/Q==
X-Gm-Message-State: AElRT7HcEmlICSlzePfogh0nNLBr99hivVhiE5aAxeJY58hcLRFePzfr
        a4d88CGPnRxttkmDifUlcFUJ3LABN4gPpkvbEIg=
X-Google-Smtp-Source: AG47ELtWiNw+Qc8ioMX4pm7WRF6QYIF1is96Yzerby47ZfQeXPAcHXiHHPAxl6wjLdVzW+8Vqfz5tpvsD7P624KhXmY=
X-Received: by 10.223.133.182 with SMTP id 51mr3622171wrt.226.1521034205019;
 Wed, 14 Mar 2018 06:30:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.197.147 with HTTP; Wed, 14 Mar 2018 06:30:04 -0700 (PDT)
In-Reply-To: <CAN0heSoJKxqSb0q5SR2SVfEzh6QjeiNNnESorZyYHTSC71jZuQ@mail.gmail.com>
References: <010201621edc97a4-a4239b1e-86d2-4400-aaac-d81727710f4f-000000@eu-west-1.amazonses.com>
 <CAN0heSoJKxqSb0q5SR2SVfEzh6QjeiNNnESorZyYHTSC71jZuQ@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Wed, 14 Mar 2018 16:30:04 +0300
Message-ID: <CAL21BmmQvjzpXGCjuHdPFiQ07P7VcV-E=mQbmM+35Y1u8acD6Q@mail.gmail.com>
Subject: Re: [RFC 1/4] ref-filter: start adding strbufs with errors
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-13 22:12 GMT+03:00 Martin =C3=85gren <martin.agren@gmail.com>:
> On 13 March 2018 at 11:16, Olga Telezhnaya <olyatelezhnaya@gmail.com> wro=
te:
>> This is a first step in removing any printing from
>> ref-filter formatting logic, so that it could be more general.
>> Everything would be the same for show_ref_array_item() users.
>> But, if you want to deal with errors by your own, you could invoke
>> format_ref_array_item(). It means that you need to print everything
>> (the result and errors) on your side.
>>
>> This commit changes signature of format_ref_array_item() by adding
>> return value and strbuf parameter for errors, and fixes
>> its callers.
>
> Minor nit: Maybe s/fixes its callers/adjusts its callers/. They are not
> broken or need to be fixed. They were simply playing the game according
> to the old rules, and now they need to learn the new ways. :-)

Agree.

>
>> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
>> ---
>>  builtin/branch.c |  7 +++++--
>>  ref-filter.c     | 17 ++++++++++++-----
>>  ref-filter.h     |  7 ++++---
>>  3 files changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 8dcc2ed058be6..f86709ca42d5e 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -391,7 +391,6 @@ static void print_ref_list(struct ref_filter *filter=
, struct ref_sorting *sortin
>>         struct ref_array array;
>>         int maxwidth =3D 0;
>>         const char *remote_prefix =3D "";
>> -       struct strbuf out =3D STRBUF_INIT;
>
> You move this variable into the loop to reduce its scope. At first I
> suspected that this might mean we now start allocating+releasing in each
> run of the loop, which might be a performance-regression. But it turns
> out, we already did that, so this tightening of the scope has no such
> downsides. :-) From the commit message, I wasn't expecting this move,
> though. Maybe "While at it, reduce the scope of the out-variable."

Added this to commit message. I just wanted to unify code style. I
added another strbuf and tried to reduce its scope (not sure that it
will cause a performance regression, I guess compiler is smart enough
- but, who knows). I saw another strbuf, and I just decided to put
them together. In my opinion, it's easier to read the code where
variables are created in the smallest possible scope.
But, anyway, you are right, I needed to mention that in the commit message.

>
>>         char *to_free =3D NULL;
>>
>>         /*
>> @@ -419,7 +418,10 @@ static void print_ref_list(struct ref_filter *filte=
r, struct ref_sorting *sortin
>>         ref_array_sort(sorting, &array);
>>
>>         for (i =3D 0; i < array.nr; i++) {
>> -               format_ref_array_item(array.items[i], format, &out);
>> +               struct strbuf out =3D STRBUF_INIT;
>> +               struct strbuf err =3D STRBUF_INIT;
>> +               if (format_ref_array_item(array.items[i], format, &out, =
&err))
>> +                       die("%s", err.buf);
>
> Using "%s", good.
>
>>                 if (column_active(colopts)) {
>>                         assert(!filter->verbose && "--column and --verbo=
se are incompatible");
>>                          /* format to a string_list to let print_columns=
() do its job */
>> @@ -428,6 +430,7 @@ static void print_ref_list(struct ref_filter *filter=
, struct ref_sorting *sortin
>>                         fwrite(out.buf, 1, out.len, stdout);
>>                         putchar('\n');
>>                 }
>> +               strbuf_release(&err);
>>                 strbuf_release(&out);
>>         }
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 45fc56216aaa8..54fae00bdd410 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -2118,9 +2118,10 @@ static void append_literal(const char *cp, const =
char *ep, struct ref_formatting
>>         }
>>  }
>>
>> -void format_ref_array_item(struct ref_array_item *info,
>> +int format_ref_array_item(struct ref_array_item *info,
>>                            const struct ref_format *format,
>> -                          struct strbuf *final_buf)
>> +                          struct strbuf *final_buf,
>> +                          struct strbuf *error_buf)
>>  {
>>         const char *cp, *sp, *ep;
>>         struct ref_formatting_state state =3D REF_FORMATTING_STATE_INIT;
>> @@ -2148,19 +2149,25 @@ void format_ref_array_item(struct ref_array_item=
 *info,
>>                 resetv.s =3D GIT_COLOR_RESET;
>>                 append_atom(&resetv, &state);
>>         }
>> -       if (state.stack->prev)
>> -               die(_("format: %%(end) atom missing"));
>> +       if (state.stack->prev) {
>> +               strbuf_addstr(error_buf, _("format: %(end) atom missing"=
));
>> +               return -1;
>> +       }
>>         strbuf_addbuf(final_buf, &state.stack->output);
>>         pop_stack_element(&state.stack);
>> +       return 0;
>>  }
>>
>>  void show_ref_array_item(struct ref_array_item *info,
>>                          const struct ref_format *format)
>>  {
>>         struct strbuf final_buf =3D STRBUF_INIT;
>> +       struct strbuf error_buf =3D STRBUF_INIT;
>>
>> -       format_ref_array_item(info, format, &final_buf);
>> +       if (format_ref_array_item(info, format, &final_buf, &error_buf))
>> +               die("%s", error_buf.buf);
>>         fwrite(final_buf.buf, 1, final_buf.len, stdout);
>> +       strbuf_release(&error_buf);
>
> I think this `strbuf_release()` will never actually do anything. If we
> get here, we had no error. But it makes sense (to me) to always be clear
> about releasing this. In this case it is easy enough.

I was thinking same as you (I want to be sure that we release everything).

>
> Possible counterargument: We might want this sort of "error-handling by
> strbufs" to follow this simple rule: return an error if and only if you
> add some error-string to the buffer. If this rule is universal enough,
> it might be ok to skip releasing these sort of buffers if you do not
> have an error.

I just think that it's more intuitive to release everything in all
cases, even if this line seems useless. Anyway, it's not super hard to
remove this line in any moment, so I guess we could wait with this
till the final review.

>
> Martin
