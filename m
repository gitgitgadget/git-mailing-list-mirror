Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076D31F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 06:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfKNGfh (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 01:35:37 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:44185 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfKNGfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 01:35:36 -0500
Received: by mail-io1-f50.google.com with SMTP id j20so5522255ioo.11
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 22:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3I1L7prSbyiOa/r2BD1LXtLb55TrWOvrQla9jCoD8C4=;
        b=XZTegFC4m67tHzrli9A7yV3dnEMzJ9No3pw39Q7e3YoWl4RSId85GP2/tKzdnDBTgm
         Kd9gxmGAL+vuzOQllwsmANrs5HbXoICVkR6PgXAFBl5Vec9ORyJXv0j5Fb8xEC4TdFEP
         uOHvGjKuOr9Vvq2jl4q8i/H/nSmMS9Qo+nSGlD1cZAgsVfXFbzqFFt+okIE+wu8Z/VQp
         n+HPX/v110gdf82W3D5s+hjaguYri9xtHCMADwG0oqnvq+HnaQRyeMtZfGOFsCUzkCr2
         yTOBNnqOtSeeiugj44RY0eD/q05CNBmCagQErzlaj0PNQe/Mi5Sk4EkqwLItvg/zb47Q
         udqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3I1L7prSbyiOa/r2BD1LXtLb55TrWOvrQla9jCoD8C4=;
        b=gCHPgLdiyHhE7th8JP7/NAAVJH29lnlfwYgZIgaIf8cshPRbC68nUc1pbmb+Z+FVa2
         PAhoxvNUvO1+Lc+A1Oz+vn4XwmQAL8Mow2J+6v64ZUguXkN9MvrAa+p0TDdPZDphujPh
         M8ZQFLgIYwMFdscBgF7PmA0lKQ8MT4ce212KemjQUWZECHWrN4tSig1AD7MDXhC12yTl
         GINep++9adxoooaS4QpqhsWFS08+al8XJYjyGzMlTHA1HW4ky9QJYRSinU8Oy3CDZX6+
         01rRkFqCO3eOB8uiJFoDKqvxhISpvEF2K5KMq+dn8xOZdyMyr5gsDGCgIJBeI/Ea0myj
         49VQ==
X-Gm-Message-State: APjAAAXz8FOvBNaToEbN2yxMpiXvD840IVm6iEDfVeIUsar9BRek/RMk
        Ats69B5XsK01BR7mPq+yi1J+9abjuZSajCvDWc92qA==
X-Google-Smtp-Source: APXvYqxV/cXJb/1Z1bkcG0FKbxUCCl/6srKSMGQVsSYeULMmkpNP1PXwXIHEY6n1GLKIpXSy11f1cBT8sHTyi+6e/rM=
X-Received: by 2002:a6b:8f13:: with SMTP id r19mr5387818iod.19.1573713335827;
 Wed, 13 Nov 2019 22:35:35 -0800 (PST)
MIME-Version: 1.0
References: <xmqqeeyin4kx.fsf@gitster-ct.c.googlers.com> <CAHd-oW6vBm6JnN8aSeryC716+7xzV-LBZujeRgZgF6RbP0LLHg@mail.gmail.com>
In-Reply-To: <CAHd-oW6vBm6JnN8aSeryC716+7xzV-LBZujeRgZgF6RbP0LLHg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 14 Nov 2019 03:35:24 -0300
Message-ID: <CAHd-oW7UPSSExyLtfLMCObWogKrBOctYabrFrOdf9-4Q2PZmMg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2019, #02; Fri, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 8, 2019 at 12:00 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> Hi, Junio
>
> On Fri, Nov 8, 2019 at 5:41 AM Junio C Hamano <gitster@pobox.com> wrote:
> [...]
> >
> > * mt/threaded-grep-in-object-store (2019-10-02) 11 commits
> >  - grep: move driver pre-load out of critical section
> >  - grep: re-enable threads in non-worktree case
> >  - grep: protect packed_git [re-]initialization
> >  - grep: allow submodule functions to run in parallel
> >  - submodule-config: add skip_if_read option to repo_read_gitmodules()
> >  - grep: replace grep_read_mutex by internal obj read lock
> >  - object-store: allow threaded access to object reading
> >  - replace-object: make replace operations thread-safe
> >  - grep: fix racy calls in grep_objects()
> >  - grep: fix race conditions at grep_submodule()
> >  - grep: fix race conditions on userdiff calls
> >
> >  Traditionally, we avoided threaded grep while searching in objects
> >  (as opposed to files in the working tree) as accesses to the object
> >  layer is not thread-safe.  This limitation is getting lifted.
> >
> >  What's the current status of this one?
>
> This was the last round of improvements I had in mind for this topic.
> So for my part, I think this is ready.

In fact, Jonathan Tan recently pointed out an issue[1] in this topic,
regarding the possibility of a race condition with the reading
windows. So I'll work on a new version.

[1]: https://public-inbox.org/git/20191112025418.254880-1-jonathantanmy@google.com/
