Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736F61F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBTWVk (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:21:40 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:46066 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeBTWVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:21:39 -0500
Received: by mail-lf0-f44.google.com with SMTP id x196so6417296lfd.12
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cLf5oTFJI8wIuKKUIXFQGNjELp589Uuen3lssD9xKOc=;
        b=G1269tsgRYA092ZcweiJM4a77l0hTaiR5ZgB4Y8iY7fVxR91n+kxneuggei00Adu9/
         2gaElbxj/evYelDhSvz+6Yi3/N5IxMIuf59DFe/vFoMlWO/YjEEjTkjt2mNptnLJfx46
         kXidi1yboQEoWbHNfOSQczBib23ouYdYTxxvS31nmjbcO8Qx03D5K2b0UTIHeAij0Jyu
         8XlcU7ambSmOxulrLt7ZNsBY9GLGR34dt6J5MtQJyTrBKWFKplZyclCkFrxvRkjcDJK7
         wQcUk078gX2DtLa+Wi17KzAL6wz5IY4VySrT37ehnzXFd84wkygtSHlfuUFhMgdasbgt
         rbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cLf5oTFJI8wIuKKUIXFQGNjELp589Uuen3lssD9xKOc=;
        b=ekIxt6/kgOe5uz9Rzlq0RG3n/k9E9QUFNYtvTVLB47qeTEQDVxc4lmegXnKdEHzMuV
         UHkB4ANqaea97elCXU+7VyaVcByIAq8DjRFaEaGBe4dGi5CSDvY5pCgxaMnloEKGt5gL
         Ib2g5hur95T3R4i9U76nquUQ+1Wgq7xlow683ra8EsLto630VkjNcHCIlt4wY6KvnunJ
         Ls97vMwD5iMdOYrgdn9Lb8teXArw912orCwKLcOPk/ow+vWgTRONkLu+jz2VeUXNyQCN
         DvgZUmG/jNweCMDOT85xgpEVZFIHSzuZzFKxqHgEJjeYXM4VB87TzN43KU039DVbCGG0
         5Yig==
X-Gm-Message-State: APf1xPAnDJKfjxZUIQIH22OzFe+ZCND9AcfyWvtSORDq1BElDUToq8Nj
        UHcDIa6fmerP1Y2GdKIrzU8jqngAE0UO9ayjx28t1Q==
X-Google-Smtp-Source: AH8x2274jCo/cN7+jvdfwCs7iHBczcTYjQ/gxcznFO/oQ6+qBNKWPUOsrbDYya63AI6QK7P0SdcGMotzkjB9BnBPhVA=
X-Received: by 10.25.204.78 with SMTP id c75mr788163lfg.39.1519165298213; Tue,
 20 Feb 2018 14:21:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.127.7 with HTTP; Tue, 20 Feb 2018 14:21:17 -0800 (PST)
In-Reply-To: <CAA7Zk=vWdEUnrfBcxCH6WAFH9Jss7T9_zK-zMnWbVO7B+2YySw@mail.gmail.com>
References: <CAA7Zk=vWdEUnrfBcxCH6WAFH9Jss7T9_zK-zMnWbVO7B+2YySw@mail.gmail.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Tue, 20 Feb 2018 17:21:17 -0500
Message-ID: <CACPiFCK_-qw72QgKziCWzSPJtDN+w1PrbDu5Qk1MVj220WKZ-A@mail.gmail.com>
Subject: Re: I'm trying to break "git pull --rebase"
To:     Julius Musseau <julius@mergebase.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 5:00 PM, Julius Musseau <julius@mergebase.com> wrote:
> I was hoping to concoct a situation where "git pull --rebase" makes a
> mess of things.

It breaks quite easily with some workflows. They are all in the "don't
do that" territory.

Open a long-lived feature-dev branch, work on it. Other folks are
working on master. Merge master into feature-dev. Make sure some
merges might need conflict resolution.

Reorg some code on master, move files around. Code some more on
feature-dev branch. Merge master into feature-dev; the merge machinery
will probably cope with the code move, file renames. If it doesn't,
resolve it by hand.

Let all that simmer for a little bit.

Then try to rebase.

"Doctor, it hurts when I rebase after merging with conflict resolution... "

cheers,



m
