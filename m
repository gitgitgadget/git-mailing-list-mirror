Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971081F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 06:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeCWGsn (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 02:48:43 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:44601 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeCWGsm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 02:48:42 -0400
Received: by mail-wr0-f181.google.com with SMTP id u46so10979746wrc.11
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vheEfU4IzkgG4+QeEqfFQcOGVN85lEqQwhk7txV1tjU=;
        b=u3Cwphjz1C3/7JezgtwqGGI1L6ScvBgeR/pCx30r4RCoFBlSf2g5K7lhe1HT72p/Rn
         3P+DZULjKQpqmbnw7MZ18+ZXzX2guXy9yRVJOqP3uOUdR5WYx11boo1e/b8pBOh6WRgz
         LVIJQkX9pxp0Vb3FTxykWtavANEGdXms9i84p5BJeBvmVXL+wBYrk1tRjnWv63zQD2fi
         aSnRjRq3yUCSuThkjy6l7l94oYTxcsasOEHfd8yPI5eqISoUufrBs6RAznT3VT/mxoIt
         QGv4tpdrGc5qheJdtui+KYHhTRSjMm4tfG1kZrsaasIP7+ty1I3f0qYLe1jWh7L/1vd9
         gcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vheEfU4IzkgG4+QeEqfFQcOGVN85lEqQwhk7txV1tjU=;
        b=kaL8tFNnYEu/r2GlSqENG6B5GK6TQmf3fRx+UNGQu69xIFqEluhgYLwYAWy/tZyLFR
         EzjSu3QtkxR4UYp87Oe0yNFsYXF/q+CdAgSoueT+zoj9B+6Ju67hi35YZGvRQVSp4m+M
         HLYPu2GsIn/B5PQ8E3oJIUmLzd7e9Iop+Smp6XS98MGtv6qNk12zN6Hf0uVpVsFlp2sn
         fx0t22qBOO/Sm+AhaEkXdEndJ36OR+biDg4iaSSneQMmoANhXsvfmy81aeioAdyVy+06
         jymQ3KIDsftB9tSgxRORpmBQAVwsYsU9Q5Nd3RdfN8at4TuVV1mFa7pqeNy3nM7qIBsP
         uL8w==
X-Gm-Message-State: AElRT7GokV5PWwXA6VRpTDO0cEEue7HC0xovxYiOXuBunOfDR2/Alje2
        /Vl9vJxIsWtdGkngMv+FXLkBUrlFsncdx/s/UVQ=
X-Google-Smtp-Source: AG47ELui3kEZW+QJ/1VVPlPo7UYVVBAGn4ZAnBh2F389v6MRm8lSZpZKxMbV3wwaO5gko/plAZiPXvPJwkPG0dWBy6Q=
X-Received: by 10.223.144.35 with SMTP id h32mr23072091wrh.2.1521787721665;
 Thu, 22 Mar 2018 23:48:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.156.195 with HTTP; Thu, 22 Mar 2018 23:48:41 -0700 (PDT)
In-Reply-To: <xmqqlgelnpsx.fsf@gitster-ct.c.googlers.com>
References: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
 <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
 <xmqqlgelnpsx.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 23 Mar 2018 09:48:41 +0300
Message-ID: <CAL21Bm=M-X8pjnxKzXKZbwArF6gyoPLLLa8JBZFNrvwrsRsacg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] strbuf: add shortcut to work with error messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-21 23:20 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
>
>> Add function strbuf_error() that helps to save few lines of code.
>> Function expands fmt with placeholders, append resulting error message
>> to strbuf *err, and return error code ret.
>>
>> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
>> ---
>>  strbuf.h | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/strbuf.h b/strbuf.h
>> index e6cae5f4398c8..fa66d4835f1a7 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -620,4 +620,17 @@ char *xstrvfmt(const char *fmt, va_list ap);
>>  __attribute__((format (printf, 1, 2)))
>>  char *xstrfmt(const char *fmt, ...);
>>
>> +/*
>> + * Expand error message, append it to strbuf *err, then return error code ret.
>> + * Allow to save few lines of code.
>> + */
>> +static inline int strbuf_error(struct strbuf *err, int ret, const char *fmt, ...)
>> +{
>
> With this function, err does not have to be an error message, and
> ret does not have to be negative.  Hence strbuf_error() is a wrong
> name for the wrapper.
>
> It somewhat is bothersome to see that this is inlined; if it is
> meant for error codepath, it probably shouldn't have to be.
>
>> +     va_list ap;
>> +     va_start(ap, fmt);
>> +     strbuf_vaddf(err, fmt, ap);
>> +     va_end(ap);
>> +     return ret;
>> +}
>> +
>>  #endif /* STRBUF_H */
>
> Quite honestly, I am not sure if it is worth to be in strbuf.h; it
> feels a bit too specific to the immediate need for these five
> patches and nowhere else.  Are there many existing calls to
> strbuf_addf() immediately followed by an "return" of an integer,
> that can be simplified by using this helper?  I see quite a many
> instances of addf() soon followed by "return -1" in
> refs/files-backend.c, but they are not immediately adjacent to each
> other, and won't be helped.

Summarizing all that we discussed: I have 2 options how to continue
this patch. I can revert to v4, or I can replace new function in
strbuf.h with similar macro in ref-filter.c (I mean, there would be no
changes in strbuf.h and one new macro in ref-filter.c). What do you
like more?

Thanks!
Olga
