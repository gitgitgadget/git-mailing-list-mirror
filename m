Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A0C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 02:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbiFWCOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 22:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiFWCOc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 22:14:32 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D91433894
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 19:14:29 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso24850774fac.4
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 19:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duxudbtsVdS0IXSiEa7ciHxPRHeDKmYrC5xZgr3lp9E=;
        b=Kl8muXkut5wp/zT0BV5vjZKA8JdLV4n1wT4wFC7MJVrSagKskwHm718EB/13WsNfjk
         82QymsI5M0tjpfm2jHiu+8mMs5IQUB6PGfXsXx8xStt6Omzi7J4mzn+BhKu5Sly8E4du
         /8QBUw1Adhsd98KOPzzqM7dnDAZAxm5slilmZW+/XCU8j63tD8axpvnnALThLUFGHJEW
         pYCZdrz16TMZAKK3KSVUeE19KphIfrIkJgLYRYOE+HG7GHNUNpjlDNS25kWagoqztoil
         zLoMzH+kJO0Jdf3Y+tudT8lYw9OucwkvUUeOLMgjxOIwrF/b96CW45Sy42FB3Q9OqEH/
         qUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duxudbtsVdS0IXSiEa7ciHxPRHeDKmYrC5xZgr3lp9E=;
        b=AbCBz3j6Wrz7cc1PreitcKSjPz5egmkievCneHYd5le6zCTWyiz6gC0AcdIqsFNZMe
         L7x2jITSHdiQlyeBWy3BPvvu2WobWDt1TLhzfUqG8Qyc90KsjwlXP/DbGenABy18KK1K
         O+HOO7kzcmJkHsmHDACA4H0ukZ62bRx4w5q4NVTVcPq0HgJsBu5t9xlJweK0npwx7kxf
         75HPiQ3Y0kuq6KmpRVQqe3f+dEP/JyBZpRJs4Eng01qAltGdZFN/evMXeoi1PCk9m5QE
         FQb7MzWDjIjRj1ix9yM5mV5hSKsHA8wfvjFl7hhZ99ezb3OsyC01ab9L1kX5PDoIHc/j
         YF7A==
X-Gm-Message-State: AJIora+0eHifBqfRErfqHUOapQS691XaqISnL8FOaHGpXFi3ng8OzDF+
        RndesyE9rMZ6EtjoBV2NBqu1T26deqNoMmw4CqXlPXDgydQ=
X-Google-Smtp-Source: AGRyM1tjfo1Itz68DC9SXJW4wgnrWSR/R5MmYXoE9yTtfJYBr7JwOMkqwHRH2RVqzJjY77piAALBS4omX2g8nU31HQM=
X-Received: by 2002:a05:6870:a2d1:b0:101:ce47:e1e6 with SMTP id
 w17-20020a056870a2d100b00101ce47e1e6mr971469oak.80.1655950468428; Wed, 22 Jun
 2022 19:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1280.git.git.1655927444821.gitgitgadget@gmail.com>
 <xmqqpmj03183.fsf@gitster.g> <CANYiYbGgS8hYUpAHJBmw0URcwTm+jpXHWK4DA0=jPHYpS53W1A@mail.gmail.com>
In-Reply-To: <CANYiYbGgS8hYUpAHJBmw0URcwTm+jpXHWK4DA0=jPHYpS53W1A@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 23 Jun 2022 10:14:16 +0800
Message-ID: <CANYiYbGCkGoxG9Ly5bEsH14XJMUExtEXArHGLSho8ycXevMs3w@mail.gmail.com>
Subject: Re: [PATCH] po typo: l10
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Arthur Milchior via GitGitGadget <gitgitgadget@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Git List <git@vger.kernel.org>,
        Arthur Milchior <arthur@milchior.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 23, 2022 at 10:01 AM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> On Thu, Jun 23, 2022 at 4:26 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Arthur Milchior via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > From: Arthur Milchior <arthur@milchior.fr>
> > >
> > > It should be l10n
> >
> > It should be, indeed.
> >
> > Thanks for patching a 10-year old bug, introduced at 75b182ae
> > (Update l10n guide: change the repository URL, etc, 2012-03-02).
> >
> > Jiang, I can take it directly to my tree, or I can pull it as part
> > of the localization update before the release.  Let's make sure we
> > do not drop it, each expecting that the other party will pick it up
> > X-<.
>
> The typo was from my fingers, oops. Thanks Arthur for reporting.
>
> Junio, I will apply this patch to my tree as the l10n update for this
> release, and will send you a pull request before next Monday.

See this commit: https://github.com/git-l10n/git-po/commit/fb03f55d87

>
> --
> Jiang Xin
