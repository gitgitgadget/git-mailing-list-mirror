Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85BA21F453
	for <e@80x24.org>; Tue, 16 Oct 2018 03:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJPLcs (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 07:32:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37343 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbeJPLcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 07:32:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id d14-v6so24127139qto.4
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 20:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4OWW5wbfQcQUZWwUWq0Rj6n1A9tnFEwDLzulPoJxh4=;
        b=kjil42eOjaWjTxngDMzenhEbjvvHxq7B8xZMFwfuSGxxwgMA6Q6+222MxkA7w0lhSx
         3INI9Bc6oVBSqYH91+6Z29CiOccWg+Qqdf2VpFqMHM/yTYpIgl+m7gomAMDByhfWwAX7
         rd0QSE/3hCGU8lM9itNmv+1iyRFdFnAV/kV1ojkM7Dxo03f8n+aNdpfagZpxgy4zU3Fa
         wTfEGCA8v223cRUXNVeMu2Xn7gPDpLxjh0mTFR2HMZ1F7eYXOP9o3CcEgicKEfuo+Sjl
         +ARcUmw9/0saBJukAJJlbNfNRkVvmWNUe6gzMyQIB6VwfgtabZ16Tc6PnAdLO5xWyoow
         X09A==
X-Gm-Message-State: ABuFfogJczsOHsgfKh1siLErKk97S9Z6f/igrTbeZDfoearbcpQ6XQ9l
        hcn8/RCz1hL/HIg0VstcD2TLK3RXlXlS9acxhQs=
X-Google-Smtp-Source: ACcGV63q7H9m7N4QlQhSpgLZn55hv+T7D3klIbVioO1CFdiGZMVEZXve99w7YSxmu5oL7iKkcZ/o50uw888orepX3xw=
X-Received: by 2002:ac8:7519:: with SMTP id u25-v6mr19196750qtq.110.1539661471069;
 Mon, 15 Oct 2018 20:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com>
 <d112b3fe86e2d5168161cd3edf9616ff7bec3319.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <d112b3fe86e2d5168161cd3edf9616ff7bec3319.1539598316.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Oct 2018 23:44:20 -0400
Message-ID: <CAPig+cSf9byf_T696_dzgQLE2X0-61PNXFxX65Ff_RZBGEuD+w@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] README: add a build badge (status of the Azure
 Pipelines build)
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 6:12 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Just like so many other OSS projects, we now also have a build badge.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/README.md b/README.md
> @@ -1,3 +1,5 @@
> +[![Build Status](https:/dev.azure.com/git/git/_apis/build/status/test-git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=2)

The first URL is broken "https:/..." rather than "https://...".
