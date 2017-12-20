Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F191F404
	for <e@80x24.org>; Wed, 20 Dec 2017 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756712AbdLTTpc (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 14:45:32 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46074 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755583AbdLTTpb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 14:45:31 -0500
Received: by mail-qt0-f194.google.com with SMTP id g10so29693518qtj.12
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 11:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yEAZwowxl3eh2kkx1KdfEymeqcnEB3ltOB/By3NyTTA=;
        b=jWpJYBFWu7JP3fvwFNw4HoBVuaM4HdIaabEoixC3lqFPvVW7i1KeUPRhr24PhTopR+
         v/QfQgPo68alParywMIQEC0P+fRmtBkYdLainYRdYapA3lzHRUYxxGbNDOHum3OQUZqE
         vSfx1SbNEda0DwM3kkL6aoutMg20BBtRepUVlajLCo/i8yDzPoJSD3zN63jWoK8eZzws
         6e/pLJ3pYDAJ1HjQUjccIv5ns9WErNFge8CeK/aU0WfJ8H6SsYVbIHJkEoBANX4BHtYU
         IvrclL3OHFtpEDa6lFd2KORCbEg1pCmhGTFpJR9HWa9urBYew2aYK+S6OiwOvu/qo8+g
         VcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yEAZwowxl3eh2kkx1KdfEymeqcnEB3ltOB/By3NyTTA=;
        b=hs4Ts0XIrBlC/s2+k9sdDUcanVorgqluANipn26PF+ZbjQmutVUbdUDXdGik2liaXz
         O2FrkY7VMoSIkNkpj5thZXRBIyzFucOxGpbPupV/dgalDzNUHgxMf1lIubkKJ+hn0gXB
         b3WY2zRI4yqtzlbIeJ4Y16x2hmrjLaL+8NjfUoce+TyElmM++ZSjFOFbQWfCg1jyJp32
         K6dcTRs1E4uypmZzrGEJUFFr7Vi8hDjseaYJkUvjIsQjA3+YPfxNv7ZwxWJGmhtK/w/u
         5IFzjtG1U4ifuMrhn12oRjPCSL/EsVF6J3+V2I5HNMMCLnm81W60LexkJqDECkcVnTlf
         WiWg==
X-Gm-Message-State: AKGB3mL3TtgtcNbmBOcau8LQ+vS0K6JVsAjA/xpKrMZH9TOloG1p8VdG
        jI6ZdoEtNtYPjMV53P052Mth8NG/YiyLhPVwEn09Ww==
X-Google-Smtp-Source: ACJfBou6a4ifmN2dlK/I8iqc4I/nQKY/yUs2u5FCjOlE/QjMkWoPyqu0NjbmfR1a1VNlKzWwxBJPmNHSe6gkPR0+6EA=
X-Received: by 10.237.35.37 with SMTP id h34mr12108161qtc.9.1513799130709;
 Wed, 20 Dec 2017 11:45:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Wed, 20 Dec 2017 11:45:30 -0800 (PST)
In-Reply-To: <20171220193845.11754-1-avarab@gmail.com>
References: <20171220193845.11754-1-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 20 Dec 2017 14:45:30 -0500
X-Google-Sender-Auth: nV2HDExQOR3-rdqAE-AslN78bDU
Message-ID: <CAPig+cR_erp_U5GJKBcoBnQ+xhWpS4KjTu3sNgRTTO4V==DCsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit doc: document that -c, -C, -F and --fixup with
 -m error
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Pat Notz <patnotz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 2:38 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Document that providing any of -c, -C, -F and --fixup along with -m
> will result in an error. Some variant of this has been errored about
> explicitly since 0c091296c0 ("git-commit: log parameter updates.",
> 2005-08-08), but the documentation was never updated to reflect this.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> @@ -144,6 +144,9 @@ OPTIONS
> ++
> +Combining the `-m` option and any of `-c`, `-C`, `-F` or `--fixup`
> +will result in an error.

This sounds a bit scary, as if there is something wrong with Git.
Perhaps say instead that they are "mutually exclusive":

    The `-m` option is mutually exclusive with `-c`, `-C`, `-F`, and
    `--fixup`.

Or something.
