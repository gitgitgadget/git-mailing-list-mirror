Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1DCEE14C3
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 02:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbjIJCCk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 9 Sep 2023 22:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIJCCj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 22:02:39 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94E18F
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 19:02:36 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6515d44b562so22020336d6.3
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 19:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694311355; x=1694916155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD/EKpTY/98bHFMGW5nc1ztBoKTtv3T628rmXA65e+Y=;
        b=QJpNWHgtTvg+9kDdr/uFdkUL/CukKnx8IxhP4z4j2m08ZDf31OZPC++xoZUSFx/n1Y
         R1pNk091QiyOst/BlQC23PxGRrgBzN9DeXppFamkXaQqUOa4hhXJeKw7Y+jZubKO26A7
         E4g5rboJCAglucJ59vdIJ9DDyhppGeZxjZti+JGqb1rrQnCLbfumLln/wGJ5aaXu8HbL
         VEs4wfR8BWO3PZVNDCvH1kiJyHtKanBicr10fBm3MKWNMfUJj+x28B0RhMx4hnqCU6Ti
         pRNXQJd9alXSNsEfa/YIz7JTGfYMZ2GGGn1flmIxBu0J3STN3xJ9QFOJ0KQ7lsdkkk5E
         A6lg==
X-Gm-Message-State: AOJu0Yx9eEXqm4LlCl4/j20VvY8ktwHaqY2GMlqtRv2xsy+Zo+IPEl5N
        ssotVHyV/Nl+ZfaKLrhoJV4/Y4g1AxSj+38/NyQ=
X-Google-Smtp-Source: AGHT+IHgmo4y4gblNfpIbjnPMgLFsC1EfmwbpR43RvVrFbCTzT1ZnULyvg/ae4QWTsLZhHtkzJx/cQVe2CTYiv6Vsp4=
X-Received: by 2002:a0c:8d43:0:b0:63d:2de9:cbbe with SMTP id
 s3-20020a0c8d43000000b0063d2de9cbbemr6211662qvb.20.1694311355214; Sat, 09 Sep
 2023 19:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
In-Reply-To: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Sep 2023 22:02:24 -0400
Message-ID: <CAPig+cS2SZqN-viky4OB4hZby7UbbJaBR-vhd=QJoqON7kXuPA@mail.gmail.com>
Subject: Re: [PATCH] completion: improve doc for complex aliases
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 9, 2023 at 12:25 PM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The completion code can be told to use a particular completion for
> aliases that shell out by using ': git <cmd> ;' as the first command of
> the alias. This only works if <cmd> and the semicolon are separated by a
> space. The examples have that space but it's not clear if it's just for
> style or if it's mandatory.
>
> Explicitely mention it.

s/Explicitely/Explicitly/

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
