Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480291F42D
	for <e@80x24.org>; Fri, 25 May 2018 14:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936199AbeEYOmu (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 10:42:50 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40846 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936192AbeEYOmt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 10:42:49 -0400
Received: by mail-ot0-f194.google.com with SMTP id n1-v6so6311965otf.7
        for <git@vger.kernel.org>; Fri, 25 May 2018 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H32AWh8VD2aN7JAxBbbBxpEBY8ZQOMMZZDoOhMPMRZI=;
        b=Q/OZMgbP6ZTregiu+xH7dlmjnTMitwNAicEXLpUM4ay/nZ+CvRhNZ26UHFhjn90HRo
         XAAAYYeQ1LjQVVfMeDYeAlb0vWaHBVyqFk9QXkVUcWs82eQvma1rd4nG3+m8wZTFLLA4
         Fp8aRHgcO6PgDg/a7y5il7lXOCeJBVnRyPxK+dXkcAUFC0vOxePj61kg4j+b+ogknCYk
         sq9CvtsM7UrkNkR7SY7bcDYPOacRzkgndnG3DM/D/Junb7o8kuFj1AFDCI6BpObVuwbT
         r0cXWqjb8Pb+6TFQLhYxsvJ3sbtKE4KTbLegwynPLFnDx/jSsuSsgQwA+h0g7YFtwFkO
         3kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H32AWh8VD2aN7JAxBbbBxpEBY8ZQOMMZZDoOhMPMRZI=;
        b=r5ZZskaf9mky/Y0uLkfb4o2aZneYCg4ETsQE0ZT+7jUF/ynxwdzOwuHcaKfOdNhPZa
         ZSokVrPeoUTH0McX2YmJK6Lq+WfwZIOU7KNit+b8qCjaQ748u63pqDQ+dQKxWTBXNl71
         vKfwYOI3HXOjgql+YsjOsM6iAP6uxH7pnZ3Qo19q3so8LL3kZoNiTnFfbANhdZSVhnNp
         cGZXZEDlbz71g+UgcvCHKCMm7JoCfg7odUQ0F0vNiraExg4Kb35Odf4Mxq/gELrv6hAF
         TDLmutrXgY2QejAQlyHcSOIQXPpfjHdFa65Iic9uv+aFN2/fr1qN6fF3DpUPLMNz0ByJ
         QD9w==
X-Gm-Message-State: ALKqPweLi7TiEWtHMRBUi7NgU2kXOwTp7vd+6PHTuKoKo9heF1zZV0+g
        XZ6giL/JXunpagzuRHbHDo1I2nbsGGwvbn9h9MnIdg==
X-Google-Smtp-Source: ADUXVKLQA0QTgyEOTGfkW+KRsdh5rhVfZNyrE98NCFCSB+LIcCmwdXoWiwCQGZiYpCXoJ8aJ4xCk/JyEcek3XlN52iE=
X-Received: by 2002:a9d:49ad:: with SMTP id g45-v6mr1855959otf.65.1527259369314;
 Fri, 25 May 2018 07:42:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 25 May 2018 07:42:18
 -0700 (PDT)
In-Reply-To: <xmqqpo1knog0.fsf@gitster-ct.c.googlers.com>
References: <CAPig+cR59-OEDL7GDNZF2v7a-NOrUH2zC9EwDvuog8QLRtvKTA@mail.gmail.com>
 <20180524194704.936-1-avarab@gmail.com> <xmqqpo1knog0.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 25 May 2018 16:42:18 +0200
Message-ID: <CACsJy8BjdiNF623vygUkp_1T82X5DwQiCQP9T55mATzFHuH1RQ@mail.gmail.com>
Subject: Re: [PATCH v3] checkout & worktree: introduce checkout.implicitRemote
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 10:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +Currently this is used by linkgit:git-checkout[1] when 'git checkout
>> +<something>' will checkout the '<something>' branch on another remote,
>> +and by linkgit:git-worktree[1] when 'git worktree add' refers to a
>> +remote branch. This setting might be used for other checkout-like
>> +commands or functionality in the future.
>
> Hmph, that is an interesting direction.  You foresee that you'll
> have a single repository with multiple remotes to grab and share
> objects from different people working on the same project, and use
> multiple worktrees to work on different branches, yet you are happy
> to declare that each worktree is to work with one particular remote?
>
> We'd need a per-worktree config file to make it work, I guess, or
> a three-level checkout.$worktree_id.defaultRemote configuration
> variable, perhaps?

I still plan to revisit per-worktree config support [1] at some point
and finish it off. Or is it decided that we don't need a generic
mechanism and will add a new level like this for each config var that
is per-worktree? If defaultRemote sets a precedence, then it'll be the
way to go from now on or we'll have another mess when some config does
"foo.$worktree.bar" while others use per-worktree config files.

[1] https://public-inbox.org/git/20170110112524.12870-1-pclouds@gmail.com/
-- 
Duy
