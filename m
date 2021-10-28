Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE072C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EADC610A0
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhJ1Rs6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 28 Oct 2021 13:48:58 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35652 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1Rs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 13:48:57 -0400
Received: by mail-ed1-f43.google.com with SMTP id g8so28338088edb.2
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 10:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MAtqlEaA0jdVmEyPcB2ZCTlBJADFSBNoKwXIyQRf670=;
        b=q6RX66ZKW9UFTchxE0V+bqbcGj+wyc1/7tPnXJsWLF/m905ofL1cVbgrFswvGY4vKj
         6SuvupjqlkYZYp3RcI0bh2uuUuUXH96tp9zLoYiybLUcg1T1dwlxFOUwOijNNhx+cVsa
         UXTbmJVc/sHxmVMm8+iByDgZW0yhmQql5t7uUTd7+9Y8DNyMVHOWfedsyWtJRSn0Gr3H
         llKAER5TDv2wIsxUy/nkDfSvBH09oOmlJzL69xYiaBDEKpn1huuSQpHD+HN/KoPcrD+Z
         MWCdY3U5by07UkfVChg5j1x5ea7UTIt6Z1N+k1Uy1dNX5t+QiMjrDKK+smzaj4w88SjS
         CwMQ==
X-Gm-Message-State: AOAM5328wfzJpCwl7EXT90fHSEgU0I/FgQ7EtQ8KKwuIs+bg7yMwZZDQ
        KLiwEN2x8CWefdpH7rvY5Sq/yI879SLjmr0c9L0=
X-Google-Smtp-Source: ABdhPJy2r1Zr2/pUW1HMv+rA3bvr3VyMOA07/Bdn856TgHVf48TFIkhuS0Sq2PphWaqc6sJFEG2b9IHOl+WZmAdA7Vc=
X-Received: by 2002:a17:906:128d:: with SMTP id k13mr7138316ejb.517.1635443188603;
 Thu, 28 Oct 2021 10:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com> <4d2d198f57294d8307453bda784bf5efe5905f45.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <4d2d198f57294d8307453bda784bf5efe5905f45.1635438124.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 28 Oct 2021 13:46:17 -0400
Message-ID: <CAPig+cR4j_jPLJs-sQAAuNQ5cEqbO0ibck-czOBy=difgi50VQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] doc: express grammar placeholders between angle brackets
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 12:22 PM Jean-Noël Avila via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> doc: express grammar placeholders between angle brackets
>
> This rules discerns user inputs from verbatim options in the
> synopsis.

Maybe: s/rules//

> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -145,7 +145,7 @@ See also <<FILES>>.
> --f config-file::
> +-f <config-file>::
>  --file config-file::

You need to fix the `--file` item as well (mentioned in my v1 review):

    --file <config-file>::

> @@ -281,7 +281,7 @@ Valid `<type>`'s include:
>  --default <value>::
>    When using `--get`, and the requested variable is not found, behave as if
> -  <value> were the value assigned to the that variable.
> +  `<value>` were the value assigned to the that variable.

This change seems out of place in this patch which claims only to be
adding angle brackets.
