Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B471F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbdLKXrx (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:47:53 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45102 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbdLKXrr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:47:47 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so17567931wme.4
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 15:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FImw1b/3eaHTYWqrPoBiVKJmyGEXo11qsG/ZHU8nIjk=;
        b=robhG4wJB+b1UMn6r2r9aHtaaBT6iDPIdpw33KasDjnksBX4S0xlyLxLy3XdDyIOhw
         3T89kxPmZEvzybjfLkA7ewQyocrpRxtWSfeMMmefHOSxG+f0mLmPiXUfh+EJTL562hEN
         zYp3iazcTPdub2BGGTvIFBNPdbQ376ErnmxK/M+sauIqdntflRM/1VvdkrJg3nNATC8I
         3qAcOXw23krLpS5W8U/doC6lMW9sjg6IYjSffOHe4iY+sWUEjFHmRSmHgwBDlsBNY8gN
         Cx5aObbNgpBnT/cPmuwh7qJ0iOjAx3kdDUj//MDzpsFWYdojVK6TAQk4DKvdbE3u3dpM
         98AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FImw1b/3eaHTYWqrPoBiVKJmyGEXo11qsG/ZHU8nIjk=;
        b=CQdBFXIkXh1cxUvbZKWDGRFWTu7e2Xh0itEdV9fGmtzB8FigIbh5dbQr1PDmMM+li0
         eLsMAM0Pkr6yNm4ldG2K4RCucbt8pVE5/ApmAsf5JFYjjgzmamJIRabc8jL+68SJr9Ic
         seqEckYSxVuBj0UXHBlBsdkt+79pxZRLxb9+S0CCir9Y/WopgqBiJUGJpsiJtRAUw/Rv
         qtg0NPaDoktAUkNK5DSaO6K/MPDlE4sDe0X10nDKLr8fYaV6FVr5Wmz5shtMukGLE4C7
         8AD10y3638Y+KuynguoUyOLTi80otZY3rHU80pWADK4Yti0LNNxQ/f4OmB5JJzSexPhJ
         4/jQ==
X-Gm-Message-State: AKGB3mKXt3R2UzzIQhFVthyXen8Q2yRk1PcCEbbziQT9anH2nlKSqgZH
        v+qTSdYoW5bDPo6e4M+kyT8cbQ==
X-Google-Smtp-Source: ACJfBovpLIqxG0hKW5BOmV5haK0xUTmcVIvou2At2DQJ3Wbkb5gZhh5gzFKQfRCK9WYHsLxxPwuwSw==
X-Received: by 10.28.4.146 with SMTP id 140mr35373wme.38.1513036066506;
        Mon, 11 Dec 2017 15:47:46 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB687E.dip0.t-ipconnect.de. [93.219.104.126])
        by smtp.gmail.com with ESMTPSA id v47sm17692846wrc.13.2017.12.11.15.47.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 15:47:46 -0800 (PST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cQ6VSXXSYJOiZeTqUpwijVhvvUYzXF8U3KCBsOQ91HPZQ@mail.gmail.com>
Date:   Tue, 12 Dec 2017 00:47:59 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>, patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <09713FC5-9D71-4B39-BFA3-0CB9C63321A2@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com> <CAPig+cQ6VSXXSYJOiZeTqUpwijVhvvUYzXF8U3KCBsOQ91HPZQ@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11 Dec 2017, at 19:39, Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Mon, Dec 11, 2017 at 10:50 AM,  <lars.schneider@autodesk.com> =
wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Git and its tools (e.g. git diff) expect all text files in UTF-8
>> encoding. Git will happily accept content in all other encodings, =
too,
>> but it might not be able to process the text (e.g. viewing diffs or
>> changing line endings).
>>=20
>> Add an attribute to tell Git what encoding the user has defined for a
>> given file. If the content is added to the index, then Git converts =
the
>> content to a canonical UTF-8 representation. On checkout Git will
>> reverse the conversion.
>>=20
>> Reviewed-by: Patrick L=FChne <patrick@luehne.de>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/convert.c b/convert.c
>> @@ -256,6 +257,149 @@ static int will_convert_lf_to_crlf(size_t len, =
struct text_stat *stats,
>> +static int encode_to_git(const char *path, const char *src, size_t =
src_len,
>> +                        struct strbuf *buf, struct encoding *enc)
>> +{
>> +#ifndef NO_ICONV
>> +       char *dst, *re_src;
>> +       int dst_len, re_src_len;
>> +
>> +       /*
>> +        * No encoding is specified or there is nothing to encode.
>> +        * Tell the caller that the content was not modified.
>> +        */
>> +       if (!enc || (src && !src_len))
>> +               return 0;
>> +
>> +       /*
>> +        * Looks like we got called from "would_convert_to_git()".
>> +        * This means Git wants to know if it would encode (=3D =
modify!)
>> +        * the content. Let's answer with "yes", since an encoding =
was
>> +        * specified.
>> +        */
>> +       if (!buf && !src)
>> +               return 1;
>> +
>> +       if (enc->to_git =3D=3D invalid_conversion) {
>> +               enc->to_git =3D iconv_open(default_encoding, =
encoding->name);
>> +               if (enc->to_git =3D=3D invalid_conversion)
>> +                       warning(_("unsupported encoding %s"), =
encoding->name);
>> +       }
>> +
>> +       if (enc->to_worktree =3D=3D invalid_conversion)
>> +               enc->to_worktree =3D iconv_open(encoding->name, =
default_encoding);
>=20
> Do you need to be calling iconv_close() somewhere on the result of the
> iconv_open() calls? [Answering myself after reading the rest of the
> patch: You're caching these opened 'iconv' descriptors, so you don't
> plan on closing them.]

Should this information go into the commit message to avoid confusing
future readers? I think, yes.


>> + [...]
>> +       /*
>> +        * Encode dst back to ensure no information is lost. This =
wastes
>> +        * a few cycles as most conversions are round trip conversion
>> +        * safe. However, content that has an invalid encoding might =
not
>> +        * match its original byte sequence after the UTF-8 =
conversion
>> +        * round trip. Let's play safe here and check the round trip
>> +        * conversion.
>> +        */
>> +       re_src =3D reencode_string_iconv(dst, dst_len, =
enc->to_worktree, &re_src_len);
>> +       if (!re_src || strcmp(src, re_src)) {
>=20
> You're using strcmp() as opposed to memcmp() because you expect
> 're_src' will unconditionally be UTF-8-encoded, right?

Yes. But since you mention it, I think it would be better to use
memcmp() here! Plus, it might be a tiny bit faster ;-)

Thanks,
Lars=
