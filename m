Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7A6202BB
	for <e@80x24.org>; Thu, 28 Mar 2019 19:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfC1TDO (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 15:03:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33039 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfC1TDO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 15:03:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so18677355ljc.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jNFy7aCeUN0fTCI/MhRUaAXA2UTM73Y/nv+2ciP/nPA=;
        b=l6kzhx0469X7wFEhoBOiVjGMnsYEl2WiifkjFJ8d3otiNCUDrOuCzR46XrEDbM4AMM
         8PidtIX4VpeZrVQwWc/3TuNtMTOOPzgZjgJpmOVPVzx92Rc/zAOqfCtjO+2ynN3L/kjj
         SszDWIsQf1jdwZs3/e8KtCSX2XbuwPkem5neshmoVqrvOwnV674KJMrsIOGqREkpsnWS
         apJuajQ4z0dRGsSTzK7Rkknb6ui3fj1AQW+TBh2ttG8OL1ZypjP19VMCmG+XygEPJeMi
         UaGdeTX1l9GxlUWUjhE/LQu2U1UBQHrJC9Imb3jhISXHjBFwYkXWWn8+rmGiXsYg+YaM
         UFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jNFy7aCeUN0fTCI/MhRUaAXA2UTM73Y/nv+2ciP/nPA=;
        b=Jsd3oUQcapA+Opu0fIq34pLUPn82cpgkJZ4r3xFrhZd9zgTWZ1SREUbH3hJBbN+WfH
         uptLL8BVv3aeamM2IodNqpTU901JuLMIEZd0X5KOOJTk47UvfihT83jSFaGaRpXZBYj+
         bjUmGZO22RODpz18+JO2kMgG1yM+eFrr3H2/xqdySbPPEtzwYgbgeqYItK2MLUEluVae
         sv50FFJoycYTykbvyWwdux9Ou5G2yZsXGdAP0EhTlkBLk76WxoAGyXgUtEX0S+qEzj2s
         53WlW3d0slXzh16Xo8Lbcr9/39f7P9JcJgI+jS3aV66o4hsxvmZXtY/vHObLKz+Mw46p
         kMkw==
X-Gm-Message-State: APjAAAUInsodwAN/I9hMH7uYgu1AIu8VO1yjlswniFXlB0+pxb470LCe
        mCv3nZYbh9hs0zMMif8q/nfWAbxWS+bb2oqhOho=
X-Google-Smtp-Source: APXvYqxRh/BAu2GurZ6TFIQogdFhvBiOfTtvFXiboom5+0Yy6gaNn223cyLd1mDteh46iJKHughlpJ9gnWtYS0balB0=
X-Received: by 2002:a2e:9e47:: with SMTP id g7mr106571ljk.48.1553799791078;
 Thu, 28 Mar 2019 12:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190325233723.GD23728@sigill.intra.peff.net> <cover.1553586707.git.liu.denton@gmail.com>
 <c371a653b4049256f3427e467b144385ee47ef43.1553586707.git.liu.denton@gmail.com>
 <CABPp-BGKWxJVGfQC3imj8Z6RHxQ6zLOGRpkOjyn93a3RxmE0Lw@mail.gmail.com> <875zs4boib.fsf@evledraar.gmail.com>
In-Reply-To: <875zs4boib.fsf@evledraar.gmail.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 28 Mar 2019 14:02:59 -0500
X-Google-Sender-Auth: oSt5eogXRX_M--9ejFSN8ZEgPnY
Message-ID: <CAHd499AJzEL27fNUHa9WXquaOFzXYuPLCpDOx4xvPF_CfRQwLA@mail.gmail.com>
Subject: Re: [PATCH 1/3] tag: prevent recursive tags
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 5:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Mar 27 2019, Elijah Newren wrote:
>
> > On Tue, Mar 26, 2019 at 12:56 AM Denton Liu <liu.denton@gmail.com> wrot=
e:
> >>
> >> Robert Dailey reported confusion on the mailing list about a recursive
> >> tag which was most likely created by mistake. Jeff King noted that thi=
s
> >> isn't a very common case so, most likely, creating a tag-to-a-tag is a
> >> user-error.
> >>
> >> Prevent mistakes by erroring and providing advice on recursive tags,
> >> unless "--allow-recursive-tag" is specified. Fix tests that fail as a
> >> result of this change.
> >
> > Any chance we could use the term "nested tag" instead of "recursive tag=
"?
>
> +1. "Recursive" sounded wrong to me, but I couldn't think of the
> now-obvious alternative.
>
> Some grepping around shows we use "nested submodules" fairly
> consistently, and in gitrevisions(7) we say the peel syntax will
> recursively peel tags (but don't call them nested).
>
> So makes sense to refer to the object type as nested, and when we're
> referring to the operation that'll iterate over that nested structure
> say it'll be done "recursively".

Wow thanks for fixing this, you guys are awesome. I wasn't expecting
anyone to fix this since it seemed kinda niche. You're right that I
created this nested tag unintentionally. And due to `git-lfs migrate`
not handling nested annotated tags, it took days of debugging to
eventually figure out that nothing was working because of 1 farkled
tag.

Just to make sure I understand the change, is a tag pointing to
another tag object now going to be forbidden by default? And to allow
it, you must do `git tag --allow-nested-tag`?

So for example, going forward, if we have this:

$ git tag -m 'Tag 1' 1.0
$ git tag -m 'Tag 2' 2.0

This will fail:

$ git tag -f 2.0 1.0

Unless I do either:

$ git tag --allow-nested-tag -f 2.0 1.0

Or (this is the intended behavior in my case):

$ git tag -f 2.0 1.0^{}
