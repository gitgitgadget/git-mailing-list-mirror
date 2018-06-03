Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0191F403
	for <e@80x24.org>; Sun,  3 Jun 2018 08:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeFCIcy (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 04:32:54 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45623 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeFCIcx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 04:32:53 -0400
Received: by mail-yw0-f196.google.com with SMTP id v190-v6so7229594ywa.12
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mxTFrkDlaHOrhtflcNYX1pCKxtCTb7Z8W4wh5jBMWrw=;
        b=qoAlCmSnzM1ebk/HwkcuQ5NReQbSBawsDWtbMou/0qxIhHGM+RvV/GDeftFDCY9OHn
         9bYimvb3LnSaXp3zzDiTFdX3cWsOnn7SGFCFqKHgt2MuGOs+EVsIwklNGHjxyqOuOjBD
         8HGVz6K0fnaKbXh6vh9wmLKPdD/07m0k17xb4e9rj/wAZsjiXytXNdqW6K5Vubxc/0Pc
         5itNUrXODrK/zpdAUNQ7BDwSVBk49q9QvgQO6BbsgtlFAlZVcbn0cWZEEFTDPqtzpHl3
         gpa4AhYjrKYl1GxH850g40SSSjz9zagiOx6dCoOyR43gItYT4Aniq4jnbA8iITXc98r+
         UHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mxTFrkDlaHOrhtflcNYX1pCKxtCTb7Z8W4wh5jBMWrw=;
        b=hAemJYZd8+AOXIkH04fvjDf8m4Y18CK29uerNkWrYGm0PYikLMpQ1ULbhJuy6TTXlT
         Uay6KUsTxyA00J11bq8FzWuAvuRamsXlep0yRU6IlEEgoHRnnA9CN19KNLwKxpWAYpe0
         7U1FsR32doBlQ8yEfzz0vdbEvW5oIuxFS3thi2u1cHHcVIk7P9Wx29Q6dt1Swpv9t2t1
         lavVBOz3LxmNMA9eZSdHkc86+aJsnfdfBgXhJtwhK33WKtoBVHattw6mZwiPqnCOkwQD
         J6FD6qVQASrRYLnWHSpSVQpLPObiFipmd8UKWXbtWTb6XzQ9RP8ilkWnOHCxRY0r1wXE
         svHQ==
X-Gm-Message-State: ALKqPwdOcUjGvmMg0SV3FECQB+DeZHY67UqBo/E+4oGSOsvGv8dJH1nZ
        DnBXfTzHdHd8PiJQn401d1ppx3zp5jGgwYZd/bzFRg==
X-Google-Smtp-Source: ADUXVKKEFuI4n14kaMIALS7rlugpdi2vV5eVQQbvaL+Vo4m2MxmLu0eAPvjgDO32pdI/rW8ri1Pz9otFKlOSzHdrx2Y=
X-Received: by 2002:a81:7b0a:: with SMTP id w10-v6mr8864536ywc.70.1528014773095;
 Sun, 03 Jun 2018 01:32:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 01:32:52 -0700 (PDT)
In-Reply-To: <20180602043241.9941-23-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-23-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 04:32:52 -0400
X-Google-Sender-Auth: YW7alJqjZI9b1xRtA2DlMNKYNac
Message-ID: <CAPig+cQKoF9EGMONWBxn6dKibTxuKcNeLH_3n+_=wYOrugK1KQ@mail.gmail.com>
Subject: Re: [PATCH 22/22] transport-helper.c: mark more strings for translation
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
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> @@ -196,13 +196,13 @@ static struct child_process *get_helper(struct tran=
sport *transport)
> -                       die("Unknown mandatory capability %s. This remote=
 "
> -                           "helper probably needs newer version of Git."=
,
> +                       die(_("Unknown mandatory capability %s. This remo=
te "
> +                             "helper probably needs newer version of Git=
."),
>                             capname);

Did you want to downcase these and drop period for consistency with
others? Perhaps:

    unknown mandatory capability '%s'; this remote
    helper probably needs newer version of Git
