Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ADA01F404
	for <e@80x24.org>; Tue, 30 Jan 2018 00:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeA3ANt (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 19:13:49 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44847 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeA3ANs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 19:13:48 -0500
Received: by mail-oi0-f65.google.com with SMTP id b3so3556557oib.11
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 16:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Imks9l7xm6As74VntjPzmqpVRnxfYLjo99C1aK1U890=;
        b=s/okx9FiNsvzmaxcrXrgmLnglWLqiqVcMbSBxZJHlJq4CkdS9EDQmslQWcrnMIdrWs
         nzGz2hqK+EAV1W24N81dQGNfC0y0y2Zycu80ZYgiHzCf/Lj9lbupGhIcVbOl0rGUJS55
         MvJphOnu89yZZXpCqfV61oDQ7BM4JOezlYhNrdKu5B2YmV3Wm85I203pHacqC1xgdvfq
         ca0gf6ihgP3LJjzeFg/GO4ld8v718A4XobxrqGid0C0F9sXnR3TL9DkPKWxCNcSXD8NB
         cDApvXKb9KrOe3dfdL5AxnQUd88J0uDuK9Oj0uySLWn/wAljQWo1cDormh3nxG8uoT10
         ZUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Imks9l7xm6As74VntjPzmqpVRnxfYLjo99C1aK1U890=;
        b=sAmaybTY1KpkvjCFijKcjXtznX+PHsppe5cZwylg3aCSK2I9eeSU3K5t9SKmvGHyXC
         ZgL2o70/iLg98pS0YoQpEqCtQrsB3lDBm0KZfNj0s4yZ9FC142jkHQSjIZ59UgbV3B86
         j5hhg2aauD7E+3OcqBME/Z/KyUeOzkrrhigk/N5I6SYDIlShlZwlG3RxVM+PYtts5Jb1
         VL80l6iKZwwTypq72DWDQLzu1M7XGEgwdg7YlbytkYrc6fxHAZF2iJm/1QZYyp17pkIT
         gsAIhkZgCwDp5YqEuDGcziY+dkdb+Ydjd7udz+zYlUrkQpEs8eaxBVlBJNxR/eVeE+Zb
         hjOw==
X-Gm-Message-State: AKwxytezvhW+mlLuLhfqtTBJCVyYY6LtfhyCMkUk3vUuHBHu3JIL4VJX
        7am+IYuXVjTNRuME1h6wgUyjmR2KD9of19It88A=
X-Google-Smtp-Source: AH8x227C13cB7siTkNw7Mi+iuCkym7lshs+GV1qFhgrtU1BG2/yKJ20qcPw/rSaV5AeWuq8e4s+FH4ldZkEXuWKsddk=
X-Received: by 10.202.196.208 with SMTP id u199mr18406987oif.117.1517271227681;
 Mon, 29 Jan 2018 16:13:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Mon, 29 Jan 2018 16:13:16 -0800 (PST)
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 30 Jan 2018 07:13:16 +0700
Message-ID: <CACsJy8Cm8HsopKisiJkwtPyfv-O6Ei3waew6CsKLXzKv7=TriQ@mail.gmail.com>
Subject: Re: [PATCH 00/37] removal of some c++ keywords
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 5:36 AM, Brandon Williams <bmwill@google.com> wrote:
> A while back there was some discussion of getting our codebase into a state
> where we could use a c++ compiler if we wanted to (for various reason like
> leveraging c++ only analysis tools, etc.).  Johannes Sixt had a very large

I would be more convinced if I knew exactly what leverage we could
have here (e.g. what tool, how many problems it caught...).

> patch that achieved this but it wasn't in a state where it could be upstreamed.
> I took that idea and did some removals of c++ keywords (new, template, try,
> this, etc) but broke it up into several (well maybe more than several) patches.
> I don't believe I've captured all of them in this series but this is at least
> moving a step closer to being able to compile using a c++ compiler.

Is it simpler (though hacky) to just  do

#ifdef __cplusplus
#define new not_new
#define try really_try
...

somewhere in git-compat-util.h?

Do we use any C features that are incompatible with C++? (or do we not
need to care?)

> I don't know if this is something the community still wants to move towards,
> but if this is something people are still interested in, and this series is
> wanted, then we can keep doing these sort of conversions in chunks slowly.

You're going to need to setup C++ build job on Travis or something to
catch new C++ keywords from entering the code base as well if you move
this to the end.
-- 
Duy
