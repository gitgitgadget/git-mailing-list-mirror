Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442601F403
	for <e@80x24.org>; Sun,  3 Jun 2018 09:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeFCJBM (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 05:01:12 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36115 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeFCJBL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 05:01:11 -0400
Received: by mail-yb0-f194.google.com with SMTP id o14-v6so10122633ybq.3
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=AoHasRLxeso22NiD8iEQvcjxDyt8kx5DVrCmf1/XYas=;
        b=I/TiK3yRsFnvjXyYmZvpdqOHqArr2PIWy+pKewJbN0GemwHQNs5ali6C5C6xd93tZd
         dN7S/hr5FWDapMRxUxGX47T9wcBs3+or5XuNEFYjPC8Tw8wfp5AfnsF/Uu0ND0omACSj
         y1l7KzNe43ehY4noVjj41nsqn30HTEOyPPSnMdudkTG1mdmLV50TrJeH3Q8yeZGwZbpi
         iCdG7vnYOCMCogmhBVXPucDxvBCB437HfhRhcES41b2A37vx0yH4gSBlfzt8kHnSnqD3
         s2qCIVK+/vL/O6kXfgXMT2hqjpaByCujnLAVxAa8udpt4XxjpTC5KX+4zcoxn7f4L++M
         2m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=AoHasRLxeso22NiD8iEQvcjxDyt8kx5DVrCmf1/XYas=;
        b=L28qEo8er7DyJEICitCRShQnmaN/zdsfGckqP+fnQScquQuiDssdyljmEM/81ZVaCP
         XZ1lbMqoxTk8W9PNv81wQMJPDuxjFcPo6bEE+BP10zan+f1HmIPp5q6vipHn7pnkrOkG
         kL3ZPGT2Ad2dJYpInbGJHA3DtMH0PxOxPs8xY533+oA8JPIjnMAfl0A7R7nEsqd6G+dT
         ic5ZXsIGSK507FkNxSlrH0sZeKN9INQJ+0YKaDK7HjdEIuuDrHRDBfnuGq5jwzz6nLZe
         15QfIhEEUKbqz91wqHeoOJgRGMdYSviDWQHs9+AjPEat6alqOAwrkm8Sed+Hyr0gmH6D
         wLow==
X-Gm-Message-State: ALKqPwc7y9ke6lm9hEltIHeSOIBMuEhACRfST9EoZUb6VpmNVM5z6/zL
        5Izmv6D9k+YqZQtggNm5NeRCOFqPKy+Dkdw4EAU=
X-Google-Smtp-Source: ADUXVKL0vzn0vhc3rMn7EuLoCxDcDWTTr4McjySHgCmDwn4RLKT8J41VCr8cj79fxSslvMOU1L/EqfYZMedmHWbsjaA=
X-Received: by 2002:a25:d612:: with SMTP id n18-v6mr9157829ybg.12.1528016470436;
 Sun, 03 Jun 2018 02:01:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 02:01:10 -0700 (PDT)
In-Reply-To: <20180602043241.9941-4-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-4-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 05:01:10 -0400
X-Google-Sender-Auth: 0RlHktSWq4wZyYPB9Mc5f7ahdS4
Message-ID: <CAPig+cQ8p=V7nCJDgJvD2f7pAjykBjN_4BnjY0XHPugE3yL_Tg@mail.gmail.com>
Subject: Re: [PATCH 03/22] builtin/config.c: mark more strings for translation
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
> There are also some minor adjustments in the strings.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/builtin/config.c b/builtin/config.c
> @@ -746,7 +746,7 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
>                 if (ret =3D=3D CONFIG_NOTHING_SET)
>                         error(_("cannot overwrite multiple values with a =
single value\n"
> -                       "       Use a regexp, --add or --replace-all to c=
hange %s."), argv[0]);
> +                       "       Use a regexp, --add or --replace-all to c=
hange %s"), argv[0]);

Perhaps?

    cannot overwrite multiple values with a single value;
    use a regexp, --add or --replace-all to change %s

> @@ -819,7 +819,7 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
>                 if (ret =3D=3D 0)
> -                       die("No such section!");
> +                       die(_("no such section!"));
> @@ -830,7 +830,7 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
>                 if (ret =3D=3D 0)
> -                       die("No such section!");
> +                       die(_("no such section!"));

In other patches, you dropped the trailing "!"; perhaps do so for
these two also?

Maybe even:

    die(_("no such section: %s", whatever);

Though, that may be out of scope of this patch series.
