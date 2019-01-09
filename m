Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B9C1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 21:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfAIV3F (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 16:29:05 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46243 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfAIV2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 16:28:46 -0500
Received: by mail-ed1-f44.google.com with SMTP id o10so8471779edt.13
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 13:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFPEHmQb4T5MvPC58kiKAD/lY4g/U0WX2CXqWQaAKPw=;
        b=oRJdTCskJQ+NQzMAlT55Nq39oynoTJSLVH7+X8WeOwJxIl4HmCnx9iu/KcpSDhAirk
         UiSWLuBHllanxnKuOPx4Bf02FepEgTrgqmvXlVg2oufAbv4KUoHCFjJ4yr2Ed/jKqa70
         oxshJjhpybnOMIolJ5oW6uAfGmpJ9x22L7XL+RGOK363GNk319AetC07YWCHErH1oln6
         QA1vXyVO4LtuAqSojHC7FP5FX0z4tt04jrtugOid3oNjWGou/DEPJ99IEKg0p26hi6RA
         U61Xb4r93Re/9+u7jG4HmGpTUy24HMMyLThDbMwmglJN0vRd+3slaGtFxY5NpF2PTva0
         V3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFPEHmQb4T5MvPC58kiKAD/lY4g/U0WX2CXqWQaAKPw=;
        b=RNQEPBmz3OcyXMXXASRtw0bHrLI6ZYb+qg1ep+fzUEyRs5zxX7m0KmY+D7HvPre14Z
         +L7MkhJ1246uBm7JuUVuGSDtaLtjYkiB1Xe506koGmfU1Gk78D9pncQQXPZY2St6DqjQ
         s4bz92AVueiUrvcPA87rzduhU8O/tANig46YPkJpZdjFtmZbTYykCrLqlTgIaNSwxBV0
         raldl52HKU2CWxwv70w3nPJ3sqwmQhCie1tk8iK4mpWtFHOQmDclJi90enGDH/kVBwyd
         26K6A/TanwrO1hH0ptwiLL1l8KAvYs5MQkP9/mM583chN9MxiF33N67htfnwyroWbJP2
         3QpA==
X-Gm-Message-State: AJcUukci83fwr/AnDJDpOBDfbgqHbKeBYXtrokG7AHHQxkoqLtbDO2Wr
        utxyR5qoXm+l/2xZLmMZGljnYb8TnOiG7ulUt0OTrZOkyi5TDA==
X-Google-Smtp-Source: ALg8bN6i0ZG9sOFHR4qKFaKb+sE8ylwd6c1sy/uz/EGsIc7EtzBpLOcohsefhd+3uA08r7IzKw2IZtKFsQ+J/+w2qF8=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr7274651edc.76.1547069324555;
 Wed, 09 Jan 2019 13:28:44 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com> <20190108212007.10855-1-jonathantanmy@google.com>
 <xmqqr2dm4yth.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2dm4yth.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 13:28:33 -0800
Message-ID: <CAGZ79kbSxBde16v7J-Px=fYJZ=qdpUVP-W75mdAYt=-rEbR2Tw@mail.gmail.com>
Subject: Re: sb/more-repo-in-api, was Re: What's cooking in git.git (Jan 2019,
 #01; Mon, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 8, 2019 at 1:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> >>  The in-core repository instances are passed through more codepaths.
> >
> > I think this is ready to be considered for merging to next. This series looks
> > good both to Stolee [1] and to me (I replied to a previous version with
> > comments on patch 18 [2] which Stefan has addressed, as can be seen in the
> > inter-diff provided by Junio [3] - I probably should have replied to the latest
> > version stating this too).
>
> Alright, thanks.
>
> While attempting to resolve conflicts with this and Peff's "get rid
> of has_sha1_file()" topic, I found it somewhat disturbing that
> sha1-file.c still was a mixture of functions that do and do not take
> the repository pointer,

I agree that the current state is less than optimal, but that comes
down to the workflow? Most of the later series regarding the repo
refactoring are crafting some minimal set of changes that make
sense to reach one specific goal. It would have been easier if we
could have refactored the whole code base at once.

> but perhaps it's something we need to polish
> over time on top.

Yeah, that is my current take. And best we'd have
more patches as "t/helper/test-repository: celebrate
independence from the_repository" to make sure
we don't have bugs creeping into the code base.

Thanks,
Stefan
