Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 049371F404
	for <e@80x24.org>; Sat, 25 Aug 2018 12:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeHYQKP (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 12:10:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45615 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeHYQKP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 12:10:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so5703945pfo.12
        for <git@vger.kernel.org>; Sat, 25 Aug 2018 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rXVi0WVTmt94p4K0gEoAWK9GA1VMqDS10o1ZMXayKmw=;
        b=VoldEk4w7tF6yRSqeV7eW1rER/jo2f5w3IrOPJEC9CEEiC9GYN8DOfaP3om+EIF0TE
         H4Cuz3Tj0qNk6KqxOG+xJ0BSqSwursJ1DPM6T+dVusx3PqgKMY0Andw2nMik+x+dfwdc
         SjwFaM/ILEqzGOYBVw8qyT8LH8dkkYLc8fqmSkyFV6XZzCbWJLtM5/v8wYo5w/Hcz9um
         x8prVzmqGqRgev5U0NHhdPTXO8v5Au42QjICEoolVv/NTV9Dly3CpaFaKTf7e3HN3DnB
         lhLRscY/bz5DuEcGA3ApFJePE9PfoKdY/2yapndpsDdW3lMuxK9hnwdr3TBtIStPem2H
         PC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rXVi0WVTmt94p4K0gEoAWK9GA1VMqDS10o1ZMXayKmw=;
        b=GKncSPYBJcCvZZpvZMB8u9lKPSxxbGzTy4ARltYSVvpj8SFxCsfcqChws0OWEd+z/3
         NNQEmPBgnXB59oM3ArWmPoJsfUaIs2OVc2T9qm3xVX0JgjSsr+pwSUXd66dZetMWPVNC
         jJVuTDBc35HtJKtY6wNUhFQ9+eYlaJy6luuRuwVOEswR3DZd/Q7UlM8S7RMnDpzOlTlB
         gan0mkzAuJxFrZbSLW2Wo25ylrHRoMDEONmZHHIA7lYqP3fp8ybwn2YuMR/r0fEuI/fl
         zqDXUATpVDZ6uFhu5mNrecny1AgsxpeAhoGmvdfJRqFeCtZlQyZ6g50PtapS/nfFX7HF
         kavw==
X-Gm-Message-State: APzg51CPIAljm8w9MTEk+4Ud6f5rlljlQXlZVPlMhea9LvUceUjLG/F2
        KNQKBPSMmjiq09BB5FQXAvHKvwe1/XLZz6thaR3XJw==
X-Google-Smtp-Source: ANB0VdafNnc9+/7Owcuoe7muo4RlCfFuccEjOr3P820LFPVHZqJa615gyAbNruQqJxZ+cjw32k9TRctdf2F1A1B+87U=
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr6102833pfm.254.1535200285093;
 Sat, 25 Aug 2018 05:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180818144128.19361-1-pclouds@gmail.com> <20180825121848.11606-1-pclouds@gmail.com>
In-Reply-To: <20180825121848.11606-1-pclouds@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 25 Aug 2018 14:31:09 +0200
Message-ID: <CAN0heSqcNBJ6-6YBFixd1+h1fg3o=2fJZXhmDehNLLYCN=RFqg@mail.gmail.com>
Subject: Re: [PATCH] Document update for nd/unpack-trees-with-cache-tree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 25 Aug 2018 at 14:22, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:
>   * Fast path if we detect that all trees are the same as cache-tree at t=
his
> - * path. We'll walk these trees recursively using cache-tree/index inste=
ad of
> - * ODB since already know what these trees contain.
> + * path. We'll walk these trees in an iteractive loop using cache-tree/i=
ndex
> + * instead of ODB since already know what these trees contain.

s/iteractive/iterative/ (i.e., drop "c")

Not new, but still: s/already/we already/

Martin
