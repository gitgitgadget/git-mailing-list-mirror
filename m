Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C2620248
	for <e@80x24.org>; Thu, 28 Feb 2019 09:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfB1JN2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 04:13:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46829 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732032AbfB1JN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 04:13:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so9413940pfh.13
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 01:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqXizTaqAHg3PcQ6c4oUCEfP45IhRDQauBRC//EM7zk=;
        b=gmdZ6fl7BppsybvNIfIshwX8v52v5TQSWHbOJ2Ny8gsxHxTnhWWKyxHePodfjCHxeD
         8IDiQLE+VcnvwaHLOWmab+tw5JG7ksY3QhswkgbZhzGnWAAwCGTFXByYvWM0h2vcM7KF
         cdnImyiO3p24Nj1kK+wJ4YCIJcyLBPnz6VOoT1eCQUGiiafE+khjLTWtU6cTOLg5jE2w
         fKjp1PenIce+h0XHQBWtZxeUY8tCEBGGolD2rg9LUfcv5HspIEuMHN+zhBkqjcAIs2v2
         WMEgwYJst771NMu7W7x9KSvO9ttLQUMCjZX86X1vGSG83NGtybRDyMO77pqh/PVW8Pwu
         b4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqXizTaqAHg3PcQ6c4oUCEfP45IhRDQauBRC//EM7zk=;
        b=LkspdLEnDoYpHhbpQZfKF9wcYTp/rkVRTl8WpUdDHVoqqChgh+ogjvanT8gIXOAdZX
         SDCccbsAXy+neshFIth9ZzzfAm97BMbJnpbkZ3L4WGgHp6otqUDEp1bfojjlUTX+qgbA
         kVYRfv47UA2jOV205vQ4ihjmHnEAJw+a0X3gLFXrnl1ZrTvu4sBxonJC9U+DQTWWJjri
         6qMUsabkztFZHSsFlaIgsO81XxVqFoaGAmuneFqqaIgOuN3wEnXa0d6rT+D2ah33ZlTh
         8I3nKtGO8TgEpj2tgazQLE2VNufBCSjQFYU5iXX/SuE9VpoCrYd9Rcbi9FpNwzR33aYQ
         yIIg==
X-Gm-Message-State: AHQUAua3yS0SPKgMaT3XTWEXffo87WWMNzKNXMUDDO2R5xHeOCUYotL/
        GOLuXDzy4jn81UA/MkEPnGBJcAq5xPoHQEBhsouW5L/c
X-Google-Smtp-Source: AHgI3IbkjKemuUDV1A5TdawLiU5mE9TabBhFdUaAzefW+dy4cI69JwX2UfWmmg7m7TowsuKZqtJU4D1Sg8yBABWkjJc=
X-Received: by 2002:aa7:9152:: with SMTP id 18mr6218511pfi.215.1551345207159;
 Thu, 28 Feb 2019 01:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20190228024315.1470303-1-kyle@kyleam.com>
In-Reply-To: <20190228024315.1470303-1-kyle@kyleam.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 28 Feb 2019 10:13:11 +0100
Message-ID: <CAN0heSo5qsd4t_mgt90ws2hCp3O0qch_9MgXuzj-4FS2gG+bkA@mail.gmail.com>
Subject: Re: [PATCH] rebase docs: fix "gitlink" typo
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Feb 2019 at 03:44, Kyle Meyer <kyle@kyleam.com> wrote:

> Change it to "linkgit" so that the reference is properly rendered.

>  have `<upstream>` as direct ancestor will keep their original branch point,
> -i.e. commits that would be excluded by gitlink:git-log[1]'s
> +i.e. commits that would be excluded by linkgit:git-log[1]'s
>  `--ancestry-path` option will keep their original ancestry by default. If

Heh, I stumbled on this a few days ago, and have this exact patch in my
w-i-p series. I found it interesting that both Asciidoctor and AsciiDoc
trip on this in quite different ways.

The patch is correct and tested by me, FWIW.

Martin
