Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E2E1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 18:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755453AbeAHSih (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:38:37 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35903 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755000AbeAHSig (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:38:36 -0500
Received: by mail-qk0-f195.google.com with SMTP id d21so4397317qkj.3
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 10:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=++Jcazy5gmnT9yXVekWMCfB8IbTei6RRedAZEM/NffI=;
        b=hGwKb5e18TZUn3yAwJSV9KLZZA9tSbPk7fbJDHT9qGVyqDGW4xnLzHAAWikHqHvFDV
         9yQxUwsJ/BVgLqbd2y6PIuU+BnqnEYZujCwE7Ss8SIf8btl1FAzwfCes27NrZu8QEv2h
         ++5hZi0laAXR4Bn8KRnsVzQ7TcDlQUiYXLpP3yT2AVOuMmpnMy9YL1CsrrnYLDlt7tYW
         rBnjF+vS2ApAa40GTlPvA2SgbOE+18l8i43lewteaNoU6Ea2TwDgWrtyWD0teqLqke84
         KOlHGvjSwqLXJnu+AgEvAjV2yEgXCu0T3xyfZ/f9i+NORyzJ6iYJiiuQoyLVmBZcBBCf
         ffuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=++Jcazy5gmnT9yXVekWMCfB8IbTei6RRedAZEM/NffI=;
        b=Rlac8dCndfvt78quyrFCp9VnW30QO3xYW+uCDS2yns7+skwjn9WJPujrGNhwrXlUeG
         dvgr6OZlAeocS2f2sMdJsMJopYNqcRxe4ivER6iMOvG6Fn9jvrJatdz3onRpqTViETjz
         dkVPnlYTZXeJvt980gGY/KYU5ffQHrKWS38+FmF84EWzGv9gyUAUy7fr0ZvLjTpIEO09
         KkTtac5yR6O6IlwX9dRbQ3l58F551dK7Oj13GVoQnlQqzDfl0SlkHd2NapNs8V3qNon1
         tAHGO2/URbqc+dIz8h7UTdPM+mjTDOTpeAh/9AsLogA09MechTH6NToMzaPXuBfQzluo
         D9dQ==
X-Gm-Message-State: AKwxyteSUH1hc4NLkUSkPaAcApjP3XcTpU88eouSj2FQ7qVxWPBGvG8Q
        sLVmuQi5n0ACbkHCGpVQggL834KgRU6EXix8N93YSA==
X-Google-Smtp-Source: ACJfBovu6VCem7E4xKIRybRmLNz49RxzL31u2hi5OGRw2W7xvnA8WJkITvTLDWMqmHGt//zMWxYNpCVJxnNF4YI1Nq4=
X-Received: by 10.55.72.75 with SMTP id v72mr16816664qka.295.1515436715778;
 Mon, 08 Jan 2018 10:38:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 10:38:35 -0800 (PST)
In-Reply-To: <20180106184614.20115-4-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com> <20180106184614.20115-4-kaartic.sivaraam@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 10:38:35 -0800
Message-ID: <CAGZ79kYrp_DAaiDzpiWbTSvsfud=JHSO+NX3UaC4osAE3dYmmQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] Doc/gitsubmodules: specify how submodules help in
 reduced size
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 10:46 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  Documentation/gitsubmodules.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> index cb795c6b6..3f73983d5 100644
> --- a/Documentation/gitsubmodules.txt
> +++ b/Documentation/gitsubmodules.txt
> @@ -63,6 +63,9 @@ Submodules can be used for at least two different use cases:
>      * Transfer size:
>        In its current form Git requires the whole working tree present. It
>        does not allow partial trees to be transferred in fetch or clone.
> +      If you have your project as multiple repositories tied together as
> +      submodules in a superproject, you can avoid fetching the working
> +      trees of the repositories you are not interested in.

You do not fetch a working tree, but a whole repository?

>      * Access control:
>        By restricting user access to submodules, this can be used to implement
>        read/write policies for different users.
> --
> 2.16.0.rc0.223.g4a4ac8367
>
