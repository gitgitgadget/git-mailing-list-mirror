Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEEF91F404
	for <e@80x24.org>; Sat, 31 Mar 2018 19:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeCaThu (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 15:37:50 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:41654 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbeCaTht (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 15:37:49 -0400
Received: by mail-io0-f169.google.com with SMTP id m83so14161036ioi.8
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gRTbfRTwIjZZ5CSg3KitiDJmEcG6w39QmJn0I6fvPgg=;
        b=LuE4m7oMoJXkwJap+s6LIgyGt6rhF6ZM3avXl+qOTcLLzXi2x9VbvGvbKRMjrLGmgJ
         PscIj+A5nHhiXkXoPpxc8InSKmRmQrxTLpLZrWQGUyg9bxSaUjDMgFfeTKN3Czj1s93M
         x7rgH4dabX+MQz7ZXWiiuCb6A3IcafGQe8CnIUPALH0Mk8UOjgBOvWiQPRyoCx9FR9OK
         eVGWC1I5DJArK/Fhff8K3Z7Yx4oxaxIhUvRtXRUp6qzMZgYGHmMn3rsH/01P514DlsQr
         dSfsXlJkVmldp1ERBp/xOIARRgP3wHUhSZPWuvpn7aTD6nYUPqdg4DIm61ttzsS6cqXY
         XA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gRTbfRTwIjZZ5CSg3KitiDJmEcG6w39QmJn0I6fvPgg=;
        b=QT/a0kq4MMJGUVLYIeMIFkOzeOp12oOUNb8bdqT86lr6wYX54DuvEXySU8XNcrYEyH
         r/OqgaCpvAjQttWG0XcSHO+bObpucOr7UFec03Lc4PGJz1OCXRTGU0f/98MLoAjCv5Zq
         DGX7GzaGgCj2TOlsZ/lGMgpJdEOVWOf0FUJ8fQJ63gHKIPL4IzRZHpF4GMPO0XuVa7fF
         cyOzF9Kh5ydtAHrs5JPLNZy7gWBdH9Rlwi0OqkmscGYyvMDlR6jFWLKC5kKkNc8FCwsh
         QM+Xuxt0FKRQCMBYDG3cmsi6NAo/sPn9A43OKAgaHYJMo/Wyxujkzu0+ege2qr65EW7l
         Bt/A==
X-Gm-Message-State: ALQs6tAyBj9/CGkeh+PRZwSKjRnqwK3pVXAHpz4cPQwD7NfMhDkSqSaQ
        OrANkk+CuiIllJw8Ljhg4PJNFS3usnFgnESLxM8=
X-Google-Smtp-Source: AIpwx480u8cgaH+56WgAuavyWq14Hd+N16DEmWdpevd3BCYwuA9FbEbErcklwuLWSPAC9f8x3e73Chl8mlk6uWB3l6E=
X-Received: by 10.107.142.203 with SMTP id q194mr3278126iod.255.1522525069020;
 Sat, 31 Mar 2018 12:37:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.90.18 with HTTP; Sat, 31 Mar 2018 12:37:28 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1803311453250.21368@localhost.localdomain>
References: <alpine.LFD.2.21.1803311453250.21368@localhost.localdomain>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 31 Mar 2018 21:37:28 +0200
Message-ID: <CACBZZX7wQChuEQeBHQzgg-XsMmmryB4qBXT9K4HxwxaSNe4UWg@mail.gmail.com>
Subject: Re: [OT] how does "git review --setup" figure out my username?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 9:04 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   (technically not a git question, but i kind of need to know the
> answer to this quickly as i'm writing some documentation and this is
> something i have to explain.)
>
>   i cloned a repository (hyperledger fabric) which has a top-level
> .gitreview file:
>
>   [gerrit]
>   host=gerrit.hyperledger.org
>   port=29418
>   project=fabric
>
> and, as i read it, if i want to configure to use gerrit, an initial
> invocation of "git review --setup" should do that for me, which it
> appears to do, as it adds the following to .git/config:
>
>   [remote "gerrit"]
>         url = ssh://rpjday@gerrit.hyperledger.org:29418/fabric
>         fetch = +refs/heads/*:refs/remotes/gerrit/*
>
> and copies over the commit-msg hook. so far, so good.
>
>   but from where does it figure out the username (rpjday) to use when
> configuring that remote? i have no gerrit configuration in my
> .gitconfig file. however, i have configured gerrit at the hyperledger
> end to use my SSH key, which is associated with my linux foundation ID
> (rpjday) that i registered to start using that repo.
>
>   is that where it gets the username from?

I've never used gerrit, but from my skimming of
https://www.mediawiki.org/wiki/Gerrit/git-review#Setting_up_git-review
and https://www.mediawiki.org/wiki/Gerrit/Tutorial#Configuring_git-review
it seems (to me) to say that it simply tries if your local loginname
works on the remote. Is rpjday your loginname on this system?
