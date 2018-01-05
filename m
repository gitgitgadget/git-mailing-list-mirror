Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 181441F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeAEUM3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:12:29 -0500
Received: from mail-ua0-f170.google.com ([209.85.217.170]:42051 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbeAEUM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:12:28 -0500
Received: by mail-ua0-f170.google.com with SMTP id q22so3231287uaa.9
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=USs7ZAZpNoRTtFg0GEKSZ1e1rfUU4xdWB/PB8hiwxe8=;
        b=m3ApO2mru0mD7Xl6S6swjKlF+9J/yEOWe5FIhFXFL8YhwYfeYtsjOsDTbEajXvuO5F
         BGRkCmV/h2FV8eK0K02I+8+xPwH8EfOB1lALuh4A+MKVYSUTYKve0l9DJvO8xg65Tkf6
         lqdfvsRrFh18TQP7hdEuE5GZQ/jnzd+YtYvdE5X4hRdSAtEqKwrl9RQZpq4ua4Bt/L4y
         7AoDontfPvmosXVbY4SF4iHi3RPJC19BG3m4kjMWiweCWsu5ekaSixxJcBUO2+Ey9kHo
         tx0wruIGEBQdDSn3fyIYS4szb8ApJOM1u8vgn70LpUS+cBBUegu94bRidITekKmjZzH4
         YTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=USs7ZAZpNoRTtFg0GEKSZ1e1rfUU4xdWB/PB8hiwxe8=;
        b=F39ktQrVFEU5U0FvdxWzw0bIIg7gNNZsnsaIObqHuCue9dJuGbe469HFk+e5LYRlyi
         MKwhvEQ9zKAZb7nxjzXGb2d4mVrP5yCmf9az/L7nUzYpIAxtCXGRbLKoUa03APIOn28d
         u4HAJzoGM5C1ItUkWjO0npmaEigiDEsHJZB6He0puE7lxn/ADY0jfLsrlf7imrdbID6k
         e2Ng/zxz4ZEnnNhCUwKw/X0IMBVE6V6ZSPrGQ+zV2u+UV6FB9zyGTvcHQuHKc6blQZQ1
         rQ0gPBsKgV3iuYlVsPdudRCsfxxcejsiP4eKLhn8IjpzRN5Q1+X9KhaOTRv4BYIIUhJq
         ISTQ==
X-Gm-Message-State: AKwxytf3MDG+5vjaBPMwwHYuH+UB4nDQ2d0k4R1p1AsWBlPbvYAiqtDh
        Z3ey6zQy9umsi/nXdoPN9/+K/FqJNRkMdWUsjfg5NQ==
X-Google-Smtp-Source: ACJfBovex15QMgYTlfIcbelKRufxRd2B+8bqu156ZbF3Gt2O0b5hgYTzcbcjeGMRT0/iNNIkdWADpxF/gPSZlUyTxRs=
X-Received: by 10.176.32.73 with SMTP id g9mr4121159ual.145.1515183147414;
 Fri, 05 Jan 2018 12:12:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.77.157 with HTTP; Fri, 5 Jan 2018 12:12:27 -0800 (PST)
In-Reply-To: <CAHd499C=3Y-ykgYZhSJzk=e-Pi6BUFeN8C89krd5T7T5fRB91g@mail.gmail.com>
References: <CAHd499C=3Y-ykgYZhSJzk=e-Pi6BUFeN8C89krd5T7T5fRB91g@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 5 Jan 2018 12:12:27 -0800
Message-ID: <CAGyf7-FHyO9pkEFFguea+B+VMTodF=mg8wJNedvjYdL7e7ORqQ@mail.gmail.com>
Subject: Re: Can't squash merge with merge.ff set to false
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 5, 2018 at 11:59 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> Not sure if this is intended or a bug, but with the following configuration:
>
> $ git config --global merge.ff false
>
> I am not able to merge my topic branch into master with squash option:
>
> $ git checkout master
> $ git merge --squash topic
> fatal: You cannot combine --squash with --no-ff.
>
> I'm not sure why a non-fast-forward merge would prevent a squash
> merge, since by its very nature a squashed merge is not a fast forward
> merge (or maybe it is if you only have one commit).
>
> Is there an issue here? I like fast forward merges to be off by
> default, since I want to control when they happen. Most of my merges
> do not use --squash, so I'm catering to the common case.
>
> Need advice on how to get past this issue. Thanks in advance.

The easiest way to move forward is probably to pass "--ff" on the
command line to override the config, when you're using "--squash".

As for why the two aren't allowed together, my assumption would be
because if you're only squashing a single commit "--squash" and that
commit is fast-forward from the target, a new commit is not created
and instead the target branch is fast-forwarded. With "--no-ff", it's
questionable what "--squash" should do in that case. Fast-forward
anyway? Rewrite the commit simply to get new committer details and
SHA-1?

Hope this helps!
Bryan Turner
