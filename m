Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A3E1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 05:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeFEFLB (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 01:11:01 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39847 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeFEFLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 01:11:00 -0400
Received: by mail-pl0-f68.google.com with SMTP id f1-v6so767567plt.6
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 22:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eG3cJ6qQrFnRbTPGNpaVo6TAwrww9QXx3eVG74Y4M5s=;
        b=VatNQe9brR2SFESImPrLmboCA4mFphOcP+wWZ+BiV2yf3y4nxsRwNJOThmWxmlzzrA
         LHBYCkNZ/1jsFJ/mFteSkGyidFTjoksG8ChndGsz3jeJ9jdkOr2JCTR3RDn0UpgAXb7I
         ZU7Q6S1MGspA/mR19qelygCJJGb/gGmaF7BF3aKBY0GgE89T21D9bc2QdXUB6m7hMveb
         nMf2YGCNesmpfgJ9wmml+TI/LM1HE+ge0ak3eqdvg1xLoGDL8LAo5E4RJwosoTZo+t8p
         QO9CcftHK7Ah69GXW8L3pjZ3fjkNwq2bZ0rIidVjfjzCjkV0TyxkGHe5FsQgqK5crTtp
         FI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eG3cJ6qQrFnRbTPGNpaVo6TAwrww9QXx3eVG74Y4M5s=;
        b=GwJV4kEwCaY+TQ3j5NrMQEg1Em5e/L2YK43A60rWhOGxUe7rjG4m0V1LbCr+t6EG8f
         d+w1N4R/twjY6qR8Fdf/wAGf0jDReUH1YIztsu7PJVF3k33VBfWJ/d1E0GjKU79o1wT/
         +o4h/rR4tmeCJcAck5jQNy2i2k9jJjok4Xw0bT7rcZWojxNAxFpJ8YWiiTExvUP45Vey
         dcJmyZZMmIs7R3JvcG9ukc2lBBoYS+tPBmSG7oFaGuYWZDJDRXkCn1vB4pyjXoEd98Dt
         SA9xS2N3tFORdbMabBuJICtTi+wp5oMJqx3rt2EEbYe1XKRKhdcPUmExGsLD18Nx17pc
         88Ow==
X-Gm-Message-State: ALKqPwcDRyWOZHeR9mZA1sx+i2d8dVXX51vHwJepS3TuswC0QELjEBMD
        hEeNYzXELRsSKkqPm4REIuD2HvTmAUZDguMQZ0Y=
X-Google-Smtp-Source: ADUXVKJVW77Z7or6aY3TRobrLOBdyNte05wBd4mrPmk5tXnZIq0GtakPFU5aGUJcUWN38DlMZjMQvi8zx1qUPS60k48=
X-Received: by 2002:a17:902:284b:: with SMTP id e69-v6mr24150304plb.240.1528175460370;
 Mon, 04 Jun 2018 22:11:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Mon, 4 Jun 2018 22:10:59
 -0700 (PDT)
In-Reply-To: <87tvqiz06t.fsf@evledraar.gmail.com>
References: <CAN0heSr6dPa+--Mut0+3Zgy-mWF0d2762vKU=d08CKhR8BnKmA@mail.gmail.com>
 <20180604144305.29909-1-martin.agren@gmail.com> <87tvqiz06t.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 5 Jun 2018 07:10:59 +0200
Message-ID: <CAN0heSprfMRf97J0zeJ4+e7vdM-hk5Z3M1mX2hniBVrRByM4KQ@mail.gmail.com>
Subject: Re: [PATCH] refspec: initalize `refspec_item` in `valid_fetch_refspec()`
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 June 2018 at 23:55, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:

> I think this makes more sense instead of this fix:
[...]
> -void refspec_item_init(struct refspec_item *item, const char *refspec, i=
nt fetch)
> +int refspec_item_init(struct refspec_item *item, const char *refspec, in=
t fetch)
>  {
>         memset(item, 0, sizeof(*item));
> +       int ret =3D parse_refspec(item, refspec, fetch);
> +       return ret;
> +}

Nit: Declaration after statement. Intriguingly, you do use a `ret`
variable, so I suspect you sort of thought about it but left the final
cleaning up for later. ;-)

> -void refspec_item_init(struct refspec_item *item, const char *refspec, i=
nt fetch);
> +int refspec_item_init(struct refspec_item *item, const char *refspec, in=
t fetch);
> +void refspec_item_init_or_die(struct refspec_item *item, const char *ref=
spec, int fetch);
>  void refspec_item_clear(struct refspec_item *item);
>  void refspec_init(struct refspec *rs, int fetch);
>  void refspec_append(struct refspec *rs, const char *refspec);
>
> I.e. let's fix the bug, but with this admittedly more verbose fix we're
> left with exactly two memset() in refspec.c, one for each type of struct
> that's initialized by the API.
>
> The reason this is difficult now is because the current API conflates
> the init function with an init_or_die, which is what most callers want,
> so let's just split those concerns up. Then we're left with one init
> function that does the memset.

I didn't test this, but it looks sane in general IMHO, and should fix
the issue I saw. Should we be worried that someone might already depend
on `refspec_item_init()` to die, and we'll silently break that
assumption?

Martin
