Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D439C77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 02:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbjFGCgr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 6 Jun 2023 22:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjFGCgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 22:36:46 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233FE6B
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 19:36:44 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-62b3b505961so23425016d6.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 19:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686105403; x=1688697403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSVns9Dmt1KWtmDPnZct4nBSJknEoBU606HUCHGm09Q=;
        b=Wo9LQm8XQpshncJKbMxQB92Kien9L1WRNsPiYpIJWmtC7TFwcChI88j5CN/XuE2HlH
         B1rnbI3jGKhWWXfwt7zFK+c2VljYwpi8STPuLpU4w4GAjdmQACrGXh8G8cJD5rybMLRS
         y+MkbmDtBoaTIcsZjCeeH0ZHnbvEn0gltjmqtkhQdB4GnRmuI7gwRGqQEXi1BHqRXCVI
         iBcvuK90tm0pPakcSI72oYQld49q2UxGl61YEhdJE8HJirRwnBHhvCPykJB7ukT2EySe
         JqoH3JMGC15B3ygvJ9im0n2FkCsgftk7Z82PJimdNynfUpogCALMx/V+4gv5vdRShTzA
         ntjQ==
X-Gm-Message-State: AC+VfDySJx40zU9FcYohJfsZEHM9p8vOiUxUL3/XoXCifL5fz716tIJu
        MzqtLagJ/trYpRP404gpUUAJmSnPkj1kXu/wV+E=
X-Google-Smtp-Source: ACHHUZ6tW6OSrNA3fUuFVk08iz+GlsyZtaLyLfZa+7V6LoYEtKmvj3Y4ubZ02JYKcrkRaPskYKSWfPuhlynfZvngEmk=
X-Received: by 2002:a05:6214:1d04:b0:5e3:d150:3163 with SMTP id
 e4-20020a0562141d0400b005e3d1503163mr1908398qvd.20.1686105403493; Tue, 06 Jun
 2023 19:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1542.git.1686099081989.gitgitgadget@gmail.com>
In-Reply-To: <pull.1542.git.1686099081989.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Jun 2023 22:36:32 -0400
Message-ID: <CAPig+cRE8=_WW_1_ER6=ObGaFzMdmQmESe5Gsb=dwo4DEx4u=A@mail.gmail.com>
Subject: Re: [PATCH] docs: typofixes
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2023 at 8:56 PM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> These were found with an automated CLI tool [1]. Only the
> "Documentation" subfolder (and not source code files) was considered
> because the docs are user-facing.
>
> [1]: https://crates.io/crates/typos-cli
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/CodingGuidelines                  | 2 +-
>  Documentation/config.txt                        | 2 +-
>  Documentation/git-cvsserver.txt                 | 2 +-
>  Documentation/git-describe.txt                  | 4 ++--
>  Documentation/git-format-patch.txt              | 2 +-
>  Documentation/git-ls-tree.txt                   | 2 +-
>  Documentation/git-mktag.txt                     | 2 +-
>  Documentation/git-sparse-checkout.txt           | 2 +-
>  Documentation/git-stash.txt                     | 2 +-
>  Documentation/gitweb.txt                        | 2 +-
>  Documentation/technical/remembering-renames.txt | 2 +-
>  Documentation/urls-remotes.txt                  | 2 +-

These changes all look sensible. Thanks.
