Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC881F403
	for <e@80x24.org>; Sun,  3 Jun 2018 08:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeFCIq0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 04:46:26 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:45880 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCIqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 04:46:25 -0400
Received: by mail-yw0-f193.google.com with SMTP id v190-v6so7233790ywa.12
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3FM++eoyIwqPs4TPIL+0cGXLxLZGcC9ZmEFDgUAF7ng=;
        b=PiuGFQFft2svHEl4ICLAoLKgcZarDUUs/b62eeANQISR1sqXXChpQulhw4UD8z9eKJ
         thP/+gYFXll4GvTbr2cQ1WYdF4V5qakfa/4QI4VxbvI9R8BfbL+LRtC1if90/SKOPrhm
         w9h8s5QSyZYdgn1vfl/whiR3rCntvGtjkT9JDscbtmMIOgROitdG7rqKocJTHNoTrgoq
         FgO5sP1ruvSF1sp79+MywwqsXZEmb6QeC0Qtv6eGuF0xg65J8/a/rAn29QPrQcarKwW0
         cTRQ9R12PwCgW8zro6JnsUq1yrloi39AVvmsoP1YhCJF4jqNiX9Ne/FC+f1Z71AUevQp
         6oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3FM++eoyIwqPs4TPIL+0cGXLxLZGcC9ZmEFDgUAF7ng=;
        b=te59bJ/bsvgq7skkUib08X6oDQEtoadNJfGi+/cjV0ZscuGaHXOZPhmDZu0kTKQbYH
         XyShoWaJipxWWV5SllT83NYfuMyY4AEXDn7B52qKPB2cE9SZ/JTWpM2j+Eqs5XQL+J66
         A41vYve6PgUuSErK2KktNi5N1p5RegiwBu9teArecVgDIFNZMRt+I5jt9doRxPmY9iLo
         dqmAYqHS+reeJl0dX3VOkf1ZICFh3vJHYCIQn2zGs1twJT8/pV2aDTt3zUFpfBL1MZGM
         +37Am17p2gMu4/3+n2VsC201MGgL7IPD7cQUZMB4n5AoOhm8YzCZb6Ip/48ZDhjGsfLy
         uM5A==
X-Gm-Message-State: ALKqPwc+9JIxYP0QnfrBg3CLkdFlzW53bbKEjZrRGTe17DvZqR1Q8tEU
        JHJq3cbEYHKMBIOaHTS6ONeecA3RA65osC8fYy0=
X-Google-Smtp-Source: ADUXVKIFxC04i0gj5FtgWSvqdo/1/SvLNxSghTL10ollO3H49JVsIDwk4BVvylkzQxn/a6m4HbVsVXxev9Ia/s5hIRM=
X-Received: by 2002:a81:7b0a:: with SMTP id w10-v6mr8877791ywc.70.1528015584908;
 Sun, 03 Jun 2018 01:46:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 01:46:24 -0700 (PDT)
In-Reply-To: <20180602043241.9941-11-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-11-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 04:46:24 -0400
X-Google-Sender-Auth: xMcsj088HGd9-3zvjTks1cWWGeU
Message-ID: <CAPig+cRP65ioZ15RvTuyCqxYJY4wDAYtCepQ0kM1-g=q9rzueQ@mail.gmail.com>
Subject: Re: [PATCH 10/22] convert.c: mark more strings for translation
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 2, 2018 at 12:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/convert.c b/convert.c
> @@ -203,11 +203,11 @@ static void check_global_conv_flags_eol(const char =
*path, enum crlf_action crlf_
>                 if (conv_flags & CONV_EOL_RNDTRP_DIE)
> -                       die(_("CRLF would be replaced by LF in %s."), pat=
h);
> +                       die(_("CRLF would be replaced by LF in %s"), path=
);
>                 else if (conv_flags & CONV_EOL_RNDTRP_WARN)
>                         warning(_("CRLF will be replaced by LF in %s.\n"
>                                   "The file will have its original line"
> -                                 " endings in your working directory."),=
 path);
> +                                 " endings in your working directory"), =
path);
> @@ -217,7 +217,7 @@ static void check_global_conv_flags_eol(const char *p=
ath, enum crlf_action crlf_
>                 else if (conv_flags & CONV_EOL_RNDTRP_WARN)
>                         warning(_("LF will be replaced by CRLF in %s.\n"
>                                   "The file will have its original line"
> -                                 " endings in your working directory."),=
 path);
> +                                 " endings in your working directory"), =
path);
>         }
>  }

For these two, perhaps:

    <blah> ... replace by <blah> in %s;
    the file will have its original line
    endings in your working directory

> @@ -492,8 +492,8 @@ static int encode_to_worktree(const char *path, const=
 char *src, size_t src_len,
>         dst =3D reencode_string_len(src, src_len, enc, default_encoding,
>                                   &dst_len);
>         if (!dst) {
> -               error("failed to encode '%s' from %s to %s",
> -                       path, default_encoding, enc);
> +               error(_("failed to encode '%s' from %s to %s"),
> +                     path, default_encoding, enc);

The whitespace change on the second line fixes alignment with the
opening '('. Okay.
