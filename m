Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BDF01F403
	for <e@80x24.org>; Sun,  3 Jun 2018 08:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeFCIla (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 04:41:30 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39672 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbeFCIl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 04:41:29 -0400
Received: by mail-yb0-f194.google.com with SMTP id m137-v6so7790545ybm.6
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3FKaunGDMuTEg88UBX7avskp1PMX3ykyDomJvXUDfDQ=;
        b=YQ0JU/SH6eQ80cEN3NiDA/xtJPaaqjJ2Q/Ua9xldMPZ3IDcYwoYR36yLNL+ih7f+JU
         dzubATJXSngZ6BJqGx++UIbB+n542d9CCeQKYJ5zJa40N5djNf2jfbmGncdJovmKMEQw
         /eZFpnG76tpoe7/QblgMby+ng59q8bQ4VQxsEooOFOzXhm3xd4fGD3ZahzOCOMbrXZuA
         lBhwBO2fivfvwP+R2pjDo6roKNJ8OfGjDDnnynFtAb3Km+nXdlCtFwkyxrLuUxEaciXB
         JlVoBwdLaWv2yWZ2i7bcW7pBrZWsEk/xexW3Z15Lqzphlh9kgtCLEwv/HTywX5KklXnQ
         S9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3FKaunGDMuTEg88UBX7avskp1PMX3ykyDomJvXUDfDQ=;
        b=HpwuWOYJNVyoSS+Wk5lk9w6X5KKU4hBO5gp6gmdY3Ae2R2WJdl7j1QEc3Dwd/KxmXg
         cpntXPN7RbCfrhw1mi7SrPlnT3GD/+veaS3VuMGkfliQcHxLXNW6LipzGW4Prck9AIxr
         32nS3Hs3aj2HaN9Pl1Zkf5KAK2dsW5PJpcLAmGfYtrmi8GNQjbu2UxTwcebgLxuYYvSt
         hrfE7pRB8yU9q0daLLlMK8jL/JMIP80nS+ugEXkpLf1Wif5KFRyHB60hIPPsaSc3s4Nm
         kAPvx6q5NMNVK9fMu2sWpvFL2nmYe134Vm9uV8aaYfby64SuCMOxYHu7ScVIAMs7Ukto
         pdkQ==
X-Gm-Message-State: ALKqPwfpNet0USTfjpQ0OJrq8SjYe3ky8sUXHwO1Ylg6ygyx99VhzAs4
        /+slayLaIVpUeMMU2uixLCEhYppa9JPGMwPMfRo=
X-Google-Smtp-Source: ADUXVKIWqbs0aQTcubV033FpoyD0ElJQ/BqOHSTutzetzdTFM0hw/Xn1YTx7MSPMpErreJptlEXkC7xjwici7yme2BU=
X-Received: by 2002:a5b:a8b:: with SMTP id h11-v6mr7692720ybq.287.1528015289057;
 Sun, 03 Jun 2018 01:41:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 01:41:28 -0700 (PDT)
In-Reply-To: <20180602043241.9941-7-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-7-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 04:41:28 -0400
X-Google-Sender-Auth: mfcQOrYFDTIh-mhZN2WdDErChWs
Message-ID: <CAPig+cSnPhi1e4QZ=ZJBC2aS0n7gfwo=q-bR22W_dj_QjJbLZw@mail.gmail.com>
Subject: Re: [PATCH 06/22] builtin/replace.c: mark more strings for translation
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
> diff --git a/builtin/replace.c b/builtin/replace.c
> @@ -456,10 +456,10 @@ static int create_graft(int argc, const char **argv=
, int force, int gentle)
> -       if (remove_signature(&buf)) {
> -               warning(_("the original commit '%s' has a gpg signature."=
), old_ref);
> -               warning(_("the signature will be removed in the replaceme=
nt commit!"));
> -       }
> +       if (remove_signature(&buf))
> +               warning(_("the original commit '%s' has a gpg signature.\=
n"
> +                         "The signature will be removed in the replaceme=
nt commit!"),
> +                       old_ref);

It's kind of weird to drop capitalization of the first sentence but
not the second. Also, you dropped trailing "!" in some other patches;
do you want to do so here? Perhaps, instead:

    the original commit '%s' has a gpg signature;
    the signature will be removed in the replacement commit
