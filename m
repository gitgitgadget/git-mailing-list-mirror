Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296032035A
	for <e@80x24.org>; Tue, 11 Jul 2017 17:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756094AbdGKRSD (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 13:18:03 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35997 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755585AbdGKRSC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 13:18:02 -0400
Received: by mail-pg0-f50.google.com with SMTP id u62so2794624pgb.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=60vbgIJUZxnTRJ978Z4PXwyPtD2ltMD4mz8A+UdmEzE=;
        b=AKYRUg3DfMshN21O1jTQp+AqlsXtgWHaD8vqCfpM8hOwvgZAhtqzboZgfaEXqhfhAy
         FIwtkQYtZs6YoW+ZS3au+hAWGYUU6XMIWfeO/BhE8BJaal3dz0na82E8tMy7Wh2/nk2g
         +BFtIvrEXPQisFsmLtelfl+VdgEd7Shrn5sl4w5KeweCoDgQ2vWBuPt5DfwRniCgvnrw
         U42AsD8R4wTLeIFB8CxPwTzKj8HRSoWNLfOsB1GXqYD/PsfaaJXkF5+/hFR5AmHOO0Rh
         99Z0LElsIzZnqQfrbwDeblwUmEhR/HslNYN/oRhK3oFlwT73UmgyDhrtTv5Eal1MGeOk
         MfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=60vbgIJUZxnTRJ978Z4PXwyPtD2ltMD4mz8A+UdmEzE=;
        b=J5GfXFhAmWKt0gTQXY9Cc70DEhDP3RkjUsmBSEimNxmGDWPw8GRegCZJAwMJZ9eT+Y
         w+S5SZMaEjMwEqM7Mv55P0duDBTnw+I/d0lGV3jvDIOwU2gPzbstC33qPVeG57hJ02nM
         0AJIF45iGqmzdwlVGtb/1dcH4GkRGwz1+um+ybnhuFjzEFT6nefmjg5P/XM+Uj5zenFO
         /xhfoHX0j5K8l72Iu2H+xrKfs3o4N/SSTIWnCJ8lesD9cE/fpr8aTT4mcxMT25Eins9P
         54S2Os7MQPgSGbaFxsHUh7VZUP36e3glYqmII3hXO7/msEJ4vHL29gvOyKRtHLnapwna
         DvSg==
X-Gm-Message-State: AIVw112Ub83uuMDin5nfYjqHt/+x7Gb/GX9E2A9SaVT6/u550u6XK1fl
        65wExSB7LW+nI35km8Na3t5XzyKzi4OmpbO2Nw==
X-Received: by 10.98.85.131 with SMTP id j125mr28594102pfb.48.1499793481212;
 Tue, 11 Jul 2017 10:18:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Tue, 11 Jul 2017 10:18:00 -0700 (PDT)
In-Reply-To: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 10:18:00 -0700
Message-ID: <CAGZ79kZaf7=uwCPJoPoDiAO9QS21bchaKZvDzWJi=ewPZw9PXQ@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     Nikolay Shustov <nikolay.shustov@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 8:45 AM, Nikolay Shustov
<nikolay.shustov@gmail.com> wrote:
> Hi,
> I have been recently struggling with migrating my development workflow
> from Perforce to Git, all because of the following thing:
>
> I have to work on several features in the same code tree parallel, in
> the same Perforce workspace. The major reason why I cannot work on one
> feature then on another is just because I have to make sure that the
> changes in the related areas of the product play together well.

So in that case the features are not independent, but related to each other?
In that case you want to have these things in the same working tree as
well as in the same branch.

Take a look at git.git itself, for example:

    git clone git://github.com/git/git
    git log --oneline --graph

You will see a lot of "Merge X into master/maint" commits, but then
you may want to dive into each feature by:

    git log --oneline e83e71c5e1

for example and then you'll see lots of commits (that were developed
in the same branch), but that are closely related. However they are
different enough to be in different commits. (different features, as
I understand)

> With Perforce, I can have multiple changelists opened, that group the
> changed files as needed.
>
> With Git I cannot seem to finding the possibility to figure out how to
> achieve the same result. And the problem is that putting change sets
> on different Git branches (or workdirs, or whatever Git offers that
> makes the changes to be NOT in the same source tree) is not a viable
> option from me as I would have to re-build code as I re-integrate the
> changes between the branches (or whatever changes separation Git
> feature is used).

you would merge the branches and then run the tests/integration. Yes that
seems cumbersome.

> Build takes time and resources and considering that I have to do it on
> multiple platforms (I do cross-platform development) it really
> denominates the option of not having multiple changes in the same code
> tree.
>
> Am I ignorant about some Git feature/way of using Git that would help?
> Is it worth considering adding to Git a feature like "group of files"
> that would offer some virtutal grouping of the locally changed files
> in the checked-out branch?

The way of Git is that a commit (snapshot) by definition describes a
set of files (The set of all files in the project). So If you need two features
there at the same time, you probably want it in the same commit.

If they are different enough such that you could have them independently,
but really want to test them together, your testing may need to become
more elaborate (test a merge of all feature branches) I would think.

>
> Thanks in advance,
> - Nikolay
