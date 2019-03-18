Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF52B20248
	for <e@80x24.org>; Mon, 18 Mar 2019 23:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCRXz1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 18 Mar 2019 19:55:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45563 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCRXz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 19:55:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so3664448wra.12
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 16:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Osd/TsZv+BmYdMLwHo79Ou3LQQxzD6IsDmJ26py0m2s=;
        b=pFjmlEzUcGDXoGagScC8Lz1h1w5NBF1vfs4kZ14BsT42furfOAeisxvgwS6Rdo2b5z
         55oRMTMRyAQZ28TRGAtelPGlJj5TKIebcFDLrqKRdyL12GvvZxPbxQOR5/Ojl2seUM5q
         0qDY+YRFlipXAqfdtutDPKnjbUD3K/mf/Kpfa+J7d6HmELn2UW1q+jmQY8P1T0qbuRzG
         1IA3Q2Gdx04WP0AitXWrVKR4eCbB7pfNOtcpxveR6CJ7+IeGhFWLGeUfrXXu747bFiKO
         vQgW+SKp3l+lKcp/YowmJMrdguMCtmBZYqeQES4V2nFDiSGxnXLyh5/8Des390dcJCK8
         Z++g==
X-Gm-Message-State: APjAAAVNS8vmXWIeGKKq/Nexp4dsXgZbpqTR40hKGbAjnnuZo8dGVkCh
        LIV8GDFqbBPT30o+dOVmOM259RqVOiGzm41K+uI=
X-Google-Smtp-Source: APXvYqxpnNtncKWLux2lyj4qvrRA4wLN+eXLcexptOp49Stb9sEVlT7TG01XAlCKy75tM/Lhcoo+I+xWdnmYzYkNfVc=
X-Received: by 2002:adf:eb02:: with SMTP id s2mr14559378wrn.40.1552953325659;
 Mon, 18 Mar 2019 16:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190317124926.17137-1-pclouds@gmail.com>
 <20190317124926.17137-15-pclouds@gmail.com>
In-Reply-To: <20190317124926.17137-15-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Mar 2019 19:55:13 -0400
Message-ID: <CAPig+cSc2tbOhjxrOiK_+1M7RdwbXL5-d-eCPm6gk84ESE1xpA@mail.gmail.com>
Subject: Re: [PATCH v4 14/26] switch: add --discard-changes
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 8:51 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> --discard-changes is a better name than --force for this option since
> it's what really happens. --force is turned to an alias for
> --discard-changes. But it's meant to an alias for potentially more force

s/to an/to be an/

> options in the future.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
