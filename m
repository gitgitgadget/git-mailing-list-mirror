Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6941F516
	for <e@80x24.org>; Sun,  1 Jul 2018 05:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeGAFiO (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 01:38:14 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38882 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeGAFiN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 01:38:13 -0400
Received: by mail-ua0-f195.google.com with SMTP id 59-v6so8188432uas.5
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 22:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kq/jflgjhQzLBnhHENCmpyX0yOVZBbbe2DmOXWuchTA=;
        b=mT45WSHFPLmR8FpvsV3Rw8/UN5YKVaa+X01DFHG41+jf8377SobMIBVeKTNXT1mu0R
         6iQHPpQXuI6oDk8yrZmXy2/VLJeFWa0LhGjMNvMQSFYVre1xsJKzNs3ORrmaQTsU1Zm5
         PpOvgm6RTThu9uXY6mvUq01gVVhfKHB4g4PpSV+diMdTjyd5vh/ImGTzwZwWPUxZaF3v
         c3LZMAEoeAB1ThiXd67bOAH2iDbNhYJdxiF3ZUAVTceCHY0BllLxygklLBRyedqOQNp/
         h5NPjIzoqhR4Xcs7tSmuQUy3TwuxpDOTvnDY+PbJ0IJSnaiBhAD7yWt27O259z9wtm0W
         sONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kq/jflgjhQzLBnhHENCmpyX0yOVZBbbe2DmOXWuchTA=;
        b=p3mxo4YNlH+9rxk/kleU5sV3dKUHbGqhcl+kSD02NgCB8HHBTNejBMxTBZubvKR08r
         qHv6btCsxRtaKXiimPLOjGMfgLYabtmYbXEZM616C8VAXu5h+XH9EAsE9gRan10giXMY
         J6I/tG6REMHcik4VE2kn4zfGag8DTwVjOKSm01Z4nbt4jq8xFnOC/FpmtbTj0iUA5UK/
         hZ5O1nttvpThoKOwmpSWMaivbSS9HSKlM3uTUwTASiCyulohtOFLAUtIVvlneqxhdlX9
         WbZoBMwcgaVlSLhO97wgl5DlprvDsWMDqoVkpzHLIxZqejbKZBdnfaYvHgst9Mi7yVPC
         poDQ==
X-Gm-Message-State: APt69E2rZDeRgNl2eUITCF89G9grO69lwJssQheYO35x9I/+4DVX+d9v
        hmu8iTz1PkLniOCvCZNuCUIkMPG65Pzqjh52Ym4=
X-Google-Smtp-Source: AAOMgpc6I4zT8dBS7uudvxC69KYx07DTZaKEVWbcIeOoVpviJ3gsitEP+nMCMwfpml6ogd6rced+Nhadsoroobv3u5o=
X-Received: by 2002:a9f:3563:: with SMTP id o90-v6mr8140895uao.79.1530423491706;
 Sat, 30 Jun 2018 22:38:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 22:38:11
 -0700 (PDT)
In-Reply-To: <20180630090818.28937-10-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com> <20180630090818.28937-10-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 Jun 2018 22:38:11 -0700
Message-ID: <CABPp-BHQSTxe4=adMSo9Arg0QT7-U_SjsU-AgO42cHiMgUxPog@mail.gmail.com>
Subject: Re: [PATCH 09/23] config.c: mark more strings for translation
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 30, 2018 at 2:08 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:

> @@ -1409,11 +1409,11 @@ static int git_default_push_config(const char *va=
r, const char *value)
>                         push_default =3D PUSH_DEFAULT_UPSTREAM;
>                 else if (!strcmp(value, "current"))
>                         push_default =3D PUSH_DEFAULT_CURRENT;
> -               else {
> -                       error("malformed value for %s: %s", var, value);
> -                       return error("Must be one of nothing, matching, s=
imple, "
> -                                    "upstream or current.");
> -               }
> +               else
> +                       return error(_("malformed value for %s: %s\n"
> +                                      "Must be one of nothing, matching,=
 simple, "
> +                                      "upstream or current."),
> +                                    var, value);

Patch 1?


No other issues noticed.
