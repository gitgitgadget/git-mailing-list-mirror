Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29284208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 14:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbdHOOks (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 10:40:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36075 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdHOOks (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 10:40:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id y129so1768903pgy.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GyWJKxscYhjkZP1b4ARJUGABW5pyzPWu45iSPzBjrN8=;
        b=q5w/GNMNLYUPYgDc2/SyjsWz5KfNcij0cUGQnnUHY13XxIWuKc62UGz26aFBYZz5ij
         Fh6kzoDAwyBNhTpGk++JgKWL8aNU7gNqkL3gKHpUf5l91jAAn69E+lLJ2eUfwEgROZHG
         QFrD3xYDpI4lIBeK3YKoMx3W21P7zhuEM3LOh+Xdkm725L973Jj2kgl9S37ZowTg0vEv
         IoSJtCUN4GB8BDtiOUrvSYOQjOhU7Qo8axY9Y/33ED4dffSDH0yPUUemVg0OqXhcxR3s
         GpJTJ/RGiKe5V79+Xp3TXzI+cCt1N8Dl8UyQMasiPHvGdYXAdFa6MZ5WVRZhEupR1Uns
         z1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GyWJKxscYhjkZP1b4ARJUGABW5pyzPWu45iSPzBjrN8=;
        b=U4HSORWMrhkTqxuD3MF76LxTxyBN4E5uoEGnNl8nl+4tq36HLzzg3Ai69TQGFRVZax
         8mLA+zfFO7b2/t9ihldLg/b1WPeQ5N30a3zJn6z5Ccj0OYMBuFgdj+UiLU5OI37oCggU
         YmpKSeuzqKcCBcOK8P41qqi9zKK2YqfDkjBwkm8i/meZI+NGgf526Tcpid82rTmaLnWx
         UVJxc4NaRYOcpsehWgjtD/F1qcI4mNXSAfFodNFuvycX5LSUUY57KFCSfXVUzDi12PWl
         MuHC/mz7md41+Mj2k2jZ5iW3mZI94KGsbuS7sU5XRQbjpQI+Ultd9yD6BY3WGNVykuYO
         A0HA==
X-Gm-Message-State: AHYfb5h5jc/cZGQFYmcE6RXX8S3cdBoaxiwO8TYeIOusWdFqha9ORoLv
        OP2kxYy60YSLhEetULQ+AbS5Nzgvt15m
X-Received: by 10.98.2.146 with SMTP id 140mr16307281pfc.207.1502808047591;
 Tue, 15 Aug 2017 07:40:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Tue, 15 Aug 2017 07:40:46 -0700 (PDT)
In-Reply-To: <20170815141734.GA4916@tor.lan>
References: <cover.1502780343.git.martin.agren@gmail.com> <0fd7f3184d285df8867ea44dd1adf418ebfc5ef3.1502780344.git.martin.agren@gmail.com>
 <20170815141734.GA4916@tor.lan>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 15 Aug 2017 16:40:46 +0200
Message-ID: <CAN0heSpF5OszFabkFC7Rp8XykUYdFc0PXWzOmVJEHcuFxJPxyg@mail.gmail.com>
Subject: Re: [PATCH 1/5] convert: initialize attr_action in convert_attrs
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 August 2017 at 16:17, Torsten B=C3=B6gershausen <tboegi@web.de> wrote=
:
> On Tue, Aug 15, 2017 at 02:53:01PM +0200, Martin =C3=85gren wrote:
>> convert_attrs populates a struct conv_attrs. The field attr_action is
>> not set in all code paths, but still one caller unconditionally reads
>> it. Since git_check_attr always returns the same value, we'll always end
>> up in the same code path and there is no problem right now. But
>> convert_attrs is obviously trying not to rely on such an
>> implementation-detail of another component.
>>
>> Initialize attr_action to CRLF_UNDEFINED in the dead code path.
>>
>> Actually, in the code path that /is/ taken, the variable is assigned to
>> twice and the first assignment has no effect. That's not wrong, but
>> let's remove that first assignment while we're here.
>>
>> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
>> ---
>> I hit a warning about attr_action possibly being uninitialized when
>> building with SANITIZE=3Dthread. I guess it's some random interaction
>> between code added by tsan, the optimizer (-O3) and the warning
>> machinery. (This was with gcc 5.4.0.)
>>
>>  convert.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/convert.c b/convert.c
>> index 1012462e3..943d957b4 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -1040,7 +1040,6 @@ static void convert_attrs(struct conv_attrs *ca, c=
onst char *path)
>>               ca->crlf_action =3D git_path_check_crlf(ccheck + 4);
>>               if (ca->crlf_action =3D=3D CRLF_UNDEFINED)
>>                       ca->crlf_action =3D git_path_check_crlf(ccheck + 0=
);
>> -             ca->attr_action =3D ca->crlf_action;
>
> I don't think the removal of that line is correct.

(Thanks for confirming in a follow-up mail that you meant that you /do/
think the removal is correct.)

>
>>               ca->ident =3D git_path_check_ident(ccheck + 1);
>>               ca->drv =3D git_path_check_convert(ccheck + 2);
>>               if (ca->crlf_action !=3D CRLF_BINARY) {
>> @@ -1058,6 +1057,7 @@ static void convert_attrs(struct conv_attrs *ca, c=
onst char *path)
>>       } else {
>>               ca->drv =3D NULL;
>>               ca->crlf_action =3D CRLF_UNDEFINED;
>> +             ca->attr_action =3D CRLF_UNDEFINED;
>
> But this one can be avoided, when the line
> ca->attr_action =3D ca->crlf_action;
> would move completely out of the "if/else" block.
>
>>               ca->ident =3D 0;
>>       }
>>       if (ca->crlf_action =3D=3D CRLF_TEXT)
>> --
>> 2.14.1.151.gdfeca7a7e
>>
>
> Thanks for spotting my mess.
> What do you think about the following:
>
>
> diff --git a/convert.c b/convert.c
> index 1012462e3c..fd91b91ada 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1040,7 +1040,6 @@ static void convert_attrs(struct conv_attrs *ca, co=
nst char *path)
>                 ca->crlf_action =3D git_path_check_crlf(ccheck + 4);
>                 if (ca->crlf_action =3D=3D CRLF_UNDEFINED)
>                         ca->crlf_action =3D git_path_check_crlf(ccheck + =
0);
> -               ca->attr_action =3D ca->crlf_action;
>                 ca->ident =3D git_path_check_ident(ccheck + 1);
>                 ca->drv =3D git_path_check_convert(ccheck + 2);
>                 if (ca->crlf_action !=3D CRLF_BINARY) {
> @@ -1060,6 +1059,8 @@ static void convert_attrs(struct conv_attrs *ca, co=
nst char *path)
>                 ca->crlf_action =3D CRLF_UNDEFINED;
>                 ca->ident =3D 0;
>         }
> +       /* Save attr and make a decision for action */
> +       ca->attr_action =3D ca->crlf_action;
>         if (ca->crlf_action =3D=3D CRLF_TEXT)
>                 ca->crlf_action =3D text_eol_is_crlf() ? CRLF_TEXT_CRLF :=
 CRLF_TEXT_INPUT;
>         if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D AUT=
O_CRLF_FALSE)

Yeah, makes lots of sense. Then we could also remove the second
assignment to attr_action. That is, this function would set attr_action
at one place, always. I'll do this in a v2.

Thanks.
