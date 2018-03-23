Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0941F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 06:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbeCWG4b (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 02:56:31 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:55972 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCWG4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 02:56:30 -0400
Received: by mail-wm0-f49.google.com with SMTP id t7so1607179wmh.5
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 23:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6uorvlMjaucyKIFXd1C8qeubCXEStPOzHEV7Ui6cb4s=;
        b=i5s/zBkSJTg89vtpNYSepY2TEfwQLnQhFwm0k7CPx32GxqX78MP9UBRGcJLpKja4XZ
         5few89DwhiQjEzOZZAAvtQiDODEn8IYwMPbXKM3pPxuIOpCPVnF6iA/72unNOHt/5haJ
         14mO8Kyp158PUVNImWPrj7ZZNM+7zLop1l5bD1WLOCSr/URhe3c16EHQZRQfnILFmGIf
         GvoB4z/qVQMeApRcsRswg+D4VPW2e89NoMzh3vD710kWF6akh/yyWSWZYMOdF2H/+RZ4
         h1x8BepsIR7IeyzWxJjBtituLgfDt8PuY+Qe7xdbVUqZzimjTRqo/h/lMesF8HeAuajP
         bdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6uorvlMjaucyKIFXd1C8qeubCXEStPOzHEV7Ui6cb4s=;
        b=Q/gWF1fJcgSRqeTJcKdz6uV5gvv6eBqfyBvQcGoE7c/E6rUmDqNjErTkx2GBW1MuMA
         ykqpxAdOWnT5zeoHrGIA8jmoYfeoPM7ZATnwR0NDJpUgP8HTj/b7+qCUrjiW/yyDiBzp
         UBaD8hD7Fvg+SqERQAV1LCwAEF2ej/aHFUtB0Hva9idzvTD4FcXW/c5s8C20z1ufWEgo
         5VOkieqgVwLFcZDuG6eDNhv3hqCAFuXtQnqpgH3Q1bf3JbKMrpGS+dk30zESuFZnwqXm
         739Q9u8vq91vWPtTGNXwnFXKMnY/EmlqgoozakzRWeUSgChwLKtVUrI/1EhzQTeLLT/+
         l8cQ==
X-Gm-Message-State: AElRT7E/is2kfRllAKyvbf9N1oln0Q0NZ5Un/T4tYbWI6FPavx2a/IMl
        hiDyPf8B5cdC94uHdExPSNn5zCw6GstGO9gTpJE=
X-Google-Smtp-Source: AG47ELtlsPK6tQ8jBpM+A2CyfhF70Pm7lXJmfzGZKlaAnY2oCbLrZRc3PW3N7Q9s168oIJsUOOXJqmHyNboxojESokI=
X-Received: by 10.28.139.131 with SMTP id n125mr7274748wmd.101.1521788189807;
 Thu, 22 Mar 2018 23:56:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.156.195 with HTTP; Thu, 22 Mar 2018 23:56:29 -0700 (PDT)
In-Reply-To: <xmqqh8p9np2a.fsf@gitster-ct.c.googlers.com>
References: <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
 <0102016249d21c96-29f058b0-a43d-45b7-9c1d-5ea2382858a2-000000@eu-west-1.amazonses.com>
 <xmqqh8p9np2a.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 23 Mar 2018 09:56:29 +0300
Message-ID: <CAL21BmnJ8ktMxt2-sLBE-US-j8p_MFGOYjdoCHPmdL0-NG=omg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] ref-filter: change parsing function error handling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-21 23:36 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
>
>> @@ -2144,13 +2151,15 @@ int format_ref_array_item(struct ref_array_item *info,
>>
>>       for (cp = format->format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>>               struct atom_value *atomv;
>> +             int pos;
>>
>>               ep = strchr(sp, ')');
>>               if (cp < sp)
>>                       append_literal(cp, sp, &state);
>> -             get_ref_atom_value(info,
>> -                                parse_ref_filter_atom(format, sp + 2, ep),
>> -                                &atomv);
>> +             pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
>> +             if (pos < 0)
>> +                     return -1;
>> +             get_ref_atom_value(info, pos, &atomv);
>>               if (atomv->handler(atomv, &state, error_buf))
>>                       return -1;
>>       }
>
> These error returns leave the formatting state "state" on the stack
> holding onto its resources, no?

Yes, you are right, thanks a lot!

>
> The only thing the caller of format_ref_array_item() that notices an
> error return does is to die even after this series, so in that sense
> it does not matter (yet), but it still feels somewhat wrong.
>

I am sure I need to fix it anyway, thanks.
