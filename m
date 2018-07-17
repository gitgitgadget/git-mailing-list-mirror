Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7604E1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 16:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeGQRWZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 13:22:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40695 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbeGQRWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 13:22:25 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so1562012iob.7
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Y2UtWWO/nEyEz7kQNu6Kkd3YvUGvVaapthwS8jVz/w=;
        b=KLZ7Pf0w1YigC15N0epGaGoUZT04YqXhSHZxqM0DJ5gacFV1bPh9jdko5VtKTuz119
         xPcJOK95HfIuucUhCLLaZ1uTlUEz3uN5AY4FDLFsSebI9ZTpW4l0B2EEJ1I5MHn3IQZy
         WlkfdKFgiIl8y3XW0ufhdkz3k1kRhq2SgtLY7vzmrOYUiT0K/GPp17zkLwFTYyHCzITT
         XNEpj8vPGmYmxT89NZDG6ZGYPUOCZt/IJPhE7av8wsTR3VoJE1CYjgnxzEyDJHtVV474
         ZU0ldGzHA3oJ7+aIgwje2WWoVFULaujZe3q/M4AGGQ+z8cZT4gHOXSqsObZjzYV6Bio5
         uzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Y2UtWWO/nEyEz7kQNu6Kkd3YvUGvVaapthwS8jVz/w=;
        b=n9aQqhvLUunKhYhQihfgMniHWK+goA7hxiZHJUJd3AJQVPtHetA/t+wi1lQTlbTnu6
         ITixLmDgQTdOYWvAOqqXkAuYqtUY1BC9ed6WDib5dMyebHrcVVuBzRDuazvVr948I22C
         G2t81XMlSlC3KppZklPMnLaBuBuigVBPMDMC305AvKRdIP09NfEtGg3Pxzmgi3m/tJzf
         yOXgA4vPOBA3xvftwjNMdevnAVXV67AMTSjIVhAIhBo+G29jNZ0Z4Ns15+TnybjMg5SH
         Ywrv5/tfA3lBur4HfU2OWhQUPfXVR1dUfCZpaHToU4jmVnrvwar4DegC4TbW7lhQicaf
         9pyg==
X-Gm-Message-State: AOUpUlE2Tyli3o+FH7ufian+4hKxg5nv1k6wlh3yWR7JECJB7HQiaeBw
        ZYwqkTTVIsnu19rBThZeDYqnT56uWoTImAhrMwA=
X-Google-Smtp-Source: AA+uWPyRzJLQhRRjXYOMdT+eJduBcJPbiCWoz+xbJePbz7U7ANTDEbQ81lBWaWei4EnNhjH+s/xsvJmc9fkbzPwFf68=
X-Received: by 2002:a6b:1f0e:: with SMTP id f14-v6mr1970945iof.236.1531846133461;
 Tue, 17 Jul 2018 09:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.9.git.gitgitgadget@gmail.com> <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
 <CACsJy8Ce0kXTCzLf6jFq1QjY4Q4QePfk1JbgGUr-kQqQDCc7mA@mail.gmail.com>
In-Reply-To: <CACsJy8Ce0kXTCzLf6jFq1QjY4Q4QePfk1JbgGUr-kQqQDCc7mA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 17 Jul 2018 18:48:27 +0200
Message-ID: <CACsJy8Cxp6Gtt3YdWvQ0=t4vqBAqNxrGPeY4B7mtjsiLNpG5TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
To:     gitgitgadget@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 6:39 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Jul 13, 2018 at 10:19 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > While it is true that we never add unreachable commits into pack files
> > intentionally (as `git repack`'s documentation states), we must not
> > forget that a `git fetch --prune` (or even a `git fetch` when a ref was
> > force-pushed in the meantime) can make a commit unreachable that was
> > reachable before.
> >
> > Therefore it is not safe to assume that a `git repack -adlf` will keep
> > unreachable commits alone (under the assumption that they had not been
> > packed in the first place).
> >
> > This is particularly important to keep in mind when looking at the
> > `.git/shallow` file: if any commits listed in that file become
> > unreachable, it is not a problem, but if they go missing, it *is* a
> > problem. One symptom of this problem is that a deepening fetch may now
> > fail with
> >
> >         fatal: error in object: unshallow <commit-hash>
> >
>
> Could you elaborate a bit more?

Never mind. The problem is described in another patch.. sigh.. I
understand you want to flip that "failure" to "success" but personally
I don't think it worth it to look back in history and have "what?"
moments like when I read this patch alone.
-- 
Duy
