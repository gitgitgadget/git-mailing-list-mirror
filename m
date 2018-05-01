Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3FB221841
	for <e@80x24.org>; Tue,  1 May 2018 11:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbeEAL0p (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:26:45 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43253 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbeEAL0p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:26:45 -0400
Received: by mail-oi0-f65.google.com with SMTP id p62-v6so9822014oie.10
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RBwSfIyWsI8gdvKrwumf7p9ufyZDF7hSM4rT1Of90Oc=;
        b=b2nFlmgrtTq38Xy2ZJuy8W49GlVeBdkMopZfWjXH6K3ImCelKpR9VxaUZU+0gE7A+f
         Fx/5C79FS6YG50NgDEzWNSxaDfcICAvRBKu3dFyw0Vybg55eKS7Xwmod9B1C8zUhrhpF
         EqIlYS3l28LCO3be7Z4t81uD+bFzDG5BVTAZ9ND2wSBp1SYWM4aXyIgPVf1jK0Ka3cqu
         dLWEyGm+eM/Z7wr7yaV8+0IZyJKO5mJnwGj8NJxwsNjd/oik3KlKtdu+upu/Hlqwz6UU
         uUHc5RCjdPvv/qlWCO7W//LZ125WUbJ+3LrMeILe4TylmLT1FwRMqznF/wn8lNJqVqfR
         Ox/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RBwSfIyWsI8gdvKrwumf7p9ufyZDF7hSM4rT1Of90Oc=;
        b=Uaobkc6JW9YDx86u/aJzElZdo1tohqhjyRhDA9UlKkNt0l0B0NZzA7yxmvNEgwqyCK
         7P7kvdKykVM1r4rlzH32VKzJjUwURs2jFvdkaDDDu67W5hkzpi9Lap0Xo6soWV7cOlCA
         NKmRNFRvsl/o8a1AHh+f+jV37jn0sz3CESWVABgDuXX1lYySHuahH908P6yaylUanRT5
         BDCrznV+NT1lfpQiYgVsBkOs3CEiEpB0dDtXGZ8meE18brQhAjUNSYMfF8dfDZuP2oQM
         DwCrH8wB7WNNH3YsMEQsQGLIvGWXRc/0rMjDMaKkb1mj6UH4TgltJe+l0R1sTD0Tf6pI
         Rdkg==
X-Gm-Message-State: ALQs6tDbVUOSGGcmiLlxCyFYvV7u+eufu/7KDtRz19Vv0seLj0Qup13V
        TkOC0h9i8/XfuGcOojRLrRNNuekXDtl7jVhu8/M=
X-Google-Smtp-Source: AB8JxZrUuXOZIfoXUrdwkNQLuIWPaaUftvYne775IF6xa1Y2Fg66HyRsxy4G67kYXD4CB3R4x8XQiSedO71VLnU3Atw=
X-Received: by 2002:aca:110e:: with SMTP id 14-v6mr8993271oir.56.1525174004622;
 Tue, 01 May 2018 04:26:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Tue, 1 May 2018 04:26:14 -0700 (PDT)
In-Reply-To: <9bbfd73a8e03a888a5e9e8800d853ece518a8bf5.1525040253.git.johannes.schindelin@gmx.de>
References: <cover.1525040253.git.johannes.schindelin@gmx.de> <9bbfd73a8e03a888a5e9e8800d853ece518a8bf5.1525040253.git.johannes.schindelin@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 1 May 2018 13:26:14 +0200
Message-ID: <CACsJy8A7K6-W=H_08JcJgtziz3aQ4B1WgOcsoMSMuSvEQDW8=A@mail.gmail.com>
Subject: Re: [PATCH 2/6] t1406: prepare for the refs code to fail with BUG()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 12:17 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> t1406 specifically verifies that certain code paths fail with a BUG: ...
> message.
>
> In the upcoming commit, we will convert that message to be generated via
> BUG() instead of die("BUG: ..."), which implies SIGABRT instead of a
> regular exit code.

On the other hand, SIGABRT on linux creates core dumps. And on some
setup (like mine) core dumps may be redirected to some central place
via /proc/sys/kernel/core_pattern. I think systemd does it too but I
didn't check.

This moving to SIGABRT when we know it _will_ happen when running the
test suite will accumulate core dumps over time and not cleaned up by
the test suite. Maybe keeping die("BUG: here is a good compromise.
-- 
Duy
