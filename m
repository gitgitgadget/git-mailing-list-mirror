Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D5220248
	for <e@80x24.org>; Wed, 20 Mar 2019 20:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfCTUbI (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 16:31:08 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:34050 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTUbI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 16:31:08 -0400
Received: by mail-pf1-f179.google.com with SMTP id v64so2756501pfb.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4xuseoPq4KKvjLAraV2j1+mxKUWAbIvG8FCATPoCTlw=;
        b=FzrCepnFXbZ0WzlB4733yMUow7ywo3x4LIzOSR5DklCD7IHs12KXnPU3blpBv/Ov70
         oPAHWlFnF0sLkdBgU/c+yjYYRrPzY+ZAHFglNW3mDNHByBQmwNCvzm87KpSjQLyBBF4M
         UNp/zVk9FOY+myIzUYlO3U4O7wpEhT4jG+hmqZG9xCubXgWCoq3xRy3wo5cG/rlydJzW
         1u+SkPe6hjIASylHsgtJfs5zbGC3XM7EmrAo80X6ihtD3m0AaDh+mdBBsiyqut8q7tI+
         FDz0hzyiHKiBI0J+70UFskDn5AcXgotM+Wo7sZcdzi1TvgXapKxFgvGabHgBQuds1+1U
         dEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4xuseoPq4KKvjLAraV2j1+mxKUWAbIvG8FCATPoCTlw=;
        b=GkTmwrjYQMZoL/JhdxB8DeD2k9UjnTMjHPTyzvObI9poEiLVgaSICcf7KJiXO+z5qD
         d4QVk1FRThsKgxoPAWtvt6fmBV3FE/P01BJVpQd1J6v4sh+5go8fH4jYu9BhMLApY51t
         HNswE0oHdRcdUJ+7blMoG92WQLmTw/deooMLPVWNS+b3oj86rs+TbkyQJwHYkSj59X/9
         ZwZbqRZX6dXq5xBftR2sDG09nHPuBcW16YFsZtjeKOAcRg5KozyKWHg1inn+oL0bikFY
         mCCiN/eLe1ec7D4S7hTCdQ58lElxf47iEhUF7BNXk1pQq3OJEbNZV4xMBf5XihCu/BEw
         iSYw==
X-Gm-Message-State: APjAAAXKUQ1xHZSk4urx5e+Vb+Jq75agYlb7r0JAzqv3u05Gwlpo5PvA
        msyWMW3CDQlrezWgad89KgLiax+2kp7IR6IhePSzSQ==
X-Google-Smtp-Source: APXvYqzKKJ3C/nwegit4sNdb3oa/zIXMO9jDtLzgoiQKlrcP7Y3I1nau+8ArxqveEWDHtjsX0wXLIuEWqm9LuVctBn4=
X-Received: by 2002:a17:902:9001:: with SMTP id a1mr9872658plp.96.1553113867577;
 Wed, 20 Mar 2019 13:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190320114703.18659-1-pclouds@gmail.com> <20190320114703.18659-14-pclouds@gmail.com>
In-Reply-To: <20190320114703.18659-14-pclouds@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 20 Mar 2019 21:30:54 +0100
Message-ID: <CAN0heSonEy5z_2ebwQfr35Y-y4n8j-WX2=LdT6Lu3zi7YMhJBg@mail.gmail.com>
Subject: Re: [PATCH 13/20] diff-parseopt: convert --no-prefix
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Mar 2019 at 12:50, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:
> +               OPT_CALLBACK_F(0, "no-prefix", options, NULL,
> +                              N_("no not show any source or destination =
prefix"),
> +                              PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_op=
t_no_prefix),

s/no not/do not/
