Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C841F42D
	for <e@80x24.org>; Wed, 16 May 2018 09:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeEPJvk (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 05:51:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42696 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeEPJvj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 05:51:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id u6-v6so90059pls.9
        for <git@vger.kernel.org>; Wed, 16 May 2018 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+57gO0Qbh7ZbO1ELE8xH0VcFj9rCnQ0Y+5+h8QUPJ2w=;
        b=jJ1MH/TOMrDNup1MYQLrewNfkr0Cx0/4kuv/cj8iDkY7VQsk3em2+J5EItaMKjm4Z5
         LRQSXhl3BofW6RZOFPr9FWyxpQvoTyhmg6xML24VsSjGwSvOxI4lez4jEtyzd9Jsn5j9
         a20vberUkYlPnNekMbGtAwj76Y6bAcIjBELB231s8Cx4ZHtjdnyO8IuLYNPH4cEbHJP7
         NtVBNK0/aCow2MEh8IaLy5NUWFdo2BqmViA/wJsNdQ9bm+F+5F6bbqWizuMsk0qfIN+7
         4Pvff+UjiG/773EmDTGLaA5TlvOLPMJq+STVEQY2FEqi2/2PW+K36bflYCQfgeEO0FSc
         SHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+57gO0Qbh7ZbO1ELE8xH0VcFj9rCnQ0Y+5+h8QUPJ2w=;
        b=npVsWM4R/ix4ypgqm/WVP4ZnhQauOC/5nwOg5onpySFvrtg9VRLhnReEuremxzR4sO
         +6hkdcQyEgXRQprWDXZczoUBbDLnqKjUfTcD4Bjjcm6fnYenFnqUabFL1fFb6ieiUojU
         4/7itzMTGg9OLaAedsnr6fs/6seI7TS32a/B994VyQ3t43HbnjOg3ubgHMD+ICq9BYsj
         V5fc1CQl8PFRcBHTyaBZBvGptpiiHuqUydh58s3zkZW6IRSv2IjqlKizN3d3N+B4Xadf
         /M4dSQ6a6smEQgDM8McX143vza9cb2/QJDHuUDMF41agm6mkySKACAVHlDr0ZECabcDC
         rQXQ==
X-Gm-Message-State: ALKqPwegN/hZMhnkP5BzTgeZkurDppIgdyv0FKBNLR+WIqfqOQTap9Ke
        Vf8yJAELleljz0WSpg4jfKKzqdQ+
X-Google-Smtp-Source: AB8JxZovU4sEJ7AeDwPQU0dMGIFn9XX4gg9y/EfkM12qrDjasu19X9lMdtHyXO8TxhNWlxWNBOwCEQ==
X-Received: by 2002:a17:902:7488:: with SMTP id h8-v6mr216463pll.124.1526464298463;
        Wed, 16 May 2018 02:51:38 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id h1-v6sm3718527pfg.135.2018.05.16.02.51.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 May 2018 02:51:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: worktrees vs. alternates
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <87po1waqyc.fsf@evledraar.gmail.com>
Date:   Wed, 16 May 2018 11:51:26 +0200
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com> <87po1waqyc.fsf@evledraar.gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 May 2018, at 11:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
>=20
> On Wed, May 16 2018, Lars Schneider wrote:
>=20
>> I am looking into different options to cache Git repositories on =
build
>> machines. The two most promising ways seem to be git-worktree [1] and
>> git-alternates [2].
>>=20
>> I wonder if you see an advantage of one over the other?
>>=20
>> My impression is that git-worktree supersedes git-alternates. Would
>> that be a fair statement? If yes, would it makes sense to deprecate
>> alternates for simplification?
>>=20
>> [1] https://git-scm.com/docs/git-worktree
>> [2] =
https://git-scm.com/docs/gitrepository-layout#gitrepository-layout-objects=
infoalternates
>=20
> It's not correct that worktrees supersede alternates, or the other way
> around, they're orthagonal features.
>=20
> git-worktree allows you to create a new working directory connected to
> the same local object store.
>=20
> Alternates allow you to declare in any given local object store, that
> your set of objects isn't complete, and you can find the rest at some
> other location, those object stores may or may not have more than one
> worktree connected to them.

OK. I just wonder in what situation I would work with an incomplete
object store. The only use case I could imagine is that two repos share
a common set of objects (most likely blobs). However, in that situation
I would keep the two independent lines of development in a single repo
with two root commits.

Would it be fair to say that "git alternates" are a good mechanism to=20
cache objects across different repos? However, I would consider a cache=20=

hit  between different repos unlikely. In that line of thinking
"git worktree" would be a good (maybe better?) mechanism to cache =
objects
for a single repo?

Thanks,
Lars=
