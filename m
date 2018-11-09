Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A341F453
	for <e@80x24.org>; Fri,  9 Nov 2018 04:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeKIOe7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 09:34:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43716 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeKIOe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 09:34:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id g59-v6so361192plb.10
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 20:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oS+OWz4IfNUuUD/nl2MbcAAyeO0cFpD/lQZosWy0R04=;
        b=Sxv9bk+GTEWu7q3rLsZ1+B9Jme00As6u/2cxxMkqiIhJRPJW3z19hcIiY+UC5xz6V3
         j4QzDxHLSxQgHqAu8+JFiA1/EviNzTLLeN4r++NEBNU7jMPyztOm3KXeHIh/tHhLhH6e
         UXha5qVSBerjhtX3KuwZC/HK1U9p1ua8mwI0vK6p780A1CbdtQfNFMr9vLmeO8GYWRb6
         8COyM5T/ycne1Uf5i2K4NBs5T6M10EOKTp9tsryQ/qp8feEkQDArhNmcBVSHcUzqThA7
         CMIVyoD5PzT4svjp/Vw7wdW8XX8IHdrDGiUviC6KPcK5euuhXuRvJ5REeVHFepJdnXWc
         i2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oS+OWz4IfNUuUD/nl2MbcAAyeO0cFpD/lQZosWy0R04=;
        b=JmVDdDArUEfDWzbW7QysmWc0z3/nLvsdE3iBS8YtGwJbpfDXt3slIcotbNojAUAbcV
         h+sei4gb4MlLGAVKly+w6EgkL+aRzvr9WewxoPFpELLRNcTkuEHhzyIea8+czxCYV1Ex
         LPnOr3fIEhFbwwlHZqDEM848fFNhr8U4stxjaGq5QUcki68Pf/+1xv9+jSls7x7dw4L5
         xzLSm2c9o+DMVXGhdzUFuYkMeS9bEjntenRqsp3wIIMuumbLuFqpgwp+X2783K2IAoAv
         /9WKTibAWyb+QOZfmchkG9fLcueOW84t538Aa3rqCw/vj8+aJDrBhIMtbEnF1/RKOE+d
         fISg==
X-Gm-Message-State: AGRZ1gJxu/1rIk3tYUO99lOuSI57Rwzn0UHqaRx8dBvldvct6+3hfMrr
        kDbjPX3a3qOyzh2Us4hqnIUUwka1Re0hVMCV+eo=
X-Google-Smtp-Source: AJdET5eltWKB11NAXebd4IizxYgW8b25f8CeLiXxdRSinLk02qsg4NjH8DeCGzld4N9ZfeFbPtpv9891FoLadnBN+tQ=
X-Received: by 2002:a17:902:7281:: with SMTP id d1-v6mr3626692pll.284.1541739368995;
 Thu, 08 Nov 2018 20:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20181030220817.61691-2-sbeller@google.com> <20181108205255.193402-1-sbeller@google.com>
In-Reply-To: <20181108205255.193402-1-sbeller@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 9 Nov 2018 05:55:53 +0100
Message-ID: <CAN0heSrF7zU=5NGHD9AUcRZgGHoCmrbBwYqJ-6YUM4xg3r+8Rg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: add pending semantic patches
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 8 Nov 2018 at 21:53, Stefan Beller <sbeller@google.com> wrote:
>
> From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>

I haven't followed the original discussion too carefully, so I'll read
this like someone new to the topic probably would.

A nit, perhaps, but I was genuinely confused at first. The subject is
"Makefile: add pending semantic patches", but this patch doesn't add
any. It adds Makefile-support for such patches though, and it defines
the entire concept of pending semantic patches. How about "coccicheck:
introduce 'pending' semantic patches"?

> Add a description and place on how to use coccinelle for large refactorin=
gs
> that happen only once.

