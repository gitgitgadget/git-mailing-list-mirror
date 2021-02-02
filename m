Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55027C433E9
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151D164F6D
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhBBR32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 12:29:28 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41055 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbhBBRZm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 12:25:42 -0500
Received: by mail-ed1-f46.google.com with SMTP id s5so10934961edw.8
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 09:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3hp0u4vI7MP0vGmaFfgtaDn0BvI0KbmeM1GxCtsZyI=;
        b=BhkchXqvjOBI9dEZM2HiP9xMuJYzCfMQX1OPREjNiFVoVggeXYms/fpS+RrYALTpjs
         twY+nTjh907TJyBMsromX1axDEamucfBtOEfAD+tRVUQTtZNo5agLlI2BUOOV4Uj3gAp
         UAhMsJJ+Q/2KsxAKUO5+K9o+MiZnOAv94S5rBkrQ6UNwgUxrXOJWkYFLwBDvHwtiOS8o
         hFa1/+ZGv1yNaXWL2UNyNtkWPNikTbEqDOECI7XNscVFpDZHShpxqYxKy4CSVCMBVSqt
         c2BLv8jfJk3wA5UuhuG9LSxDQ8GQBv3LjppZhzRQyn8cqmEMmtL9IgHWBkrqZ+GPgTdi
         oPOQ==
X-Gm-Message-State: AOAM5333k8G0BrN9zgiL1hrMu0rVB7CgrzSxr6TqR/nIAGDqK44qvDPb
        1LdX/6dnqxnMd00snt0z91hLzr7X5oAosWx603rT8GaFwLs=
X-Google-Smtp-Source: ABdhPJwdaF139vmEcBkpTEOxiWcDADLguBwbI4iVwCqJ4/nHt8+cblpOC/vYeYcmm8PcM/TO2H2eML9qCYT5Fw/FGrQ=
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr24498477edb.233.1612286702335;
 Tue, 02 Feb 2021 09:25:02 -0800 (PST)
MIME-Version: 1.0
References: <CACoUkn6+9C3+HVVQF905t1siAD9Sqo1JvRa0Whw-J6x7V7icyg@mail.gmail.com>
 <YBkVFTOP6K1//i6m@coredump.intra.peff.net> <YBkZnY8X5VyNkXkR@coredump.intra.peff.net>
 <xmqqpn1igznk.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn1igznk.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Feb 2021 12:24:51 -0500
Message-ID: <CAPig+cQoCuQSyrKfE_sNCvi=Yo2035e0TOA1sOBF1HE02-kFjA@mail.gmail.com>
Subject: Re: Bash completion suggests tags for git branch -D
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Paul Jolly <paul@myitcv.io>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 12:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> From: Jeff King <peff@peff.net>
> Subject: [PATCH] completion: treat "branch -D" the same way as "branch -d"
>
> Paul Jolly noticed that the former offers not just branches but tags
> as completion candidates.  Mimic how "branch -d" limits its suggestion
> to branch names.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Perhaps a Reported-by: would be appropriate?
