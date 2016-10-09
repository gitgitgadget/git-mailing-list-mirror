Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A40F20986
	for <e@80x24.org>; Sun,  9 Oct 2016 11:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbcJILMD (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 07:12:03 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35455 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbcJILMC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 07:12:02 -0400
Received: by mail-it0-f44.google.com with SMTP id o21so50310449itb.0
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qsnrpBKrQWIglc4dt7r5IGJIsc/OtzXzc/YuVE0W+Uk=;
        b=AYfrx9PrcCY0p431nXDFqaRrA/J+ciOkDFNvuFjp9aeOd9UEyj3lFsrl9huzURu5/O
         kEylAtRtGX7tCNDbQ7n6Xc49LoD6npIgsjModLKgIU3sSN3Iv71XN7eCuUJOIkI0KWh/
         3GLf8Lh/2g2DIXBDukOxTlkMC5r8DkGbP4c5oeT6SMvMYSiCLpDd2w4uVXBgV6fRtiXp
         CIlneukDLsx1KAYbQXVOd5Un7nbIcKInfw7euhM2M08uCA0cHGByFvXbXQOISS/Y5kVO
         uuLEEogiv9ET+ve/SB0zcClNmgKXKLz2D4qLgHOWBkwmKrUYRN3XRyjpejWYNcWEtNHm
         3WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qsnrpBKrQWIglc4dt7r5IGJIsc/OtzXzc/YuVE0W+Uk=;
        b=eo7OQp1DtaqGrK/uRfv4sCx2ylbEl4u1QJ4DPDXzQQs7ruCih1umbp/FQDgxg+o2tD
         YgI5tgj1ZIOsfHlfGsLXjWpV7UAPExjeRgpgjjGX0np6UXJTyVrdNXvbskeZrHyFkS7y
         vWfPtuFt3s0erWqiV87AFT/kXWfpWACnq1iXPrfR66GG+OZMaUduQysFkJFuBHbISIRd
         A9F4ld9lrvjvAoSCOEYLtncOOi0bCCSZSPyaGtvip060QecceU4bCaWkLKXBL7CxOzal
         hHYkxXtSXsHF1Dhf2FSakaW1q5ohgQWZ6vVOYKaYnEKNEdHMh7w5lwNY20JR6ZfHkVAY
         lfXw==
X-Gm-Message-State: AA6/9RlF76B0qt33k1KZl7dzM9xgFlBiinTW6lk+qzLhPPukGxIItPqa50mcUGEOqcMf6MPReQN/O69jkUuAVA==
X-Received: by 10.36.36.214 with SMTP id f205mr5720342ita.50.1476011521958;
 Sun, 09 Oct 2016 04:12:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Sun, 9 Oct 2016 04:11:31 -0700 (PDT)
In-Reply-To: <CADKxhpe3S4L9CPV9yxh2yhrtJMa9wyZAPC45u_S=RiuzY1Xrkg@mail.gmail.com>
References: <CADKxhpe3S4L9CPV9yxh2yhrtJMa9wyZAPC45u_S=RiuzY1Xrkg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 9 Oct 2016 18:11:31 +0700
Message-ID: <CACsJy8C0kyKor4gCLSJrreRCazazbexvaSdbBg+Cka=-beZU_g@mail.gmail.com>
Subject: Re: Feature request: use relative path in worktree config files
To:     =?UTF-8?Q?St=C3=A9phane_Klein?= <contact@stephane-klein.info>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 8, 2016 at 4:35 PM, St=C3=A9phane Klein
<contact@stephane-klein.info> wrote:
> Hi,
>
> "git worktree add" write absolute path in ".git/gitdir"
>
> The code source is here
> https://git.kernel.org/cgit/git/git.git/tree/builtin/worktree.c?h=3Dv2.10=
.1#n256
>
> Is it possible to use relative path in this config files:
>
> * [main_worktree]/.git/worktrees/[worktree_foobar]/gitdir

The problem with relative is the question "relative to where" and the
answer has to be the same when asked from any worktree. For this file,
it may be ok after we find a good anchor point (which I have avoided
because it gives me headache and absolute paths just work).

> * [worktree_foobar]/.git

This is made absolute on purpose. So that if you move worktree_foobar
away manually, it can still point back to
"[main_worktree]/.git/worktrees/[woktree_foobar]". I'm not sure if we
want relative paths here.

> Why:
>
> 1. I configure worktree on my host
> 2. next I use this git working copy in Docker with volume share
> 3. next I've some git error in Docker because config files use absolute p=
ath

I think the common way of dealing with this in docker is put things in
the same path where it actually is outside docker. If you have stuff
at /path/to/foo, then you create the same /path/to/foo inside docker
and bind the data to that path. Does that work?
--=20
Duy
