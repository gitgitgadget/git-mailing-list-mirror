Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDADC433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 03:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5DC619B2
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 03:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhCXD7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 23:59:18 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:35331 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhCXD7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 23:59:09 -0400
Received: by mail-ej1-f50.google.com with SMTP id jy13so30558073ejc.2
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 20:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqWjuhZOM2veN7sfWF7O80UlKpmiWfhBaTEAbFul5EY=;
        b=jesg3viV6INRCWRUSfdhdoAVmgH1sOX5kVE1tHtPCoHmKgE9A5OFZqC+Seb2WTc1lN
         ca5C2VBEDQNyPDczojqECOohsPp2wIH9gtaCN7hC+J2Hzgk7M8QbRxHrktUikVwMKFv6
         8/PPiUwFOwDI1/ePMRhYYSM2fIr23BCILYgv6MCMGHDW6bbHbctJ7+2Ig+NzhMC502M4
         vXKeYS0ht9VgTKxjNt9BTiFNGavFDR4bDQXYY0L93a7FupUvYxsGoFrmugwMvJiwBGgl
         gaoHXBX7npid3AP4OuieF+uj7HB4QRcq9vSQqMbHMiwcf5LOuLznUCih2rHc+H6/pt4S
         RUpQ==
X-Gm-Message-State: AOAM531T6VHTfw0CpXOOibiNwtgPaIJ1bBIVDKyns3hNy5S460X37Z5m
        YYdyDR2VqchnPDs12T83Sfy8KgCEpKRO3yNY/u8=
X-Google-Smtp-Source: ABdhPJz/by42GPOBZVT1babyPaGM7QUELi1Guly0Shoau7j3BXr+/vC//pdeIAPcY9b7MFqSpbG5q6ZMDlwXZBLKzP4=
X-Received: by 2002:a17:906:7c48:: with SMTP id g8mr1537066ejp.138.1616558348473;
 Tue, 23 Mar 2021 20:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v9.git.1616317225769.gitgitgadget@gmail.com> <pull.885.v10.git.1616497946427.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v10.git.1616497946427.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Mar 2021 23:58:57 -0400
Message-ID: <CAPig+cQJ6q21PB9rBuw13q-j-YAEKz5bmk7_+yXQtggqHzRRcw@mail.gmail.com>
Subject: Re: [PATCH v10] format-patch: allow a non-integral version numbers
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 7:12 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> Allow `format-patch` to take such a non-integral iteration
> number.
> [...]
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] format-patch: allow a non-integral version numbers
>     A rollback was performed again under Eric's suggestion.

Thanks. I think this version addresses my previous review comments.

I did not find anything to comment about in this version.
