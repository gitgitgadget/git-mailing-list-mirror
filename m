Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3DCC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17793207C4
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgEOPIx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 15 May 2020 11:08:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36751 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgEOPIw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 11:08:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id k13so1850534wrx.3
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wuUA9pclATwCQd2GHxiP5xHmyJv9Ai2SNWqpxRuQTUE=;
        b=IkqOUQBNFAxJBIlzXL5dajbK0/azdkeSgjilV32wWux1rIdhRPAPLnCGuDnxPtEMfn
         WnqKpU0srBBCkgpn0I7tAQlUsOcj7uQFBL4q2/ZHtxwJvT0QLbhmbsize1o8XgN+DE0E
         VHhbQEaKX6it/Xnj0k+PcrN5Ga1UmPp7Rfkb+pd4YwqK07AnxNkoVxEBTIm1TYyLM+e2
         tZsY0InsYV4zIPFZMAMn/simxRczkZHDEyrFeg/8cTGRM3Foox91c+8mXwwVbTtK6TOg
         65Jls84YjqQ2NbrTXvYj3nCJSACijmI05TNqhTsLkfSewPXC4UR40ACv8tMmkXp2LfYt
         VKiw==
X-Gm-Message-State: AOAM533JydRzMjfNnhEeDLLZUF84Y3SuPsiMWtA1x+0+a53Zt26mBr+C
        PTlxYBTdzz8feDJNsYj5NQqcfm23f5cskjoYw5U=
X-Google-Smtp-Source: ABdhPJyK3BvADrXqHGk7V44pHKWDWLkWvPuvBUYhmb8cBZwwztLHLrKmHshwOqd57FhsZMiFYRUVeC9+/w0UQ36Eq0c=
X-Received: by 2002:adf:f651:: with SMTP id x17mr4964704wrp.277.1589555331157;
 Fri, 15 May 2020 08:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com> <20200515150041.22873-1-carenas@gmail.com>
In-Reply-To: <20200515150041.22873-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 May 2020 11:08:40 -0400
Message-ID: <CAPig+cTG7oPOC2EmrXw6j4J4xyeBOy4UPFoFe7p-k2+5hgaRkQ@mail.gmail.com>
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 11:00 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> 662f9cf154 (tests: when run in Bash, annotate test failures with file
> name/line number, 2020-04-11) adds metadata to the TAP output to help
> identify the location of the failed test, but does it in a way that
> break the TAP format and therefore confuses prove.
>
> Move the metadata to the description to workaround the issue and
> change the regex from 676eb0c1ce (ci: add a problem matcher for GitHub
> Actions, 2020-04-11) to match.
>
> Reported-by: Alban Gruin <alban.gruin@gmail.com>

Missing sign-off.
