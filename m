Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBFBC43465
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F6623444
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgIRCwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:52:38 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:32855 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbgIRCwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:52:36 -0400
Received: by mail-ej1-f66.google.com with SMTP id j11so6126780ejk.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLmphnjY/RMtnXO51cqJ8KaMLFEbY+KrwjxzHTPcaVM=;
        b=MWA6rdxmyYaaZZBRO5yy9Sw6FuLUPgCe9K/oxQs+cscsJ3gPgijW8o7cBBoDeLtDOE
         0d98PRcV703J9nCqSAVm22lnDkN3GZFjgD3y5tLT59rReF7TL/2kETTtz2ttZaDB31b0
         MrOmKq5wCEcmj4PxkVrdh3d+yiWg8B2bDcBpQy/94+anNKoYvD6DjMIVsANY8SwSE/sF
         uW/e9WBuxijPhp4LcBTn1c4ma/JvT62IsQMYyeHWToXLa1JaTBTN6pQhNlGknE94HD9/
         8Ap0EUQHmiiCpSYBXb2dNitLfnQZPEgjGEQY0/1804uefSs7lFLXG8hHjT9QrTpL/ciU
         76ig==
X-Gm-Message-State: AOAM531ntR478keHBCUw05Q0iSPckORs90hYVvPqdp2jk9jZFSR3cEpd
        y6c8hbjblriTQCTXT3z9dJMsKm83axlmn+QRJCs=
X-Google-Smtp-Source: ABdhPJywKcbXDqRW7K5OSJHQIsvFaHyx2MljicaFcOT6kvFF7qgeCQcazlVLHVO5qJKz9Q59f6NYLH/NP/Lr8pqRwhM=
X-Received: by 2002:a17:906:552:: with SMTP id k18mr21417948eja.482.1600397554360;
 Thu, 17 Sep 2020 19:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200916020840.84892-1-alipman88@gmail.com> <20200918004909.32474-1-alipman88@gmail.com>
In-Reply-To: <20200918004909.32474-1-alipman88@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Sep 2020 22:52:23 -0400
Message-ID: <CAPig+cSptROTM4xDSj97g1UVEpVe3OCL4m9=R8f0rn-PRMhzPw@mail.gmail.com>
Subject: Re: [PATCH 0/2] ref-filter: merged & no-merged touch-ups
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 8:49 PM Aaron Lipman <alipman88@gmail.com> wrote:
> Since this got moved to next, I'm not entirely clear on whether folks
> want me to keep tweaking this, or if the last set of comments were
> general advice for future contributions.
>
> But in the interest of diligence, I'd like to offer a couple touch-ups
> applying Junio's suggestions.

In this case, the review comments were reasonably important, so
tweaking it by patching what has already been moved to 'next', as you
do here, is a good choice. Thanks for the diligence. I'll leave one or
two minor comments on the patches themselves (although, it's probably
not worth re-rolling just for them).
