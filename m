Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A6120288
	for <e@80x24.org>; Wed, 19 Jul 2017 17:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755914AbdGSRnX (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 13:43:23 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34950 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755911AbdGSRnW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 13:43:22 -0400
Received: by mail-pf0-f179.google.com with SMTP id e199so2673954pfh.2
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 10:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QpXvawQbEHuYHVrOdF+tqGKmFcStiOVGk8mS/dQYjQo=;
        b=IQeWJx9/mA1xmGWmLuzpZVzW719hDnCZSV/RhvYrjbdAeu18qf+TS5fW+liqpg0Fte
         D3rdmU+TdldTabz47xZmgPrhHu9ytJe5Lmg+nz9/MdV1wBjmDHSKeYBYWhih9v1fN6Js
         bN6zSWuCX+uphkZOc36+IHtWuox1gBsOtPE+cevmMshU1Bifk9Y0bWQ1YNTQX+/TR/We
         yA/R+ALtMZRcp6go2IfVRcNEAH7x+97zsMgJjE8m+C5o4pfD+sb3zdFxuR0hTgcYrw5k
         gVgmCYD45Nytq81ZnoO6SNgeLeImgOBncdh/gdlRnZLCbyeGvSHDRy+pvDcJN2+crqH6
         afUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QpXvawQbEHuYHVrOdF+tqGKmFcStiOVGk8mS/dQYjQo=;
        b=B6d3LMEQ/2L+TwEZg+SKFTH+PMkYVYqIpBbpiExMW2Cvh9R9Kb6NRmcf5EDbpPAkAg
         9F2P5TVCd5HGBC34nJUocbUbdnd1wpHTZ1JGYNwTgF9yC+g043Nx1kBKzoPR9rNEgMYu
         dWvx+EGA6GidWEWDQZgNekhv7xCx5LxWL0QChS5wIbhQoirZO8BIU2FV9PSqPtgMfoyX
         lovRCJ/YYtW2f4EQUta5bdiHcFiERZdwwK7CudihUXhbmYbWgi1lt43RmUZijWGLmvox
         zObUicT6BJk86xNlSPvmfZtypjzr2tERskwDp6tA85C24MpovdVOnLNIzZ9HsToI7AyE
         0IZg==
X-Gm-Message-State: AIVw112UAycNPTJRbLtXWBSJ3bZ/7ycs3X04eMt1JYxyGuKRy5QXIHA9
        F+TWE2Vp/sz79qDKJsE8QwrYv2bBIZPH
X-Received: by 10.99.134.72 with SMTP id x69mr898594pgd.210.1500486201655;
 Wed, 19 Jul 2017 10:43:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Wed, 19 Jul 2017 10:43:20 -0700 (PDT)
In-Reply-To: <CAHd499BovefnyWjauE0vNaofmvL8JBZCSzJ7w-cJ8Sm3eoJ4=w@mail.gmail.com>
References: <CAHd499BovefnyWjauE0vNaofmvL8JBZCSzJ7w-cJ8Sm3eoJ4=w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Jul 2017 10:43:20 -0700
Message-ID: <CAGZ79kas6jm8+1BhhHqOe4PzFObLVEASXEQfV0H9j=4oLvz7Lw@mail.gmail.com>
Subject: Re: subrepo vs submodule
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 19, 2017 at 7:27 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> So I found out about "subrepo" today: https://github.com/ingydotnet/git-subrepo
>
> I'm still reading about how it works internally, but what do you guys
> think about it?

Nice find!

From reading the toplevel ReadMe.pod, I have the impression
that it is closer to subtree than submodules as the content is
stored in the main repository using a .gitrepo file to indicate that
it is a special directory.

> Is it a more or less perfect alternative to submodules?

Maybe to subtrees. It does not offer the workflows that
submodules allow you:
  " Users get your repo and all your subrepos just
  by cloning your repo."

Submodules allow you to *not* get the content of a submodule.
There are multiple reasons for not wanting the content, including
* not needing it (e.g. documentation, hardware specific code
  for an architecture you don't have)
* not wanting it (e.g. large binary files yield bandwidth concerns)

"Upstream history (clone/pull) is condensed into a single commit."

Same for submodules, not so(?) for subtrees.

Depending on the point of view this is either a feature or a bug.
For clean history you may view this as a feature, but as soon as
you want to git-bisect, you'd wish for the most fine grained history
available.

> What would be a reason not to use it?

There are multiple things that should drive a decision. some:
* What do you need in terms of workflow (even just talking about
  "submodule vs subtree" you get different answers for different
  workflows), and then seeing how subrepo compares to the others.
* Can you use it? (does it work on your platform? subrepo is bash,
  whereas submodule, subtree are posix shell; how is it distributed?
  Some people are uneasy installing from random github repos on
  the web, so do you install it via the package manager of your
  distribution, has your organisation a package to use?)
* Ease of use, do you need to explain the workflow
  to collaborateurs?
