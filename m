Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5552A20248
	for <e@80x24.org>; Tue, 26 Mar 2019 15:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbfCZPkH (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 11:40:07 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39370 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbfCZPkH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 11:40:07 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so20722556ita.4
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKv0KbvquLk1G5jf7y3Wr5yEuuQAC1dm1dlaqoKqhpU=;
        b=gOrXnEMMLAAsXgQhQPB3d1e/+BlNCGk47G8u6Wmmm0x1/B4/OG8s77pzzjp0KxdH3P
         TV0ZhL0cPaXqQ46vgiHZ3fr7iSHoA152fv4qB3Qac22ayt4LjyDEteuf0+DqOPl/7I4+
         y/P1RW80O7TEKV3JiIKhJARz0/zo9jpvqqLLpZYgkZLgSJa/06j1FzH9UeeK3xc7Pswl
         Eh/IhR479qybNj+XOFRnvPG3NNAmL4qzzf17snFadf3HOW/R/WT3j9TEewgV1q+wfhoL
         p2P4FsIzSadZYxf+N2siCtuHUrGuz5eytfK5u+HsrPmP00J4HozeDUJEjCfqmJ4Noyty
         VDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKv0KbvquLk1G5jf7y3Wr5yEuuQAC1dm1dlaqoKqhpU=;
        b=VGFG1YT+CHe59PKgXp5ZPjtPNLPepsKxTi+qfIjtgygD5q99xQFn7uvQnPzSFewkCk
         jAxe9i4/ccSQTyrHXe3xQdbE6xUtFvBpllNcOtHafrpu0rHIIIcbr4lAqnMKxra6f215
         9HBhg+jnM3v3+Dx+a7GmLhiufXkKhFtYsSdwIvqT5mO32nYrhIkgOffoFyC6UCg2bYId
         97SX59IBtsB9r6vfge9BBhgnbkvv7IZOCp+S9SMTBY370KUc9GnC5v8JGzuqyRP+JDdI
         VjLbaCyjAaqV2WBFrZKg2ZxuUx5cIOECpRo2SoY8IESh3kDFxIaQz/F+YT+Q/ZXRnPkq
         9uRQ==
X-Gm-Message-State: APjAAAXTFyirhq7yrLiR2ljyQcd7NnrqzPvU/0Aq6c8WZXOq/xel/xXX
        PFJVqd4WGt+Qq0dCIWz+A0KqmBvezQcmev/sjZeF4w==
X-Google-Smtp-Source: APXvYqyTg9wECAgAGDbOwFKeUGz851YRgl25bdqFqowboJmGeKyeB3EoaaLPi4TVMdX0rnbP5fTBTkxsWvTMLLzP4AI=
X-Received: by 2002:a24:5493:: with SMTP id t141mr111086ita.10.1553614806264;
 Tue, 26 Mar 2019 08:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553546216.git.jonathantanmy@google.com>
 <c4d2f409e246cce02ebfdb8c7110e3700d066ec8.1553546216.git.jonathantanmy@google.com>
 <20190326052011.GB1933@sigill.intra.peff.net> <CACsJy8BHBR2OAHjr-LO4HEmwrmga++5RS1K76qKnh36Hsw9Chw@mail.gmail.com>
 <20190326151825.GA26167@sigill.intra.peff.net>
In-Reply-To: <20190326151825.GA26167@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Mar 2019 22:39:39 +0700
Message-ID: <CACsJy8A5F5Cj02ViO31oFHzOPrdUr+=Gp1q1BEXz7kHDkZTz3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch-pack: respect --no-update-shallow in v2
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 10:18 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Mar 26, 2019 at 05:14:11PM +0700, Duy Nguyen wrote:
>
> > > That seems like the best we can do without the protocol change. And even
> > > if we adjust the protocol, we need some fallback behavior for existing
> > > v2 servers, so this is worth doing.
> >
> > Are people actually doing this (i.e. cloning from or  pushing to a
> > shallow repo)? I added this with the intention that a big shallow repo
> > (e.g. one year long history) is served as the common source to reduce
> > server loads and everything, while the full/big repo is available but
> > rarely needed. I never saw anyone complain about it (so, likely not
> > using it).
>
> I don't think I've ever seen anybody serve fetches out of a shallow
> clone in practice (I don't think we ever seriously considered them at
> GitHub, but given their general incompatibility with reachability
> bitmaps, I suspect it would cause more performance problems than it
> solves).

Yeah. I still think it scales better long term because you can control
this history depth in the common case instead of trying to make git
work well with 30+ years worth of commits. I might try to make
reachability bitmaps and commit-graph work with shallow clones one
day, but that's pretty much in the "hey this is fun, are you bored?"
category.

> I've always imagined people do it for one-offs. E.g., they have a
> shallow clone, and fetch out of that to a temporary copy. That may be
> less useful these days with the advent of separate worktrees.
-- 
Duy