A bit confused about "and place". Based on my understanding from reading
the remainder of this patch, maybe:

  Teach `make coccicheck` to avoid patches named "*.pending.cocci" and
  handle them separately in a new `make coccicheck-pending` instead.
  This means that we can separate "critical" patches from "FYI" patches.
  The former target can continue causing Travis to fail its static
  analysis job, while the latter can let us keep an eye on ongoing
  (pending) transitions without them causing too much fallout.

  Document the intended use-cases and processes around these two
  targets.

>  This directory provides examples of Coccinelle (http://coccinelle.lip6.f=
r/)
>  semantic patches that might be useful to developers.
> +
> +There are two types of semantic patches:
> +
> + * Using the semantic transformation to check for bad patterns in the co=
de;
> +   This is what the original target 'make coccicheck' is designed to do =
and

Is it relevant that this was the "original" target? (Genuine question.)

> +   it is expected that any resulting patch indicates a regression.
> +   The patches resulting from 'make coccicheck' are small and infrequent=
,
> +   so once they are found, they can be sent to the mailing list as per u=
sual.
> +
> +   Example for introducing new patterns:
> +   67947c34ae (convert "hashcmp() !=3D 0" to "!hasheq()", 2018-08-28)
> +   b84c783882 (fsck: s/++i > 1/i++/, 2018-10-24)
> +
> +   Example of fixes using this approach:
> +   248f66ed8e (run-command: use strbuf_addstr() for adding a string to
> +               a strbuf, 2018-03-25)
> +   f919ffebed (Use MOVE_ARRAY, 2018-01-22)
> +
> +   These types of semantic patches are usually part of testing, c.f.
> +   0860a7641b (travis-ci: fail if Coccinelle static analysis found somet=
hing
> +               to transform, 2018-07-23)

Very nicely described, nice with the examples to quickly give a feeling
about how/when to use this.

> + * Using semantic transformations in large scale refactorings throughout
> +   the code base.
> +
> +   When applying the semantic patch into a real patch, sending it to the
> +   mailing list in the usual way, such a patch would be expected to have=
 a
> +   lot of textual and semantic conflicts as such large scale refactoring=
s
> +   change function signatures that are used widely in the code base.
> +   A textual conflict would arise if surrounding code near any call of s=
uch
> +   function changes. A semantic conflict arises when other patch series =
in
> +   flight introduce calls to such functions.

OK, I'm with you.

> +   So to aid these large scale refactorings, semantic patches can be use=
d,
> +   using the process as follows:
> +
> +   1) Figure out what kind of large scale refactoring we need
> +      -> This is usually done by another unrelated series.

"This"? The figuring out, or the refactoring? Also, "unrelated"?

> +   2) Create the sematic patch needed for the large scale refactoring

s/sematic/semantic/

> +      and store it in contrib/coccinelle/*.pending.cocci
> +      -> The suffix containing 'pending' is important to differentiate
> +      this case from the other use case of checking for bad patterns.

Good.

> +   3) Apply the semantic patch only partially, where needed for the patc=
h series
> +      that motivates the large scale refactoring and then build that ser=
ies
> +      on top of it.
> +      By applying the semantic patch only partially where needed, the se=
ries
> +      is less likely to conflict with other series in flight.
> +      To make it possible to apply the semantic patch partially, there n=
eeds
> +      to be mechanism for backwards compatibility to keep those places w=
orking
> +      where the semantic patch is not applied. This can be done via a
> +      wrapper function that has the exact name and signature as the func=
tion
> +      to be changed.
> +
> +   4) Send the series as usual, including only the needed parts of the
> +      large scale refactoring

Trailing period.

OK, I think I get it, but I wonder if this might not work equally well
or better under certain circumstances:

  - introduce new API
  - add pending semantic patch
  - convert quiet areas to use the new API

On the other hand, listing all possible flows might be needlessly
limiting. I guess it boils down to this:

"Create a pending semantic patch. Make sure the old way of doing things
still works. Apply the semantic patch to the quieter areas of the
codebase. If in doubt, convert fewer places in the original series --
remaining spots can always be converted at a later time."

Martin
