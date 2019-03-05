Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4034020248
	for <e@80x24.org>; Tue,  5 Mar 2019 17:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCERgu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 12:36:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33147 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfCERgu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 12:36:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id z7so8359584lji.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6oeoU7w2wcHi65Rk5y5GPk9tF1DWtXa6Uks1hcXppHI=;
        b=Nh4In66iJ2OZS0zliAE5gEZ6Wyw9u32LARhesIPwdQpXcOt+/a5dg0POZtspduqlG6
         3cku5LAJIxoNZKjBmjpATGCcBgrwSlZf4Zsc/9gyeeDT/XSgYajPBIt8byd8tBtSnQIC
         kML6FrQYFEjhwMEKSGHX1HzFH0C2jsR9F5Xiid8cF3Cer/k+Yr4ju8tQo7Vs7Ce5fyHX
         wmQ571puAsJV38fo+4+cYth5GsU21KpK7JvZwTnXCTu5ECvjpWJFvq7lnC+VXMTdbybe
         /hWcWkXmhWDe2zE2w5pgX64pEthQsQcz8hR+Gi4yentsoSfvF0Et5UuDoXb2ARtsrs5Y
         niWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6oeoU7w2wcHi65Rk5y5GPk9tF1DWtXa6Uks1hcXppHI=;
        b=nqFwpMQcMgjkpXhsBtSrdM98+GZS1TVrPLg/fTLkImRMSSkdVEn+xVb/rPfhdb9UQ1
         SP2cnyHg09EmT+29bwqwWCfUo0niMLrqRlwJ70LB0F4Nv/TdIg8GswOh49pznotlvLOm
         Nb2XWAYNCxj2igixva5MB3MJzZKnQN5ML/3Pl7GTbieVf3Q6Q2GB8d9zrlH0mYNx0XKk
         MsUYukdwL44RGX5nWk+RIv1MGp8Ee/VLGu6wkwX6O67JRuK3oVGOeSyVrHaVm+HDnrNH
         EIHYdBwhiuBVaTN/zfHt+yiRvw/E7dPkWoEHlPB1dRoX15NYtOAlgnjmEIIam7+/DfuP
         q+FQ==
X-Gm-Message-State: APjAAAWpxp+d2LtAATv4rQXKInH6cOaYfbYIMBAC4HLORM+gHJrZQaKv
        TcFIFkTuFhhwY6vBlsUfXjNvT1vffm30OjuJQnU=
X-Google-Smtp-Source: APXvYqzWOBK+fOAfk2yyjHUYJxeioAuLOuyqL8HtaDz0nBOBRT1Yb1klXgSWG4hkSj2ZpPV9K4Ce1WdUFbimpzf9gl8=
X-Received: by 2002:a2e:408:: with SMTP id 8mr14532809lje.15.1551807407862;
 Tue, 05 Mar 2019 09:36:47 -0800 (PST)
MIME-Version: 1.0
References: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com> <xmqqa7i9v4mv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7i9v4mv.fsf@gitster-ct.c.googlers.com>
From:   Kenneth Cochran <kenneth.cochran101@gmail.com>
Date:   Tue, 5 Mar 2019 11:36:35 -0600
Message-ID: <CAJ145vW3HPaP2GeSL65q5C1XhYpiE+7=apU1ia=17eNWPfRj_g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add alias option to git branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Phil Sainty <psainty@orcon.net.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 5, 2019 at 7:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Kenneth Cochran <kenneth.cochran101@gmail.com> writes:
>
> > From c1bad54b29ae1c1d8548d248f6ecaa5959e55f7b Mon Sep 17 00:00:00 2001
> > From: Kenneth Cochran <kenneth.cochran101@gmail.com>
> > Date: Mon, 4 Mar 2019 09:40:22 -0600
> > Subject: [RFC PATCH 0/4] Add alias option to git branch
> > Cc: Sahil Dua <sahildua2305@gmail.com>,
> >     Duy Nguyen <pclouds@gmail.com>,
> >     Jeff King <peff@peff.net>
>
> Avoid using these in-body headers.
>
> Reader's MUA won't show this "Subject:", but instead show the same
> "Add alias option to gir branch", among hundreds of mailing list
> messages, making it very tempting to ignore these four messages.
>

Thanks, I'll be sure to fix that in the future.

>
> > I find myself often using git symbolic-ref to get around work requireme=
nts to use branch names that are not very human friendly.
> > There are a few problems with this:
> >       - There=E2=80=99s a lot of text to type
> >       - Mistyping certain parts (heads/refs) will do things other than =
create a branch alias
> >       - It will happily overwrite an existing branch
> >       - Deleting one that is checked out will put HEAD in an invalid st=
ate.
>
> Meh.
>
> All of the above are problems _you_ create by trying to use symbolic
> refs.  If the project wants to use an overlong branch name, using it
> with "git branch" or "git checkout" or whatever would be a much
> better solution.  Command-line completion will complete long branch
> names, and "git branch overly-long-name-of-an-existing-branch" will
> not overwrite an existing branch (without --force).  "git branch -d
> overly-long-name-of-an-existing-branch" would not delete an
> checked-out branch, either.
>

I definitely agree, I had only meant that these were problems with my
current solution of using git symbolic-ref directly - problems that these
patches are meant to fix. I probably should have included more
information about why I use that solution in the first place.

Command line completion definitely helps in some cases, but not all - for
example, let's say I have two branches, feature/PRODUCT-13032 and
feature/PRODUCT-13023. These branches are generally short lived, so
they're not around long enough that the numbers have much meaning to
me - even with tab completion, I need to have the bug tracking software
open alongside the terminal in order to keep them separated. This can be
even more pronounced when working on several branches that are
numbered in sequence.

`git checkout foo` is much easier than `git checkout feature/PRODUCT-13032`=
,
even with tab completion. There's a significant number of stack overflow
questions about this functionality, and for almost all of them,
`git symbolic-ref refs/heads/newname refs/heads/branchname` is the accepted
answer. There's definitely interest in having this ability besides just me.
