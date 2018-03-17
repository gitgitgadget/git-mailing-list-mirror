Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BCCE1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 12:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCQMAK (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 08:00:10 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:34365 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeCQMAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 08:00:09 -0400
Received: by mail-ot0-f178.google.com with SMTP id v4-v6so9810284otj.1
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aB/5k+ElXu+adLrFxPrPZEviwFLp4TjdJvypBDRIrpE=;
        b=Q/FimrGqUk8GP0F1fb58dUyvE9kU1UjE19QErxWHQ5q7Wm+4CgsG6HYSH/gGUQucPz
         syas1DEA3+CaM6Hux1Xk7lCnSOP6rssLM0hX6kf5ItS1/+nn/CJ11OgnA53v6u/DR6x4
         lmWOO2i3rp7UQmC2PAYEOQLSTxrncerZVTfQCiqB3RR3TS4GnpkPGkJDBwLQXUGvAgnf
         +jLwi7hB1rk9PfOTczzjhkR0IE1Xrvi0Mjos8owPTVBMFLWOPO6HA0pNlesryd8FV7Ls
         u68MlQ8OU3CuPpBUlGj3fI9VxYM4K6Xgas4grCEBcN8fn/qYXXujjph04i+1T0x/dTSD
         o4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aB/5k+ElXu+adLrFxPrPZEviwFLp4TjdJvypBDRIrpE=;
        b=qHHcWvfFQLhPlhBrIqKPrkpkzjueMs/44NfMMGpkEM+zJJe4zrtl+NKqlwWaCDRDTa
         ydKzHhSeI1w+dHPfjvvGuVmdqEQVR2ZUVoON+e0GgNcohe+fHUC01J83yfw9k1FcZf7D
         APAQMQTUtvIVGV3+3jwERK1znuu3As781BytPzKP/Ym87F7Kn3WwKFyAHpCKTap6Lv7H
         dOU1WzDTeXNdu0bcMnsQr0FIC/hRhKiSTgbp3G5N7YzZ3orhRoqblL+A83FHHA9uFquH
         ULAb50RwuvaMq7HsQBHXyGGXS61qpr4BlRpDkcU+KFmt7F5G66utNyq3aXoE9E2KYDIL
         Pd1Q==
X-Gm-Message-State: AElRT7GavMAMEgOLY4f6vBrMKlAu0R+SPn90QfizL41OpyQTvFQtHa0I
        2d9D8BuNlmo699HknR2KaUHvJmHetMMSH3M94X4=
X-Google-Smtp-Source: AG47ELuHQHPpzHpMzySpXtCsUHzKv096spPsaFUABcRYh49EHDamQI6JL68wWNPl87ZxC1edelxLiTlaMmxMJZ4QIxQ=
X-Received: by 2002:a9d:2eac:: with SMTP id w41-v6mr3616951ota.152.1521288009363;
 Sat, 17 Mar 2018 05:00:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sat, 17 Mar 2018 04:59:38 -0700 (PDT)
In-Reply-To: <xmqqfu4z2232.fsf@gitster-ct.c.googlers.com>
References: <20180308114232.10508-1-pclouds@gmail.com> <20180316183200.31014-1-pclouds@gmail.com>
 <20180316183200.31014-2-pclouds@gmail.com> <xmqqfu4z2232.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 17 Mar 2018 12:59:38 +0100
Message-ID: <CACsJy8CVQBgs4s8VyQ2PoVx3kVv+n76ctwjCe_2YkLGiWd2r2A@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] pack-objects: a bit of document about struct object_entry
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +/*
>> + * basic object info
>> + * -----------------
>> + * idx.oid is filled up before delta searching starts. idx.crc32 and
>> + * is only valid after the object is written out and will be used for
>
> "and is"?

There was another field that I thought was only valid after blah blah.
But it was wrong and I forgot to delete this "and" after deleting that
field.

>> + * "hash" contains a path name hash which is used for sorting the
>> + * delta list and also during delta searching. Once prepare_pack()
>> + * returns it's no longer needed.
>
> Hmm, that suggests an interesting optimization opportunity ;-)

Heh.. it does not reduce peak memory consumption though which is why
I'm less interested in freeing it after prepare_pack().

>> + * source pack info
>> + * ----------------
>> + * The (in_pack, in_pack_offset, in_pack_header_size) tuple contains
>> + * the location of the object in the source pack, with or without
>> + * header.
>
> "with or without", meaning...?  An object in the source pack may or
> may not have any in_pack_header, in which case in_pack_header_size
> is zero, or something?  Not suggesting to rephrase (at least not
> yet), but trying to understand.

The location with the header (i.e. true beginning an object in a pack)
or without/after the header so you are at the zlib stream, ready to
inflate or reuse. I'll rephrase this a bit.

>> + *
>> + * delta_child and delta_sibling are last needed in
>> + * compute_write_order(). "delta" and "delta_size" must remain valid
>> + * at object writing phase in case the delta is not cached.
>
> True.  I thought child and sibling are only needed during write
> order computing, so there may be an optimization opportunity there.

See. I wrote all this for a reason. Somebody looking for low hang
fruit can always find some ;-)
-- 
Duy
