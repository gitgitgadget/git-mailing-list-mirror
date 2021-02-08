Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3261AC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2A664E42
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhBHXHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 18:07:51 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:47064 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhBHXHt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 18:07:49 -0500
Received: by mail-ed1-f43.google.com with SMTP id y18so21163801edw.13
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 15:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PxoFM2X8pOH8XMKAeCag1NzNylb+759DNTPnkaiir8=;
        b=JGw3VOwDN+s7GFS6f4YiZ/O8S8/FRThlwbwlvucipQc+c9qQLnKEB1Cbm1i4dtuG60
         JT3msa8wZcMOzrQpgzqxpt1a9FtZygZN1ve+tjMvyJm7M5mQTsI/z7RfqOQx9hJv3EXL
         tqQWAOuSebOdtFxepAWImXCufaNRUji4nPVxOTeosEogHs10csLBAjqOCZ+RlxUYsuHw
         AEDYIsQ1+MzT3eGvdHzmOcLup/Vj/h3hsKbfZhRFeXpIrmbyXseFju74nXiBuB7Vc4Pu
         6pfo+x/1ZizXAo08sr325B9iwREg8DutpVNCcEMCrz2ubub4t0StLN2SrFXaSmxj8LjF
         KanA==
X-Gm-Message-State: AOAM530JSZ38tkBZE3DMQyTdUZjAA2+zQi0N5GjosploKTIWUHVCZ+xE
        KvFNxIw/MD9Cgd796TQJVaokAcvLnPStJxDqFOs=
X-Google-Smtp-Source: ABdhPJw0R4bnSEFefjazOOr09o9PIQflOUGM8iubMU4bVwisl/qq66DT/EU0E7p2uBFbLtgg3SfjZRHPGDxRguXzFtI=
X-Received: by 2002:a50:9ecf:: with SMTP id a73mr10415361edf.181.1612825627946;
 Mon, 08 Feb 2021 15:07:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.871.git.1612795943.gitgitgadget@gmail.com> <33b7a74af4eb45756c3648eb7b002d06e4ec3563.1612795943.git.gitgitgadget@gmail.com>
In-Reply-To: <33b7a74af4eb45756c3648eb7b002d06e4ec3563.1612795943.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 Feb 2021 18:06:56 -0500
Message-ID: <CAPig+cTOv_Hq-FM2s8-XaGHz6FSUt5Dr41sOB9wP12tQJ_kcmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] maintenance: add pack-refs task
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 8, 2021 at 9:52 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +pack-refs::
> +       The `pack-refs` task collects the loose reference files and
> +       collects them into a single file. This speeds up operations that
> +       need to iterate across many refereences. See linkgit:git-pack-refs[1]
> +       for more information.

s/refereences/references/
