Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C139E1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 08:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeFCI3Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 04:29:24 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38669 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbeFCI3X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 04:29:23 -0400
Received: by mail-yb0-f195.google.com with SMTP id q62-v6so8632494ybg.5
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=AJOLd44hv+1iEB0CIcF/q3SRPMWHoH05XJ5VtKSo7ak=;
        b=HBCIHDw9WGPXGcHsviQZA8xbHPF9nuIjzAokOS4UPGCR5XLfQy8USVjsCf+6kOcfgD
         w1A+IavWK4IE4ZEkSWdZXvZPwGS1iPcFYU8BvswR0+2FHcxb/BfDeI/HZ67UGtWPUxwv
         UgzV3yD0QVZvha7QPHvtvIOs1USuY9PbGytSYMUwZDHtE66jVpuIXJoDuGdIE9WsbIc/
         WnTXtkxXToWmvtukXDSKwBUg+95TukFYxdS4DvhFStFkremVIHS+ThY7Dk8ePldYkIY8
         NiZnYIgWbNFVFoids9B8x8IJAfBznoAB2Zckxlv7mnWOgarQZuPnCE2R/xJlnAB5Vsp9
         oUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=AJOLd44hv+1iEB0CIcF/q3SRPMWHoH05XJ5VtKSo7ak=;
        b=moeIjLn7ZCtry2rhdWAv5e6uQwmhqrXZV18tC3OQUGtngfsR5fiOtEKqn5Z4Znw2RD
         bV/VF3ozcqepqXp3v4oDazSIqYp51Y9fkIFVzFH/Qm3lguiQgY0+2+xrhVuCeLfOU80o
         DoIfoqvXD03kvj69BlDD22e8CJ/bsMIU4YoW+Hmr/g1iuflk5e4SmAyL8J3+iLwZ3xGs
         esEbsoIQphebMg4lY+Y1g1tgZ5g5gTwoxNLHNxNP6UU4aqvkCD5DNwYWuEPZNUoPvDX1
         yfxMQqtAsliOdnDoASaKS50BdpP0ddCGhi+AEyuZod9KgYfIrzLJAflGEoUtp8F+flq1
         LBhQ==
X-Gm-Message-State: ALKqPwc053O3XmJR9B7tlJeGvHqfDHKWXx125DxDSaESV4oZU0+R8VsZ
        2kbGoLLhmlstw7PWihDPPu3ITijXv1zi0bmwO3NiOQ==
X-Google-Smtp-Source: ADUXVKIILvtbWQj2/1lvp9VB9M5C9WGOSZ9Nk1ZSSvbGRlr6aCDjnJ6T80HMepWu9LYfqGmfD/s70cipbLpJjmwvzmA=
X-Received: by 2002:a25:9789:: with SMTP id i9-v6mr9046353ybo.497.1528014562440;
 Sun, 03 Jun 2018 01:29:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 01:29:22 -0700 (PDT)
In-Reply-To: <20180602043241.9941-22-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-22-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 04:29:22 -0400
X-Google-Sender-Auth: Y7ds2e-Sg7W_07f6XFFdWejSt08
Message-ID: <CAPig+cSVJq8iaKJDO_AiFs6-01PbtoRj1=56cv6_nNPQwEPacQ@mail.gmail.com>
Subject: Re: [PATCH 21/22] transport.c: mark more strings for translation
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
> diff --git a/transport.c b/transport.c
> @@ -875,7 +875,7 @@ struct transport *transport_get(struct remote *remote=
, const char *url)
>         ret->progress =3D isatty(2);
>
>         if (!remote)
> -               die("No remote provided to transport_get()");
> +               BUG("No remote provided to transport_get()");

Did you want to downcase "No" or just didn't bother since it's not
intended for end-user?

It looks like most callers of transport_get() won't pass NULL for
'remote' so this makes sense as a BUG(). A couple callers,
archive.c:run_remote_archiver() and fetch-object.c:fetch_refs(), get
the remote via remote_get() but don't check for NULL before
dereferencing it (before even calling this function), so will crash if
remote_get() ever returns NULL (assuming that it ever could in those
cases).
