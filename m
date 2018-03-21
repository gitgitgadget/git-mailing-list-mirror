Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37FD71F404
	for <e@80x24.org>; Wed, 21 Mar 2018 17:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeCURBW (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 13:01:22 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:46326 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbeCURBT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 13:01:19 -0400
Received: by mail-ot0-f174.google.com with SMTP id g97-v6so6333367otg.13
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=icj2L5ssehbiWw2OH0aE0vmQFDdPu+28rpmdzjT7IKo=;
        b=BSSh/9gukpaHoHOU97J4Vp8VoUOfGHhRTpDLdQsL2g5Qzsg++rAg54VmteilT+iBd8
         DnhWotfX528zTVk6yPunPBm80xD7hn+k49fqIpg+30rCyzsVz6YFkDocNBPvCM1i8ocP
         wYcZH3XWqns6YcIW8R1uEXKCXVV0GZI6vco7dXvxYNIrmHpWlJtstByRU7LaRmB+TXp/
         424foYQAFQeAmQxAA5vITysB1w2p+H+pML5e/LjhLt8Tt9Y/rBTLfjd1jAtuyNLhMsbx
         3SgYzCkH6cXaD+CiUzChnhV+uaB7/LYoRgaDeB03cZbvmrHHf6zqjiZdYOtxLoYNayu4
         zeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=icj2L5ssehbiWw2OH0aE0vmQFDdPu+28rpmdzjT7IKo=;
        b=J3gcyCLH/NInZFBRjKcR45XerAJnFHqjT4eHk60Ehncu0WFWl+Q/HDwMVdsyFOnJPX
         LJKGxLoFtOTYDKWgzFEWgIVowmFuGQY3yPfedu89Lj2wSoj8AnI2GM8DBpIb3fArth5e
         KxUPgw2QJv831fYrMFXM6TdkdiQpfEsGtkDnh4SHUdQUthWTaWqB+raAxsbWYALqnFHH
         nIjQ8vdXUtWiJjujRMg/xP6Z1TtMeh3kTN2UY/Hj1Gi6B6GAreEssCTy/XHVIFq3XtRS
         vW37hj0nNqP0QvovCf1dFzdkvxuumah194lcudPpa3vGvs60B8I53yyfA989DGgBCJN6
         ronw==
X-Gm-Message-State: AElRT7ELuu3jhZSExdnYNyeOw7hgW/lFtFQoIQIL8+93QF9/lJF5Fjt+
        CqskivGuMEIXjrKI8/h1t03KcnsadfZa+/Kh6qI=
X-Google-Smtp-Source: AG47ELtbyajkZiEEg6A9pBgoescuWwxVMK1JFTQhQduEKFs3O/u+mmJvUUuDNufZNK1o4ujptYK0kVOmDJGmqAo8N0I=
X-Received: by 2002:a9d:154c:: with SMTP id z12-v6mr13284389otz.65.1521651677350;
 Wed, 21 Mar 2018 10:01:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Wed, 21 Mar 2018 10:00:46 -0700 (PDT)
In-Reply-To: <xmqq370tqsjk.fsf@gitster-ct.c.googlers.com>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net> <87tvt9xuel.fsf@evledraar.gmail.com>
 <xmqq370tqsjk.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 21 Mar 2018 18:00:46 +0100
Message-ID: <CACsJy8CWkm_Xn2c0f46jUdD5dH7NUzTqyu6TrRkGKTS8WRCe3Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 5:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> That's going to be super rare (and probably nonexisting) edge case, but
>> (untested) I wonder if something like this on top would alleviate your
>> concerns, i.e. instead of dying we just take the first N packs up to our
>> limit:
>>
>>     diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>     index 4406af640f..49d467ab2a 100644
>>     --- a/builtin/pack-objects.c
>>     +++ b/builtin/pack-objects.c
>>     @@ -1065,8 +1065,9 @@ static int want_object_in_pack(const struct ob=
ject_id *oid,
>>
>>             want =3D 1;
>>      done:
>>     -       if (want && *found_pack && !(*found_pack)->index)
>>     -               oe_add_pack(&to_pack, *found_pack);
>>     +       if (want && *found_pack && !(*found_pack)->index) {
>>     +               if (oe_add_pack(&to_pack, *found_pack) =3D=3D -1)
>>     +                       return 0;
>>
>>             return want;
>>      }
>
> It is probably a small first step in the right direction, but we'd
> need to communicate which packs we ignored with this logic to the
> calling program.  I offhand do not know how we would handle the "-d"
> part of "repack -a -d" without it.

repack will delete all the packs except ones with .keep files and ones
created by pack-objects. So this change alone is not enough. I think I
did mention that we could make this work by making repack run
pack-objects multiple times. But I did not do it because I did not
think it could really happen.
--=20
Duy
