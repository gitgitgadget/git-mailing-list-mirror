Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1261F403
	for <e@80x24.org>; Sun,  3 Jun 2018 08:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeFCIvl (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 04:51:41 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35286 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeFCIvl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 04:51:41 -0400
Received: by mail-yw0-f179.google.com with SMTP id v131-v6so6810114ywg.2
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FpZNhaMquGGEWieLzZhjLdHPhbZsjnqKkmoqGktiOBQ=;
        b=QYFKw3WAmVmt/y1PIfZ1JBz7S4ZsVcGfxtJ9JMd6mObt3E3IjLCtEteoNiAJDhEmNA
         nMaAN4DP+lgxUR9dUWK4G+X4nDgkbpHzhjM9R0fGZgrB8L07DZnjte1YrsspE5irYPPr
         yCcfcFvH1VqEpaBHM9RmBaU+TfhU4CVjV87SyzaRNO2cF1YUqiF4Vw7R72E6s4yOGCwy
         rkzvYXaCoswwpYMerr/vTWIE5LDaVoW1LYXM6xzooP6zd9hi74G3Tmm9Vp1Uf2EMvRy0
         gLEQK7esw7g8pML0PfoZooN6ymQwgN8J6J0AU2BtMtp0F9BxqacJorkyf5lmx95A17X4
         lGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FpZNhaMquGGEWieLzZhjLdHPhbZsjnqKkmoqGktiOBQ=;
        b=PDql7bX190UKcVwT8u2GwLrJTQQtPlXknmvsEAg17RsQ3q2D538q9Op3rOPjeDAtYc
         NeA50IYAbNA4KxbcZbjUFJ2aHDxcBsA9c40lr8sxrL3FytX28/sUdQ3nLBZhKal4ejON
         Yd/kwzpoRKr9VQKqU8wF59QwdxKuJcsZzBdrVRfI7gAXMBUfEcTGxzvL3JitCTDAMsHo
         bLwkYBTQyrzeVVkxmyMPeHao3TFpW6HtQSTZmfFlc2R0Uclum46qsKl295TXpzWLoAeq
         Cog2x2AdIg5OovTDiigIRiiwkUSY1Nb5zcubLtAbOdXH5Deq74M94mPIwT2lCbSlq6iL
         T49Q==
X-Gm-Message-State: ALKqPwciC+FzxI3d9aP8fScikQomVwTjpb8ELVThmGAn4CewEGEtcpqT
        hzaEA7VQ2IJLdDdem9pqy+wxosc16U1LAmpKzTA=
X-Google-Smtp-Source: ADUXVKJ07Gc3r7kZxzrreh3Un5zz3T3lrKOryiwIOPrwYZtFpphZD5h8bF4Zv+9+GZWPE/63Q7xWTa3mZCKGdtRYynA=
X-Received: by 2002:a81:4303:: with SMTP id q3-v6mr8709863ywa.98.1528015900452;
 Sun, 03 Jun 2018 01:51:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 01:51:40 -0700 (PDT)
In-Reply-To: <20180602043241.9941-9-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-9-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 04:51:40 -0400
X-Google-Sender-Auth: NdGfaPyywJyrOgSApuZerLL6xUk
Message-ID: <CAPig+cSZSA2x2oj-thF7G3RYd80gmh_3W0vUsT_n1ZLUWLRjGQ@mail.gmail.com>
Subject: Re: [PATCH 08/22] config.c: mark more strings for translation
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
> diff --git a/config.c b/config.c
> @@ -461,7 +461,7 @@ int git_config_from_parameters(config_fn_t fn, void *=
data)
>         envw =3D xstrdup(env);
>
>         if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
> -               ret =3D error("bogus format in " CONFIG_DATA_ENVIRONMENT)=
;
> +               ret =3D error(("bogus format in %s"), CONFIG_DATA_ENVIRON=
MENT);

s/((/(_(/
