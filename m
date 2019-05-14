Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0407F1F461
	for <e@80x24.org>; Tue, 14 May 2019 10:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfENKMa (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 06:12:30 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:45037 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfENKMa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 06:12:30 -0400
Received: by mail-io1-f48.google.com with SMTP id f22so12358830iol.11
        for <git@vger.kernel.org>; Tue, 14 May 2019 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QoIuU7EY/hPt73YvunHw+GunyycX7SOr7eUWqkThfo=;
        b=hvjsMRMi9v+wAkJXNkn20jFBfBMiuP09dmKOlGHyoHFxMfLgGoGwEJt39XLfLA4Uwn
         dKOAYa54p6mMbUbdpYn67S5drS9ODJWnyt1OLeZ0ksu3eL7htLvjYkM31P2vvjLEe1HT
         yAxKgDumXfduO5EQ+6bWPApD0PxCl/mLK7/PcKgz+iCP3xb27+YAsJikQYMBJHWQxEMz
         h9J6VkyuzulffEbR3rmDUfyVJRre5ffiBfAiAfAfAuauR4W2HTTivz4pzXG5BA3DZssu
         ULupIuFtHK7WfrDB8zEBTgI4mrLA6hCTbxOdGkVAzsByJH1pV16evoCYEIqD8Wk5UjV9
         1Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QoIuU7EY/hPt73YvunHw+GunyycX7SOr7eUWqkThfo=;
        b=p96mFOz+XPqFUES/cH5OabSRpSfPruwy98+NDTIE8j0ucDZjK7KE+ZYv55kJmCl+DG
         yopEpkymTGzHbohchbv+bBS/obQJX7/LLpVosE7tUkK6qo9hGLhIXAkJni/3G70EQftN
         QL6CxPImrSYL0N06Y+G3i5yct45xuYRp3HFzRHdx+DRCVZmv01nOIjbrigGiFXV22Zxn
         1ve/W1/w74Ua3pXEmdvazTJlvdLk+YfjShHr1txUotT+PGD5IUvFhLReDxHvKNu6jwJw
         /bEyFlOwjwVTBZZBCAd0fhU+S5VacZnP1b+VFFPbyhTYlcqkqRhKZziywtnnYIjdQrMJ
         E1hw==
X-Gm-Message-State: APjAAAV5fpWwJiuCA1lpaUdfoQ/nomZ2kCP2v53p94doTTu0WTS6Nfwy
        0UYcZdN6Dd3IIMpL4g8PfqgxHY9i1QEUwrGKwTIF7g==
X-Google-Smtp-Source: APXvYqwdhoAEGZRuCgRzVrJD4hXKRgiiDxTbyWpa1TZLjsldtlD3GX5lRtQ4Fy9X1Yf2QPhF7N/nGktF1DmYGot/Gvk=
X-Received: by 2002:a5e:d60f:: with SMTP id w15mr16766826iom.282.1557828749767;
 Tue, 14 May 2019 03:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
In-Reply-To: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 May 2019 17:12:03 +0700
Message-ID: <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com>
Subject: Re: Missing branches after clone
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 4:42 PM Ulrich Windl
<Ulrich.Windl@rz.uni-regensburg.de> wrote:
>
> Hi!
>
> While wondering why some branches are not being displayed by "git branch" in a cloned repository, I was reading the obvious man pages (man git-branch, man git-remote), but still couldn't find the reason or the solution.

Local and remote branches are separate concepts. One big difference is
remote branches will be automatically updated when you get updates
from the remote repository, but local branches are only changed by
you.

So if you have to remote branches origin/master and origin/something.
If we automatically create the local branches 'master' and 'something'
for you, just so you can see it in 'git branch', then at the next 'git
fetch' (or 'git pull'), we're going to have a problem. The local
branches will stay the same old values while origin/master and
origin/something are kept uptodate. By the time you switch to and use
branch 'something'. there may be a surprise for you.

Besides, tracking all remote branches only works well when you have
one remote repository. Once you have another one, things get
complicated

> Then I found https://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branches which handles the subject...
> But still the most common solution there still looks like an ugly hack.
> Thus I suggest to improve the man-pages (unless done already)

Yeah I expected to see at least some definition of remote-tracking
branches (vs local ones) but I didn't see one. Room for improvement.
-- 
Duy
