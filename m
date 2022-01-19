Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F9BC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 21:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiASVZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 16:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiASVZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 16:25:39 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B8C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 13:25:39 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v123so7830940wme.2
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 13:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gJx5PlvNd1NaXondVNrC9A/qLt5h7DVjhtgU3Bdspyo=;
        b=I+l1/fCdWJyvQGUHgPAX14hMS4llKoODCACHG/huBt0iFgtus/NeEQ7Cis5cdkHndv
         e/ENaIQd9u4PCpjGF23Dt2zMh1oSN7LuKej+9eTY2OLuLWLp3BKmhM+9rQ0e3Sri/OPk
         jskwT3C+RrnK4O5RKgak86uVGxqRkhfz1PPnYQ4Ubf9j+DLbFecqvyLVIANmDdkxRIJr
         tfx1MDYigiZETgKou9rQ7/sn3Zcb4Xl3BihvqgHYdAR1wE4/RAnS+2SBdoPdsMs6zQzR
         TKlk+sqlvwbA3y5KKMiMqYXyXODYlGKURkP9X7jSfIidnSf8pvea3+HTtAGSRR8AuzRq
         Nc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gJx5PlvNd1NaXondVNrC9A/qLt5h7DVjhtgU3Bdspyo=;
        b=z7M9UOnUQWSyC4oqn4TlOilgvLqkyyYrIng706GvcNr5zT6jPi1u4aXiQyLGS0JKls
         9aABl50zwT/IIcfvF/Uo/UuwfeywGHokQT27+p2tPCwIxcqcWUMApRt5X7CN2ZyNzZoM
         GewewNnUgCLSg1LD7cLwj6s9Yo7tdUBvbsdQpqAPq4P7E1t7HbRxXO5KcSYAQaDynczv
         QwtQYCNnb6zMYwiPSjQfBM0alQ9QvBUVOZGwDR1PUTIL6ZR2Q3Qc9dbyYfXfjCNe5hVB
         /TKrGAl77DmbxAkgfnu9136jv219YahTIa1TyoRu9hSPHRMsh3wvcDiSF5lDY4KhWTVx
         S9EA==
X-Gm-Message-State: AOAM5336CWCfYEZ5VfUazhOn5jnN/Q1Hg46w9V2BdE2HvvBWMnQ78IbO
        mq2RkZyfloVeKD7y4LH1VLYFlJZJn2pxU01uGcFbOp8li5m5MQ==
X-Google-Smtp-Source: ABdhPJz9IOlLfJH7kjqayJDVNlmQKAd3zqbW5Rd7d5XQhNdig4LrbD3Fg3fPhlKLIdNWnlKNLNDKk3vNKeOSvenGDmI=
X-Received: by 2002:a7b:c00d:: with SMTP id c13mr5419729wmb.128.1642627537569;
 Wed, 19 Jan 2022 13:25:37 -0800 (PST)
MIME-Version: 1.0
References: <CAB7QKarvGGjNf-bvuKqwnAVT_wX_=J+Dh0-AEdKPdVMbkSzW3Q@mail.gmail.com>
 <xmqqbl07mrp3.fsf@gitster.g>
In-Reply-To: <xmqqbl07mrp3.fsf@gitster.g>
From:   Frederic Tessier <ftessier@gmail.com>
Date:   Wed, 19 Jan 2022 16:25:26 -0500
Message-ID: <CAB7QKapGFZa4b7YKGgQkAnHnOWnC2K+ouN-qQpoAW348gg1K7Q@mail.gmail.com>
Subject: Re: Dangling copyright in git hook template
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thank you for the quick response! My approach on this was that the
line tripped the licence analysis for our organization projects, but
you are entirely right: removing the line does not change anything, as
the copyright notice is optional (I did not know that was true
globally, thanks for pointing that out).

It would be great if the samples were explicitly under MIT licence or
other permissive option. In the short term, perhaps do not copy the
templates by default, or make that a git config option, or else not
copy the templates when running `git clone`?

I realize this is not a big deal, especially since it is unlikely
someone would distribute files in .git by mistake. However, upon
cloning my repo, someone could be under the *impression* that I am
violating copyright since it appears in the repo; alas, my employer
(government) is a stickler when it comes to managing copyright! :-)

At any rate, minor point, but thanks for listening, and for taking the
time to reply. Much appreciated.

Regards,
Fr=C3=A9d=C3=A9ric.

On Wed, 19 Jan 2022 at 14:49, Junio C Hamano <gitster@pobox.com> wrote:
>
> Frederic Tessier <ftessier@gmail.com> writes:
>
> > What did you expect to happen? (Expected behavior)
> > New repo initialized containing no copyright claims
> >
> > What happened instead? (Actual behavior)
> > New repo initialized with a copyright claim in .git/hooks/pre-rebase.sa=
mple:
> > # Copyright (c) 2006, 2008 Junio C Hamano
>
> Because the sample files are copied verbatim, with or without such
> copyright notice message, they are copyrighted by their respective
> copyright holders.  And their modification and distribution should
> follow the same licensing terms (i.e. GPLv2) as our source files.
>
> Removing that single line would not change anything, as these days
> the written copyright notice is optional across the globe.
>
> We could probably stop shipping these .sample hook files, or the
> users can ignore them with the same ease.
>
> I dunno.  An alternative position on the other extreme is to find
> and convince all the copyright holders of template/, relicense these
> files under less restrictive license _and_ state the license clearly
> in each of these files.  I think that ought to be our long term
> direction.
>
> Thanks for bringing this up.
