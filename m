Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B44020248
	for <e@80x24.org>; Mon, 18 Mar 2019 12:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCRMwC (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 08:52:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50590 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCRMwB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 08:52:01 -0400
Received: by mail-it1-f195.google.com with SMTP id m137so4658828ita.0
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 05:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mnNNSKDD7wXEP2N/8mJzmGqnH7vlcamELc0CNmcicso=;
        b=sUjmqifuL7IjOIpOVT2UD7neUTcpT5OGOj4xkdN1uBJRQz/BM4uD7xFCcjA+0mKtgy
         YPUIlXZO6eJCwTR7xXptXnIVyvJ6qSfM0amv0U0BJKwtMGqRBDNO/mY+hE6CRq7mEoon
         z4+IARBnfCHyXTIQsQvpMTSmRskYOXMl5UrIRCM5jh9Nw/9rw/TJNKrwU25OKBzuU5fv
         P9sGwYGdjyT7HFqXcUqrqM2CmCWxph92uARAJGkqu2yonWrUdfOZzVakACy2vVEUXwyt
         b8C+vST8VJLQjuj/0KJu+ZepIvuk3rm8AwTqtCYrPJm0DvszbLnURI9oxjh8oAeThgzv
         iIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnNNSKDD7wXEP2N/8mJzmGqnH7vlcamELc0CNmcicso=;
        b=FN1Tk2zZI28RVBzGoSD+1aIxCy9IRUpE6FYHBfO8BPv+3CDRT5bo5ZizTS7FlClz9y
         NSomDYk6aYrqKLSkWzilxDXkzqvMhxHU5lUHAV9NSUJBwht/qvBlo0pjxZpMxktoozeZ
         3hCYiJJZVwCY8lnIZX2GWYFkXWQmCPiGU83WBI8r0dE10rk6KxdahiKb1gidrPhxyv54
         ZvL8H6UnGxDnThe7RNSjVce01fA4F3USZU+5a/kuaaMKcSmlBiulDELuGNZqnbIeY98O
         9W04CypwWi9ek5c2skRh9PRpq+JVAqYShPg3xezAOLmLBF0gQRAmKeUmn46BUtdmt3dp
         rFSQ==
X-Gm-Message-State: APjAAAVE8bwpJ4BzKZDB49xG1NQM3IzNZBO89qXVf68UDkrS5syNIkqb
        DQUBO094cozVcYS5Rc2jpgQTMBn1KXPx0g6TEI8=
X-Google-Smtp-Source: APXvYqwCAR4C30UZBX7q9HEHlS5VD/Et32lEdyu6rcHDtfAzX70ebiydjA2rxPJaae13BF0ekKtR/ScxjfaAtBM7Cbc=
X-Received: by 2002:a24:7542:: with SMTP id y63mr10409849itc.70.1552913520793;
 Mon, 18 Mar 2019 05:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 18 Mar 2019 19:51:34 +0700
Message-ID: <CACsJy8DtoMMSu5Vm4+ZkeUqCOo7stM4HObLkiSc-nQQV4G=GvA@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 4:17 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi everyone,
>
> There are now ideas, micro-projects and organization application pages
> for GSoC 2019 on https://git.github.io/
>
> It would be nice to have a few more project ideas.
> https://git.github.io/SoC-2019-Ideas/ currently lists only 2 possible
> projects:
>
> - Unify ref-filter formats with other --pretty formats (which is new)
> - git log --oneline improvements
>
> as I didn't feel that the others were still relevant, though I might be wrong.
>
> As Olga and Thomas told me at the Git Merge that they could be ok to
> co-mentor with me, they are listed as possible mentors for both of
> these projects.
>
> Anyway feel free to comment and suggest improvements on those pages,
> especially the micro-projects and ideas one. Pull requests on
> https://github.com/git/git.github.io/ are very much appreciated.

I'm not opening a pull request because I'm not sure if it's worthy of
GSoC (probably 2020, not 2019) but anyway the get_config_* discussion
elsewhere reminds me of this.

Currently we have two ways of parsing config files, by a callback that
gives you everything and you do whatever you want, and with configset
where you can just call "get me this config", "get me that one". The
idea is moving most callback-based sites to get_config_ one.
Preferably in a declarative style, like 'struct option[]'.

This should reduce some amount of code because all the "if (!strcmp..)
var = git_confg..." is handled by a common code. It's easier to read
too. And it may open up an opportunity to suggest misspelled config
name (a bit far fetched) and list relevant configs of any command,
perhaps with a short description of each config variable too. The
configset way should be a bit faster too, but I don't think we care
about performance at all here.

To handle three-level config like remote.*.url, we can still do it the
declarative way by declaring the pattern "remote.*" instead of a fixed
variable name which we can't know in advance. There will still be a
callback to handle remote.* vars correctly, but the callback should be
much smaller and easier to manage, I hope.
-- 
Duy
