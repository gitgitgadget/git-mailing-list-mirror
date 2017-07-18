Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CFF20896
	for <e@80x24.org>; Tue, 18 Jul 2017 01:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdGRBdp (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 21:33:45 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36381 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdGRBdo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 21:33:44 -0400
Received: by mail-qt0-f180.google.com with SMTP id 21so5070619qtx.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PlXP/sBgw42Jy9zpy1KY2EhpKVILA6M1ld5kow+s98c=;
        b=A/aw8qmYKNuyltSECgyxESpb6lB5sZvaurj6CIUtq0fCmbjfA1KIVtpV2Jk75IbdN+
         6gf6eISXPpPpmC34eM8l6A3c6jgv0NJXOgLwFUYWoqlirFnASIjs8g8Cvph9II2gDzCl
         ZLOZ2R+V2h33rYcbzkY+Zi6rs8DnLTj3g614OXjsiDEGWeKLZC7Y/jbiFlN0QYFAMZH3
         2chAk/j/MzQl9aibJ9n6NxE70tdt5MvvIRHrbTC36AT+yPsa0KDxzf03HeouQC0xjmqK
         4JRvhtHwf626TdbjyWusMoYINU2GtkLyQmGjMNERaLjT0SE3ZAPQVu/6EQMEiK1U1Epx
         ncow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PlXP/sBgw42Jy9zpy1KY2EhpKVILA6M1ld5kow+s98c=;
        b=sBkRbAgpT9Z2II914WJF7qXKBuTrWmrxUgmRFxp5oe1RDLhxVauHmSYWIyVVtXpsRB
         jBZZkVvUpZGrc2wE3sm6fjSx4iYAGA+8mbEgLw5yrjQ316YHbcashr8v6IyDcptdwAMM
         jKg+EnlovBfAS1Oce7KpuCgiZxx17ydYbVVEi8Z83vgcPJLiP0haY3oBOVsm+Mv9/91J
         TCHeWLUHIL7XiVxrzi2dgPV9u8nQKm4SCGxc8X8pCiwVkO21GSFf6Z32iMD4X+s8eol2
         Co8te2H6Sq/iyoXTva6YTYtve3yFxUCZxZi0fOUmH45j1DgYHc4GmnlpeHqAayqkj2dd
         eYRA==
X-Gm-Message-State: AIVw110meBr+UsGheyZ8QSiinedJMw309pZ0lid6zfCk+jahQM6qxzJC
        9O02On5KjBdO2R7b5n04ZFLCFyQT0A==
X-Received: by 10.200.58.161 with SMTP id x30mr431003qte.69.1500341624053;
 Mon, 17 Jul 2017 18:33:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Mon, 17 Jul 2017 18:33:43 -0700 (PDT)
In-Reply-To: <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
 <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 18 Jul 2017 09:33:43 +0800
Message-ID: <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-18 1:10 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Commit cb71f8bdb5 ("PRItime: introduce a new "printf format" for
>> timestamps", 2017-04-21) does not play well with i18n framework. The
>> static string concatenation cannot be correctly interpreted by
>> gettext utilities, such as xgettext.
>>
>> Wrap PRItime in format_raw_time() function, so that we can extract
>> correct l10n messages into "po/git.pot".
>>
>> Reported-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>> ...
>> @@ -191,6 +200,15 @@ struct date_mode *date_mode_from_type(enum date_mod=
e_type type)
>>       return &mode;
>>  }
>>
>> +const char *format_raw_time(timestamp_t time)
>> +{
>> +     static struct strbuf time_buf =3D STRBUF_INIT;
>> +
>> +     strbuf_reset(&time_buf);
>> +     strbuf_addf(&time_buf, "%"PRItime, time);
>> +     return time_buf.buf;
>> +}
>
> Hmm.
>
> Two potential issues are:
>
>  - After this patch, there still are quite a many
>
>         printf("time is %"PRItime" ...\n", timestamp)
>
>    so the burden on the programmers having to remember when it is
>    required to use format_raw_time() becomes unclear, and makes the
>    change/churn larger when an existing message needs to be marked
>    for translation.
>
>  - The static struct strbuf here is a cheap way to avoid leaks, but
>    at the same time it is unfriendly to threaded code.  We could
>    instead do:
>
>         void append_PRItime(struct strbuf *buf, timestamp_t time);
>
>    to fix that trivially, but the damage to the caller obviously is
>    much larger going this way.
>

I wonder if we can replace the original %lu for timestamp with PRIuMAX
instead.  PRIuMAX works fine with gettext utils.

--=20
Jiang Xin
